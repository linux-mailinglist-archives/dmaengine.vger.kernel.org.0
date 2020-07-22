Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1328A22986B
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jul 2020 14:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgGVMpG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jul 2020 08:45:06 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48830 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGVMpG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jul 2020 08:45:06 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F2933329;
        Wed, 22 Jul 2020 14:45:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1595421904;
        bh=GGD1Wv2NYThYs0C95Sh9D/1gBBDQmKtWeCHsy+e8F8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XaJFFu2Dh/bl7KtPpO8KngKAcWCPFC+LmOqPSmeSS+kEwpMa2iHaFIdThzxY1VlD3
         qmG0FNZ/AKJGKTY+19S84Wyhv4lM/RVR8XmlQCpGPg8W0VBxUylYwDPI+3gQJapl1S
         /NWZ/+SEAMa5JC/ya9m4tfY4Q4riBQa/8ztGWz4o=
Date:   Wed, 22 Jul 2020 15:44:58 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/3] dmaengine: xilinx: dpdma: remove comparison of
 unsigned expression
Message-ID: <20200722124458.GF5833@pendragon.ideasonboard.com>
References: <20200718135201.191881-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200718135201.191881-1-vkoul@kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thank you for the patch.

On Sat, Jul 18, 2020 at 07:21:59PM +0530, Vinod Koul wrote:
> xilinx_dpdma_config() channel id is unsigned int and compares with
> ZYNQMP_DPDMA_VIDEO0 which is zero, so remove this comparison
> 
> drivers/dma/xilinx/xilinx_dpdma.c:1073:15: warning: comparison of
> unsigned expression in ‘>= 0’ is always true [-Wtype-limits] if
> 	(chan->id >= ZYNQMP_DPDMA_VIDEO0 && chan->id <= ZYNQMP_DPDMA_VIDEO2)

I didn't see that warning, how do you produce it ?

> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index af88a6762ef4..8e602378f2dc 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -1070,7 +1070,7 @@ static int xilinx_dpdma_config(struct dma_chan *dchan,
>  	 * Abuse the slave_id to indicate that the channel is part of a video
>  	 * group.
>  	 */
> -	if (chan->id >= ZYNQMP_DPDMA_VIDEO0 && chan->id <= ZYNQMP_DPDMA_VIDEO2)
> +	if (chan->id <= ZYNQMP_DPDMA_VIDEO2)

While this doesn't affect the behaviour, I'm worried about the risk of
introducing bugs in the future if the ZYNQMP_DPDMA_VIDEO0 becomes
non-zero. On the other hand, that's part of the DT ABI, so it shouldn't
change. How about

	switch (chan->id) {
	case ZYNQMP_DPDMA_VIDEO0:
	case ZYNQMP_DPDMA_VIDEO1:
	case ZYNQMP_DPDMA_VIDEO2:
  		chan->video_group = config->slave_id != 0;
		break;
	}

instead ?

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  		chan->video_group = config->slave_id != 0;
>  
>  	spin_unlock_irqrestore(&chan->lock, flags);

-- 
Regards,

Laurent Pinchart
