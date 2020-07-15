Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07082204DD
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 08:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgGOGUC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 02:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgGOGUC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 02:20:02 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E49520672;
        Wed, 15 Jul 2020 06:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594794001;
        bh=05czjJvRJc8XN686B6X5OIjt1m5Lx94Zy66nZ0TFTuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TkN9kI7sW2FxzrMGLsnMSOwyLrYgRTsapamaHFT5ehvpboZalM4to6Kn4CneZsoAf
         l4tDgoEVPTgKkzAIWkq6cI1RYmZsqxw6PeL35Jmiwe4gky+oFMzPrqQysl6qj66iMd
         mZBGDFdxeuRN4wxW83eGEdBuxtQBaZu7WESwQtMo=
Date:   Wed, 15 Jul 2020 11:49:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     EastL Lee <EastL.Lee@mediatek.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, cc.hwang@mediatek.com
Subject: Re: [PATCH v6 2/4] dmaengine: mediatek-cqdma: remove redundant queue
 structure
Message-ID: <20200715061957.GA34333@vkoul-mobl>
References: <1593673564-4425-1-git-send-email-EastL.Lee@mediatek.com>
 <1593673564-4425-3-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593673564-4425-3-git-send-email-EastL.Lee@mediatek.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-07-20, 15:06, EastL Lee wrote:

>  static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
>  					   dma_cookie_t cookie,
>  					   struct dma_tx_state *txstate)
>  {
> -	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
> -	struct mtk_cqdma_vdesc *cvd;
> -	struct virt_dma_desc *vd;
> -	enum dma_status ret;
> -	unsigned long flags;
> -	size_t bytes = 0;
> -
> -	ret = dma_cookie_status(c, cookie, txstate);
> -	if (ret == DMA_COMPLETE || !txstate)
> -		return ret;
> -
> -	spin_lock_irqsave(&cvc->vc.lock, flags);
> -	vd = mtk_cqdma_find_active_desc(c, cookie);
> -	spin_unlock_irqrestore(&cvc->vc.lock, flags);
> -
> -	if (vd) {
> -		cvd = to_cqdma_vdesc(vd);
> -		bytes = cvd->residue;
> -	}
> -
> -	dma_set_residue(txstate, bytes);

any reason why you want to remove setting residue?

> -static void mtk_cqdma_free_active_desc(struct dma_chan *c)
> +static int mtk_cqdma_terminate_all(struct dma_chan *c)
>  {
>  	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
> -	bool sync_needed = false;
> +	struct virt_dma_chan *vc = to_virt_chan(c);
>  	unsigned long pc_flags;
>  	unsigned long vc_flags;
> +	LIST_HEAD(head);
> +
> +	/* wait for the VC to be inactive  */
> +	if (!wait_for_completion_timeout(&cvc->cmp, msecs_to_jiffies(3000)))
> +		return -EAGAIN;
>  
>  	/* acquire PC's lock first due to lock dependency in dma ISR */
>  	spin_lock_irqsave(&cvc->pc->lock, pc_flags);
>  	spin_lock_irqsave(&cvc->vc.lock, vc_flags);
>  
> -	/* synchronization is required if this VC is active */
> -	if (mtk_cqdma_is_vchan_active(cvc)) {
> -		cvc->issue_synchronize = true;
> -		sync_needed = true;
> -	}
> +	/* get VDs from lists */
> +	vchan_get_all_descriptors(vc, &head);
> +
> +	/* free all the VDs */
> +	vchan_dma_desc_free_list(vc, &head);
>  
>  	spin_unlock_irqrestore(&cvc->vc.lock, vc_flags);
>  	spin_unlock_irqrestore(&cvc->pc->lock, pc_flags);

Good cleanup, do you need both these locks?
-- 
~Vinod
