Return-Path: <dmaengine+bounces-7655-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DAECC26E6
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 12:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7559A3003879
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 11:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6883355028;
	Tue, 16 Dec 2025 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9ZYCN09"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD9355026
	for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885825; cv=none; b=hKVqUfql+jfCbWLJ5zQ7QqJjffKvf2BrfmJgM4vOipxdIdmeBgPz5ckAqEKnzggfll2wbqfIukEYzzkqsFeRFQvzBC8vHG33BcxdVzkFM+co6QI3bzoCEcdt7FfO7gRQN+CdpJnkjhZ4BHiBxPIMpVTacSKc9yEEnr4e1+sR/Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885825; c=relaxed/simple;
	bh=KK8rYQTcI8CsXpatxFi8pM/N+BZNptqEKmZuNAyg/lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwm3n9GB9yOCrx82+uo/CH2NFhoFe5T5PTXO9nFQTece6IMMmwDkXWMgFE8hfhAk9a24depOGdcdGmTaSaSuJfzTuLvlbz3xwfjzmLyfN3osPOv4qehrkd+PDZ09VWjwRA07KzVjJcfVvaS6onILeywo9KVCu3xpKyfxH7Ch8Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9ZYCN09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0077C16AAE;
	Tue, 16 Dec 2025 11:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765885825;
	bh=KK8rYQTcI8CsXpatxFi8pM/N+BZNptqEKmZuNAyg/lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9ZYCN09AvE5WWOIdy/EboXYKz8Rzh8vgYFnKSEb8lK41XkHXg/e1GSkwhJGFXzGV
	 TnrhFIrSnDhgfuRPGq4MrpsI4T/HxDehuF9A6DfGRujLDOuDKPVhfoeQZL1pJ3sHXQ
	 ylH11Z7jc5Gii32Z34pjIqdaO/u4fc8gRGZVUT/M65yKaz83i3PZo7u7fuhVLNvj93
	 1v0T1Wk5Fhj1eOFmFBUI/H3QAfls6ILxXNUZiRZEUSXz/ILoZLdeAR7Yxsp+4yi7ZQ
	 SIR3qJEyWbGtMupwoRCPk/6Jex5SY7W+JChTjdZx4QamdiTbJJXzXLAxJCdqX2xhP0
	 OK7jjeCCE9CrQ==
Date: Tue, 16 Dec 2025 17:20:21 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 3/3] dmaengine: switchtec-dma: Implement descriptor
 submission
Message-ID: <aUFHfUFNrDojRoRm@vaman>
References: <20251215181649.2605-1-logang@deltatee.com>
 <20251215181649.2605-4-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215181649.2605-4-logang@deltatee.com>

On 15-12-25, 11:16, Logan Gunthorpe wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
> 
> On prep, a spin lock is taken and the next entry in the circular buffer
> is filled. On submit, the spin lock just needs to be released as the
> requests are already pending.
> 
> When switchtec_dma_issue_pending() is called, the sq_tail register
> is written to indicate there are new jobs for the dma engine to start
> on.
> 
> Pause and resume operations are implemented by writing to a control
> register.
> 
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Co-developed-by: George Ge <george.ge@microchip.com>
> Signed-off-by: George Ge <george.ge@microchip.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/dma/switchtec_dma.c | 221 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 221 insertions(+)
> 
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 648eabc0f5da..9f95f8887dd2 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -33,6 +33,8 @@ MODULE_AUTHOR("Kelvin Cao");
>  #define SWITCHTEC_REG_SE_BUF_CNT	0x98
>  #define SWITCHTEC_REG_SE_BUF_BASE	0x9a
>  
> +#define SWITCHTEC_DESC_MAX_SIZE		0x100000
> +
>  #define SWITCHTEC_CHAN_CTRL_PAUSE	BIT(0)
>  #define SWITCHTEC_CHAN_CTRL_HALT	BIT(1)
>  #define SWITCHTEC_CHAN_CTRL_RESET	BIT(2)
> @@ -194,6 +196,11 @@ struct switchtec_dma_hw_se_desc {
>  	__le16 sfid;
>  };
>  
> +#define SWITCHTEC_SE_DFM		BIT(5)
> +#define SWITCHTEC_SE_LIOF		BIT(6)
> +#define SWITCHTEC_SE_BRR		BIT(7)
> +#define SWITCHTEC_SE_CID_MASK		GENMASK(15, 0)
> +
>  #define SWITCHTEC_CE_SC_LEN_ERR		BIT(0)
>  #define SWITCHTEC_CE_SC_UR		BIT(1)
>  #define SWITCHTEC_CE_SC_CA		BIT(2)
> @@ -231,6 +238,8 @@ struct switchtec_dma_desc {
>  	bool completed;
>  };
>  
> +#define SWITCHTEC_INVALID_HFID 0xffff
> +
>  #define SWITCHTEC_DMA_SQ_SIZE	SZ_32K
>  #define SWITCHTEC_DMA_CQ_SIZE	SZ_32K
>  
> @@ -603,6 +612,210 @@ static void switchtec_dma_synchronize(struct dma_chan *chan)
>  	spin_unlock_bh(&swdma_chan->complete_lock);
>  }
>  
> +static struct dma_async_tx_descriptor *
> +switchtec_dma_prep_desc(struct dma_chan *c, u16 dst_fid, dma_addr_t dma_dst,
> +			u16 src_fid, dma_addr_t dma_src, u64 data,
> +			size_t len, unsigned long flags)
> +	__acquires(swdma_chan->submit_lock)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(c, struct switchtec_dma_chan, dma_chan);
> +	struct switchtec_dma_desc *desc;
> +	int head, tail;
> +
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +
> +	if (!swdma_chan->ring_active)
> +		goto err_unlock;
> +
> +	tail = READ_ONCE(swdma_chan->tail);
> +	head = swdma_chan->head;
> +
> +	if (!CIRC_SPACE(head, tail, SWITCHTEC_DMA_RING_SIZE))
> +		goto err_unlock;
> +
> +	desc = swdma_chan->desc_ring[head];
> +
> +	if (src_fid != SWITCHTEC_INVALID_HFID &&
> +	    dst_fid != SWITCHTEC_INVALID_HFID)
> +		desc->hw->ctrl |= SWITCHTEC_SE_DFM;
> +
> +	if (flags & DMA_PREP_INTERRUPT)
> +		desc->hw->ctrl |= SWITCHTEC_SE_LIOF;
> +
> +	if (flags & DMA_PREP_FENCE)
> +		desc->hw->ctrl |= SWITCHTEC_SE_BRR;
> +
> +	desc->txd.flags = flags;
> +
> +	desc->completed = false;
> +	desc->hw->opc = SWITCHTEC_DMA_OPC_MEMCPY;
> +	desc->hw->addr_lo = cpu_to_le32(lower_32_bits(dma_src));
> +	desc->hw->addr_hi = cpu_to_le32(upper_32_bits(dma_src));
> +	desc->hw->daddr_lo = cpu_to_le32(lower_32_bits(dma_dst));
> +	desc->hw->daddr_hi = cpu_to_le32(upper_32_bits(dma_dst));
> +	desc->hw->byte_cnt = cpu_to_le32(len);
> +	desc->hw->tlp_setting = 0;
> +	desc->hw->dfid = cpu_to_le16(dst_fid);
> +	desc->hw->sfid = cpu_to_le16(src_fid);
> +	swdma_chan->cid &= SWITCHTEC_SE_CID_MASK;
> +	desc->hw->cid = cpu_to_le16(swdma_chan->cid++);
> +	desc->orig_size = len;
> +
> +	head++;
> +	head &= SWITCHTEC_DMA_RING_SIZE - 1;
> +
> +	/*
> +	 * Ensure the desc updates are visible before updating the head index
> +	 */
> +	smp_store_release(&swdma_chan->head, head);
> +
> +	/* return with the lock held, it will be released in tx_submit */
> +
> +	return &desc->txd;
> +
> +err_unlock:
> +	/*
> +	 * Keep sparse happy by restoring an even lock count on
> +	 * this lock.
> +	 */
> +	__acquire(swdma_chan->submit_lock);
> +
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +	return NULL;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +switchtec_dma_prep_memcpy(struct dma_chan *c, dma_addr_t dma_dst,
> +			  dma_addr_t dma_src, size_t len, unsigned long flags)
> +	__acquires(swdma_chan->submit_lock)
> +{
> +	if (len > SWITCHTEC_DESC_MAX_SIZE) {
> +		/*
> +		 * Keep sparse happy by restoring an even lock count on
> +		 * this lock.
> +		 */
> +		__acquire(swdma_chan->submit_lock);
> +		return NULL;
> +	}
> +
> +	return switchtec_dma_prep_desc(c, SWITCHTEC_INVALID_HFID, dma_dst,
> +				       SWITCHTEC_INVALID_HFID, dma_src, 0, len,
> +				       flags);
> +}
> +
> +static dma_cookie_t
> +switchtec_dma_tx_submit(struct dma_async_tx_descriptor *desc)
> +	__releases(swdma_chan->submit_lock)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(desc->chan, struct switchtec_dma_chan, dma_chan);
> +	dma_cookie_t cookie;
> +
> +	cookie = dma_cookie_assign(desc);
> +
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	return cookie;
> +}

What about the descriptor, you should push into a pending queue or
something here?

> +
> +static enum dma_status switchtec_dma_tx_status(struct dma_chan *chan,
> +		dma_cookie_t cookie, struct dma_tx_state *txstate)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	enum dma_status ret;
> +
> +	ret = dma_cookie_status(chan, cookie, txstate);
> +	if (ret == DMA_COMPLETE)
> +		return ret;
> +
> +	switchtec_dma_cleanup_completed(swdma_chan);

Why are we doing this on a status query??

> +
> +	return dma_cookie_status(chan, cookie, txstate);

No setting residue?

> +}
> +
> +static void switchtec_dma_issue_pending(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
> +
> +	/*
> +	 * Ensure the desc updates are visible before starting the
> +	 * DMA engine.
> +	 */
> +	wmb();
> +
> +	/*
> +	 * The sq_tail register is actually for the head of the
> +	 * submisssion queue. Chip has the opposite define of head/tail
> +	 * to the Linux kernel.
> +	 */
> +
> +	rcu_read_lock();
> +	if (!rcu_dereference(swdma_dev->pdev)) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +	writew(swdma_chan->head, &swdma_chan->mmio_chan_hw->sq_tail);
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	rcu_read_unlock();
> +}

This seems to assume that the channel is idle when issue_pending is
invoked. That is not the right assumption, we can be running a txn so you
need to check if channel is not running and start if it is idle

> +
> +static int switchtec_dma_pause(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		ret = -ENODEV;
> +		goto unlock_and_exit;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(SWITCHTEC_CHAN_CTRL_PAUSE, &chan_hw->ctrl);
> +	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_PAUSED, true);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static int switchtec_dma_resume(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		ret = -ENODEV;
> +		goto unlock_and_exit;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(0, &chan_hw->ctrl);
> +	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_PAUSED, false);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
>  static void switchtec_dma_desc_task(unsigned long data)
>  {
>  	struct switchtec_dma_chan *swdma_chan = (void *)data;
> @@ -733,6 +946,7 @@ static int switchtec_dma_alloc_desc(struct switchtec_dma_chan *swdma_chan)
>  		}
>  
>  		dma_async_tx_descriptor_init(&desc->txd, &swdma_chan->dma_chan);
> +		desc->txd.tx_submit = switchtec_dma_tx_submit;
>  		desc->hw = &swdma_chan->hw_sq[i];
>  		desc->completed = true;
>  
> @@ -1064,10 +1278,17 @@ static int switchtec_dma_create(struct pci_dev *pdev)
>  
>  	dma = &swdma_dev->dma_dev;
>  	dma->copy_align = DMAENGINE_ALIGN_8_BYTES;
> +	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
> +	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
>  	dma->dev = get_device(&pdev->dev);
>  
>  	dma->device_alloc_chan_resources = switchtec_dma_alloc_chan_resources;
>  	dma->device_free_chan_resources = switchtec_dma_free_chan_resources;
> +	dma->device_prep_dma_memcpy = switchtec_dma_prep_memcpy;
> +	dma->device_tx_status = switchtec_dma_tx_status;
> +	dma->device_issue_pending = switchtec_dma_issue_pending;
> +	dma->device_pause = switchtec_dma_pause;
> +	dma->device_resume = switchtec_dma_resume;
>  	dma->device_terminate_all = switchtec_dma_terminate_all;
>  	dma->device_synchronize = switchtec_dma_synchronize;
>  	dma->device_release = switchtec_dma_release;
> -- 
> 2.47.3

-- 
~Vinod

