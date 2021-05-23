Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C0238D7FF
	for <lists+dmaengine@lfdr.de>; Sun, 23 May 2021 02:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhEWAVf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 May 2021 20:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhEWAVf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 May 2021 20:21:35 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8583FC061574;
        Sat, 22 May 2021 17:20:09 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B0D242A8;
        Sun, 23 May 2021 02:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1621729205;
        bh=F5R+Ym46eRNyJ7nYF6pjtVqD2w5HTuZXq2ESBHDvgbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BJQZLoI0TPvuLPj02Y/KKVtYeXwss7o7ut5/rQMjneaP260VmoEU5FWWw1XBNgzQD
         aY0uSXB/Y/QW3z3bT9Dpc+schxnIBy0ciwRD/2lb6SG+YBNn6Lj1fKSpQ7rzjeyUil
         e9RGr8F2ZSuAFxN+TOVMMdbsx/U25xvUPma89hj0=
Date:   Sun, 23 May 2021 03:20:03 +0300
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
Message-ID: <YKmfs68Cq4osBaQ0@pendragon.ideasonboard.com>
References: <20210522021313.16405-1-rdunlap@infradead.org>
 <20210522021313.16405-5-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210522021313.16405-5-rdunlap@infradead.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Randy,

Thank you for the patch.

On Fri, May 21, 2021 at 07:13:13PM -0700, Randy Dunlap wrote:
> When CONFIG_HAS_IOMEM is not set/enabled, most iomap() family
> functions [including ioremap(), devm_ioremap(), etc.] are not
> available.
> Drivers that use these functions should depend on HAS_IOMEM so that
> they do not cause build errors.
> 
> Cures this build error:
> s390-linux-ld: drivers/dma/xilinx/xilinx_dpdma.o: in function `xilinx_dpdma_probe':
> xilinx_dpdma.c:(.text+0x336a): undefined reference to `devm_platform_ioremap_resource'

I've previously posted
https://lore.kernel.org/dmaengine/20210520152420.23986-2-laurent.pinchart@ideasonboard.com/T/#u
which fixes the same issue (plus an additional one).

> Fixes: 7cbb0c63de3fc ("dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> CC: dmaengine@vger.kernel.org
> Cc: Hyun Kwon <hyun.kwon@xilinx.com>
> Cc: Tejas Upadhyay <tejasu@xilinx.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/dma/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20210521.orig/drivers/dma/Kconfig
> +++ linux-next-20210521/drivers/dma/Kconfig
> @@ -702,6 +702,7 @@ config XILINX_ZYNQMP_DMA
>  
>  config XILINX_ZYNQMP_DPDMA
>  	tristate "Xilinx DPDMA Engine"
> +	depends on HAS_IOMEM
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	help

-- 
Regards,

Laurent Pinchart
