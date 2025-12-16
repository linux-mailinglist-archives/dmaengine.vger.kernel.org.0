Return-Path: <dmaengine+bounces-7651-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F36CC1D58
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 10:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F2DE300E168
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 09:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13442798ED;
	Tue, 16 Dec 2025 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQcv19sC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C14D219A8E
	for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765877701; cv=none; b=qnEcBWyq9FcE85bleTu7Sz4dR7tBPmdWhikSlmnzvFmJPaxbQwd5eL9O56HmSr4wrDm5rLfPUz6ys6UG6Rp/0qf8BNRc9klOZfJh125zm2a+PszL99qZS9CVP76O03wGtt8OKdMUFNqJ1NwJr01iqq0hkHcDDedBmIJlnHz617M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765877701; c=relaxed/simple;
	bh=B3Kv5eY+YhzZvcpg2r/PRdd6dUGEFTSvTGWtqheuB0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ypvf4g4puCjivLDL3J6Mi/cgSlkbByOfKWI6901fXZLQao+s5QuqKm056BK9p0+940QM71CafdFd6uhW23WPc7CmINkuvZiHpqZOXBY8JzghKd97lUGI76UTdJhHwOMGnXvvcpbpzsIn2Zw3FCeXI9ZDe75kfXOyn/p1NKTCzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQcv19sC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC64C4CEF1;
	Tue, 16 Dec 2025 09:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765877701;
	bh=B3Kv5eY+YhzZvcpg2r/PRdd6dUGEFTSvTGWtqheuB0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQcv19sCOTnYwDi6vhCuTGmo5Lmr0F+McBdi0qL+UQm2jdI2xNbxRGPtTz9PdLfHh
	 Ye1yRicT90/1rjUjmDJReHDdivLGLbnsROjopWtHKJbDYYRJyV743tg2zWFUw3GSt8
	 N71LBuyZdfMhaZLSR227ca7oN9uiuH7jHMdWuBPkF9R+wwQWdf9BxQmt5T0U03x70F
	 iyuk7MFqtf8zxAvu2ZuTxyO3+hgT9mEvz7YhyKvmUNObZFa7jPudQ2oucOBHFA9bm4
	 D5VcYe2QSuclsCL+yT9lZhNCS+TOBMqZ+eJaPGlvLH+x2bUAh33+5G166o3VHUCTBj
	 D5gFtH8Lhdpng==
Date: Tue, 16 Dec 2025 15:04:57 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 1/3] dmaengine: switchtec-dma: Introduce Switchtec
 DMA engine skeleton
Message-ID: <aUEnwQZQ383GgXMM@vaman>
References: <20251215181649.2605-1-logang@deltatee.com>
 <20251215181649.2605-2-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215181649.2605-2-logang@deltatee.com>

Hi,

This looks mostly good to me, we should get this in soon. Sorry for
delay in reviews

On 15-12-25, 11:16, Logan Gunthorpe wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
> 
> Some Switchtec Switches can expose DMA engines via extra PCI functions
> on the upstream ports. At most one such function can be supported on
> each upstream port. Each function can have one or more DMA channels.
> 
> This patch is just the core PCI driver skeleton and dma
> engine registration.
> 
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Co-developed-by: George Ge <george.ge@microchip.com>
> Signed-off-by: George Ge <george.ge@microchip.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  MAINTAINERS                 |   7 ++
>  drivers/dma/Kconfig         |   9 ++
>  drivers/dma/Makefile        |   1 +
>  drivers/dma/switchtec_dma.c | 218 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 235 insertions(+)
>  create mode 100644 drivers/dma/switchtec_dma.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b11839cba9d..8653502ae275 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25209,6 +25209,13 @@ S:	Supported
>  F:	include/net/switchdev.h
>  F:	net/switchdev/
>  
> +SWITCHTEC DMA DRIVER
> +M:	Kelvin Cao <kelvin.cao@microchip.com>
> +M:	Logan Gunthorpe <logang@deltatee.com>
> +L:	dmaengine@vger.kernel.org
> +S:	Maintained
> +F:	drivers/dma/switchtec_dma.c
> +
>  SY8106A REGULATOR DRIVER
>  M:	Icenowy Zheng <icenowy@aosc.io>
>  S:	Maintained
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 8bb0a119ecd4..85296c5cead9 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -610,6 +610,15 @@ config SPRD_DMA
>  	help
>  	  Enable support for the on-chip DMA controller on Spreadtrum platform.
>  
> +config SWITCHTEC_DMA
> +	tristate "Switchtec PSX/PFX Switch DMA Engine Support"
> +	depends on PCI
> +	select DMA_ENGINE
> +	help
> +	  Some Switchtec PSX/PFX PCIe Switches support additional DMA engines.
> +	  These are exposed via an extra function on the switch's upstream
> +	  port.
> +
>  config TXX9_DMAC
>  	tristate "Toshiba TXx9 SoC DMA support"
>  	depends on MACH_TX49XX
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index a54d7688392b..df566c4958b6 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -74,6 +74,7 @@ obj-$(CONFIG_SF_PDMA) += sf-pdma/
>  obj-$(CONFIG_SOPHGO_CV1800B_DMAMUX) += cv1800b-dmamux.o
>  obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
>  obj-$(CONFIG_SPRD_DMA) += sprd-dma.o
> +obj-$(CONFIG_SWITCHTEC_DMA) += switchtec_dma.o
>  obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
>  obj-$(CONFIG_TEGRA186_GPC_DMA) += tegra186-gpc-dma.o
>  obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> new file mode 100644
> index 000000000000..f3c366936684
> --- /dev/null
> +++ b/drivers/dma/switchtec_dma.c
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Microchip Switchtec(tm) DMA Controller Driver
> + * Copyright (c) 2025, Kelvin Cao <kelvin.cao@microchip.com>
> + * Copyright (c) 2025, Microchip Corporation
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/circ_buf.h>
> +#include <linux/dmaengine.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +
> +#include "dmaengine.h"
> +
> +MODULE_DESCRIPTION("Switchtec PCIe Switch DMA Engine");
> +MODULE_VERSION("0.1");

How are you planning to use this..

> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Kelvin Cao");
> +
> +struct switchtec_dma_dev {
> +	struct dma_device dma_dev;
> +	struct pci_dev __rcu *pdev;
> +	void __iomem *bar;
> +};
> +
> +static void switchtec_dma_release(struct dma_device *dma_dev)
> +{
> +	struct switchtec_dma_dev *swdma_dev =
> +		container_of(dma_dev, struct switchtec_dma_dev, dma_dev);
> +
> +	put_device(dma_dev->dev);
> +	kfree(swdma_dev);
> +}
> +
> +static int switchtec_dma_create(struct pci_dev *pdev)
> +{
> +	struct switchtec_dma_dev *swdma_dev;
> +	struct dma_device *dma;
> +	struct dma_chan *chan;
> +	int nr_vecs, rc;
> +
> +	/*
> +	 * Create the switchtec dma device
> +	 */
> +	swdma_dev = kzalloc(sizeof(*swdma_dev), GFP_KERNEL);
> +	if (!swdma_dev)
> +		return -ENOMEM;
> +
> +	swdma_dev->bar = ioremap(pci_resource_start(pdev, 0),
> +				 pci_resource_len(pdev, 0));
> +
> +	pci_info(pdev, "Switchtec PSX/PFX DMA EP\n");

I see bunch of info messages, they are really noise as far as upstream
is considered. Pls consider dropping them
See https://elixir.bootlin.com/linux/v6.18.1/source/Documentation/process/debugging/driver_development_debugging_guide.rst#L79

-- 
~Vinod

