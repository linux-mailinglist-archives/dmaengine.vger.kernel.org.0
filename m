Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62794BF783
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2019 19:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfIZRWJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 13:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbfIZRWI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Sep 2019 13:22:08 -0400
Received: from localhost (unknown [12.206.46.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24DCB222C7;
        Thu, 26 Sep 2019 17:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569518528;
        bh=a5q6Qw1XOqSsCPiOXvp/+OXUTyfRXfd1NTeUwBG9/mA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ae0eArDgBRhDPjYyo4YgpxVEMeBmyZ1sHJRxbmrU26gU1fWnHk7fvzX7bxHO34MlH
         PiiSjbJEbwPUQTYEc+/ftryImye6tr51w8jVFrAWIdpxmghkbi/8rxl+evrXT7ZEb4
         hClpB5ls00YLvh7eZJPcF/NhyVDK13N3qBuGWZ1E=
Date:   Thu, 26 Sep 2019 10:21:07 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        nick.graumann@gmail.com, andrea.merello@gmail.com,
        appana.durga.rao@xilinx.com, mcgrof@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 7/8] dmaengine: xilinx_dma: Check for both idle and
 halted state in axidma stop_transfer
Message-ID: <20190926172107.GN3824@vkoul-mobl>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1567701424-25658-8-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567701424-25658-8-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-09-19, 22:07, Radhey Shyam Pandey wrote:
> From: Nicholas Graumann <nick.graumann@gmail.com>
> 
> When polling for a stopped transfer in AXI DMA mode, in some cases the
> status of the channel may indicate IDLE instead of HALTED if the
> channel was reset due to an error.
> 
> Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index b5dd62a..0896e07 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1092,8 +1092,9 @@ static int xilinx_dma_stop_transfer(struct xilinx_dma_chan *chan)
>  
>  	/* Wait for the hardware to halt */
>  	return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
> -				       val & XILINX_DMA_DMASR_HALTED, 0,
> -				       XILINX_DMA_LOOP_COUNT);
> +				       val | (XILINX_DMA_DMASR_IDLE |
> +					      XILINX_DMA_DMASR_HALTED),

The condition was bitwise AND and now is OR.. ??

> +				       0, XILINX_DMA_LOOP_COUNT);
>  }
>  
>  /**
> -- 
> 2.7.4

-- 
~Vinod
