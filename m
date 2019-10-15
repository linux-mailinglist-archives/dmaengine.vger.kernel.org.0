Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9502D7350
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 12:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfJOKd1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 06:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730348AbfJOKd1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Oct 2019 06:33:27 -0400
Received: from localhost (unknown [171.76.96.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C663B2067B;
        Tue, 15 Oct 2019 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571135605;
        bh=qdJqoueENd5lpExCSVcONA4BLf3Zb7UaD0+DUUd/++Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gK7UgJFmceZgTPx4I+tLtHrDLCPmbnV4ISo/4t+tuzZlarENQ9Hn3u/pLBMW9RkKC
         XY89fqsWlc/fksWPAxvcml+BBE2S7iXxAud8prR3dbrK0wpAz8xK0skEI4+wzYRdDS
         HFtH6LIw1yak/acts4U3bbRx8fbwZq5dNexldduQ=
Date:   Tue, 15 Oct 2019 16:03:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexander Gordeev <a.gordeev.box@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Michael Chen <micchen@altera.com>,
        devel@driverdev.osuosl.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: avalon: Intel Avalon-MM DMA Interface
 for PCIe
Message-ID: <20191015103321.GU2654@vkoul-mobl>
References: <cover.1570558807.git.a.gordeev.box@gmail.com>
 <3ed3c016b7fbe69e36023e7ee09c53acac8a064c.1570558807.git.a.gordeev.box@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ed3c016b7fbe69e36023e7ee09c53acac8a064c.1570558807.git.a.gordeev.box@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-10-19, 12:12, Alexander Gordeev wrote:

> +config AVALON_DMA_CTRL_BASE
> +	hex "Avalon DMA controllers base"
> +	default "0x00000000"

what kind of device is this? I dont think we want these and the ones
coming below as part of kernel kconfig!

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Avalon DMA engine
> + *
> + * Author: Alexander Gordeev <a.gordeev.box@gmail.com>

No copyright notices?

> +static int setup_dma_descs(struct dma_desc *dma_descs,
> +			   struct avalon_dma_desc *desc)
> +{
> +	struct scatterlist *sg_stop;
> +	unsigned int sg_set;
> +	int ret;
> +
> +	ret = setup_descs_sg(dma_descs, 0,
> +			     desc->direction,
> +			     desc->dev_addr,
> +			     desc->sg, desc->sg_len,
> +			     desc->sg_curr, desc->sg_offset,
> +			     &sg_stop, &sg_set);
> +	BUG_ON(!ret);

Please remove this and others

> +static int start_dma_xfer(struct avalon_dma_hw *hw,
> +			  struct avalon_dma_desc *desc)
> +{
> +	size_t ctrl_off;
> +	struct __dma_desc_table *__table;
> +	struct dma_desc_table *table;
> +	u32 rc_src_hi, rc_src_lo;
> +	u32 ep_dst_lo, ep_dst_hi;
> +	int last_id, *__last_id;
> +	int nr_descs;
> +
> +	if (desc->direction == DMA_TO_DEVICE) {
> +		__table = &hw->dma_desc_table_rd;
> +
> +		ctrl_off = AVALON_DMA_RD_CTRL_OFFSET;
> +
> +		ep_dst_hi = AVALON_DMA_RD_EP_DST_HI;
> +		ep_dst_lo = AVALON_DMA_RD_EP_DST_LO;
> +
> +		__last_id = &hw->h2d_last_id;
> +	} else if (desc->direction == DMA_FROM_DEVICE) {
> +		__table = &hw->dma_desc_table_wr;
> +
> +		ctrl_off = AVALON_DMA_WR_CTRL_OFFSET;
> +
> +		ep_dst_hi = AVALON_DMA_WR_EP_DST_HI;
> +		ep_dst_lo = AVALON_DMA_WR_EP_DST_LO;
> +
> +		__last_id = &hw->d2h_last_id;
> +	} else {
> +		BUG();
> +	}
> +
> +	table = __table->cpu_addr;
> +	memset(&table->flags, 0, sizeof(table->flags));
> +
> +	nr_descs = setup_dma_descs(table->descs, desc);
> +	if (WARN_ON(nr_descs < 1))
> +		return nr_descs;
> +
> +	last_id = nr_descs - 1;
> +	*__last_id = last_id;
> +
> +	rc_src_hi = __table->dma_addr >> 32;
> +	rc_src_lo = (u32)__table->dma_addr;
> +
> +	start_xfer(hw->regs, ctrl_off,
> +		   rc_src_hi, rc_src_lo,
> +		   ep_dst_hi, ep_dst_lo,
> +		   last_id);
> +
> +	return 0;

why have a return when you always return 0?

> +static irqreturn_t avalon_dma_interrupt(int irq, void *dev_id)
> +{
> +	struct avalon_dma *adma = (struct avalon_dma *)dev_id;
> +	struct avalon_dma_chan *chan = &adma->chan;
> +	struct avalon_dma_hw *hw = &chan->hw;
> +	spinlock_t *lock = &chan->vchan.lock;
> +	u32 *rd_flags = hw->dma_desc_table_rd.cpu_addr->flags;
> +	u32 *wr_flags = hw->dma_desc_table_wr.cpu_addr->flags;
> +	struct avalon_dma_desc *desc;
> +	struct virt_dma_desc *vdesc;
> +	bool rd_done;
> +	bool wr_done;
> +
> +	spin_lock(lock);
> +
> +	rd_done = (hw->h2d_last_id < 0);
> +	wr_done = (hw->d2h_last_id < 0);
> +
> +	if (rd_done && wr_done) {
> +		spin_unlock(lock);
> +		return IRQ_NONE;
> +	}
> +
> +	do {
> +		if (!rd_done && rd_flags[hw->h2d_last_id])
> +			rd_done = true;
> +
> +		if (!wr_done && wr_flags[hw->d2h_last_id])
> +			wr_done = true;
> +	} while (!rd_done || !wr_done);

Can you explain this logic. I dont like busy loop in isr and who updates
rd_done and rd_flags etc..?

> +static struct dma_async_tx_descriptor *
> +avalon_dma_prep_slave_sg(struct dma_chan *dma_chan,
> +			 struct scatterlist *sg, unsigned int sg_len,
> +			 enum dma_transfer_direction direction,
> +			 unsigned long flags, void *context)
> +{
> +	struct avalon_dma_chan *chan = to_avalon_dma_chan(dma_chan);
> +	struct avalon_dma_desc *desc;
> +	gfp_t gfp_flags = in_interrupt() ? GFP_NOWAIT : GFP_KERNEL;

We use GFP_NOWAIT in prep calls. They can be called from atomic context

> +static int __init avalon_pci_probe(struct pci_dev *pci_dev,
> +				   const struct pci_device_id *id)
> +{
> +	void *adma;
> +	void __iomem *regs;
> +	int ret;
> +
> +	ret = pci_enable_device(pci_dev);
> +	if (ret)
> +		goto enable_err;
> +
> +	ret = pci_request_regions(pci_dev, DRIVER_NAME);
> +	if (ret)
> +		goto reg_err;
> +
> +	regs = pci_ioremap_bar(pci_dev, PCI_BAR);

This is a pci device, so we should really be using the PCI way of
setting and querying the resources. Doing this thru kernel config
options is not correct!

> +static int __init avalon_drv_init(void)
> +{
> +	return pci_register_driver(&dma_driver_ops);
> +}
> +
> +static void __exit avalon_drv_exit(void)
> +{
> +	pci_unregister_driver(&dma_driver_ops);
> +}
> +
> +module_init(avalon_drv_init);
> +module_exit(avalon_drv_exit);

pls use module_pci_driver.

-- 
~Vinod
