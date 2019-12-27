Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7606312B1C5
	for <lists+dmaengine@lfdr.de>; Fri, 27 Dec 2019 07:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfL0GeS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Dec 2019 01:34:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:42856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfL0GeS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Dec 2019 01:34:18 -0500
Received: from localhost (unknown [106.201.34.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7251220828;
        Fri, 27 Dec 2019 06:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577428457;
        bh=QmhOaQhmStFpEX9h7iiPOQiA3ViF2ugMgnDWtCU9Ek8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j71b1ORR5isd/iuQCkuKk+CZkf8gXZyRZKiNR9MZgAtgIb1azhbGHN4o6PHKvEBvO
         10xvGkDVQM+Bk8xfelvhFK+bnnZKiBgkzhXwAPSNKQxR/FvxCtP3ZqX3MW4AuQTi95
         ceEaiwYCt+BlTKfgKiJO5RABJlP+bu1JKrCSxUOg=
Date:   Fri, 27 Dec 2019 12:04:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 2/2] dmaengine: uniphier-xdmac: Add UniPhier external DMA
 controller driver
Message-ID: <20191227063411.GG3006@vkoul-mobl>
References: <1576630620-1977-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1576630620-1977-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576630620-1977-3-git-send-email-hayashi.kunihiko@socionext.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-12-19, 09:57, Kunihiko Hayashi wrote:
> This adds external DMA controller driver implemented in Socionext
> UniPhier SoCs. This driver supports DMA_MEMCPY and DMA_SLAVE modes.
> 
> Since this driver does not support the the way to transfer size
> unaligned to burst width, 'src_maxburst' or 'dst_maxburst' of

You mean driver does not support any unaligned bursts?

> +static int uniphier_xdmac_probe(struct platform_device *pdev)
> +{
> +	struct uniphier_xdmac_device *xdev;
> +	struct device *dev = &pdev->dev;
> +	struct dma_device *ddev;
> +	int irq;
> +	int nr_chans;
> +	int i, ret;
> +
> +	if (of_property_read_u32(dev->of_node, "dma-channels", &nr_chans))
> +		return -EINVAL;
> +	if (nr_chans > XDMAC_MAX_CHANS)
> +		nr_chans = XDMAC_MAX_CHANS;
> +
> +	xdev = devm_kzalloc(dev, struct_size(xdev, channels, nr_chans),
> +			    GFP_KERNEL);
> +	if (!xdev)
> +		return -ENOMEM;
> +
> +	xdev->nr_chans = nr_chans;
> +	xdev->reg_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(xdev->reg_base))
> +		return PTR_ERR(xdev->reg_base);
> +
> +	ddev = &xdev->ddev;
> +	ddev->dev = dev;
> +	dma_cap_zero(ddev->cap_mask);
> +	dma_cap_set(DMA_MEMCPY, ddev->cap_mask);
> +	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
> +	ddev->src_addr_widths = UNIPHIER_XDMAC_BUSWIDTHS;
> +	ddev->dst_addr_widths = UNIPHIER_XDMAC_BUSWIDTHS;
> +	ddev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) |
> +			   BIT(DMA_MEM_TO_MEM);
> +	ddev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> +	ddev->max_burst = XDMAC_MAX_WORDS;
> +	ddev->device_free_chan_resources = uniphier_xdmac_free_chan_resources;
> +	ddev->device_prep_dma_memcpy = uniphier_xdmac_prep_dma_memcpy;
> +	ddev->device_prep_slave_sg = uniphier_xdmac_prep_slave_sg;
> +	ddev->device_config = uniphier_xdmac_slave_config;
> +	ddev->device_terminate_all = uniphier_xdmac_terminate_all;
> +	ddev->device_synchronize = uniphier_xdmac_synchronize;
> +	ddev->device_tx_status = dma_cookie_status;
> +	ddev->device_issue_pending = uniphier_xdmac_issue_pending;
> +	INIT_LIST_HEAD(&ddev->channels);
> +
> +	for (i = 0; i < nr_chans; i++) {
> +		ret = uniphier_xdmac_chan_init(xdev, i);
> +		if (ret) {
> +			dev_err(dev,
> +				"Failed to initialize XDMAC channel %d\n", i);
> +			return ret;

so on error for channel N we leave N-1 channels initialized?

> +static int uniphier_xdmac_remove(struct platform_device *pdev)
> +{
> +	struct uniphier_xdmac_device *xdev = platform_get_drvdata(pdev);
> +	struct dma_device *ddev = &xdev->ddev;
> +	struct dma_chan *chan;
> +	int ret;
> +
> +	/*
> +	 * Before reaching here, almost all descriptors have been freed by the
> +	 * ->device_free_chan_resources() hook. However, each channel might
> +	 * be still holding one descriptor that was on-flight at that moment.
> +	 * Terminate it to make sure this hardware is no longer running. Then,
> +	 * free the channel resources once again to avoid memory leak.
> +	 */
> +	list_for_each_entry(chan, &ddev->channels, device_node) {
> +		ret = dmaengine_terminate_sync(chan);
> +		if (ret)
> +			return ret;
> +		uniphier_xdmac_free_chan_resources(chan);

terminating sounds okayish but not freeing here. .ree_chan_resources()
should have been called already and that should ensure that termination
is already done...

-- 
~Vinod
