Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762213A9753
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 12:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhFPKdM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 06:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232030AbhFPKdL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 06:33:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7210C61245;
        Wed, 16 Jun 2021 10:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623839465;
        bh=kbRtLUdWaOWuC+aonTy88qSE/5UTRrrJ//3tQJQaeHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQQkni44Pz2Xzx7UXwLDLr9BeEhWuB2ch5AiNSFGj7KOPyy4V0zo26RxLbd31iKJ2
         Yr3mBzNnspnWYKydCAdDEWIwgF8d9lXENdbgDFQ1V84m3p0+z6ov6gp9GUgc/tq1w+
         99MxrGa+QZp3MMIIqynyylyJs5ueoetr8x3GU5TPYQNTohH92ajGPdJGfDiwQ5QrD9
         suY/nQYlgmeVH3xotVWaKKGkHPmMMPx6LABJACKet5Wlmws6WxWdu2+ButTswZQCBO
         bRt23hBMyIa+3j9Ticj6etTqGZEyCIwpdYQFzLV4VaOgQV8+71x0TblnIOWwokF90O
         +Mf6r9NbT2nIA==
Date:   Wed, 16 Jun 2021 16:01:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 3/5] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Message-ID: <YMnS5AdR8PL0hKuC@vkoul-mobl>
References: <20210611113642.18457-1-biju.das.jz@bp.renesas.com>
 <20210611113642.18457-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611113642.18457-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-06-21, 12:36, Biju Das wrote:
> Add DMA Controller driver for RZ/G2L SoC.
> 
> Based on the work done by Chris Brandt for RZ/A DMA driver.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/dma/sh/Kconfig   |    8 +
>  drivers/dma/sh/Makefile  |    1 +
>  drivers/dma/sh/rz-dmac.c | 1050 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1059 insertions(+)
>  create mode 100644 drivers/dma/sh/rz-dmac.c
> 
> diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
> index 13437323a85b..280a6d359e36 100644
> --- a/drivers/dma/sh/Kconfig
> +++ b/drivers/dma/sh/Kconfig
> @@ -47,3 +47,11 @@ config RENESAS_USB_DMAC
>  	help
>  	  This driver supports the USB-DMA controller found in the Renesas
>  	  SoCs.
> +
> +config RZ_DMAC
> +	tristate "Renesas RZ/G2L Controller"
> +	depends on ARCH_R9A07G044 || COMPILE_TEST
> +	select RENESAS_DMA
> +	help
> +	  This driver supports the general purpose DMA controller found in the
> +	  Renesas RZ/G2L SoC variants.
> diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
> index 112fbd22bb3f..9b2927f543bf 100644
> --- a/drivers/dma/sh/Makefile
> +++ b/drivers/dma/sh/Makefile
> @@ -15,3 +15,4 @@ obj-$(CONFIG_SH_DMAE) += shdma.o
>  
>  obj-$(CONFIG_RCAR_DMAC) += rcar-dmac.o
>  obj-$(CONFIG_RENESAS_USB_DMAC) += usb-dmac.o
> +obj-$(CONFIG_RZ_DMAC) += rz-dmac.o
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> new file mode 100644
> index 000000000000..87a902ba3cfa
> --- /dev/null
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -0,0 +1,1050 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L Controller Driver
> + *
> + * Based on imx-dma.c
> + *
> + * Copyright (C) 2021 Renesas Electronics Corp.
> + * Copyright 2010 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
> + * Copyright 2012 Javier Martin, Vista Silicon <javier.martin@vista-silicon.com>
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#include "../dmaengine.h"
> +
> +struct rz_dmac_slave_config {
> +	u32 mid_rid;
> +	dma_addr_t addr;
> +	u32 chcfg;
> +};

why not use dma_slave_config()

> +
> +enum  rz_dmac_prep_type {
> +	RZ_DMAC_DESC_MEMCPY,
> +	RZ_DMAC_DESC_SLAVE_SG,
> +};
> +
> +struct rz_lmdesc {
> +	u32 header;
> +	u32 sa;
> +	u32 da;
> +	u32 tb;
> +	u32 chcfg;
> +	u32 chitvl;
> +	u32 chext;
> +	u32 nxla;
> +};
> +
> +struct rz_dmac_desc {
> +	struct list_head node;

what is this list node for?

> +	struct dma_async_tx_descriptor desc;
> +	enum dma_status status;
> +	dma_addr_t src;
> +	dma_addr_t dest;
> +	size_t len;
> +	enum dma_transfer_direction direction;
> +	enum rz_dmac_prep_type type;
> +	/* For memcpy */
> +	unsigned int config_port;
> +	unsigned int config_mem;
> +	/* For slave sg */
> +	struct scatterlist *sg;
> +	unsigned int sgcount;
> +};

why not use virt_dma_desc ?

> +
> +struct rz_dmac_channel {
> +	struct rz_dmac_engine *rzdma;
> +	unsigned int index;
> +	int irq;
> +
> +	spinlock_t lock;
> +	struct list_head ld_free;
> +	struct list_head ld_queue;
> +	struct list_head ld_active;

why not use virt_dma_chan() ?

> +
> +	int descs_allocated;
> +	enum dma_slave_buswidth word_size;
> +	dma_addr_t per_address;
> +	struct dma_chan chan;
> +	struct dma_async_tx_descriptor desc;
> +	enum dma_status status;

Both desc and chan need status?

> +	const struct rz_dmac_slave_config *slave;
> +	void __iomem *ch_base;
> +	void __iomem *ch_cmn_base;
> +
> +	struct {
> +		struct rz_lmdesc *base;
> +		struct rz_lmdesc *head;
> +		struct rz_lmdesc *tail;
> +		int valid;
> +		dma_addr_t base_dma;
> +	} lmdesc;
> +
> +	u32 chcfg;
> +	u32 chctrl;
> +
> +	struct {
> +		int issue;
> +		int prep_slave_sg;
> +	} stat;
> +};

I have glanced at the rest of the driver, looks mostly okay but please
move this to use virt_dma_chan and virt_dma_desc that would ease a lot
of code from driver

Thanks
-- 
~Vinod
