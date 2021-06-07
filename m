Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8715539DB6D
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jun 2021 13:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhFGLgw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Jun 2021 07:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbhFGLgv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Jun 2021 07:36:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0ABF5610C7;
        Mon,  7 Jun 2021 11:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623065700;
        bh=v0YJkBcz+6wfgXabI+7TF72vY2yLxw672rc/FUtSO5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPgbGmqf+oGa6/ijvcX0YbECLH3xQ6+fkn3gJEjG1h+mcGRVlaaUfDvr8scLldozp
         p1gkiCfIap8DrG31wbs97znYWf2nu7TT6b8KFTHYMXCwVuMU+K8uQQeUjTvzNI6VWm
         6ZNBnk0Wl9UYIZpqBzqncM9magLVWccGGqWefcHmYSqBnac7bCZ6bdDpNIq/BnNBvZ
         vB3G+WsxQEYcnxz/EBz6BlwT6ogG5T1RMt2+S8REfAn12w6ZoBBe7KXbhwQWKtl8Zo
         u5CsgbaTRhaDqx6H/xAbFZjY6f0JS44Meml23n7F3Sjl4YfW1p5aPf+jdV8yTfJC48
         p1fKMaNt5yIDw==
Date:   Mon, 7 Jun 2021 17:04:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH v1 1/1] dmaengine: dw: Program xBAR hardware for Elkhart
 Lake
Message-ID: <YL4EYb35GOVYxdQO@vkoul-mobl>
References: <20210602085604.21933-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602085604.21933-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-06-21, 11:56, Andy Shevchenko wrote:
> Intel Elkhart Lake PSE DMA implementation is integrated with crossbar IP
> in order to serve more hardware than there are DMA request lines available.
> 
> Due to this, program xBAR hardware to make flexible support of PSE peripheral.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dw/idma32.c              | 146 ++++++++++++++++++++++++++-
>  drivers/dma/dw/internal.h            |  16 +++
>  drivers/dma/dw/pci.c                 |   6 +-
>  drivers/dma/dw/platform.c            |   6 +-
>  include/linux/platform_data/dma-dw.h |   3 +
>  5 files changed, 168 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/dw/idma32.c b/drivers/dma/dw/idma32.c
> index 3ce44de25d33..5232fcb1a736 100644
> --- a/drivers/dma/dw/idma32.c
> +++ b/drivers/dma/dw/idma32.c
> @@ -1,15 +1,152 @@
>  // SPDX-License-Identifier: GPL-2.0
> -// Copyright (C) 2013,2018 Intel Corporation
> +// Copyright (C) 2013,2018,2020 Intel Corporation

2021..?

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
> +static unsigned int idma32_get_slave_devid(struct dw_dma_chan *dwc)
> +{
> +	struct device *slave = dwc->chan.slave;
> +
> +	if (!slave || !dev_is_pci(slave))
> +		return 0;
> +
> +	return to_pci_dev(slave)->devfn;

so this return devfn.. maybe rename function to get_slave_devfn() ?

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
> +	default:
> +		value |= CTL_CH_WR_NON_SNOOP_BIT | CTL_CH_RD_NON_SNOOP_BIT;
> +		value |= CTL_CH_TRANSFER_MODE_S2S;
> +		break;

aha, how did you test this...

-- 
~Vinod
