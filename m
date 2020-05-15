Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFDE1D45AB
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 08:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgEOGQI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 02:16:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgEOGQI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 May 2020 02:16:08 -0400
Received: from localhost (unknown [122.178.196.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539732065F;
        Fri, 15 May 2020 06:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589523367;
        bh=yFXDhdxhT5d9Ejkfe1II0aCOjPVqelKVXfPuyhwgZYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HuZs1a0eDauoD6qWYPdoEZXN3wg3dqclsmKOII+olf6HAlUQ482cGFgwWCcyCYzYf
         AggQIfMWldHsLmza0EihG5zqcCix/Mt3bdQKkRkl4mJAoNwY5IO0KowK6/GYVyF+pT
         TQseb7S7vaaiwNx8bzzZIkzU01QbDOPkCH4JxGEc=
Date:   Fri, 15 May 2020 11:46:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <20200515061601.GG333670@vkoul-mobl>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-4-Sergey.Semin@baikalelectronics.ru>
 <20200508112152.GI185537@smile.fi.intel.com>
 <20200511211622.yuh3ls2ay76yaxrf@mobilestation>
 <20200512123551.GX185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512123551.GX185537@smile.fi.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-05-20, 15:35, Andy Shevchenko wrote:
> On Tue, May 12, 2020 at 12:16:22AM +0300, Serge Semin wrote:
> > On Fri, May 08, 2020 at 02:21:52PM +0300, Andy Shevchenko wrote:
> > > On Fri, May 08, 2020 at 01:53:01PM +0300, Serge Semin wrote:
> > > > Maximum block size DW DMAC configuration corresponds to the max segment
> > > > size DMA parameter in the DMA core subsystem notation. Lets set it with a
> > > > value specific to the probed DW DMA controller. It shall help the DMA
> > > > clients to create size-optimized SG-list items for the controller. This in
> > > > turn will cause less dw_desc allocations, less LLP reinitializations,
> > > > better DMA device performance.
> 
> > > Yeah, I have locally something like this and I didn't dare to upstream because
> > > there is an issue. We have this information per DMA controller, while we
> > > actually need this on per DMA channel basis.
> > > 
> > > Above will work only for synthesized DMA with all channels having same block
> > > size. That's why above conditional is not needed anyway.
> > 
> > Hm, I don't really see why the conditional isn't needed and this won't work. As
> > you can see in the loop above Initially I find a maximum of all channels maximum
> > block sizes and use it then as a max segment size parameter for the whole device.
> > If the DW DMA controller has the same max block size of all channels, then it
> > will be found. If the channels've been synthesized with different block sizes,
> > then the optimization will work for the one with greatest block size. The SG
> > list entries of the channels with lesser max block size will be split up
> > by the DW DMAC driver, which would have been done anyway without
> > max_segment_size being set. Here we at least provide the optimization for the
> > channels with greatest max block size.
> > 
> > I do understand that it would be good to have this parameter setup on per generic
> > DMA channel descriptor basis. But DMA core and device descriptor doesn't provide
> > such facility, so setting at least some justified value is a good idea.
> > 
> > > 
> > > OTOH, I never saw the DesignWare DMA to be synthesized differently (I remember
> > > that Intel Medfield has interesting settings, but I don't remember if DMA
> > > channels are different inside the same controller).
> > > 
> > > Vineet, do you have any information that Synopsys customers synthesized DMA
> > > controllers with different channel characteristics inside one DMA IP?
> > 
> > AFAICS the DW DMAC channels can be synthesized with different max block size.
> > The IP core supports such configuration. So we can't assume that such DMAC
> > release can't be found in a real hardware just because we've never seen one.
> > No matter what Vineet will have to say in response to your question.
> 
> My point here that we probably can avoid complications till we have real
> hardware where it's different. As I said I don't remember a such, except
> *maybe* Intel Medfield, which is quite outdated and not supported for wider
> audience anyway.

IIRC Intel Medfield has couple of dma controller instances each one with
different parameters *but* each instance has same channel configuration.

I do not recall seeing that we have synthesis parameters per channel
basis... But I maybe wrong, it's been a while.

-- 
~Vinod
