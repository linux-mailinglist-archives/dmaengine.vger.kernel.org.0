Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDF638DC80
	for <lists+dmaengine@lfdr.de>; Sun, 23 May 2021 20:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhEWSyq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 23 May 2021 14:54:46 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:51042 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhEWSyp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 23 May 2021 14:54:45 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 07C1C2A8;
        Sun, 23 May 2021 20:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1621795997;
        bh=0MbZwRbBUjdf9JuXa/VR/8NC9VAmYtB+9nqLUnykiFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mW9zZyM3nNCcVNRy7hbSX4jvSOeAe64ygruErCf+u5VEX2Vr5Igz8r8BaOXaf8iU+
         Zwmu/tScyWB3yAhVxeDmOcfElnoiUJWqgt8M0tMswSZnWb0ripAxpIQtBo8zacJhNf
         LUDL+GJVi3MjGoYKbW2ESFIarPSE0q1FGxyjKkIM=
Date:   Sun, 23 May 2021 21:53:13 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Green Wan <green.wan@sifive.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 4/4] DMA: XILINX_ZYNQMP_DPDMA depends on HAS_IOMEM
Message-ID: <YKqkmbZHPdbH2XtS@pendragon.ideasonboard.com>
References: <20210522021313.16405-1-rdunlap@infradead.org>
 <20210522021313.16405-5-rdunlap@infradead.org>
 <YKmfs68Cq4osBaQ0@pendragon.ideasonboard.com>
 <5cb3b313-cd96-d687-2916-0d4af8e5e675@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5cb3b313-cd96-d687-2916-0d4af8e5e675@infradead.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Randy,

On Sat, May 22, 2021 at 06:07:01PM -0700, Randy Dunlap wrote:
> On 5/22/21 5:20 PM, Laurent Pinchart wrote:
> > On Fri, May 21, 2021 at 07:13:13PM -0700, Randy Dunlap wrote:
> >> When CONFIG_HAS_IOMEM is not set/enabled, most iomap() family
> >> functions [including ioremap(), devm_ioremap(), etc.] are not
> >> available.
> >> Drivers that use these functions should depend on HAS_IOMEM so that
> >> they do not cause build errors.
> >>
> >> Cures this build error:
> >> s390-linux-ld: drivers/dma/xilinx/xilinx_dpdma.o: in function `xilinx_dpdma_probe':
> >> xilinx_dpdma.c:(.text+0x336a): undefined reference to `devm_platform_ioremap_resource'
> > 
> > I've previously posted
> > https://lore.kernel.org/dmaengine/20210520152420.23986-2-laurent.pinchart@ideasonboard.com/T/#u
> > which fixes the same issue (plus an additional one).
> 
> Hi Laurent,
> 
> I didn't add a dependency on OF because OF header files _mostly_
> have stubs so that they work when  OF is enabled or disabled.
> 
> I did find a problem in <linux/of_address.h> where it could end up
> without having a stub. I will post a patch for that soon.
> I'm currently doing lots of randconfig builds on it.

I'm fine with eithe approach, but the patch you've posted to address the
of_address.h issue has an issue itself.

If Vinod would prefer merging this patch instead of mine,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> >> Fixes: 7cbb0c63de3fc ("dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver")
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Cc: Vinod Koul <vkoul@kernel.org>
> >> CC: dmaengine@vger.kernel.org
> >> Cc: Hyun Kwon <hyun.kwon@xilinx.com>
> >> Cc: Tejas Upadhyay <tejasu@xilinx.com>
> >> Cc: Michal Simek <michal.simek@xilinx.com>
> >> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >> ---
> >>  drivers/dma/Kconfig |    1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> --- linux-next-20210521.orig/drivers/dma/Kconfig
> >> +++ linux-next-20210521/drivers/dma/Kconfig
> >> @@ -702,6 +702,7 @@ config XILINX_ZYNQMP_DMA
> >>  
> >>  config XILINX_ZYNQMP_DPDMA
> >>  	tristate "Xilinx DPDMA Engine"
> >> +	depends on HAS_IOMEM
> >>  	select DMA_ENGINE
> >>  	select DMA_VIRTUAL_CHANNELS
> >>  	help

-- 
Regards,

Laurent Pinchart
