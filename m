Return-Path: <dmaengine+bounces-12486-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id COSmMcsoVmpf0QAAu9opvQ
	(envelope-from <dmaengine+bounces-12486-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:17:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A71D754666
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:17:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Nww+aQs7;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12486-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12486-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E207434FEE97
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08161392C32;
	Tue, 14 Jul 2026 12:03:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B9C2FBE1F;
	Tue, 14 Jul 2026 12:03:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030605; cv=none; b=nLkASmMTfFSkzJbjWIMgC/tlUoWRQM46S/8Lzv7C5ceylv8glW+u+ZIoXEf3eeFfUfcbsnygcdzN9Uoig5XHQKAb1vLr5aisU+6pGADcqWG9mcvePKK8zt8a7JCn6KWglbT6qcYaV2Lz5T6CwXoe8tMx5aKSMROXJT5EJ5bLq/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030605; c=relaxed/simple;
	bh=KwGy7fWqUYGkkpXerfZG2X3j2Yri4hnvfOm2RZGNPBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAc/7UuLsIOtD1P4+QMO/0AqxKKgN/nxQJN+DXTMgqnMMvjZuHQcS41bfBTgpbJdIGxBN2P8K61TNzP057WtMkRSerimidrGzu9xLekKfuWeJWjgXRFCV4RaFd7E0+rFHGBFHAOacfdBRr0uVuKQHnTFjc8/6xm+Bhv3/bFy/tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nww+aQs7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E56C1F000E9;
	Tue, 14 Jul 2026 12:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784030602;
	bh=TEZI3chpr1Sn0iTGmVOuZ3v5A0uYcjaAtTMT7DqMsDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nww+aQs7Vih9dRithSo4WWYbNEAli8OML9UuRIuzHAIlrHy2sZxGs52QacS//52ZZ
	 k65+mU+AWPHBHeaXNaisXpoExyEpK8XklK/DACDZJZnH4a9lQGtMVtorGUAtsrUCTT
	 ocndPzKAXCnH+kSEWNysCgx7OBB2R87oAXAaBUQsDqlas8BrK5C1qCRHAxwwrg9Ad2
	 jfr4cT1xiqY9U483cTuLAXCJS4r5NZPpU2WixoZpSd4mYlDTYXnJUSgNXl3gIsTAOp
	 4SQsNEwa39YQ2FxH6s8eZpBgSh204Sa8s8mdmdZtx+K9bOjXUDtrgFGbatIc/LgALv
	 xdB3tgqD+RuZQ==
Date: Tue, 14 Jul 2026 17:33:18 +0530
From: Vinod Koul <vkoul@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, linux-amlogic@lists.infradead.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v11 2/3] dmaengine: amlogic: Add general DMA driver for A9
Message-ID: <alYlhm9vav59wKq9@vaman>
References: <20260714-amlogic-dma-v11-0-de79c2394282@amlogic.com>
 <20260714-amlogic-dma-v11-2-de79c2394282@amlogic.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-amlogic-dma-v11-2-de79c2394282@amlogic.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:xianwei.zhao@amlogic.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:Frank.Li@kernel.org,m:linux-amlogic@lists.infradead.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:Frank.Li@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-12486-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amlogic.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,vaman:mid,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A71D754666

On 14-07-26, 08:08, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Amlogic A9 SoCs include a general-purpose DMA controller that can be used
> by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
> is associated with a dedicated DMA channel in hardware.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  drivers/dma/Kconfig       |  10 +
>  drivers/dma/Makefile      |   1 +
>  drivers/dma/amlogic-dma.c | 726 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 737 insertions(+)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index ae6a682c9f76..01f96a8257e5 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -85,6 +85,16 @@ config AMCC_PPC440SPE_ADMA
>  	help
>  	  Enable support for the AMCC PPC440SPe RAID engines.
>  
> +config AMLOGIC_DMA
> +	tristate "Amlogic general DMA support"
> +	depends on ARCH_MESON || COMPILE_TEST
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	select REGMAP_MMIO
> +	help
> +	  Enable support for the Amlogic general DMA engines. THis DMA
> +	  controller is used some Amlogic SoCs, such as A9.
> +
>  config APPLE_ADMAC
>  	tristate "Apple ADMAC support"
>  	depends on ARCH_APPLE || COMPILE_TEST
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index 14aa086629d5..f62d12b08e15 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_DMATEST) += dmatest.o
>  obj-$(CONFIG_ALTERA_MSGDMA) += altera-msgdma.o
>  obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
>  obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
> +obj-$(CONFIG_AMLOGIC_DMA) += amlogic-dma.o
>  obj-$(CONFIG_APPLE_ADMAC) += apple-admac.o
>  obj-$(CONFIG_ARM_DMA350) += arm-dma350.o
>  obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
> diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
> new file mode 100644
> index 000000000000..9de650a79aba
> --- /dev/null
> +++ b/drivers/dma/amlogic-dma.c
> @@ -0,0 +1,726 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (C) 2025 Amlogic, Inc. All rights reserved

2026 please

> +/* DMA controller reg */
> +#define RCH_INT_MASK		0x1000
> +#define WCH_INT_MASK		0x1004
> +#define CLEAR_W_BATCH		0x1014
> +#define CLEAR_RCH		0x1024
> +#define CLEAR_WCH		0x1028
> +#define RCH_ACTIVE		0x1038
> +#define WCH_ACTIVE		0x103c
> +#define RCH_DONE		0x104c
> +#define WCH_DONE		0x1050
> +#define RCH_ERR			0x1060
> +#define RCH_LEN_ERR		0x1064
> +#define WCH_ERR			0x1068
> +#define DMA_BATCH_END		0x1078
> +#define WCH_EOC_DONE		0x1088
> +#define WDMA_RESP_ERR		0x1098
> +#define UPT_PKT_SYNC		0x10a8
> +#define RCHN_CFG		0x10ac
> +#define WCHN_CFG		0x10b0
> +#define MEM_PD_CFG		0x10b4
> +#define MEM_BUS_CFG		0x10b8
> +#define DMA_GMV_CFG		0x10bc
> +#define DMA_GMR_CFG		0x10c0
> +
> +#define MAX_CHAN_ID		32
> +#define SG_MAX_LEN		(GENMASK(26, 0) & ~0x3)

So you define a mask for 0-26 and then clear everything expect last two
bits, why not define last two bits..? Something does not look right here

> +static int aml_dma_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct dma_device *dma_dev;
> +	struct aml_dma_dev *aml_dma;
> +	int ret, i, len;
> +	u32 chan_nr;
> +
> +	const struct regmap_config aml_regmap_config = {
> +		.reg_bits = 32,
> +		.val_bits = 32,
> +		.reg_stride = 4,
> +		.max_register = 0x3000,
> +	};
> +
> +	ret = of_property_read_u32(np, "dma-channels", &chan_nr);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to read dma-channels\n");
> +	if (chan_nr > (MAX_CHAN_ID * 2))
> +		return dev_err_probe(&pdev->dev, -EINVAL, "dma-channels unusual\n");
> +
> +	len = sizeof(struct aml_dma_dev) + sizeof(struct aml_dma_chan) * chan_nr;
> +	aml_dma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> +	if (!aml_dma)
> +		return -ENOMEM;
> +
> +	aml_dma->chan_nr = chan_nr;
> +
> +	aml_dma->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(aml_dma->base))
> +		return PTR_ERR(aml_dma->base);
> +
> +	aml_dma->regmap = devm_regmap_init_mmio(&pdev->dev, aml_dma->base,
> +						&aml_regmap_config);
> +	if (IS_ERR_OR_NULL(aml_dma->regmap))
> +		return PTR_ERR(aml_dma->regmap);
> +
> +	aml_dma->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(aml_dma->clk))
> +		return PTR_ERR(aml_dma->clk);
> +
> +	aml_dma->irq = platform_get_irq(pdev, 0);
> +
> +	aml_dma->pdev = pdev;
> +	aml_dma->dma_device.dev = &pdev->dev;
> +
> +	dma_dev = &aml_dma->dma_device;
> +	INIT_LIST_HEAD(&dma_dev->channels);
> +
> +	/* Initialize channel parameters */
> +	for (i = 0; i < chan_nr; i++) {
> +		struct aml_dma_chan *aml_chan = &aml_dma->aml_chans[i];
> +
> +		aml_chan->aml_dma = aml_dma;
> +		aml_chan->vchan.desc_free = aml_dma_free_desc;
> +		vchan_init(&aml_chan->vchan, &aml_dma->dma_device);
> +	}
> +	aml_dma->chan_used = 0;
> +
> +	dma_set_max_seg_size(dma_dev->dev, SG_MAX_LEN);
> +	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> +	dma_dev->device_alloc_chan_resources = aml_dma_alloc_chan_resources;
> +	dma_dev->device_free_chan_resources = aml_dma_free_chan_resources;
> +	dma_dev->device_tx_status = aml_dma_tx_status;
> +	dma_dev->device_prep_slave_sg = aml_dma_prep_slave_sg;
> +	dma_dev->device_pause = aml_dma_chan_pause;
> +	dma_dev->device_resume = aml_dma_chan_resume;
> +	dma_dev->device_terminate_all = aml_dma_terminate_all;
> +	dma_dev->device_issue_pending = aml_dma_issue_pending;
> +	/* PIO 4 bytes and I2C 1 byte */
> +	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
> +	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> +
> +	regmap_write(aml_dma->regmap, RCH_INT_MASK, 0xffffffff);
> +	regmap_write(aml_dma->regmap, WCH_INT_MASK, 0xffffffff);

I think we have macros for 32bit masks, please use that here and other
places
 

-- 
~Vinod

