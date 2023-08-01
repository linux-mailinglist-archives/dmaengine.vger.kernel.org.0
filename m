Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90ED76BC74
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 20:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjHAS2y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 14:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjHAS2x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 14:28:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8400E2D7D;
        Tue,  1 Aug 2023 11:28:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 036DC61689;
        Tue,  1 Aug 2023 18:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48F7C433C7;
        Tue,  1 Aug 2023 18:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690914505;
        bh=qq2hMF7w/Pu7ZdsWOzCQ/stYxKwx7YuIUPzmiH4iKFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PKz/e16630V597EjDfkzZ4FqELQFi+WWbwlEAzJIVenElrtf0oF2UV0oeBb3DF45q
         NubYDLPbeRUMjzPuHt2k9dXiv5/euhOYZw7A0OjvqwyV02K4h43pJn6iCc0+VD/426
         FwyYUsjxPsuTkQaWDCprvprm5c0LPsRLo18a8Nli36hcawDX4oUQ0edl3kmaQP6cye
         ugyHflDH9cN7RdDF15nek+YsXS9vHaU77xPtSF3B+KAoebhEspOXkF0cZMjGLjl9TN
         H4V4QWKyo38S0sABROSo0U3j9izcKZGoqRUMJ/6hG8gvfGenYRZpaDTIm0bR9uIq63
         vIVI4UMOXjkUw==
Date:   Tue, 1 Aug 2023 23:58:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Binbin Zhou <zhoubinbin@loongson.cn>
Cc:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, Yingkun Meng <mengyingkun@loongson.cn>
Subject: Re: [PATCH v3 2/2] dmaengine: ls2x-apb: new driver for the Loongson
 LS2X APB DMA controller
Message-ID: <ZMlOxZ1ML+tlRkna@matsya>
References: <cover.1689075791.git.zhoubinbin@loongson.cn>
 <b282ef7c5d1841886a80b2b6502c735f2f0254c9.1689075791.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b282ef7c5d1841886a80b2b6502c735f2f0254c9.1689075791.git.zhoubinbin@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-07-23, 20:19, Binbin Zhou wrote:
> The Loongson LS2X APB DMA controller is available on Loongson-2K chips.
> 
> It is a single-channel, configurable DMA controller IP core based on the
> AXI bus, whose main function is to integrate DMA functionality on a chip
> dedicated to carrying data between memory and peripherals in APB bus
> (e.g. nand).
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Signed-off-by: Yingkun Meng <mengyingkun@loongson.cn>
> ---
>  MAINTAINERS                |   1 +
>  drivers/dma/Kconfig        |  14 +
>  drivers/dma/Makefile       |   1 +
>  drivers/dma/ls2x-apb-dma.c | 684 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 700 insertions(+)
>  create mode 100644 drivers/dma/ls2x-apb-dma.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 60a411936ba7..709c2e9d5f5f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12248,6 +12248,7 @@ M:	Binbin Zhou <zhoubinbin@loongson.cn>
>  L:	dmaengine@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> +F:	drivers/dma/ls2x-apb-dma.c
>  
>  LOONGSON LS2X I2C DRIVER
>  M:	Binbin Zhou <zhoubinbin@loongson.cn>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 644c188d6a11..9b41b59ba2b4 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -376,6 +376,20 @@ config LPC18XX_DMAMUX
>  	  Enable support for DMA on NXP LPC18xx/43xx platforms
>  	  with PL080 and multiplexed DMA request lines.
>  
> +config LS2X_APB_DMA
> +	tristate "Loongson LS2X APB DMA support"
> +	depends on LOONGARCH || COMPILE_TEST
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Support for the Loongson LS2X APB DMA controller driver. The
> +	  DMA controller is having single DMA channel which can be
> +	  configured for different peripherals like audio, nand, sdio
> +	  etc which is in APB bus.
> +
> +	  This DMA controller transfers data from memory to peripheral fifo.
> +	  It does not support memory to memory data transfer.
> +
>  config MCF_EDMA
>  	tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
>  	depends on M5441x || COMPILE_TEST
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index a4fd1ce29510..9b28ddb1ea3b 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_INTEL_IOATDMA) += ioat/
>  obj-y += idxd/
>  obj-$(CONFIG_K3_DMA) += k3dma.o
>  obj-$(CONFIG_LPC18XX_DMAMUX) += lpc18xx-dmamux.o
> +obj-$(CONFIG_LS2X_APB_DMA) += ls2x-apb-dma.o
>  obj-$(CONFIG_MILBEAUT_HDMAC) += milbeaut-hdmac.o
>  obj-$(CONFIG_MILBEAUT_XDMAC) += milbeaut-xdmac.o
>  obj-$(CONFIG_MMP_PDMA) += mmp_pdma.o
> diff --git a/drivers/dma/ls2x-apb-dma.c b/drivers/dma/ls2x-apb-dma.c
> new file mode 100644
> index 000000000000..b3efe86e4330
> --- /dev/null
> +++ b/drivers/dma/ls2x-apb-dma.c
> @@ -0,0 +1,684 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for the Loongson LS2X APB DMA Controller
> + *
> + * Copyright (C) 2017-2023 Loongson Corporation
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

drop this header, of.h should suffice

> +/*
> + * struct ls2x_dma_hw_desc - DMA HW descriptor
> + * @ndesc_addr: the next descriptor low address.
> + * @mem_addr: memory low address.
> + * @apb_addr: device buffer address.
> + * @len: length of a piece of carried content, in words.
> + * @step_len: length between two moved memory data blocks.
> + * @step_times: number of blocks to be carried in a single DMA operation.
> + * @cmd: descriptor command or state.
> + * @stats: DMA status.
> + * @high_ndesc_addr: the next descriptor high address.
> + * @high_mem_addr: memory high address.
> + * @reserved: reserved
> + */
> +struct ls2x_dma_hw_desc {
> +	u32 ndesc_addr;
> +	u32 mem_addr;
> +	u32 apb_addr;

why not use dma_addr_t for this?

> +static void ls2x_dma_start_transfer(struct ls2x_dma_chan *lchan)
> +{
> +	struct ls2x_dma_priv *priv = to_ldma_priv(lchan->vchan.chan.device);
> +	struct ls2x_dma_sg *ldma_sg;
> +	struct virt_dma_desc *vdesc;
> +	u64 val;
> +
> +	/* Get the next descriptor */
> +	vdesc = vchan_next_desc(&lchan->vchan);
> +	if (!vdesc) {
> +		lchan->desc = NULL;
> +		return;
> +	}
> +
> +	list_del(&vdesc->node);
> +	lchan->desc = to_ldma_desc(vdesc);
> +	ldma_sg = &lchan->desc->sg[0];
> +
> +	/* Start DMA */
> +	lo_hi_writeq(0, priv->regs + LDMA_ORDER_ERG);
> +	val = (ldma_sg->llp & ~LDMA_CONFIG_MASK) | LDMA_64BIT_EN | LDMA_START;
> +	lo_hi_writeq(val, priv->regs + LDMA_ORDER_ERG);
> +}
> +
> +static void ls2x_dma_fill_desc(struct ls2x_dma_chan *lchan, u32 i,
> +			       struct ls2x_dma_desc *desc)

pls align this one to precceding open brace (hint: checkpatch.pl
--strict would warn you about this)

> +{
> +	struct ls2x_dma_sg *ldma_sg = &desc->sg[i];
> +
> +	ldma_sg->hw->mem_addr = lower_32_bits(ldma_sg->phys);
> +	ldma_sg->hw->high_mem_addr = upper_32_bits(ldma_sg->phys);
> +	/* Word count register takes input in words */
> +	ldma_sg->hw->len = ldma_sg->len >> 2;
> +	ldma_sg->hw->step_len = 0;
> +	ldma_sg->hw->step_times = 1;
> +
> +	if (desc->direction == DMA_MEM_TO_DEV) {
> +		ldma_sg->hw->cmd = LDMA_INT | LDMA_DATA_DIRECTION;
> +		ldma_sg->hw->apb_addr = lchan->sconfig.dst_addr;
> +	} else {
> +		ldma_sg->hw->cmd = LDMA_INT;
> +		ldma_sg->hw->apb_addr = lchan->sconfig.src_addr;

only addr are used here, what about data width, why is that ignored?

> +	}
> +
> +	/* lets make a link list */
> +	if (i) {

what does i refer to here..?

> +/*
> + * of_ls2x_dma_xlate - Translation function
> + * @dma_spec: Pointer to DMA specifier as found in the device tree
> + * @ofdma: Pointer to DMA controller data
> + *
> + * Return: DMA channel pointer on success and NULL on error
> + */
> +static struct dma_chan *of_ls2x_dma_xlate(struct of_phandle_args *dma_spec,
> +					  struct of_dma *ofdma)
> +{
> +	struct ls2x_dma_priv *priv = ofdma->of_dma_data;
> +	struct ls2x_dma_chan *lchan;
> +
> +	/* We are single channel DMA, just get the channel from priv. */
> +	lchan = &priv->lchan;
> +	if (!lchan)
> +		return NULL;
> +
> +	return dma_get_slave_channel(&lchan->vchan.chan);
> +}

why not use generic xlate?
-- 
~Vinod
