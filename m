Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A865246441
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 12:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHQKRr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 06:17:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:39462 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgHQKRq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 06:17:46 -0400
IronPort-SDR: 73o/qQj0o8JQg1Yl0jCuUU8Cnzlts16jNm7dmfxQeLr7SUzIV5IA6eDDNYJX3QG/REjOHqK/9c
 34mz1EP4JOag==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="154648037"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="154648037"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 03:17:46 -0700
IronPort-SDR: CoYmT4vadO1YRsuKPGQNgqbHL2QoBwuuBnEmdEhmN4D2w6Rf93xKC2LYYk5ryOz2nq6A5VtH1w
 NFRCdT2QDv/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="326368963"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2020 03:17:43 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1k7bw6-009Hfg-BU; Mon, 17 Aug 2020 13:00:14 +0300
Date:   Mon, 17 Aug 2020 13:00:14 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        linux-kernel@vger.kernel.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Subject: Re: [PATCH v2 1/5] dt-bindings: dma: dw: Add optional DMA-channels
 mask cell support
Message-ID: <20200817100014.GG1891694@smile.fi.intel.com>
References: <20200731200826.9292-1-Sergey.Semin@baikalelectronics.ru>
 <20200731200826.9292-2-Sergey.Semin@baikalelectronics.ru>
 <20200803215147.GA3201744@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803215147.GA3201744@bogus>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Aug 03, 2020 at 03:51:47PM -0600, Rob Herring wrote:
> On Fri, 31 Jul 2020 23:08:22 +0300, Serge Semin wrote:
> > Each DW DMA controller channel can be synthesized with different
> > parameters like maximum burst-length, multi-block support, maximum data
> > width, etc. Most of these parameters determine the DW DMAC channels
> > performance in its own aspect. On the other hand these parameters can
> > be implicitly responsible for the channels performance degradation
> > (for instance multi-block support is a very useful feature, but having
> > it disabled during the DW DMAC synthesize will provide a more optimized
> > core). Since DMA slave devices may have critical dependency on the DMA
> > engine performance, let's provide a way for the slave devices to have
> > the DMA-channels allocated from a pool of the channels, which according
> > to the system engineer fulfill their performance requirements.
> > 
> > The pool is determined by a mask optionally specified in the fifth
> > DMA-cell of the DMA DT-property. If the fifth cell is omitted from the
> > phandle arguments or the mask is zero, then the allocation will be
> > performed from a set of all channels provided by the DMA controller.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Rob, I have a question to clarify (it's not directly related to the series,
but to this schema and property names).

We have two drivers for DMA controllers from Synopsys (they are different)
where properties with the same semantics (like block_size or data-width) have
different pattern of naming (okay, block_size for older driver even has _
instead of -), i.e. block_size vs. snps,block-size and data-width vs.
snps,data-width.

I would like to unify them (*) in both drivers and would like to know which
naming pattern is preferred in such case?

*) Yes, we have to leave support for deprecated properties in this case in
   the code.

-- 
With Best Regards,
Andy Shevchenko


