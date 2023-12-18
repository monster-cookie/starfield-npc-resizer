ScriptName NPCResizer_ConfigTerminalScript Extends ActiveMagicEffect

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venpi_DebugEnabled Auto Const Mandatory
String Property Venpi_ModName="ResizeTheWorld" Auto Const Mandatory

GlobalVariable Property NPCResizer_Enabled Auto Const Mandatory
GlobalVariable Property NPCResizer_UseEasterEggMode Auto Const Mandatory
GlobalVariable Property NPCResizer_ScalingMin Auto Const Mandatory
GlobalVariable Property NPCResizer_ScalingMax Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Actor Property PlayerRef Auto
Form Property NPCResizer_ConfigTerminal Auto
Message Property NPCResizer_ConfigTerminal_MainMenu Auto
Message Property NPCResizer_ConfigTerminal_ConfigScaleMin Auto
Message Property NPCResizer_ConfigTerminal_ConfigScaleMax Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  If (akTarget == PlayerRef as ObjectReference)
    VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "OnEffectStart", "Regenerating the item and calling process menu.", 0, Venpi_DebugEnabled.GetValueInt())
    PlayerRef.AddItem(NPCResizer_ConfigTerminal, 1, True) ;; Need to replace the item we just consumed to trigger the menu
    Self.ProcessMenu(NPCResizer_ConfigTerminal_MainMenu, -1, True)
  Else
    VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "OnEffectStart", "Inventoy object trigger by someone other then the player??? PlayerRef = " + PlayerRef as ObjectReference + " Target is " + akTarget + ".", 0, Venpi_DebugEnabled.GetValueInt())
  EndIf
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function ProcessMenu(Message message, Int menuButtonClicked, Bool menuActive)
  While (menuActive)
    If (message == NPCResizer_ConfigTerminal_MainMenu)
      menuButtonClicked = NPCResizer_ConfigTerminal_MainMenu.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Close Menu Clicked
        menuActive = False
      ElseIf (menuButtonClicked == 1)
        ;; CLICKED 1: Enable NPC Resizing
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 1 Clicked - Enabling NPC Resize.", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCResizer_ConfigTerminal_MainMenu
        NPCResizer_Enabled.SetValueInt(1)
      ElseIf (menuButtonClicked == 2)
        ;; CLICKED 2: Disable NPC Resizing
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 2 clicked - Disabling NPC Resize.", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCResizer_ConfigTerminal_MainMenu
        NPCResizer_Enabled.SetValueInt(0)
      ElseIf (menuButtonClicked == 3)
        ;; CLICKED 3: Enable Easter Egg (Min/2 & Max*2)
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 2 clicked - Enable Easter Egg (Min/2 & Max*2).", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCResizer_ConfigTerminal_MainMenu
        NPCResizer_UseEasterEggMode.SetValueInt(1)
      ElseIf (menuButtonClicked == 4)
        ;; CLICKED 4: Disable Easter Egg (Min/2 & Max*2)
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 2 clicked - Disable Easter Egg (Min/2 & Max*2).", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCResizer_ConfigTerminal_MainMenu
        NPCResizer_UseEasterEggMode.SetValueInt(0)
      ElseIf (menuButtonClicked == 5)
        ;; CLICKED 5: Set minimum size scale
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 5 clicked - Launching NPCResizer_ConfigTerminal_ConfigScaleMin menu.", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCResizer_ConfigTerminal_ConfigScaleMin
      ElseIf (menuButtonClicked == 6)
        ;; CLICKED 6: Set maximum size scale
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 6 clicked - Launching NPCResizer_ConfigTerminal_ConfigScaleMax menu.", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCResizer_ConfigTerminal_ConfigScaleMax
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show minimum size scale
    ElseIf (message == NPCResizer_ConfigTerminal_ConfigScaleMin)
      menuButtonClicked = NPCResizer_ConfigTerminal_ConfigScaleMin.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Minimum scale to 35% (Minimum engine can take without targeting errors)
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 1 clicked - Minimum scale to 35% (Minimum engine can take without targeting errors).", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMin.SetValue(0.35)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Minimum scale to 40%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 2 clicked - Minimum scale to 40%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMin.SetValue(0.40)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Minimum scale to 50%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 3 clicked - Minimum scale to 50%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMin.SetValue(0.50)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Minimum scale to 60%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 4 clicked - Minimum scale to 60%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMin.SetValue(0.60)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Minimum scale to 70%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 5 clicked - Minimum scale to 70%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMin.SetValue(0.70)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Minimum scale to 75%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 6 clicked - Minimum scale to 75%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMin.SetValue(0.75)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: Minimum scale to 80%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 7 clicked - Minimum scale to 80%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMin.SetValue(0.80)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 8) 
        ;; CLICKED 8: Minimum scale to 85%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 8 clicked - Minimum scale to 85%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMin.SetValue(0.85)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 9) 
        ;; CLICKED 9: Minimum scale to 90% (Default)
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 9 clicked - Minimum scale to 90% (Default).", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMin.SetValue(0.90)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 10) 
        ;; CLICKED 10: Minimum scale to 95%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 10 clicked - Minimum scale to 95%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMin.SetValue(0.95)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 11) 
        ;; CLICKED 11: Minimum scale to 100%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 11 clicked - Minimum scale to 100%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMin.SetValue(1.00)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 12) 
        ;; CLICKED 12: Minimum scale to 105%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 12 clicked - Minimum scale to 105%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMin.SetValue(1.05)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 13) 
        ;; CLICKED 13: Minimum scale to 110%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 13 clicked - Minimum scale to 110%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMin.SetValue(1.10)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show maximum size scale
    ElseIf (message == NPCResizer_ConfigTerminal_ConfigScaleMax)
      menuButtonClicked = NPCResizer_ConfigTerminal_ConfigScaleMax.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Maximum scale to 85%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 1 clicked - Maximum scale to 85%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMax.SetValue(0.85)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Maximum scale to 90%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 2 clicked - Maximum scale to 90%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMax.SetValue(0.90)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Maximum scale to 95%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 3 clicked - Maximum scale to 95%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMax.SetValue(0.95)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Maximum scale to 100%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 4 clicked - Maximum scale to 100%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMax.SetValue(1.00)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Maximum scale to 105%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 5 clicked - Maximum scale to 105%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMax.SetValue(1.05)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Maximum scale to 110% (Default)
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 6 clicked - Maximum scale to 110% (Default).", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMax.SetValue(1.10)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: Maximum scale to 115%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 7 clicked - Maximum scale to 115%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMax.SetValue(1.15)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 8) 
        ;; CLICKED 8: Maximum scale to 120%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 8 clicked - Maximum scale to 120%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMax.SetValue(1.20)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 9) 
        ;; CLICKED 9: Maximum scale to 125%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 9 clicked - Maximum scale to 125%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMax.SetValue(1.25)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 10) 
        ;; CLICKED 10: Maximum scale to 150%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 10 clicked - Maximum scale to 150%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMax.SetValue(1.50)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 11) 
        ;; CLICKED 11: Maximum scale to 175%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 11 clicked - Maximum scale to 175%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMax.SetValue(1.75)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 12) 
        ;; CLICKED 12: Maximum scale to 200%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 12 clicked - Maximum scale to 200%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMax.SetValue(2.00)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 13) 
        ;; CLICKED 13: Maximum scale to 250%
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 13 clicked - Maximum scale to 250%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMax.SetValue(2.5)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 14) 
        ;; CLICKED 14: Maximum scale to 300% (Max engine can take without targeting errors)
        VPI_Debug.DebugMessage(Venpi_ModName, "NPCResizer_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 14 clicked - Maximum scale to 300% (Max engine can take without targeting errors).", 0, Venpi_DebugEnabled.GetValueInt())
        NPCResizer_ScalingMax.SetValue(3.00)
        message = NPCResizer_ConfigTerminal_MainMenu ;; Return to root menu
      EndIf
    EndIf ;; End Main Menu
  EndWhile
EndFunction
