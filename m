Return-Path: <dmaengine+bounces-6298-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55979B3C5FE
	for <lists+dmaengine@lfdr.de>; Sat, 30 Aug 2025 02:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63251188BD1E
	for <lists+dmaengine@lfdr.de>; Sat, 30 Aug 2025 00:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A77DF6C;
	Sat, 30 Aug 2025 00:00:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E865C2FB;
	Sat, 30 Aug 2025 00:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756512055; cv=none; b=R2qwQYOao6GiRgM1nJTRqzcB3WY9UKahctaO9ALrhq+5T6wzcde0CL1A+rkoh1tzzHESaG9DRG64Z2VtZmAM8Lg2R8+4OChAuQ8vl6p1tDXMGTkpE/t+IyQPrI6xX/NqXDIhmXBXz6dEzg67EO73U/QlFuaM2ex1JzgEt+r/pE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756512055; c=relaxed/simple;
	bh=chm6L8bmk4QtDqokX86WVSAw9Lg6p+LjNmSSGBpyBhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAbzcNDM4WbCkPzSXYWDo7DO7E3kOiQNODtgnmqPQHMSka8BgSIRdJzCyriKOrNGRu81l+8BYgDf7hC5fOLnT311icJaf2BpQkVehLrIphY4FvrDxVdbEsvkVAziZFIPr2N65v6ZuW5812lxcKa28vLmgvZNz0JwjAqKm6m+DaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 002631756;
	Fri, 29 Aug 2025 17:00:44 -0700 (PDT)
Received: from [10.57.3.75] (unknown [10.57.3.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 218C93F63F;
	Fri, 29 Aug 2025 17:00:49 -0700 (PDT)
Message-ID: <5e39026e-bec9-408f-b24a-bb60b3f1f411@arm.com>
Date: Sat, 30 Aug 2025 01:00:47 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] dmaengine: dma350: Support device_prep_slave_sg
To: Jisheng Zhang <jszhang@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250823154009.25992-1-jszhang@kernel.org>
 <20250823154009.25992-12-jszhang@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250823154009.25992-12-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-23 4:40 pm, Jisheng Zhang wrote:
> Add device_prep_slave_sg() callback function so that DMA_MEM_TO_DEV
> and DMA_DEV_TO_MEM operations in single mode can be supported.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   drivers/dma/arm-dma350.c | 180 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 174 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
> index 3d26a1f020df..a285778264b9 100644
> --- a/drivers/dma/arm-dma350.c
> +++ b/drivers/dma/arm-dma350.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   // Copyright (C) 2024-2025 Arm Limited
> +// Copyright (C) 2025 Synaptics Incorporated
>   // Arm DMA-350 driver
>   
>   #include <linux/bitfield.h>
> @@ -98,7 +99,23 @@
>   
>   #define CH_FILLVAL		0x38
>   #define CH_SRCTRIGINCFG		0x4c
> +#define CH_SRCTRIGINMODE	GENMASK(11, 10)
> +#define CH_SRCTRIG_CMD		0
> +#define CH_SRCTRIG_DMA_FC	2
> +#define CH_SRCTRIG_PERIF_FC	3
> +#define CH_SRCTRIGINTYPE	GENMASK(9, 8)
> +#define CH_SRCTRIG_SW_REQ	0
> +#define CH_SRCTRIG_HW_REQ	2
> +#define CH_SRCTRIG_INTERN_REQ	3
>   #define CH_DESTRIGINCFG		0x50
> +#define CH_DESTRIGINMODE	GENMASK(11, 10)
> +#define CH_DESTRIG_CMD		0
> +#define CH_DESTRIG_DMA_FC	2
> +#define CH_DESTRIG_PERIF_FC	3
> +#define CH_DESTRIGINTYPE	GENMASK(9, 8)
> +#define CH_DESTRIG_SW_REQ	0
> +#define CH_DESTRIG_HW_REQ	2
> +#define CH_DESTRIG_INTERN_REQ	3

Like the CH_CFG_* definitions, let's just have common CH_TRIG* fields 
that work for both SRC and DES to simplify matters. FWIW, my attempt to 
balance clarity with conciseness would be:

#define CH_TRIGINCFG_BLKSIZE	GENMASK(23, 16)
#define CH_TRIGINCFG_MODE	GENMASK(11, 10)
#define CH_TRIG_MODE_CMD	0
#define CH_TRIG_MODE_DMA	2
#define CH_TRIG_MODE_PERIPH	3
#define CH_TRIGINCFG_TYPE	GENMASK(9, 8)
#define CH_TRIG_TYPE_SW		0
#define CH_TRIG_TYPE_HW		2
#define CH_TRIG_TYPE_INTERN	3
#define CH_TRIGINCFG_SEL	GENMASK(7, 0)

>   #define CH_LINKATTR		0x70
>   #define CH_LINK_SHAREATTR	GENMASK(9, 8)
>   #define CH_LINK_MEMATTR		GENMASK(7, 0)
> @@ -190,11 +207,13 @@ struct d350_chan {
>   	struct d350_desc *desc;
>   	void __iomem *base;
>   	struct dma_pool *cmd_pool;
> +	struct dma_slave_config config;
>   	int irq;
>   	enum dma_status status;
>   	dma_cookie_t cookie;
>   	u32 residue;
>   	u8 tsz;
> +	u8 ch;

What's this for? It doesn't seem to be anything meaningful.

>   	bool has_trig;
>   	bool has_wrap;
>   	bool coherent;
> @@ -327,6 +346,144 @@ static struct dma_async_tx_descriptor *d350_prep_memset(struct dma_chan *chan,
>   	return vchan_tx_prep(&dch->vc, &desc->vd, flags);
>   }
>   
> +static struct dma_async_tx_descriptor *
> +d350_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> +		   unsigned int sg_len, enum dma_transfer_direction dir,
> +		   unsigned long flags, void *context)
> +{
> +	struct d350_chan *dch = to_d350_chan(chan);
> +	dma_addr_t src, dst, phys;
> +	struct d350_desc *desc;
> +	struct scatterlist *sg;
> +	u32 len, trig, *cmd, *la_cmd, tsz;
> +	struct d350_sg *dsg;
> +	int i, j;
> +
> +	if (unlikely(!is_slave_direction(dir) || !sg_len))
> +		return NULL;
> +
> +	desc = kzalloc(struct_size(desc, sg, sg_len), GFP_NOWAIT);
> +	if (!desc)
> +		return NULL;
> +
> +	desc->sglen = sg_len;
> +
> +	if (dir == DMA_MEM_TO_DEV)
> +		tsz = __ffs(dch->config.dst_addr_width | (1 << dch->tsz));
> +	else
> +		tsz = __ffs(dch->config.src_addr_width | (1 << dch->tsz));

Surely we should just use the exact addr_width requested?

> +	for_each_sg(sgl, sg, sg_len, i) {
> +		desc->sg[i].command = dma_pool_zalloc(dch->cmd_pool, GFP_NOWAIT, &phys);
> +		if (unlikely(!desc->sg[i].command))
> +			goto err_cmd_alloc;
> +
> +		desc->sg[i].phys = phys;
> +		dsg = &desc->sg[i];
> +		len = sg_dma_len(sg);
> +
> +		if (dir == DMA_MEM_TO_DEV) {
> +			src = sg_dma_address(sg);
> +			dst = dch->config.dst_addr;
> +			trig = CH_CTRL_USEDESTRIGIN;
> +		} else {
> +			src = dch->config.src_addr;
> +			dst = sg_dma_address(sg);
> +			trig = CH_CTRL_USESRCTRIGIN;
> +		}
> +		dsg->tsz = tsz;
> +		dsg->xsize = lower_16_bits(len >> dsg->tsz);
> +		dsg->xsizehi = upper_16_bits(len >> dsg->tsz);
> +
> +		cmd = dsg->command;
> +		if (!i) {
> +			cmd[0] = LINK_CTRL | LINK_SRCADDR | LINK_SRCADDRHI | LINK_DESADDR |
> +				 LINK_DESADDRHI | LINK_XSIZE | LINK_XSIZEHI | LINK_SRCTRANSCFG |
> +				 LINK_DESTRANSCFG | LINK_XADDRINC | LINK_LINKADDR;
> +
> +			cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, dsg->tsz) | trig |
> +				 FIELD_PREP(CH_CTRL_XTYPE, CH_CTRL_XTYPE_CONTINUE);
> +
> +			cmd[2] = lower_32_bits(src);
> +			cmd[3] = upper_32_bits(src);
> +			cmd[4] = lower_32_bits(dst);
> +			cmd[5] = upper_32_bits(dst);
> +			cmd[6] = FIELD_PREP(CH_XY_SRC, dsg->xsize) |
> +				 FIELD_PREP(CH_XY_DES, dsg->xsize);
> +			cmd[7] = FIELD_PREP(CH_XY_SRC, dsg->xsizehi) |
> +				 FIELD_PREP(CH_XY_DES, dsg->xsizehi);
> +			if (dir == DMA_MEM_TO_DEV) {
> +				cmd[0] |= LINK_DESTRIGINCFG;
> +				cmd[8] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
> +				cmd[9] = TRANSCFG_DEVICE;
> +				cmd[10] = FIELD_PREP(CH_XY_SRC, 1);
> +				cmd[11] = FIELD_PREP(CH_DESTRIGINMODE, CH_DESTRIG_DMA_FC) |
> +					  FIELD_PREP(CH_DESTRIGINTYPE, CH_DESTRIG_HW_REQ);
> +			} else {
> +				cmd[0] |= LINK_SRCTRIGINCFG;
> +				cmd[8] = TRANSCFG_DEVICE;
> +				cmd[9] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
> +				cmd[10] = FIELD_PREP(CH_XY_DES, 1);
> +				cmd[11] = FIELD_PREP(CH_SRCTRIGINMODE, CH_SRCTRIG_DMA_FC) |
> +					  FIELD_PREP(CH_SRCTRIGINTYPE, CH_SRCTRIG_HW_REQ);
> +			}
> +			la_cmd = &cmd[12];
> +		} else {
> +			*la_cmd = phys | CH_LINKADDR_EN;
> +			if (i == sg_len - 1) {
> +				cmd[0] = LINK_CTRL | LINK_SRCADDR | LINK_SRCADDRHI | LINK_DESADDR |
> +					 LINK_DESADDRHI | LINK_XSIZE | LINK_XSIZEHI | LINK_LINKADDR;
> +				cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, dsg->tsz) | trig |
> +					 FIELD_PREP(CH_CTRL_XTYPE, CH_CTRL_XTYPE_CONTINUE);
> +				cmd[2] = lower_32_bits(src);
> +				cmd[3] = upper_32_bits(src);
> +				cmd[4] = lower_32_bits(dst);
> +				cmd[5] = upper_32_bits(dst);
> +				cmd[6] = FIELD_PREP(CH_XY_SRC, dsg->xsize) |
> +					 FIELD_PREP(CH_XY_DES, dsg->xsize);
> +				cmd[7] = FIELD_PREP(CH_XY_SRC, dsg->xsizehi) |
> +					 FIELD_PREP(CH_XY_DES, dsg->xsizehi);
> +				la_cmd = &cmd[8];
> +			} else {
> +				cmd[0] = LINK_SRCADDR | LINK_SRCADDRHI | LINK_DESADDR |
> +					 LINK_DESADDRHI | LINK_XSIZE | LINK_XSIZEHI | LINK_LINKADDR;
> +				cmd[1] = lower_32_bits(src);
> +				cmd[2] = upper_32_bits(src);
> +				cmd[3] = lower_32_bits(dst);
> +				cmd[4] = upper_32_bits(dst);
> +				cmd[5] = FIELD_PREP(CH_XY_SRC, dsg->xsize) |
> +					 FIELD_PREP(CH_XY_DES, dsg->xsize);
> +				cmd[6] = FIELD_PREP(CH_XY_SRC, dsg->xsizehi) |
> +					 FIELD_PREP(CH_XY_DES, dsg->xsizehi);
> +				la_cmd = &cmd[7];
> +			}
> +		}
> +	}
Again, the structure and duplication here is unbearable. I fail to 
comprehend why the "if (i == sg_len - 1)" case even exists...

More crucially, it clearly can't even work for DMA-350 since it would 
always be selecting trigger 0. How much of this has been tested?

> +	/* the last command */
> +	*la_cmd = 0;
> +	desc->sg[sg_len - 1].command[1] |= FIELD_PREP(CH_CTRL_DONETYPE, CH_CTRL_DONETYPE_CMD);
> +
> +	mb();
> +
> +	return vchan_tx_prep(&dch->vc, &desc->vd, flags);
> +
> +err_cmd_alloc:
> +	for (j = 0; j < i; j++)
> +		dma_pool_free(dch->cmd_pool, desc->sg[j].command, desc->sg[j].phys);
> +	kfree(desc);
> +	return NULL;
> +}
> +
> +static int d350_slave_config(struct dma_chan *chan, struct dma_slave_config *config)
> +{
> +	struct d350_chan *dch = to_d350_chan(chan);
Shouldn't we validate that the given channel has any chance of 
supporting the given config?

> +	memcpy(&dch->config, config, sizeof(*config));
> +
> +	return 0;
> +}
> +
>   static int d350_pause(struct dma_chan *chan)
>   {
>   	struct d350_chan *dch = to_d350_chan(chan);
> @@ -558,8 +715,9 @@ static irqreturn_t d350_irq(int irq, void *data)
>   	writel_relaxed(ch_status, dch->base + CH_STATUS);
>   
>   	spin_lock(&dch->vc.lock);
> -	vchan_cookie_complete(vd);
>   	if (ch_status & CH_STAT_INTR_DONE) {
> +		vchan_cookie_complete(vd);
> +		dch->desc = NULL;

What's this about? As I mentioned on the earlier patches it was very 
fiddly to get consistently appropriate handling of errors for 
MEM_TO_MEM, so please explain if this change is somehow necessary for 
MEM_TO_DEV/DEV_TO_MEM. Otherwise, if anything it just looks like an 
undocumented bodge around what those previous patches subtly broke.

>   		dch->status = DMA_COMPLETE;
>   		dch->residue = 0;
>   		d350_start_next(dch);
> @@ -617,7 +775,7 @@ static int d350_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct d350 *dmac;
>   	void __iomem *base;
> -	u32 reg, dma_chan_mask;
> +	u32 reg, dma_chan_mask, trig_bits = 0;
>   	int ret, nchan, dw, aw, r, p;
>   	bool coherent, memset;
>   
> @@ -637,13 +795,11 @@ static int d350_probe(struct platform_device *pdev)
>   	dw = 1 << FIELD_GET(DMA_CFG_DATA_WIDTH, reg);
>   	aw = FIELD_GET(DMA_CFG_ADDR_WIDTH, reg) + 1;
>   
> -	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(aw));
> -	coherent = device_get_dma_attr(dev) == DEV_DMA_COHERENT;
> -
>   	dmac = devm_kzalloc(dev, struct_size(dmac, channels, nchan), GFP_KERNEL);
>   	if (!dmac)
>   		return -ENOMEM;
>   
> +	dmac->dma.dev = dev;

Similarly, why are these two hunks just moving lines around apparently 
at random?

>   	dmac->nchan = nchan;
>   
>   	/* Enable all channels by default */
> @@ -655,12 +811,14 @@ static int d350_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(aw));
> +	coherent = device_get_dma_attr(dev) == DEV_DMA_COHERENT;
> +
>   	reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG1);
>   	dmac->nreq = FIELD_GET(DMA_CFG_NUM_TRIGGER_IN, reg);
>   
>   	dev_dbg(dev, "DMA-350 r%dp%d with %d channels, %d requests\n", r, p, dmac->nchan, dmac->nreq);
>   
> -	dmac->dma.dev = dev;
>   	for (int i = min(dw, 16); i > 0; i /= 2) {
>   		dmac->dma.src_addr_widths |= BIT(i);
>   		dmac->dma.dst_addr_widths |= BIT(i);
> @@ -692,6 +850,7 @@ static int d350_probe(struct platform_device *pdev)
>   
>   		dch->coherent = coherent;
>   		dch->base = base + DMACH(i);
> +		dch->ch = i;
>   		writel_relaxed(CH_CMD_CLEAR, dch->base + CH_CMD);
>   
>   		reg = readl_relaxed(dch->base + CH_BUILDCFG1);
> @@ -711,6 +870,7 @@ static int d350_probe(struct platform_device *pdev)
>   
>   		/* Fill is a special case of Wrap */
>   		memset &= dch->has_wrap;
> +		trig_bits |= dch->has_trig << dch->ch;

This is a bool merely dressed up as a bitmap, the shift is doing nothing.

Thanks,
Robin.

>   		reg = readl_relaxed(dch->base + CH_BUILDCFG0);
>   		dch->tsz = FIELD_GET(CH_CFG_DATA_WIDTH, reg);
> @@ -723,6 +883,13 @@ static int d350_probe(struct platform_device *pdev)
>   		vchan_init(&dch->vc, &dmac->dma);
>   	}
>   
> +	if (trig_bits) {
> +		dmac->dma.directions |= (BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV));
> +		dma_cap_set(DMA_SLAVE, dmac->dma.cap_mask);
> +		dmac->dma.device_config = d350_slave_config;
> +		dmac->dma.device_prep_slave_sg = d350_prep_slave_sg;
> +	}
> +
>   	if (memset) {
>   		dma_cap_set(DMA_MEMSET, dmac->dma.cap_mask);
>   		dmac->dma.device_prep_dma_memset = d350_prep_memset;
> @@ -759,5 +926,6 @@ static struct platform_driver d350_driver = {
>   module_platform_driver(d350_driver);
>   
>   MODULE_AUTHOR("Robin Murphy <robin.murphy@arm.com>");
> +MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
>   MODULE_DESCRIPTION("Arm DMA-350 driver");
>   MODULE_LICENSE("GPL v2");

