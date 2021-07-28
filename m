Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117233D8780
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 07:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhG1Fza (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 01:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhG1Fza (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 01:55:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFCEE60F91;
        Wed, 28 Jul 2021 05:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627451729;
        bh=CHutfR66EytynydQX6I7FYroM0McZFhjdSGnOcWRUMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOgx1/5HtC7kDH/DMOqVu6bijNc2yaE0cA6Fx29IHRiaTMg0nDkdQsEAoLlVmH0E0
         TyT/NRV+eCELg7neljgY9xwSfPEAfRLuT4lnwv3G4yUGifCbqDk3Zx6n8LQ/HRcpqH
         OGsnzibBYI4BGEIpTqy2pIDJuAGJ4aMEzgF8XDX1UrdTAm3criwO/Upcjlho1am4EC
         4qCSAG0xroWT2UDESyvdfy/JsEbBaEpIHNZmPWxX9sN1HMe7jPDUfrv3unELOQCTn6
         0ZaSvVDP27V3HfK9NiJBbsZ+C20udsF8Fg5v2Iwc4Fxb/K8oY7tAqy+xnYUlZTJsyi
         DXVcSZmlJswnw==
Date:   Wed, 28 Jul 2021 11:25:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v10 1/3] dmaengine: ptdma: Initial driver for the AMD
 PTDMA
Message-ID: <YQDxSwT0DYqEf0z5@matsya>
References: <1624207298-115928-1-git-send-email-Sanju.Mehta@amd.com>
 <1624207298-115928-2-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624207298-115928-2-git-send-email-Sanju.Mehta@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-06-21, 11:41, Sanjay R Mehta wrote:

> +static irqreturn_t pt_core_irq_handler(int irq, void *data)
> +{
> +	struct pt_device *pt = data;
> +	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
> +	u32 status;
> +	bool err = true;
> +
> +	pt_core_disable_queue_interrupts(pt);
> +
> +	status = ioread32(cmd_q->reg_interrupt_status);
> +	if (status) {
> +		cmd_q->int_status = status;
> +		cmd_q->q_status = ioread32(cmd_q->reg_status);
> +		cmd_q->q_int_status = ioread32(cmd_q->reg_int_status);
> +
> +		/* On error, only save the first error value */
> +		if ((status & INT_ERROR) && !cmd_q->cmd_error) {
> +			cmd_q->cmd_error = CMD_Q_ERROR(cmd_q->q_status);
> +			err = false;
> +		}
> +
> +		/* Acknowledge the interrupt */
> +		iowrite32(status, cmd_q->reg_interrupt_status);
> +	}
> +
> +	pt_core_enable_queue_interrupts(pt);
> +
> +	return err ? IRQ_HANDLED : IRQ_NONE;

On err you should not return IRQ_NONE. IRQ_NONE means "interrupt was not
from this device or was not handled"

Error is handled here!

> +static struct pt_device *pt_alloc_struct(struct device *dev)
> +{
> +	struct pt_device *pt;
> +
> +	pt = devm_kzalloc(dev, sizeof(*pt), GFP_KERNEL);
> +
> +	if (!pt)
> +		return NULL;
> +	pt->dev = dev;
> +
> +	INIT_LIST_HEAD(&pt->cmd);
> +
> +	snprintf(pt->name, MAX_PT_NAME_LEN, "pt-%s", dev_name(dev));

what is this name used for? Why not use dev_name everywhere?

> +static int pt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct pt_device *pt;
> +	struct pt_msix *pt_msix;
> +	struct device *dev = &pdev->dev;
> +	void __iomem * const *iomap_table;
> +	int bar_mask;
> +	int ret = -ENOMEM;
> +
> +	pt = pt_alloc_struct(dev);
> +	if (!pt)
> +		goto e_err;
> +
> +	pt_msix = devm_kzalloc(dev, sizeof(*pt_msix), GFP_KERNEL);
> +	if (!pt_msix)
> +		goto e_err;
> +
> +	pt->pt_msix = pt_msix;
> +	pt->dev_vdata = (struct pt_dev_vdata *)id->driver_data;
> +	if (!pt->dev_vdata) {
> +		ret = -ENODEV;
> +		dev_err(dev, "missing driver data\n");
> +		goto e_err;
> +	}
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		dev_err(dev, "pcim_enable_device failed (%d)\n", ret);
> +		goto e_err;
> +	}
> +
> +	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
> +	ret = pcim_iomap_regions(pdev, bar_mask, "ptdma");
> +	if (ret) {
> +		dev_err(dev, "pcim_iomap_regions failed (%d)\n", ret);
> +		goto e_err;
> +	}
> +
> +	iomap_table = pcim_iomap_table(pdev);
> +	if (!iomap_table) {
> +		dev_err(dev, "pcim_iomap_table failed\n");
> +		ret = -ENOMEM;
> +		goto e_err;
> +	}
> +
> +	pt->io_regs = iomap_table[pt->dev_vdata->bar];
> +	if (!pt->io_regs) {
> +		dev_err(dev, "ioremap failed\n");
> +		ret = -ENOMEM;
> +		goto e_err;
> +	}
> +
> +	ret = pt_get_irqs(pt);
> +	if (ret)
> +		goto e_err;
> +
> +	pci_set_master(pdev);
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
> +	if (ret) {
> +		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +		if (ret) {
> +			dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n",
> +				ret);
> +			goto e_err;
> +		}
> +	}
> +
> +	dev_set_drvdata(dev, pt);
> +
> +	if (pt->dev_vdata)
> +		ret = pt_core_init(pt);
> +
> +	if (ret)
> +		goto e_err;
> +
> +	return 0;
> +
> +e_err:
> +	dev_err(dev, "initialization failed\n");

log the err code, that is very useful!

> +	/* Register addresses for queue */
> +	void __iomem *reg_control;
> +	void __iomem *reg_tail_lo;
> +	void __iomem *reg_head_lo;
> +	void __iomem *reg_int_enable;
> +	void __iomem *reg_interrupt_status;
> +	void __iomem *reg_status;
> +	void __iomem *reg_int_status;
> +	void __iomem *reg_dma_status;
> +	void __iomem *reg_dma_read_status;
> +	void __iomem *reg_dma_write_status;

this looks like pointer to registers, wont it make sense to keep base
ptr and use offset to read..?

Looking at pt_init_cmdq_regs(), i think that seems to be the case. Why
waste so much memory by having so many pointers?


> +	u32 qcontrol; /* Cached control register */
> +
> +	/* Status values from job */
> +	u32 int_status;
> +	u32 q_status;
> +	u32 q_int_status;
> +	u32 cmd_error;
> +} ____cacheline_aligned;
> +
> +struct pt_device {
> +	struct list_head entry;
> +
> +	unsigned int ord;

Unused?

-- 
~Vinod
