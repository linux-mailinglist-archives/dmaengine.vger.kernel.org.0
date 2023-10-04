Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195407B78E9
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 09:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241515AbjJDHn4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 03:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjJDHnz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 03:43:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3D99B;
        Wed,  4 Oct 2023 00:43:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76DEC433C7;
        Wed,  4 Oct 2023 07:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696405431;
        bh=HfgYTp0WssHEnePmDkQCGt5XcFpdT2hvV0snW81vExs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bXPCIXQqmxiDqSEwBLhtixM/suy318GVMRJ6EGuhPk1PnYSGAmkDDPIMJWPfN27pF
         U5LY9+sywq7Emw7feUDXBeMaD4hSGs6HAgDBgKaJhaL25Wv3t5M8vgcKqaJn7RWOT7
         oAZPadzYPulUBsoEJZGj2zwfW9XTqWJuih/5Jp4L+uXlR/WoSvYPiDzaB/pltBLfo4
         d9UoNx0EO+x4NzNm744oFmDisOggRVwgAm2otbs2tY6knjZaWkTQKzl+6JFvXCUTGb
         RHByqlw0miOJpeCdHCbBhot6BVmwyO13QQcIunviXxGry09JzUeIv4j/dv9C1NZHg+
         EOzJewi7K5Zww==
Date:   Wed, 4 Oct 2023 13:13:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v5 2/2] dmaengine: Loongson1: Add Loongson1 dmaengine
 driver
Message-ID: <ZR0Xs1IGA3v+EJE/@matsya>
References: <20230928121953.524608-1-keguang.zhang@gmail.com>
 <20230928121953.524608-3-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928121953.524608-3-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-09-23, 20:19, Keguang Zhang wrote:
> This patch adds DMA Engine driver for Loongson1 SoCs.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V4 -> V5:
>    Add DT support
>    Use DT data instead of platform data
>    Use chan_id of struct dma_chan instead of own id
>    Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
>    Update the author information to my official name
> V3 -> V4:
>    Use dma_slave_map to find the proper channel.
>    Explicitly call devm_request_irq() and tasklet_kill().
>    Fix namespace issue.
>    Some minor fixes and cleanups.
> V2 -> V3:
>    Rename ls1x_dma_filter_fn to ls1x_dma_filter.
> V1 -> V2:
>    Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
>    and rearrange it in alphabetical order in Kconfig and Makefile.
>    Fix comment style.
> 
>  drivers/dma/Kconfig         |   9 +
>  drivers/dma/Makefile        |   1 +
>  drivers/dma/loongson1-dma.c | 492 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 502 insertions(+)
>  create mode 100644 drivers/dma/loongson1-dma.c
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 4ccae1a3b884..0b0d5c61b4a0 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -369,6 +369,15 @@ config K3_DMA
>  	  Support the DMA engine for Hisilicon K3 platform
>  	  devices.
>  
> +config LOONGSON1_DMA
> +	tristate "Loongson1 DMA support"
> +	depends on MACH_LOONGSON32
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  This selects support for the DMA controller in Loongson1 SoCs,
> +	  which is required by Loongson1 NAND and AC97 support.
> +
>  config LPC18XX_DMAMUX
>  	bool "NXP LPC18xx/43xx DMA MUX for PL080"
>  	depends on ARCH_LPC18XX || COMPILE_TEST
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index 83553a97a010..887103db5ee3 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_INTEL_IDMA64) += idma64.o
>  obj-$(CONFIG_INTEL_IOATDMA) += ioat/
>  obj-y += idxd/
>  obj-$(CONFIG_K3_DMA) += k3dma.o
> +obj-$(CONFIG_LOONGSON1_DMA) += loongson1-dma.o
>  obj-$(CONFIG_LPC18XX_DMAMUX) += lpc18xx-dmamux.o
>  obj-$(CONFIG_MILBEAUT_HDMAC) += milbeaut-hdmac.o
>  obj-$(CONFIG_MILBEAUT_XDMAC) += milbeaut-xdmac.o
> diff --git a/drivers/dma/loongson1-dma.c b/drivers/dma/loongson1-dma.c
> new file mode 100644
> index 000000000000..b589103d5ae0
> --- /dev/null
> +++ b/drivers/dma/loongson1-dma.c
> @@ -0,0 +1,492 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * DMA Driver for Loongson-1 SoC
> + *
> + * Copyright (C) 2015-2023 Keguang Zhang <keguang.zhang@gmail.com>
> + */
> +
> +#include <linux/dmapool.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "dmaengine.h"
> +#include "virt-dma.h"
> +
> +/* Loongson 1 DMA Register Definitions */
> +#define LS1X_DMA_CTRL		0x0
> +
> +/* DMA Control Register Bits */
> +#define LS1X_DMA_STOP		BIT(4)
> +#define LS1X_DMA_START		BIT(3)
> +
> +#define LS1X_DMA_ADDR_MASK	GENMASK(31, 6)
> +
> +/* DMA Command Register Bits */
> +#define LS1X_DMA_RAM2DEV		BIT(12)
> +#define LS1X_DMA_TRANS_OVER		BIT(3)
> +#define LS1X_DMA_SINGLE_TRANS_OVER	BIT(2)
> +#define LS1X_DMA_INT			BIT(1)
> +#define LS1X_DMA_INT_MASK		BIT(0)
> +
> +#define LS1X_DMA_MAX_CHANNELS	3
> +
> +struct ls1x_dma_lli {
> +	u32 next;		/* next descriptor address */
> +	u32 saddr;		/* memory DMA address */
> +	u32 daddr;		/* device DMA address */
> +	u32 length;
> +	u32 stride;
> +	u32 cycles;
> +	u32 cmd;
> +} __aligned(64);
> +
> +struct ls1x_dma_hwdesc {
> +	struct ls1x_dma_lli *lli;
> +	dma_addr_t phys;
> +};
> +
> +struct ls1x_dma_desc {
> +	struct virt_dma_desc vdesc;
> +	struct ls1x_dma_chan *chan;
> +
> +	enum dma_transfer_direction dir;
> +	enum dma_transaction_type type;
> +
> +	unsigned int nr_descs;	/* number of descriptors */
> +	unsigned int nr_done;	/* number of completed descriptors */
> +	struct ls1x_dma_hwdesc hwdesc[];	/* DMA coherent descriptors */
> +};
> +
> +struct ls1x_dma_chan {
> +	struct virt_dma_chan vchan;
> +	struct dma_pool *desc_pool;
> +	struct dma_slave_config cfg;
> +
> +	void __iomem *reg_base;
> +	int irq;
> +
> +	struct ls1x_dma_desc *desc;
> +};
> +
> +struct ls1x_dma {
> +	struct dma_device ddev;
> +	void __iomem *reg_base;
> +
> +	unsigned int nr_chans;
> +	struct ls1x_dma_chan chan[];
> +};
> +
> +#define to_ls1x_dma_chan(dchan)		\
> +	container_of(dchan, struct ls1x_dma_chan, vchan.chan)
> +
> +#define to_ls1x_dma_desc(vdesc)		\
> +	container_of(vdesc, struct ls1x_dma_desc, vdesc)
> +
> +/* macros for registers read/write */
> +#define chan_readl(chan, off)		\
> +	readl((chan)->reg_base + (off))
> +
> +#define chan_writel(chan, off, val)	\
> +	writel((val), (chan)->reg_base + (off))
> +
> +static inline struct device *chan2dev(struct dma_chan *chan)
> +{
> +	return &chan->dev->device;
> +}
> +
> +static void ls1x_dma_free_chan_resources(struct dma_chan *dchan)
> +{
> +	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
> +
> +	vchan_free_chan_resources(&chan->vchan);
> +	dma_pool_destroy(chan->desc_pool);
> +	chan->desc_pool = NULL;
> +}
> +
> +static int ls1x_dma_alloc_chan_resources(struct dma_chan *dchan)
> +{
> +	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
> +
> +	chan->desc_pool = dma_pool_create(dma_chan_name(dchan),
> +					  dchan->device->dev,
> +					  sizeof(struct ls1x_dma_lli),
> +					  __alignof__(struct ls1x_dma_lli), 0);
> +	if (!chan->desc_pool)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void ls1x_dma_free_desc(struct virt_dma_desc *vdesc)
> +{
> +	struct ls1x_dma_desc *desc = to_ls1x_dma_desc(vdesc);
> +
> +	if (desc->nr_descs) {
> +		unsigned int i = desc->nr_descs;
> +		struct ls1x_dma_hwdesc *hwdesc;
> +
> +		do {
> +			hwdesc = &desc->hwdesc[--i];
> +			dma_pool_free(desc->chan->desc_pool, hwdesc->lli,
> +				      hwdesc->phys);
> +		} while (i);
> +	}
> +
> +	kfree(desc);
> +}
> +
> +static struct ls1x_dma_desc *ls1x_dma_alloc_desc(struct ls1x_dma_chan *chan,
> +						 int sg_len)
> +{
> +	struct ls1x_dma_desc *desc;
> +
> +	desc = kzalloc(struct_size(desc, hwdesc, sg_len), GFP_NOWAIT);

why do you need a helper to do kzalloc?

> +
> +	return desc;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +ls1x_dma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
> +		       unsigned int sg_len,
> +		       enum dma_transfer_direction direction,
> +		       unsigned long flags, void *context)
> +{
> +	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
> +	struct dma_slave_config *cfg = &chan->cfg;
> +	struct ls1x_dma_desc *desc;
> +	struct scatterlist *sg;
> +	unsigned int dev_addr, bus_width, cmd, i;
> +
> +	if (!is_slave_direction(direction)) {
> +		dev_err(chan2dev(dchan), "invalid DMA direction!\n");
> +		return NULL;
> +	}
> +
> +	dev_dbg(chan2dev(dchan), "sg_len=%d, dir=%s, flags=0x%lx\n", sg_len,
> +		direction == DMA_MEM_TO_DEV ? "to device" : "from device",
> +		flags);
> +
> +	switch (direction) {
> +	case DMA_MEM_TO_DEV:
> +		dev_addr = cfg->dst_addr;
> +		bus_width = cfg->dst_addr_width;
> +		cmd = LS1X_DMA_RAM2DEV | LS1X_DMA_INT;
> +		break;
> +	case DMA_DEV_TO_MEM:
> +		dev_addr = cfg->src_addr;
> +		bus_width = cfg->src_addr_width;
> +		cmd = LS1X_DMA_INT;
> +		break;
> +	default:
> +		dev_err(chan2dev(dchan),
> +			"unsupported DMA transfer direction! %d\n", direction);
> +		return NULL;
> +	}
> +
> +	/* allocate DMA descriptor */
> +	desc = ls1x_dma_alloc_desc(chan, sg_len);
> +	if (!desc)
> +		return NULL;
> +
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		dma_addr_t buf_addr = sg_dma_address(sg);
> +		size_t buf_len = sg_dma_len(sg);
> +		struct ls1x_dma_hwdesc *hwdesc = &desc->hwdesc[i];
> +		struct ls1x_dma_lli *lli;
> +
> +		if (!is_dma_copy_aligned(dchan->device, buf_addr, 0, buf_len)) {
> +			dev_err(chan2dev(dchan), "%s: buffer is not aligned!\n",
> +				__func__);
> +			goto err;
> +		}
> +
> +		/* allocate HW DMA descriptors */
> +		lli = dma_pool_alloc(chan->desc_pool, GFP_NOWAIT,
> +				     &hwdesc->phys);
> +		if (!lli) {
> +			dev_err(chan2dev(dchan),
> +				"%s: failed to alloc HW DMA descriptor!\n",
> +				__func__);
> +			goto err;
> +		}
> +		hwdesc->lli = lli;
> +
> +		/* config HW DMA descriptors */
> +		lli->saddr = buf_addr;
> +		lli->daddr = dev_addr;
> +		lli->length = buf_len / bus_width;
> +		lli->stride = 0;
> +		lli->cycles = 1;
> +		lli->cmd = cmd;
> +		lli->next = 0;
> +
> +		if (i)
> +			desc->hwdesc[i - 1].lli->next = hwdesc->phys;
> +
> +		dev_dbg(chan2dev(dchan),
> +			"hwdesc=%px, saddr=%08x, daddr=%08x, length=%u\n",
> +			hwdesc, buf_addr, dev_addr, buf_len);
> +	}
> +
> +	/* config DMA descriptor */
> +	desc->chan = chan;
> +	desc->dir = direction;
> +	desc->type = DMA_SLAVE;
> +	desc->nr_descs = sg_len;
> +	desc->nr_done = 0;
> +
> +	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
> +err:
> +	desc->nr_descs = i;
> +	ls1x_dma_free_desc(&desc->vdesc);
> +	return NULL;
> +}
> +
> +static int ls1x_dma_slave_config(struct dma_chan *dchan,
> +				 struct dma_slave_config *config)
> +{
> +	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
> +
> +	chan->cfg = *config;

You are using only addr and width, why keep full structure?
-- 
~Vinod
