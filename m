Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AA33B1A9A
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jun 2021 14:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFWNBP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Jun 2021 09:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWNBN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Jun 2021 09:01:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F873C061574;
        Wed, 23 Jun 2021 05:58:56 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C60619AA;
        Wed, 23 Jun 2021 14:58:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1624453135;
        bh=lBmq8McJCYUITuRQECXx+V8MX4oixl0DGshKbgS0ijU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l0BdjNuAZpxxvpC2kZsH7qj8T5Tkud8HMBbBoFgNCukuC3lgirXZpDa8tk+g1TfK0
         5Ef7hsc4u0NuKwGpZAs0m5HICC/8r/pwbkYuizCuZ3KGAI1kFVW48xCnM4EmcaSFyI
         gEy1kamGV0f0T+XiwOpUtgmAZ25qxCdFJ8GyRMrE=
Date:   Wed, 23 Jun 2021 15:58:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: xilinx: dpdma: Use kernel type u32 over
 uint32_t
Message-ID: <YNMv8ZDahRnZD61w@pendragon.ideasonboard.com>
References: <9569008794d519b487348bfeafbfd76c5da5755e.1624446336.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9569008794d519b487348bfeafbfd76c5da5755e.1624446336.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Wed, Jun 23, 2021 at 01:05:39PM +0200, Michal Simek wrote:
> Use u32 kernel type instead of uint32_t. Issue is reported by
> checkpatch.pl --strict.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index 539f1a42ca72..0b67083c95d0 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -1600,7 +1600,7 @@ static struct dma_chan *of_dma_xilinx_xlate(struct of_phandle_args *dma_spec,
>  					    struct of_dma *ofdma)
>  {
>  	struct xilinx_dpdma_device *xdev = ofdma->of_dma_data;
> -	uint32_t chan_id = dma_spec->args[0];
> +	u32 chan_id = dma_spec->args[0];
>  
>  	if (chan_id >= ARRAY_SIZE(xdev->chan))
>  		return NULL;

-- 
Regards,

Laurent Pinchart
