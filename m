Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502D03B1A9F
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jun 2021 14:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFWNBw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Jun 2021 09:01:52 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38614 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWNBw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Jun 2021 09:01:52 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A29909AA;
        Wed, 23 Jun 2021 14:59:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1624453173;
        bh=WRNQ43bka2fHx73Bt1Dxbd2nJ/Sp0ZOKsmWYcvwxIzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sj1k4TSCKTPhIjLEc3HXCo5YNYNinTs1CsSBST/JDrTuGPn00iYNpxQs71eR1VDad
         PN6xuSUmux7cVbxR//zRraRQ9SVrfbRFcS1F1idRvX8zF5hVISv1FnwUGndrBWT/4O
         jhjaPEKgO7xMQhxWqPprjyWWD8Nr6OLRYWMXEYIQ=
Date:   Wed, 23 Jun 2021 15:59:04 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: xilinx: dpdma: Fix spacing around addr[i-1]
Message-ID: <YNMwGICbXY2pWhwn@pendragon.ideasonboard.com>
References: <ef7cde6f793bfa6f3dd0a8898bad13b6407479b0.1624446456.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef7cde6f793bfa6f3dd0a8898bad13b6407479b0.1624446456.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 23, 2021 at 01:07:38PM +0200, Michal Simek wrote:
> Use proper spacing for array calculation. Issue is reported by
> checkpatch.pl --strict.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index 0b67083c95d0..b280a53e8570 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -531,7 +531,7 @@ static void xilinx_dpdma_sw_desc_set_dma_addrs(struct xilinx_dpdma_device *xdev,
>  	for (i = 1; i < num_src_addr; i++) {
>  		u32 *addr = &hw_desc->src_addr2;
>  
> -		addr[i-1] = lower_32_bits(dma_addr[i]);
> +		addr[i - 1] = lower_32_bits(dma_addr[i]);

I don't mind either way.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
>  		if (xdev->ext_addr) {
>  			u32 *addr_ext = &hw_desc->addr_ext_23;

-- 
Regards,

Laurent Pinchart
