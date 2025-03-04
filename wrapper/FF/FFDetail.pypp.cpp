// This file has been generated by Py++.

// (C) Christopher Woods, GPL >= 2 License

#include "boost/python.hpp"
#include "FFDetail.pypp.hpp"

namespace bp = boost::python;

#include "SireBase/errors.h"

#include "SireBase/propertylist.h"

#include "SireError/errors.h"

#include "SireStream/datastream.h"

#include "SireStream/shareddatastream.h"

#include "ffdetail.h"

#include <QMutex>

#include "ffdetail.h"

#include "Qt/qdatastream.hpp"

#include "Helpers/str.hpp"

void register_FFDetail_class(){

    { //::SireFF::FFDetail
        typedef bp::class_< SireFF::FFDetail, bp::bases< SireBase::Property >, boost::noncopyable > FFDetail_exposer_t;
        FFDetail_exposer_t FFDetail_exposer = FFDetail_exposer_t( "FFDetail", "This is the base class of the classes that provide details about\nthe forcefield of a molecule or system. The details include the\ncanonical name of the forcefield. When specialised into\nSireMM::MMDetail it describes whether it uses LJ parameters,\ncombining rules, default 1-4 scale factors, functional forms\nof internal parameters etc. etc.\n\nAuthor: Christopher Woods\n", bp::no_init );
        bp::scope FFDetail_scope( FFDetail_exposer );
        { //::SireFF::FFDetail::assertCompatibleWith
        
            typedef void ( ::SireFF::FFDetail::*assertCompatibleWith_function_type)( ::SireFF::FFDetail const & ) const;
            assertCompatibleWith_function_type assertCompatibleWith_function_value( &::SireFF::FFDetail::assertCompatibleWith );
            
            FFDetail_exposer.def( 
                "assertCompatibleWith"
                , assertCompatibleWith_function_value
                , ( bp::arg("other") )
                , "" );
        
        }
        { //::SireFF::FFDetail::forcefields
        
            typedef ::QStringList ( *forcefields_function_type )(  );
            forcefields_function_type forcefields_function_value( &::SireFF::FFDetail::forcefields );
            
            FFDetail_exposer.def( 
                "forcefields"
                , forcefields_function_value
                , "Return a list of all of the forcefields that have been registered" );
        
        }
        { //::SireFF::FFDetail::get
        
            typedef ::SireBase::PropertyPtr ( *get_function_type )( ::QString );
            get_function_type get_function_value( &::SireFF::FFDetail::get );
            
            FFDetail_exposer.def( 
                "get"
                , get_function_value
                , ( bp::arg("forcefield") )
                , "Return the forcefield that has been registered with this name. This\nreturns a null property if there is no property with this name" );
        
        }
        { //::SireFF::FFDetail::isCompatibleWith
        
            typedef bool ( ::SireFF::FFDetail::*isCompatibleWith_function_type)( ::SireFF::FFDetail const & ) const;
            isCompatibleWith_function_type isCompatibleWith_function_value( &::SireFF::FFDetail::isCompatibleWith );
            
            FFDetail_exposer.def( 
                "isCompatibleWith"
                , isCompatibleWith_function_value
                , ( bp::arg("other") )
                , "" );
        
        }
        { //::SireFF::FFDetail::isNull
        
            typedef bool ( ::SireFF::FFDetail::*isNull_function_type)(  ) const;
            isNull_function_type isNull_function_value( &::SireFF::FFDetail::isNull );
            
            FFDetail_exposer.def( 
                "isNull"
                , isNull_function_value
                , "Return whether or not this is null" );
        
        }
        { //::SireFF::FFDetail::name
        
            typedef ::QString ( ::SireFF::FFDetail::*name_function_type)(  ) const;
            name_function_type name_function_value( &::SireFF::FFDetail::name );
            
            FFDetail_exposer.def( 
                "name"
                , name_function_value
                , "Return the name of the forcefield" );
        
        }
        FFDetail_exposer.def( bp::self != bp::self );
        { //::SireFF::FFDetail::operator=
        
            typedef ::SireFF::FFDetail & ( ::SireFF::FFDetail::*assign_function_type)( ::SireFF::FFDetail const & ) ;
            assign_function_type assign_function_value( &::SireFF::FFDetail::operator= );
            
            FFDetail_exposer.def( 
                "assign"
                , assign_function_value
                , ( bp::arg("other") )
                , bp::return_self< >()
                , "" );
        
        }
        FFDetail_exposer.def( bp::self == bp::self );
        { //::SireFF::FFDetail::properties
        
            typedef ::SireBase::Properties ( ::SireFF::FFDetail::*properties_function_type)(  ) const;
            properties_function_type properties_function_value( &::SireFF::FFDetail::properties );
            
            FFDetail_exposer.def( 
                "properties"
                , properties_function_value
                , "Return all of the properties of this forcefield type" );
        
        }
        { //::SireFF::FFDetail::typeName
        
            typedef char const * ( *typeName_function_type )(  );
            typeName_function_type typeName_function_value( &::SireFF::FFDetail::typeName );
            
            FFDetail_exposer.def( 
                "typeName"
                , typeName_function_value
                , "" );
        
        }
        FFDetail_exposer.staticmethod( "forcefields" );
        FFDetail_exposer.staticmethod( "get" );
        FFDetail_exposer.staticmethod( "typeName" );
        FFDetail_exposer.def( "__rlshift__", &__rlshift__QDataStream< ::SireFF::FFDetail >,
                            bp::return_internal_reference<1, bp::with_custodian_and_ward<1,2> >() );
        FFDetail_exposer.def( "__rrshift__", &__rrshift__QDataStream< ::SireFF::FFDetail >,
                            bp::return_internal_reference<1, bp::with_custodian_and_ward<1,2> >() );
        FFDetail_exposer.def( "__str__", &__str__< ::SireFF::FFDetail > );
        FFDetail_exposer.def( "__repr__", &__str__< ::SireFF::FFDetail > );
    }

}
