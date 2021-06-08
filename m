Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E89C39FDE4
	for <lists+dmaengine@lfdr.de>; Tue,  8 Jun 2021 19:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhFHRl3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Jun 2021 13:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232376AbhFHRl1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 8 Jun 2021 13:41:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E63361287;
        Tue,  8 Jun 2021 17:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623173973;
        bh=G0w8IRYv/gI7NXTJMKk89TByjoobmyyxOQUk2Nywga4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmeK6iCr7bR+8a4pC85HGTdtXyY0YqiigMDtJbXDbcEViSGnhedB9+58fV/sY9ov9
         g1aFhubcoDmJq6i8U0aidvjZPoQaDShvUazTnrtT4bmNQWCK2ZsfIn7XpRspNSnpoz
         5fmAjfUJJTjsHHGwNqJytlh+CzVWAjRL5MyrrYJXkyNdoHJWuASR0VhtY1dGI3eJgL
         vRznhnXTmSE3GYxnvqEPm3zB24feFi2Y/+BfJgNxAs+vv80UP6V+P9B+WvYXiKdW+w
         0ToRy4xL33pwX6tWjV+mGqrQfyAmaPg2T8KDCdtnqCI1rs07/ODi9JBHvBi3ZNxnRr
         VNJU7NUlRL72Q==
Date:   Tue, 8 Jun 2021 23:09:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v9 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
Message-ID: <YL+rUBGUJoFLS902@vkoul-mobl>
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-2-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622654551-9204-2-git-send-email-Sanju.Mehta@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-06-21, 12:22, Sanjay R Mehta wrote:

> +static int pt_core_execute_cmd(struct ptdma_desc *desc, struct pt_cmd_queue *cmd_q)
> +{
> +	bool soc = FIELD_GET(DWORD0_SOC, desc->dw0);
> +	u8 *q_desc = (u8 *)&cmd_q->qbase[cmd_q->qidx];
> +	u8 *dp = (u8 *)desc;

this case seems unnecessary?

> +int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
> +			     struct pt_passthru_engine *pt_engine)

Pls align this to preceding open brace, checkpatch with --strict would
warn you about this

> +static irqreturn_t pt_core_irq_handler(int irq, void *data)
> +{
> +	struct pt_device *pt = data;
> +	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
> +	u32 status;
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
> +		if ((status & INT_ERROR) && !cmd_q->cmd_error)
> +			cmd_q->cmd_error = CMD_Q_ERROR(cmd_q->q_status);
> +
> +		/* Acknowledge the interrupt */
> +		iowrite32(status, cmd_q->reg_interrupt_status);
> +	}
> +
> +	pt_core_enable_queue_interrupts(pt);
> +
> +	return IRQ_HANDLED;

should you always return IRQ_HANDLED, that sounds apt for the if loop
but not for the non loop case

> +int pt_core_init(struct pt_device *pt)
> +{
> +	char dma_pool_name[MAX_DMAPOOL_NAME_LEN];
> +	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
> +	u32 dma_addr_lo, dma_addr_hi;
> +	struct device *dev = pt->dev;
> +	struct dma_pool *dma_pool;
> +	int ret;
> +
> +	/* Allocate a dma pool for the queue */
> +	snprintf(dma_pool_name, sizeof(dma_pool_name), "%s_q", pt->name);
> +
> +	dma_pool = dma_pool_create(dma_pool_name, dev,
> +				   PT_DMAPOOL_MAX_SIZE,
> +				   PT_DMAPOOL_ALIGN, 0);
> +	if (!dma_pool) {
> +		dev_err(dev, "unable to allocate dma pool\n");

This is superfluous, allocator would warn on failure

> +static struct pt_device *pt_alloc_struct(struct device *dev)
> +{
> +	struct pt_device *pt;
> +
> +	pt = devm_kzalloc(dev, sizeof(*pt), GFP_KERNEL);
> +
> +	if (!pt)
> +		return NULL;
> +	pt->dev = dev;
> +	pt->ord = atomic_inc_return(&pt_ordinal);

What is the use of this number?

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
> +	dev_dbg(dev, "PTDMA enabled\n");

pls remove these...

> +#include <linux/device.h>
> +#include <linux/pci.h>
> +#include <linux/spinlock.h>
> +#include <linux/mutex.h>
> +#include <linux/list.h>
> +#include <linux/wait.h>
> +#include <linux/dmapool.h>
> +
> +#define MAX_PT_NAME_LEN			16
> +#define MAX_DMAPOOL_NAME_LEN		32
> +
> +#define MAX_HW_QUEUES			1
> +#define MAX_CMD_QLEN			100
> +
> +#define PT_ENGINE_PASSTHRU		5
> +#define PT_OFFSET			0x0
> +
> +#define PT_VSIZE			16
> +#define PT_VMASK			((unsigned int)((1 << PT_VSIZE) - 1))

why cast?

-- 
~Vinod
