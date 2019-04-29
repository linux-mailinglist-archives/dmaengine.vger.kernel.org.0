Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05BE3E166
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2019 13:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfD2LgI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Apr 2019 07:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbfD2LgH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Apr 2019 07:36:07 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B69482075E;
        Mon, 29 Apr 2019 11:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556537766;
        bh=xrb4idnEqTxEw7YKrCpZyBX26GxTnwHkDH99g213PQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VEW+K+47fN2uG7Z1EKCt2g8fTb1RQbfUPM6mxN3KWl5FiTdqryFkRGMrfXCZje2El
         EeJIuGirmR+BnFAi+o/wbYHW29KWlDOoHDWrqRXlEFFUwVN8kKX/1JWTGcAJMeT3Y5
         bvzr+DdI92iexlvpfVvTrkptqj5Xg8GNxGNLIudI=
Date:   Mon, 29 Apr 2019 17:05:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     dan.j.williams@intel.com, eric.long@unisoc.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dmaengine: sprd: Fix the possible crash when getting
 engine status
Message-ID: <20190429113555.GI3845@vkoul-mobl.Dlink>
References: <cover.1555330115.git.baolin.wang@linaro.org>
 <2eecd528e85377f03e6fbc5e7d6544b9c9f59cb1.1555330115.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eecd528e85377f03e6fbc5e7d6544b9c9f59cb1.1555330115.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-04-19, 20:14, Baolin Wang wrote:
> We will get a NULL virtual descriptor by vchan_find_desc() when the descriptor
> has been submitted, that will crash the kernel when getting the engine status.

No that is wrong, status is for descriptor and not engine!

> In this case, since the descriptor has been submitted, which means the pointer
> 'schan->cur_desc' will point to the current descriptor, then we can use
> 'schan->cur_desc' to get the engine status to avoid this issue.

Nope, since the descriptor is completed, you return with residue as 0
and DMA_COMPLETE status!

> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/dma/sprd-dma.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 48431e2..e29342a 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -625,7 +625,7 @@ static enum dma_status sprd_dma_tx_status(struct dma_chan *chan,
>  		else
>  			pos = 0;
>  	} else if (schan->cur_desc && schan->cur_desc->vd.tx.cookie == cookie) {
> -		struct sprd_dma_desc *sdesc = to_sprd_dma_desc(vd);
> +		struct sprd_dma_desc *sdesc = schan->cur_desc;
>  
>  		if (sdesc->dir == DMA_DEV_TO_MEM)
>  			pos = sprd_dma_get_dst_addr(schan);
> -- 
> 1.7.9.5

-- 
~Vinod
