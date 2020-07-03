Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432442134C9
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jul 2020 09:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgGCHSq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 03:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCHSq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 3 Jul 2020 03:18:46 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 805D62088E;
        Fri,  3 Jul 2020 07:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593760725;
        bh=q2B3lnfM/DwL4HaE9L7hqetjkT0SRbnWQrIyGxtzCu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JWss+/2BfnU0BubfCD6CTXV7nP5QSOYbFhcRQ7yE7SM6q1YF9Y/8/En2cyjlBT85D
         Shu0NYTOA2BUecDDg3egGC0Zhjty7g8MyqbzgX07Es2ey5tlP62Qaq76WH5NkGK+z3
         rL+YWlBW7w3I9PE+RuxxOApAbGqewZFxx0P/bLqU=
Date:   Fri, 3 Jul 2020 12:48:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dmaengine: ptdma: Initial driver for the AMD
 PTDMA controller
Message-ID: <20200703071841.GJ273932@vkoul-mobl>
References: <1592356288-42064-1-git-send-email-Sanju.Mehta@amd.com>
 <1592356288-42064-2-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592356288-42064-2-git-send-email-Sanju.Mehta@amd.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-06-20, 20:11, Sanjay R Mehta wrote:

> +static int pt_core_execute_cmd(struct ptdma_desc *desc,
> +			       struct pt_cmd_queue *cmd_q)
> +{
> +	__le32 *mp;
> +	u32 *dp;
> +	u32 tail;
> +	int	i;

no tabs, spaces pls

> +	int ret = 0;

ret is initialized to 0
> +
> +	if (desc->dw0.soc) {
> +		desc->dw0.ioc = 1;
> +		desc->dw0.soc = 0;
> +	}
> +	mutex_lock(&cmd_q->q_mutex);
> +
> +	mp = (__le32 *)&cmd_q->qbase[cmd_q->qidx];
> +	dp = (u32 *)desc;
> +	for (i = 0; i < 8; i++)
> +		mp[i] = cpu_to_le32(dp[i]); /* handle endianness */
> +
> +	cmd_q->qidx = (cmd_q->qidx + 1) % CMD_Q_LEN;
> +
> +	/* The data used by this command must be flushed to memory */
> +	wmb();
> +
> +	/* Write the new tail address back to the queue register */
> +	tail = lower_32_bits(cmd_q->qdma_tail + cmd_q->qidx * Q_DESC_SIZE);
> +	iowrite32(tail, cmd_q->reg_tail_lo);
> +
> +	/* Turn the queue back on using our cached control register */
> +	pt_start_queue(cmd_q);
> +	mutex_unlock(&cmd_q->q_mutex);
> +
> +	return ret;

and returned here!, why not return 0, or even do void return here

> +int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
> +			     struct pt_passthru_engine *pt_engine)
> +{
> +	struct ptdma_desc desc;
> +
> +	cmd_q->cmd_error = 0;
> +
> +	memset(&desc, 0, Q_DESC_SIZE);

why not sizeof(desc) insteadof Q_DESC_SIZE, this makes code harder to
look to check what this is defined to

> +int pt_core_init(struct pt_device *pt)
> +{
> +	struct device *dev = pt->dev;
> +	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
> +	struct dma_pool *dma_pool;
> +	char dma_pool_name[MAX_DMAPOOL_NAME_LEN];
> +	int ret;
> +	u32 dma_addr_lo, dma_addr_hi;

reverse christmas tree please

> +
> +	/* Allocate a dma pool for the queue */
> +	snprintf(dma_pool_name, sizeof(dma_pool_name), "%s_q", pt->name);
> +
> +	dma_pool = dma_pool_create(dma_pool_name, dev,
> +				   PT_DMAPOOL_MAX_SIZE,
> +				   PT_DMAPOOL_ALIGN, 0);
> +	if (!dma_pool) {
> +		dev_err(dev, "unable to allocate dma pool\n");
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	/* ptdma core initialisation */
> +	iowrite32(CMD_CONFIG_VHB_EN, pt->io_regs + CMD_CONFIG_OFFSET);
> +	iowrite32(CMD_QUEUE_PRIO, pt->io_regs + CMD_QUEUE_PRIO_OFFSET);
> +	iowrite32(CMD_TIMEOUT_DISABLE, pt->io_regs + CMD_TIMEOUT_OFFSET);
> +	iowrite32(CMD_CLK_GATE_CONFIG, pt->io_regs + CMD_CLK_GATE_CTL_OFFSET);
> +	iowrite32(CMD_CONFIG_REQID, pt->io_regs + CMD_REQID_CONFIG_OFFSET);
> +
> +	cmd_q->pt = pt;
> +	cmd_q->dma_pool = dma_pool;
> +	mutex_init(&cmd_q->q_mutex);
> +
> +	/* Page alignment satisfies our needs for N <= 128 */
> +	cmd_q->qsize = Q_SIZE(Q_DESC_SIZE);
> +	cmd_q->qbase = dma_alloc_coherent(dev, cmd_q->qsize,
> +					  &cmd_q->qbase_dma,
> +					   GFP_KERNEL);

last line seems misaligned, please run checkpatch with --strict options
to find these.

> +	if (!cmd_q->qbase) {
> +		dev_err(dev, "unable to allocate command queue\n");
> +		ret = -ENOMEM;
> +		goto e_dma_alloc;
> +	}
> +
> +	cmd_q->qidx = 0;
> +
> +	/* Preset some register values */
> +	cmd_q->reg_control = pt->io_regs + CMD_Q_STATUS_INCR;
> +	pt_init_cmdq_regs(cmd_q);
> +
> +	dev_dbg(dev, "queue available\n");

debug artifacts, pls remove this and others

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
> +	if (ret) {
> +		dev_notice(dev, "PTDMA initialization failed\n");
> +		goto e_err;
> +	}
> +
> +	dev_notice(dev, "PTDMA enabled\n");

dev_dbg?

> +
> +	return 0;
> +
> +e_err:
> +	dev_notice(dev, "initialization failed\n");

dev_err? Also no rollback?

> +	return ret;
> +}
> +
> +static void pt_pci_remove(struct pci_dev *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pt_device *pt = dev_get_drvdata(dev);
> +
> +	if (!pt)
> +		return;
> +
> +	if (pt->dev_vdata)
> +		pt_core_destroy(pt);
> +
> +	pt_free_irqs(pt);
> +}
> +
> +static const struct pt_dev_vdata dev_vdata[] = {
> +	{
> +		.bar = 2,

Is this PCI bars?

> +		.version = PT_VERSION(5, 0),

Hw doesn't tell that?

-- 
~Vinod
