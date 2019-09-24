Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 340F2BD428
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 23:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbfIXVVO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 17:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731409AbfIXVVO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 17:21:14 -0400
Received: from localhost (unknown [12.157.10.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 812862146E;
        Tue, 24 Sep 2019 21:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569360072;
        bh=YwTnTLVeehJrct4PNQdvbGHqGUqGNX0FXMXJ8P27DZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wfE5PHL673l/faJkcNrHUaXRQ+94j1pJKdEikf3DrBIKkUirdnWkQ++L3dso3zdlj
         0WAQkVJbn8QR38mdR/Ih4PtjGoEC4Sc0ATLE2Jnvjjci+uLv/F/QEu6su4299nQWVs
         z7JgEH7pmrLakQ0RlTkVSf8CmWFmZeq5T9FX7FpA=
Date:   Tue, 24 Sep 2019 14:20:11 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Green Wan <green.wan@sifive.com>
Cc:     linux-hackers@sifive.com, Dan Williams <dan.j.williams@intel.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/3] dmaengine: sf-pdma: add platform DMA support for
 HiFive Unleashed A00
Message-ID: <20190924212011.GG3824@vkoul-mobl>
References: <20190920090205.19552-1-green.wan@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920090205.19552-1-green.wan@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Green,

On 20-09-19, 17:01, Green Wan wrote:

Please make sure threading is *not* broken in your patch series. Atm
they are all over place in my mailbox!

> Link: https://www.kernel.org/doc/html/v4.17/driver-api/dmaengine/
> Link: https://static.dev.sifive.com/FU540-C000-v1.0.pdf

Link tag is used for discussion for the patch, please drop first one and
add second one as a documentation for hardware

> diff --git a/MAINTAINERS b/MAINTAINERS
> index d0caa09a479e..c5f0662c9106 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14594,6 +14594,7 @@ F:	drivers/media/mmc/siano/
>  SIFIVE PDMA DRIVER
>  M:	Green Wan <green.wan@sifive.com>
>  S:	Maintained
> +F:	drivers/dma/sf-pdma/
>  F:	Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml

What is this generated against, only one line?

> +static void sf_pdma_fill_desc(struct sf_pdma_chan *chan,
> +			      u64 dst,
> +			      u64 src,
> +			      u64 size)

Please align these to precceeding line open brace!

> +{
> +	struct pdma_regs *regs = &chan->regs;
> +
> +	writel(PDMA_FULL_SPEED, regs->xfer_type);
> +	writeq(size, regs->xfer_size);
> +	writeq(dst, regs->dst_addr);
> +	writeq(src, regs->src_addr);
> +}
> +
> +void sf_pdma_disclaim_chan(struct sf_pdma_chan *chan)
> +{
> +	struct pdma_regs *regs = &chan->regs;
> +
> +	writel(PDMA_CLEAR_CTRL, regs->ctrl);
> +}
> +
> +struct dma_async_tx_descriptor *
> +	sf_pdma_prep_dma_memcpy(struct dma_chan *dchan,
> +				dma_addr_t dest,
> +				dma_addr_t src,
> +				size_t len,
> +				unsigned long flags)
> +{
> +	struct sf_pdma_chan *chan = to_sf_pdma_chan(dchan);
> +	struct sf_pdma_desc *desc;
> +
> +	if (!chan || !len || !dest || !src) {
> +		pr_debug("%s: Please check dma len, dest, src!\n", __func__);
> +		return NULL;
> +	}
> +
> +	desc = sf_pdma_alloc_desc(chan);
> +	if (!desc)
> +		return NULL;
> +
> +	desc->in_use = true;
> +	desc->dirn = DMA_MEM_TO_MEM;
> +	desc->async_tx = vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);

No error checking?
> +
> +	spin_lock_irqsave(&chan->lock, flags);
> +	chan->desc = desc;
> +	sf_pdma_fill_desc(desc->chan, dest, src, len);
> +	spin_unlock_irqrestore(&chan->lock, flags);
> +
> +	return desc->async_tx;
> +}
> +
> +static void sf_pdma_unprep_slave_dma(struct sf_pdma_chan *chan)
> +{
> +	if (chan->dma_dir != DMA_NONE)
> +		dma_unmap_resource(chan->vchan.chan.device->dev,

This is slave dma right, why are you unmapping? Also where is the
mapping call?

> +				   chan->dma_dev_addr,
> +				   chan->dma_dev_size,
> +				   chan->dma_dir, 0);
> +	chan->dma_dir = DMA_NONE;
> +}
> +
> +static int sf_pdma_slave_config(struct dma_chan *dchan,
> +				struct dma_slave_config *cfg)
> +{
> +	struct sf_pdma_chan *chan = to_sf_pdma_chan(dchan);
> +
> +	memcpy(&chan->cfg, cfg, sizeof(*cfg));
> +	sf_pdma_unprep_slave_dma(chan);

Why unprep?

> +static enum dma_status
> +sf_pdma_tx_status(struct dma_chan *dchan,
> +		  dma_cookie_t cookie,
> +		  struct dma_tx_state *txstate)
> +{
> +	struct sf_pdma_chan *chan = to_sf_pdma_chan(dchan);
> +	enum dma_status status;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chan->lock, flags);
> +	if (chan->xfer_err) {
> +		chan->status = DMA_ERROR;
> +		spin_unlock_irqrestore(&chan->lock, flags);
> +		return chan->status;
> +	}
> +
> +	spin_unlock_irqrestore(&chan->lock, flags);
> +
> +	status = dma_cookie_status(dchan, cookie, txstate);
> +
> +	if (status == DMA_COMPLETE)
> +		return status;
> +
> +	if (!txstate)
> +		return chan->status;

why not return status? Is that expected to be different than status?

> +static int sf_pdma_remove(struct platform_device *pdev)
> +{
> +	struct sf_pdma *pdma = platform_get_drvdata(pdev);
> +
> +	dma_async_device_unregister(&pdma->dma_dev);

whay about irqs and tasklets, they are still enabled and can trigger!
-- 
~Vinod
