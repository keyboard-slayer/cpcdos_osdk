' OBJ (Objets)
' Systeme de gestion graphique utilisateur
' par FAVIER Sebastien
' commence le 21/07/2016

' Mise a jour le 16 Janvier 2017

'	======================
'	=      --   --   --  =    --    -     --
'	=     |    |__| |    =   |  ) (   )   \
'	=      --  |     --  =    --    -    --
'	==========================================
'		--   --   --    =  --    -     --    =
'      |    |__| |      = |  ) (   )   \     =
'		--  |     --    =  --    -    --     =
'	                    ======================
rem option gosub

' Inclure les declarations du projet entier

#include once "cpcdos.bi"

' 16-01-2018	: Adaptation des buffeurs BITMAP avec l'instance de la classe MEMOIRE_MAP
'					- PictureBox
'					- ProgressBar
'					- CheckBox
'					- TexteBox
' 17-12-2017	: AJOUT du CheckBox/ et de l'effet de survole
'					+ AJOUT de l'effet de survole du bouton
' 10-12-2017	: AJOUT de la barre de progression (Debut 22-11-2017)
' 15-11-2017	: MODIFICATION du support opacite pour les fenetres
'					+ CORRECTION des crashs du type:1
' 26-10-2017	: AJOUT du support du TexteBox
' 10-10-2017	: Separation des fichiers d'objets
'					+ Correction de la taille X du textebloc qui �tait egale a la taille du precedent
'						objet initialise.
' 15-09-2017	: Revue des crashs du picturebox (Reecriture complete en vue)
' 17-07-2017	: AJOUT du textebloc
' 08-07-2017	: AJOUT du bouton graphique!
'					+ Ajout de l'evenement MouseClic et MouseClic() des qu'on relache le clic.
' 06-07-2017	: Correction des fuites de memoire des fenetres et des picturebox (deplacement et IUG/ again)
' 28-06-2017	: Correction d'un bug d'agrandissement de la picturebox selon la position de la fenetre
'					+ Ajustage des modification des proprietes pour les picturebox
'					+ Ajout des informations de debogage pour les picturebox
' 21-06-2017	: Ajustage des modification des proprietes pour la fenetre
'					+ Ajout des informations de debogage pour la fenetre
' 30-05-2017	: Ajout des ombres, Transparences, proprietes graphiques des fenetres et pictures box
' 16-AVL-2021   : Debut de refonte de la window


' Decommenter pour restaurer l'ancienne fenetre
'#include once "OBJ_Fenetre.BAS"
#include once "obj_window.bas"

#include once "obj_bouton.bas"
#include once "obj_picturebox.bas"
#include once "obj_textebloc.bas"
#include once "obj_textbox.bas"
#include once "obj_progressbar.bas"
#include once "obj_checkbox.bas"
#include once "obj_explorer.bas"
#include once "obj_listbox.bas"





