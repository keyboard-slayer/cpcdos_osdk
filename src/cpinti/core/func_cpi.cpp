/*	
	======================================
	==     CPinti ---> Fonctions CPinti ==
	======================================
	
	Developpe entierement par Sebastien FAVIER

	Description
		Module regroupant toutes les fonctions hors classes
		 utiles afin d'accompagner CPinti Core dans ses besoins ;)
	
	Creation 
		19/10/2016

	Mise a jour
		07/12/2017
		
		07-12-2017	: AMELIORATION du code en suivant une procedure sticte de GCC
		14-02-2017	: Ajout des fonctions string --> to uint, long et int
		06-01-2016	: Ajout des fonction de compatibilites WATTCP (_w32_intel)
	
*/

#include <iostream>
#include <sstream> 
#include <time.h>
#include <sys/select.h>

#include "func_cpi.h"
#include "core.h"
#include <stdio.h>
// #include "leakchk.h"

 
// extern "C" unsigned short _w32_intel (unsigned short val)
// {
	// return cpinti::Func_Cpinti::_w32_intel(val);
// }

// extern "C" unsigned short _w32_intel16 (unsigned short val)
// {
	// return cpinti::Func_Cpinti::_w32_intel16(val);
// }

namespace cpinti
{
	namespace Func_Cpinti
	{
		
		unsigned long _w32_intel (unsigned long val)
		{
			// Cette methode permet de convertir en BIGENDIAN 32 bits
			return 	((val & 0x000000FFU) << 24) | // Deplacer le bit faible a gauche
					((val & 0x0000FF00U) <<  8) |
					((val & 0x00FF0000U) >>  8) |
					((val & 0xFF000000U) >> 24);  // Deplacer le bit fort a droite
		}

		unsigned short _w32_intel16 (unsigned short val)
		{
			// Cette methode permet de convertir en BIGENDIAN 16 bits
			return ((val & 0x00FF) << 8) | ((val & 0xFF00) >> 8);
		}

		std::string to_string(int nombre)
		{
			// Cette methode permet de convertir du int --> string
			
			std::stringstream convertir;
			convertir << nombre;
			return convertir.str();
		}
		
		std::string to_string(unsigned int nombre)
		{
			// Cette methode permet de convertir du unsigned int --> string
			
			std::stringstream convertir;
			convertir << nombre;
			return convertir.str();
		}
		
		
		std::string to_string(long nombre)
		{
			// Cette methode permet de convertir du long --> string
			
			std::stringstream convertir;
			convertir << nombre;
			return convertir.str();
		}
		
		std::string to_string(double nombre)
		{
			// Cette methode permet de convertir du double --> string
			
			std::stringstream convertir;
			convertir << nombre;
			return convertir.str();
		}
		
		std::string to_string(long unsigned int nombre)
		{
			// Cette methode permet de convertir du double --> string
			
			std::stringstream convertir;
			convertir << nombre;
			return convertir.str();
		}
		
		std::string to_string(short unsigned int nombre)
		{
			// Cette methode permet de convertir du double --> string
			
			std::stringstream convertir;
			convertir << nombre;
			return convertir.str();
		}
		
		int to_int(std::string nombre)
		{
			// Cette methode permet de convertir du String --> int
			int Resultat;
			std::istringstream ( nombre ) >> Resultat;
			return Resultat;
		}
		
		unsigned int to_uint(std::string nombre)
		{
			// Cette methode permet de convertir du String --> unsigned int
			unsigned int Resultat;
			std::istringstream ( nombre ) >> Resultat;
			return Resultat;
		}
		
		unsigned long to_ulong(std::string nombre)
		{
			// Cette methode permet de convertir du String --> unsigned int
			unsigned long Resultat;
			std::istringstream ( nombre ) >> Resultat;
			return Resultat;
		}
		
		long to_long(std::string nombre)
		{
			// Cette methode permet de convertir du String --> long
			long Resultat;
			std::istringstream ( nombre ) >> Resultat;
			return Resultat;
		}
		
		std::string to_str_hex(int nombre)
		{
			// Cette methode permet de convertir du string --> hexa
			
			std::stringstream sstream;
			sstream << std::hex << nombre;
			return sstream.str();
		}
		
		std::string to_str_hex(unsigned int nombre)
		{
			// Cette methode permet de convertir du string --> hexa
			
			std::stringstream sstream;
			sstream << std::hex << nombre;
			return sstream.str();
		}
		
		std::string to_str_hex(long unsigned int nombre)
		{
			// Cette methode permet de convertir du string --> hexa
			
			std::stringstream sstream;
			sstream << std::hex << nombre;
			return sstream.str();
		}
		
		unsigned short Generer_CheckSum(void* TRAME, size_t Taille)
		{	
			unsigned short *Buffer = (unsigned short *) TRAME;
			unsigned int 	SUM=0;
			unsigned short 	Resultat;

			for ( SUM = 0; Taille > 1; Taille -= 2 )
				SUM += *Buffer++;
			
			if ( Taille == 1 )
				SUM += *(unsigned char*)Buffer;
			
			SUM = (SUM >> 16) + (SUM & 0xFFFF);
			SUM += (SUM >> 16);
			Resultat = ~SUM;
			return Resultat;
		}
		
		long Comparer_Temps (struct timeval *Temps_DEPART, struct timeval *Temps_ACTUEL)
		{
			long Resultat = (long int) (((Temps_DEPART->tv_sec*1000000) + (long unsigned int) Temps_DEPART->tv_usec) - ((Temps_ACTUEL->tv_sec*1000000) + (long unsigned int) Temps_ACTUEL->tv_usec))/100000000;
			return Resultat;

		}
	} // namespace func_cpi
	
	
	//***********************//
	
	void cpinti_doevents()
	{
		cpinti_doevents(1);
	}
	
	void cpinti_doevents(unsigned long Temps)
	{


		// PEACE FOR YOUR CPU
		if(Temps < 1)
		{
			gestionnaire_tache::Interruption_Timer(0);
		}
		else
		{
			cpinti_USleep(Temps);
		}
	}
}

