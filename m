Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51E68105F6E
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2019 06:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKVFSs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Nov 2019 00:18:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfKVFSs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 22 Nov 2019 00:18:48 -0500
Received: from localhost (unknown [171.61.94.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31A702068E;
        Fri, 22 Nov 2019 05:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574399927;
        bh=p3/OMDSIlesQqDnNrRHF5zmd6dHTJYMBxcxtdLJUIbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ULeCQFIPKC/62ThBrNWcQ4AJx1DsoOIDqlWC8HFPAzacWa8Qr+Fc7nw7InT6VtdbJ
         Dt/5Ihuc6nvLsuIb4szwjx06qzxHqjB2qvNZdYeN6BzbrmGCbPserNnlVa4O6IvsUQ
         zz/1/DQktkbaJv0pyBx1lNyyBiO86V69SPVVakNw=
Date:   Fri, 22 Nov 2019 10:48:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexander Gordeev <a.gordeev.box@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v5 1/2] dmaengine: avalon-dma: Intel Avalon-MM DMA
 Interface for PCIe
Message-ID: <20191122051842.GN82508@vkoul-mobl>
References: <cover.1573052725.git.a.gordeev.box@gmail.com>
 <fa36d91e16ab127206db0de3f9ab1ec9ceeaf002.1573052725.git.a.gordeev.box@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa36d91e16ab127206db0de3f9ab1ec9ceeaf002.1573052725.git.a.gordeev.box@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-11-19, 20:22, Alexander Gordeev wrote:

> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 7af874b69ffb..f6f43480a4a4 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -669,6 +669,8 @@ source "drivers/dma/sh/Kconfig"
>  
>  source "drivers/dma/ti/Kconfig"
>  
> +source "drivers/dma/avalon/Kconfig"

Sort this alphabetically please

> +
>  # clients
>  comment "DMA Clients"
>  	depends on DMA_ENGINE
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index f5ce8665e944..fd7e11417b73 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_UNIPHIER_MDMAC) += uniphier-mdmac.o
>  obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
>  obj-$(CONFIG_ZX_DMA) += zx_dma.o
>  obj-$(CONFIG_ST_FDMA) += st_fdma.o
> +obj-$(CONFIG_AVALON_DMA) += avalon/

This one as well

> +config AVALON_DMA
> +	tristate "Intel Avalon-MM DMA Interface for PCIe"
> +	depends on PCI
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  This selects a driver for Avalon-MM DMA Interface for PCIe
> +	  hard IP block used in Intel Arria, Cyclone or Stratix FPGAs.

If it is just a single kconfig block, why not move it into dmaengine
Kconfig?

> +static unsigned int dma_mask_width = 64;
> +module_param(dma_mask_width, uint, 0644);
> +MODULE_PARM_DESC(dma_mask_width, "Avalon DMA bitmask width (default: 64)");
> +
> +unsigned long ctrl_base;
> +module_param(ctrl_base, ulong, 0644);
> +MODULE_PARM_DESC(ctrl_base, "Avalon DMA controller base (default: 0)");
> +
> +static unsigned int rd_ep_dst_lo = 0x80000000;
> +module_param(rd_ep_dst_lo, uint, 0644);
> +MODULE_PARM_DESC(rd_ep_dst_lo,
> +		 "Read status and desc table low (default: 0x80000000)");
> +
> +static unsigned int rd_ep_dst_hi = 0;
> +module_param(rd_ep_dst_hi, uint, 0644);
> +MODULE_PARM_DESC(rd_ep_dst_hi,
> +		 "Read status and desc table hi (default: 0)");
> +
> +static unsigned int wr_ep_dst_lo = 0x80002000;
> +module_param(wr_ep_dst_lo, uint, 0644);
> +MODULE_PARM_DESC(wr_ep_dst_lo,
> +		 "Write status and desc table low (default: 0x80002000)");
> +
> +static unsigned int wr_ep_dst_hi = 0;
> +module_param(wr_ep_dst_hi, uint, 0644);
> +MODULE_PARM_DESC(wr_ep_dst_hi,
> +		 "Write status and desc table hi (default: 0)");

these are resources, do you not have any other way, DT/ACPI/something
else to find these!

> +static void avalon_dma_term(struct avalon_dma *adma)
> +{
> +	struct avalon_dma_chan *chan = &adma->chan;
> +	struct avalon_dma_hw *hw = &chan->hw;
> +	struct device *dev = adma->dev;
> +
> +	free_irq(adma->irq, adma);

please also kill the vchan tasklet

> +static int avalon_dma_device_config(struct dma_chan *dma_chan,
> +				    struct dma_slave_config *config)
> +{
> +	struct avalon_dma_chan *chan = to_avalon_dma_chan(dma_chan);
> +
> +	if (!IS_ALIGNED(config->src_addr, sizeof(u32)) ||
> +	    !IS_ALIGNED(config->dst_addr, sizeof(u32)))
> +		return -EINVAL;
> +
> +	chan->src_addr = config->src_addr;
> +	chan->dst_addr = config->dst_addr;

hmmm you dont care about widths and burst sizes?

> +static struct dma_async_tx_descriptor *
> +avalon_dma_prep_slave_sg(struct dma_chan *dma_chan,
> +			 struct scatterlist *sg, unsigned int sg_len,
> +			 enum dma_transfer_direction direction,
> +			 unsigned long flags, void *context)
> +{
> +	struct avalon_dma_chan *chan = to_avalon_dma_chan(dma_chan);
> +	struct avalon_dma_desc *desc;
> +	dma_addr_t dev_addr;
> +	int i;
> +
> +	if (direction == DMA_MEM_TO_DEV)
> +		dev_addr = chan->dst_addr;
> +	else if (direction == DMA_DEV_TO_MEM)
> +		dev_addr = chan->src_addr;

the dst_addr/src_addr is initialized to -1 so dont you want to check you
have a valid address?

> +	else
> +		return NULL;
> +
> +	desc = kzalloc(struct_size(desc, seg, sg_len), GFP_NOWAIT);
> +	if (!desc)
> +		return NULL;
> +
> +	desc->direction = direction;
> +	desc->dev_addr	= dev_addr;
> +	desc->seg_curr	= 0;
> +	desc->seg_off	= 0;
> +	desc->nr_segs	= sg_len;
> +
> +	for (i = 0; i < sg_len; i++) {
> +		struct dma_segment *seg = &desc->seg[i];
> +		dma_addr_t dma_addr = sg_dma_address(sg);
> +		unsigned int dma_len = sg_dma_len(sg);
> +
> +		if (!IS_ALIGNED(dma_addr, sizeof(u32)) ||
> +		    !IS_ALIGNED(dma_len, sizeof(u32)))

you are leaking desc here

> +struct avalon_dma *avalon_dma_register(struct device *dev,
> +				       void __iomem *regs,
> +				       unsigned int irq)
> +{
> +	struct avalon_dma *adma;
> +	struct avalon_dma_chan *chan;
> +	struct dma_device *dma_dev;
> +	int ret;
> +
> +	adma = kzalloc(sizeof(*adma), GFP_KERNEL);
> +	if (!adma)
> +		return ERR_PTR(-ENOMEM);

any reason for not using device managed API for this?

> +static unsigned int pci_bar = 0;
> +module_param(pci_bar, uint, 0644);
> +MODULE_PARM_DESC(pci_bar,
> +		 "PCI BAR number the controller is mapped to (default: 0)");
> +
> +static unsigned int pci_msi_vector = 0;
> +module_param(pci_msi_vector, uint, 0644);
> +MODULE_PARM_DESC(pci_msi_vector,
> +		 "MSI vector number used for the controller (default: 0)");
> +
> +static unsigned int pci_msi_count_order = 5;
> +module_param(pci_msi_count_order, uint, 0644);
> +MODULE_PARM_DESC(pci_msi_count_order,
> +		 "Number of MSI vectors (order) device uses (default: 5)");

and still not convinced these should be module params
-- 
~Vinod
