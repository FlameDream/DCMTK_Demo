/*
 *
 *  Copyright (C) 1994-2016, OFFIS e.V.
 *  All rights reserved.  See COPYRIGHT file for details.
 *
 *  This software and supporting documentation were developed by
 *
 *    OFFIS e.V.
 *    R&D Division Health
 *    Escherweg 2
 *    D-26121 Oldenburg, Germany
 *
 *
 *  Module:  dcmdata
 *
 *  Author:  Gerd Ehlers
 *
 *  Purpose: include most dcmdata files that are usually required
 *
 */

#ifndef DCTK_H
#define DCTK_H

#include "../config/osconfig.h"    /* make sure OS specific configuration is included first */

// various headers
#include "../dcmdata/dctypes.h"
#include "../dcmdata/dcswap.h"
#include "../dcmdata/dcistrma.h"
#include "../dcmdata/dcostrma.h"
#include "../dcmdata/dcvr.h"
#include "../dcmdata/dcxfer.h"
#include "../dcmdata/dcuid.h"
#include "../ofstd/ofdefine.h"

// tags and dictionary
#include "../dcmdata/dctagkey.h"
#include "../dcmdata/dctag.h"
#include "../dcmdata/dcdicent.h"
#include "../dcmdata/dchashdi.h"
#include "../dcmdata/dcdict.h"
#include "../dcmdata/dcdeftag.h"

// basis classes
#include "../dcmdata/dcobject.h"
#include "../dcmdata/dcelem.h"

// classes for management of sequences and other lists
#include "../dcmdata/dcitem.h"
#include "../dcmdata/dcmetinf.h"
#include "../dcmdata/dcdatset.h"
#include "../dcmdata/dcsequen.h"
#include "../dcmdata/dcfilefo.h"
#include "../dcmdata/dcdicdir.h"
#include "../dcmdata/dcpixseq.h"

// element classes for string management (8-bit)
#include "../dcmdata/dcbytstr.h"
#include "../dcmdata/dcvrae.h"
#include "../dcmdata/dcvras.h"
#include "../dcmdata/dcvrcs.h"
#include "../dcmdata/dcvrda.h"
#include "../dcmdata/dcvrds.h"
#include "../dcmdata/dcvrdt.h"
#include "../dcmdata/dcvris.h"
#include "../dcmdata/dcvrtm.h"
#include "../dcmdata/dcvrui.h"
#include "../dcmdata/dcvrur.h"

// element classes for string management (8-bit and/or multi-byte)
#include "../dcmdata/dcchrstr.h"
#include "../dcmdata/dcvrlo.h"
#include "../dcmdata/dcvrlt.h"
#include "../dcmdata/dcvrpn.h"
#include "../dcmdata/dcvrsh.h"
#include "../dcmdata/dcvrst.h"
#include "../dcmdata/dcvruc.h"
#include "../dcmdata/dcvrut.h"

// element class for byte and word value representations
#include "../dcmdata/dcvrobow.h"
#include "../dcmdata/dcpixel.h"
#include "../dcmdata/dcovlay.h"

// element classes for binary value fields
#include "../dcmdata/dcvrat.h"
#include "../dcmdata/dcvrss.h"
#include "../dcmdata/dcvrus.h"
#include "../dcmdata/dcvrsl.h"
#include "../dcmdata/dcvrul.h"
#include "../dcmdata/dcvrulup.h"
#include "../dcmdata/dcvrfl.h"
#include "../dcmdata/dcvrfd.h"
#include "../dcmdata/dcvrof.h"
#include "../dcmdata/dcvrod.h"
#include "../dcmdata/dcvrol.h"

// misc supporting tools
#include "../dcmdata/cmdlnarg.h"

#endif /* DCTK_H */
