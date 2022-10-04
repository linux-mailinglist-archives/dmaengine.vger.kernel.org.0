Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED755F3E18
	for <lists+dmaengine@lfdr.de>; Tue,  4 Oct 2022 10:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiJDITT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Oct 2022 04:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJDITQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Oct 2022 04:19:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDE2AE70;
        Tue,  4 Oct 2022 01:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664871553; x=1696407553;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3kA13kKYGE3UFOIjOT0eOXD2NOdnFNuViuzBQ9ypSX8=;
  b=FmHjFqpTG2RRBVIjTN8iLEtC/yOpYzH/5UzUZcIUGpeJzziEg1uzY2kO
   LeFt7Lrr7HDV0ycolDk/9wWApt9iPt65rBlBSNo6JYltEtmWk229mOWj3
   HsBt+BSghjfLNA1/9KMRWBy9YnPo1Dy+r9TGWf25x3kw0wbQ/qJiV2Bze
   ZZeqe5vX5TruYq4jc54dnS7xVYaE74SAM5i0fsL22ynYHsaHtzuwDfX9c
   mHth0PHrDk5ftbPpakUDFyotyn8zfExa8KrjLzCbvudmgrsRdHMpEMivc
   OsOkak08sTmdGnfdCIE5h73+x72p6rcTPyVsX4Bmv4GH8gjzAC9uQlqVo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="304398337"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="304398337"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 01:19:12 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="654686396"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="654686396"
Received: from kmreisi-mobl.ger.corp.intel.com ([10.252.39.196])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 01:19:09 -0700
Date:   Tue, 4 Oct 2022 11:18:54 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, trix@redhat.com,
        tumic@gpxsee.org, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com
Subject: Re: [PATCH V5 XDMA 1/2] dmaengine: xilinx: xdma: Add xilinx xdma
 driver
In-Reply-To: <1664409507-64079-2-git-send-email-lizhi.hou@amd.com>
Message-ID: <6ba2221c-bbc9-a33c-7e62-85c2d87ceeed@linux.intel.com>
References: <1664409507-64079-1-git-send-email-lizhi.hou@amd.com> <1664409507-64079-2-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 28 Sep 2022, Lizhi Hou wrote:

> Add driver to enable PCIe board which uses XDMA (the DMA/Bridge Subsystem
> for PCI Express). For example, Xilinx Alveo PCIe devices.
>     https://www.xilinx.com/products/boards-and-kits/alveo.html
> 
> The XDMA engine support up to 4 Host to Card (H2C) and 4 Card to Host (C2H)
> channels. Memory transfers are specified on a per-channel basis in
> descriptor linked lists, which the DMA fetches from host memory and
> processes. Events such as descriptor completion and errors are signaled
> using interrupts. The hardware detail is provided by
>     https://docs.xilinx.com/r/en-US/pg195-pcie-dma/Introduction
> 
> This driver implements dmaengine APIs.
>     - probe the available DMA channels
>     - use dma_slave_map for channel lookup
>     - use virtual channel to manage dmaengine tx descriptors
>     - implement device_prep_slave_sg callback to handle host scatter gather
>       list
>     - implement device_config to config device address for DMA transfer
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Brian Xu <brian.xu@amd.com>
> ---

> +/* bits of the channel control register */
> +#define CHAN_CTRL_RUN_STOP			BIT(0)
> +#define CHAN_CTRL_IE_DESC_STOPPED		BIT(1)
> +#define CHAN_CTRL_IE_DESC_COMPLETED		BIT(2)
> +#define CHAN_CTRL_IE_DESC_ALIGN_MISMATCH	BIT(3)
> +#define CHAN_CTRL_IE_MAGIC_STOPPED		BIT(4)
> +#define CHAN_CTRL_IE_IDLE_STOPPED		BIT(6)
> +#define CHAN_CTRL_IE_READ_ERROR			(0x1FUL << 9)
> +#define CHAN_CTRL_IE_DESC_ERROR			(0x1FUL << 19)

Looks GENMASK()

> +/* bits of the SG DMA control register */
> +#define XDMA_CTRL_RUN_STOP			BIT(0)
> +#define XDMA_CTRL_IE_DESC_STOPPED		BIT(1)
> +#define XDMA_CTRL_IE_DESC_COMPLETED		BIT(2)
> +#define XDMA_CTRL_IE_DESC_ALIGN_MISMATCH	BIT(3)
> +#define XDMA_CTRL_IE_MAGIC_STOPPED		BIT(4)
> +#define XDMA_CTRL_IE_IDLE_STOPPED		BIT(6)
> +#define XDMA_CTRL_IE_READ_ERROR			(0x1FUL << 9)
> +#define XDMA_CTRL_IE_DESC_ERROR			(0x1FUL << 19)

Ditto.

> +/**
> + * xdma_config_channels - Detect and config DMA channels
> + * @xdev: DMA device pointer
> + * @dir: Channel direction
> + */
> +static int xdma_config_channels(struct xdma_device *xdev,
> +				enum dma_transfer_direction dir)
> +{
> +	struct xdma_platdata *pdata = dev_get_platdata(&xdev->pdev->dev);
> +	u32 base, identifier, target;
> +	struct xdma_chan **chans;
> +	u32 *chan_num;
> +	int i, j, ret;
> +
> +	if (dir == DMA_MEM_TO_DEV) {
> +		base = XDMA_CHAN_H2C_OFFSET;
> +		target = XDMA_CHAN_H2C_TARGET;
> +		chans = &xdev->h2c_chans;
> +		chan_num = &xdev->h2c_chan_num;
> +	} else if (dir == DMA_DEV_TO_MEM) {
> +		base = XDMA_CHAN_C2H_OFFSET;
> +		target = XDMA_CHAN_C2H_TARGET;
> +		chans = &xdev->c2h_chans;
> +		chan_num = &xdev->c2h_chan_num;
> +	} else {
> +		xdma_err(xdev, "invalid direction specified");
> +		return -EINVAL;
> +	}
> +
> +	/* detect number of available DMA channels */
> +	for (i = 0, *chan_num = 0; i < pdata->max_dma_channels; i++) {
> +		ret = xdma_read_reg(xdev, base + i * XDMA_CHAN_STRIDE,
> +				    XDMA_CHAN_IDENTIFIER, &identifier);
> +		if (ret) {
> +			xdma_err(xdev, "failed to read channel id: %d", ret);
> +			return ret;
> +		}
> +
> +		/* check if it is available DMA channel */
> +		if (XDMA_CHAN_CHECK_TARGET(identifier, target))
> +			(*chan_num)++;
> +	}
> +
> +	if (!*chan_num) {
> +		xdma_err(xdev, "does not probe any channel");
> +		return -EINVAL;
> +	}
> +
> +	*chans = devm_kzalloc(&xdev->pdev->dev, sizeof(**chans) * (*chan_num),
> +			      GFP_KERNEL);
> +	if (!*chans)
> +		return -ENOMEM;
> +
> +	for (i = 0, j = 0; i < pdata->max_dma_channels; i++) {
> +		ret = xdma_read_reg(xdev, base + i * XDMA_CHAN_STRIDE,
> +				    XDMA_CHAN_IDENTIFIER, &identifier);
> +		if (ret) {
> +			xdma_err(xdev, "failed to read channel id: %d", ret);
> +			return ret;
> +		}

Is it ok to not rollback the allocation in case of an error occurs?

> +
> +		if (!XDMA_CHAN_CHECK_TARGET(identifier, target))
> +			continue;
> +
> +		if (j == *chan_num) {
> +			xdma_err(xdev, "invalid channel number");
> +			return -EIO;
> +		}

Same here?

> +
> +		/* init channel structure and hardware */
> +		(*chans)[j].xdev_hdl = xdev;
> +		(*chans)[j].base = base + i * XDMA_CHAN_STRIDE;
> +		(*chans)[j].dir = dir;
> +
> +		ret = xdma_channel_init(&(*chans)[j]);
> +		if (ret)
> +			return ret;

And here.

> +		(*chans)[j].vchan.desc_free = xdma_free_desc;
> +		vchan_init(&(*chans)[j].vchan, &xdev->dma_dev);
> +
> +		j++;
> +	}
> +
> +	dev_info(&xdev->pdev->dev, "configured %d %s channels", j,
> +		 (dir == DMA_MEM_TO_DEV) ? "H2C" : "C2H");
> +
> +	return 0;
> +}


> +static int xdma_irq_init(struct xdma_device *xdev)
> +{
> +	u32 irq = xdev->irq_start;
> +	int i, j, ret;
> +
> +	/* return failure if there are not enough IRQs */
> +	if (xdev->irq_num < xdev->h2c_chan_num + xdev->c2h_chan_num) {
> +		xdma_err(xdev, "not enough irq");
> +		return -EINVAL;
> +	}
> +
> +	/* setup H2C interrupt handler */
> +	for (i = 0; i < xdev->h2c_chan_num; i++) {
> +		ret = request_irq(irq, xdma_channel_isr, 0,
> +				  "xdma-h2c-channel", &xdev->h2c_chans[i]);
> +		if (ret) {
> +			xdma_err(xdev, "H2C channel%d request irq%d failed: %d",
> +				 i, irq, ret);
> +			for (j = 0; j < i; j++) {
> +				free_irq(xdev->h2c_chans[j].irq,
> +					 &xdev->h2c_chans[j]);
> +			}
> +			return ret;

Remove freeing for loop and just do
			goto failed_init_c2h;
And reverse the iteration order down on the error path (from i to zero) by 
using
	while (i--)

> +		}
> +		xdev->h2c_chans[i].irq = irq;
> +		irq++;
> +	}
> +
> +	/* setup C2H interrupt handler */
> +	for (i = 0; i < xdev->c2h_chan_num; i++) {
> +		ret = request_irq(irq, xdma_channel_isr, 0,
> +				  "xdma-c2h-channel", &xdev->c2h_chans[i]);
> +		if (ret) {
> +			xdma_err(xdev, "H2C channel%d request irq%d failed: %d",
> +				 i, irq, ret);
> +			for (j = 0; j < i; j++) {
> +				free_irq(xdev->c2h_chans[j].irq,
> +					 &xdev->c2h_chans[j]);
> +			}
> +			goto failed_init_c2h;

Ditto. But use j for this whole for loop so you can just do while (j--) on 
the error path as the index variable won't clash with the previous loop.

> +		}
> +		xdev->c2h_chans[i].irq = irq;
> +		irq++;
> +	}
> +
> +	/* config hardware IRQ registers */
> +	ret = xdma_set_vector_reg(xdev, XDMA_IRQ_CHAN_VEC_NUM, 0,
> +				  xdev->h2c_chan_num + xdev->c2h_chan_num);
> +	if (ret) {
> +		xdma_err(xdev, "failed to set channel vectors: %d", ret);
> +		goto failed;
> +	}
> +
> +	/* enable interrupt */
> +	ret = xdma_enable_intr(xdev);
> +	if (ret) {
> +		xdma_err(xdev, "failed to enable interrupts: %d", ret);
> +		goto failed;
> +	}
> +
> +	return 0;
> +
> +failed:
> +	for (i = 0; i < xdev->c2h_chan_num; i++)

As mentioned above:

while (j--)

> +		free_irq(xdev->c2h_chans[i].irq, &xdev->c2h_chans[i]);
> +failed_init_c2h:
> +	for (i = 0; i < xdev->h2c_chan_num; i++)

while (i--)

> +		free_irq(xdev->h2c_chans[i].irq, &xdev->h2c_chans[i]);
> +
> +	return ret;
> +}
> +
> +static bool xdma_filter_fn(struct dma_chan *chan, void *param)
> +{
> +	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
> +	struct xdma_chan_info *chan_info = param;
> +
> +	if (chan_info->dir != xdma_chan->dir)
> +		return false;
> +
> +	return true;

return chan_info->dir == xdma_chan->dir;


-- 
 i.

