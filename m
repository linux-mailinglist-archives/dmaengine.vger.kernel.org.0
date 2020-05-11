Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906AF1CE676
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 23:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbgEKVCD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 17:02:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:46854 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732394AbgEKVCC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 May 2020 17:02:02 -0400
IronPort-SDR: FxP6TRRGHphqbp6jDxLoZXUEBv25bZKRIqXHajCn3WHBWk128mbUQ7PDACgs+XU5z/s3GPVbLy
 +9OcQ7E2RpXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 14:01:39 -0700
IronPort-SDR: rm1hhYS517j4tRfG8qoVJZn+JTLquoo7K7+mgWFQddz7WgPeNX5R+Tvnm0hdl0TpEecMCJAPnB
 tXC7fyMLlgSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="463521700"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 11 May 2020 14:01:37 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jYFYQ-0063Cu-VM; Tue, 12 May 2020 00:01:38 +0300
Date:   Tue, 12 May 2020 00:01:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
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
Message-ID: <20200511210138.GN185537@smile.fi.intel.com>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-3-Sergey.Semin@baikalelectronics.ru>
 <20200508111242.GH185537@smile.fi.intel.com>
 <20200511200528.nfkc2zkh3bvupn7l@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511200528.nfkc2zkh3bvupn7l@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 11, 2020 at 11:05:28PM +0300, Serge Semin wrote:
> On Fri, May 08, 2020 at 02:12:42PM +0300, Andy Shevchenko wrote:
> > On Fri, May 08, 2020 at 01:53:00PM +0300, Serge Semin wrote:
> > > This array property is used to indicate the maximum burst transaction
> > > length supported by each DMA channel.
> > 
> > > +  snps,max-burst-len:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    description: |
> > > +      Maximum length of burst transactions supported by hardware.
> > > +      It's an array property with one cell per channel in units of
> > > +      CTLx register SRC_TR_WIDTH/DST_TR_WIDTH (data-width) field.
> > > +    items:
> > > +      maxItems: 8
> > > +      items:
> > 
> > > +        enum: [4, 8, 16, 32, 64, 128, 256]
> > 
> > Isn't 1 allowed?
> 
> Burst length of 1 unit is supported, but in accordance with Data Book the MAX
> burst length is limited to be equal to a value from the set I submitted. So the
> max value can be either 4, or 8, or 16 and so on.

Hmm... It seems you mistakenly took here DMAH_CHx_MAX_MULT_SIZE pre-silicon
configuration parameter instead of runtime as described in Table 26:
CTLx.SRC_MSIZE and DEST_MSIZE Decoding.

-- 
With Best Regards,
Andy Shevchenko


