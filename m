Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50946DC977
	for <lists+dmaengine@lfdr.de>; Mon, 10 Apr 2023 18:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDJQnE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Apr 2023 12:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDJQnD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Apr 2023 12:43:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CF2199E;
        Mon, 10 Apr 2023 09:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nbDfj+fxxyNWvXcCm13Rnl3Z5ky3RPipxesn+scUJrU=; b=162s8flC36vlOsM30mWkmZ2sOm
        C46NMvvp7kg2oQ2i5rMIsPprGa3kbzW3C5pR4yBneFuHT8jPerH1H5iuzGdgrCOwx+x4f0/cKUoRq
        wN7Gli97sJ1UNsm8+vmPrIQUw9WRZ2esGWBJXuTIsOTn+7QTl6Y6mXmx99RIrqMJVr3BoL7Ua64q7
        TanwfvNOdYifA5Zba42RzOU6QvT25ouAxDbfM1lNmIePJt16Q04MlotIuUpRPhIwZXX8hI5M97Y3M
        /FbZvIAKVSau0hUDc9+Wf8luHcf6vbgZHy2cXML2odihx2ZIwUYqXM+D2NRyuzrFSaAtXLyJKSnh7
        ESpUJyhA==;
Received: from [2001:4bb8:192:2d6c:a8bb:7ca0:f381:8b1e] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1plubL-00FZiF-2m;
        Mon, 10 Apr 2023 16:42:44 +0000
Date:   Mon, 10 Apr 2023 18:42:41 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Kelvin Cao <kelvin.cao@microchip.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, logang@deltatee.com,
        george.ge@microchip.com
Subject: Re: [PATCH v2 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <ZDQ8geSEauTsd2ME@infradead.org>
References: <20230403180630.4186061-1-kelvin.cao@microchip.com>
 <20230403180630.4186061-2-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403180630.4186061-2-kelvin.cao@microchip.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Apr 03, 2023 at 11:06:28AM -0700, Kelvin Cao wrote:
> +#define HALT_RETRY 100
> +static int halt_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	u32 status;
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	int retry = HALT_RETRY;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		ret = -ENODEV;
> +		goto unlock_and_exit;
> +	}

This whole RCU critical section around every access to ->pdev scheme
looks a bit bothersome to me.  This means that all the low-level
PCI ops are done in RCU critical section.  Is this something you
came up with or is it copied from other drivers?

Normally we'd do an unregistration from the dmaengine subsystem
first, which might do a RCU synchronization at a high level,
and then we're sure that none of the methods gets called again
on the unregistered device.

Can't this driver (and the dmaengine core) support an operation
mode where you set a shutdown flag at the beginning 
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(SWITCHTEC_CHAN_CTRL_HALT, &chan_hw->ctrl);
> +
> +	ret = -EIO;
> +	do {
> +		status = readl(&chan_hw->status);
> +
> +		if (status & SWITCHTEC_CHAN_STS_HALTED) {
> +			ret = 0;
> +			break;
> +		}
> +
> +		udelay(1000);
> +	} while (retry--);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);

Why is the lock needed while reading the status and waiting
for it with long delays?

> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	ctrl = SWITCHTEC_CHAN_CTRL_RESET;
> +	ctrl |= SWITCHTEC_CHAN_CTRL_ERR_PAUSE;
> +	writel(ctrl, &chan_hw->ctrl);
> +
> +	udelay(1000);
> +
> +	ctrl = SWITCHTEC_CHAN_CTRL_ERR_PAUSE;
> +	writel(ctrl, &chan_hw->ctrl);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);

This looks broken.  PCIe MMIO Write TLPs an might not never
reach the device until you do a read from it.  So instead of
the udelay you probably need to do a read* operation to some
register that has no side effects.

Also what is the point of the ctrl local variable?  Just passing
the values directly would be shorted and easier to read.

> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(SWITCHTEC_CHAN_CTRL_PAUSE, &chan_hw->ctrl);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +	rcu_read_unlock();
> +
> +	/* wait 60ms to ensure no pending CEs */
> +	msleep(60);

Without a previous read* to flush the posted writes you're not
actually waiting 60ms here from the device POV.

> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(SWITCHTEC_CHAN_CTRL_PAUSE, &chan_hw->ctrl);
> +
> +	ret = -EIO;
> +	do {
> +		status = readl(&chan_hw->status);
> +
> +		if (status & SWITCHTEC_CHAN_STS_PAUSED) {
> +			ret = 0;
> +			break;
> +		}
> +
> +		udelay(1000);
> +	} while (retry--);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);

Same comment about waiting under a spinlock here.

> +	do {
> +		status = readl(&chan_hw->status);
> +
> +		if (!(status & SWITCHTEC_CHAN_STS_PAUSED)) {
> +			ret = 0;
> +			break;
> +		}
> +
> +		udelay(1000);
> +	} while (retry--);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);

.. and here.

It might also be useful to have a helper to wait for a certain
bit to be set or not set in the status register rather than
duplicating the code.

> +static void switchtec_dma_synchronize(struct dma_chan *chan)
> +{
> +	struct pci_dev *pdev;
> +	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
> +	int rc;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (pdev)
> +		synchronize_irq(swdma_chan->irq);
> +	rcu_read_unlock();

synchronize_irq can sleep and must not be called in a RCU critical
section.

> +	if (type >= UNKNOWN_TRANSACTION)
> +		goto err_unlock;
> +
> +	if (type == MEMCPY)
> +		if (len > SWITCHTEC_DESC_MAX_SIZE)
> +			goto err_unlock;
> +
> +	if ((type == WIMM) && (len == 8))

Maybe do a switch on the type to make the code more readable?

Also no need for the inner braces in the last line here.

> +static irqreturn_t switchtec_dma_isr(int irq, void *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan = chan;
> +
> +	if (swdma_chan->comp_ring_active)
> +		tasklet_schedule(&swdma_chan->desc_task);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t switchtec_dma_chan_status_isr(int irq, void *dma)
> +{
> +	struct switchtec_dma_dev *swdma_dev = dma;
> +
> +	tasklet_schedule(&swdma_dev->chan_status_task);

What speaks against simply using threaded irqs here instead of the
tasklets?

> +	swdma_chan->hw_cq = dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
> +					       &swdma_chan->dma_addr_cq,
> +					       GFP_KERNEL);
> +	if (!swdma_chan->hw_cq) {
> +		rc = -ENOMEM;
> +		goto free_and_exit;
> +	}
> +
> +	memset(swdma_chan->hw_cq, 0, size);

dma_alloc_coherent always returns zeroed memory, no need to
zero it again.

> +
> +	/* reset host phase tag */
> +	swdma_chan->phase_tag = 0;
> +
> +	size = sizeof(*swdma_chan->desc_ring);
> +	swdma_chan->desc_ring = kcalloc(SWITCHTEC_DMA_RING_SIZE, size,
> +					GFP_KERNEL);
> +	if (!swdma_chan->desc_ring) {
> +		rc = -ENOMEM;
> +		goto free_and_exit;
> +	}
> +
> +	memset(swdma_chan->desc_ring, 0, SWITCHTEC_DMA_RING_SIZE * size);

kcalloc also already zeroes the memory.

> +	writew((__force u16)cpu_to_le16(SWITCHTEC_DMA_SQ_SIZE),
> +	       &swdma_chan->mmio_chan_fw->sq_size);
> +	writew((__force u16)cpu_to_le16(SWITCHTEC_DMA_CQ_SIZE),
> +	       &swdma_chan->mmio_chan_fw->cq_size);

This looks broken to me, writew always expects cpu endian arguments
and byte swaps on big endian systems.

And if it isn't bogus: __force casts need a good detailed comment
explaining them.

> +void switchtec_chan_kobject_del(struct switchtec_dma_chan *swdma_chan);

This function doesn't actually seem to exists, and thus doesn't need
a forward declaration.

> +	if (!swdma_dev)
> +		return -ENOMEM;
> +
> +	bar = pcim_iomap_table(pdev)[0];
> +	swdma_dev->bar = bar;
> +
> +	swdma_dev->mmio_dmac_ver = bar + SWITCHTEC_DMAC_VERSION_OFFSET;
> +	swdma_dev->mmio_dmac_cap = bar + SWITCHTEC_DMAC_CAPABILITY_OFFSET;
> +	swdma_dev->mmio_dmac_status = bar + SWITCHTEC_DMAC_STATUS_OFFSET;
> +	swdma_dev->mmio_dmac_ctrl = bar + SWITCHTEC_DMAC_CONTROL_OFFSET;
> +	swdma_dev->mmio_chan_hw_all = bar + SWITCHTEC_DMAC_CHAN_CTRL_OFFSET;
> +	swdma_dev->mmio_chan_fw_all = bar + SWITCHTEC_DMAC_CHAN_CFG_STS_OFFSET;

These are all either unused or only used once or twice.  I'd drop
all the extra pointers and just do the little bit of arithmetics
in the callers.

But I find the whole pcim_iomap_table concept very confusing to the
reader of the driver, and given that it doesn't really use many
devm or pcim routines I'd suggest removing them all and sticking to
one well understood way of manging resource lifetimes.

> +	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (rc)
> +		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	if (rc)
> +		return rc;

dma_set_mask_and_coherent for a smaller mask will never succeed when
trying to set it to a larger one failed.  So you can remove the second
call here.

> +#define MICROSEMI_VENDOR_ID 0x11f8

This is already in include/linux/pci_ids.h as
PCI_VENDOR_ID_MICROSEMI, please use that.

> +
> +#define SWITCHTEC_PCI_DEVICE(device_id) \
> +	{ \
> +		.vendor     = MICROSEMI_VENDOR_ID, \
> +		.device     = device_id, \
> +		.subvendor  = PCI_ANY_ID, \
> +		.subdevice  = PCI_ANY_ID, \
> +		.class      = PCI_CLASS_SYSTEM_OTHER << 8, \
> +		.class_mask = 0xFFFFFFFF, \
> +	}

Please just use

	PCI_DEVICE(PCI_VENDOR_ID_MICROSEMI, 0x1234),

instead.

> +	SWITCHTEC_PCI_DEVICE(0x4000),  //PFX 100XG4

and please use normal /* */ comments.
