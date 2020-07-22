Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDCA229A07
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jul 2020 16:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgGVOZw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jul 2020 10:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbgGVOZw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 Jul 2020 10:25:52 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C80D720709;
        Wed, 22 Jul 2020 14:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595427951;
        bh=AgJnPCTRdZiLLhVrsBn26Cf5dDaLlwJZF14IM8W+1kA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XU3Y8OncwP3EPLmXENsmApA1+fFwMFN92wBzifPeoJxVDkpcKHUb2y9rMB4CLk+ve
         GWQCgEVkG+2RkJSP3f5kZxxeUIwlaqk1fALqqUwYj8eJIIJlyuMY1w37mzzTi86hmp
         HFGo/w6lqJXq9498BXIWhn1eLXAiOTtf7xA2nH5A=
Date:   Wed, 22 Jul 2020 19:55:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/3] dmaengine: xilinx: dpdma: remove comparison of
 unsigned expression
Message-ID: <20200722142547.GQ12965@vkoul-mobl>
References: <20200718135201.191881-1-vkoul@kernel.org>
 <20200722124458.GF5833@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200722124458.GF5833@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-07-20, 15:44, Laurent Pinchart wrote:
> Hi Vinod,
> 
> Thank you for the patch.
> 
> On Sat, Jul 18, 2020 at 07:21:59PM +0530, Vinod Koul wrote:
> > xilinx_dpdma_config() channel id is unsigned int and compares with
> > ZYNQMP_DPDMA_VIDEO0 which is zero, so remove this comparison
> > 
> > drivers/dma/xilinx/xilinx_dpdma.c:1073:15: warning: comparison of
> > unsigned expression in ‘>= 0’ is always true [-Wtype-limits] if
> > 	(chan->id >= ZYNQMP_DPDMA_VIDEO0 && chan->id <= ZYNQMP_DPDMA_VIDEO2)
> 
> I didn't see that warning, how do you produce it ?

I see it with gcc and W=1.

> 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> > index af88a6762ef4..8e602378f2dc 100644
> > --- a/drivers/dma/xilinx/xilinx_dpdma.c
> > +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> > @@ -1070,7 +1070,7 @@ static int xilinx_dpdma_config(struct dma_chan *dchan,
> >  	 * Abuse the slave_id to indicate that the channel is part of a video
> >  	 * group.
> >  	 */
> > -	if (chan->id >= ZYNQMP_DPDMA_VIDEO0 && chan->id <= ZYNQMP_DPDMA_VIDEO2)
> > +	if (chan->id <= ZYNQMP_DPDMA_VIDEO2)
> 
> While this doesn't affect the behaviour, I'm worried about the risk of
> introducing bugs in the future if the ZYNQMP_DPDMA_VIDEO0 becomes
> non-zero. On the other hand, that's part of the DT ABI, so it shouldn't
> change. How about
> 
> 	switch (chan->id) {
> 	case ZYNQMP_DPDMA_VIDEO0:
> 	case ZYNQMP_DPDMA_VIDEO1:
> 	case ZYNQMP_DPDMA_VIDEO2:
>   		chan->video_group = config->slave_id != 0;
> 		break;
> 	}
> 
> instead ?
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks

> 
> >  		chan->video_group = config->slave_id != 0;
> >  
> >  	spin_unlock_irqrestore(&chan->lock, flags);
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
~Vinod
