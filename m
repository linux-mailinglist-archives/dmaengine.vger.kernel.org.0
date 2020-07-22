Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45AF22986D
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jul 2020 14:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgGVMp0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jul 2020 08:45:26 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48840 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGVMpZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jul 2020 08:45:25 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3E61B329;
        Wed, 22 Jul 2020 14:45:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1595421924;
        bh=BIwBqSI3RqlKYQPNaFC3g0efC+ro75/zsR4UJG3t+h4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tZRSIFrO5IzDyCAMo6KB4ZYB9lK56rom2ugIxA6HHwjICWYVuUWvYvq5uea7s9KrQ
         Nm+VvLB0uRLAXAKewwYg3+T0slzvZUsy0oxJxt2pCZiKCQ4y/ZQF/HkoYMl4LuR4S9
         5ApyIFIndZ2r6iOAvQnDZ0OhGuyZcHgRxglWSYzE=
Date:   Wed, 22 Jul 2020 15:45:19 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 2/3] dmaengine: xilinx: dpdma: add missing kernel doc
Message-ID: <20200722124519.GG5833@pendragon.ideasonboard.com>
References: <20200718135201.191881-1-vkoul@kernel.org>
 <20200718135201.191881-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200718135201.191881-2-vkoul@kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thank you for the patch.

On Sat, Jul 18, 2020 at 07:22:00PM +0530, Vinod Koul wrote:
> xilinx_dpdma_sw_desc_set_dma_addrs() documentation is missing describing
> 'xdev', so add it
> 
> drivers/dma/xilinx/xilinx_dpdma.c:313: warning: Function parameter or
> member 'xdev' not described in 'xilinx_dpdma_sw_desc_set_dma_addrs'
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/dma/xilinx/xilinx_dpdma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index 8e602378f2dc..430f3714f6a3 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -295,6 +295,7 @@ static inline void dpdma_set(void __iomem *base, u32 offset, u32 set)
>  
>  /**
>   * xilinx_dpdma_sw_desc_set_dma_addrs - Set DMA addresses in the descriptor
> + * @xdev: DPDMA device
>   * @sw_desc: The software descriptor in which to set DMA addresses
>   * @prev: The previous descriptor
>   * @dma_addr: array of dma addresses

-- 
Regards,

Laurent Pinchart
