/********************************************\
  *
  *  Sire - Molecular Simulation Framework
  *
  *  Copyright (C) 2013  Christopher Woods
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License, or
  *  (at your option) any later version.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  *
  *  For full details of the license please see the COPYING file
  *  that should have come with this distribution.
  *
  *  You can contact the authors via the developer's mailing list
  *  at http://siremol.org
  *
\*********************************************/

#ifndef SIRESTREAM_REGISTERALTERNATIVENAME_H
#define SIRESTREAM_REGISTERALTERNATIVENAME_H

#include "sireglobal.h"

SIRE_BEGIN_HEADER

namespace SireStream
{
    void registerAlternativeName(const char *type_name, const char *alternative);

    /** This class is used for static initialisation to register alternative names */
    template<class T>
    class SIRESTREAM_EXPORT RegisterAlternativeName
    {
    public:
        RegisterAlternativeName(const char *alternative)
        {
            registerAlternativeName(T::typeName(), alternative);
        }
        
        ~RegisterAlternativeName()
        {}
    };
    
    namespace detail
    {
        QSet<QString> getAlternativeNames(QString type_name);
    }
}

SIRE_END_HEADER

#endif
