Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5575611A948
	for <lists+dmaengine@lfdr.de>; Wed, 11 Dec 2019 11:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfLKKwk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Dec 2019 05:52:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfLKKwk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Dec 2019 05:52:40 -0500
Received: from localhost (unknown [171.76.100.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE0A62073B;
        Wed, 11 Dec 2019 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576061559;
        bh=KnWDWMENquDzWNp+R8f9eK+p6TF4rRyM36s80K7DgtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jiSoLd1mYP1cuSrNC3eC1Qb5/deelIw4rYPa2BO+Y6krCXXWkqQTjkWbUTQmcX14o
         i43+WgvslGbPVnYLAFzspf2OysuATbK73p4U/AZYXRLI2ae/u09OGuT2H+1kHovTeB
         Pm6qfOUvMg7wBENceN3cSB1+s6y6TX75OUK0euaQ=
Date:   Wed, 11 Dec 2019 16:22:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linuxarm@huawei.com, Zhenfa Qiu <qiuzhenfa@hisilicon.com>
Subject: Re: [PATCH v2] dmaengine: hisilicon: Add Kunpeng DMA engine support
Message-ID: <20191211105234.GG2536@vkoul-mobl>
References: <1575943997-164744-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575943997-164744-1-git-send-email-wangzhou1@hisilicon.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-12-19, 10:13, Zhou Wang wrote:
> This patch adds a driver for HiSilicon Kunpeng DMA engine.

Can you please describe this controller here, how many channels,
controller capabilities etc

> +static void hisi_dma_enable_dma(struct hisi_dma_dev *hdma_dev, u32 index,
> +				bool enable)

Coding Style expects the second line to be aligned to preceding line
brace opne, --strict option with checkpatch should warn you!

> +{
> +	void __iomem *addr = hdma_dev->base + HISI_DMA_CTRL0(index);
> +	u32 tmp;
> +
> +	tmp = readl_relaxed(addr);
> +	tmp = enable ? tmp | HISI_DMA_CTRL0_QUEUE_EN :
> +		       tmp & ~HISI_DMA_CTRL0_QUEUE_EN;
> +	writel_relaxed(tmp, addr);
> +}

why not create a modifyl() macro and then use that here and other places
rather than doiun read, modify, write sequence

> +static void hisi_dma_reset_hw_chan(struct hisi_dma_chan *chan)
> +{
> +	struct hisi_dma_dev *hdma_dev = chan->hdma_dev;
> +	u32 index = chan->qp_num, tmp;
> +	int ret;
> +
> +	hisi_dma_pause_dma(hdma_dev, index, true);
> +	hisi_dma_enable_dma(hdma_dev, index, false);
> +	hisi_dma_mask_irq(hdma_dev, index);
> +
> +	ret = readl_relaxed_poll_timeout(hdma_dev->base +
> +		HISI_DMA_Q_FSM_STS(index), tmp,
> +		FIELD_GET(HISI_DMA_FSM_STS_MASK, tmp) != RUN, 10, 1000);
> +	if (ret)
> +		dev_err(&hdma_dev->pdev->dev, "disable channel timeout!\n");

you want to continue on this timeout?

> +static int hisi_dma_terminate_all(struct dma_chan *c)
> +{
> +	struct hisi_dma_chan *chan = to_hisi_dma_chan(c);
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +
> +	hisi_dma_pause_dma(chan->hdma_dev, chan->qp_num, true);
> +	if (chan->desc) {
> +		vchan_terminate_vdesc(&chan->desc->vd);
> +		chan->desc = NULL;
> +	}
> +
> +	vchan_get_all_descriptors(&chan->vc, &head);
> +
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +
> +	vchan_dma_desc_free_list(&chan->vc, &head);
> +	hisi_dma_pause_dma(chan->hdma_dev, chan->qp_num, false);

pause on terminate? Not DISABLE?

> +static struct pci_driver hisi_dma_pci_driver = {
> +	.name		= "hisi_dma",
> +	.id_table	= hisi_dma_pci_tbl,
> +	.probe		= hisi_dma_probe,

no .remove and kconfig has a tristate option!

> +MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
> +MODULE_AUTHOR("Zhenfa Qiu <qiuzhenfa@hisilicon.com>");
> +MODULE_DESCRIPTION("HiSilicon Kunpeng DMA controller driver");
> +MODULE_LICENSE("GPL");

GPL v2..

-- 
~Vinod
