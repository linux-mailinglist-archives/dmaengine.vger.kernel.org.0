Return-Path: <dmaengine+bounces-9067-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEZmFJ/ZnmkTXgQAu9opvQ
	(envelope-from <dmaengine+bounces-9067-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:14:39 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AC41964FC
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBE543002F54
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CCC32A3D1;
	Wed, 25 Feb 2026 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g14DAovX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396D2C027F
	for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018073; cv=none; b=dkWdCpuykMH3o0kOMef+77iw3KCapjSXzv2pxkkoeqGCAZ/2Ki5oA46UVL+sSbEBuoT0aKJeCY/QB5VcGSn3JL8drwA4x3+JNL4ePLfuBjrYKSrYYV+hSlMQ1QI0g5jV1XzH4ChJtFFbwFMidcuoQNQFQiAmCC12BlP963YJ4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018073; c=relaxed/simple;
	bh=T6eXVrd1j38V9J/IxrTJIs08c+jiSkVaYxdkRGrVDPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz8JYVCJrdaDKPVHRfVNLH+xLjDbWOIFtn0Zwnnpd6IBU0pPazBwQfwgT1P5Ow98RhY13t7T/OMTw1hF64v9fpON7sx7EcNKdu9x9SW+JemfeTfXciWG+NO4PkevANw64d72M3DdMiwWyYSLChAUy+WAXKV8VXm7phNO+Ypfcgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g14DAovX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37C4C116D0;
	Wed, 25 Feb 2026 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772018073;
	bh=T6eXVrd1j38V9J/IxrTJIs08c+jiSkVaYxdkRGrVDPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g14DAovXR7jWTKZyjEYQQk3U5zMR16H0m3NMeT8bb5Kqcs3KWRT5FekyXiUpSDjtO
	 J57X9h7/NzeFbLxAABwZo3i1INJmSFjaZ21eTqalFy9J/Jh0TXe8Q0aV0uskd+jddS
	 S1/45MwvdGPn/vIk3ScgWu3QuDMbZPd1Yl1EAbh957+Zt2lliaT4fv413ZqkXNkLm8
	 23P6Fl2dgVMddnUfZsNgXf6nMVt27hxWQyiBD6mlKFlAa/coNDlUy1wXSeFExWb+Dk
	 dJNe+gEQp0eX1l0JQuvIn6Vm4LHy9fS5236XpCPc0PFz1KAdlcM/hIC21o4RdKJwLr
	 Itp7qNiZNr6Hg==
Date: Wed, 25 Feb 2026 16:44:29 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v13 1/3] dmaengine: switchtec-dma: Introduce Switchtec
 DMA engine skeleton
Message-ID: <aZ7Zlad8ahxJfogv@vaman>
References: <20260121051219.2409-1-logang@deltatee.com>
 <20260121051219.2409-2-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121051219.2409-2-logang@deltatee.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,infradead.org,wanadoo.fr,lst.de];
	TAGGED_FROM(0.00)[bounces-9067-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,deltatee.com:email,microchip.com:email,lst.de:email]
X-Rspamd-Queue-Id: 65AC41964FC
X-Rspamd-Action: no action

On 20-01-26, 22:12, Logan Gunthorpe wrote:
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
>  drivers/dma/switchtec_dma.c | 209 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 226 insertions(+)
>  create mode 100644 drivers/dma/switchtec_dma.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index da9dbc1a4019..b57712a12c53 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25223,6 +25223,13 @@ S:	Supported
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
> index 000000000000..bedc72d9c0ef
> --- /dev/null
> +++ b/drivers/dma/switchtec_dma.c
> @@ -0,0 +1,209 @@
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

This needs to be updated to new kmalloc_obj() API

-- 
~Vinod

