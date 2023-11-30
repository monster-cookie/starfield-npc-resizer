Scriptname NPCResizer_ResizerScript extends ActiveMagicEffect  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venpi_DebugEnabled Auto Const Mandatory

GlobalVariable Property NPCResizer_Enabled Auto Const Mandatory
GlobalVariable Property NPCResizer_UseEasterEggMode Auto Const Mandatory
GlobalVariable Property NPCResizer_ScalingMin Auto Const Mandatory
GlobalVariable Property NPCResizer_ScalingMax Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Keyword Property NPCResizer_Resized Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;
ObjectReference Property Myself Auto
Actor Property RealMe Auto


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;

Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Debug.DebugMessage("NPCResizer_ResizerScript", "OnEffectStart", "OnEffectStart triggered", 0, Venpi_DebugEnabled.GetValueInt())
  If (akTarget == None)
    Return
  EndIf

  Myself = akTarget
  RealMe = akTarget.GetSelfAsActor()

  ;; Have a race condition which shouldn't be possible but injecting a keyword to prevent reprossessing. 
  If (Myself.HasKeyword(NPCResizer_Resized)) 
    return
  Else
    RealMe.AddKeyword(NPCResizer_Resized)
  EndIf

  If (NPCResizer_Enabled.GetValueInt() == 1)
    HandleHeightScaling()
  Else
    VPI_Debug.DebugMessage("NPCResizer_ResizerScript", "OnEffectStart", "NPC Height Resizing is currently disabled.", 0, Venpi_DebugEnabled.GetValueInt())
  EndIf
EndEvent

Event OnEffectFinish(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Debug.DebugMessage("NPCResizer_ResizerScript", "OnEffectFinish", "OnEffectFinish triggered", 0, Venpi_DebugEnabled.GetValueInt())
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function HandleHeightScaling()
  Float currentScale = RealMe.GetScale()
  Float newScaleMin = NPCResizer_ScalingMin.GetValue()
  Float newScaleMax = NPCResizer_ScalingMax.GetValue()
  Float newScale = currentScale

  If (NPCResizer_UseEasterEggMode.GetValueInt() == 1)
    newScaleMin = newScaleMin/2
    if (newScaleMin < 0.35)
      ;; Below what the engine can handle for targeting so reset to 0.35
      newScaleMin = 0.35
    EndIf

    newScaleMax = newScaleMax*2
    if (newScaleMax > 3.00)
      ;; Above what the engine can handle for targeting so reset to 3.00
      newScaleMax = 3.00
    EndIf

    VPI_Debug.DebugMessage("NPCResizer_ResizerScript", "HandleHeightScaling", "NPC Easter Egg mode is enabled so min sacle is now " + newScaleMin + " and max scale is now " + newScaleMax, 0, Venpi_DebugEnabled.GetValueInt())
  EndIf

  newScale = Utility.RandomFloat(newScaleMin, newScaleMax)
  VPI_Debug.DebugMessage("NPCResizer_ResizerScript", "HandleHeight", Myself + "> NPC is being rescaled to " + newScale + ".", 0, Venpi_DebugEnabled.GetValueInt())
  RealMe.SetScale(newScale)
EndFunction
