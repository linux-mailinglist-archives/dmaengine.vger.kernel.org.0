Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ED31CF111
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2020 11:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgELJIF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 May 2020 05:08:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:40872 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgELJIF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 May 2020 05:08:05 -0400
IronPort-SDR: C6eIVAzKrKUdAjWa4LxTUXAN9hAYi/2yMG73h0gScD+45i5hE4+CukNgg1veYTv7oM348Y0Zf4
 j/GaWXogP7tg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 02:08:05 -0700
IronPort-SDR: tK8Y1hj8lywcychMAVWY2TQBVdiHUmt66zVihP/hHXEbPQEzpNav1j/mL8IDsfr+cdnbEG0t44
 teUKiXogRV6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="265443794"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 12 May 2020 02:08:01 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jYQtQ-00694C-A8; Tue, 12 May 2020 12:08:04 +0300
Date:   Tue, 12 May 2020 12:08:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: dma: dw: Add max burst transaction
 length property
Message-ID: <20200512090804.GR185537@smile.fi.intel.com>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-3-Sergey.Semin@baikalelectronics.ru>
 <20200508111242.GH185537@smile.fi.intel.com>
 <20200511200528.nfkc2zkh3bvupn7l@mobilestation>
 <20200511210138.GN185537@smile.fi.intel.com>
 <20200511213531.wnywlljiulvndx6s@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511213531.wnywlljiulvndx6s@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 12, 2020 at 12:35:31AM +0300, Serge Semin wrote:
> On Tue, May 12, 2020 at 12:01:38AM +0300, Andy Shevchenko wrote:
> > On Mon, May 11, 2020 at 11:05:28PM +0300, Serge Semin wrote:
> > > On Fri, May 08, 2020 at 02:12:42PM +0300, Andy Shevchenko wrote:
> > > > On Fri, May 08, 2020 at 01:53:00PM +0300, Serge Semin wrote:
> > > > > This array property is used to indicate the maximum burst transaction
> > > > > length supported by each DMA channel.
> > > > 
> > > > > +  snps,max-burst-len:
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > +    description: |
> > > > > +      Maximum length of burst transactions supported by hardware.
> > > > > +      It's an array property with one cell per channel in units of
> > > > > +      CTLx register SRC_TR_WIDTH/DST_TR_WIDTH (data-width) field.
> > > > > +    items:
> > > > > +      maxItems: 8
> > > > > +      items:
> > > > 
> > > > > +        enum: [4, 8, 16, 32, 64, 128, 256]
> > > > 
> > > > Isn't 1 allowed?
> > > 
> > > Burst length of 1 unit is supported, but in accordance with Data Book the MAX
> > > burst length is limited to be equal to a value from the set I submitted. So the
> > > max value can be either 4, or 8, or 16 and so on.
> > 
> > Hmm... It seems you mistakenly took here DMAH_CHx_MAX_MULT_SIZE pre-silicon
> > configuration parameter instead of runtime as described in Table 26:
> > CTLx.SRC_MSIZE and DEST_MSIZE Decoding.
> 
> No. You misunderstood what I meant. We shouldn't use a runtime parameters values
> here. Why would we?

Because what we describe in the DTS is what user may do to the hardware. In
some cases user might want to limit this to 1, how to achieve that?

Rob, is there any clarification that schema describes only synthesized values?
Or i.o.w. shall we allow user to setup whatever hardware supports at run time?

> Property "snps,max-burst-len" matches DMAH_CHx_MAX_MULT_SIZE
> config parameter.

Why? User should have a possibility to ask whatever hardware supports at run time.

> See a comment to the "SRC_MSIZE" and "DEST_MSIZE" fields of the
> registers. You'll find out that their maximum value is determined by the
> DMAH_CHx_MAX_MULT_SIZE parameter, which must belong to the set [4, 8, 16, 32, 64,
> 128, 256]. So no matter how you synthesize the DW DMAC block you'll have at least
> 4x max burst length supported.

That's true.


-- 
With Best Regards,
Andy Shevchenko


