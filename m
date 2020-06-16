Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAB31FBC2B
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2020 18:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgFPQz4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jun 2020 12:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbgFPQzz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Jun 2020 12:55:55 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 542F9208E4;
        Tue, 16 Jun 2020 16:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592326555;
        bh=yKr5wwutWeyD3jubWBBo/Tas2qiPPBydjljqL+ty00U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=suSvvi7UEgk7SHH3CDiT9fDfcZkrta8DfsVoYixnnZSWh4FovZpdkOIKLGf7/WET6
         MqoIWN8gpYEago792XBC2Lg+Zlhj7OynR+Lx2+zHHmYitDLieLZfncOjLdLRuMkkH+
         N1Ihtd+UUsTbX5KITGBLYq5Lo4b3iS4CyBE+qIdg=
Date:   Tue, 16 Jun 2020 22:25:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dma: sh: usb-dmac: Fix residue after the commit
 24461d9792c2
Message-ID: <20200616165550.GP2324254@vkoul-mobl>
References: <1590061573-12576-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590061573-12576-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-05-20, 20:46, Yoshihiro Shimoda wrote:
> This driver assumed that freed descriptors have "done_cookie".
> But, after the commit 24461d9792c2 ("dmaengine: virt-dma: Fix
> access after free in vchan_complete()"), since the desc is freed
> after callback function was called, this driver could not
> match any done_cookie when a client driver (renesas_usbhs driver)
> calls dmaengine_tx_status() in the callback function.

Hmmm, I am not sure about this, why should we try to match! cookie is
monotonically increasing number so if you see that current cookie
completed is > requested you should return DMA_COMPLETE

The below case of checking residue should not even get executed

> So, add to check both descriptor types (freed and got) to fix
> the issue.
> 
> Reported-by: Hien Dang <hien.dang.eb@renesas.com>
> Fixes: 24461d9792c2 ("dmaengine: virt-dma: Fix access after free in vchan_complete()")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/dma/sh/usb-dmac.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
> index b218a01..c0adc1c8 100644
> --- a/drivers/dma/sh/usb-dmac.c
> +++ b/drivers/dma/sh/usb-dmac.c
> @@ -488,16 +488,17 @@ static u32 usb_dmac_chan_get_residue_if_complete(struct usb_dmac_chan *chan,
>  						 dma_cookie_t cookie)
>  {
>  	struct usb_dmac_desc *desc;
> -	u32 residue = 0;
>  
> +	list_for_each_entry_reverse(desc, &chan->desc_got, node) {
> +		if (desc->done_cookie == cookie)
> +			return desc->residue;
> +	}
>  	list_for_each_entry_reverse(desc, &chan->desc_freed, node) {
> -		if (desc->done_cookie == cookie) {
> -			residue = desc->residue;
> -			break;
> -		}
> +		if (desc->done_cookie == cookie)
> +			return desc->residue;
>  	}
>  
> -	return residue;
> +	return 0;
>  }
>  
>  static u32 usb_dmac_chan_get_residue(struct usb_dmac_chan *chan,
> -- 
> 2.7.4

-- 
~Vinod
