Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C051D4B9F
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 12:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgEOKxS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 06:53:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:23818 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgEOKxS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 May 2020 06:53:18 -0400
IronPort-SDR: ZEIiMclK4CAEABoksrY00BYJtZEszQm6oJIz4TqOPd+Uso7A/qffUDWVQXIXRNflsQX+Adfoad
 SOMw5uegyY5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 03:53:18 -0700
IronPort-SDR: Z9jMbhI0bOSAkUctcFuR95gd0AMX/8Mg684Ffh1OGKjfyYJ8M6hkVl1s3Jyl+BbGleFFixE9ab
 lPkSNLmIyqsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="341946497"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 15 May 2020 03:53:11 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZXxp-006qHS-UQ; Fri, 15 May 2020 13:53:13 +0300
Date:   Fri, 15 May 2020 13:53:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] dmaengine: dw: Set DMA device max segment size
 parameter
Message-ID: <20200515105313.GL185537@smile.fi.intel.com>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-4-Sergey.Semin@baikalelectronics.ru>
 <20200508112152.GI185537@smile.fi.intel.com>
 <20200511211622.yuh3ls2ay76yaxrf@mobilestation>
 <20200512123551.GX185537@smile.fi.intel.com>
 <20200515061601.GG333670@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515061601.GG333670@vkoul-mobl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 15, 2020 at 11:46:01AM +0530, Vinod Koul wrote:
> On 12-05-20, 15:35, Andy Shevchenko wrote:
> > On Tue, May 12, 2020 at 12:16:22AM +0300, Serge Semin wrote:
> > > On Fri, May 08, 2020 at 02:21:52PM +0300, Andy Shevchenko wrote:
> > > > On Fri, May 08, 2020 at 01:53:01PM +0300, Serge Semin wrote:

...

> > My point here that we probably can avoid complications till we have real
> > hardware where it's different. As I said I don't remember a such, except
> > *maybe* Intel Medfield, which is quite outdated and not supported for wider
> > audience anyway.
> 
> IIRC Intel Medfield has couple of dma controller instances each one with
> different parameters *but* each instance has same channel configuration.

That's my memory too.

> I do not recall seeing that we have synthesis parameters per channel
> basis... But I maybe wrong, it's been a while.

Exactly, that's why I think we better simplify things till we will have real
issue with it. I.o.w. no need to solve the problem which doesn't exist.

-- 
With Best Regards,
Andy Shevchenko


