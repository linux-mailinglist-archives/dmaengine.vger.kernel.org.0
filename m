Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1FBFF60C6
	for <lists+dmaengine@lfdr.de>; Sat,  9 Nov 2019 18:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfKIR7P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 9 Nov 2019 12:59:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfKIR7P (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 9 Nov 2019 12:59:15 -0500
Received: from localhost (unknown [106.51.111.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DEAB214E0;
        Sat,  9 Nov 2019 17:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573322353;
        bh=lkKs3TqpgqBoM+DEP+32oMO2Qy6d/2/pPn616Z9Wo8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQ/pT1xdkrlwFWa9cTbNg13uVaRP4IL4JnWsDuvcRtvTgngvNEW9RbpTf+NyDjcJe
         /hx5WmEClPIdztFl7gVuhySfPwSuQUr7+x/EJs6g7SxFVvcYOExaefzs9WZ1DlsOW4
         wEcrqoArI3tEENB1pwN/xgiQ9nJNEsoCtzO16Pn0=
Date:   Sat, 9 Nov 2019 23:29:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v2 2/4] dma: xilinx: dpdma: Add the Xilinx DisplayPort
 DMA engine driver
Message-ID: <20191109175908.GI952516@vkoul-mobl>
References: <20191107021400.16474-1-laurent.pinchart@ideasonboard.com>
 <20191107021400.16474-3-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107021400.16474-3-laurent.pinchart@ideasonboard.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

it is dmaengine: xxx not dma: xxx :-)

On 07-11-19, 04:13, Laurent Pinchart wrote:

> +/*
> + * DPDMA descriptor placement
> + * --------------------------
> + * DPDMA descritpor life time is described with following placements:
> + *
> + * allocated_desc -> submitted_desc -> pending_desc -> active_desc -> done_list
> + *
> + * Transition is triggered as following:
> + *
> + * -> allocated_desc : a descriptor allocation
> + * allocated_desc -> submitted_desc: a descriptor submission
> + * submitted_desc -> pending_desc: request to issue pending a descriptor
> + * pending_desc -> active_desc: VSYNC intr when a desc is scheduled to DPDMA
> + * active_desc -> done_list: VSYNC intr when DPDMA switches to a new desc

Well this tells me driver is not using vchan infrastructure, the
drivers/dma/virt-dma.c is common infra which does pretty decent list
management and drivers do not need to open code this.

Please convert the driver to use virt-dma

> +static struct dma_async_tx_descriptor *
> +xilinx_dpdma_chan_prep_slave_sg(struct xilinx_dpdma_chan *chan,
> +				struct scatterlist *sgl)
> +{
> +	struct xilinx_dpdma_tx_desc *tx_desc;
> +	struct xilinx_dpdma_sw_desc *sw_desc, *last = NULL;
> +
> +	if (chan->allocated_desc)
> +		return &chan->allocated_desc->async_tx;

This seems wrong, you are supposed to prepare a new descriptor based on
sg list provided, returning allocated without preparing seems wrong to
me!

> +static dma_cookie_t xilinx_dpdma_tx_submit(struct dma_async_tx_descriptor *tx)
> +{
> +	struct xilinx_dpdma_chan *chan = to_xilinx_chan(tx->chan);
> +	struct xilinx_dpdma_tx_desc *tx_desc = to_dpdma_tx_desc(tx);
> +	struct xilinx_dpdma_sw_desc *sw_desc;
> +	dma_cookie_t cookie;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chan->lock, flags);
> +
> +	if (chan->submitted_desc) {
> +		cookie = chan->submitted_desc->async_tx.cookie;

submit should give a new cookie not for already submitted descriptor!

> +		goto out_unlock;
> +	}
> +
> +	cookie = dma_cookie_assign(&tx_desc->async_tx);

yes this is correct :-)

> +
> +	/*
> +	 * Assign the cookie to descriptors in this transaction. Only 16 bit
> +	 * will be used, but it should be enough.
> +	 */
> +	list_for_each_entry(sw_desc, &tx_desc->descriptors, node)
> +		sw_desc->hw.desc_id = cookie;
> +
> +	if (tx_desc != chan->allocated_desc)
> +		dev_err(chan->xdev->dev, "desc != allocated_desc\n");
> +	else
> +		chan->allocated_desc = NULL;
> +	chan->submitted_desc = tx_desc;

submitted should be a list, we can submit multiple...

> +static void xilinx_dpdma_issue_pending(struct dma_chan *dchan)
> +{
> +	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
> +
> +	xilinx_dpdma_chan_start(chan);

what if channel is already started?
-- 
~Vinod
