' Gestionnaire graphique

' Par Sebastien FAVIER
' Reecriture le 13/10/2016
' Mise a jour le 14/12/2017

' 27-01-2021	: AJOUT du support explorer + desktop
' 14-14-2017	: AJOUT du support multi-OS.
' 22-11-2017 	: AJOUT du support d'interaction evenementielle de la barre de progression
' 26-10-2017	: AJOUT du support d'interaction evenementielle du TexteBox
' 15-09-2017	: Correction des evenements mouseleave et mousemove
' 21-08-2017	: Ajout du systeme de suppression des objets + debug
' 06-07-2017	: Ajout des evenements MouseEnter MouseLeave MouseMove Click KeyPress
' 21-06-2017	: Adaptation de init_gui pour les modification des proprietes graphiques
' 23-05-2017	: Ajout du support du CLIC gauche et droit sur les imagesbox
' 19-05-2017	: Readaptation du PNG et le picturebox


#include once "cpcdos.bi"

#print * Initaliser GUI


Function _SCI_Cpcdos_OSx__.Initialiser_GUI__ImGUI(Arg1 as integer, RetourVAR_ as String, _CLE_ as double) as integer


	ENTRER_SectionCritique()
	
	Dim Test_Resolution 	as Integer
	Dim var_SCR_BIT 		as integer
	Dim tmpKernelID			as uinteger
	Dim tmpOSID				as uinteger
	Dim tmpTID				as uinteger
	Dim tmpPID	 			as uinteger
	dim tmpUSERID			as uinteger
	
	Dim var_SCR_RES 		as string
	
	
	this.RetourVAR = RetourVAR_
	
	tmpKernelID = CPCDOS_INSTANCE.get_id_kernel(_CLE_)
	tmpOSID 	= CPCDOS_INSTANCE.get_id_OS(_CLE_)
	tmpTID 		= CPCDOS_INSTANCE.get_id_TID(_CLE_)
	tmpPID 		= CPCDOS_INSTANCE.get_id_PID(_CLE_)
	tmpUSERID 	= CPCDOS_INSTANCE.get_id_Utilisateur(_CLE_)
	
	this._CLE_ = _CLE_
	
	
	' Definit le nouvel ID os depuis la CLE
	set_OSid(tmpOSID)
	
	' Valider l'execution depuis ID os
	CPCDOS_INSTANCE.SCI_INSTANCE.GUI_Exec_os(tmpOSID) = True
	
	IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
		DEBUG("[GUI] Initialisation de la GUI [OS:" & tmpOSID & " 0x" & hex(_CLE_, 8) & "].", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, "")
	Else
		DEBUG("[GUI] GUI Initialisation [OS:" & tmpOSID & " 0x" & hex(_CLE_, 8) & "].", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, "")
	End if
	
	' Recupere la resolution dans les variables utilisateurs
	var_SCR_RES	= UCASE(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("SCR_RES", 4, _CLE_))
	var_SCR_BIT	= Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("SCR_BIT", 4, _CLE_))
	
	
	DEBUG("[GUI] " & var_SCR_RES & " " & var_SCR_BIT & " bits", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, "")
	
	' Tester et initialiser la resolution d'ecran
	Test_Resolution = Initialiser_ECRAN(var_SCR_RES, var_SCR_BIT)

	CPCDOS_INSTANCE.SCI_INSTANCE.GUI_Mode = FALSE
	CPCDOS_INSTANCE.SCI_INSTANCE.GUI_Exec = false

	


	DEBUG("[GUI] Return " & Test_Resolution, CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, "")
	
	if Test_Resolution > 0 Then
		CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("@#ImGUI__Thread cmd/ /thread[MAX] exe/ /Win32 tests/imgui.exe", _CLE_, 4, 0, "")
		Dim ImGUI__Thread as integer = val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("ImGUI__Thread", 4, _CLE_))
	End if

	return Test_Resolution

End function


Function _SCI_Cpcdos_OSx__.Initialiser_GUI(Arg1 as integer, RetourVAR_ as String, _CLE_ as double) as integer
	' Cette fonction va permettre d'initialiser l'interface graphique
	' Declarer les variables
	
	ENTRER_SectionCritique()
	
	Dim Test_Resolution 	as Integer
	Dim var_SCR_BIT 		as integer
	Dim tmpKernelID			as uinteger
	Dim tmpOSID				as uinteger
	Dim tmpTID				as uinteger
	Dim tmpPID	 			as uinteger
	dim tmpUSERID			as uinteger
	
	Dim var_SCR_RES 		as string
	
	
	this.RetourVAR = RetourVAR_
	
	tmpKernelID = CPCDOS_INSTANCE.get_id_kernel(_CLE_)
	tmpOSID 	= CPCDOS_INSTANCE.get_id_OS(_CLE_)
	tmpTID 		= CPCDOS_INSTANCE.get_id_TID(_CLE_)
	tmpPID 		= CPCDOS_INSTANCE.get_id_PID(_CLE_)
	tmpUSERID 	= CPCDOS_INSTANCE.get_id_Utilisateur(_CLE_)
	
	this._CLE_ = _CLE_
	
	
	' Definit le nouvel ID os depuis la CLE
	set_OSid(tmpOSID)
	
	' Valider l'execution depuis ID os
	CPCDOS_INSTANCE.SCI_INSTANCE.GUI_Exec_os(tmpOSID) = True
	
	IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
		DEBUG("[GUI] Initialisation de la GUI [OS:" & tmpOSID & " 0x" & hex(_CLE_, 8) & "].", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, "")
	Else
		DEBUG("[GUI] GUI Initialisation [OS:" & tmpOSID & " 0x" & hex(_CLE_, 8) & "].", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, "")
	End if
	
	' Recupere la resolution dans les variables utilisateurs
	var_SCR_RES	= UCASE(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("SCR_RES", 4, _CLE_))
	var_SCR_BIT	= Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("SCR_BIT", 4, _CLE_))
	
	
	DEBUG("[GUI] " & var_SCR_RES & " " & var_SCR_BIT & " bits", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, "")
	
	' Tester et initialiser la resolution d'ecran
	Test_Resolution = Initialiser_ECRAN(var_SCR_RES, var_SCR_BIT)
	
	DEBUG("[GUI] Return " & Test_Resolution, CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, "")
	
	if Test_Resolution > 0 Then
		' Charger le fond d'ecran
		Dim var_SCR_IMG as String = CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("SCR_IMG", 3, _CLE_)
		charger_Fond(var_SCR_IMG, tmpTID+1024)
		
		
		charger_Curseurs_properties()
		
		charger_Curseurs(tmpTID+1024)


		CPCDOS_INSTANCE.SCI_INSTANCE.screen_collision_left 	= val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.WINDOW.screen_collision_left"	, 3, _CLE_))
		CPCDOS_INSTANCE.SCI_INSTANCE.screen_collision_right = val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.WINDOW.screen_collision_right"	, 3, _CLE_))
		CPCDOS_INSTANCE.SCI_INSTANCE.screen_collision_top 	= val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.WINDOW.screen_collision_top"		, 3, _CLE_))
		CPCDOS_INSTANCE.SCI_INSTANCE.screen_collision_down 	= val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.WINDOW.screen_collision_down"	, 3, _CLE_))


		' L'afficher sur l'ecran
		Flip 3, 2
		Flip 3, 1
		
		SORTIR_SectionCritique()

		
		
		' Creer un nouveau processus
		DEBUG(" ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_SURBRILLE, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR_)
		
		
		IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
			DEBUG("[GUI] Creation du Processus SCI ...", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_Normal, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
		Else
			DEBUG("[GUI] Creating SCI Process ...", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_Normal, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
		End if
		
		Dim INSTANCE_STRUCT_PROCESS as _STRUCT_PROCESSUS_Cpcdos_OSx__
		
		
		' Remplir la structure
		INSTANCE_STRUCT_PROCESS.Nom 			= "SCI_PROCESSUS"		' Nom du processus
		INSTANCE_STRUCT_PROCESS.PROC_ID_PARENT	= tmpPID				' PID du processus parent (qui l'a cree)
		INSTANCE_STRUCT_PROCESS.THREAD_ID_PARENT= tmpTID				' TID du thread parent (qui l'a cree)
		INSTANCE_STRUCT_PROCESS.OS_ID			= tmpOSID				' ID de l'OS
		INSTANCE_STRUCT_PROCESS.USER_ID			= tmpUSERID				' ID de l'user
		
		' Creer le processus
		CPCDOS_INSTANCE.SCI_INSTANCE.PID_SCI = CPCDOS_INSTANCE.Creer_processus(INSTANCE_STRUCT_PROCESS)
		
		Scope
		
			' 3 nouveaux threads
			
			' Thread blittage buffer video
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[GUI] Creation du thread 'THREAD_Screen_Video' dans le processus (PID:" & CPCDOS_INSTANCE.SCI_INSTANCE.PID_SCI & ") ...", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_Normal, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			Else
				DEBUG("[GUI] Creating 'THREAD_Screen_Video' thread in process (PID:" & CPCDOS_INSTANCE.SCI_INSTANCE.PID_SCI & ")...", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_Normal, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			End if
		
			Dim INSTANCE_STRUCT_THREAD as _STRUCT_THREAD_Cpcdos_OSx__
			
			' Remplir la structure
			INSTANCE_STRUCT_THREAD.Nom 		= "THREAD_Screen_Video"		' Nom du thread
			INSTANCE_STRUCT_THREAD.Fonction = @THREAD_Screen_Video		' Adresse memoire
			INSTANCE_STRUCT_THREAD.PROC_ID 	= PID_SCI					' PID du processus parent
			INSTANCE_STRUCT_THREAD.OS_ID	= tmpOSID					' ID de l'OS
			INSTANCE_STRUCT_THREAD.USER_ID	= tmpUSERID					' ID de l'user
			INSTANCE_STRUCT_THREAD.KERNEL_ID= tmpKernelID				' ID du kernel
			
			INSTANCE_STRUCT_THREAD.Priorite = _PRIORITE_THRD_MOYENNE
			INSTANCE_STRUCT_THREAD.ARG_CP	= NULL						' Argument pour CPinti Core
			
			INSTANCE_STRUCT_THREAD.ARG_1 	= NULL
			INSTANCE_STRUCT_THREAD.ARG_2 	= NULL
			INSTANCE_STRUCT_THREAD.ARG_3	= NULL
			INSTANCE_STRUCT_THREAD.ARG_4	= NULL
			INSTANCE_STRUCT_THREAD.ARG_5 	= NULL
			INSTANCE_STRUCT_THREAD.ARG_6 	= NULL
			
			' Creer le thread
			CPCDOS_INSTANCE.SCI_INSTANCE.TID_SCI = CPCDOS_INSTANCE.Creer_thread(INSTANCE_STRUCT_THREAD)
			
			' Thread interaction utilisateur et creations
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[GUI] Creation du thread 'THREAD_SCI' dans le processus (PID:" & CPCDOS_INSTANCE.SCI_INSTANCE.PID_SCI & ") ...", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_Normal, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			Else
				DEBUG("[GUI] Creating 'THREAD_SCI' thread in process (PID:" & CPCDOS_INSTANCE.SCI_INSTANCE.PID_SCI & ")...", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_Normal, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			End if
				
			' Remplir la structure
			INSTANCE_STRUCT_THREAD.Nom 		= "THREAD_SCI"					' Nom du thread
			INSTANCE_STRUCT_THREAD.Fonction = @THREAD__SCI					' Adresse memoire
			INSTANCE_STRUCT_THREAD.PROC_ID 	= PID_SCI						' PID du processus parent
			INSTANCE_STRUCT_THREAD.OS_ID	= tmpOSID						' ID de l'OS
			INSTANCE_STRUCT_THREAD.USER_ID	= tmpUSERID						' ID de l'user
			INSTANCE_STRUCT_THREAD.KERNEL_ID= tmpKernelID						' ID du kernel
			
			INSTANCE_STRUCT_THREAD.Priorite = _PRIORITE_THRD_HAUTE
			INSTANCE_STRUCT_THREAD.ARG_CP	= NULL							' Argument pour CPinti Core
			INSTANCE_STRUCT_THREAD.ARG_1 	= NULL
			INSTANCE_STRUCT_THREAD.ARG_2 	= NULL
			INSTANCE_STRUCT_THREAD.ARG_3	= NULL
			INSTANCE_STRUCT_THREAD.ARG_4	= NULL
			INSTANCE_STRUCT_THREAD.ARG_5 	= NULL
			INSTANCE_STRUCT_THREAD.ARG_6 	= NULL
			
			' Creer le thread
			CPCDOS_INSTANCE.SCI_INSTANCE.TID_SCI = CPCDOS_INSTANCE.Creer_thread(INSTANCE_STRUCT_THREAD)
			
			' Thread d'actualisation des elements graphiques (Heure, FPS, CPU, RAM ...)
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[GUI] Creation du thread 'THREAD_RefreshGUI_Elements' dans le processus (PID:" & CPCDOS_INSTANCE.SCI_INSTANCE.PID_SCI & ") ...", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_Normal, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			Else
				DEBUG("[GUI] Creating 'THREAD_RefreshGUI_Elements' thread in process (PID:" & CPCDOS_INSTANCE.SCI_INSTANCE.PID_SCI & ")...", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_Normal, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			End if
				
			' Remplir la structure
			INSTANCE_STRUCT_THREAD.Nom 		= "THREAD_RefreshGUI_Elements"	' Nom du thread
			INSTANCE_STRUCT_THREAD.Fonction = @THREAD_RefreshGUI_Elements	' Adresse memoire
			INSTANCE_STRUCT_THREAD.PROC_ID 	= PID_SCI						' PID du processus parent
			INSTANCE_STRUCT_THREAD.OS_ID	= tmpOSID						' ID de l'OS
			INSTANCE_STRUCT_THREAD.USER_ID	= tmpUSERID						' ID de l'user
			INSTANCE_STRUCT_THREAD.KERNEL_ID= tmpKernelID						' ID du kernel
			
			INSTANCE_STRUCT_THREAD.Priorite = _PRIORITE_THRD_HAUTE
			INSTANCE_STRUCT_THREAD.ARG_CP	= NULL							' Argument pour CPinti Core
			INSTANCE_STRUCT_THREAD.ARG_1 	= NULL
			INSTANCE_STRUCT_THREAD.ARG_2 	= NULL
			INSTANCE_STRUCT_THREAD.ARG_3	= NULL
			INSTANCE_STRUCT_THREAD.ARG_4	= NULL
			INSTANCE_STRUCT_THREAD.ARG_5 	= NULL
			INSTANCE_STRUCT_THREAD.ARG_6 	= NULL
			
			' Creer le thread
			CPCDOS_INSTANCE.SCI_INSTANCE.TID_SCI = CPCDOS_INSTANCE.Creer_thread(INSTANCE_STRUCT_THREAD)

		End Scope
		ScreenUnlock
		
		' Actualiser tout
		ActualiserGUI(0, 0)
		return 1
	else
		SORTIR_SectionCritique()
		return 0
	End if
	
End function



Sub _SCI_Cpcdos_OSx__.IUG_Updater(Type_IUG as integer, index as integer, index_PID as integer)
	' Cette fonction permet de mettre a jour les "objets" qui doivent etre reactualises
	
	ScreenLock
	
	IF get_OSid() = this.INST_INIT_GUI.GUI__FENETRE(index_PID).Identification_Objet.OS_id Then
		if CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__FENETRE(index_PID).PROP_TYPE.Ferme 	= false AND _
			CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__FENETRE(index_PID).PROP_TYPE.Reduit 	= false Then

			If Type_IUG = GUI_TYPE.Fenetre then
				IF this.INST_INIT_GUI.POSITION(1) = index_PID Then
					Creer_Fenetre( index) 'Actualiser si focus
				End if
			ElseIf Type_IUG = GUI_TYPE.Bouton then
				IF this.INST_INIT_GUI.POSITION(1) = index_PID Then
					Creer_Bouton(index, index_PID) 'Actualiser si focus
				End if
			ElseIf Type_IUG = GUI_TYPE.PictureBox then
				IF this.INST_INIT_GUI.POSITION(1) = index_PID Then
					Creer_PictureBox(index, index_PID) 'Actualiser si focus
				else
					'IF this.MULTI_PICTUREBOX = TRUE then
					'	Creer_PictureBox(index, index_PID) 'Actualiser si focus
					'	ActualiserGUI(1, this.INST_INIT_GUI.POSITION(1))
					'End if
				End if
			ElseIf Type_IUG = GUI_TYPE.TextBlock then
				IF this.INST_INIT_GUI.POSITION(1) = index_PID Then
					Creer_TextBlock(index, index_PID) 'Actualiser si focus
				End if
			ElseIf Type_IUG = GUI_TYPE.TextBox then
				IF this.INST_INIT_GUI.POSITION(1) = index_PID Then
					Creer_TextBox(index, index_PID) 'Actualiser si focus
				End if
			ElseIf Type_IUG = GUI_TYPE.ProgressBar then
				IF this.INST_INIT_GUI.POSITION(1) = index_PID Then
					Creer_ProgressBar(index, index_PID) 'Actualiser si focus
				End if
			ElseIf Type_IUG = GUI_TYPE.Explorer then
				IF this.INST_INIT_GUI.POSITION(1) = index_PID Then
					Creer_Explorer(index, index_PID) 'Actualiser si focus
				End if
			ElseIf Type_IUG = GUI_TYPE.Listbox then
				IF this.INST_INIT_GUI.POSITION(1) = index_PID Then
					Creer_Listbox(index, index_PID) 'Actualiser si focus
				End if
			Else
			
			end if
		End if ' fenetre visible ?
	End if
	
	ScreenUnLock
End sub

Function _SCI_Cpcdos_OSx__.CPC__GUI_Init_obj(Type_De_GUI as Integer, _Proprietes as CPCDOS_GUI_INIT__, _CLE_ as uinteger, Modification_GUI as boolean, _INDEX_MODIF_ as integer) as Integer
	REM Cette fonction permet de creer un objet proprement en identifiant le type de creation
	REM Type_De_GUI : 	
	REM 	.Fenetre
	REM		.PictureBox
	REM		.TextBlock
	REM		.TextBox
	
	REM Renvoie le numero de PID
	
	Dim _INDEX_ as integer = 0
	
	ScreenLock

	' =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= FENETRE =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	IF Type_De_GUI = this.GUI_TYPE.Fenetre Then

		' Si le handle est superieur a 0, donc verifier si ce handle existe! 
		IF _Proprietes.TEMP_GUI__FENETRE.Identification_Objet.handle > 0 Then
			IF _INDEX_MODIF_ = 0 Then
				For _BOUCLE_ as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_FENETRE
					IF _Proprietes.TEMP_GUI__FENETRE.Identification_Objet.handle = this.INST_INIT_GUI.GUI__FENETRE(_BOUCLE_).Identification_Objet.handle Then
					
						' Obtenir l'emplacement memoire libre
						_INDEX_  = get_Emplacement_Libre(Type_De_GUI)
					
						exit for
					END IF
				Next _BOUCLE_

				' Verifier si le PID parent a ete trouve
				IF _INDEX_ = 0 Then 
					IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
						DEBUG("[GUI] Le handle fenetre parent " & _Proprietes.TEMP_GUI__FENETRE.Identification_Objet.handle & " est introuvable!", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
					Else
						DEBUG("[GUI] Parent window handle " & _Proprietes.TEMP_GUI__FENETRE.Identification_Objet.handle & " is missing !", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
					End if

					CPC__GUI_Init_obj = -1
					ScreenUnlock
					exit function
				End if
			End if
		End if
	
		IF _INDEX_MODIF_ > 0  Then 
		
			_INDEX_ = _INDEX_MODIF_
			
			' Recuperer l'ancien handle
			_Proprietes.TEMP_GUI__FENETRE.Identification_Objet.handle = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.handle
			
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__FENETRE(_INDEX_) 	= _Proprietes.TEMP_GUI__FENETRE
			
		Else
		
			' *** PROCESSUS ***
			' Recuperer le PID (processus) parent qui heberge la fenetre
			_Proprietes.TEMP_GUI__FENETRE.Identification_Objet.PID_PARENT 	= CPCDOS_INSTANCE.get_id_PID(_CLE_)
			
			' Recuperer le NOM de ce processus grace a son PID
			_Proprietes.TEMP_GUI__FENETRE.Identification_Objet.Proc_PARENT 	= CPCDOS_INSTANCE.get_Nom_Processus(_Proprietes.TEMP_GUI__FENETRE.Identification_Objet.PID_PARENT)
			
			
			' *** THREAD ***
			' Recuperer le TID (thread) parent qui execute cette fenetre
			_Proprietes.TEMP_GUI__FENETRE.Identification_Objet.TID_PARENT 		= CPCDOS_INSTANCE.get_id_TID(_CLE_)
			
			' Recuperer le PID du processus parent qui heberge la fenetre grace a son TID
			_Proprietes.TEMP_GUI__FENETRE.Identification_Objet.Thread_PARENT	= CPCDOS_INSTANCE.get_Nom_Thread(_Proprietes.TEMP_GUI__FENETRE.Identification_Objet.TID_PARENT)
		
			
			 ' Obtenir l'emplacement memoire libre
			_INDEX_ = get_Emplacement_Libre(Type_De_GUI)
			
			' Associer son numero de handle unique de la fenetre
			_Proprietes.TEMP_GUI__FENETRE.Identification_Objet.handle	= CPCDOS_INSTANCE.Generer_RND(100, 999)

			' SI c'est un taskbar
			if _Proprietes.TEMP_GUI__FENETRE.PROP_TYPE.TaskBar > 0 Then
				CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_List_win = _INDEX_
			End if
			
			' /!\ Transferer les proprietes temporaires dans les proprietes definitives /!\
			this.INST_INIT_GUI.GUI__FENETRE(_INDEX_) 					= _Proprietes.TEMP_GUI__FENETRE

			' Mettre la fenetre au premier plan
			Changer_PremierPlan_OrdreFenetrale(_INDEX_)
		End if
		
		
		' Lui donner son index
		_Proprietes.TEMP_GUI__FENETRE.Identification_Objet.Index_Enfant = _INDEX_

		

		' Creer l'objet
		_Proprietes.TEMP_GUI__FENETRE.Identification_Objet.handle = Creer_Fenetre(_INDEX_)
					
		
		CPC__GUI_Init_obj = _Proprietes.TEMP_GUI__FENETRE.Identification_Objet.handle

		' Sil y a une taskbar
		if CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_List_win > 0 Then
			if NOT CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_List_win = _INDEX_ Then ' Et que c'est pas elle m�me
				' On actualise le contenu de la taskbar
				ActualiserGUI(1, CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_List_win)

			End if
		End if

		



	' =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Bouton  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	ELSEIF Type_De_GUI = this.GUI_TYPE.Bouton Then
	
		Dim _INDEX_Fenetre_ as integer 
		' Verifier si le processus (PID) existe!
		For _INDEX_Fenetre_ = 1 to CPCDOS_INSTANCE._MAX_GUI_FENETRE
			IF _Proprietes.TEMP_GUI__BOUTON.Identification_Objet.Handle_Parent = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_Fenetre_).Identification_Objet.handle Then
				
				IF _INDEX_MODIF_ = 0 Then
					' Obtenir l'emplacement memoire libre
					_INDEX_  = get_Emplacement_Libre(Type_De_GUI)
				else
					_INDEX_ = _INDEX_MODIF_
				End if
				
				exit for
			END IF
		Next _INDEX_Fenetre_
		
		' Verifier si le PID a ete trouve
		IF _INDEX_ = 0 Then 
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[GUI] Le handle fenetre parent " & _Proprietes.TEMP_GUI__BOUTON.Identification_Objet.handle & " est introuvable!", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			Else
				DEBUG("[GUI] Parent window handle " & _Proprietes.TEMP_GUI__BOUTON.Identification_Objet.handle & " is missing !", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			End if
			CPC__GUI_Init_obj = -1
			ScreenUnlock
			exit function
		End if
		
		IF _INDEX_MODIF_ > 0  Then 
			
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__BOUTON(_INDEX_) = _Proprietes.TEMP_GUI__BOUTON
			
		Else
		
			 ' Obtenir l'emplacement memoire libre
			_INDEX_ = get_Emplacement_Libre(Type_De_GUI)
			
			' Lui donner son numero d'index
			_Proprietes.TEMP_GUI__BOUTON.Identification_Objet.Index_Enfant = _INDEX_
			
			' Associer son handle a celui du processus parent
			_Proprietes.TEMP_GUI__BOUTON.Identification_Objet.handle = CPCDOS_INSTANCE.Generer_RND(100, 999)
		
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__BOUTON(_INDEX_) = _Proprietes.TEMP_GUI__BOUTON

		End if
		
		' Creer l'objet
		_Proprietes.TEMP_GUI__BOUTON.Identification_Objet.handle = Creer_Bouton(_INDEX_, _INDEX_Fenetre_)

		' Transferer le handle
		CPC__GUI_Init_obj = _Proprietes.TEMP_GUI__BOUTON.Identification_Objet.handle
		
	
	' =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= PICTURE BOX =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	ELSEIF Type_De_GUI = this.GUI_TYPE.PictureBox Then
	
		Dim _INDEX_Fenetre_ as integer 

		For _INDEX_Fenetre_ = 1 to CPCDOS_INSTANCE._MAX_GUI_FENETRE
			IF _Proprietes.TEMP_GUI__PICTUREBOX.Identification_Objet.Handle_Parent = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_Fenetre_).Identification_Objet.handle Then
				
				IF _INDEX_MODIF_ = 0 Then
					' Obtenir l'emplacement memoire libre
					_INDEX_  = get_Emplacement_Libre(Type_De_GUI)
				else
					_INDEX_ = _INDEX_MODIF_
				End if
				
				exit for
			END IF
		Next _INDEX_Fenetre_
	
		' Verifier si le PID a ete trouve
		IF _INDEX_ = 0 Then 
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[GUI] Le handle fenetre parent " & _Proprietes.TEMP_GUI__PICTUREBOX.Identification_Objet.handle & " est introuvable!", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			Else
				DEBUG("[GUI] Parent window handle " & _Proprietes.TEMP_GUI__PICTUREBOX.Identification_Objet.handle & " is missing !", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			End if
			CPC__GUI_Init_obj = -1
			ScreenUnlock
			exit function
		End if
		
		IF _INDEX_MODIF_ > 0  Then 
			
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__PICTUREBOX(_INDEX_) = _Proprietes.TEMP_GUI__PICTUREBOX
			
		Else
		
			 ' Obtenir l'emplacement memoire libre
			_INDEX_ = get_Emplacement_Libre(Type_De_GUI)
			
			' Lui donner son numero d'index
			_Proprietes.TEMP_GUI__PICTUREBOX.Identification_Objet.Index_Enfant = _INDEX_
			
			
			' INFO DU 05/09
			' A REVOIR !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			' Verifier s'il a besoin d'un thread pour actualiser son contenu
			IF _Proprietes.TEMP_GUI__PICTUREBOX.IUG_UPDATER > 0 then 
			
				' DEBUG("**** ID:" & _Proprietes.TEMP_GUI__PICTUREBOX.IMG_ID & ".", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_Normal, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				
				' CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Actu_Bitmap_TYPE	(_Proprietes.TEMP_GUI__PICTUREBOX.IMG_ID) = CPCDOS_INSTANCE.SCI_INSTANCE.GUI_TYPE.PictureBox
				' CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Actu_Bitmap_PID	(_Proprietes.TEMP_GUI__PICTUREBOX.IMG_ID) = _INDEX_Fenetre_
				' CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Actu_Bitmap_Index	(_Proprietes.TEMP_GUI__PICTUREBOX.IMG_ID) = _INDEX_
			
				' DEBUG("TYPE:" & CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Actu_Bitmap_TYPE	(_Proprietes.TEMP_GUI__PICTUREBOX.IMG_ID) & ".", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_Normal, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				' DEBUG("PID:" & CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Actu_Bitmap_PID	(_Proprietes.TEMP_GUI__PICTUREBOX.IMG_ID) & ".", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_Normal, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				' DEBUG("IND:" & CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Actu_Bitmap_Index	(_Proprietes.TEMP_GUI__PICTUREBOX.IMG_ID) & ".", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_Normal, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
			
				IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
					IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
						DEBUG("[CpcdosC+] Creation du thread du PictureBox [" & "_CPCDOS_THREAD_PICTUREBOX~" & _Proprietes.TEMP_GUI__PICTUREBOX.Identification_Objet.handle & "] ...", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_Normal, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
					Else
						DEBUG("[CpcdosC+] Creating PictureBox thread [" & "_CPCDOS_THREAD_PICTUREBOX~" & _Proprietes.TEMP_GUI__PICTUREBOX.Identification_Objet.handle & "] ...", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_Normal, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
					End if
				END IF

				if Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.PICTUREBOX.MULTI_THREAD.NO_FOCUS", 3, _CLE_)) = 1 Then
					CPCDOS_INSTANCE.SCI_INSTANCE.MULTI_PICTUREBOX = true
				Else
					CPCDOS_INSTANCE.SCI_INSTANCE.MULTI_PICTUREBOX = false
				End if

				Scope
				
					Dim INSTANCE_STRUCT_THREAD as _STRUCT_THREAD_Cpcdos_OSx__
			
					' Remplir la structure
					INSTANCE_STRUCT_THREAD.Nom 		= "_CPCDOS_THREAD_PICTUREBOX~" & _Proprietes.TEMP_GUI__PICTUREBOX.Identification_Objet.PROC_PARENT
					INSTANCE_STRUCT_THREAD.Fonction = cast(any ptr, @THREAD_IUG_PICTUREBOX) 											' Adresse memoire de la fonction
					INSTANCE_STRUCT_THREAD.PROC_ID 	= this.INST_INIT_GUI.GUI__FENETRE(_INDEX_Fenetre_).Identification_Objet.PID_PARENT	' PID uint
					INSTANCE_STRUCT_THREAD.OS_ID	= CPCDOS_INSTANCE.get_id_OS()														' ID de l'OS
					INSTANCE_STRUCT_THREAD.USER_ID	= CPCDOS_INSTANCE.get_id_Utilisateur(_CLE_)											' ID de l'user
					INSTANCE_STRUCT_THREAD.KERNEL_ID= CPCDOS_INSTANCE.get_id_Kernel(_CLE_)												' ID du kernel
					
					INSTANCE_STRUCT_THREAD.THREAD_ID= this.INST_INIT_GUI.GUI__FENETRE(_INDEX_Fenetre_).Identification_Objet.TID_PARENT	' TID
					INSTANCE_STRUCT_THREAD.handle 	= this.INST_INIT_GUI.GUI__FENETRE(_INDEX_Fenetre_).Identification_Objet.handle		' Handle
					INSTANCE_STRUCT_THREAD.Priorite = _PRIORITE_THRD_TRES_FAIBLE
					INSTANCE_STRUCT_THREAD.ARG_CP	= NULL																				' Argument pour CPinti Core
					INSTANCE_STRUCT_THREAD.ARG_1 	= NULL
					INSTANCE_STRUCT_THREAD.ARG_2 	= NULL
					INSTANCE_STRUCT_THREAD.ARG_3	= NULL
					INSTANCE_STRUCT_THREAD.ARG_4	= NULL
					INSTANCE_STRUCT_THREAD.ARG_5 	= NULL
					INSTANCE_STRUCT_THREAD.ARG_6 	= NULL
					
					' Creer le thread
					_Proprietes.TEMP_GUI__PICTUREBOX.Identification_Objet.handle = CPCDOS_INSTANCE.Creer_thread(INSTANCE_STRUCT_THREAD)
				End Scope
				
				IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
					IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
						DEBUG("[CpcdosC+] Demande creation thread PictureBox envoye!", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_Normal, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
					Else
						DEBUG("[CpcdosC+] PictureBox thread creation, in creating!", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_Normal, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
					End if
				END IF
				
				' doevents(500000)
				
			else
				' Associer son handle a celui du processus parent
				_Proprietes.TEMP_GUI__PICTUREBOX.Identification_Objet.handle = CPCDOS_INSTANCE.Generer_RND(100, 999)
			End if
			
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__PICTUREBOX(_INDEX_) = _Proprietes.TEMP_GUI__PICTUREBOX

		End if
		
		' Creer l'objet
		_Proprietes.TEMP_GUI__PICTUREBOX.Identification_Objet.handle = Creer_PictureBox(_INDEX_, _INDEX_Fenetre_)
	
		
		' Transferer le handle
		CPC__GUI_Init_obj = _Proprietes.TEMP_GUI__PICTUREBOX.Identification_Objet.handle
		
	' =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= TEXT BLOCK =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	ELSEIF	Type_De_GUI = this.GUI_TYPE.TextBlock Then
	
		Dim _INDEX_Fenetre_ as integer 

		For _INDEX_Fenetre_ = 1 to CPCDOS_INSTANCE._MAX_GUI_FENETRE
			IF _Proprietes.TEMP_GUI__TEXTBLOCK.Identification_Objet.Handle_Parent = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_Fenetre_).Identification_Objet.handle Then
				
				IF _INDEX_MODIF_ = 0 Then
					' Obtenir l'emplacement memoire libre
					_INDEX_  = get_Emplacement_Libre(Type_De_GUI)
				else
					_INDEX_ = _INDEX_MODIF_
				End if
				
				exit for
			END IF
		Next _INDEX_Fenetre_
	
		' Verifier si le PID a ete trouve
		IF _INDEX_ = 0 Then 
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[GUI] Le handle fenetre parent " & _Proprietes.TEMP_GUI__TEXTBLOCK.Identification_Objet.handle & " est introuvable!", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			Else
				DEBUG("[GUI] Parent window handle " & _Proprietes.TEMP_GUI__TEXTBLOCK.Identification_Objet.handle & " is missing !", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			End if
			CPC__GUI_Init_obj = -1
			ScreenUnlock
			exit function
		End if
		
		IF _INDEX_MODIF_ > 0  Then 
			
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__TEXTBLOCK(_INDEX_) = _Proprietes.TEMP_GUI__TEXTBLOCK
			
		Else
		
			 ' Obtenir l'emplacement memoire libre
			_INDEX_ = get_Emplacement_Libre(Type_De_GUI)
			
			' Lui donner son numero d'index
			_Proprietes.TEMP_GUI__TEXTBLOCK.Identification_Objet.Index_Enfant = _INDEX_
			
			' Associer son handle a celui du processus parent
			_Proprietes.TEMP_GUI__TEXTBLOCK.Identification_Objet.handle = CPCDOS_INSTANCE.Generer_RND(100, 999)
		
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__TEXTBLOCK(_INDEX_) = _Proprietes.TEMP_GUI__TEXTBLOCK

		End if
		
		' Creer l'objet
		_Proprietes.TEMP_GUI__TEXTBLOCK.Identification_Objet.handle = Creer_TextBlock(_INDEX_, _INDEX_Fenetre_)
	
		
		' Transferer le handle
		CPC__GUI_Init_obj = _Proprietes.TEMP_GUI__TEXTBLOCK.Identification_Objet.handle

	' =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= TEXT BOX =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	ELSEIF	Type_De_GUI = this.GUI_TYPE.TextBox Then
	
		Dim _INDEX_Fenetre_ as integer 

		For _INDEX_Fenetre_ = 1 to CPCDOS_INSTANCE._MAX_GUI_FENETRE
			IF _Proprietes.TEMP_GUI__TEXTBOX.Identification_Objet.Handle_Parent = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_Fenetre_).Identification_Objet.handle Then
				
				IF _INDEX_MODIF_ = 0 Then
					' Obtenir l'emplacement memoire libre
					_INDEX_  = get_Emplacement_Libre(Type_De_GUI)
				else
					_INDEX_ = _INDEX_MODIF_
				End if
				
				exit for
			END IF
		Next _INDEX_Fenetre_
	
		' Verifier si le PID a ete trouve
		IF _INDEX_ = 0 Then 
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[GUI] Le handle fenetre parent " & _Proprietes.TEMP_GUI__TEXTBOX.Identification_Objet.handle & " est introuvable!", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			Else
				DEBUG("[GUI] Parent window handle " & _Proprietes.TEMP_GUI__TEXTBOX.Identification_Objet.handle & " is missing !", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			End if
			CPC__GUI_Init_obj = -1
			ScreenUnlock
			exit function
		End if
		
		IF _INDEX_MODIF_ > 0  Then 
			
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__TEXTBOX(_INDEX_) = _Proprietes.TEMP_GUI__TEXTBOX
			
		Else
		
			 ' Obtenir l'emplacement memoire libre
			_INDEX_ = get_Emplacement_Libre(Type_De_GUI)
			
			' Lui donner son numero d'index
			_Proprietes.TEMP_GUI__TEXTBOX.Identification_Objet.Index_Enfant = _INDEX_
			
			' Associer son handle a celui du processus parent
			_Proprietes.TEMP_GUI__TEXTBOX.Identification_Objet.handle = CPCDOS_INSTANCE.Generer_RND(100, 999)
		
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__TEXTBOX(_INDEX_) = _Proprietes.TEMP_GUI__TEXTBOX

		End if
		
		' Creer l'objet
		this.INST_INIT_GUI.GUI__TEXTBOX(_INDEX_).Identification_Objet.handle = Creer_TextBox(_INDEX_, _INDEX_Fenetre_)
	
		
		' Transferer le handle
		CPC__GUI_Init_obj = this.INST_INIT_GUI.GUI__TEXTBOX(_INDEX_).Identification_Objet.handle
	
	' =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Progress Bar =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	ELSEIF	Type_De_GUI = this.GUI_TYPE.ProgressBar Then
	
		Dim _INDEX_Fenetre_ as integer 

		For _INDEX_Fenetre_ = 1 to CPCDOS_INSTANCE._MAX_GUI_FENETRE
			IF _Proprietes.TEMP_GUI__PROGRESSBAR.Identification_Objet.Handle_Parent = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_Fenetre_).Identification_Objet.handle Then
				
				IF _INDEX_MODIF_ = 0 Then
					' Obtenir l'emplacement memoire libre
					_INDEX_  = get_Emplacement_Libre(Type_De_GUI)
				else
					_INDEX_ = _INDEX_MODIF_
				End if
				
				exit for
			END IF
		Next _INDEX_Fenetre_
	
		' Verifier si le PID a ete trouve
		IF _INDEX_ = 0 Then 
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[GUI] Le handle fenetre parent " & _Proprietes.TEMP_GUI__PROGRESSBAR.Identification_Objet.handle & " est introuvable!", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			Else
				DEBUG("[GUI] Parent window handle " & _Proprietes.TEMP_GUI__PROGRESSBAR.Identification_Objet.handle & " is missing !", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			End if
			CPC__GUI_Init_obj = -1
			ScreenUnlock
			exit function
		End if
		
		IF _INDEX_MODIF_ > 0  Then 
			
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__PROGRESSBAR(_INDEX_) = _Proprietes.TEMP_GUI__PROGRESSBAR
			
		Else
		
			 ' Obtenir l'emplacement memoire libre
			_INDEX_ = get_Emplacement_Libre(Type_De_GUI)
			
			' Lui donner son numero d'index
			_Proprietes.TEMP_GUI__PROGRESSBAR.Identification_Objet.Index_Enfant = _INDEX_
			
			' Associer son handle a celui du processus parent
			_Proprietes.TEMP_GUI__PROGRESSBAR.Identification_Objet.handle = CPCDOS_INSTANCE.Generer_RND(100, 999)
		
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__PROGRESSBAR(_INDEX_) = _Proprietes.TEMP_GUI__PROGRESSBAR

		End if
		
		' Creer l'objet
		this.INST_INIT_GUI.GUI__PROGRESSBAR(_INDEX_).Identification_Objet.handle = Creer_ProgressBar(_INDEX_, _INDEX_Fenetre_)
	
		
		' Transferer le handle
		CPC__GUI_Init_obj = this.INST_INIT_GUI.GUI__PROGRESSBAR(_INDEX_).Identification_Objet.handle
	
	' =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Progress Bar =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	ELSEIF	Type_De_GUI = this.GUI_TYPE.Checkbox Then
	
		Dim _INDEX_Fenetre_ as integer 

		For _INDEX_Fenetre_ = 1 to CPCDOS_INSTANCE._MAX_GUI_FENETRE
			IF _Proprietes.TEMP_GUI__CHECKBOX.Identification_Objet.Handle_Parent = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_Fenetre_).Identification_Objet.handle Then
				
				IF _INDEX_MODIF_ = 0 Then
					' Obtenir l'emplacement memoire libre
					_INDEX_  = get_Emplacement_Libre(Type_De_GUI)
				else
					_INDEX_ = _INDEX_MODIF_
				End if
				
				exit for
			END IF
		Next _INDEX_Fenetre_
	
		' Verifier si le PID a ete trouve
		IF _INDEX_ = 0 Then 
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[GUI] Le handle fenetre parent " & _Proprietes.TEMP_GUI__CHECKBOX.Identification_Objet.handle & " est introuvable!", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			Else
				DEBUG("[GUI] Parent window handle " & _Proprietes.TEMP_GUI__CHECKBOX.Identification_Objet.handle & " is missing !", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			End if
			CPC__GUI_Init_obj = -1
			ScreenUnlock
			exit function
		End if
		
		IF _INDEX_MODIF_ > 0  Then 
			
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__CHECKBOX(_INDEX_) = _Proprietes.TEMP_GUI__CHECKBOX
			
		Else
		
			 ' Obtenir l'emplacement memoire libre
			_INDEX_ = get_Emplacement_Libre(Type_De_GUI)
			
			' Lui donner son numero d'index
			_Proprietes.TEMP_GUI__CHECKBOX.Identification_Objet.Index_Enfant = _INDEX_
			
			' Associer son handle a celui du processus parent
			_Proprietes.TEMP_GUI__CHECKBOX.Identification_Objet.handle = CPCDOS_INSTANCE.Generer_RND(100, 999)
		
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__CHECKBOX(_INDEX_) = _Proprietes.TEMP_GUI__CHECKBOX

		End if
		
		' Creer l'objet
		this.INST_INIT_GUI.GUI__CHECKBOX(_INDEX_).Identification_Objet.handle = Creer_Checkbox(_INDEX_, _INDEX_Fenetre_)
	
		
		' Transferer le handle
		CPC__GUI_Init_obj = this.INST_INIT_GUI.GUI__CHECKBOX(_INDEX_).Identification_Objet.handle
	
	' =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Explorer  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	ELSEIF Type_De_GUI = this.GUI_TYPE.Explorer Then
	
		Dim _INDEX_Fenetre_ as integer 
		' Verifier si le processus (PID) existe!
		For _INDEX_Fenetre_ = 1 to CPCDOS_INSTANCE._MAX_GUI_FENETRE
			IF _Proprietes.TEMP_GUI__EXPLORER.Identification_Objet.Handle_Parent = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_Fenetre_).Identification_Objet.handle Then
				
				IF _INDEX_MODIF_ = 0 Then
					' Obtenir l'emplacement memoire libre
					_INDEX_  = get_Emplacement_Libre(Type_De_GUI)
				else
					_INDEX_ = _INDEX_MODIF_
				End if
				
				exit for
			END IF
		Next _INDEX_Fenetre_
		
		' Verifier si le PID a ete trouve
		IF _INDEX_ = 0 Then 
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[GUI] Le handle fenetre parent " & _Proprietes.TEMP_GUI__EXPLORER.Identification_Objet.handle & " est introuvable!", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			Else
				DEBUG("[GUI] Parent window handle " & _Proprietes.TEMP_GUI__EXPLORER.Identification_Objet.handle & " is missing !", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			End if
			CPC__GUI_Init_obj = -1
			ScreenUnlock
			exit function
		End if

		IF _INDEX_MODIF_ > 0  Then 
			
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__EXPLORER(_INDEX_) = _Proprietes.TEMP_GUI__EXPLORER
			
		Else
		
			 ' Obtenir l'emplacement memoire libre
			_INDEX_ = get_Emplacement_Libre(Type_De_GUI)
			
			' Lui donner son numero d'index
			_Proprietes.TEMP_GUI__EXPLORER.Identification_Objet.Index_Enfant = _INDEX_
			
			' Associer son handle a celui du processus parent
			_Proprietes.TEMP_GUI__EXPLORER.Identification_Objet.handle = CPCDOS_INSTANCE.Generer_RND(100, 999)
		
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__EXPLORER(_INDEX_) = _Proprietes.TEMP_GUI__EXPLORER
			

		End if
		
		' Creer l'objet
		_Proprietes.TEMP_GUI__EXPLORER.Identification_Objet.handle = Creer_Explorer(_INDEX_, _INDEX_Fenetre_)

		' Transferer le handle
		CPC__GUI_Init_obj = _Proprietes.TEMP_GUI__EXPLORER.Identification_Objet.handle
	' =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Listbox  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	ELSEIF Type_De_GUI = this.GUI_TYPE.Listbox Then

	
		Dim _INDEX_Fenetre_ as integer 
		' Verifier si le processus (PID) existe!
		For _INDEX_Fenetre_ = 1 to CPCDOS_INSTANCE._MAX_GUI_FENETRE
			IF _Proprietes.TEMP_GUI__LISTBOX.Identification_Objet.Handle_Parent = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_Fenetre_).Identification_Objet.handle Then
				
				IF _INDEX_MODIF_ = 0 Then
					' Obtenir l'emplacement memoire libre
					_INDEX_  = get_Emplacement_Libre(Type_De_GUI)
				else
					_INDEX_ = _INDEX_MODIF_
				End if
				
				exit for
			END IF
		Next _INDEX_Fenetre_
		
		' Verifier si le PID a ete trouve
		IF _INDEX_ = 0 Then 
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[GUI] Le handle fenetre parent " & _Proprietes.TEMP_GUI__LISTBOX.Identification_Objet.handle & " est introuvable!", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			Else
				DEBUG("[GUI] Parent window handle " & _Proprietes.TEMP_GUI__LISTBOX.Identification_Objet.handle & " is missing !", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_AFF, RetourVAR)
			End if
			CPC__GUI_Init_obj = -1
			ScreenUnlock
			exit function
		End if

		

		IF _INDEX_MODIF_ > 0  Then 
			
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__LISTBOX(_INDEX_) = _Proprietes.TEMP_GUI__LISTBOX
			
		Else
		
			 ' Obtenir l'emplacement memoire libre
			_INDEX_ = get_Emplacement_Libre(Type_De_GUI)
			
			' Lui donner son numero d'index
			_Proprietes.TEMP_GUI__LISTBOX.Identification_Objet.Index_Enfant = _INDEX_
			
			' Associer son handle a celui du processus parent
			_Proprietes.TEMP_GUI__LISTBOX.Identification_Objet.handle = CPCDOS_INSTANCE.Generer_RND(100, 999)
		
			' Transferer les proprietes temporaires dans les proprietes definitives
			this.INST_INIT_GUI.GUI__LISTBOX(_INDEX_) = _Proprietes.TEMP_GUI__LISTBOX
			

		End if
		
		' Creer l'objet
		_Proprietes.TEMP_GUI__LISTBOX.Identification_Objet.handle = Creer_Listbox(_INDEX_, _INDEX_Fenetre_)

		' Transferer le handle
		CPC__GUI_Init_obj = _Proprietes.TEMP_GUI__LISTBOX.Identification_Objet.handle
	end if
	
	ScreenUnlock
End Function

Function _SCI_Cpcdos_OSx__.CPC__GUI_SUPPRIMER_bitmaps_fenetre(_INDEX_FENETRE_ as integer, clean_memory as boolean, reset_id as boolean, objets as boolean) as Integer
	' permet de supprimer tous les bitmaps d'une fenetre
	
	dim compteur as integer = 0
	IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
		IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
			DEBUG("[IUG] Suppression des bitmaps de la fenetre '" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.Nom & "' (Handle:" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.Handle & " PID:" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.PID_PARENT & ") ...", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
		Else
			DEBUG("[GUI] Deleting window bitmaps '" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.Nom & "' (Handle:" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.Handle & " PID:" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.PID_PARENT & ") ...", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
		End if
	End if
	
	' Suppression des bitmaps de la fenetre
	if clean_memory = true then
		'compteur += CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP_byhandle(this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.Handle)
		
		' CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).BT_CLOSE_IMG_ID)
		' CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).BT_CLOSE_ORG_IMG_ID)
		' CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).ICONE_IMG_ID)
		' CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).ICONE_ORG_IMG_ID)
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).TITRE_IMG_ID)	
	end if
	
	' remise a zero des ID 
	if reset_id = true then
		' this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).BT_CLOSE_IMG_ID = 0
		' this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).BT_CLOSE_ORG_IMG_ID = 0
		' this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).BT_SIZEUP_IMG_ID = 0
		' this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).BT_SIZEDOWN_IMG_ID = 0
		' this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).BT_SIZEDOWN_IMG_ORG_ID = 0
		' this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).BT_REDUCT_IMG_ID = 0
		' this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).BT_REDUCT_IMG_ORG_ID = 0
		' this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).ICONE_IMG_ID = 0
		' this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).ICONE_ORG_IMG_ID = 0
		this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).TITRE_IMG_ID = 0
	end if
	
	return compteur
End function

Function _SCI_Cpcdos_OSx__.CPC__GUI_SUPPRIMER_fenetre(_INDEX_FENETRE_ as integer) as Integer
	
	' Evenement WindowClosing
	Dim Fichier_Event as String
	Dim Fenetre_Nom as String
	Dim Fenetre_CLE as double
	
	if NOT this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Fichier_evenement = "" Then
		Fichier_Event = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Fichier_evenement
		Fenetre_Nom = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.Nom
		Fenetre_CLE = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet._CLE_
		CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_Event & _
						":=##/F:" & Fenetre_Nom & ".WindowClosing()", Fenetre_CLE , 2, 0, "")
	End if
	
	ScreenLock
	
	IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
		IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
			DEBUG("[IUG] Suppression de la fenetre '" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.Nom & "' (Handle:" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.Handle & " PID:" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.PID_PARENT & ") par une action utilisateur ...", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
		Else
			DEBUG("[GUI] Deleting window '" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.Nom & "' (Handle:" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.Handle & " PID:" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.PID_PARENT & ") by user action ...", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
		End if
	End if
	
	
	
	' Supprimer l'objet concerne
	CPC__GUI_SUPPRIMER_fenetre = CPCDOS_INSTANCE.SCI_INSTANCE.CPC__GUI_SUPPRIMER_obj(this.GUI_TYPE.Fenetre, _INDEX_FENETRE_)
	
	' Si l'interface graphique est executee
	IF CPCDOS_INSTANCE.SCI_INSTANCE.GUI_Mode = TRUE Then
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[IUG]  Actualisation graphique ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
			Else
				DEBUG("[GUI] Graphic actualisation", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
			End if
		End if
		
		
		' Et actualiser l'interface graphique
		CPCDOS_INSTANCE.SCI_INSTANCE.ActualiserGUI(0, 0)
	End if
	
	ScreenUnLock

	' Evenement WindowClosed
	if NOT Fichier_Event = "" Then
		CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_Event & _
						":=##/F:" & Fenetre_Nom & ".WindowClosed()", Fenetre_CLE , 2, 0, "")
	End if

End function


Function _SCI_Cpcdos_OSx__.CPC__GUI_SUPPRIMER_obj(Type_De_GUI as Integer, _INDEX_ as integer) as Integer
	REM Cette fonction permet de supprimer un objet graphique/Proprietes de la memoire 
	' supprimer aussi de l'ordre fenetrale

	IF Type_De_GUI = this.GUI_TYPE.Fenetre Then
		IF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.Nom = "" Then Exit function
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[SCI] Suppression de la fenetre '" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.Nom & "' handle:" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.handle & " CleID:'" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet._CLE_ & "' associe au processus '" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.Proc_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.TID_PARENT & " handle:" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.Handle_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
				if this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS > 0 Then
					DEBUG("[SCI] Suppression de(s) " & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS & " objets instancies(s)...", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
				End if
			Else
				DEBUG("[SCI] Deleting window '" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).TITRE & "' handle:" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.handle & " CleID:'" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet._CLE_ & "' associe au processus '" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.Proc_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.TID_PARENT & " handle:" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.Handle_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
				if this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS > 0 Then
					DEBUG("[SCI] Deleting " & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS & " instancied objects...", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
				End if
			End if

			' Si c'etait une fenetre prioritaire, on la delete
			if CPCDOS_INSTANCE.SCI_INSTANCE.priority_window = _INDEX_ Then CPCDOS_INSTANCE.SCI_INSTANCE.priority_window = 0
			
			' On s'assure qu'elle ne reviendra pas!
			this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).PROP_TYPE.IsPriority = false

			' Suppression des bitmaps
			CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).BT_CLOSE_IMG_ID)
			this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).BT_CLOSE_IMG_ID = 0
			CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).BT_CLOSE_ORG_IMG_ID)
			this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).BT_CLOSE_ORG_IMG_ID = 0
			
			CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).ICONE_IMG_ID)
			this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).ICONE_IMG_ID = 0
			CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).ICONE_ORG_IMG_ID)
			this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).ICONE_ORG_IMG_ID = 0
			
			CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).TITRE_IMG_ID)
			this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).TITRE_IMG_ID = 0
		End if

		
		if this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS > 0 Then
			For Boucle as integer = 1 to CPCDOS_INSTANCE._MAX_GUI___OBJS
				IF this.INST_INIT_GUI.GUI__BOUTON(Boucle).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.handle Then
					CPC__GUI_SUPPRIMER_obj(this.GUI_TYPE.Bouton, Boucle)

					' Desincrementer le nombre d'objets present dans la fenetre parent
					this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS - 1
				End if
				IF this.INST_INIT_GUI.GUI__PICTUREBOX(Boucle).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.handle Then
					CPC__GUI_SUPPRIMER_obj(this.GUI_TYPE.PictureBox, Boucle)
					
					' Desincrementer le nombre d'objets present dans la fenetre parent
					this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS - 1
				End if
				IF this.INST_INIT_GUI.GUI__TEXTBLOCK(Boucle).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.handle Then
					CPC__GUI_SUPPRIMER_obj(this.GUI_TYPE.TextBlock, Boucle)
					
					' Desincrementer le nombre d'objets present dans la fenetre parent
					this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS - 1
				End if
				IF this.INST_INIT_GUI.GUI__TEXTBOX(Boucle).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.handle Then
					CPC__GUI_SUPPRIMER_obj(this.GUI_TYPE.TextBox, Boucle)
					
					' Desincrementer le nombre d'objets present dans la fenetre parent
					this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS - 1
				End if
				IF this.INST_INIT_GUI.GUI__PROGRESSBAR(Boucle).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.handle Then
					CPC__GUI_SUPPRIMER_obj(this.GUI_TYPE.ProgressBar, Boucle)
					
					' Desincrementer le nombre d'objets present dans la fenetre parent
					this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS - 1
				End if
				IF this.INST_INIT_GUI.GUI__CHECKBOX(Boucle).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.handle Then
					CPC__GUI_SUPPRIMER_obj(this.GUI_TYPE.CheckBox, Boucle)
					
					' Desincrementer le nombre d'objets present dans la fenetre parent
					this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS - 1
				End if
				IF this.INST_INIT_GUI.GUI__EXPLORER(Boucle).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.handle Then
					CPC__GUI_SUPPRIMER_obj(this.GUI_TYPE.Explorer, Boucle)
					
					' Desincrementer le nombre d'objets present dans la fenetre parent
					this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS - 1
				End if
				IF this.INST_INIT_GUI.GUI__LISTBOX(Boucle).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.handle Then
					CPC__GUI_SUPPRIMER_obj(this.GUI_TYPE.Listbox, Boucle)
					
					' Desincrementer le nombre d'objets present dans la fenetre parent
					this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Nombre_OBJETS - 1
				End if
			Next Boucle
		End if
		
		For index_free as integer = 1 to CPCDOS_INSTANCE._MAX_GUI___OBJS
			this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Ordre_OBJETS(index_free) = ""
		Next index_free
	
		
		Dim PID_Fenetre 		as integer 	= this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.PID_PARENT
		Dim TID_Fenetre 		as integer 	= this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.TID_PARENT
		Dim Handle_Fenetre 		as integer 	= this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.Handle_PARENT
		Dim CLE_Fenetre 		as Double 	= this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet._CLE_
		Dim NomFenetre 			as String 	= this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.Nom
		Dim PROC_Fenetre 		as String 	= this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.Proc_PARENT
		
		' Vider toutes les proprietes de la fenetre
		this.INST_INIT_GUI.GUI__FENETRE(_INDEX_)			= this.NULL_GUI__FENETRE
		
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[SCI] Suppression de la fenetre '" & NomFenetre & "' CleID:" & CLE_Fenetre & " associe au processus '" & PROC_Fenetre & "' (PID:" & PID_Fenetre & " handle:" & Handle_Fenetre & ") [OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[SCI] Deleting window '" & NomFenetre & "' KeyID:" & CLE_Fenetre & " associed to the process '" & PROC_Fenetre & "' (PID:" & PID_Fenetre & " handle:" & Handle_Fenetre & ") [OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if
		
		' Elements a actualiser
		' IF CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__FENETRE(_INDEX_).IUG_UPDATER > 0 Then 
			' CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.RefreshGUI_Elements_FENETRE -= 1
		' End if
		
		' Suppression des bitmaps
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).BT_CLOSE_IMG_ID)
		this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).BT_CLOSE_IMG_ID = 0
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).BT_CLOSE_ORG_IMG_ID)
		this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).BT_CLOSE_ORG_IMG_ID = 0
		
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).ICONE_IMG_ID)
		this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).ICONE_IMG_ID = 0
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).ICONE_ORG_IMG_ID)
		this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).ICONE_ORG_IMG_ID = 0
		
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).TITRE_IMG_ID)
		this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).TITRE_IMG_ID = 0
		
	
	ELSEIF Type_De_GUI = this.GUI_TYPE.Bouton Then
		
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[SCI] Suppression du bouton '" & this.INST_INIT_GUI.GUI__BOUTON(_INDEX_).Identification_Objet.Nom & "' CleID:'" & this.INST_INIT_GUI.GUI__BOUTON(_INDEX_).Identification_Objet._CLE_ & "' associe a la fenetre '" & this.INST_INIT_GUI.GUI__BOUTON(_INDEX_).Identification_Objet.Fenetre_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__BOUTON(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__BOUTON(_INDEX_).Identification_Objet.TID_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.NoCRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[SCI] Deleting button '" & this.INST_INIT_GUI.GUI__BOUTON(_INDEX_).Identification_Objet.Nom & "' KeyID:'" & this.INST_INIT_GUI.GUI__BOUTON(_INDEX_).Identification_Objet._CLE_ & "' associed to the window'" & this.INST_INIT_GUI.GUI__BOUTON(_INDEX_).Identification_Objet.Fenetre_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__BOUTON(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__BOUTON(_INDEX_).Identification_Objet.TID_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.NoCRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if
		
		' Elements a actualiser
		IF CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__BOUTON(_index_).IUG_UPDATER > 0 Then 
			CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.RefreshGUI_Elements_BOUTON -= 1
		End if
		
		' Supprimer les anciennes images!
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__BOUTON(_index_).IMG_ID)
		this.INST_INIT_GUI.GUI__BOUTON(_index_).IMG_ID = 0
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__BOUTON(_index_).IMG_ORG_ID)
		this.INST_INIT_GUI.GUI__BOUTON(_index_).IMG_ORG_ID = 0
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__BOUTON(_index_).IMG_SURVOLE_ID)
		this.INST_INIT_GUI.GUI__BOUTON(_index_).IMG_SURVOLE_ID = 0
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__BOUTON(_index_).IMG_SURVOLE_ORG_ID)
		this.INST_INIT_GUI.GUI__BOUTON(_index_).IMG_SURVOLE_ORG_ID = 0
		
		' Vider toutes les proprietes du bouton
		this.INST_INIT_GUI.GUI__BOUTON(_INDEX_)				= this.NULL_GUI__BOUTON
		
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if
	ELSEIF Type_De_GUI = this.GUI_TYPE.PictureBox Then
	
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[SCI] Suppression de l'imagebox '" & this.INST_INIT_GUI.GUI__PICTUREBOX(_INDEX_).Identification_Objet.Nom & "' CleID:'" & this.INST_INIT_GUI.GUI__PICTUREBOX(_INDEX_).Identification_Objet._CLE_ & "' associe a la fenetre '" & this.INST_INIT_GUI.GUI__PICTUREBOX(_INDEX_).Identification_Objet.Proc_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__PICTUREBOX(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__BOUTON(_INDEX_).Identification_Objet.TID_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.NoCRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[SCI] Deleting picturebox '" & this.INST_INIT_GUI.GUI__PICTUREBOX(_INDEX_).Identification_Objet.Nom & "' KeyID:'" & this.INST_INIT_GUI.GUI__PICTUREBOX(_INDEX_).Identification_Objet._CLE_ & "' associed to the window'" & this.INST_INIT_GUI.GUI__PICTUREBOX(_INDEX_).Identification_Objet.Proc_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__PICTUREBOX(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__BOUTON(_INDEX_).Identification_Objet.TID_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.NoCRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if
		
		' Elements a actualiser
		IF CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__PICTUREBOX(_index_).IUG_UPDATER > 0 Then 
			CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.RefreshGUI_Elements_PICTUREBOX -= 1
		End if
		
		' Suppression des bitmaps
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__PICTUREBOX(_index_).IMG_ID)
		this.INST_INIT_GUI.GUI__PICTUREBOX(_index_).IMG_ID = 0
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__PICTUREBOX(_index_).IMG_ORG_ID)
		this.INST_INIT_GUI.GUI__PICTUREBOX(_index_).IMG_ORG_ID = 0
		
		' Vider toutes les proprietes du picturebox
		this.INST_INIT_GUI.GUI__PICTUREBOX(_INDEX_)			= this.NULL_GUI__PICTUREBOX
		
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if
		
	ELSEIF Type_De_GUI = this.GUI_TYPE.TextBlock Then
		
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[SCI] Suppression du textebloc '" & this.INST_INIT_GUI.GUI__TEXTBLOCK(_INDEX_).Identification_Objet.Nom & "' CleID:'" & this.INST_INIT_GUI.GUI__TEXTBLOCK(_INDEX_).Identification_Objet._CLE_ & "' associe a la fenetre '" & this.INST_INIT_GUI.GUI__TEXTBLOCK(_INDEX_).Identification_Objet.Proc_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__TEXTBLOCK(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__TEXTBLOCK(_INDEX_).Identification_Objet.TID_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.NoCRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[SCI] Deleting textblock '" & this.INST_INIT_GUI.GUI__TEXTBLOCK(_INDEX_).Identification_Objet.Nom & "' KeyID:'" & this.INST_INIT_GUI.GUI__TEXTBLOCK(_INDEX_).Identification_Objet._CLE_ & "' associed to the window'" & this.INST_INIT_GUI.GUI__TEXTBLOCK(_INDEX_).Identification_Objet.Proc_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__TEXTBLOCK(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__TEXTBLOCK(_INDEX_).Identification_Objet.TID_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.NoCRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if

		' Elements a rafraichir 
		IF CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__TEXTBLOCK(_index_).IUG_UPDATER > 0 Then 
			CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.RefreshGUI_Elements_TEXTBLOCK -= 1
		End if
		
		' Vider toutes les proprietes du textblock
		this.INST_INIT_GUI.GUI__TEXTBLOCK(_INDEX_)			= this.NULL_GUI__TEXTBLOCK
		
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if
	ELSEIF Type_De_GUI = this.GUI_TYPE.TextBox Then
	
		
		
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[SCI] Suppression du textebox '" & this.INST_INIT_GUI.GUI__TEXTBOX(_INDEX_).Identification_Objet.Nom & "' CleID:'" & this.INST_INIT_GUI.GUI__TEXTBOX(_INDEX_).Identification_Objet._CLE_ & "' associe a la fenetre '" & this.INST_INIT_GUI.GUI__TEXTBOX(_INDEX_).Identification_Objet.Proc_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__TEXTBOX(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__TEXTBOX(_INDEX_).Identification_Objet.TID_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.NoCRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[SCI] Deleting textbox '" & this.INST_INIT_GUI.GUI__TEXTBOX(_INDEX_).Identification_Objet.Nom & "' KeyID:'" & this.INST_INIT_GUI.GUI__TEXTBOX(_INDEX_).Identification_Objet._CLE_ & "' associed to the window'" & this.INST_INIT_GUI.GUI__TEXTBOX(_INDEX_).Identification_Objet.Proc_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__TEXTBOX(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__TEXTBOX(_INDEX_).Identification_Objet.TID_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.NoCRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if
		
		' Elements a actualiser
		IF CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__TEXTBOX(_index_).IUG_UPDATER > 0 Then 
			CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.RefreshGUI_Elements_TEXTBOX -= 1
		End if
		
		' Suppression des bitmaps
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__TEXTBOX(_index_).IMG_ID)
		this.INST_INIT_GUI.GUI__TEXTBOX(_index_).IMG_ID = 0
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__TEXTBOX(_index_).IMG_ORG_ID)
		this.INST_INIT_GUI.GUI__TEXTBOX(_index_).IMG_ORG_ID = 0
		
		
		' Vider toutes les proprietes du textbox
		this.INST_INIT_GUI.GUI__TEXTBOX(_INDEX_)			= this.NULL_GUI__TEXTBOX
		
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if
	ElseIF Type_De_GUI = this.GUI_TYPE.ProgressBar Then
	
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[SCI] Suppression de la barre de progression '" & this.INST_INIT_GUI.GUI__PROGRESSBAR(_INDEX_).Identification_Objet.Nom & "' CleID:'" & this.INST_INIT_GUI.GUI__PROGRESSBAR(_INDEX_).Identification_Objet._CLE_ & "' associe a la fenetre '" & this.INST_INIT_GUI.GUI__PROGRESSBAR(_INDEX_).Identification_Objet.Proc_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__PROGRESSBAR(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__PROGRESSBAR(_INDEX_).Identification_Objet.TID_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.NoCRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[SCI] Deleting progress bar '" & this.INST_INIT_GUI.GUI__PROGRESSBAR(_INDEX_).Identification_Objet.Nom & "' KeyID:'" & this.INST_INIT_GUI.GUI__PROGRESSBAR(_INDEX_).Identification_Objet._CLE_ & "' associed to the window'" & this.INST_INIT_GUI.GUI__PROGRESSBAR(_INDEX_).Identification_Objet.Proc_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__PROGRESSBAR(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__PROGRESSBAR(_INDEX_).Identification_Objet.TID_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.NoCRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if
		
		' Elements a actualiser
		IF CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__PROGRESSBAR(_index_).IUG_UPDATER > 0 Then 
			CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.RefreshGUI_Elements_PROGRESSBAR -= 1
		End if
		
		' Suppression des bitmaps
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__PROGRESSBAR(_index_).IMG_ID)
		this.INST_INIT_GUI.GUI__PROGRESSBAR(_index_).IMG_ID = 0
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__PROGRESSBAR(_index_).IMG_prog_ID)
		this.INST_INIT_GUI.GUI__PROGRESSBAR(_index_).IMG_prog_ID = 0
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__PROGRESSBAR(_index_).IMG_ORG_ID)
		this.INST_INIT_GUI.GUI__PROGRESSBAR(_index_).IMG_ORG_ID = 0
		
		' Vider toutes les proprietes de la PROGRESSBAR
		this.INST_INIT_GUI.GUI__PROGRESSBAR(_INDEX_)			= this.NULL_GUI__PROGRESSBAR
		
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if
	ElseIF Type_De_GUI = this.GUI_TYPE.CheckBox Then
	
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[SCI] Suppression du CheckBox '" & this.INST_INIT_GUI.GUI__CHECKBOX(_INDEX_).Identification_Objet.Nom & "' CleID:'" & this.INST_INIT_GUI.GUI__CHECKBOX(_INDEX_).Identification_Objet._CLE_ & "' associe a la fenetre '" & this.INST_INIT_GUI.GUI__PICTUREBOX(_INDEX_).Identification_Objet.Proc_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__CHECKBOX(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__CHECKBOX(_INDEX_).Identification_Objet.TID_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.NoCRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[SCI] Deleting checkbox '" & this.INST_INIT_GUI.GUI__CHECKBOX(_INDEX_).Identification_Objet.Nom & "' KeyID:'" & this.INST_INIT_GUI.GUI__CHECKBOX(_INDEX_).Identification_Objet._CLE_ & "' associed to the window'" & this.INST_INIT_GUI.GUI__PICTUREBOX(_INDEX_).Identification_Objet.Proc_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__CHECKBOX(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__CHECKBOX(_INDEX_).Identification_Objet.TID_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.NoCRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if
		
		' Elements a actualiser
		IF CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__CHECKBOX(_index_).IUG_UPDATER > 0 Then 
			CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.RefreshGUI_Elements_CHECKBOX -= 1
		End if
		
		' Suppression des bitmaps
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__CHECKBOX(_index_).IMG_ID)
		this.INST_INIT_GUI.GUI__CHECKBOX(_index_).IMG_ID = 0
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__CHECKBOX(_index_).IMG_fond_ID)
		this.INST_INIT_GUI.GUI__CHECKBOX(_index_).IMG_fond_ID = 0
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__CHECKBOX(_index_).IMG_ORG_ID)
		this.INST_INIT_GUI.GUI__CHECKBOX(_index_).IMG_ORG_ID = 0
		
		
		' Vider toutes les proprietes de la PROGRESSBAR
		this.INST_INIT_GUI.GUI__CHECKBOX(_INDEX_)			= this.NULL_GUI__CHECKBOX
		
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if
	ELSEIF Type_De_GUI = this.GUI_TYPE.Explorer Then
		
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[SCI] Suppression du explorer '" & this.INST_INIT_GUI.GUI__EXPLORER(_INDEX_).Identification_Objet.Nom & "' CleID:'" & this.INST_INIT_GUI.GUI__EXPLORER(_INDEX_).Identification_Objet._CLE_ & "' associe a la fenetre '" & this.INST_INIT_GUI.GUI__EXPLORER(_INDEX_).Identification_Objet.Fenetre_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__EXPLORER(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__EXPLORER(_INDEX_).Identification_Objet.TID_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.NoCRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[SCI] Deleting explorer '" & this.INST_INIT_GUI.GUI__EXPLORER(_INDEX_).Identification_Objet.Nom & "' KeyID:'" & this.INST_INIT_GUI.GUI__EXPLORER(_INDEX_).Identification_Objet._CLE_ & "' associed to the window'" & this.INST_INIT_GUI.GUI__EXPLORER(_INDEX_).Identification_Objet.Fenetre_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__EXPLORER(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__EXPLORER(_INDEX_).Identification_Objet.TID_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.NoCRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if
		
		' Elements a actualiser
		IF CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__EXPLORER(_index_).IUG_UPDATER > 0 Then 
			CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.RefreshGUI_Elements_EXPLORER -= 1
		End if
		
		' Supprimer les anciennes images!
		if this.INST_INIT_GUI.GUI__EXPLORER(_index_).NB_ICONE > 0 Then
			' Delete les icones 1 par 1
			For ico_index as integer = 0 to this.INST_INIT_GUI.GUI__EXPLORER(_index_).NB_ICONE -1
				CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__EXPLORER(_index_).IMG_ICONE_ID(ico_index))
				this.INST_INIT_GUI.GUI__EXPLORER(_index_).IMG_ICONE_ID(ico_index) = 0
			Next ico_index
		End if
		
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__EXPLORER(_index_).IMG_BUFFER_ID)
		this.INST_INIT_GUI.GUI__EXPLORER(_index_).IMG_BUFFER_ID = 0
		
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__EXPLORER(_index_).IMG_SELECTEUR_ID)
		this.INST_INIT_GUI.GUI__EXPLORER(_index_).IMG_SELECTEUR_ID = 0

		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__EXPLORER(_index_).IMG_SCROLL_ID)
		this.INST_INIT_GUI.GUI__EXPLORER(_index_).IMG_SCROLL_ID = 0

		
		
		
		' Vider toutes les proprietes du bouton
		this.INST_INIT_GUI.GUI__EXPLORER(_INDEX_)				= this.NULL_GUI__EXPLORER
		
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if
	ELSEIF Type_De_GUI = this.GUI_TYPE.Listbox Then
		
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[SCI] Suppression du listbox '" & this.INST_INIT_GUI.GUI__LISTBOX(_INDEX_).Identification_Objet.Nom & "' CleID:'" & this.INST_INIT_GUI.GUI__LISTBOX(_INDEX_).Identification_Objet._CLE_ & "' associe a la fenetre '" & this.INST_INIT_GUI.GUI__LISTBOX(_INDEX_).Identification_Objet.Fenetre_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__LISTBOX(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__LISTBOX(_INDEX_).Identification_Objet.TID_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.NoCRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[SCI] Deleting listbox '" & this.INST_INIT_GUI.GUI__LISTBOX(_INDEX_).Identification_Objet.Nom & "' KeyID:'" & this.INST_INIT_GUI.GUI__LISTBOX(_INDEX_).Identification_Objet._CLE_ & "' associed to the window'" & this.INST_INIT_GUI.GUI__LISTBOX(_INDEX_).Identification_Objet.Fenetre_PARENT & "' (PID:" & this.INST_INIT_GUI.GUI__LISTBOX(_INDEX_).Identification_Objet.PID_PARENT & " TID:" & this.INST_INIT_GUI.GUI__LISTBOX(_INDEX_).Identification_Objet.TID_PARENT & ") ... ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.NoCRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if
		
		' Elements a actualiser
		IF CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__LISTBOX(_index_).IUG_UPDATER > 0 Then 
			CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.RefreshGUI_Elements_LISTBOX -= 1
		End if
		
		' Supprimer les anciennes images!
		if this.INST_INIT_GUI.GUI__LISTBOX(_index_).NB_ICONE > 0 Then
			' Delete les icones 1 par 1
			For ico_index as integer = 0 to this.INST_INIT_GUI.GUI__LISTBOX(_index_).NB_ICONE -1
				CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__LISTBOX(_index_).IMG_ICONE_ID(ico_index))
				this.INST_INIT_GUI.GUI__LISTBOX(_index_).IMG_ICONE_ID(ico_index) = 0
			Next ico_index
		End if
		
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__LISTBOX(_index_).IMG_BUFFER_ID)
		this.INST_INIT_GUI.GUI__LISTBOX(_index_).IMG_BUFFER_ID = 0
		
		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__LISTBOX(_index_).IMG_SELECTEUR_ID)
		this.INST_INIT_GUI.GUI__LISTBOX(_index_).IMG_SELECTEUR_ID = 0

		CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Supprimer_BITMAP(this.INST_INIT_GUI.GUI__LISTBOX(_index_).IMG_SCROLL_ID)
		this.INST_INIT_GUI.GUI__LISTBOX(_index_).IMG_SCROLL_ID = 0

		
		
		
		' Vider toutes les proprietes du bouton
		this.INST_INIT_GUI.GUI__LISTBOX(_INDEX_)				= this.NULL_GUI__LISTBOX
		
		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
			IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
				DEBUG("[OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			Else
				DEBUG("[OK]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.SansDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, RetourVAR)
			End if
		End if
	End if
	
	CPC__GUI_SUPPRIMER_obj = 1
End Function

Function _SCI_Cpcdos_OSx__.get_Emplacement_Libre(Type_De_GUI as integer) as integer
	REM Cette fonction permet d'obtenir un emplacement memoire de type 'index'
	REM  afin de creer un objet
	
	IF Type_De_GUI = this.GUI_TYPE.Fenetre Then
		For _INDEX_ as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_FENETRE
			' Si aucun nom de processus est specifie alors l'emplacement est libre
			IF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_).Identification_Objet.Handle = 0 Then
				get_Emplacement_Libre = _INDEX_
				exit function
			End if
		Next _INDEX_
	Elseif Type_De_GUI = this.GUI_TYPE.Bouton Then
		For _INDEX_ as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_BOUTON
			' Si aucun nom de processus est specifie alors l'emplacement est libre
			IF this.INST_INIT_GUI.GUI__BOUTON(_INDEX_).Identification_Objet.Handle = 0 Then
				get_Emplacement_Libre = _INDEX_
				exit function
			End if
		Next _INDEX_
	Elseif Type_De_GUI = this.GUI_TYPE.PictureBox Then
		For _INDEX_ as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_PICTUREBOX
			' Si aucun nom de processus est specifie alors l'emplacement est libre
			IF this.INST_INIT_GUI.GUI__PICTUREBOX(_INDEX_).Identification_Objet.Handle = 0 Then
				get_Emplacement_Libre = _INDEX_
				exit function
			End if
		Next _INDEX_
	Elseif Type_De_GUI = this.GUI_TYPE.TextBlock Then
		For _INDEX_ as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_TEXTBLOCK
			' Si aucun nom de processus est specifie alors l'emplacement est libre
			IF this.INST_INIT_GUI.GUI__TEXTBLOCK(_INDEX_).Identification_Objet.Handle = 0 Then
				get_Emplacement_Libre = _INDEX_
				exit function
			End if
		Next _INDEX_
	Elseif Type_De_GUI = this.GUI_TYPE.TextBox Then
		For _INDEX_ as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_TEXTBOX
			' Si aucun nom de processus est specifie alors l'emplacement est libre
			IF this.INST_INIT_GUI.GUI__TEXTBOX(_INDEX_).Identification_Objet.Handle = 0 Then
				get_Emplacement_Libre = _INDEX_
				exit function
			End if
		Next _INDEX_
	Elseif Type_De_GUI = this.GUI_TYPE.ProgressBar Then
		For _INDEX_ as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_PROGRESSBAR
			' Si aucun nom de processus est specifie alors l'emplacement est libre
			IF this.INST_INIT_GUI.GUI__PROGRESSBAR(_INDEX_).Identification_Objet.Handle = 0 Then
				get_Emplacement_Libre = _INDEX_
				exit function
			End if
		Next _INDEX_
	Elseif Type_De_GUI = this.GUI_TYPE.CheckBox Then
		For _INDEX_ as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_PROGRESSBAR
			' Si aucun nom de processus est specifie alors l'emplacement est libre
			IF this.INST_INIT_GUI.GUI__CHECKBOX(_INDEX_).Identification_Objet.Handle = 0 Then
				get_Emplacement_Libre = _INDEX_
				exit function
			End if
		Next _INDEX_
	Elseif Type_De_GUI = this.GUI_TYPE.Explorer Then
		For _INDEX_ as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_EXPLORER
			' Si aucun nom de processus est specifie alors l'emplacement est libre
			IF this.INST_INIT_GUI.GUI__EXPLORER(_INDEX_).Identification_Objet.Handle = 0 Then
				get_Emplacement_Libre = _INDEX_
				exit function
			End if
		Next _INDEX_
	Elseif Type_De_GUI = this.GUI_TYPE.Listbox Then
		For _INDEX_ as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_LISTBOX
			' Si aucun nom de processus est specifie alors l'emplacement est libre
			IF this.INST_INIT_GUI.GUI__LISTBOX(_INDEX_).Identification_Objet.Handle = 0 Then
				get_Emplacement_Libre = _INDEX_
				exit function
			End if
		Next _INDEX_
	End if
	
	get_Emplacement_Libre = 0
End function

Function _SCI_Cpcdos_OSx__.get_NombreOSenCours() as integer
	' Cette fonction permet de connaitre le nombre d'OS en cours
	
	get_NombreOSenCours = this.NombreOSEnCours
	
End Function

Sub _SCI_Cpcdos_OSx__.set_NombreOSenCours(Nombre as Integer)
	' Cette fonction permet de connaitre le nombre d'OS en cours
	
	This.NombreOSEnCours = Nombre
	
End Sub

Function _SCI_Cpcdos_OSx__.get_CLE() as Double
	' Cette fonction permet de connaitre le nombre d'OS en cours
	
	get_CLE = this._CLE_
	
End Function

Sub _SCI_Cpcdos_OSx__.set_CLE(Nombre as Double)
	' Cette fonction permet de connaitre le nombre d'OS en cours
		
	Dim tmpOSID as integer
		
	This._CLE_ = Nombre
	
	' Recuperer le ID de l'OS depus le noyau
	tmpOSID = CPCDOS_INSTANCE.get_id_OS(Nombre)
	This.set_OSid(tmpOSID)
	
End Sub

Function _SCI_Cpcdos_OSx__.get_OSid() as integer
	' Cette fonction permet de connaitre le nombre d'OS en cours
	
	get_OSid = This.OS_id
	
End Function

Sub _SCI_Cpcdos_OSx__.set_OSid(Num_ID as integer)
	' Cette fonction permet de connaitre le nombre d'OS en cours
	
	This.OS_id = Num_ID
	
End Sub

Function _SCI_Cpcdos_OSx__.Interaction_SOURIS_FENETRE(Pos_X as integer, Pos_Y as integer, Type_Clic as integer) as integer
	' Cette fonction permet de savoir sur quelle fenetre l'utilisateur a clique
	' Renvoie le PID
	
	
	' Ce qui permet de savoir si on peut executer un ev si la souris est hors de la fenetre
	Dim EV_HorsFenetre as Boolean = false
	
	Dim Pret_Pour_Evenement 	as Boolean 	= FALSE
	Dim Evenement_Sur_Objet 	as Boolean 	= FALSE
	DIM _INDEX_FENETRE_ 		as integer
	Dim NoDeplacer				as Integer 	= 0
	Dim Index_Focus_OBJ 		as integer	= 0
	Dim _CLE_OBJ_ 				as Double 	= 0
	Dim Evenement_A_Executer 	as string 	= ""
	Dim Nom_Objet 				as String 	= ""
	Dim Fichier_evenement 		as String 	= ""

	

	For _INDEX_ as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_FENETRE
	
		 _INDEX_FENETRE_ = this.INST_INIT_GUI.POSITION(_INDEX_)

		' Sil y a fenetre prioritaire dans l'OS alors se fixer dessus
		IF CPCDOS_INSTANCE.SCI_INSTANCE.priority_window > 0 Then 
			IF CPCDOS_INSTANCE.SCI_INSTANCE.get_OSid() = this.INST_INIT_GUI.GUI__FENETRE(CPCDOS_INSTANCE.SCI_INSTANCE.priority_window).Identification_Objet.OS_id Then
				if NOT this.INST_INIT_GUI.GUI__FENETRE(CPCDOS_INSTANCE.SCI_INSTANCE.priority_window).Identification_Objet.Nom = "" Then
					this.INST_INIT_GUI.GUI__FENETRE(CPCDOS_INSTANCE.SCI_INSTANCE.priority_window).PROP_TYPE.Reduit = false
					_INDEX_FENETRE_ = CPCDOS_INSTANCE.SCI_INSTANCE.priority_window
				else
					CPCDOS_INSTANCE.SCI_INSTANCE.priority_window = 0
				End if
			else
					CPCDOS_INSTANCE.SCI_INSTANCE.priority_window = 0
			End if
		End if
		

		If this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Reduit = true Then Continue for

		
		
		IF CPCDOS_INSTANCE.SCI_INSTANCE.get_OSid() = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.OS_id Then
			' Sil y a une fenetre prioritaire. NE PLUS interagir avec les autres elements du bureau
			
			

			' Si la position de la souris est superieur au bord gauche ET inferieur au bord droit (Relatif a l'odre fenetrale)
			IF Pos_X >= this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X AND Pos_X < (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X) Then

				' Si la position de la souris est superieur au bord haut ET inferieur au bord bas (Relatif a l'odre fenetrale)
				IF Pos_Y >= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) AND Pos_Y < (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_Y) Then
					' L'utiliateur a clique dans la fenetre!

					
					
					IF (Type_Clic AND 1) OR (Type_Clic AND 2) OR (Type_Clic AND 4) Then

						

						' if ClicElementTaskBar = false Then
							if NOT _INDEX_FENETRE_ = CPCDOS_INSTANCE.SCI_INSTANCE.DESKTOPMODE_Index_Fenetre Then
								' Mettre cette fenetre au premier plan seulement en cas de clic :)
								IF NOT Fenetre_FOCUS(0) = _INDEX_FENETRE_ Then 
									Fenetre_FOCUS(_INDEX_FENETRE_)
									NoDeplacer = 1
								Else
									NoDeplacer = 0
								End if
							End if
						' End if


						Dim ClicElementTaskBar as boolean = false
						if this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.TaskBar > 0 Then
							if CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_clic = false Then

								CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_clic = true
								' On parourt tous les elements de la barre des taches jusqu'a tomber sur celui ou la souris se trouve.
								for indexage as integer = 0 to _MAX_Taskbar_Elements

									' S'il clique dans l'espace X
									if Pos_X > CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_px(indexage) AND Pos_X < (CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_px(indexage) + CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_sx(indexage)) Then

										' Puis dans l'espace Y
										if Pos_Y > CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_py(indexage) AND Pos_Y < (CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_py(indexage) + CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_sy(indexage)) Then
											' L'utilisateur a clique dans un element de la taskbar!

											ClicElementTaskBar = true

											if this.INST_INIT_GUI.GUI__FENETRE(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage)).PROP_TYPE.Reduit = true Then

												IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
													DEBUG("[SCI] Restauration de la fenetre (" & CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage) & ") '" & this.INST_INIT_GUI.GUI__FENETRE(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage)).Titre & "' depuis la barre des taches.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
												else
													DEBUG("[SCI] Window restauration (" & CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage) & ") '" & this.INST_INIT_GUI.GUI__FENETRE(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage)).Titre & "' from the taskbar. ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
												End if

												' Si elle etait pas focus, hop on la restaure!
												this.INST_INIT_GUI.GUI__FENETRE(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage)).PROP_TYPE.Reduit = false
												Fenetre_FOCUS(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage))

												ActualiserGUI(0, 0)

											Elseif this.INST_INIT_GUI.POSITION(2) = CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage) Then

												IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
													DEBUG("[SCI] Reduction de la fenetre (" & CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage) & ") '" & this.INST_INIT_GUI.GUI__FENETRE(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage)).Titre & "' dans la barre des taches.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
												else
													DEBUG("[SCI] Window minimization (" & CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage) & ") '" & this.INST_INIT_GUI.GUI__FENETRE(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage)).Titre & "' to the taskbar. ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
												End if

												' Si la fenetre est deja FOCUS et pas reduite
												' Hop on reduit la fenetre dans la barre des taches
												this.INST_INIT_GUI.GUI__FENETRE(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage)).PROP_TYPE.Reduit = true
												ActualiserGUI(0, 0)
											else
												IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
													DEBUG("[SCI] Focus de la fenetre (" & CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage) & ") '" & this.INST_INIT_GUI.GUI__FENETRE(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage)).Titre & "' dans la barre des taches.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
												else
													DEBUG("[SCI] Window focus (" & CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage) & ") '" & this.INST_INIT_GUI.GUI__FENETRE(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage)).Titre & "' to the taskbar. ", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
												End if

												' Focuser la fenetre
												Fenetre_FOCUS(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position(indexage))
												ActualiserGUI(0, 0)
											End if

											exit for

										End if
									End if
								Next Indexage
							End if
							if ClicElementTaskBar = true Then return 1
						End if


						
						if this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.TYPE_OBJ <= 3 Then
							if this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Fermable = true Then
								' ==== On ferme la fenetre par le bouton X ====
								
								IF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_CLOSE_POS = 3 Then ' Droite
									' X
									IF Pos_X >= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X - (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_CLOSE_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_CLOSE_X)) _
									AND Pos_X <= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X - this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_CLOSE_X) Then
										' Y
										IF Pos_Y >= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_CLOSE_Y) _
										AND Pos_Y <= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_CLOSE_Y) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_CLOSE_X Then
											
											' On supprime la fenetre
											CPCDOS_INSTANCE.SCI_INSTANCE.CPC__GUI_SUPPRIMER_fenetre(_INDEX_FENETRE_)
											NoDeplacer = 1
											this.CLIC_PRESS_TITLE = true
											return 1
										End if
									End if
								ElseIf this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_CLOSE_POS = 2 Then ' Centre
								
									' X
									IF Pos_X >= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X/2) - this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_CLOSE_X/2) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_CLOSE_X _
									AND Pos_X <= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X/2) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_CLOSE_X/2) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_CLOSE_X Then
										' Y
										IF Pos_Y >= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_CLOSE_Y) _
										AND Pos_Y <= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_CLOSE_Y) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_CLOSE_X Then
											
											' On supprime la fenetre
											CPCDOS_INSTANCE.SCI_INSTANCE.CPC__GUI_SUPPRIMER_fenetre(_INDEX_FENETRE_)
											NoDeplacer = 1
											this.CLIC_PRESS_TITLE = true
											return 1
										End if
									End if
								ElseIf this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_CLOSE_POS = 1 Then ' Gauche
								
									' X
									IF Pos_X >= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_CLOSE_X) _
									AND Pos_X <= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_CLOSE_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_CLOSE_X) Then
										' Y
										IF Pos_Y >= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_CLOSE_Y) _
										AND Pos_Y <= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_CLOSE_Y) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_CLOSE_X Then
											
											' On supprime la fenetre
											CPCDOS_INSTANCE.SCI_INSTANCE.CPC__GUI_SUPPRIMER_fenetre(_INDEX_FENETRE_)
											NoDeplacer = 1
											this.CLIC_PRESS_TITLE = true
											return 1
										End if
									End if
								End if
							end if
							
							' --------------------------------------------------------------------------------------------------
							
							if this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Sizeable = true Then
								if this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.SizeUP = false then
									' ==== On agrandit la fenetre par le bouton du milieu ====
									
									IF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEUP_POS = 3 Then ' Droite
										' X
										IF Pos_X >= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X - (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEUP_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_SIZEUP_X)) _
										AND Pos_X <= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X - this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEUP_X) Then
											' Y
											IF Pos_Y >= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEUP_Y) _
											AND Pos_Y <= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEUP_Y) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_SIZEUP_X Then
												
												' on agrandit la fenetre!
												Sizing_window_button(true, _INDEX_FENETRE_)
												NoDeplacer = 1
												this.CLIC_PRESS_TITLE = true
												return 1
											End if
										End if
									ElseIf this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEUP_POS = 2 Then ' Centre
									
										' X
										IF Pos_X >= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X/2) - this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_SIZEUP_X/2) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEUP_X _
										AND Pos_X <= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X/2) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_SIZEUP_X/2) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEUP_X Then
											' Y
											IF Pos_Y >= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEUP_Y) _
											AND Pos_Y <= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEUP_Y) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_SIZEUP_X Then
												
												' on agrandit la fenetre!
												Sizing_window_button(true, _INDEX_FENETRE_)
												NoDeplacer = 1
												this.CLIC_PRESS_TITLE = true
												return 1
											End if
										End if
									ElseIf this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEUP_POS = 1 Then ' Gauche
									
										' X
										IF Pos_X >= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEUP_X) _
										AND Pos_X <= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEUP_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_SIZEUP_X) Then
											' Y
											IF Pos_Y >= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEUP_Y) _
											AND Pos_Y <= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEUP_Y) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_SIZEUP_X Then
												
												' on agrandit la fenetre!
												Sizing_window_button(true, _INDEX_FENETRE_)
												NoDeplacer = 1
												this.CLIC_PRESS_TITLE = true
												return 1
											End if
										End if
									End if
								Else
									' --------------------------------------------------------------------------------------------------
									
									' ==== On retrecit la fenetre par le bouton du milieu ====
								
									IF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEDOWN_POS = 3 Then ' Droite
										' X
										IF Pos_X >= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X - (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEDOWN_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_SIZEDOWN_X)) _
										AND Pos_X <= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X - this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEDOWN_X) Then
											' Y
											IF Pos_Y >= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEDOWN_Y) _
											AND Pos_Y <= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEDOWN_Y) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_SIZEDOWN_X Then
												
												' on retrecit la fenetre!
												Sizing_window_button(false, _INDEX_FENETRE_)
												NoDeplacer = 1
												this.CLIC_PRESS_TITLE = true
												return 1
											End if
										End if
									ElseIf this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEDOWN_POS = 2 Then ' Centre
									
										' X
										IF Pos_X >= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X/2) - this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_SIZEDOWN_X/2) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEDOWN_X _
										AND Pos_X <= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X/2) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_SIZEDOWN_X/2) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEDOWN_X Then
											' Y
											IF Pos_Y >= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEDOWN_Y) _
											AND Pos_Y <= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEDOWN_Y) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_SIZEDOWN_X Then
												
												' on retrecit la fenetre!
												Sizing_window_button(false, _INDEX_FENETRE_)
												NoDeplacer = 1
												this.CLIC_PRESS_TITLE = true
												return 1
											End if
										End if
									ElseIf this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEDOWN_POS = 1 Then ' Gauche
									
										' X
										IF Pos_X >= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEDOWN_X) _
										AND Pos_X <= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEDOWN_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_SIZEDOWN_X) Then
											' Y
											IF Pos_Y >= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEDOWN_Y) _
											AND Pos_Y <= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_SIZEDOWN_Y) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_SIZEDOWN_X Then
												
												' on retrecit la fenetre!
												Sizing_window_button(false, _INDEX_FENETRE_)
												NoDeplacer = 1
												this.CLIC_PRESS_TITLE = true
												return 1
											End if
										End if
									End if
								End if
							End if 'if sizeable
							
							' --------------------------------------------------------------------------------------------------
							
							if this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Reductable = true Then
								' ==== On reduit la fenetre ====
								IF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_REDUCT_POS = 3 Then ' Droite
									' X
									IF Pos_X >= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X - (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_REDUCT_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_REDUCT_X)) _
									AND Pos_X <= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X - this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_REDUCT_X) Then
										' Y
										IF Pos_Y >= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_REDUCT_Y) _
										AND Pos_Y <= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_REDUCT_Y) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_REDUCT_X Then
											
											' on reduit la fenetre!
											IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
												IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
													DEBUG("[SCI] Reduction de la fenetre (" & _INDEX_FENETRE_ & ") '" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Titre & "' depuis bouton reduction, dans la barre des taches.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
												else
													DEBUG("[SCI] Window minimization (" & _INDEX_FENETRE_ & ") '" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Titre & "' from minimize button, to the taskbar.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
												End if
											End if
											' Si la fenetre est deja FOCUS et pas reduite
											' Hop on reduit la fenetre dans la barre des taches
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Reduit = true
											ActualiserGUI(0, 0)
											NoDeplacer = 1
											this.CLIC_PRESS_TITLE = true
											return 1
										End if
									End if
								ElseIf this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_REDUCT_POS = 2 Then ' Centre
								
									' X
									IF Pos_X >= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X/2) - this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_REDUCT_X/2) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_REDUCT_X _
									AND Pos_X <= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X/2) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_REDUCT_X/2) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_REDUCT_X Then
										' Y
										IF Pos_Y >= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_REDUCT_Y) _
										AND Pos_Y <= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_REDUCT_Y) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_REDUCT_X Then
											
											' on reduit la fenetre!
											IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
												IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
													DEBUG("[SCI] Reduction de la fenetre (" & _INDEX_FENETRE_ & ") '" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Titre & "' depuis bouton reduction, dans la barre des taches.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
												else
													DEBUG("[SCI] Window minimization (" & _INDEX_FENETRE_ & ") '" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Titre & "' from minimize button, to the taskbar.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
												End if
											End if
											' Si la fenetre est deja FOCUS et pas reduite
											' Hop on reduit la fenetre dans la barre des taches
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Reduit = true
											ActualiserGUI(0, 0)
											NoDeplacer = 1
											this.CLIC_PRESS_TITLE = true
											return 1
										End if
									End if
								ElseIf this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_REDUCT_POS = 1 Then ' Gauche
								
									' X
									IF Pos_X >= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_REDUCT_X) _
									AND Pos_X <= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_REDUCT_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_REDUCT_X) Then
										' Y
										IF Pos_Y >= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_REDUCT_Y) _
										AND Pos_Y <= ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_BT_REDUCT_Y) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_BT_REDUCT_X Then
											
											' on reduit la fenetre!
											IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
												IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
													DEBUG("[SCI] Reduction de la fenetre (" & _INDEX_FENETRE_ & ") '" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Titre & "' depuis bouton reduction, dans la barre des taches.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
												else
													DEBUG("[SCI] Window minimization (" & _INDEX_FENETRE_ & ") '" & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Titre & "' from minimize button, to the taskbar.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
												End if
											End if
											' Si la fenetre est deja FOCUS et pas reduite
											' Hop on reduit la fenetre dans la barre des taches
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Reduit = true
											ActualiserGUI(0, 0)
											NoDeplacer = 1
											this.CLIC_PRESS_TITLE = true
											return 1
										End if
									End if
								End if
							End if ' if reductable
						End if ' Si l'objet est de type 0, 1, 2, 3
					Else
						CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_clic = false
					End if

					
					if this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Sizeable_ANGL = true Then
						' L'utilisateur reste appuye sur la zone de resize
						IF Pos_X >= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X) - CPCDOS_INSTANCE.SYSTEME_INSTANCE.CURSEUR_Resize_zone_X AND Pos_X < (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_X) Then
							IF Pos_Y > ((this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y-this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_Y) - CPCDOS_INSTANCE.SYSTEME_INSTANCE.CURSEUR_Resize_zone_Y AND Pos_Y < (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y + this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_Y) Then
								Dim As integer Pos_X, Pos_Y, Scroll_Weel, TypeClic, Clip, Presente

								
								this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Sizeable_ANGL_display = true
								

								' Si l'utilisateur a encore le bouton presse = deplacement
								Presente = CPCDOS_INSTANCE.SYSTEME_INSTANCE.cpc_GetMouse(Pos_X, Pos_Y, Scroll_Weel, TypeClic, Clip)

								IF TypeClic = 1 Then ' Clic gauche
									
									ScreenLock
									ENTRER_SectionCritique()

									this.INST_INIT_GUI.REDIMENTIONNEMENT = _INDEX_FENETRE_
									
									
									' Retrecir la fenetre si agrandie
									if this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).PROP_TYPE.SizeUP = true Then
										'Sizing_window_button(false, this.INST_INIT_GUI.DEPLACEMENT)
										
										'Fenetre_FOCUS(this.INST_INIT_GUI.DEPLACEMENT)
									end if
									
									'this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).Siz_X = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).Pos_X - Pos_X
									'this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).Siz_Y = Pos_Y + this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).Pos_Y

									' Actualiser l'affichage derriere la fentre puis capturer dans un buffer
									ActualiserGUI(2, this.INST_INIT_GUI.REDIMENTIONNEMENT)
									
									SORTIR_SectionCritique()
									ScreenUnlock

									Flip 1, 2

									'this.INST_INIT_GUI.RELATIF_X = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.DEPLACEMENT).POS_X + this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.DEPLACEMENT).SIZ_X
									'this.INST_INIT_GUI.RELATIF_Y = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.DEPLACEMENT).POS_Y + this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.DEPLACEMENT).SIZ_Y
									
									
								Else

									' Flip 3, 1
									' ActualiserGUI(0, 0)
									this.INST_INIT_GUI.REDIMENTIONNEMENT = 0
									this.INST_INIT_GUI.RELATIF_X = 0
									this.INST_INIT_GUI.RELATIF_Y = 0
								End if

								exit for

							End if
						End if
					End if


					' Clic barre de titre
					If this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.TYPE_OBJ <= 3 AND _
						this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Deplacable = true AND _
						NoDeplacer = 0 AND _
						Pos_Y >= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y - this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).SIZ_TITRE) AND _
						Pos_Y <= (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y) Then

						Dim As integer Pos_X, Pos_Y, Scroll_Weel, TypeClic, Clip, Presente


						' doevents(0)

						' Si l'utilisateur a encore le bouton presse = deplacement
						Presente = CPCDOS_INSTANCE.SYSTEME_INSTANCE.cpc_GetMouse(Pos_X, Pos_Y, Scroll_Weel, TypeClic, Clip)

						ScreenLock
						ENTRER_SectionCritique()

						IF TypeClic = 1 Then ' Clic gauche
							this.INST_INIT_GUI.DEPLACEMENT = _INDEX_FENETRE_
							
							
							' Retrecir la fenetre si agrandie
							if this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.DEPLACEMENT).PROP_TYPE.SizeUP = true Then
								Sizing_window_button(false, this.INST_INIT_GUI.DEPLACEMENT)
								this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.DEPLACEMENT).POS_X = Pos_X - (this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.DEPLACEMENT).SIZ_X / 2)
								this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.DEPLACEMENT).POS_Y = Pos_Y - (this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.DEPLACEMENT).SIZ_TITRE/2)
								Fenetre_FOCUS(this.INST_INIT_GUI.DEPLACEMENT)
							end if
							
							
							' Actualiser l'affichage derriere la fentre puis capturer dans un buffer
							ActualiserGUI(2, this.INST_INIT_GUI.DEPLACEMENT)
							
							Flip 1, 2
							
							
							this.INST_INIT_GUI.RELATIF_X = Pos_X - this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.DEPLACEMENT).POS_X
							this.INST_INIT_GUI.RELATIF_Y = Pos_Y - this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.DEPLACEMENT).POS_Y
						elseif TypeClic = 2 Then

							IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
								DEBUG("[SCI] Right clic on title bar on " & this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).identification_objet.nom, CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
							End if

							' Creer menu contextuel
							CPCDOS_INSTANCE.SCI_INSTANCE.creer_ContextMenu(Pos_X - 1, Pos_Y - 1, this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.OBJ_context_menu)
							
							SORTIR_SectionCritique()
							ScreenUnlock

							this.CLIC_PRESS_TITLE = true

							return 1

						Else

							' Flip 3, 1
							' ActualiserGUI(0, 0)
							this.INST_INIT_GUI.DEPLACEMENT = 0
							this.INST_INIT_GUI.RELATIF_X = 0
							this.INST_INIT_GUI.RELATIF_Y = 0
						End if
						
						
						
						SORTIR_SectionCritique()
						ScreenUnlock
						
						' CORRECTION BUG 25-JAN-2020 :
						'	Fenetre arriere plan qui passait au dessus de la fenetre focus lors du clic 
						' 	sur la barre de titre
						Exit for 
						
			
					Else
						' Clic DANS la fenetre

						' Voir si la souris qui a clique se trouve dans un objet.
						'  la recherche s'effectue dans l'ordre de creation des objets,
						'  du plus recent au plus vieux, et selon le nombre d'objets present.
						
						
						Index_Focus_OBJ  		= 0
						_CLE_OBJ_ 		 		= 0
						Nom_Objet 				= ""
						Fichier_evenement 	 	= ""
						Pret_Pour_Evenement  	= FALSE
						Evenement_Sur_Objet  	= FALSE
						
						' **********************************************************
						' ** E V E N E M E N T S  O B J E T   G R A P H I Q U E S **
						' **********************************************************
						Dim _INDEX__ORDRE_OBJET as integer

						if this.CLIC_PRESS_TITLE = true Then return 1
						
						Dim NoExitFor_Loop as boolean = false
						
						For _IN_ORDR_OBJ_ as integer = 0 to this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Nombre_OBJETS

							_INDEX__ORDRE_OBJET = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Nombre_OBJETS - _IN_ORDR_OBJ_
							
							' *** Correctif crash trouve par Guillaume 21 JUIN 2019 (Ligne 1296 'Chercher le numero d'index') ***
							if _INDEX__ORDRE_OBJET < 1 OR _INDEX__ORDRE_OBJET > this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Nombre_OBJETS Then Exit for
							
							' Chercher le numero d'index
							IF NOT this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Ordre_OBJETS(_INDEX__ORDRE_OBJET) = "" Then

								DIM NomOrdreObjet as String = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Ordre_OBJETS(_INDEX__ORDRE_OBJET)
								
								DIM The_Objet 		as String = MID(NomOrdreObjet, 1, Instr(NomOrdreObjet, ":") - 1)
								DIM The_Objet_index as integer  = VAL(MID(NomOrdreObjet, Instr(NomOrdreObjet, ":") + 1))

								IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
									DEBUG("[SCI] Search GUI element " & The_Objet & "(" & The_Objet_index & ") Type_Clic:" & Type_Clic & ".", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
								end if
								
						
								' locate 1, 1
								' Color RGB(255,255,255), RGB(0, 0, 0)
					

								' **********************************
								' ** B O U T O N      B O U T O N ** ----------------------------------------------------
								' **********************************
								
								If The_Objet = "BOUTON" Then 
								
									Fichier_evenement  	= this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.Fichier_evenement
								
									if NOT Fichier_evenement = "" Then
									
										' Infos du picturebox concerne
										Index_Focus_OBJ 	= The_Objet_index
										_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).Identification_Objet._CLE_
										Nom_Objet 		 	= this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).Identification_Objet.Nom

										IF Interaction_TOUCHE(Pos_X, Pos_Y, _INDEX_FENETRE_, _
											this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).POS_X, _
											this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).POS_Y, _
											this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).SIZ_X, _
											this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).SIZ_Y) = TRUE Then
											
											Dim Retour_STR as String = ""
											
											' Pour pas que la fenetre soit aussi comprise
											Evenement_Sur_Objet = TRUE

											' *****************************************************************************************
											' *** EVENEMENT : Si l'utilisateur clique dans l'objet graphique avec sa souris (CLICK) ***
											' *****************************************************************************************
											
											IF (Type_Clic AND 1) OR (Type_Clic AND 2) OR (Type_Clic AND 3) Then

												' On indique qu'on FOCUS un bouton
												this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_TYPE = CPCDOS_INSTANCE.SCI_INSTANCE.GUI_TYPE.Bouton
												
												' Avec son index
												this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_INDEX = The_Objet_index
												
												this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.Pression = TRUE
												
												this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.Pression_Bouton = Type_Clic
												
												' Actualiser graphiquement le bouton pour l'effet de "pression"
												Creer_Bouton(The_Objet_index, _INDEX_FENETRE_)

												IF this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.EV_Click = True Then
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Click(1)") > 0 Then
														' Si l'utilisateur clique (bouton enfonce) avec nimporte quel bouton de la souris (Click) ou (Click(Valeur))
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																		":=##/F:" & Nom_Objet & ".Click(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																		= "ERR_050" Then
																			
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Click(1);"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Click(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														End if
													end if
													
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Click()") > 0 Then
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																		":=##/F:" & Nom_Objet & ".Click()", _CLE_OBJ_ , 2, 0, "") _
																		= "ERR_050" Then
																			
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Click();"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Click()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														End if
													End if
												End if	

												if Type_Clic AND 2 Then
													' Creer menu contextuel
													CPCDOS_INSTANCE.SCI_INSTANCE.creer_ContextMenu(Pos_X - 1, Pos_Y - 1, this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.OBJ_context_menu)
													
													return 1
												End if			

												' On quitte cette boucle
												exit for
											Else
											
												' *******************************************************************
												' *** EVENEMENT : Si l'utilisateur a finit de cliquer sur l'objet ***
												' *******************************************************************
												
												IF this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.Pression = TRUE Then
													this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.Pression = False
													
													
													
													' Actualiser graphiquement le bouton pour l'effet de "pression"
													Creer_Bouton(The_Objet_index, _INDEX_FENETRE_)
											
													IF this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.EV_MouseClick = True Then
													
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)") > 0 Then
															' Si l'utilisateur clique (bouton relache) avec nimporte quel bouton de la souris (MouseClick) ou (Click(Valeur))
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																			":=##/F:" & Nom_Objet & ".MouseClick(" & this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.Pression_Bouton & ")", _CLE_OBJ_ , 2, 0, "") _
																			= "ERR_050" Then
																			
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1);"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															End if
														End if

														
														
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick()") > 0 Then
															IF CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																			":=##/F:" & Nom_Objet & ".MouseClick()", _CLE_OBJ_ , 2, 0, "") _
																			= "ERR_050" Then
																			
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick();"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
																
															End if
														End if
													End if
												End if
											
												' *****************************************************************************************************
												' *** EVENEMENT : Si l'utilisateur ENTRE la souris dans l'objet pour la premiere fois (MouseEnter) ***
												' *****************************************************************************************************
												
												IF NOT this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.Fichier_evenement = "" Then
													IF this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.Survole = FALSE Then
													
														
														IF this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.EV_MouseEnter = True Then
															if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseEnter()") > 0 Then
																if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																		":=##/F:" & Nom_Objet & ".MouseEnter()", _CLE_OBJ_ , 2, 0, "") _
																		= "ERR_050" Then
																			
																	' Black LIST EVENT !
																	CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseEnter();"
																	IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																		DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseEnter()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																	End if
																	
																End if
															End if
														End if
														
														' L'objet est en cours de survole
														this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.Survole = TRUE
														
														this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = this.GUI_TYPE.Bouton
														this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = The_Objet_index
														
														' Actualiser graphiquement le bouton pour l'effet de "pression"
														Creer_Bouton(The_Objet_index, _INDEX_FENETRE_)
														
														' On quitte cette boucle
														exit for
														
													End if
												End if
												
												
												' *****************************************************************************
												' *** EVENEMENT : Si l'utilisateur se deplace DANS le controle (MouseMove) ***
												' *****************************************************************************
												
												IF NOT this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.Fichier_evenement = "" Then
													
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseMove()") > 0 Then
														IF this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.EV_MouseMove = True Then
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseMove()", _CLE_OBJ_ , 2, 0, "") _
																= "ERR_050" Then
																		
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseMove();"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseMove()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															End if
														End if
													End if
													
													
													' L'objet est en cours de survole
													this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.Survole = TRUE
													

													' On quitte cette boucle
													exit for
													
												End if
											End if
										End if
										
										' *******************************************************************
										' *** EVENEMENT : Si l'utilisateur a finit de cliquer sur l'objet ***
										' *******************************************************************
										
										IF this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.Pression = TRUE Then
											this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.Pression = False
											
											' Actualiser graphiquement le bouton pour l'effet de "pression"
											Creer_Bouton(The_Objet_index, _INDEX_FENETRE_)
									
											IF this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.EV_MouseClick = True Then
												' Si l'utilisateur clique (bouton relache) avec nimporte quel bouton de la souris (MouseClick) ou (Click(Valeur))
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseClick(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1);"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												End if
																
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick()") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseClick()", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick();"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												End if
											End if
										End if
										
										' *****************************************************************************
										' *** EVENEMENT : Si l'utilisateur SORT/Ne survole plus l'objet (MouseLeave) ***
										' *****************************************************************************
										
										IF this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.Survole = TRUE Then
											this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.Survole = False
											
											IF this.INST_INIT_GUI.GUI__BOUTON(The_Objet_index).PROP_TYPE.EV_MouseLeave = True Then
												
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()") > 0 Then
													' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseLeave()", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseLeave();"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												End if
											End if

											
											' Efface toutes traces
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = 0
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = 0
											
											' Actualiser graphiquement le bouton pour l'effet de "pression"
											Creer_Bouton(The_Objet_index, _INDEX_FENETRE_)
											
											' On quitte cette boucle
											exit for
										End if
									End if
									
									
								' ************************************************
								' ** P I C T U R E B O X    P I C T U R E B O X ** ----------------------------------------------------
								' ************************************************	
								
								ElseIF The_Objet = "PICTUREBOX" Then 

									' Ajouter MOUSE_ENTER --> Lors ce que la souris ENTRE dans l'objet
									' Ajouter quand on relache le bouton du clic
									' Ajouter quand on entre en restant CLIQU�
									' Ajouter quand sort en restant CLIQU�
									' Ajouter quand on est dedans et le bouton relach�
									
									Fichier_evenement  	= this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.Fichier_evenement
									
									if NOT Fichier_evenement = "" Then
										
										' Infos du picturebox concerne
										Index_Focus_OBJ 	= The_Objet_index
										_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).Identification_Objet._CLE_
										Nom_Objet 		 	= this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).Identification_Objet.Nom
								
										IF Interaction_TOUCHE(Pos_X, Pos_Y, _INDEX_FENETRE_, _
											this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).POS_X, _
											this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).POS_Y, _
											this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).SIZ_X, _
											this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).SIZ_Y) = TRUE Then
											
											' Pour pas que la fenetre soit aussi comprise
											Evenement_Sur_Objet = TRUE

											
											' *****************************************************************************************
											' *** EVENEMENT : Si l'utilisateur clique dans l'objet graphique avec sa souris (CLICK) ***
											' *****************************************************************************************
											
											IF (Type_Clic AND 1) OR (Type_Clic AND 2) OR (Type_Clic AND 3) Then

												' On indique qu'on FOCUS un picturebox
												this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_TYPE = CPCDOS_INSTANCE.SCI_INSTANCE.GUI_TYPE.PictureBox
												
												' Avec son index
												this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_INDEX = The_Objet_index
												
												
												this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.Pression = TRUE
												
												this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.Pression_Bouton = Type_Clic
												
												IF this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.EV_Click = True Then
													' Si l'utilisateur clique avec nimporte quel bouton de la souris (Click) ou (Click(Valeur))
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Click(1)") > 0 Then
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																		":=##/F:" & Nom_Objet & ".Click(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																		= "ERR_050" Then
																		
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Click(1);"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Click(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														end if
													end if
													
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Click()") > 0 Then
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																		":=##/F:" & Nom_Objet & ".Click()", _CLE_OBJ_ , 2, 0, "") _
																		= "ERR_050" Then
																		
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Click();"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Click()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														end if
													end if
												End if

												if Type_Clic AND 2 Then
													' Creer menu contextuel
													CPCDOS_INSTANCE.SCI_INSTANCE.creer_ContextMenu(Pos_X - 1, Pos_Y - 1, this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.OBJ_context_menu)
													
													return 1
												End if

												' On quitte cette boucle
												exit for

											Else
											
												' *******************************************************************
												' *** EVENEMENT : Si l'utilisateur a finit de cliquer sur l'objet ***
												' *******************************************************************
												
												IF this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.Pression = TRUE Then
													this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.Pression = False
													
													' Actualiser graphiquement le bouton pour l'effet de "pression"
													Creer_PictureBox(The_Objet_index, _INDEX_FENETRE_)
											
													IF this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.EV_MouseClick = True Then
														' Si l'utilisateur clique (bouton relache) avec nimporte quel bouton de la souris (MouseClick) ou (Click(Valeur))
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)") > 0 Then
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																		":=##/F:" & Nom_Objet & ".MouseClick(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1);"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															End if
														End if
															
													
													
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick()") > 0 Then
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																			":=##/F:" & Nom_Objet & ".MouseClick()", _CLE_OBJ_ , 2, 0, "") _
																			= "ERR_050" Then
																		
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick();"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															End if
														End if
													End IF
												End if
											
												' *****************************************************************************************************
												' *** EVENEMENT : Si l'utilisateur ENTRE la souris dans l'objet pour la premiere fois (MouseEnter) ***
												' *****************************************************************************************************
	

												IF this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.Survole = FALSE Then

												
													IF this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.EV_MouseEnter = True Then
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseEnter()") > 0 Then
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseEnter()", _CLE_OBJ_ , 2, 0, "") _
																		= "ERR_050" Then
																		
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseEnter();"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseEnter()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															end if
														end if
													end if

													' L'objet est en cours de survole
													this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.Survole = TRUE
													
													this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = this.GUI_TYPE.PictureBox
													this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = The_Objet_index

													' On quitte cette boucle
													'exit for
													continue for

													
												End if
												
												
												' *****************************************************************************
												' *** EVENEMENT : Si l'utilisateur se deplace DANS le controle (MouseMove) ***
												' *****************************************************************************
												
												
												IF this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.EV_MouseMove = True Then
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseMove()") > 0 Then
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseMove()", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseMove();"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseMove()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														end if
													End if
												End if


												' L'objet est en cours de survole
												this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.Survole = TRUE
												
												
												
												' On quitte cette boucle
												'exit for
												continue for
											End if
										End if
										
										' *******************************************************************
										' *** EVENEMENT : Si l'utilisateur a finit de cliquer sur l'objet ***
										' *******************************************************************
										
										IF this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.Pression = TRUE Then
											this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.Pression = False
											
											' Actualiser graphiquement le bouton pour l'effet de "pression"
											Creer_PictureBox(The_Objet_index, _INDEX_FENETRE_)
											IF this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.EV_MouseClick = True Then
												' Si l'utilisateur clique (bouton relache) avec nimporte quel bouton de la souris (MouseClick) ou (Click(Valeur))
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseClick(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1);"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													end if
												End if
																
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick()") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseClick()", _CLE_OBJ_ , 2, 0, "") _
															= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick();"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													end if
												end if
											End if
											
										End if
										
										
										' *****************************************************************************
										' *** EVENEMENT : Si l'utilisateur SORT/Ne survole plus l'objet (MouseLeave) ***
										' *****************************************************************************

										IF this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.Survole = TRUE Then
											this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.Survole = False
											
											IF this.INST_INIT_GUI.GUI__PICTUREBOX(The_Objet_index).PROP_TYPE.EV_MouseLeave = True Then
												' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
												
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseLeave()", _CLE_OBJ_ , 2, 0, "") _
															= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseLeave();"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													end if
												end if
											End if

											
											' Efface toutes traces
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = 0
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = 0
											
											' On quitte cette boucle
											exit for
										End if
									End if
									
									
									
								' ************************************************
								' **  T E X T E B L O C     T E X T E B L O C   ** ----------------------------------------------------
								' ************************************************	
								
								ElseIF The_Objet = "TEXTBLOCK" Then 

									Fichier_evenement  	= this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.Fichier_evenement

									if NOT Fichier_evenement = "" Then
									
										' Infos du picturebox concerne
										Index_Focus_OBJ 	= The_Objet_index
										_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).Identification_Objet._CLE_
										Nom_Objet 		 	= this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).Identification_Objet.Nom


										IF Interaction_TOUCHE(Pos_X, Pos_Y, _INDEX_FENETRE_, _
											this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).POS_X, _
											this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).POS_Y, _
											this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).SIZ_X, _
											this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).SIZ_Y) = TRUE Then
											
											' Pour pas que la fenetre soit aussi comprise
											Evenement_Sur_Objet = TRUE

											' *****************************************************************************************
											' *** EVENEMENT : Si l'utilisateur clique dans l'objet graphique avec sa souris (CLICK) ***
											' *****************************************************************************************
											
											IF (Type_Clic AND 1) OR (Type_Clic AND 2) OR (Type_Clic AND 3) Then

												' On indique qu'on FOCUS un picturebox
												this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_TYPE = CPCDOS_INSTANCE.SCI_INSTANCE.GUI_TYPE.TextBlock
												
												' Avec son index
												this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_INDEX = The_Objet_index
												
												this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.Pression = TRUE
												
												this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.Pression_Bouton = Type_Clic
												
												' Actualiser graphiquement le bouton pour l'effet de "pression"
												Creer_TextBlock(The_Objet_index, _INDEX_FENETRE_)
												
												IF this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.EV_Click = True Then
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Click(1)") > 0 Then
														' Si l'utilisateur clique (bouton enfonce) avec nimporte quel bouton de la souris (Click) ou (Click(Valeur))
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".Click(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																			
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Click(1);"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Click(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														end if
													End if
												
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Click()") > 0 Then
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".Click()", _CLE_OBJ_ , 2, 0, "") _
																= "ERR_050" Then
																		
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Click();"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Click()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														end if
													End if
												End if	

												if Type_Clic AND 2 Then
													' Creer menu contextuel
													CPCDOS_INSTANCE.SCI_INSTANCE.creer_ContextMenu(Pos_X - 1, Pos_Y - 1, this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.OBJ_context_menu)
													
													return 1
												End if		

												' On quitte cette boucle
												exit for
											Else
											
												' *******************************************************************
												' *** EVENEMENT : Si l'utilisateur a finit de cliquer sur l'objet ***
												' *******************************************************************
												
												IF this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.Pression = TRUE Then
													this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.Pression = False
													
													
													
													' Actualiser graphiquement le bouton pour l'effet de "pression"
													Creer_TextBlock(The_Objet_index, _INDEX_FENETRE_)
													
													IF this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.EV_MouseClick = True Then
														' Si l'utilisateur clique (bouton relache) avec nimporte quel bouton de la souris (MouseClick) ou (Click(Valeur))
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)") > 0 Then
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																		":=##/F:" & Nom_Objet & ".MouseClick(" & this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.Pression_Bouton & ")", _CLE_OBJ_ , 2, 0, "") _
																		= "ERR_050" Then
																			
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1);"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															End if
														end if
													
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick()") > 0 Then
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseClick()", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick();"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															End if
														End if
													End if
												End if
											
												' *****************************************************************************************************
												' *** EVENEMENT : Si l'utilisateur ENTRE la souris dans l'objet pour la premiere fois (MouseEnter) ***
												' *****************************************************************************************************
												
												IF NOT this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.Fichier_evenement = "" Then
													IF this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.Survole = FALSE Then
													
														IF this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.EV_MouseEnter = True Then
															if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseEnter()") > 0 Then
																if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseEnter()", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
																	' Black LIST EVENT !
																	CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseEnter();"
																	IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																		DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseEnter()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																	End if
																End if
															end if
														End if
														
														' L'objet est en cours de survole
														this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.Survole = TRUE
														
														this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = this.GUI_TYPE.TextBlock
														this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = The_Objet_index
														
														' On quitte cette boucle
														exit for
														
													End if
												End if
												
												
												' *****************************************************************************
												' *** EVENEMENT : Si l'utilisateur se deplace DANS le controle (MouseMove) ***
												' *****************************************************************************
												
												IF NOT this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.Fichier_evenement = "" Then
													
													IF this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.EV_MouseMove = True Then
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseMove()") > 0 Then
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseMove()", _CLE_OBJ_ , 2, 0, "") _
																= "ERR_050" Then
																		
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseMove();"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseMove()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															end if
														end if
													End if
													
													' L'objet est en cours de survole
													this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.Survole = TRUE
													

													' On quitte cette boucle
													exit for
													
												End if
											End if
										End if
										
										' *******************************************************************
										' *** EVENEMENT : Si l'utilisateur a finit de cliquer sur l'objet ***
										' *******************************************************************
										
										IF this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.Pression = TRUE Then
											this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.Pression = False
											
											' Actualiser graphiquement le bouton pour l'effet de "pression"
											Creer_TextBlock(The_Objet_index, _INDEX_FENETRE_)
									
											IF this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.EV_MouseClick = True Then
												' Si l'utilisateur clique (bouton relache) avec nimporte quel bouton de la souris (MouseClick) ou (Click(Valeur))
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseClick(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1);"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													end if
												end if
											
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick()") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseClick()", _CLE_OBJ_ , 2, 0, "") _
															= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick();"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												end if
											End if
										End if
										
										' *****************************************************************************
										' *** EVENEMENT : Si l'utilisateur SORT/Ne survole plus l'objet (MouseLeave) ***
										' *****************************************************************************
										
										IF this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.Survole = TRUE Then
											this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.Survole = False
											
											IF this.INST_INIT_GUI.GUI__TEXTBLOCK(The_Objet_index).PROP_TYPE.EV_MouseLeave = True Then
												' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseLeave()", _CLE_OBJ_ , 2, 0, "") _
															= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseLeave();"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													end if
												End if
											End if				
											' Efface toutes traces
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = 0
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = 0
											
											' On quitte cette boucle
											exit for
										End if
									End if
									

									
								' ********************************************
								' **  T E X T E B O X     T E X T E B O X   ** ----------------------------------------------------
								' ********************************************	
								
									
								ElseIF The_Objet = "TEXTBOX" Then 

									Fichier_evenement  	= this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Fichier_evenement
									
									
									' Infos du picturebox concerne
									Index_Focus_OBJ 	= The_Objet_index
									_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).Identification_Objet._CLE_
									Nom_Objet 		 	= this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).Identification_Objet.Nom

									IF Interaction_TOUCHE(Pos_X, Pos_Y, _INDEX_FENETRE_, _
										this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).POS_X, _
										this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).POS_Y, _
										this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).SIZ_X, _
										this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).SIZ_Y) = TRUE Then
										
										' Pour pas que la fenetre soit aussi comprise
										Evenement_Sur_Objet = TRUE

										' *****************************************************************************************
										' *** EVENEMENT : Si l'utilisateur clique dans l'objet graphique avec sa souris (CLICK) ***
										' *****************************************************************************************
										
										IF (Type_Clic AND 1) OR (Type_Clic AND 2) OR (Type_Clic AND 3) Then

											' On indique qu'on FOCUS un Textbox
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_TYPE = CPCDOS_INSTANCE.SCI_INSTANCE.GUI_TYPE.TextBox
											
											' Avec son index
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_INDEX = The_Objet_index
											
											this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Pression = TRUE
											
											this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Pression_Bouton = Type_Clic
											
											
											' Donner position X et Y de la souris pour estimer la position du curseur d'edition du textebox
											CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Pos_User_New 	= true
											CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Move_Keyb 		= false
											CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Pos_User_Mouse_X = Pos_X
											CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Pos_User_Mouse_Y = Pos_Y
											
											' Actualiser graphiquement le textebox pour l'effet de ""
											Creer_TextBox(The_Objet_index, _INDEX_FENETRE_)
											
											
											' CORRECTION 03/12/2019 : Cette ligne est ici sinon textebox Freez� car pas fichier events
											if NOT Fichier_evenement = "" Then
												IF this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.EV_Click = True Then
													' Si l'utilisateur clique (bouton enfonce) avec nimporte quel bouton de la souris (Click) ou (Click(Valeur))
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Click(1)") > 0 Then
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".Click(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																= "ERR_050" Then
																		
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Click(1);"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Click(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														end if
													End if
													
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseMove()") > 0 Then
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".Click()", _CLE_OBJ_ , 2, 0, "") _
																= "ERR_050" Then
																		
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseLeave();"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														End if
													end if
												End if			
											End if

											if Type_Clic AND 2 Then
												' Creer menu contextuel
												CPCDOS_INSTANCE.SCI_INSTANCE.creer_ContextMenu(Pos_X - 1, Pos_Y - 1, this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.OBJ_context_menu)
												
												return 1
											End if
															
															
											' On quitte cette boucle
											exit for
										Else
										
											' *******************************************************************
											' *** EVENEMENT : Si l'utilisateur a finit de cliquer sur l'objet ***
											' *******************************************************************
											
											IF this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Pression = TRUE Then
												this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Pression = False
												
												
												' Actualiser graphiquement le bouton pour l'effet de "pression"
												Creer_TextBox(The_Objet_index, _INDEX_FENETRE_)
												
												' CORRECTION 03/12/2019 : Cette ligne est ici sinon textebox Freez� car pas fichier events
												if NOT Fichier_evenement = "" Then
													IF this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.EV_MouseClick = True Then
														' Si l'utilisateur clique (bouton relache) avec nimporte quel bouton de la souris (MouseClick) ou (Click(Valeur))
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)") > 0 Then
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseClick(" & this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Pression_Bouton & ")", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1);"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															end if
														end if
													
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick()") > 0 Then
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseClick()", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick();"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															end if
														end if
													End if
												End if
											End if
										
											' *****************************************************************************************************
											' *** EVENEMENT : Si l'utilisateur ENTRE la souris dans l'objet pour la premiere fois (MouseEnter) ***
											' *****************************************************************************************************
											
											IF NOT this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Fichier_evenement = "" Then
												IF this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Survole = FALSE Then
												
													' CORRECTION 03/12/2019 : Cette ligne est ici sinon textebox Freez� car pas fichier events
													if NOT Fichier_evenement = "" Then
														IF this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.EV_MouseEnter = True Then
															if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseEnter()") > 0 Then
																if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseEnter()", _CLE_OBJ_ , 2, 0, "") _
																		= "ERR_050" Then
																		
																	' Black LIST EVENT !
																	CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseEnter();"
																	IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																		DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseEnter()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																	End if
																End if
															end if
														End if
													End if
													
													' L'objet est en cours de survole
													this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Survole = TRUE
													
													this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = this.GUI_TYPE.TextBox
													this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = The_Objet_index
													
													' On quitte cette boucle
													exit for
													
												End if
											End if
											
											
											' *****************************************************************************
											' *** EVENEMENT : Si l'utilisateur se deplace DANS le controle (MouseMove) ***
											' *****************************************************************************
											
											IF NOT this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Fichier_evenement = "" Then
												
												' CORRECTION 03/12/2019 : Cette ligne est ici sinon textebox Freez� car pas fichier events
												if NOT Fichier_evenement = "" Then
													IF this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.EV_MouseMove = True Then
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseMove()") > 0 Then
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseMove()", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseMove();"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseMove()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															End if
														end if
													End if
												End if
												
												' L'objet est en cours de survole
												this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Survole = TRUE
												
												
												
												' On quitte cette boucle
												exit for
												
											End if
										End if
									End if
									
									' *******************************************************************
									' *** EVENEMENT : Si l'utilisateur a finit de cliquer sur l'objet ***
									' *******************************************************************
									
									IF this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Pression = TRUE Then
										this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Pression = False
										
										' Actualiser graphiquement le bouton pour l'effet de "pression"
										Creer_TextBox(The_Objet_index, _INDEX_FENETRE_)
								
										' CORRECTION 03/12/2019 : Cette ligne est ici sinon textebox Freez� car pas fichier events
										if NOT Fichier_evenement = "" Then
											IF this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.EV_MouseClick = True Then
												' Si l'utilisateur clique (bouton relache) avec nimporte quel bouton de la souris (MouseClick) ou (Click(Valeur))
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseClick(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1);"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												End if
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick()") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseClick()", _CLE_OBJ_ , 2, 0, "") _
															= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick();"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													end if
												End if
											End if
										End if
									End if
									
									' *****************************************************************************
									' *** EVENEMENT : Si l'utilisateur SORT/Ne survole plus l'objet (MouseLeave) ***
									' *****************************************************************************
									
									IF this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Survole = TRUE Then
										this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.Survole = False
										
										' CORRECTION 03/12/2019 : Cette ligne est ici sinon textebox Freez� car pas fichier events
										if NOT Fichier_evenement = "" Then
											IF this.INST_INIT_GUI.GUI__TEXTBOX(The_Objet_index).PROP_TYPE.EV_MouseLeave = True Then
												' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
												
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseLeave()", _CLE_OBJ_ , 2, 0, "") _
																= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseLeave();"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												end if
											End if				
										End if				
										' Efface toutes traces
										this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = 0
										this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = 0
										
										' On quitte cette boucle
										exit for
									End if
									
									
									
								
								' ********************************************
								' **   B A R R E   P R O G R E S S I O N   ** ----------------------------------------------------
								' ********************************************	
								
									
								ElseIF The_Objet = "PROGRESSBAR" Then 

									Fichier_evenement  	= this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.Fichier_evenement
									
									if NOT Fichier_evenement = "" Then
									
										' Infos du picturebox concerne
										Index_Focus_OBJ 	= The_Objet_index
										_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).Identification_Objet._CLE_
										Nom_Objet 		 	= this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).Identification_Objet.Nom

										
										IF Interaction_TOUCHE(Pos_X, Pos_Y, _INDEX_FENETRE_, _
											this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).POS_X, _
											this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).POS_Y, _
											this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).SIZ_X, _
											this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).SIZ_Y) = TRUE Then
											
											' Pour pas que la fenetre soit aussi comprise
											Evenement_Sur_Objet = TRUE

											' *****************************************************************************************
											' *** EVENEMENT : Si l'utilisateur clique dans l'objet graphique avec sa souris (CLICK) ***
											' *****************************************************************************************
											
											IF (Type_Clic AND 1) OR (Type_Clic AND 2) OR (Type_Clic AND 3) Then

												' On indique qu'on FOCUS un PROGRESSBAR
												this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_TYPE = CPCDOS_INSTANCE.SCI_INSTANCE.GUI_TYPE.PROGRESSBAR
												
												' Avec son index
												this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_INDEX = The_Objet_index
												
												this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.Pression = TRUE
												
												this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.Pression_Bouton = Type_Clic
												
												' Actualiser graphiquement le textebox pour l'effet de ""
												Creer_PROGRESSBAR(The_Objet_index, _INDEX_FENETRE_)
												
												IF this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.EV_Click = True Then
													' Si l'utilisateur clique (bouton enfonce) avec nimporte quel bouton de la souris (Click) ou (Click(Valeur))
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Click(1)") > 0 Then
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".Click(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																= "ERR_050" Then
																		
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Click(1);"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Click(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														end if
													End if
																
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Click()") > 0 Then
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".Click()", _CLE_OBJ_ , 2, 0, "") _
															= "ERR_050" Then
															
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Click();"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Click()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														End if
													end if
												End if

												if Type_Clic AND 2 Then
													' Creer menu contextuel
													CPCDOS_INSTANCE.SCI_INSTANCE.creer_ContextMenu(Pos_X - 1, Pos_Y - 1, this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.OBJ_context_menu)
													
													return 1
												End if

												' On quitte cette boucle
												exit for
											Else
											
												' *******************************************************************
												' *** EVENEMENT : Si l'utilisateur a finit de cliquer sur l'objet ***
												' *******************************************************************
												
												IF this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.Pression = TRUE Then
													this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.Pression = False
													
													
													
													' Actualiser graphiquement le bouton pour l'effet de "pression"
													Creer_PROGRESSBAR(The_Objet_index, _INDEX_FENETRE_)
													
													IF this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.EV_MouseClick = True Then
														' Si l'utilisateur clique (bouton relache) avec nimporte quel bouton de la souris (MouseClick) ou (Click(Valeur))
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)") > 0 Then
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseClick(" & this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.Pression_Bouton & ")", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
															
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1);"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															End if
														end if
																	
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick()") > 0 Then
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseClick()", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
															
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick();"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															End if
														end if
													End if
												End if
											
												' *****************************************************************************************************
												' *** EVENEMENT : Si l'utilisateur ENTRE la souris dans l'objet pour la premiere fois (MouseEnter) ***
												' *****************************************************************************************************
												
												IF NOT this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.Fichier_evenement = "" Then
													IF this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.Survole = FALSE Then
													
														IF this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.EV_MouseEnter = True Then
															if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseEnter()") > 0 Then
																if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseEnter()", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
															
																	' Black LIST EVENT !
																	CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseEnter();"
																	IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																		DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseEnter()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																	End if
																End if
															end if
														End if
														
														' L'objet est en cours de survole
														this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.Survole = TRUE
														
														this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = this.GUI_TYPE.PROGRESSBAR
														this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = The_Objet_index
														
														' On quitte cette boucle
														exit for
														
													End if
												End if
												
												
												' *****************************************************************************
												' *** EVENEMENT : Si l'utilisateur se deplace DANS le controle (MouseMove) ***
												' *****************************************************************************
												
												IF NOT this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.Fichier_evenement = "" Then
													
													IF this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.EV_MouseMove = True Then
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseMove()") > 0 Then
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseMove()", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
															
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseMove();"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseMove()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															End if
														end if
													End if
													
													' L'objet est en cours de survole
													this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.Survole = TRUE
													
													
													
													' On quitte cette boucle
													exit for
													
												End if
											End if
										End if
										
										' *******************************************************************
										' *** EVENEMENT : Si l'utilisateur a finit de cliquer sur l'objet ***
										' *******************************************************************
										
										IF this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.Pression = TRUE Then
											this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.Pression = False
											
											' Actualiser graphiquement le bouton pour l'effet de "pression"
											Creer_PROGRESSBAR(The_Objet_index, _INDEX_FENETRE_)
									
											IF this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.EV_MouseClick = True Then
												' Si l'utilisateur clique (bouton relache) avec nimporte quel bouton de la souris (MouseClick) ou (Click(Valeur))
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseClick(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																= "ERR_050" Then
															
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1);"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													end if
												End if
												
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseMove()") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseClick()", _CLE_OBJ_ , 2, 0, "") _
															= "ERR_050" Then
															
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick();"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												end if
											End if
										End if
										
										' *****************************************************************************
										' *** EVENEMENT : Si l'utilisateur SORT/Ne survole plus l'objet (MouseLeave) ***
										' *****************************************************************************
										
										IF this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.Survole = TRUE Then
											this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.Survole = False
											
											IF this.INST_INIT_GUI.GUI__PROGRESSBAR(The_Objet_index).PROP_TYPE.EV_MouseLeave = True Then
												' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
												
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseLeave()", _CLE_OBJ_ , 2, 0, "") _
															= "ERR_050" Then
															
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseLeave();"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												end if
											End if				
											' Efface toutes traces
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = 0
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = 0
											
											' On quitte cette boucle
											exit for
										End if
									End if
									
									
									
								' ********************************************
								' **   C H E C K B O X    C H E C K B O X   ** ----------------------------------------------------
								' ********************************************	
								
									
								ElseIF The_Objet = "CHECKBOX" Then 

									Fichier_evenement  	= this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.Fichier_evenement
									
									if NOT Fichier_evenement = "" Then
									
										' Infos du picturebox concerne
										Index_Focus_OBJ 	= The_Objet_index
										_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).Identification_Objet._CLE_
										Nom_Objet 		 	= this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).Identification_Objet.Nom

										
										IF Interaction_TOUCHE(Pos_X, Pos_Y, _INDEX_FENETRE_, _
											this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).POS_X, _
											this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).POS_Y, _
											this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).SIZ_X, _
											this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).SIZ_Y) = TRUE Then
											
											' Pour pas que la fenetre soit aussi comprise
											Evenement_Sur_Objet = TRUE

											' *****************************************************************************************
											' *** EVENEMENT : Si l'utilisateur clique dans l'objet graphique avec sa souris (CLICK) ***
											' *****************************************************************************************
											
											IF (Type_Clic AND 1) OR (Type_Clic AND 2) OR (Type_Clic AND 3) Then

												' On indique qu'on FOCUS un checkbox
												this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_TYPE = CPCDOS_INSTANCE.SCI_INSTANCE.GUI_TYPE.CheckBox
												
												' Avec son index
												this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_INDEX = The_Objet_index
												
												this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.Pression = TRUE
												
												this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.Pression_Bouton = Type_Clic
												
												' Actualiser graphiquement le checkbox pour l'effet de ""
												Creer_CheckBox(The_Objet_index, _INDEX_FENETRE_)
												
												IF this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.EV_Click = True Then
													' Si l'utilisateur clique (bouton enfonce) avec nimporte quel bouton de la souris (Click) ou (Click(Valeur))
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Click(1)") > 0 Then
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".Click(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																= "ERR_050" Then
															
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Click(1);"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Click(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														end if
													end if
																
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Click()") > 0 Then
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".Click()", _CLE_OBJ_ , 2, 0, "") _
																= "ERR_050" Then
															
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Click();"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Click()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														end if
													End if
												end if

												if Type_Clic AND 2 Then
													' Creer menu contextuel
													CPCDOS_INSTANCE.SCI_INSTANCE.creer_ContextMenu(Pos_X - 1, Pos_Y - 1, this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.OBJ_context_menu)
													
													return 1
												End if	
																
												' On quitte cette boucle
												exit for
											Else
											
												' *******************************************************************
												' *** EVENEMENT : Si l'utilisateur a finit de cliquer sur l'objet ***
												' *******************************************************************
												
												IF this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.Pression = TRUE Then
													this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.Pression = False
													
													if this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).Valeur > 0 Then
														this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).Valeur = 0
													Else
														this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).Valeur = 1
													End if
													
													' Actualiser graphiquement le checkbox pour l'effet de "pression"
													Creer_CheckBox(The_Objet_index, _INDEX_FENETRE_)
													
													IF this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.EV_MouseClick = True Then
														' Si l'utilisateur clique (bouton relache) avec nimporte quel bouton de la souris (MouseClick) ou (Click(Valeur))
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)") > 0 Then
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseClick(" & this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.Pression_Bouton & ")", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
															
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1);"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															End if
														end if
														
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseMove()") > 0 Then
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseClick()", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
															
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick();"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															End if
														end if
													End if
												End if
											
												' *****************************************************************************************************
												' *** EVENEMENT : Si l'utilisateur ENTRE la souris dans l'objet pour la premiere fois (MouseEnter) ***
												' *****************************************************************************************************
												
												IF NOT this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.Fichier_evenement = "" Then
													IF this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.Survole = FALSE Then
													
														IF this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.EV_MouseEnter = True Then
															if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseEnter()") > 0 Then
																if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseEnter()", _CLE_OBJ_ , 2, 0, "") _
																		= "ERR_050" Then
															
																	' Black LIST EVENT !
																	CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseEnter();"
																	IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																		DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseEnter()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																	End if
																end if
															End if
														End if
														
														' L'objet est en cours de survole
														this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.Survole = TRUE
														
														this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = this.GUI_TYPE.CheckBox
														this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = The_Objet_index
														
														' Actualiser graphiquement le checkbox pour l'effet de "pression"
														Creer_CheckBox(The_Objet_index, _INDEX_FENETRE_)
														
														' On quitte cette boucle
														exit for
														
													End if
												End if
												
												
												' *****************************************************************************
												' *** EVENEMENT : Si l'utilisateur se deplace DANS le controle (MouseMove) ***
												' *****************************************************************************
												
												IF NOT this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.Fichier_evenement = "" Then
													
													IF this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.EV_MouseMove = True Then
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseMove()") > 0 Then
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseMove()", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
															
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseMove();"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseMove()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															end if
														End if
													End if
													
													' L'objet est en cours de survole
													this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.Survole = TRUE
													
													
													
													' On quitte cette boucle
													exit for
													
												End if
											End if
										End if
										
										' *******************************************************************
										' *** EVENEMENT : Si l'utilisateur a finit de cliquer sur l'objet ***
										' *******************************************************************
										
										IF this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.Pression = TRUE Then
											this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.Pression = False
											
											
											
											' Actualiser graphiquement le bouton pour l'effet de "pression"
											Creer_CheckBox(The_Objet_index, _INDEX_FENETRE_)
									
											IF this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.EV_MouseClick = True Then
												' Si l'utilisateur clique (bouton relache) avec nimporte quel bouton de la souris (MouseClick) ou (Click(Valeur))
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseClick(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																= "ERR_050" Then
																
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1);"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												end if
												
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick()") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseClick()", _CLE_OBJ_ , 2, 0, "") _
															= "ERR_050" Then
															
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick();"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												end if
											End if
										End if
										
										' *****************************************************************************
										' *** EVENEMENT : Si l'utilisateur SORT/Ne survole plus l'objet (MouseLeave) ***
										' *****************************************************************************
										
										IF this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.Survole = TRUE Then
											this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.Survole = False
											
											IF this.INST_INIT_GUI.GUI__CHECKBOX(The_Objet_index).PROP_TYPE.EV_MouseLeave = True Then
												' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & ".MouseLeave()", _CLE_OBJ_ , 2, 0, "") _
															= "ERR_050" Then
															
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseLeave();"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												end if
											End if				
											' Efface toutes traces
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = 0
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = 0
											
											' Actualiser graphiquement le checkbox pour l'effet de "pression"
											Creer_CheckBox(The_Objet_index, _INDEX_FENETRE_)
											
											' On quitte cette boucle
											exit for
										End if
									End if
									
									
								' ******************************************
								' ** E X P L O R E U R    E X P L O R E R ** ----------------------------------------------------
								' ******************************************
								
								ElseIf The_Objet = "EXPLORER" Then 

									Fichier_evenement  	= this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.Fichier_evenement
								
									if NOT Fichier_evenement = "" Then
									
										' Infos du picturebox concerne
										Index_Focus_OBJ 	= The_Objet_index
										_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).Identification_Objet._CLE_
										Nom_Objet 		 	= this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).Identification_Objet.Nom

										IF Interaction_TOUCHE(Pos_X, Pos_Y, _INDEX_FENETRE_, _
											this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).POS_X, _
											this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).POS_Y, _
											this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).SIZ_X, _
											this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).SIZ_Y) = TRUE Then
											
											Dim Retour_STR as String = ""
											
											' Pour pas que la fenetre soit aussi comprise
											Evenement_Sur_Objet = TRUE

											' *****************************************************************************************
											' *** EVENEMENT : Si l'utilisateur clique dans l'objet graphique avec sa souris (CLICK) ***
											' *****************************************************************************************
											
											IF (Type_Clic AND 1) OR (Type_Clic AND 2) OR (Type_Clic AND 3) Then

												' On indique qu'on FOCUS un explorer
												this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_TYPE = CPCDOS_INSTANCE.SCI_INSTANCE.GUI_TYPE.Explorer
												
												' Avec son index
												this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_INDEX = The_Objet_index
												
												this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.Pression = TRUE
												
												this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.Pression_Bouton = Type_Clic
												
												
												' Actualiser graphiquement l'explorer pour l'effet de "pression"
												'if this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.DESKTOPMODE = false Then
													' Actualiser graphiquement le bouton pour l'effet de "survole"
													this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).obj_doevent_press += 1
															
													if this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).obj_doevent_press > 5 Then
														this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).obj_doevent_press = 0
														Creer_Explorer(The_Objet_index, _INDEX_FENETRE_)
													End if
												'End if
												
												IF this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.EV_Click = True Then
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Click(1)") > 0 Then
														' Si l'utilisateur clique (bouton enfonce) avec nimporte quel bouton de la souris (Click) ou (Click(Valeur))
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																		":=##/F:" & Nom_Objet & ".Click(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																		= "ERR_050" Then
																			
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Click(1);"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Click(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														End if
													end if
													
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Click()") > 0 Then
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																		":=##/F:" & Nom_Objet & ".Click()", _CLE_OBJ_ , 2, 0, "") _
																		= "ERR_050" Then
																			
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Click();"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Click()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														End if
													End if
												End if		


												if Type_Clic AND 2 Then
													' Creer menu contextuel
													CPCDOS_INSTANCE.SCI_INSTANCE.creer_ContextMenu(Pos_X - 1, Pos_Y - 1, this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.OBJ_context_menu)
													
													return 1
												End if		
																
																
												' On quitte cette boucle
												exit for
											Else
											
												' *******************************************************************
												' *** EVENEMENT : Si l'utilisateur a finit de cliquer sur l'objet ***
												' *******************************************************************
												
												IF this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.Pression = TRUE Then
													this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.Pression = False
													
													
													
													' Actualiser graphiquement le bouton pour l'effet de "pression"
													Creer_Explorer(The_Objet_index, _INDEX_FENETRE_)
											
													IF this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.EV_MouseClick = True Then
													
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)") > 0 Then
															' Si l'utilisateur clique (bouton relache) avec nimporte quel bouton de la souris (MouseClick) ou (Click(Valeur))
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																			":=##/F:" & Nom_Objet & ".MouseClick(" & this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.Pression_Bouton & ")", _CLE_OBJ_ , 2, 0, "") _
																			= "ERR_050" Then
																			
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1);"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															End if
														End if
														
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick()") > 0 Then
															IF CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																			":=##/F:" & Nom_Objet & ".MouseClick()", _CLE_OBJ_ , 2, 0, "") _
																			= "ERR_050" Then
																			
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick();"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
																
															End if
														End if
													End if
												End if
											
												' *****************************************************************************************************
												' *** EVENEMENT : Si l'utilisateur ENTRE la souris dans l'objet pour la premiere fois (MouseEnter) ***
												' *****************************************************************************************************
												
												if CPCDOS_INSTANCE.SCI_INSTANCE.Fenetre_FOCUS(0) = _INDEX_FENETRE_ Then 
													IF NOT this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.Fichier_evenement = "" Then
														IF this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.Survole = FALSE Then
														
															IF this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.EV_MouseEnter = True Then
																if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseEnter()") > 0 Then
																	if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																			":=##/F:" & Nom_Objet & ".MouseEnter()", _CLE_OBJ_ , 2, 0, "") _
																			= "ERR_050" Then
																				
																		' Black LIST EVENT !
																		CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseEnter();"
																		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																			DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseEnter()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																		End if
																		
																	End if
																End if
															End if
															
															' L'objet est en cours de survole
															this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.Survole = TRUE
															
															this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = this.GUI_TYPE.Explorer
															this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = The_Objet_index
															
															if this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.DESKTOPMODE = false Then
																' Actualiser graphiquement le bouton pour l'effet de "survole"
																Creer_Explorer(The_Objet_index, _INDEX_FENETRE_)
															End if

															' On quitte cette boucle
															exit for
															
														End if
													End if
													
													
													' *****************************************************************************
													' *** EVENEMENT : Si l'utilisateur se deplace DANS le controle (MouseMove) ***
													' *****************************************************************************
													
													IF NOT this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.Fichier_evenement = "" Then
														
														IF 0 Then ' Desactiver l'event mousemove de
															if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseMove()") > 0 Then
																IF this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.EV_MouseMove = True Then
																	if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																		":=##/F:" & Nom_Objet & ".MouseMove()", _CLE_OBJ_ , 2, 0, "") _
																		= "ERR_050" Then
																				
																		' Black LIST EVENT !
																		CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseMove();"
																		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																			DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseMove()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																		End if
																	End if
																End if
															End if
														End if
														
														' L'objet est en cours de survole
														this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.Survole = TRUE
														
														' Actualiser graphiquement le explorer pour l'effet de "pression"
														if this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.DESKTOPMODE = false Then
															' Actualiser graphiquement le bouton pour l'effet de "survole"
															
															this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).obj_doevent_survole += 1
															
															if this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).obj_doevent_survole > 4 Then
																this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).obj_doevent_survole = 0
																Creer_Explorer(The_Objet_index, _INDEX_FENETRE_)
															End if
														End if

														' On quitte cette boucle
														exit for
														
													End if
												End if ' IF FOCUS
											End if 
										End if
										
										' *******************************************************************
										' *** EVENEMENT : Si l'utilisateur a finit de cliquer sur l'objet ***
										' *******************************************************************
										
										IF this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.Pression = TRUE Then
											this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.Pression = False
											
											' Actualiser graphiquement le explorer pour l'effet de "pression"
											Creer_Explorer(The_Objet_index, _INDEX_FENETRE_)
									
											IF this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.EV_MouseClick = True Then
												' Si l'utilisateur clique (bouton relache) avec nimporte quel bouton de la souris (MouseClick) ou (Click(Valeur))
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseClick(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1);"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												End if
																
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick()") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseClick()", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick();"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												End if
											End if
										End if
										
										' *****************************************************************************
										' *** EVENEMENT : Si l'utilisateur SORT/Ne survole plus l'objet (MouseLeave) ***
										' *****************************************************************************
										
										IF this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.Survole = TRUE Then
											this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.Survole = False
											
											IF this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.EV_MouseLeave = True Then
												
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()") > 0 Then
													' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseLeave()", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseLeave();"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												End if
											End if

											
											' Efface toutes traces
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = 0
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = 0
											
											' Actualiser graphiquement le explorer pour l'effet de "pression"
											if this.INST_INIT_GUI.GUI__EXPLORER(The_Objet_index).PROP_TYPE.DESKTOPMODE = false Then
												' Actualiser graphiquement le bouton pour l'effet de "survole"
												Creer_Explorer(The_Objet_index, _INDEX_FENETRE_)
											End if
											
											' On quitte cette boucle
											exit for
										End if
										
									End if 
								' ******************************************
								' ** L I S T B O X          L I S T B O X ** ----------------------------------------------------
								' ******************************************
								
								ElseIf The_Objet = "LISTBOX" Then 

									Fichier_evenement  	= this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.Fichier_evenement
								
									if NOT Fichier_evenement = "" Then
									
										' Infos du picturebox concerne
										Index_Focus_OBJ 	= The_Objet_index
										_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).Identification_Objet._CLE_
										Nom_Objet 		 	= this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).Identification_Objet.Nom

										IF Interaction_TOUCHE(Pos_X, Pos_Y, _INDEX_FENETRE_, _
											this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).POS_X, _
											this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).POS_Y, _
											this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).SIZ_X, _
											this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).SIZ_Y) = TRUE Then
											
											Dim Retour_STR as String = ""
											
											' Pour pas que la fenetre soit aussi comprise
											Evenement_Sur_Objet = TRUE

											' *****************************************************************************************
											' *** EVENEMENT : Si l'utilisateur clique dans l'objet graphique avec sa souris (CLICK) ***
											' *****************************************************************************************
											
											IF (Type_Clic AND 1) OR (Type_Clic AND 2) OR (Type_Clic AND 3) Then

												' On indique qu'on FOCUS un Listbox
												this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_TYPE = CPCDOS_INSTANCE.SCI_INSTANCE.GUI_TYPE.Listbox
												
												' Avec son index
												this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_INDEX = The_Objet_index
												
												this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.Pression = TRUE
												
												this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.Pression_Bouton = Type_Clic
												
												
												' Actualiser graphiquement le listbox pour l'effet de "pression"
												'if this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.DESKTOPMODE = false Then
													' Actualiser graphiquement le bouton pour l'effet de "survole"
													Creer_Listbox(The_Objet_index, _INDEX_FENETRE_)
												'End if

												Dim SELECTIONNE_index as integer = this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).SELECTIONNE_index
												Dim SELECTIONNE_str as string = this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).SELECTIONNE_str

												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Selected(2)") > 0 Then
													' Si l'utilisateur selectionne (bouton enfonce) un element
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".Selected(" & SELECTIONNE_str & "," & SELECTIONNE_index & ")", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Selected(2);"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Selected(2)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												end if
												
												IF this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.EV_Click = True Then
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Click(1)") > 0 Then
														' Si l'utilisateur clique (bouton enfonce) avec nimporte quel bouton de la souris (Click) ou (Click(Valeur))
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																		":=##/F:" & Nom_Objet & ".Click(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																		= "ERR_050" Then
																			
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Click(1);"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Click(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														End if
													end if
													
													if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Click()") > 0 Then
														if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																		":=##/F:" & Nom_Objet & ".Click()", _CLE_OBJ_ , 2, 0, "") _
																		= "ERR_050" Then
																			
															' Black LIST EVENT !
															CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Click();"
															IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Click()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
															End if
														End if
													End if
												End if		


												if Type_Clic AND 2 Then
													' Creer menu contextuel
													CPCDOS_INSTANCE.SCI_INSTANCE.creer_ContextMenu(Pos_X - 1, Pos_Y - 1, this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.OBJ_context_menu)
													
													return 1
												End if		
																
																
												' On quitte cette boucle
												exit for
											Else
											
												' *******************************************************************
												' *** EVENEMENT : Si l'utilisateur a finit de cliquer sur l'objet ***
												' *******************************************************************
												
												IF this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.Pression = TRUE Then
													this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.Pression = False
													
													
													
													' Actualiser graphiquement le bouton pour l'effet de "pression"
													Creer_Listbox(The_Objet_index, _INDEX_FENETRE_)
											
													IF this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.EV_MouseClick = True Then
													
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)") > 0 Then
															' Si l'utilisateur clique (bouton relache) avec nimporte quel bouton de la souris (MouseClick) ou (Click(Valeur))
															if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																			":=##/F:" & Nom_Objet & ".MouseClick(" & this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.Pression_Bouton & ")", _CLE_OBJ_ , 2, 0, "") _
																			= "ERR_050" Then
																			
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1);"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
															End if
														End if
														
														if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick()") > 0 Then
															IF CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																			":=##/F:" & Nom_Objet & ".MouseClick()", _CLE_OBJ_ , 2, 0, "") _
																			= "ERR_050" Then
																			
																' Black LIST EVENT !
																CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick();"
																IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																	DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																End if
																
															End if
														End if
													End if
												End if
											
												' *****************************************************************************************************
												' *** EVENEMENT : Si l'utilisateur ENTRE la souris dans l'objet pour la premiere fois (MouseEnter) ***
												' *****************************************************************************************************
												
												if CPCDOS_INSTANCE.SCI_INSTANCE.Fenetre_FOCUS(0) = _INDEX_FENETRE_ Then 
													IF NOT this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.Fichier_evenement = "" Then
														IF this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.Survole = FALSE Then
														
															IF this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.EV_MouseEnter = True Then
																if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseEnter()") > 0 Then
																	if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																			":=##/F:" & Nom_Objet & ".MouseEnter()", _CLE_OBJ_ , 2, 0, "") _
																			= "ERR_050" Then
																				
																		' Black LIST EVENT !
																		CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseEnter();"
																		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																			DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseEnter()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																		End if
																		
																	End if
																End if
															End if
															
															' L'objet est en cours de survole
															this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.Survole = TRUE
															
															this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = this.GUI_TYPE.Listbox
															this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = The_Objet_index
															
															if this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.DESKTOPMODE = false Then
																' Actualiser graphiquement le bouton pour l'effet de "survole"
																Creer_Listbox(The_Objet_index, _INDEX_FENETRE_)
															End if

															' On quitte cette boucle
															exit for
															
														End if
													End if
													
													
													' *****************************************************************************
													' *** EVENEMENT : Si l'utilisateur se deplace DANS le controle (MouseMove) ***
													' *****************************************************************************
													
													IF NOT this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.Fichier_evenement = "" Then
														
														IF 0 Then ' Desactiver l'event mousemove de
															if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseMove()") > 0 Then
																IF this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.EV_MouseMove = True Then
																	if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																		":=##/F:" & Nom_Objet & ".MouseMove()", _CLE_OBJ_ , 2, 0, "") _
																		= "ERR_050" Then
																				
																		' Black LIST EVENT !
																		CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseMove();"
																		IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
																			DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseMove()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
																		End if
																	End if
																End if
															End if
														End if
														
														' L'objet est en cours de survole
														this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.Survole = TRUE
														
														' Actualiser graphiquement le listbox pour l'effet de "pression"
														if this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.DESKTOPMODE = false Then
															' Actualiser graphiquement le bouton pour l'effet de "survole"
															Creer_Listbox(The_Objet_index, _INDEX_FENETRE_)
														End if

														' On quitte cette boucle
														exit for
														
													End if
												End if ' IF FOCUS
											End if 
										End if
										
										' *******************************************************************
										' *** EVENEMENT : Si l'utilisateur a finit de cliquer sur l'objet ***
										' *******************************************************************
										
										IF this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.Pression = TRUE Then
											this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.Pression = False
											
											' Actualiser graphiquement le listbox pour l'effet de "pression"
											Creer_Listbox(The_Objet_index, _INDEX_FENETRE_)
									
											IF this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.EV_MouseClick = True Then
												' Si l'utilisateur clique (bouton relache) avec nimporte quel bouton de la souris (MouseClick) ou (Click(Valeur))
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseClick(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1);"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												End if
																
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseClick()") > 0 Then
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseClick()", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseClick();"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseClick()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												End if
											End if
										End if
										
										' *****************************************************************************
										' *** EVENEMENT : Si l'utilisateur SORT/Ne survole plus l'objet (MouseLeave) ***
										' *****************************************************************************
										
										IF this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.Survole = TRUE Then
											this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.Survole = False
											
											IF this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.EV_MouseLeave = True Then
												
												if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()") > 0 Then
													' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
													if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																	":=##/F:" & Nom_Objet & ".MouseLeave()", _CLE_OBJ_ , 2, 0, "") _
																	= "ERR_050" Then
																		
														' Black LIST EVENT !
														CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":MouseLeave();"
														IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
															DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":MouseLeave()", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
														End if
													End if
												End if
											End if

											
											' Efface toutes traces
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = 0
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = 0
											
											' Actualiser graphiquement le listbox pour l'effet de "pression"
											if this.INST_INIT_GUI.GUI__LISTBOX(The_Objet_index).PROP_TYPE.DESKTOPMODE = false Then
												' Actualiser graphiquement le bouton pour l'effet de "survole"
												Creer_Listbox(The_Objet_index, _INDEX_FENETRE_)
											End if
											
											' On quitte cette boucle
											exit for
										End if
										
									End if 
								
								End if ' Scope des differents objets
							End if
						
						' Next _INDEX__ORDRE_OBJET
						Next _IN_ORDR_OBJ_
						
						
						' ***************************************************************
						' ** E V E N E M E N T S  F E N E T R E S  G R A P H I Q U E S ** ------------------------------
						' ***************************************************************
						
						' Si aucuns des objets a eu une interaction alors on va question la fenetre! ;-)
						IF Evenement_Sur_Objet = FALSE Then
							
							
							Fichier_evenement  	= this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Fichier_evenement
							
							' Si l'evenement existe
							if NOT Fichier_evenement = "" Then
							
								_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet._CLE_
								Nom_Objet 		 	= this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.Nom
							
							
								' *****************************************************************************************
								' *** EVENEMENT : Si l'utilisateur clique dans la fenetre avec sa souris (CLICK) ***
								' *****************************************************************************************
								
								IF (Type_Clic AND 1) OR (Type_Clic AND 2) OR (Type_Clic AND 3) Then

									' On indique qu'on FOCUS un picturebox
									this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_TYPE = CPCDOS_INSTANCE.SCI_INSTANCE.GUI_TYPE.Fenetre
									
									' Avec son index
									this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_FOCUS_INDEX = _INDEX_FENETRE_
									
									Evenement_A_Executer = "Click"
									
									IF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.EV_Click = True Then
										IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
											IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
												DEBUG("[SCI] Appel d'un evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "(VALEUR) Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
											else
												DEBUG("[SCI] Calling graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "(VALUE) Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
											End if
										end if
										
										
										' Si l'utilisateur clique avec nimporte quel bouton de la souris (Click) ou (Click(Valeur))
										CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
														":=##/F:" & Nom_Objet & "." & Evenement_A_Executer & "(" & Type_Clic & ")", _CLE_OBJ_ , 2, 0, "")

										IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
											IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
												DEBUG("[SCI] FIN de l'evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "(VALEUR) Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
												DEBUG("[SCI] Appel d'un evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
											else
												DEBUG("[SCI] END graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "(VALUE) Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
												DEBUG("[SCI] Calling graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
											End if
										end if

										CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
														":=##/F:" & Nom_Objet & "." & Evenement_A_Executer & "()", _CLE_OBJ_ , 2, 0, "")
														
										IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
											IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
												DEBUG("[SCI] FIN de l'evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
											else
												DEBUG("[SCI] END graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
											End if
										end if
									End if

			
								Else
								
								
									' *****************************************************************************************************
									' *** EVENEMENT : Si l'utilisateur ENTRE la souris dans la fenetre pour la premiere fois (MouseEnter) ***
									' *****************************************************************************************************
									
									IF NOT this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Fichier_evenement = "" Then
										IF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Survole = FALSE Then
										
										
											Evenement_A_Executer = "MouseEnter"
										
											IF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.EV_MouseEnter = True Then
												IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
													IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
														DEBUG("[SCI] Appel d'un evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
													else
														DEBUG("[SCI] Calling graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
													End if
												end if
												
												
												CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
														":=##/F:" & Nom_Objet & "." & Evenement_A_Executer & "()", _CLE_OBJ_ , 2, 0, "")
														
												IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
													IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
														DEBUG("[SCI] FIN de l'evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
													else
														DEBUG("[SCI] END graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
													End if
												end if
											End if
											' L'objet est en cours de survole
											this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Survole = TRUE
											
										End if
									End if
									
									
									' *****************************************************************************
									' *** EVENEMENT : Si l'utilisateur se deplace DANS la fenetre (MouseMove) ***
									' *****************************************************************************
									
									IF NOT this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Fichier_evenement = "" Then
									
										Evenement_A_Executer = "MouseMove"
										
										IF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.EV_MouseMove = True Then
											IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then

												IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
													DEBUG("[SCI] Appel d'un evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
												else
													DEBUG("[SCI] Calling graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
												End if
											end if
											
											CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
																":=##/F:" & Nom_Objet & "." & Evenement_A_Executer & "()", _CLE_OBJ_ , 2, 0, "")
																
											IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
												IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
													DEBUG("[SCI] FIN de l'evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
												else
													DEBUG("[SCI] END graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
												End if
											end if
										End if
										' L'objet est en cours de survole
										this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Survole = TRUE
									End if
								End if
							End if
						End if ' If Evenement_Sur_Objet = FALSE Then
						
						' doevents(0)
						
					exit for ' une fois qu'on a clique dedans, ca sert a rien de chercher plus loin
					
					End if ' Clique a l'interieur de la fenetre (Hors de la barre de titre)
				Else
					EV_HorsFenetre = TRUE
				End if
			Else
				EV_HorsFenetre = TRUE
			End if
			
			' ****************************************************************************
			' *** EVENEMENT : Si l'utilisateur SORT/Ne survole des objets (MouseLeave) ***
			' ****************************************************************************
			IF Evenement_Sur_Objet = FALSE Then
				Dim OBJET_SURVOLE_INDEX__TMP as integer = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX
				IF OBJET_SURVOLE_INDEX__TMP > 0 Then
					
					' Si le picturebox n'a pas eu sa souris qui a "leave" on force son execution evenementielle
					IF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = this.GUI_TYPE.Bouton Then
						if this.INST_INIT_GUI.GUI__BOUTON(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Survole = TRUE Then
						
							this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = 0
							this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = 0
							
							Fichier_evenement = this.INST_INIT_GUI.GUI__BOUTON(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Fichier_evenement
						
							' Si l'evenement existe
							if NOT Fichier_evenement = "" Then
							
								_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__BOUTON(OBJET_SURVOLE_INDEX__TMP).Identification_Objet._CLE_
								Nom_Objet 		 	= this.INST_INIT_GUI.GUI__BOUTON(OBJET_SURVOLE_INDEX__TMP).Identification_Objet.Nom
					
								this.INST_INIT_GUI.GUI__BOUTON(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Survole = FALSE
								
								Evenement_A_Executer = "MouseLeave"
								
								IF this.INST_INIT_GUI.GUI__BOUTON(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.EV_MouseLeave = True Then
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] Appel d'un evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] Calling graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
										
									' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
									CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
														":=##/F:" & Nom_Objet & "." & Evenement_A_Executer & "()", _CLE_OBJ_ , 2, 0, "")
														
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] FIN de l'evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] END graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
								End if
							End if
						End if
						
					' Si le bouton n'a pas eu sa souris qui a "leave" on force son execution evenementielle
					ElseIF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = this.GUI_TYPE.PictureBox Then
						IF this.INST_INIT_GUI.GUI__PICTUREBOX(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Survole = TRUE Then
						
							this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = 0
							this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = 0
							
							Fichier_evenement = this.INST_INIT_GUI.GUI__PICTUREBOX(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Fichier_evenement
						
							' Si l'evenement existe
							if NOT Fichier_evenement = "" Then
							
								_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__PICTUREBOX(OBJET_SURVOLE_INDEX__TMP).Identification_Objet._CLE_
								Nom_Objet 		 	= this.INST_INIT_GUI.GUI__PICTUREBOX(OBJET_SURVOLE_INDEX__TMP).Identification_Objet.Nom
					
								this.INST_INIT_GUI.GUI__PICTUREBOX(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Survole = FALSE
								
								Evenement_A_Executer = "MouseLeave"
								
								IF this.INST_INIT_GUI.GUI__PICTUREBOX(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.EV_MouseLeave = True Then
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] Appel d'un evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] Calling graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
										
									' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
									CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
														":=##/F:" & Nom_Objet & "." & Evenement_A_Executer & "()", _CLE_OBJ_ , 2, 0, "")
														
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] FIN de l'evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] END graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
								End if
							End if
						End if
						
					' Si le bouton n'a pas eu sa souris qui a "leave" on force son execution evenementielleI
					ElseIF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = this.GUI_TYPE.TextBlock Then
						IF this.INST_INIT_GUI.GUI__TEXTBLOCK(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Survole = TRUE Then
						
							this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = 0
							this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = 0
							
							Fichier_evenement = this.INST_INIT_GUI.GUI__TEXTBLOCK(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Fichier_evenement
						
							' Si l'evenement existe
							if NOT Fichier_evenement = "" Then
							
								_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__TEXTBLOCK(OBJET_SURVOLE_INDEX__TMP).Identification_Objet._CLE_
								Nom_Objet 		 	= this.INST_INIT_GUI.GUI__TEXTBLOCK(OBJET_SURVOLE_INDEX__TMP).Identification_Objet.Nom
					
								this.INST_INIT_GUI.GUI__TEXTBLOCK(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Survole = FALSE
								
								Evenement_A_Executer = "MouseLeave"
								
								IF this.INST_INIT_GUI.GUI__TEXTBLOCK(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.EV_MouseLeave = True Then
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] Appel d'un evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] Calling graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
										
									' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
									CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
														":=##/F:" & Nom_Objet & "." & Evenement_A_Executer & "()", _CLE_OBJ_ , 2, 0, "")
														
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] FIN de l'evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] END graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
								End if
							End if
						End if ' Survole = TRUE
						
					' Si le textebox n'a pas eu sa souris qui a "leave" on force son execution evenementielleI
					ElseIF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = this.GUI_TYPE.TextBox Then
						IF this.INST_INIT_GUI.GUI__TEXTBOX(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Survole = TRUE Then
						
							this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = 0
							this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = 0
							
							Fichier_evenement = this.INST_INIT_GUI.GUI__TEXTBOX(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Fichier_evenement
						
							' Si l'evenement existe
							if NOT Fichier_evenement = "" Then
							
								_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__TEXTBOX(OBJET_SURVOLE_INDEX__TMP).Identification_Objet._CLE_
								Nom_Objet 		 	= this.INST_INIT_GUI.GUI__TEXTBOX(OBJET_SURVOLE_INDEX__TMP).Identification_Objet.Nom
					
								this.INST_INIT_GUI.GUI__TEXTBOX(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Survole = FALSE
								
								Evenement_A_Executer = "MouseLeave"
								
								IF this.INST_INIT_GUI.GUI__TEXTBOX(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.EV_MouseLeave = True Then
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] Appel d'un evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] Calling graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
										
									' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
									CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
														":=##/F:" & Nom_Objet & "." & Evenement_A_Executer & "()", _CLE_OBJ_ , 2, 0, "")
														
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] FIN de l'evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] END graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
								End if
							End if
						End if ' Survole = TRUE
					ElseIF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = this.GUI_TYPE.ProgressBar Then
						IF this.INST_INIT_GUI.GUI__PROGRESSBAR(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Survole = TRUE Then
						
							this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = 0
							this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = 0
							
							Fichier_evenement = this.INST_INIT_GUI.GUI__PROGRESSBAR(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Fichier_evenement
						
							' Si l'evenement existe
							if NOT Fichier_evenement = "" Then
							
								_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__PROGRESSBAR(OBJET_SURVOLE_INDEX__TMP).Identification_Objet._CLE_
								Nom_Objet 		 	= this.INST_INIT_GUI.GUI__PROGRESSBAR(OBJET_SURVOLE_INDEX__TMP).Identification_Objet.Nom
					
								this.INST_INIT_GUI.GUI__PROGRESSBAR(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Survole = FALSE
								
								Evenement_A_Executer = "MouseLeave"
								
								IF this.INST_INIT_GUI.GUI__PROGRESSBAR(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.EV_MouseLeave = True Then
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] Appel d'un evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] Calling graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
										
									' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
									CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
														":=##/F:" & Nom_Objet & "." & Evenement_A_Executer & "()", _CLE_OBJ_ , 2, 0, "")
														
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] FIN de l'evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] END graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
								End if
							End if
						End if ' Survole = TRUE
					ElseIF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = this.GUI_TYPE.CheckBox Then
						IF this.INST_INIT_GUI.GUI__CHECKBOX(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Survole = TRUE Then
						
							this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = 0
							this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = 0
							
							Fichier_evenement = this.INST_INIT_GUI.GUI__CHECKBOX(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Fichier_evenement
						
							' Si l'evenement existe
							if NOT Fichier_evenement = "" Then
							
								_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__CHECKBOX(OBJET_SURVOLE_INDEX__TMP).Identification_Objet._CLE_
								Nom_Objet 		 	= this.INST_INIT_GUI.GUI__CHECKBOX(OBJET_SURVOLE_INDEX__TMP).Identification_Objet.Nom
					
								this.INST_INIT_GUI.GUI__CHECKBOX(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Survole = FALSE
								
								Evenement_A_Executer = "MouseLeave"
								
								IF this.INST_INIT_GUI.GUI__CHECKBOX(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.EV_MouseLeave = True Then
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] Appel d'un evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] Calling graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
										
									' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
									CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
														":=##/F:" & Nom_Objet & "." & Evenement_A_Executer & "()", _CLE_OBJ_ , 2, 0, "")
														
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] FIN de l'evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] END graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
								End if
							End if
						End if ' Survole = TRUE
					ElseIF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = this.GUI_TYPE.Explorer Then
						if this.INST_INIT_GUI.GUI__EXPLORER(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Survole = TRUE Then
						
							this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = 0
							this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = 0
							
							Fichier_evenement = this.INST_INIT_GUI.GUI__EXPLORER(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Fichier_evenement
						
							' Si l'evenement existe
							if NOT Fichier_evenement = "" Then
							
								_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__EXPLORER(OBJET_SURVOLE_INDEX__TMP).Identification_Objet._CLE_
								Nom_Objet 		 	= this.INST_INIT_GUI.GUI__EXPLORER(OBJET_SURVOLE_INDEX__TMP).Identification_Objet.Nom
					
								this.INST_INIT_GUI.GUI__EXPLORER(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Survole = FALSE
								
								Evenement_A_Executer = "MouseLeave"
								
								IF this.INST_INIT_GUI.GUI__EXPLORER(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.EV_MouseLeave = True Then
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] Appel d'un evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] Calling graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
										
									' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
									CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
														":=##/F:" & Nom_Objet & "." & Evenement_A_Executer & "()", _CLE_OBJ_ , 2, 0, "")
														
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] FIN de l'evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] END graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
								End if
							End if
						End if
					ElseIF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = this.GUI_TYPE.Listbox Then
						if this.INST_INIT_GUI.GUI__LISTBOX(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Survole = TRUE Then
						
							this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_INDEX = 0
							this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).OBJET_SURVOLE_TYPE = 0
							
							Fichier_evenement = this.INST_INIT_GUI.GUI__LISTBOX(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Fichier_evenement
						
							' Si l'evenement existe
							if NOT Fichier_evenement = "" Then
							
								_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__LISTBOX(OBJET_SURVOLE_INDEX__TMP).Identification_Objet._CLE_
								Nom_Objet 		 	= this.INST_INIT_GUI.GUI__LISTBOX(OBJET_SURVOLE_INDEX__TMP).Identification_Objet.Nom
					
								this.INST_INIT_GUI.GUI__LISTBOX(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.Survole = FALSE
								
								Evenement_A_Executer = "MouseLeave"
								
								IF this.INST_INIT_GUI.GUI__LISTBOX(OBJET_SURVOLE_INDEX__TMP).PROP_TYPE.EV_MouseLeave = True Then
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] Appel d'un evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] Calling graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
										
									' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
									CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
														":=##/F:" & Nom_Objet & "." & Evenement_A_Executer & "()", _CLE_OBJ_ , 2, 0, "")
														
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] FIN de l'evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] END graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> " & Evenement_A_Executer & "() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
								End if
							End if
						End if
					End if ' .OBJET_SURVOLE_TYPE
				End if ' IF OBJET_SURVOLE_INDEX__TMP > 0 Then
			End if
			
			
			' *********************************************************************************
			' *** EVENEMENT : Si l'utilisateur SORT/Ne survole plus la fenetre (MouseLeave) ***
			' *********************************************************************************
			
			IF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Survole = TRUE Then
				this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Survole = FALSE
				' Si on est bien HORS de la fenetre, qu'il n'y a eu aucun evenements avec les objets et qu'un EV est dispo
				IF EV_HorsFenetre = TRUE Then
					IF Evenement_Sur_Objet = FALSE Then
					
						Fichier_evenement = this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Fichier_evenement
						
						' Si l'evenement existe
						if NOT Fichier_evenement = "" Then
						
							_CLE_OBJ_ 	 		= this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet._CLE_
							Nom_Objet 		 	= this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).Identification_Objet.Nom
				
							IF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Survole = TRUE Then
								this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.Survole = FALSE
								
								IF this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).PROP_TYPE.EV_MouseClick = True Then
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] Appel d'un evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> MouseLeave() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] Calling graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> MouseLeave() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
									
									' Si la souris de l'utilisateur sort de l'objet (MouseLeave)
									CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
														":=##/F:" & Nom_Objet & ".MouseLeave()", _CLE_OBJ_ , 2, 0, "")
														
									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] FIN de l'evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> MouseLeave() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] END graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> MouseLeave() Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if
								End if
							End if
						End if
					End if
				End if
			End if
		End if ' CLE !
		
	Next _INDEX_
	
	return 1
End Function

Function _SCI_Cpcdos_OSx__.Interaction_TOUCHE(Pos_Souris_X as integer, Pos_Souris_Y as integer, _INDEX_FENETRE_ as integer, POSITION_X as integer, POSITION_Y as integer, TAILLE_X as integer, TAILLE_Y as integer) as Boolean
	' Cette fonction permet de savoir si le pointage graphique est pointe DANS le conteneur ENFANT du conteneur PARENT 
	'  ( exemple, si l'utilisateur clique sur un bouton, ca permet de savoir si le curseur se trouve a l'interieur)
	
	' Pos_Souris_X	: Position X du pointage.
	' Pos_Souris_X	: Position Y du pointage.
	' _INDEX_FENETRE_: index de la fenetre.
	' POSITION_X	: Position X de l'axe origine X du conteneur.
	' POSITION_X	: Position X de l'axe origine X du conteneur.
	' TAILLE_X		: Taille X du conteneur.
	' TAILLE_Y		: Taille Y de conteneur.
	
	'  Retourne 
	'  TRUE : Le pointage est dans l'objet
	'  FALSE: Le pointage est HORS de l'objet
	
	' *********************************************************************************
	' Position X > (Position X de la fenetre + Position X de l'objet DANS la fenetre)
	' ET
	' Position X < (Position X de la fenetre + Position X de l'objet + Taille X de l'objet )
	' *********************************************************************************
	if Pos_Souris_X > (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + POSITION_X) _
	   AND Pos_Souris_X < (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_X + POSITION_X + TAILLE_X) Then
		' L'utilisateur a clique dans le conteneur de l'objet qui correspond a l'axe X									
		
		' *********************************************************************************
		' Position Y > (Position Y de la fenetre (+taille titre) + Position Y de l'objet DANS la fenetre)
		' ET
		' Position Y < (Position Y de la fenetre (+taille titre) + Position Y de l'objet + Taille Y de l'objet )
		' *********************************************************************************
		if Pos_Souris_Y > (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y + POSITION_Y) _
		   AND Pos_Souris_Y < (this.INST_INIT_GUI.GUI__FENETRE(_INDEX_FENETRE_).POS_Y + POSITION_Y + TAILLE_Y) Then
			' *********************************************************************************
			' L'utilisateur a clique dans le conteneur de l'objet qui correspond a l'axe Y	
			' *********************************************************************************
		
			Interaction_TOUCHE = TRUE
			exit function
		End if
	End if
	Interaction_TOUCHE = FALSE
End function

Function _SCI_Cpcdos_OSx__.Fenetre_FOCUS(INDEX_FENETRE as integer) as integer
	' Cette fonction permet d'afficher au premier plan la fenetre choisie

	ScreenLock

	' Verifier s'il y a un fenetre prioritaire, si oui on la laisse focus
	if INDEX_FENETRE > 0 Then
		IF CPCDOS_INSTANCE.SCI_INSTANCE.priority_window > 0 Then 
			IF get_OSid() = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).Identification_Objet.OS_id Then
				if NOT this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).Identification_Objet.Nom = "" Then
					INDEX_FENETRE = CPCDOS_INSTANCE.SCI_INSTANCE.priority_window
				Else
					CPCDOS_INSTANCE.SCI_INSTANCE.priority_window = 0
				End if
			Else
				' Si l'os ID n'est pas la bonne, on l'enleve
				CPCDOS_INSTANCE.SCI_INSTANCE.priority_window = 0
			End if
		End if
	End if

	dim a_fenetre as integer = this.INST_INIT_GUI.POSITION(1)
	
	IF INDEX_FENETRE > 0 Then
		IF get_OSid() = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).Identification_Objet.OS_id Then
			' Mettre cette fenetre au premier plan si c'est pas la meme
			IF this.INST_INIT_GUI.POSITION(1) <> INDEX_FENETRE THEN
				
				Changer_PremierPlan_OrdreFenetrale(INDEX_FENETRE)
			END IF
			ActualiserGUI(0, INDEX_FENETRE)
		End if
		Fenetre_FOCUS = 1
	Else
		Fenetre_FOCUS = this.INST_INIT_GUI.POSITION(1)
	end if
	
	ScreenUnlock
End Function

Function _SCI_Cpcdos_OSx__.Sizing_window_button(SizeUP as boolean, INDEX_FENETRE as integer) as boolean
	' Cette fonction permet d'agrandir ou de retrecir la taille de la fenetre
	' SizeUP : TRUE = FAIRE agrandir
	'		   FALSE = FAIRE retrecir
	' Renvoie false si probleme
	
	if SizeUP = true Then ' On va AGRANDIR
	
		' Sauvegarder les positions originales
		this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).POS_X_ORG = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).POS_X
		this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).POS_Y_ORG = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).POS_Y
		
		' Sauvegarder les tailles originales
		this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).SIZ_X_ORG = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).SIZ_X
		this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).SIZ_Y_ORG = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).SIZ_Y
		
		' Recuperer la taille de l'ecran
		Dim Resolution_X as integer = CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_Resolution_X()
		Dim Resolution_Y as integer = CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_Resolution_Y()
	
		' Preparer le full screen!
		this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).POS_X = 0 + val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.WINDOW.fullscreen_left", 3, _CLE_))
		this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).POS_Y = 0 + val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.WINDOW.fullscreen_top", 3, _CLE_))
		this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).SIZ_X = Resolution_X - val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.WINDOW.fullscreen_right", 3, _CLE_))
		this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).SIZ_Y = Resolution_Y - val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.WINDOW.fullscreen_down", 3, _CLE_))
		

	else ' On va RETRECIR
	
		' Restaurer les position originales
		this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).POS_X = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).POS_X_ORG
		this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).POS_Y = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).POS_Y_ORG
		
		' Restaurer les tailles originales
		this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).SIZ_X = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).SIZ_X_ORG
		this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).SIZ_Y = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).SIZ_Y_ORG
	
	End if
	
	this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).PROP_TYPE.SizeUP = SizeUP
	
	
	Dim Fichier_evenement as String = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).PROP_TYPE.Fichier_evenement
						
	' Si l'evenement existe
	if NOT Fichier_evenement = "" Then
	
		Dim _CLE_OBJ_ as double = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).Identification_Objet._CLE_
		Dim Nom_Objet as String = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).Identification_Objet.Nom
		
		IF this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).PROP_TYPE.EV_Resize = True Then
		
			IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
				IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
					DEBUG("[SCI] Appel d'un evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> Resize(VALEUR) Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				else
					DEBUG("[SCI] Calling graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> Resize(VALUE) Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				End if
			end if

			if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":Resize(1)") > 0 Then
				if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
							":=##/F:" & Nom_Objet & ".Resize(" & SizeUP &")", _CLE_OBJ_ , 2, 0, "") _
							= "ERR_050" Then
										
					' Black LIST EVENT !
					CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":Resize(1);"
					IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
						DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":Resize(1)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
					End if
				End if
			end if
								
			IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
				IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
					DEBUG("[SCI] FIN de l'evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> Resize(VALEUR) Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				else
					DEBUG("[SCI] END graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> Resize(VALUE) Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				End if
			end if
		End if
	End if
	
	' Executer l'evenement ResizeEnd
	Sizing_window_ending(INDEX_FENETRE)

	
	Fenetre_FOCUS(INDEX_FENETRE)
	
	return true
End Function

Function _SCI_Cpcdos_OSx__.Sizing_window_ending(INDEX_FENETRE as integer) as boolean
	' Cette fonction permet d'executer l'evenement du ResizeEnd()

		
	' Recuperer les dimensions
	Dim Siz_X as integer = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).Siz_X
	Dim Siz_Y as integer = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).Siz_Y
	
	
	
	Dim Fichier_evenement as String = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).PROP_TYPE.Fichier_evenement
						
	' Si l'evenement existe
	if NOT Fichier_evenement = "" Then
	
		Dim _CLE_OBJ_ as double = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).Identification_Objet._CLE_
		Dim Nom_Objet as String = this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).Identification_Objet.Nom
		
		IF this.INST_INIT_GUI.GUI__FENETRE(INDEX_FENETRE).PROP_TYPE.EV_Resize = True Then
		
			IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
				IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
					DEBUG("[SCI] Appel d'un evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> ResizeEnd(VALEUR,VALEUR) Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				else
					DEBUG("[SCI] Calling graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> ResizeEnd(VALUE,VALUE) Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				End if
			end if

			if NOT instr(CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire, Fichier_evenement & "->" & Nom_Objet & ":ResizeEnd(2)") > 0 Then
				if CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CpcdosCP_SHELL("##FONCTION=:" & Fichier_evenement & _
							":=##/F:" & Nom_Objet & ".ResizeEnd(" & Siz_X & "," & Siz_Y &")", _CLE_OBJ_ , 2, 0, "") _
							= "ERR_050" Then
										
					' Black LIST EVENT !
					CPCDOS_INSTANCE.SCI_INSTANCE.Event_Liste_Noire += Fichier_evenement & "->" & Nom_Objet & ":ResizeEnd(2);"
					IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
						DEBUG("[SCI] BLACK LIST EVENT " & Fichier_evenement & "->" & Nom_Objet & ":ResizeEnd(2)", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, CPCDOS_INSTANCE.SCI_INSTANCE.RetourVAR)
					End if
				End if
			end if
								
			IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
				IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
					DEBUG("[SCI] FIN de l'evenement graphique (" & Nom_Objet & " CLE:" & HEX(_CLE_OBJ_, 8) & ") --> ResizeEnd(VALEUR,VALEUR) Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				else
					DEBUG("[SCI] END graphical event (" & Nom_Objet & " KEY:" & HEX(_CLE_OBJ_, 8) & ") --> ResizeEnd(VALUE,VALUE) Source '" & Fichier_evenement & "'.", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				End if
			end if
		End if
	End if
	
	return true
End Function

Function _SCI_Cpcdos_OSx__.DeplacerFenetre_TO_POS(POS_X as integer, POS_Y as integer) as integer
	REM Cette fonction permet de deplacer la fenetre via la souris

	IF get_OSid() = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.DEPLACEMENT).Identification_Objet.OS_id Then

		


		' Modifier la position X et Y
		this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.DEPLACEMENT).POS_X = POS_X
		this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.DEPLACEMENT).POS_Y = POS_Y

		' Appliquer une correction
		CPCDOS_INSTANCE.SCI_INSTANCE.Collision_correction(this.INST_INIT_GUI.DEPLACEMENT)

		
		' Redessiner la fenetre
		Creer_Fenetre(this.INST_INIT_GUI.DEPLACEMENT)
	End if

	return 1

End function

Function _SCI_Cpcdos_OSx__.DeplacerFenetre_TO_SIZE(SIZE_X as integer, SIZE_Y as integer) as integer
	REM Cette fonction permet de resize la fenetre via la souris

	IF get_OSid() = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).Identification_Objet.OS_id Then

		if SIZE_X < 50 Then SIZE_X = 50
		if SIZE_Y < 10 Then SIZE_Y = 10

		' Modifier la position X et Y
		this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).SIZ_X = SIZE_X + 5
		this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).SIZ_Y = SIZE_Y + 5

		' Corriger la taille selon les donnees utilisateur
		if this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).PROP_TYPE.Minimal_size_X > 0 Then
			if SIZE_X < this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).PROP_TYPE.Minimal_size_X Then
				this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).SIZ_X = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).PROP_TYPE.Minimal_size_X
			End if
		end if

		if this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).PROP_TYPE.Minimal_size_Y > 0 Then
			if SIZE_Y < this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).PROP_TYPE.Minimal_size_Y Then
				this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).SIZ_Y = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).PROP_TYPE.Minimal_size_Y
			End if
		end if

		if this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).PROP_TYPE.Maximal_size_X > 0 Then
			if SIZE_X > this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).PROP_TYPE.Maximal_size_X Then
				this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).SIZ_X = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).PROP_TYPE.Maximal_size_X
			End if
		end if

		if this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).PROP_TYPE.Maximal_size_Y > 0 Then
			if SIZE_Y > this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).PROP_TYPE.Maximal_size_Y Then
				this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).SIZ_Y = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).PROP_TYPE.Maximal_size_Y
			End if
		end if

		' Forcer a reloader les bitmaps
		this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.REDIMENTIONNEMENT).design_Image_LOADED = false

		' Redessiner la fenetre
		Creer_Fenetre(this.INST_INIT_GUI.REDIMENTIONNEMENT)
	End if

	return 1

End function

Function _SCI_Cpcdos_OSx__.ActualiserGUI(ModeActu as integer, index as integer) as integer
	REM Cette fonction permet d'actualiser graphiquement la GUI
	REM ModeActu :
	' 0 	: Actualise TOUT!
	' 1 	: Actualise la fenetre indique dans index
	' 2		: Actualise TOUT sauf la fenetre undique dans index
	' 3		: Actualise uniquement via le buffer 2
	

	ENTRER_SectionCritique()
	
	
	
	if ModeActu = 0 then ' Actualise TOUT!
		
		' Copier le fond d'ecran vers le buffer principal
		Flip 2, 1
		
		' Afficher les fenetre relatif a l'ordre fenetrale
		For _INDEX_ as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_FENETRE

			if this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_) = DESKTOPMODE_Index_Fenetre Then Continue For


			If this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).PROP_TYPE.Reduit = true Then Continue for
			If this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).PROP_TYPE.Ferme = true Then Continue for

			IF this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_) <> 0 _
						AND this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.handle > 0 Then
				
				IF get_OSid() = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.OS_id Then
					Creer_Fenetre(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))
				
					' Si le handle correspond a la fenetre, alors on trace le PictureBox
					For b as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_PICTUREBOX
						IF this.INST_INIT_GUI.GUI__PICTUREBOX(b).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.handle _
								AND this.INST_INIT_GUI.GUI__PICTUREBOX(b).Identification_Objet.Handle_PARENT > 0 Then
								
							Creer_PictureBox(b, this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))
						END IF
					Next b
					
					' Si le handle correspond a la fenetre, alors on trace le Bouton
					For b as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_BOUTON
						IF this.INST_INIT_GUI.GUI__BOUTON(b).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.handle _
								AND this.INST_INIT_GUI.GUI__BOUTON(b).Identification_Objet.Handle_PARENT > 0 Then
								
							Creer_Bouton(b, this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))
						END IF
					Next b
					
					
					' Si le handle correspond a la fenetre, alors on trace le Textebloc
					For b as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_TEXTBLOCK
						IF this.INST_INIT_GUI.GUI__TEXTBLOCK(b).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.Handle _
								AND this.INST_INIT_GUI.GUI__TEXTBLOCK(b).Identification_Objet.Handle_PARENT > 0 Then
								
							Creer_TextBlock(b, this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))
						END IF
					Next b
					
					' Si le handle correspond a la fenetre, alors on trace le Textebox
					For b as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_TEXTBOX
						IF this.INST_INIT_GUI.GUI__TEXTBOX(b).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.Handle _
								AND this.INST_INIT_GUI.GUI__TEXTBOX(b).Identification_Objet.Handle_PARENT > 0 Then
							
							Creer_TextBox(b, this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))
						END IF
					Next b
					
					' Si le handle correspond a la fenetre, alors on trace la progressbar
					For b as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_PROGRESSBAR
						IF this.INST_INIT_GUI.GUI__PROGRESSBAR(b).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.Handle _
								AND this.INST_INIT_GUI.GUI__PROGRESSBAR(b).Identification_Objet.Handle_PARENT > 0 Then
								
							Creer_ProgressBar(b, this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))
						END IF
					Next b
					
					' Si le handle correspond a la fenetre, alors on trace le Checkbox
					For b as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_CHECKBOX
						IF this.INST_INIT_GUI.GUI__CHECKBOX(b).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.Handle _
								AND this.INST_INIT_GUI.GUI__CHECKBOX(b).Identification_Objet.Handle_PARENT > 0 Then
								
							Creer_CheckBox(b, this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))
						END IF
					Next b
					
					' Si le handle correspond a la fenetre, alors on trace l'explorer
					For b as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_EXPLORER
						IF this.INST_INIT_GUI.GUI__EXPLORER(b).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.handle _
								AND this.INST_INIT_GUI.GUI__EXPLORER(b).Identification_Objet.Handle_PARENT > 0 Then
								
							Creer_Explorer(b, this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))
						END IF
					Next b

					' Si le handle correspond a la fenetre, alors on trace le listbox
					For b as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_LISTBOX
						IF this.INST_INIT_GUI.GUI__LISTBOX(b).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.handle _
								AND this.INST_INIT_GUI.GUI__LISTBOX(b).Identification_Objet.Handle_PARENT > 0 Then
								
							Creer_Listbox(b, this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))
						END IF
					Next b

					' Afficher la taskbar si disponible
					if this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).PROP_TYPE.TaskBar > 0 Then
						Display_Taskbar(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))

					End if
					
				End if
			End if
		Next _INDEX_
	elseif ModeActu = 1 then ' Actualiser uniquement un objet d'une fenetre
	
	elseif ModeActu = 2 then ' Actualise tout sauf la fenetre indique dans index
		
		' Copier le fond d'ecran vers le buffer principal
		Flip 2, 1
		
		' Afficher les fenetre relatif a l'ordre fenetrale
		For _INDEX_ as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_FENETRE

			if this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_) = DESKTOPMODE_Index_Fenetre Then Continue For

			If this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).PROP_TYPE.Reduit = true Then Continue for

			IF this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_) <> 0  _
						AND this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.handle > 0 Then
						
				IF this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_) <> index Then ' Si c'est pas la fenetre
					
					IF get_OSid() = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.OS_id Then
						Creer_Fenetre(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))

						' Si le PID correspond a la fenetre, alors on trace le bouton
						For b as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_BOUTON
							IF this.INST_INIT_GUI.GUI__BOUTON(b).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.handle _
									AND this.INST_INIT_GUI.GUI__BOUTON(b).Identification_Objet.Handle_PARENT > 0 Then
									
								Creer_Bouton( b, this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))
							END IF
						Next b
						
						' Si le PID correspond a la fenetre, alors on trace le PictureBox
						For b as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_PICTUREBOX
							IF this.INST_INIT_GUI.GUI__PICTUREBOX(b).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.Handle _
									AND this.INST_INIT_GUI.GUI__PICTUREBOX(b).Identification_Objet.Handle_PARENT > 0 Then
									
								Creer_PictureBox(b, this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))
							END IF
						Next b
						
						' Si le PID correspond a la fenetre, alors on trace le Textbox
						For b as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_TEXTBLOCK
							IF this.INST_INIT_GUI.GUI__TEXTBLOCK(b).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.Handle _
									AND this.INST_INIT_GUI.GUI__TEXTBLOCK(b).Identification_Objet.Handle_PARENT > 0 Then
									
								Creer_TextBlock(b, this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))
							END IF
						Next b
						
						' Si le PID correspond a la fenetre, alors on trace la progressbar
						For b as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_PROGRESSBAR
							IF this.INST_INIT_GUI.GUI__PROGRESSBAR(b).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.Handle _
									AND this.INST_INIT_GUI.GUI__PROGRESSBAR(b).Identification_Objet.Handle_PARENT > 0 Then
									
								Creer_ProgressBar(b, this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))
							END IF
						Next b
						
						' Si le PID correspond a la fenetre, alors on trace le checkbox
						For b as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_CHECKBOX
							IF this.INST_INIT_GUI.GUI__CHECKBOX(b).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.Handle _
									AND this.INST_INIT_GUI.GUI__CHECKBOX(b).Identification_Objet.Handle_PARENT > 0 Then
									
								Creer_CheckBox(b, this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))
							END IF
						Next b
						
						' Si le PID correspond a la fenetre, alors on trace le Explorer
						For b as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_EXPLORER
							IF this.INST_INIT_GUI.GUI__EXPLORER(b).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.handle _
									AND this.INST_INIT_GUI.GUI__EXPLORER(b).Identification_Objet.Handle_PARENT > 0 Then
									
								Creer_Explorer(b, this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))
							END IF
						Next b

						' Si le PID correspond a la fenetre, alors on trace le listbox
						For b as integer = 1 to CPCDOS_INSTANCE._MAX_GUI_LISTBOX
							IF this.INST_INIT_GUI.GUI__LISTBOX(b).Identification_Objet.Handle_PARENT = this.INST_INIT_GUI.GUI__FENETRE(this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_)).Identification_Objet.handle _
									AND this.INST_INIT_GUI.GUI__LISTBOX(b).Identification_Objet.Handle_PARENT > 0 Then
									
								Creer_Listbox(b, this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - _INDEX_))
							END IF
						Next b
						
					End if
				End if
			End if
		Next _INDEX_
	
	elseif ModeActu = 3 then ' Actualise uniquement via le buffer 2	
	
		' Copier le fond d'ecran vers le buffer principal
		Flip 2, 1
		
	end if
	
	SORTIR_SectionCritique()
	
	return 1
End function

Function _SCI_Cpcdos_OSx__.Display_Taskbar(index_fenetre as integer) as boolean
	' Cette fonction permet d'afficher la barre de taches au dessus des objets d'une fenetre dediee

	' Verifier si c'est autorise
	if this.INST_INIT_GUI.GUI__FENETRE(index_fenetre).PROP_TYPE.TaskBar > 0 Then

		' ------------ TASKBAR ------------

		' Recuperer le nom de fichier du fond d'ecran du menu contextuel
		dim Image_Normal as string = CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.NORMAL", 3, this._CLE_)
		dim Image_Focus as string = CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.FOCUS", 3, this._CLE_)

		Dim Espacement_X as integer = Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.SPACING_X", 3, this._CLE_))
		Dim Espacement_Y as integer = Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.SPACING_Y", 3, this._CLE_))

		' Position de la barre des taches
		Dim Pos_X as integer = this.INST_INIT_GUI.GUI__FENETRE(index_fenetre).POS_X + Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.POS_X", 3, this._CLE_))
		Dim Pos_Y as integer = this.INST_INIT_GUI.GUI__FENETRE(index_fenetre).POS_Y + Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.POS_Y", 3, this._CLE_))

		' Taille de la barre des taches
		Dim Size_X as integer = Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.SIZ_X", 3, this._CLE_))
		Dim Size_Y as integer = Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.SIZ_Y", 3, this._CLE_))

		if Size_X > this.INST_INIT_GUI.GUI__FENETRE(index_fenetre).SIZ_X Then Size_X = this.INST_INIT_GUI.GUI__FENETRE(index_fenetre).SIZ_X
		if Size_Y > this.INST_INIT_GUI.GUI__FENETRE(index_fenetre).SIZ_Y Then Size_Y = this.INST_INIT_GUI.GUI__FENETRE(index_fenetre).SIZ_Y



		' ------------ PAR ITEMS ------------

		' Taille max du texte
		Dim Size_text	as integer = Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.SIZ_TEXT", 3, this._CLE_))

		' Position du texte
		Dim Pos_Text_X 	as integer = Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.POS_TEXT_X", 3, this._CLE_))
		Dim Pos_Text_Y 	as integer = Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.POS_TEXT_Y", 3, this._CLE_))

		' Position de l'icone
		Dim Pos_Icon_X 	as integer = Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.POS_ICON_X", 3, this._CLE_))
		Dim Pos_Icon_Y 	as integer = Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.POS_ICON_Y", 3, this._CLE_))

		' Taille de l'icone
		Dim Siz_Icon_X 	as integer = Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.SIZ_ICON_X", 3, this._CLE_))
		Dim Siz_Icon_Y 	as integer = Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.SIZ_ICON_Y", 3, this._CLE_))

		' Taille des elements de la barre des taches
		Dim Size_X_item as integer = Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.SIZ_ITEM_X", 3, this._CLE_))
		Dim Size_Y_item as integer = Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.SIZ_ITEM_Y", 3, this._CLE_))

		' Couleur des elements textuels
		dim Couleur_FNT_R as integer = Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.TEXT_R", 3, this._CLE_))
		dim Couleur_FNT_V as integer = Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.TEXT_G", 3, this._CLE_))
		dim Couleur_FNT_B as integer = Val(CPCDOS_INSTANCE.SHELLCCP_INSTANCE.CCP_Lire_Variable("CPC_GUI.TASKBAR.TEXT_B", 3, this._CLE_))


		if CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_Standard_ID < 1 Then
			IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
				IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
					DEBUG("[SCI] Display_Taskbar() Chargement image taskbar normal de " & Image_Normal, CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				else
					DEBUG("[SCI] Display_Taskbar() Loading normal taskbar image from de " & Image_Normal, CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				End if
			end if
			
			' Charger l'image et recuperer son ID
			CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_Standard_ID = CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Creer_BITMAP_depuis_FILE(Image_Normal, 123)
			CPCDOS_INSTANCE.SYSTEME_INSTANCE.Memoire_MAP.ReSize_BITMAP(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_Standard_ID, Size_X_item, Size_Y_item)

			IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
				IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
					DEBUG("[SCI] Display_Taskbar() " & Image_Normal & " --> id:" & CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_Standard_ID & " charge en memoire a l'adresse [0x" & HEX(CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Recuperer_BITMAP_PTR(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_Standard_ID)) & "]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_VALIDATION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				else
					DEBUG("[SCI] Display_Taskbar() " & Image_Normal & " --> id:" & CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_Standard_ID & " loaded in memory at address [0x" & HEX(CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Recuperer_BITMAP_PTR(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_Standard_ID)) & "]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_VALIDATION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				End if
			end if
		Else
			IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
				IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
					DEBUG("[SCI] Display_Taskbar() image taskbar normal de " & Image_Normal & " deja chargee", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				else
					DEBUG("[SCI] Display_Taskbar() normal taskbar image " & Image_Normal & " already loaded", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				End if
			end if
		End if

		if CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_Focus_ID < 1 Then
			IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
				IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
					DEBUG("[SCI] Display_Taskbar() Chargement image taskbar focus de" & Image_Focus, CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				else
					DEBUG("[SCI] Display_Taskbar() Loading focus taskbar image from de " & Image_Focus, CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				End if
			end if

			' Charger l'image et recuperer son ID
			CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_Focus_ID = CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Creer_BITMAP_depuis_FILE(Image_Focus, 123)
			CPCDOS_INSTANCE.SYSTEME_INSTANCE.Memoire_MAP.ReSize_BITMAP(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_Focus_ID, Size_X_item, Size_Y_item)

			IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
				IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
					DEBUG("[SCI] Display_Taskbar() " & Image_Focus & " --> id:" & CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_Focus_ID & " charge en memoire a l'adresse [0x" & HEX(CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Recuperer_BITMAP_PTR(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_Focus_ID)) & "]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_VALIDATION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				else
					DEBUG("[SCI] Display_Taskbar() " & Image_Focus & " --> id:" & CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_Focus_ID & " loaded in memory at address [0x" & HEX(CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Recuperer_BITMAP_PTR(CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_Focus_ID)) & "]", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_VALIDATION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				End if
			end if
		Else
			IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
				IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
					DEBUG("[SCI] Display_Taskbar() image taskbar normal de " & Image_Focus & " deja chargee", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				else
					DEBUG("[SCI] Display_Taskbar() normal taskbar image " & Image_Focus & " already loaded", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_OK, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
				End if
			end if
		End if

		if this.INST_INIT_GUI.GUI__FENETRE(index_fenetre).PROP_TYPE.TaskBar = 1 Then
			' Horizontale

			Dim indexage as integer = 0
			Dim Positionnement_X as integer = 1
			For boucle as integer = 0 to CPCDOS_INSTANCE._MAX_GUI_FENETRE

				' Pas la peine d'afficher plus si y'en a deja assez !
				if indexage > CPCDOS_INSTANCE.SCI_INSTANCE._MAX_Taskbar_Elements Then exit for

				' Si c'est pas une taskbar, ni un desktop
				if this.INST_INIT_GUI.GUI__FENETRE(boucle).PROP_TYPE.TaskBar = 0 AND this.INST_INIT_GUI.GUI__FENETRE(boucle).PROP_TYPE.DESKTOPMODE = 0 Then
					if this.INST_INIT_GUI.GUI__FENETRE(boucle).PROP_TYPE.NoTaskBar = false Then
						if NOT this.INST_INIT_GUI.GUI__FENETRE(boucle).Identification_Objet.Nom = "" Then
						
							' Recuperer tous les elements pour creer un item

							' ID de l'icone de fenetre deja charge
							Dim Icone_Fenetre_ID as integer = 0

							if this.INST_INIT_GUI.GUI__FENETRE(boucle).ICONE_IMG_Resized_TaskBar > 0 Then
								' S'il y a deja un profil avec une icone traitee, on prend celle la !
								Icone_Fenetre_ID = this.INST_INIT_GUI.GUI__FENETRE(boucle).ICONE_IMG_Resized_TaskBar

							Else
								' Sinon on prend l'originale
								Icone_Fenetre_ID = this.INST_INIT_GUI.GUI__FENETRE(boucle).ICONE_IMG_ID
							
								Dim tmp_sx as integer = CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Recuperer_BITMAP_x(Icone_Fenetre_ID)
								Dim tmp_sy as integer = CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Recuperer_BITMAP_y(Icone_Fenetre_ID)

								' Si sa taille est differente a ce que l'utilisateur souhaite
								if CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Recuperer_BITMAP_x(Icone_Fenetre_ID) <> Siz_Icon_X OR CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Recuperer_BITMAP_y(Icone_Fenetre_ID) <> Siz_Icon_Y Then

									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
											DEBUG("[SCI] Display_Taskbar() [0x" & hex(this._CLE_) & "] Taille icone differente (" & tmp_sx & "x" & tmp_sy & ") resizing en (" & Siz_Icon_X & "x" & Siz_Icon_Y & ").", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_AVERTISSEMENT, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										else
											DEBUG("[SCI] Display_Taskbar() [0x" & hex(this._CLE_) & "] Size different icon (" & tmp_sx & "x" & tmp_sy & ") resizing to (" & Siz_Icon_X & "x" & Siz_Icon_Y & ").", CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_AVERTISSEMENT, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if

									' On la resize et on l'enregistre
									this.INST_INIT_GUI.GUI__FENETRE(boucle).ICONE_IMG_Resized_TaskBar = CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.ReSize_BITMAP_NewID(Icone_Fenetre_ID, Siz_Icon_X, Siz_Icon_Y)

									' Et on le recupere
									Icone_Fenetre_ID = this.INST_INIT_GUI.GUI__FENETRE(boucle).ICONE_IMG_Resized_TaskBar

									IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
										if Icone_Fenetre_ID > 0 Then
											DEBUG("[SCI] Display_Taskbar() [0x" & hex(this._CLE_) & "] Ok ! ICONE_IMG_Resized_TaskBar : " & Icone_Fenetre_ID, CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_AVERTISSEMENT, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										Else
											DEBUG("[SCI] Display_Taskbar() [0x" & hex(this._CLE_) & "] [ERROR] ! ICONE_IMG_Resized_TaskBar : " & Icone_Fenetre_ID, CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ERREUR, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
										End if
									end if

								End if
							End if

							' Titre de la fenetre
							Dim Titre_Fenetre as String = this.INST_INIT_GUI.GUI__FENETRE(boucle).TITRE
							if Len(Titre_Fenetre) > 12 Then Titre_Fenetre = Mid(Titre_Fenetre, 1, 9) & "..."

							' Si la fenetre est FOCUS ou non, l'apparence ne sera pas la meme
							Dim Focus_Fenetre as boolean
							if this.INST_INIT_GUI.POSITION(1) = boucle Then 
								Focus_Fenetre = true
							else
								Focus_Fenetre = false
							End if


							IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
								IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
									DEBUG("[SCI] Display_Taskbar() [0x" & hex(this._CLE_) & "] Buffer_drawing(0x" & hex(CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_EcranPTR(), 8) & ") " & Pos_X + Positionnement_X & "," & Pos_Y & " " & Size_X_item & "," & Size_Y_item , CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
								else
									DEBUG("[SCI] Display_Taskbar() [0x" & hex(this._CLE_) & "] Buffer_drawing(0x" & hex(CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_EcranPTR(), 8) & ") " & Pos_X + Positionnement_X & "," & Pos_Y & " " & Size_X_item & "," & Size_Y_item , CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
								End if
							end if

							CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_index_Position	(indexage) = boucle
							CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_px				(indexage) = Pos_X + Positionnement_X
							CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_py				(indexage) = Pos_Y

							CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_sx				(indexage) = Size_X_item
							CPCDOS_INSTANCE.SCI_INSTANCE.TaskBar_sy				(indexage) = Size_Y_item

							indexage += 1

							if Focus_Fenetre = true Then
								' Image de l'item selected
								CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Dessiner_ecran(TaskBar_Focus_ID, Pos_X + Positionnement_X, Pos_Y, 0, 0, Size_X_item, Size_Y_item)
							Else
								' Image de l'item non selected
								CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Dessiner_ecran(TaskBar_Standard_ID, Pos_X + Positionnement_X, Pos_Y, 0, 0, Size_X_item, Size_Y_item)
							End if

							' Ajouter l'icone de l'application
							CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Dessiner_ecran(Icone_Fenetre_ID, Pos_X + Positionnement_X + Pos_Icon_X, Pos_Y + Pos_Icon_Y, 0, 0, Size_X_item, Size_Y_item)

							' Ajouter le nom de l'application
							CPCDOS_INSTANCE.SYSTEME_INSTANCE.MEMOIRE_MAP.Ecrire_ecran(Titre_Fenetre, Pos_X + Positionnement_X + Pos_Text_X, Pos_Y + Pos_Text_Y, Couleur_FNT_R, Couleur_FNT_V, Couleur_FNT_B)

							IF CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_DBG_DEBUG() > 0 Then
								IF CPCDOS_INSTANCE.Utilisateur_Langage = 0 Then
									DEBUG("[SCI] Display_Taskbar() [0x" & hex(this._CLE_) & "] Fin du dessin" , CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
								else
									DEBUG("[SCI] Display_Taskbar() [0x" & hex(this._CLE_) & "] End drawing" , CPCDOS_INSTANCE.DEBUG_INSTANCE.Ecran, CPCDOS_INSTANCE.DEBUG_INSTANCE.NonLog, CPCDOS_INSTANCE.DEBUG_INSTANCE.Couleur_ACTION, 0, CPCDOS_INSTANCE.DEBUG_INSTANCE.CRLF, CPCDOS_INSTANCE.DEBUG_INSTANCE.AvecDate, CPCDOS_INSTANCE.DEBUG_INSTANCE.SIGN_CPCDOS, this.RetourVAR)
								End if
							end if


							Positionnement_X += Size_X_item + 5
						End if
					End if
				End if
			Next boucle
			
			return true
		Elseif this.INST_INIT_GUI.GUI__FENETRE(index_fenetre).PROP_TYPE.TaskBar = 2 Then
			' Verticale


			return true
		End if

	End if

	' Pas de barre des taches dans l'OS !

	return false
End Function

Function _SCI_Cpcdos_OSx__.Changer_PremierPlan_OrdreFenetrale(NouvelleFenetre as integer) as integer
	REM Cette fonction permet de mettre la fenetre indique au premier plan

	IF get_OSid() = this.INST_INIT_GUI.GUI__FENETRE(NouvelleFenetre).Identification_Objet.OS_id Then
		IF NOT this.INST_INIT_GUI.POSITION(1) = NouvelleFenetre then
			' Chercher et supprimer l'ancienne position
			Dim Debut as integer = 0
			For Debut = 0 to CPCDOS_INSTANCE._MAX_GUI_FENETRE
				IF this.INST_INIT_GUI.POSITION(Debut) = NouvelleFenetre Then
					For ORDRE as integer = Debut to CPCDOS_INSTANCE._MAX_GUI_FENETRE
						this.INST_INIT_GUI.POSITION(Debut) = this.INST_INIT_GUI.POSITION(Debut + 1)
					Next ORDRE
				End if
			Next Debut

			' Deplacer l'ordre fenetrale pour liberer la position 1
			For ORDRE as integer = 0 to CPCDOS_INSTANCE._MAX_GUI_FENETRE -1 ' Correction : Ajout du -1 le 08/03/2019
				this.INST_INIT_GUI.POSITION(CPCDOS_INSTANCE._MAX_GUI_FENETRE - ORDRE) = this.INST_INIT_GUI.POSITION((CPCDOS_INSTANCE._MAX_GUI_FENETRE - (ORDRE+1)))
			Next ORDRE
				
			' Et definir la position 1 pour CETTE fenetre ;)
			this.INST_INIT_GUI.POSITION(1) = NouvelleFenetre
		End IF
	End if
	
	Changer_PremierPlan_OrdreFenetrale = 1
End Function

Function _SCI_Cpcdos_OSx__.Interaction_SOURIS_OBJ(Index_Fenetre as integer) as integer
	REM Cette fonction permet de savoir sur quelle objet l'utilisateur a clique
	REM Renvoie le PID
	
	' For boucle as integer 1 to _MAX_GUI_
	
	Interaction_SOURIS_OBJ = 1
End Function


Sub _SCI_Cpcdos_OSx__.Collision_correction(Index_Fenetre as integer)
	' Cette fonction permet de corriger la sortie d'ecran relatif a des coordonnees programmes dans WIN_SCR.CPC

	if CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__FENETRE(Index_Fenetre).PROP_TYPE.Collision = true Then
		' ===========================================
		' ***** Collision aux abords de l'ecran *****
		' ===========================================

		Dim Taille_X_ecran as integer 	= CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_Resolution_X()
		Dim Taille_Y_ecran as integer 	= CPCDOS_INSTANCE.SYSTEME_INSTANCE.get_Resolution_Y()

		' Gauche
		if CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__FENETRE(Index_Fenetre).Pos_X <= -CPCDOS_INSTANCE.SCI_INSTANCE.screen_collision_left Then
			CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__FENETRE(Index_Fenetre).POS_X = -CPCDOS_INSTANCE.SCI_INSTANCE.screen_collision_left
		End if

		' Haut
		if CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__FENETRE(Index_Fenetre).Pos_Y <= -CPCDOS_INSTANCE.SCI_INSTANCE.screen_collision_top Then
			CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__FENETRE(Index_Fenetre).POS_Y = -CPCDOS_INSTANCE.SCI_INSTANCE.screen_collision_top
		End if

		' Droite
		if CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__FENETRE(Index_Fenetre).Pos_X + CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__FENETRE(Index_Fenetre).Siz_X > Taille_X_ecran + CPCDOS_INSTANCE.SCI_INSTANCE.screen_collision_right  Then
			CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__FENETRE(Index_Fenetre).POS_X = (Taille_X_ecran + CPCDOS_INSTANCE.SCI_INSTANCE.screen_collision_right) - CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__FENETRE(Index_Fenetre).Siz_X
		End if

		' Bas
		if CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__FENETRE(Index_Fenetre).Pos_Y + CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__FENETRE(Index_Fenetre).Siz_Y > Taille_Y_ecran + CPCDOS_INSTANCE.SCI_INSTANCE.screen_collision_down  Then
			CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__FENETRE(Index_Fenetre).POS_Y = (Taille_Y_ecran + CPCDOS_INSTANCE.SCI_INSTANCE.screen_collision_down) - CPCDOS_INSTANCE.SCI_INSTANCE.INST_INIT_GUI.GUI__FENETRE(Index_Fenetre).Siz_Y
		End if

	end if ' Collision
End sub
