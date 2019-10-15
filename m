Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFC2D7720
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 15:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfJONLm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 09:11:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42990 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbfJONLm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Oct 2019 09:11:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id n14so23764224wrw.9;
        Tue, 15 Oct 2019 06:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kcfG1me/BhzZqP8wY4GRgJComN93ShbPrifsGzk/CNU=;
        b=ZeQBr6AXbyROsqlVpC1AMM/ElLjEl6hOjiNo8COcBS8BAC+T9BWNcf+5gdJObVshdx
         xrwa+bh+8i9vi6isYZJCqoQjdtp8NNZoH/HGqbJeTJtV8o62OLpuy0Z901j3LhmvWLLx
         XXfLeuUFkElSAiFTfxufegJKJnkS7THZfthN8t78iXIlSbmPO5G3DSFpZqS3jPdT1YX9
         fmeduzZIV9OjoJH6fBGUM4B2DSczPvMUiTQ5Ir42YUqGqqsxdfqO9MCYWsKsM36SzLbT
         6yNUjDcXnA7e81I6IsrGZGryxZVG4LoUnB0cMsSd3wL4k8GipmrRLWl40mGwqofqpqzG
         S+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kcfG1me/BhzZqP8wY4GRgJComN93ShbPrifsGzk/CNU=;
        b=AxLI68QXPpbInK9IbqkY+A3yLZSJT+fXPh+oRgJBlu1KDJvZPR9UkJ0OwNzz++NVC5
         1d9iaPI6T7ho1dbzQ8C4IrngBGQ8ktT9d3T/XHuflsLWlXV6sDMLTjEevgjfo0uCQGWj
         zqxWrkevrkfbxb4T9sXKxvsHwi+/6+XBSVfsD0yXbaabhXj/mQlwyZTfvmYUOZVA/SQB
         6WottgkRrs6oc6ep3NC5gbAHI9SE2lJhLtYB7Yv4M3DuRvsdzjQqvUzPu7SwU+gT2KGj
         BGD/U6sEjDgJCOnRqMyyQrqzQlwk0nzZUUro1ydjoCGmJp2bx++LSyGh/t/ulYAleYXD
         PtjA==
X-Gm-Message-State: APjAAAVPa6ZaWL0fels3HtODPtQgbtbrvHxZUVrXt+9fv0i8AUJQCgzr
        UMvGDQUAMR4QT5xdhP9evgM=
X-Google-Smtp-Source: APXvYqyOjxZa8qxqj8xJ/KYmyr1KjwzRqtGZ/50JoH5gH6Ebz98OxPn/rI4Ne0jQxh0zYMYtPjMHFA==
X-Received: by 2002:adf:f606:: with SMTP id t6mr3313449wrp.196.1571145099647;
        Tue, 15 Oct 2019 06:11:39 -0700 (PDT)
Received: from AlexGordeev-DPT-VI0092 ([213.86.25.14])
        by smtp.gmail.com with ESMTPSA id r2sm47452450wma.1.2019.10.15.06.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 06:11:39 -0700 (PDT)
Date:   Tue, 15 Oct 2019 15:11:37 +0200
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Michael Chen <micchen@altera.com>,
        devel@driverdev.osuosl.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: avalon: Intel Avalon-MM DMA Interface
 for PCIe
Message-ID: <20191015131136.GA20789@AlexGordeev-DPT-VI0092>
References: <cover.1570558807.git.a.gordeev.box@gmail.com>
 <3ed3c016b7fbe69e36023e7ee09c53acac8a064c.1570558807.git.a.gordeev.box@gmail.com>
 <20191015103321.GU2654@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015103321.GU2654@vkoul-mobl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Oct 15, 2019 at 04:03:21PM +0530, Vinod Koul wrote:
> what kind of device is this? I dont think we want these and the ones
> coming below as part of kernel kconfig!

Yes, I have already been pointed out on this and will put those as
kernel module parameters in the next version. The device is an IP
block for Intel FPGAs.

> > +static int start_dma_xfer(struct avalon_dma_hw *hw,
> > +			  struct avalon_dma_desc *desc)
> > +{
> > +	size_t ctrl_off;
> > +	struct __dma_desc_table *__table;
> > +	struct dma_desc_table *table;
> > +	u32 rc_src_hi, rc_src_lo;
> > +	u32 ep_dst_lo, ep_dst_hi;
> > +	int last_id, *__last_id;
> > +	int nr_descs;
> > +
> > +	if (desc->direction == DMA_TO_DEVICE) {
> > +		__table = &hw->dma_desc_table_rd;
> > +
> > +		ctrl_off = AVALON_DMA_RD_CTRL_OFFSET;
> > +
> > +		ep_dst_hi = AVALON_DMA_RD_EP_DST_HI;
> > +		ep_dst_lo = AVALON_DMA_RD_EP_DST_LO;
> > +
> > +		__last_id = &hw->h2d_last_id;
> > +	} else if (desc->direction == DMA_FROM_DEVICE) {
> > +		__table = &hw->dma_desc_table_wr;
> > +
> > +		ctrl_off = AVALON_DMA_WR_CTRL_OFFSET;
> > +
> > +		ep_dst_hi = AVALON_DMA_WR_EP_DST_HI;
> > +		ep_dst_lo = AVALON_DMA_WR_EP_DST_LO;
> > +
> > +		__last_id = &hw->d2h_last_id;
> > +	} else {
> > +		BUG();
> > +	}
> > +
> > +	table = __table->cpu_addr;
> > +	memset(&table->flags, 0, sizeof(table->flags));
> > +
> > +	nr_descs = setup_dma_descs(table->descs, desc);
> > +	if (WARN_ON(nr_descs < 1))
> > +		return nr_descs;

(1) Here it may fail.

> > +	last_id = nr_descs - 1;
> > +	*__last_id = last_id;
> > +
> > +	rc_src_hi = __table->dma_addr >> 32;
> > +	rc_src_lo = (u32)__table->dma_addr;
> > +
> > +	start_xfer(hw->regs, ctrl_off,
> > +		   rc_src_hi, rc_src_lo,
> > +		   ep_dst_hi, ep_dst_lo,
> > +		   last_id);
> > +
> > +	return 0;
> 
> why have a return when you always return 0?

Please see (1) above.

> > +static irqreturn_t avalon_dma_interrupt(int irq, void *dev_id)
> > +{
> > +	struct avalon_dma *adma = (struct avalon_dma *)dev_id;
> > +	struct avalon_dma_chan *chan = &adma->chan;
> > +	struct avalon_dma_hw *hw = &chan->hw;
> > +	spinlock_t *lock = &chan->vchan.lock;
> > +	u32 *rd_flags = hw->dma_desc_table_rd.cpu_addr->flags;
> > +	u32 *wr_flags = hw->dma_desc_table_wr.cpu_addr->flags;

(2)

> > +	struct avalon_dma_desc *desc;
> > +	struct virt_dma_desc *vdesc;
> > +	bool rd_done;
> > +	bool wr_done;
> > +
> > +	spin_lock(lock);
> > +
> > +	rd_done = (hw->h2d_last_id < 0);
> > +	wr_done = (hw->d2h_last_id < 0);

(3)

> > +
> > +	if (rd_done && wr_done) {
> > +		spin_unlock(lock);
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	do {
> > +		if (!rd_done && rd_flags[hw->h2d_last_id])
> > +			rd_done = true;
> > +
> > +		if (!wr_done && wr_flags[hw->d2h_last_id])
> > +			wr_done = true;
> > +	} while (!rd_done || !wr_done);
> 
> Can you explain this logic. I dont like busy loop in isr and who updates

Here is the comment in the next version of the patch:

The Intel documentation claims "The Descriptor Controller
writes a 1 to the done bit of the status DWORD to indicate
successful completion. The Descriptor Controller also sends
an MSI interrupt for the final descriptor. After receiving
this MSI, host software can poll the done bit to determine
status."

The above could be read like MSI interrupt might be delivered
before the corresponding done bit is set. But in reality it
does not happen at all (or happens really rare). So put here
the done bit polling, just in case.

> rd_done and rd_flags etc..?

rd_flags/wr_flags are updated by the hardware (2) and mapped in as
coherent DMA memory.

rd_done/wr_done are just local variables (3)

> > +static int __init avalon_pci_probe(struct pci_dev *pci_dev,
> > +				   const struct pci_device_id *id)
> > +{
> > +	void *adma;
> > +	void __iomem *regs;
> > +	int ret;
> > +
> > +	ret = pci_enable_device(pci_dev);
> > +	if (ret)
> > +		goto enable_err;
> > +
> > +	ret = pci_request_regions(pci_dev, DRIVER_NAME);
> > +	if (ret)
> > +		goto reg_err;
> > +
> > +	regs = pci_ioremap_bar(pci_dev, PCI_BAR);
> 
> This is a pci device, so we should really be using the PCI way of
> setting and querying the resources. Doing this thru kernel config
> options is not correct!

I assume you are referring to PCI_BAR in this particular case, right?
If so, this is an excerpt from the documentation that I read like a
BAR the DMA controller is mapped to needs to be configurable:

"When the DMA Descriptor Controller is externally instantiated, these
registers are accessed through a BAR. The offsets must be added to the
base address for the read controller. When the Descriptor Controller
is internally instantiated these registers are accessed through BAR0."

Thank you, Vinod!

> -- 
> ~Vinod
