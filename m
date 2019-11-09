Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F49F60BC
	for <lists+dmaengine@lfdr.de>; Sat,  9 Nov 2019 18:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfKIRkx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 9 Nov 2019 12:40:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbfKIRkx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 9 Nov 2019 12:40:53 -0500
Received: from localhost (unknown [106.51.111.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5992075C;
        Sat,  9 Nov 2019 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573321251;
        bh=vy5NcVkRLavTedN1+Fn+Ya9Xj6EAtbcf0FqL/26lxek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEk2HhZWv/OPHe/GfnKEnfNCbi+6nD5OofeHByF5TlpFEh7QFazvwxaoP+3aPvUuk
         Q9kR1u68YPIfXzaf1iLUFjG8T7j2KzlGn6zK87zZjVQ7sK61pTQWsOvqHWqOsBymGV
         PUBNtooXdICSSu8Jn1U+WQ3YNB7bhZrNUNd4mxiI=
Date:   Sat, 9 Nov 2019 23:10:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 5/5] dmaengine: plx-dma: Implement descriptor submission
Message-ID: <20191109174047.GH952516@vkoul-mobl>
References: <20191022214616.7943-1-logang@deltatee.com>
 <20191022214616.7943-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022214616.7943-6-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-10-19, 15:46, Logan Gunthorpe wrote:
> On prep, a spin lock is taken and the next entry in the circular buffer
> is filled. On submit, the valid bit is set in the hardware descriptor
> and the lock is released.
> 
> The DMA engine is started (if it's not already running) when the client
> calls dma_async_issue_pending().
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/dma/plx_dma.c | 119 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
> index d3c2319e2fad..21e4d7634eeb 100644
> --- a/drivers/dma/plx_dma.c
> +++ b/drivers/dma/plx_dma.c
> @@ -7,6 +7,7 @@
>  
>  #include "dmaengine.h"
>  
> +#include <linux/circ_buf.h>
>  #include <linux/dmaengine.h>
>  #include <linux/kref.h>
>  #include <linux/list.h>
> @@ -122,6 +123,11 @@ static struct plx_dma_dev *chan_to_plx_dma_dev(struct dma_chan *c)
>  	return container_of(c, struct plx_dma_dev, dma_chan);
>  }
>  
> +static struct plx_dma_desc *to_plx_desc(struct dma_async_tx_descriptor *txd)
> +{
> +	return container_of(txd, struct plx_dma_desc, txd);
> +}
> +
>  static struct plx_dma_desc *plx_dma_get_desc(struct plx_dma_dev *plxdev, int i)
>  {
>  	return plxdev->desc_ring[i & (PLX_DMA_RING_COUNT - 1)];
> @@ -244,6 +250,113 @@ static void plx_dma_desc_task(unsigned long data)
>  	plx_dma_process_desc(plxdev);
>  }
>  
> +static struct dma_async_tx_descriptor *plx_dma_prep_memcpy(struct dma_chan *c,
> +		dma_addr_t dma_dst, dma_addr_t dma_src, size_t len,
> +		unsigned long flags)
> +	__acquires(plxdev->ring_lock)
> +{
> +	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(c);
> +	struct plx_dma_desc *plxdesc;
> +
> +	spin_lock_bh(&plxdev->ring_lock);
> +	if (!plxdev->ring_active)
> +		goto err_unlock;
> +
> +	if (!CIRC_SPACE(plxdev->head, plxdev->tail, PLX_DMA_RING_COUNT))
> +		goto err_unlock;
> +
> +	if (len > PLX_DESC_SIZE_MASK)
> +		goto err_unlock;
> +
> +	plxdesc = plx_dma_get_desc(plxdev, plxdev->head);
> +	plxdev->head++;
> +
> +	plxdesc->hw->dst_addr_lo = cpu_to_le32(lower_32_bits(dma_dst));
> +	plxdesc->hw->dst_addr_hi = cpu_to_le16(upper_32_bits(dma_dst));
> +	plxdesc->hw->src_addr_lo = cpu_to_le32(lower_32_bits(dma_src));
> +	plxdesc->hw->src_addr_hi = cpu_to_le16(upper_32_bits(dma_src));
> +
> +	plxdesc->orig_size = len;
> +
> +	if (flags & DMA_PREP_INTERRUPT)
> +		len |= PLX_DESC_FLAG_INT_WHEN_DONE;
> +
> +	plxdesc->hw->flags_and_size = cpu_to_le32(len);
> +	plxdesc->txd.flags = flags;
> +
> +	/* return with the lock held, it will be released in tx_submit */
> +
> +	return &plxdesc->txd;
> +
> +err_unlock:
> +	/*
> +	 * Keep sparse happy by restoring an even lock count on
> +	 * this lock.
> +	 */
> +	__acquire(plxdev->ring_lock);
> +
> +	spin_unlock_bh(&plxdev->ring_lock);
> +	return NULL;
> +}
> +
> +static dma_cookie_t plx_dma_tx_submit(struct dma_async_tx_descriptor *desc)
> +	__releases(plxdev->ring_lock)
> +{
> +	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(desc->chan);
> +	struct plx_dma_desc *plxdesc = to_plx_desc(desc);
> +	dma_cookie_t cookie;
> +
> +	cookie = dma_cookie_assign(desc);
> +
> +	/*
> +	 * Ensure the descriptor updates are visible to the dma device
> +	 * before setting the valid bit.
> +	 */
> +	wmb();
> +
> +	plxdesc->hw->flags_and_size |= cpu_to_le32(PLX_DESC_FLAG_VALID);

so where do you store the submitted descriptor?

> +
> +	spin_unlock_bh(&plxdev->ring_lock);
> +
> +	return cookie;
> +}
> +
> +static enum dma_status plx_dma_tx_status(struct dma_chan *chan,
> +		dma_cookie_t cookie, struct dma_tx_state *txstate)
> +{
> +	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
> +	enum dma_status ret;
> +
> +	ret = dma_cookie_status(chan, cookie, txstate);
> +	if (ret == DMA_COMPLETE)
> +		return ret;
> +
> +	plx_dma_process_desc(plxdev);

why is this done here..? Query of status should not make you process
something!

> +
> +	return dma_cookie_status(chan, cookie, txstate);
> +}
> +
> +static void plx_dma_issue_pending(struct dma_chan *chan)
> +{
> +	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
> +
> +	rcu_read_lock();
> +	if (!rcu_dereference(plxdev->pdev)) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	/*
> +	 * Ensure the valid bits are visible before starting the
> +	 * DMA engine.
> +	 */
> +	wmb();
> +
> +	writew(PLX_REG_CTRL_START_VAL, plxdev->bar + PLX_REG_CTRL);

start what? 

> +
> +	rcu_read_unlock();
> +}
> +
>  static irqreturn_t plx_dma_isr(int irq, void *devid)
>  {
>  	struct plx_dma_dev *plxdev = devid;
> @@ -307,7 +420,9 @@ static int plx_dma_alloc_desc(struct plx_dma_dev *plxdev)
>  			goto free_and_exit;
>  
>  		dma_async_tx_descriptor_init(&desc->txd, &plxdev->dma_chan);
> +		desc->txd.tx_submit = plx_dma_tx_submit;
>  		desc->hw = &plxdev->hw_ring[i];
> +
>  		plxdev->desc_ring[i] = desc;
>  	}
>  
> @@ -428,11 +543,15 @@ static int plx_dma_create(struct pci_dev *pdev)
>  	dma = &plxdev->dma_dev;
>  	dma->chancnt = 1;
>  	INIT_LIST_HEAD(&dma->channels);
> +	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
>  	dma->copy_align = DMAENGINE_ALIGN_1_BYTE;
>  	dma->dev = get_device(&pdev->dev);
>  
>  	dma->device_alloc_chan_resources = plx_dma_alloc_chan_resources;
>  	dma->device_free_chan_resources = plx_dma_free_chan_resources;
> +	dma->device_prep_dma_memcpy = plx_dma_prep_memcpy;
> +	dma->device_issue_pending = plx_dma_issue_pending;
> +	dma->device_tx_status = plx_dma_tx_status;
>  
>  	chan = &plxdev->dma_chan;
>  	chan->device = dma;
> -- 
> 2.20.1

-- 
~Vinod
