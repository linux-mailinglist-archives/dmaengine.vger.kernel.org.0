Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C24226FB92
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 13:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgIRLet (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Sep 2020 07:34:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgIRLet (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 18 Sep 2020 07:34:49 -0400
Received: from localhost (unknown [136.185.124.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E161F22208;
        Fri, 18 Sep 2020 11:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600428888;
        bh=hvbmsfwPi5LAx2FgLYSC6xzMj7RwwMQh4CaU5M7j/8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vey5lMVK8fs639QubwCa5+8QCpvnDdNrx9POdpYhosFotS30oDLdXo2vGF5c/GM6c
         gTj+lH5ZJL3fThln0mT5G4JVXOrLhBq/XwVO5hZuNx1ugEXWKw7g84w6BwdC4HEX/3
         oDI/MI7wAeD4qaBsmxaRcFYufFJk3L1mhrJZs+lw=
Date:   Fri, 18 Sep 2020 17:04:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thomas Pedersen <twp@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: Add ADM driver
Message-ID: <20200918113443.GN2968@vkoul-mobl>
References: <20200916064326.GA13963@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916064326.GA13963@earth.li>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Jonathan

On 16-09-20, 07:43, Jonathan McDowell wrote:
> From: Andy Gross <agross@codeaurora.org>
> 
> (I'm not sure how best to attribute this. It's originally from Andy
> Gross, the version I picked up was a later version from Thomas Pedersen,
> and I can't find clear indication of why the latest version wasn't
> applied. The device tree details were added back in September 2014. The
> driver is the missing piece in mainline for IPQ8064 NAND support and
> I've been using it successfully with my RB3011 device on 5.8+)

Yeah not sure why the driver was missed :(
Btw this note is helpful but not great for log, you should add it after
sob lines.

> Add the DMA engine driver for the QCOM Application Data Mover (ADM) DMA
> controller found in the MSM8x60 and IPQ/APQ8064 platforms.
> 
> The ADM supports both memory to memory transactions and memory
> to/from peripheral device transactions.  The controller also provides
> flow control capabilities for transactions to/from peripheral devices.
> 
> The initial release of this driver supports slave transfers to/from
> peripherals and also incorporates CRCI (client rate control interface)
> flow control.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> Signed-off-by: Thomas Pedersen <twp@codeaurora.org>
> Signed-off-by: Jonathan McDowell <noodles@earth.li>
> 
> diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
> index 3bcb689162c6..75ee112ccea9 100644
> --- a/drivers/dma/qcom/Kconfig
> +++ b/drivers/dma/qcom/Kconfig
> @@ -28,3 +28,13 @@ config QCOM_HIDMA
>  	  (user to kernel, kernel to kernel, etc.).  It only supports
>  	  memcpy interface. The core is not intended for general
>  	  purpose slave DMA.
> +
> +config QCOM_ADM

alphabetical sort please

> +	tristate "Qualcomm ADM support"
> +	depends on ARCH_QCOM || (COMPILE_TEST && OF && ARM)

Why COMPILE_TEST && OF? just COMPILE_TEST should be fine


> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	---help---
> +	  Enable support for the Qualcomm ADM DMA controller.  This controller
> +	  provides DMA capabilities for both general purpose and on-chip
> +	  peripheral devices.
> diff --git a/drivers/dma/qcom/Makefile b/drivers/dma/qcom/Makefile
> index 1ae92da88b0c..98a021fc6fe5 100644
> --- a/drivers/dma/qcom/Makefile
> +++ b/drivers/dma/qcom/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_QCOM_HIDMA_MGMT) += hdma_mgmt.o
>  hdma_mgmt-objs	 := hidma_mgmt.o hidma_mgmt_sys.o
>  obj-$(CONFIG_QCOM_HIDMA) +=  hdma.o
>  hdma-objs        := hidma_ll.o hidma.o hidma_dbg.o
> +obj-$(CONFIG_QCOM_ADM) += qcom_adm.o

alphabetical sort please

> diff --git a/drivers/dma/qcom/qcom_adm.c b/drivers/dma/qcom/qcom_adm.c
> new file mode 100644
> index 000000000000..36d16c5e1515
> --- /dev/null
> +++ b/drivers/dma/qcom/qcom_adm.c
> @@ -0,0 +1,914 @@
> +/*
> + * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

SPDX tags please

> +/* channel status */
> +#define ADM_CH_STATUS_VALID	BIT(1)
> +
> +/* channel result */
> +#define ADM_CH_RSLT_VALID	BIT(31)
> +#define ADM_CH_RSLT_ERR		BIT(3)
> +#define ADM_CH_RSLT_FLUSH	BIT(2)
> +#define ADM_CH_RSLT_TPD		BIT(1)
> +
> +/* channel conf */
> +#define ADM_CH_CONF_SHADOW_EN		BIT(12)
> +#define ADM_CH_CONF_MPU_DISABLE		BIT(11)
> +#define ADM_CH_CONF_PERM_MPU_CONF	BIT(9)
> +#define ADM_CH_CONF_FORCE_RSLT_EN	BIT(7)
> +#define ADM_CH_CONF_SEC_DOMAIN(ee)	(((ee & 0x3) << 4) | ((ee & 0x4) << 11))

USE FIELD_PREP for this?

> +/* channel result conf */
> +#define ADM_CH_RSLT_CONF_FLUSH_EN	BIT(1)
> +#define ADM_CH_RSLT_CONF_IRQ_EN		BIT(0)
> +
> +/* CRCI CTL */
> +#define ADM_CRCI_CTL_MUX_SEL	BIT(18)
> +#define ADM_CRCI_CTL_RST	BIT(17)
> +
> +/* CI configuration */
> +#define ADM_CI_RANGE_END(x)	(x << 24)
> +#define ADM_CI_RANGE_START(x)	(x << 16)
> +#define ADM_CI_BURST_4_WORDS	BIT(2)
> +#define ADM_CI_BURST_8_WORDS	BIT(3)
> +
> +/* GP CTL */
> +#define ADM_GP_CTL_LP_EN	BIT(12)
> +#define ADM_GP_CTL_LP_CNT(x)	(x << 8)
> +
> +/* Command pointer list entry */
> +#define ADM_CPLE_LP		BIT(31)
> +#define ADM_CPLE_CMD_PTR_LIST	BIT(29)
> +
> +/* Command list entry */
> +#define ADM_CMD_LC		BIT(31)
> +#define ADM_CMD_DST_CRCI(n)	(((n) & 0xf) << 7)
> +#define ADM_CMD_SRC_CRCI(n)	(((n) & 0xf) << 3)
> +
> +#define ADM_CMD_TYPE_SINGLE	0x0
> +#define ADM_CMD_TYPE_BOX	0x3
> +
> +#define ADM_CRCI_MUX_SEL	BIT(4)
> +#define ADM_DESC_ALIGN		8
> +#define ADM_MAX_XFER		(SZ_64K-1)
> +#define ADM_MAX_ROWS		(SZ_64K-1)

space around -  please

> +/**
> + * adm_process_fc_descriptors - Process descriptors for flow controlled xfers
> + *
> + * @achan: ADM channel
> + * @desc: Descriptor memory pointer
> + * @sg: Scatterlist entry
> + * @crci: CRCI value
> + * @burst: Burst size of transaction
> + * @direction: DMA transfer direction
> + */
> +static void *adm_process_fc_descriptors(struct adm_chan *achan,
> +	void *desc, struct scatterlist *sg, u32 crci, u32 burst,
> +	enum dma_transfer_direction direction)

please align these to preceding parenthesis. Note checkpatch with
--strict option will tell you about the style issues

> +static struct dma_async_tx_descriptor *adm_prep_slave_sg(struct dma_chan *chan,
> +	struct scatterlist *sgl, unsigned int sg_len,
> +	enum dma_transfer_direction direction, unsigned long flags,
> +	void *context)
> +{
> +	struct adm_chan *achan = to_adm_chan(chan);
> +	struct adm_device *adev = achan->adev;
> +	struct adm_async_desc *async_desc;
> +	struct scatterlist *sg;
> +	dma_addr_t cple_addr;
> +	u32 i, burst;
> +	u32 single_count = 0, box_count = 0, crci = 0;
> +	void *desc;
> +	u32 *cple;
> +	int blk_size = 0;
> +
> +	if (!is_slave_direction(direction)) {
> +		dev_err(adev->dev, "invalid dma direction\n");
> +		return NULL;
> +	}
> +
> +	/*
> +	 * get burst value from slave configuration
> +	 */
> +	burst = (direction == DMA_MEM_TO_DEV) ?
> +		achan->slave.dst_maxburst :
> +		achan->slave.src_maxburst;
> +
> +	/* if using flow control, validate burst and crci values */
> +	if (achan->slave.device_fc) {
> +
> +		blk_size = adm_get_blksize(burst);
> +		if (blk_size < 0) {
> +			dev_err(adev->dev, "invalid burst value: %d\n",
> +				burst);
> +			return ERR_PTR(-EINVAL);
> +		}
> +
> +		crci = achan->slave.slave_id & 0xf;
> +		if (!crci || achan->slave.slave_id > 0x1f) {
> +			dev_err(adev->dev, "invalid crci value\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +	}
> +
> +	/* iterate through sgs and compute allocation size of structures */
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		if (achan->slave.device_fc) {
> +			box_count += DIV_ROUND_UP(sg_dma_len(sg) / burst,
> +						  ADM_MAX_ROWS);
> +			if (sg_dma_len(sg) % burst)
> +				single_count++;
> +		} else {
> +			single_count += DIV_ROUND_UP(sg_dma_len(sg),
> +						     ADM_MAX_XFER);
> +		}
> +	}
> +
> +	async_desc = kzalloc(sizeof(*async_desc), GFP_ATOMIC);

GFP_NOWAIT please

> +static int adm_dma_probe(struct platform_device *pdev)
> +{
> +	struct adm_device *adev;
> +	struct resource *iores;
> +	int ret;
> +	u32 i;
> +
> +	adev = devm_kzalloc(&pdev->dev, sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		return -ENOMEM;
> +
> +	adev->dev = &pdev->dev;
> +
> +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	adev->regs = devm_ioremap_resource(&pdev->dev, iores);

devm_platform_ioremap_resource() pls

> +	if (IS_ERR(adev->regs))
> +		return PTR_ERR(adev->regs);
> +
> +	adev->irq = platform_get_irq(pdev, 0);
> +	if (adev->irq < 0)
> +		return adev->irq;
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "qcom,ee", &adev->ee);
> +	if (ret) {
> +		dev_err(adev->dev, "Execution environment unspecified\n");
> +		return ret;
> +	}
> +
> +	adev->core_clk = devm_clk_get(adev->dev, "core");
> +	if (IS_ERR(adev->core_clk))
> +		return PTR_ERR(adev->core_clk);
> +
> +	ret = clk_prepare_enable(adev->core_clk);
> +	if (ret) {
> +		dev_err(adev->dev, "failed to prepare/enable core clock\n");
> +		return ret;
> +	}
> +
> +	adev->iface_clk = devm_clk_get(adev->dev, "iface");
> +	if (IS_ERR(adev->iface_clk)) {
> +		ret = PTR_ERR(adev->iface_clk);
> +		goto err_disable_core_clk;
> +	}
> +
> +	ret = clk_prepare_enable(adev->iface_clk);
> +	if (ret) {
> +		dev_err(adev->dev, "failed to prepare/enable iface clock\n");
> +		goto err_disable_core_clk;
> +	}
> +
> +	adev->clk_reset = devm_reset_control_get(&pdev->dev, "clk");
> +	if (IS_ERR(adev->clk_reset)) {
> +		dev_err(adev->dev, "failed to get ADM0 reset\n");
> +		ret = PTR_ERR(adev->clk_reset);
> +		goto err_disable_clks;
> +	}
> +
> +	adev->c0_reset = devm_reset_control_get(&pdev->dev, "c0");
> +	if (IS_ERR(adev->c0_reset)) {
> +		dev_err(adev->dev, "failed to get ADM0 C0 reset\n");
> +		ret = PTR_ERR(adev->c0_reset);
> +		goto err_disable_clks;
> +	}
> +
> +	adev->c1_reset = devm_reset_control_get(&pdev->dev, "c1");
> +	if (IS_ERR(adev->c1_reset)) {
> +		dev_err(adev->dev, "failed to get ADM0 C1 reset\n");
> +		ret = PTR_ERR(adev->c1_reset);
> +		goto err_disable_clks;
> +	}
> +
> +	adev->c2_reset = devm_reset_control_get(&pdev->dev, "c2");
> +	if (IS_ERR(adev->c2_reset)) {
> +		dev_err(adev->dev, "failed to get ADM0 C2 reset\n");
> +		ret = PTR_ERR(adev->c2_reset);
> +		goto err_disable_clks;
> +	}
> +
> +	reset_control_assert(adev->clk_reset);
> +	reset_control_assert(adev->c0_reset);
> +	reset_control_assert(adev->c1_reset);
> +	reset_control_assert(adev->c2_reset);
> +

No delay?

> +static int adm_dma_remove(struct platform_device *pdev)
> +{
> +	struct adm_device *adev = platform_get_drvdata(pdev);
> +	struct adm_chan *achan;
> +	u32 i;
> +
> +	of_dma_controller_free(pdev->dev.of_node);
> +	dma_async_device_unregister(&adev->common);
> +
> +	for (i = 0; i < ADM_MAX_CHANNELS; i++) {
> +		achan = &adev->channels[i];
> +
> +		/* mask IRQs for this channel/EE pair */
> +		writel(0, adev->regs + ADM_CH_RSLT_CONF(achan->id, adev->ee));
> +
> +		adm_terminate_all(&adev->channels[i].vc.chan);
> +	}
> +
vchan_tasklet needs to be killed here

-- 
~Vinod
