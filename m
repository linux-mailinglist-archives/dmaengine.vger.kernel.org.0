Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F353B2D98
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jun 2021 13:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhFXLSz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Jun 2021 07:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232227AbhFXLSy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Jun 2021 07:18:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 152ED6124C;
        Thu, 24 Jun 2021 11:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624533395;
        bh=VqtZFxJX1DDdRqa4BEp8kCGGfSx/r0wT8Rgi7OK6hcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hJMsnPFCOUrGbUj2xasIlwRmJHWI795bv30AAUIUlauTvfSsb5sj5gSA1e8JsIUIs
         u/tQ8ZzaIzTCmlaOa+Xw36y/B4ERtUfT3z5uPyOnLa8CGtdlGB2HH8/TdZAMJfHovh
         hckyP3ou9SOLtF/CDsRNFHfR06eeOAjRbCYgfckhbIpz3Vhn4SGZOsKl/Utt8fpXR2
         iKHfRCdKv2mWFt2+dmc2uvg0tJPKlhozda9bv+xHdednQDjBfBg9EUSF0TKYatDVD8
         1jY0bLblceEh9ZdS/U1aknK+8C7eiOJRdWElFVnSzdC9VQg3vrVEDA5ZIFPk2pmMMf
         nOsMfsogusr1w==
Date:   Thu, 24 Jun 2021 16:46:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH v2 1/1] dmaengine: dw: Program xBAR hardware for Elkhart
 Lake
Message-ID: <YNRpkMMDE5B9NY9J@matsya>
References: <20210614133018.66931-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614133018.66931-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-06-21, 16:30, Andy Shevchenko wrote:
> Intel Elkhart Lake PSE DMA implementation is integrated with crossbar IP
> in order to serve more hardware than there are DMA request lines available.
> 
> Due to this, program xBAR hardware to make flexible support of PSE peripheral.
> 
> The Device-to-Device has not been tested and it's not supported by DMA Engine,
> but it's left in the code for the sake of documenting hardware features.

Kernel does not like to keep dead code, please remove this. It can be
added back when we have users

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: updated year, added explanation about D2D code, renamed func (Vinod)
>  drivers/dma/dw/idma32.c              | 149 ++++++++++++++++++++++++++-
>  drivers/dma/dw/internal.h            |  16 +++
>  drivers/dma/dw/pci.c                 |   6 +-
>  drivers/dma/dw/platform.c            |   6 +-
>  include/linux/platform_data/dma-dw.h |   3 +
>  5 files changed, 171 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/dw/idma32.c b/drivers/dma/dw/idma32.c
> index 3ce44de25d33..22af77a3276d 100644
> --- a/drivers/dma/dw/idma32.c
> +++ b/drivers/dma/dw/idma32.c
> @@ -1,15 +1,155 @@
>  // SPDX-License-Identifier: GPL-2.0
> -// Copyright (C) 2013,2018 Intel Corporation
> +// Copyright (C) 2013,2018,2020-2021 Intel Corporation
>  
>  #include <linux/bitops.h>
>  #include <linux/dmaengine.h>
>  #include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  
>  #include "internal.h"
>  
> -static void idma32_initialize_chan(struct dw_dma_chan *dwc)
> +#define DMA_CTL_CH(x)			(0x1000 + (x) * 4)
> +#define DMA_SRC_ADDR_FILLIN(x)		(0x1100 + (x) * 4)
> +#define DMA_DST_ADDR_FILLIN(x)		(0x1200 + (x) * 4)
> +#define DMA_XBAR_SEL(x)			(0x1300 + (x) * 4)
> +#define DMA_REGACCESS_CHID_CFG		(0x1400)
> +
> +#define CTL_CH_TRANSFER_MODE_MASK	GENMASK(1, 0)
> +#define CTL_CH_TRANSFER_MODE_S2S	0
> +#define CTL_CH_TRANSFER_MODE_S2D	1
> +#define CTL_CH_TRANSFER_MODE_D2S	2
> +#define CTL_CH_TRANSFER_MODE_D2D	3
> +#define CTL_CH_RD_RS_MASK		GENMASK(4, 3)
> +#define CTL_CH_WR_RS_MASK		GENMASK(6, 5)
> +#define CTL_CH_RD_NON_SNOOP_BIT		BIT(8)
> +#define CTL_CH_WR_NON_SNOOP_BIT		BIT(9)
> +
> +#define XBAR_SEL_DEVID_MASK		GENMASK(15, 0)
> +#define XBAR_SEL_RX_TX_BIT		BIT(16)
> +#define XBAR_SEL_RX_TX_SHIFT		16
> +
> +#define REGACCESS_CHID_MASK		GENMASK(2, 0)
> +
> +static unsigned int idma32_get_slave_devfn(struct dw_dma_chan *dwc)
> +{
> +	struct device *slave = dwc->chan.slave;
> +
> +	if (!slave || !dev_is_pci(slave))
> +		return 0;
> +
> +	return to_pci_dev(slave)->devfn;
> +}
> +
> +static void idma32_initialize_chan_xbar(struct dw_dma_chan *dwc)
> +{
> +	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
> +	void __iomem *misc = __dw_regs(dw);
> +	u32 cfghi = 0, cfglo = 0;
> +	u8 dst_id, src_id;
> +	u32 value;
> +
> +	/* DMA Channel ID Configuration register must be programmed first */
> +	value = readl(misc + DMA_REGACCESS_CHID_CFG);
> +
> +	value &= ~REGACCESS_CHID_MASK;
> +	value |= dwc->chan.chan_id;
> +
> +	writel(value, misc + DMA_REGACCESS_CHID_CFG);
> +
> +	/* Configure channel attributes */
> +	value = readl(misc + DMA_CTL_CH(dwc->chan.chan_id));
> +
> +	value &= ~(CTL_CH_RD_NON_SNOOP_BIT | CTL_CH_WR_NON_SNOOP_BIT);
> +	value &= ~(CTL_CH_RD_RS_MASK | CTL_CH_WR_RS_MASK);
> +	value &= ~CTL_CH_TRANSFER_MODE_MASK;
> +
> +	switch (dwc->direction) {
> +	case DMA_MEM_TO_MEM:
> +		value |= CTL_CH_TRANSFER_MODE_D2D;
> +		break;
> +	case DMA_MEM_TO_DEV:
> +		value |= CTL_CH_TRANSFER_MODE_D2S;
> +		value |= CTL_CH_WR_NON_SNOOP_BIT;
> +		break;
> +	case DMA_DEV_TO_MEM:
> +		value |= CTL_CH_TRANSFER_MODE_S2D;
> +		value |= CTL_CH_RD_NON_SNOOP_BIT;
> +		break;
> +	case DMA_DEV_TO_DEV:
> +		value |= CTL_CH_WR_NON_SNOOP_BIT | CTL_CH_RD_NON_SNOOP_BIT;
> +		value |= CTL_CH_TRANSFER_MODE_S2S;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	writel(value, misc + DMA_CTL_CH(dwc->chan.chan_id));
> +
> +	/* Configure crossbar selection */
> +	value = readl(misc + DMA_XBAR_SEL(dwc->chan.chan_id));
> +
> +	/* DEVFN selection */
> +	value &= ~XBAR_SEL_DEVID_MASK;
> +	value |= idma32_get_slave_devfn(dwc);
> +
> +	switch (dwc->direction) {
> +	case DMA_MEM_TO_MEM:
> +		break;
> +	case DMA_MEM_TO_DEV:
> +		value |= XBAR_SEL_RX_TX_BIT;
> +		break;
> +	case DMA_DEV_TO_MEM:
> +		value &= ~XBAR_SEL_RX_TX_BIT;
> +		break;
> +	case DMA_DEV_TO_DEV:
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	writel(value, misc + DMA_XBAR_SEL(dwc->chan.chan_id));
> +
> +	/* Configure DMA channel low and high registers */
> +	switch (dwc->direction) {
> +	case DMA_MEM_TO_MEM:
> +		dst_id = dwc->chan.chan_id;
> +		src_id = dwc->chan.chan_id;
> +		break;
> +	case DMA_MEM_TO_DEV:
> +		dst_id = dwc->chan.chan_id;
> +		src_id = dwc->dws.src_id;
> +		break;
> +	case DMA_DEV_TO_MEM:
> +		dst_id = dwc->dws.dst_id;
> +		src_id = dwc->chan.chan_id;
> +		break;
> +	case DMA_DEV_TO_DEV:
> +		dst_id = dwc->dws.src_id;
> +		src_id = dwc->dws.dst_id;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	/* Set default burst alignment */
> +	cfglo |= IDMA32C_CFGL_DST_BURST_ALIGN | IDMA32C_CFGL_SRC_BURST_ALIGN;
> +
> +	/* Low 4 bits of the request lines */
> +	cfghi |= IDMA32C_CFGH_DST_PER(dst_id & 0xf);
> +	cfghi |= IDMA32C_CFGH_SRC_PER(src_id & 0xf);
> +
> +	/* Request line extension (2 bits) */
> +	cfghi |= IDMA32C_CFGH_DST_PER_EXT(dst_id >> 4 & 0x3);
> +	cfghi |= IDMA32C_CFGH_SRC_PER_EXT(src_id >> 4 & 0x3);
> +
> +	channel_writel(dwc, CFG_LO, cfglo);
> +	channel_writel(dwc, CFG_HI, cfghi);
> +}
> +
> +static void idma32_initialize_chan_generic(struct dw_dma_chan *dwc)
>  {
>  	u32 cfghi = 0;
>  	u32 cfglo = 0;
> @@ -134,7 +274,10 @@ int idma32_dma_probe(struct dw_dma_chip *chip)
>  		return -ENOMEM;
>  
>  	/* Channel operations */
> -	dw->initialize_chan = idma32_initialize_chan;
> +	if (chip->pdata->quirks & DW_DMA_QUIRK_XBAR_PRESENT)
> +		dw->initialize_chan = idma32_initialize_chan_xbar;
> +	else
> +		dw->initialize_chan = idma32_initialize_chan_generic;
>  	dw->suspend_chan = idma32_suspend_chan;
>  	dw->resume_chan = idma32_resume_chan;
>  	dw->prepare_ctllo = idma32_prepare_ctllo;
> diff --git a/drivers/dma/dw/internal.h b/drivers/dma/dw/internal.h
> index 2e1c52eefdeb..563ce73488db 100644
> --- a/drivers/dma/dw/internal.h
> +++ b/drivers/dma/dw/internal.h
> @@ -74,4 +74,20 @@ static __maybe_unused const struct dw_dma_chip_pdata idma32_chip_pdata = {
>  	.remove = idma32_dma_remove,
>  };
>  
> +static const struct dw_dma_platform_data xbar_pdata = {
> +	.nr_channels = 8,
> +	.chan_allocation_order = CHAN_ALLOCATION_ASCENDING,
> +	.chan_priority = CHAN_PRIORITY_ASCENDING,
> +	.block_size = 131071,
> +	.nr_masters = 1,
> +	.data_width = {4},
> +	.quirks = DW_DMA_QUIRK_XBAR_PRESENT,
> +};
> +
> +static __maybe_unused const struct dw_dma_chip_pdata xbar_chip_pdata = {
> +	.pdata = &xbar_pdata,
> +	.probe = idma32_dma_probe,
> +	.remove = idma32_dma_remove,
> +};
> +
>  #endif /* _DMA_DW_INTERNAL_H */
> diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
> index 1142aa6f8c4a..26a3f926da02 100644
> --- a/drivers/dma/dw/pci.c
> +++ b/drivers/dma/dw/pci.c
> @@ -120,9 +120,9 @@ static const struct pci_device_id dw_pci_id_table[] = {
>  	{ PCI_VDEVICE(INTEL, 0x22c0), (kernel_ulong_t)&dw_dma_chip_pdata },
>  
>  	/* Elkhart Lake iDMA 32-bit (PSE DMA) */
> -	{ PCI_VDEVICE(INTEL, 0x4bb4), (kernel_ulong_t)&idma32_chip_pdata },
> -	{ PCI_VDEVICE(INTEL, 0x4bb5), (kernel_ulong_t)&idma32_chip_pdata },
> -	{ PCI_VDEVICE(INTEL, 0x4bb6), (kernel_ulong_t)&idma32_chip_pdata },
> +	{ PCI_VDEVICE(INTEL, 0x4bb4), (kernel_ulong_t)&xbar_chip_pdata },
> +	{ PCI_VDEVICE(INTEL, 0x4bb5), (kernel_ulong_t)&xbar_chip_pdata },
> +	{ PCI_VDEVICE(INTEL, 0x4bb6), (kernel_ulong_t)&xbar_chip_pdata },
>  
>  	/* Haswell */
>  	{ PCI_VDEVICE(INTEL, 0x9c60), (kernel_ulong_t)&dw_dma_chip_pdata },
> diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
> index 0585d749d935..246118955877 100644
> --- a/drivers/dma/dw/platform.c
> +++ b/drivers/dma/dw/platform.c
> @@ -149,9 +149,9 @@ static const struct acpi_device_id dw_dma_acpi_id_table[] = {
>  	{ "808622C0", (kernel_ulong_t)&dw_dma_chip_pdata },
>  
>  	/* Elkhart Lake iDMA 32-bit (PSE DMA) */
> -	{ "80864BB4", (kernel_ulong_t)&idma32_chip_pdata },
> -	{ "80864BB5", (kernel_ulong_t)&idma32_chip_pdata },
> -	{ "80864BB6", (kernel_ulong_t)&idma32_chip_pdata },
> +	{ "80864BB4", (kernel_ulong_t)&xbar_chip_pdata },
> +	{ "80864BB5", (kernel_ulong_t)&xbar_chip_pdata },
> +	{ "80864BB6", (kernel_ulong_t)&xbar_chip_pdata },
>  
>  	{ }
>  };
> diff --git a/include/linux/platform_data/dma-dw.h b/include/linux/platform_data/dma-dw.h
> index b34a094b2258..b11b0c8bc5da 100644
> --- a/include/linux/platform_data/dma-dw.h
> +++ b/include/linux/platform_data/dma-dw.h
> @@ -52,6 +52,7 @@ struct dw_dma_slave {
>   * @max_burst: Maximum value of burst transaction size supported by hardware
>   *	       per channel (in units of CTL.SRC_TR_WIDTH/CTL.DST_TR_WIDTH).
>   * @protctl: Protection control signals setting per channel.
> + * @quirks: Optional platform quirks.
>   */
>  struct dw_dma_platform_data {
>  	unsigned int	nr_channels;
> @@ -71,6 +72,8 @@ struct dw_dma_platform_data {
>  #define CHAN_PROTCTL_CACHEABLE		BIT(2)
>  #define CHAN_PROTCTL_MASK		GENMASK(2, 0)
>  	unsigned char	protctl;
> +#define DW_DMA_QUIRK_XBAR_PRESENT	BIT(0)
> +	unsigned int	quirks;
>  };
>  
>  #endif /* _PLATFORM_DATA_DMA_DW_H */
> -- 
> 2.30.2

-- 
~Vinod
