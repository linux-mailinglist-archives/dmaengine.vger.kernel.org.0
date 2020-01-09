Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A741358E9
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jan 2020 13:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgAIMMX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jan 2020 07:12:23 -0500
Received: from mx.socionext.com ([202.248.49.38]:22779 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730167AbgAIMMW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 9 Jan 2020 07:12:22 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 09 Jan 2020 21:12:20 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id A5D3B603AB;
        Thu,  9 Jan 2020 21:12:20 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 9 Jan 2020 21:13:11 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 322C540343;
        Thu,  9 Jan 2020 21:12:20 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id F0BFA120136;
        Thu,  9 Jan 2020 21:12:19 +0900 (JST)
Date:   Thu, 09 Jan 2020 21:12:20 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 2/2] dmaengine: uniphier-xdmac: Add UniPhier external DMA controller driver
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <20191227063411.GG3006@vkoul-mobl>
References: <1576630620-1977-3-git-send-email-hayashi.kunihiko@socionext.com> <20191227063411.GG3006@vkoul-mobl>
Message-Id: <20200109211219.57FC.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thank you for your comment.

On Fri, 27 Dec 2019 12:04:11 +0530 <vkoul@kernel.org> wrote:

> On 18-12-19, 09:57, Kunihiko Hayashi wrote:
> > This adds external DMA controller driver implemented in Socionext
> > UniPhier SoCs. This driver supports DMA_MEMCPY and DMA_SLAVE modes.
> > 
> > Since this driver does not support the the way to transfer size
> > unaligned to burst width, 'src_maxburst' or 'dst_maxburst' of
> 
> You mean driver does not support any unaligned bursts?

Yes. If transfer size is unaligned to burst size, the final transfer
will be overrun.

> 
> > +static int uniphier_xdmac_probe(struct platform_device *pdev)
> > +{
> > +	struct uniphier_xdmac_device *xdev;
> > +	struct device *dev = &pdev->dev;
> > +	struct dma_device *ddev;
> > +	int irq;
> > +	int nr_chans;
> > +	int i, ret;
> > +
> > +	if (of_property_read_u32(dev->of_node, "dma-channels", &nr_chans))
> > +		return -EINVAL;
> > +	if (nr_chans > XDMAC_MAX_CHANS)
> > +		nr_chans = XDMAC_MAX_CHANS;
> > +
> > +	xdev = devm_kzalloc(dev, struct_size(xdev, channels, nr_chans),
> > +			    GFP_KERNEL);
> > +	if (!xdev)
> > +		return -ENOMEM;
> > +
> > +	xdev->nr_chans = nr_chans;
> > +	xdev->reg_base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(xdev->reg_base))
> > +		return PTR_ERR(xdev->reg_base);
> > +
> > +	ddev = &xdev->ddev;
> > +	ddev->dev = dev;
> > +	dma_cap_zero(ddev->cap_mask);
> > +	dma_cap_set(DMA_MEMCPY, ddev->cap_mask);
> > +	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
> > +	ddev->src_addr_widths = UNIPHIER_XDMAC_BUSWIDTHS;
> > +	ddev->dst_addr_widths = UNIPHIER_XDMAC_BUSWIDTHS;
> > +	ddev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) |
> > +			   BIT(DMA_MEM_TO_MEM);
> > +	ddev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> > +	ddev->max_burst = XDMAC_MAX_WORDS;
> > +	ddev->device_free_chan_resources = uniphier_xdmac_free_chan_resources;
> > +	ddev->device_prep_dma_memcpy = uniphier_xdmac_prep_dma_memcpy;
> > +	ddev->device_prep_slave_sg = uniphier_xdmac_prep_slave_sg;
> > +	ddev->device_config = uniphier_xdmac_slave_config;
> > +	ddev->device_terminate_all = uniphier_xdmac_terminate_all;
> > +	ddev->device_synchronize = uniphier_xdmac_synchronize;
> > +	ddev->device_tx_status = dma_cookie_status;
> > +	ddev->device_issue_pending = uniphier_xdmac_issue_pending;
> > +	INIT_LIST_HEAD(&ddev->channels);
> > +
> > +	for (i = 0; i < nr_chans; i++) {
> > +		ret = uniphier_xdmac_chan_init(xdev, i);
> > +		if (ret) {
> > +			dev_err(dev,
> > +				"Failed to initialize XDMAC channel %d\n", i);
> > +			return ret;
> 
> so on error for channel N we leave N-1 channels initialized?

The uniphier_xdmac_chan_init() always returns 0, so this error decision
can be removed.

> > +static int uniphier_xdmac_remove(struct platform_device *pdev)
> > +{
> > +	struct uniphier_xdmac_device *xdev = platform_get_drvdata(pdev);
> > +	struct dma_device *ddev = &xdev->ddev;
> > +	struct dma_chan *chan;
> > +	int ret;
> > +
> > +	/*
> > +	 * Before reaching here, almost all descriptors have been freed by the
> > +	 * ->device_free_chan_resources() hook. However, each channel might
> > +	 * be still holding one descriptor that was on-flight at that moment.
> > +	 * Terminate it to make sure this hardware is no longer running. Then,
> > +	 * free the channel resources once again to avoid memory leak.
> > +	 */
> > +	list_for_each_entry(chan, &ddev->channels, device_node) {
> > +		ret = dmaengine_terminate_sync(chan);
> > +		if (ret)
> > +			return ret;
> > +		uniphier_xdmac_free_chan_resources(chan);
> 
> terminating sounds okayish but not freeing here. .ree_chan_resources()
> should have been called already and that should ensure that termination
> is already done...

If all transfers are complete, .device_free_chan_resources() should be called.
Since _remove() might be called asynchronously, this is post-processing just
before transfer completion.

Thank you,

---
Best Regards,
Kunihiko Hayashi

