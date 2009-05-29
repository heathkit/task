////////////////////////////////////////////////////////////////////////////////
// task - a command line task list manager.
//
// Copyright 2006 - 2009, Paul Beckingham.
// All rights reserved.
//
// This program is free software; you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation; either version 2 of the License, or (at your option) any later
// version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
// details.
//
// You should have received a copy of the GNU General Public License along with
// this program; if not, write to the
//
//     Free Software Foundation, Inc.,
//     51 Franklin Street, Fifth Floor,
//     Boston, MA
//     02110-1301
//     USA
//
////////////////////////////////////////////////////////////////////////////////

#include <string>
#include "T.h"

////////////////////////////////////////////////////////////////////////////////
T::T ()
{
}

////////////////////////////////////////////////////////////////////////////////
T::T (const std::string& input)
{
  parse (input);
}

////////////////////////////////////////////////////////////////////////////////
T& T::operator= (const T& other)
{
  throw std::string ("unimplemented T::operator=");
  if (this != &other)
  {
//    mOne = other.mOne;
  }

  return *this;
}

////////////////////////////////////////////////////////////////////////////////
T::~T ()
{
}

////////////////////////////////////////////////////////////////////////////////
// [name:value, name:"value",name:[name:value,name:value]]
std::string T::composeF4 ()
{
  throw std::string ("unimplemented T::composeF4");
  return "";
}

////////////////////////////////////////////////////////////////////////////////
std::string T::composeCSV ()
{
  throw std::string ("unimplemented T::composeCSV");
  return "";
}

////////////////////////////////////////////////////////////////////////////////
bool T::validate () const
{
  // TODO Verify until > due
  // TODO Verify entry < until, due, start, end
  return true;
}

////////////////////////////////////////////////////////////////////////////////