Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3954A7E94
	for <lists+dmaengine@lfdr.de>; Thu,  3 Feb 2022 05:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349276AbiBCEOI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Feb 2022 23:14:08 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:39884 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbiBCEOI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Feb 2022 23:14:08 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EA0AB49C;
        Thu,  3 Feb 2022 05:14:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643861647;
        bh=rigEpl7ODh+WqLDeI2Ri/B6qDXjbCp9XPb5DWtVknS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KpjtfsddQ+v9QH9fS/ir3R89xQYe4ENSmFeWbZ7yZM67/2McvIUDQxNMmAKaKKNGx
         h5UK9dm0QMrUEKXCPa969qGPNIiiWDjyB+Xj+H+Jyd/3au/eUbQ00i3glvUNuIEmuP
         nkQtNamOPsYhYaxsLeK/M7ww+C9+GuoNo8m9YE8s=
Date:   Thu, 3 Feb 2022 06:13:44 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neel Gandhi <neel.gandhi@xilinx.com>
Cc:     dan.j.williams@intel.com, vkoul@kernel.org,
        michal.simek@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: xilinx: dpdma: Fix race condition in vsync IRQ
Message-ID: <YftWeLCpAfN/JnFj@pendragon.ideasonboard.com>
References: <20220122121407.11467-1-neel.gandhi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220122121407.11467-1-neel.gandhi@xilinx.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Neel,

Thank you for the patch.

On Sat, Jan 22, 2022 at 05:44:07PM +0530, Neel Gandhi wrote:
> Protected race condition of virtual DMA channel from channel queue transfer
> via vchan spin lock from the caller of xilinx_dpdma_chan_queue_transfer

This should explain what the race condition is, as it's not immediately
apparent from the patch itself. You can write it as

The vchan_next_desc() function, called from
xilinx_dpdma_chan_queue_transfer(), must be called with
virt_dma_chan.lock held. This isn't correctly handled in all code paths,
resulting in a race condition between the .device_issue_pending()
handler and the IRQ handler which causes DMA to randomly stop. Fix it by
taking the lock around xilinx_dpdma_chan_queue_transfer() calls that are
missing it.

> Signed-off-by: Neel Gandhi <neel.gandhi@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_dpdma.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index b0f4948b00a5..7d77a8948e38 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -1102,7 +1102,9 @@ static void xilinx_dpdma_chan_vsync_irq(struct  xilinx_dpdma_chan *chan)

Adding some context:

	if (chan->desc.active)
		vchan_cookie_complete(&chan->desc.active->vdesc);

>         chan->desc.active = pending;
>         chan->desc.pending = NULL;
> 
> +       spin_lock(&chan->vchan.lock);
>         xilinx_dpdma_chan_queue_transfer(chan);
> +       spin_unlock(&chan->vchan.lock);

There seems to be one more race condition here. vchan_cookie_complete()
is documented as requiring the vchan.lock being held too. Moving the
spin_lock() call before that should be enough to fix it.

It would probably be useful to revisit locking in this driver, but for
now, with the issues pointed out here fixed, this patch should be good
enough. Can you submit a v2 ?

> 
>  out:
>         spin_unlock_irqrestore(&chan->lock, flags);
> @@ -1495,7 +1497,9 @@ static void xilinx_dpdma_chan_err_task(struct tasklet_struct *t)
>                     XILINX_DPDMA_EINTR_CHAN_ERR_MASK << chan->id);
> 
>         spin_lock_irqsave(&chan->lock, flags);
> +       spin_lock(&chan->vchan.lock);
>         xilinx_dpdma_chan_queue_transfer(chan);
> +       spin_unlock(&chan->vchan.lock);
>         spin_unlock_irqrestore(&chan->lock, flags);
>  }
> 

-- 
Regards,

Laurent Pinchart
