Return-Path: <dmaengine+bounces-6296-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77043B3C4C4
	for <lists+dmaengine@lfdr.de>; Sat, 30 Aug 2025 00:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34311B200EE
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 22:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DD7276031;
	Fri, 29 Aug 2025 22:24:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC3B25D533;
	Fri, 29 Aug 2025 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756506286; cv=none; b=Ly1LGoMcTBRGvT+ASu9JobqfK/HVulU5ZPIY4PCw5zrfvshm8a7jkuJSZegpWWHtok69AruAima7g+ep82L9tElljj9g+FV/UATdjrO1TjUuZg7EHGi+xg8sUi/ZxHRLvDLAIJGuCSE412Sggz3Yj8Pv1I4XWpgFEoU/vm+C66c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756506286; c=relaxed/simple;
	bh=CtqWO64lbYhAqyGMv/Ckajn9YwXPnH5ZErWLqeamKgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PM1dXDgTrOiyrRFJX19jKHNmL31VUSUe7oObcj0+oHbZcL5ILE4Vk1EHkiFVEUXPQah7pr+Yzxc4Sa8F6Ws/PlIw5rOLaQvYd6DfZGdPbQyhUEPJq40J/0Is7MRIfcW8LujZLVCZoMp0T/fMz68VixgbaMXrOFI1ILvOsgTN1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53A191BA8;
	Fri, 29 Aug 2025 15:24:33 -0700 (PDT)
Received: from [10.57.3.75] (unknown [10.57.3.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC4E43F63F;
	Fri, 29 Aug 2025 15:24:39 -0700 (PDT)
Message-ID: <b2987edf-8e49-4b9f-93a5-45cbe08b975b@arm.com>
Date: Fri, 29 Aug 2025 23:24:37 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] dmaengine: dma350: Support ARM DMA-250
To: Jisheng Zhang <jszhang@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250823154009.25992-1-jszhang@kernel.org>
 <20250823154009.25992-15-jszhang@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250823154009.25992-15-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-23 4:40 pm, Jisheng Zhang wrote:
> Compared with ARM DMA-350, DMA-250 is a simplified version. They share
> many common parts, but they do have difference. Add DMA-250 support
> by handling their difference by using different device_prep_slave_sg,
> device_prep_dma_cyclic and device_prep_dma_memcpy. DMA-250 doesn't
> support device_prep_dma_memset.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   drivers/dma/arm-dma350.c | 444 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 424 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
> index 5abb965c6687..0ee807424b7e 100644
> --- a/drivers/dma/arm-dma350.c
> +++ b/drivers/dma/arm-dma350.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   // Copyright (C) 2024-2025 Arm Limited
>   // Copyright (C) 2025 Synaptics Incorporated
> -// Arm DMA-350 driver
> +// Arm DMA-350/DMA-250 driver

Yeah, that's going to get old fast... By all means update the Kconfig 
help text if you think it's helpful to end users, but I don't think 
anyone expects comments like this to be exhaustive, so honestly I'd save 
the churn.
>   #include <linux/bitfield.h>
>   #include <linux/dmaengine.h>
> @@ -16,6 +16,10 @@
>   #include "dmaengine.h"
>   #include "virt-dma.h"
>   
> +#define DMANSECCTRL		0x0200
> +
> +#define NSEC_CNTXBASE		0x10
> +
>   #define DMAINFO			0x0f00
>   
>   #define DMA_BUILDCFG0		0xb0
> @@ -26,12 +30,16 @@
>   #define DMA_BUILDCFG1		0xb4
>   #define DMA_CFG_NUM_TRIGGER_IN	GENMASK(8, 0)
>   
> +#define DMA_BUILDCFG2		0xb8
> +#define DMA_CFG_HAS_TZ		BIT(8)I don't think we need to care about that. Yes, the TRM describes the 
total context memory size required from the PoV of the hardware itself, 
but even if SEC_CNTXBASE does exist, Non-Secure Linux can't set it, so 
clearly Linux can't need to provide memory for it.

> +
>   #define IIDR			0xc8
>   #define IIDR_PRODUCTID		GENMASK(31, 20)
>   #define IIDR_VARIANT		GENMASK(19, 16)
>   #define IIDR_REVISION		GENMASK(15, 12)
>   #define IIDR_IMPLEMENTER	GENMASK(11, 0)
>   
> +#define PRODUCTID_DMA250	0x250
>   #define PRODUCTID_DMA350	0x3a0
>   #define IMPLEMENTER_ARM		0x43b
>   
> @@ -140,6 +148,7 @@
>   #define CH_CFG_HAS_TRIGSEL	BIT(7)
>   #define CH_CFG_HAS_TRIGIN	BIT(5)
>   #define CH_CFG_HAS_WRAP		BIT(1)
> +#define CH_CFG_HAS_XSIZEHI	BIT(0)
>   
>   
>   #define LINK_REGCLEAR		BIT(0)
> @@ -218,6 +227,7 @@ struct d350_chan {
>   	bool cyclic;
>   	bool has_trig;
>   	bool has_wrap;
> +	bool has_xsizehi;
>   	bool coherent;
>   };
>   
> @@ -225,6 +235,10 @@ struct d350 {
>   	struct dma_device dma;
>   	int nchan;
>   	int nreq;
> +	bool is_d250;

That won't scale, but it also shouldn't be needed anyway - other than 
the context memory which is easily handled within the scope of the probe 
routine that already has the IIDR to hand, everything else ought to be 
based on the relevant feature flags.

> +	dma_addr_t cntx_mem_paddr;
> +	void *cntx_mem;
> +	u32 cntx_mem_size;
>   	struct d350_chan channels[] __counted_by(nchan);
>   };
>   
> @@ -238,6 +252,11 @@ static inline struct d350_desc *to_d350_desc(struct virt_dma_desc *vd)
>   	return container_of(vd, struct d350_desc, vd);
>   }
>   
> +static inline struct d350 *to_d350(struct dma_device *dd)
> +{
> +	return container_of(dd, struct d350, dma);
> +}
> +
>   static void d350_desc_free(struct virt_dma_desc *vd)
>   {
>   	struct d350_chan *dch = to_d350_chan(vd->tx.chan);
> @@ -585,6 +604,337 @@ static int d350_slave_config(struct dma_chan *chan, struct dma_slave_config *con
>   	return 0;
>   }
>   
> +static struct dma_async_tx_descriptor *d250_prep_memcpy(struct dma_chan *chan,
> +		dma_addr_t dest, dma_addr_t src, size_t len, unsigned long flags)

Case in point: We don't need a mess of separate copy-pasted functions, 
we just need to evolve the existing ones to split the respective 
operations into either 32-bit or 16-bit chunks depending on has_xsizehi 
- even on DMA-350, >32-bit sizes aren't properly supported since I never 
got as far as command linking, but there's no reason they shouldn't be.

> +{
> +	struct d350_chan *dch = to_d350_chan(chan);
> +	struct d350_desc *desc;
> +	u32 *cmd, *la_cmd, tsz;
> +	int sglen, i;
> +	struct d350_sg *sg;
> +	size_t xfer_len, step_max;
> +	dma_addr_t phys;
> +
> +	tsz = __ffs(len | dest | src | (1 << dch->tsz));
> +	step_max = ((1UL << 16) - 1) << tsz;
> +	sglen = DIV_ROUND_UP(len, step_max);
> +
> +	desc = kzalloc(struct_size(desc, sg, sglen), GFP_NOWAIT);
> +	if (!desc)
> +		return NULL;
> +
> +	desc->sglen = sglen;
> +	sglen = 0;
> +	while (len) {
> +		sg = &desc->sg[sglen];
> +		xfer_len = (len > step_max) ? step_max : len;

If only we had a min() function...

> +		sg->tsz = __ffs(xfer_len | dest | src | (1 << dch->tsz));

Um, what? By this point we've already decided to split based on the 
initial tsz, what purpose does recalculating it serve?

> +		sg->xsize = lower_16_bits(xfer_len >> sg->tsz);
> +
> +		sg->command = dma_pool_zalloc(dch->cmd_pool, GFP_NOWAIT, &phys);
> +		if (unlikely(!sg->command))
> +			goto err_cmd_alloc;
> +		sg->phys = phys;
> +
> +		cmd = sg->command;
> +		if (!sglen) {
> +			cmd[0] = LINK_CTRL | LINK_SRCADDR | LINK_DESADDR |
> +				 LINK_XSIZE | LINK_SRCTRANSCFG |
> +				 LINK_DESTRANSCFG | LINK_XADDRINC | LINK_LINKADDR;
> +
> +			cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, sg->tsz) |
> +				 FIELD_PREP(CH_CTRL_XTYPE, CH_CTRL_XTYPE_CONTINUE);
> +
> +			cmd[2] = lower_32_bits(src);
> +			cmd[3] = lower_32_bits(dest);
> +			cmd[4] = FIELD_PREP(CH_XY_SRC, sg->xsize) |
> +				 FIELD_PREP(CH_XY_DES, sg->xsize);
> +			cmd[5] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
> +			cmd[6] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
> +			cmd[7] = FIELD_PREP(CH_XY_SRC, 1) | FIELD_PREP(CH_XY_DES, 1);
> +			la_cmd = &cmd[8];
> +		} else {
> +			*la_cmd = phys | CH_LINKADDR_EN;
> +			if (len <= step_max) {
> +				cmd[0] = LINK_CTRL | LINK_XSIZE | LINK_LINKADDR;
> +				cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, sg->tsz) |
> +					 FIELD_PREP(CH_CTRL_XTYPE, CH_CTRL_XTYPE_CONTINUE);
> +				cmd[2] = FIELD_PREP(CH_XY_SRC, sg->xsize) |
> +					 FIELD_PREP(CH_XY_DES, sg->xsize);
> +				la_cmd = &cmd[3];
> +			} else {
> +				cmd[0] = LINK_XSIZE | LINK_LINKADDR;
> +				cmd[1] = FIELD_PREP(CH_XY_SRC, sg->xsize) |
> +					 FIELD_PREP(CH_XY_DES, sg->xsize);
> +				la_cmd = &cmd[2];
> +			}

Ok, we really need to figure out a better abstraction for command 
construction, the hard-coded array indices were a bad enough idea to 
start with, but this is almost impossible to make sense of.

> +		}
> +
> +		len -= xfer_len;
> +		src += xfer_len;
> +		dest += xfer_len;
> +		sglen++;
> +	}
> +
> +	/* the last cmdlink */
> +	*la_cmd = 0;
> +	desc->sg[sglen - 1].command[1] |= FIELD_PREP(CH_CTRL_DONETYPE, CH_CTRL_DONETYPE_CMD);

As for that, I don't even...

Furthermore, all these loops and conditionals are crazy anyway, and 
thoroughly failing to do justice to the hardware actually being pretty 
cool, namely that *commands can loop themselves*! Any single buffer/sg 
segment should take at most two commands - one dividing as much of the 
length as possible between XSIZE{HI} and CMDRESTARTCOUNT using 
REGRELOADTYPE=1, and/or one to transfer whatever non-multiple tail 
portion remains.

Honestly I'm sad the project for which I originally started this driver 
got canned, as this is the part I was really looking forward to having 
some fun with...

[...]
>   static int d350_pause(struct dma_chan *chan)
>   {
>   	struct d350_chan *dch = to_d350_chan(chan);
> @@ -620,20 +970,31 @@ static u32 d350_get_residue(struct d350_chan *dch)
>   	u32 res, xsize, xsizehi, linkaddr, linkaddrhi, hi_new;
>   	int i, sgcur, retries = 3; /* 1st time unlucky, 2nd improbable, 3rd just broken */
>   	struct d350_desc *desc = dch->desc;
> +	struct d350 *dmac = to_d350(dch->vc.chan.device);
>   
> -	hi_new = readl_relaxed(dch->base + CH_XSIZEHI);
> -	do {
> -		xsizehi = hi_new;
> -		xsize = readl_relaxed(dch->base + CH_XSIZE);
> +	if (dch->has_xsizehi) {
>   		hi_new = readl_relaxed(dch->base + CH_XSIZEHI);
> -	} while (xsizehi != hi_new && --retries);
> +		do {
> +			xsizehi = hi_new;
> +			xsize = readl_relaxed(dch->base + CH_XSIZE);
> +			hi_new = readl_relaxed(dch->base + CH_XSIZEHI);
> +		} while (xsizehi != hi_new && --retries);
> +	} else {
> +		xsize = readl_relaxed(dch->base + CH_XSIZE);
> +		xsizehi = 0;
> +	}
This is unnecessary - if the CH_XSIZEHI location isn't the actual 
register then it's RAZ/WI, which means the existing logic can take full 
advantage of it reading as zero and still work just the same.

> -	hi_new = readl_relaxed(dch->base + CH_LINKADDRHI);
> -	do {
> -		linkaddrhi = hi_new;
> -		linkaddr = readl_relaxed(dch->base + CH_LINKADDR);
> +	if (!dmac->is_d250) {

And similarly here. The only thing we should perhaps do specially for 
LINKADDRHI is omit it from command generation when ADDR_WIDTH <= 32 in 
general. I admit I was lazy there, since it's currently harmless for 
d350_start_next() to write the register location unconditionally, but 
I'm not sure how a 32-bit DMA-350 would handle it in an actual command 
link header.

>   		hi_new = readl_relaxed(dch->base + CH_LINKADDRHI);
> -	} while (linkaddrhi != hi_new && --retries);
> +		do {
> +			linkaddrhi = hi_new;
> +			linkaddr = readl_relaxed(dch->base + CH_LINKADDR);
> +			hi_new = readl_relaxed(dch->base + CH_LINKADDRHI);
> +		} while (linkaddrhi != hi_new && --retries);
> +	} else {
> +		linkaddr = readl_relaxed(dch->base + CH_LINKADDR);
> +		linkaddrhi = 0;
> +	}
>   
>   	for (i = 0; i < desc->sglen; i++) {
>   		if (desc->sg[i].phys == (((u64)linkaddrhi << 32) | (linkaddr & ~CH_LINKADDR_EN)))
> @@ -876,6 +1237,14 @@ static void d350_free_chan_resources(struct dma_chan *chan)
>   	dch->cmd_pool = NULL;
>   }
>   
> +static void d250_cntx_mem_release(void *ptr)
> +{
> +	struct d350 *dmac = ptr;
> +	struct device *dev = dmac->dma.dev;
> +
> +	dma_free_coherent(dev, dmac->cntx_mem_size, dmac->cntx_mem, dmac->cntx_mem_paddr);
> +}
> +
>   static int d350_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -893,8 +1262,9 @@ static int d350_probe(struct platform_device *pdev)
>   	r = FIELD_GET(IIDR_VARIANT, reg);
>   	p = FIELD_GET(IIDR_REVISION, reg);
>   	if (FIELD_GET(IIDR_IMPLEMENTER, reg) != IMPLEMENTER_ARM ||
> -	    FIELD_GET(IIDR_PRODUCTID, reg) != PRODUCTID_DMA350)
> -		return dev_err_probe(dev, -ENODEV, "Not a DMA-350!");
> +	    ((FIELD_GET(IIDR_PRODUCTID, reg) != PRODUCTID_DMA350) &&
> +	    FIELD_GET(IIDR_PRODUCTID, reg) != PRODUCTID_DMA250))
> +		return dev_err_probe(dev, -ENODEV, "Not a DMA-350/DMA-250!");
>   
>   	reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG0);
>   	nchan = FIELD_GET(DMA_CFG_NUM_CHANNELS, reg) + 1;
> @@ -917,13 +1287,38 @@ static int d350_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	if (device_is_compatible(dev, "arm,dma-250")) {
If only we had a completely reliable product ID from the hardware itself...

> +		u32 cfg2;
> +		int secext_present;
> +
> +		dmac->is_d250 = true;
> +
> +		cfg2 = readl_relaxed(base + DMAINFO + DMA_BUILDCFG2);
> +		secext_present = (cfg2 & DMA_CFG_HAS_TZ) ? 1 : 0;
> +		dmac->cntx_mem_size = nchan * 64 * (1 + secext_present);

As before I think that's wrong.

> +		dmac->cntx_mem = dma_alloc_coherent(dev, dmac->cntx_mem_size,
> +						    &dmac->cntx_mem_paddr,
> +						    GFP_KERNEL);

This is too early, it needs to wait until after we've set the DMA mask. 
Also since this is purely private memory for the device, it may as well 
use DMA_ATTR_NO_KERNEL_MAPPING.

> +		if (!dmac->cntx_mem)
> +			return dev_err_probe(dev, -ENOMEM, "Failed to alloc context memory\n");
Just return -ENOMEM - dev_err_probe() adds nothing.

> +		ret = devm_add_action_or_reset(dev, d250_cntx_mem_release, dmac);
> +		if (ret) {
> +			dma_free_coherent(dev, dmac->cntx_mem_size,
> +					  dmac->cntx_mem, dmac->cntx_mem_paddr);

a) Understand that the mildly non-obvious "or reset" means it already 
calls the cleanup action on error, so this would be a double-free.

b) Don't reinvent dmam_alloc_*() in the first place though.

> +			return ret;
> +		}
> +		writel_relaxed(dmac->cntx_mem_paddr, base + DMANSECCTRL + NSEC_CNTXBASE);

Perhaps we should check that this hasn't already been set up first? I 
mean, we can't necessarily even be sure teh context memory interface can 
access the same address space as the DMA transfer interface at all; the 
design intent is at least partly to allow connecting a dedicated SRAM 
directly, see figure 1 here: 
https://developer.arm.com/documentation/108001/0000/DMAC-interfaces/AHB5-manager-interfaces/Separate-AHB5-ports-for-data-and-virtual-channel-context?lang=en

However I'm not sure how feasible that is to detect from software - the 
base register alone clearly isn't foolproof since 0 could be a valid 
address (especially in a private SRAM). At worst I suppose we might end 
up needing a DMA-250-specific DT property to say whether it does or 
doesn't need context memory from the OS...

> +	}
> +
>   	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(aw));
>   	coherent = device_get_dma_attr(dev) == DEV_DMA_COHERENT;
>   
>   	reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG1);
>   	dmac->nreq = FIELD_GET(DMA_CFG_NUM_TRIGGER_IN, reg);
>   
> -	dev_dbg(dev, "DMA-350 r%dp%d with %d channels, %d requests\n", r, p, dmac->nchan, dmac->nreq);
> +	dev_info(dev, "%s r%dp%d with %d channels, %d requests\n",
> +		 dmac->is_d250 ? "DMA-250" : "DMA-350", r, p, dmac->nchan, dmac->nreq);

As Krzysztof said, this is a debug message and it's staying a debug 
message. And just replace "DMA-350" with "ProductID 0x%x" - it's only 
meant as a sanity-check that we're looking at the hardware we expect to 
be looking at.
>   	for (int i = min(dw, 16); i > 0; i /= 2) {
>   		dmac->dma.src_addr_widths |= BIT(i);
> @@ -935,7 +1330,10 @@ static int d350_probe(struct platform_device *pdev)
>   	dmac->dma.device_alloc_chan_resources = d350_alloc_chan_resources;
>   	dmac->dma.device_free_chan_resources = d350_free_chan_resources;
>   	dma_cap_set(DMA_MEMCPY, dmac->dma.cap_mask);
> -	dmac->dma.device_prep_dma_memcpy = d350_prep_memcpy;
> +	if (dmac->is_d250)
> +		dmac->dma.device_prep_dma_memcpy = d250_prep_memcpy;
> +	else
> +		dmac->dma.device_prep_dma_memcpy = d350_prep_memcpy;
>   	dmac->dma.device_pause = d350_pause;
>   	dmac->dma.device_resume = d350_resume;
>   	dmac->dma.device_terminate_all = d350_terminate_all;
> @@ -971,8 +1369,8 @@ static int d350_probe(struct platform_device *pdev)
>   			return dch->irq;
>   
>   		dch->has_wrap = FIELD_GET(CH_CFG_HAS_WRAP, reg);
> -		dch->has_trig = FIELD_GET(CH_CFG_HAS_TRIGIN, reg) &
> -				FIELD_GET(CH_CFG_HAS_TRIGSEL, reg);

Not only is this in the wrong patch, it's the wrong change to make 
anyway. If you're only adding support for fixed triggers, you need to 
explicitly *exclude* selectable triggers from that, because they work 
differently.

Thanks,
Robin.

> +		dch->has_xsizehi = FIELD_GET(CH_CFG_HAS_XSIZEHI, reg);
> +		dch->has_trig = FIELD_GET(CH_CFG_HAS_TRIGIN, reg);
>   
>   		/* Fill is a special case of Wrap */
>   		memset &= dch->has_wrap;
> @@ -994,8 +1392,13 @@ static int d350_probe(struct platform_device *pdev)
>   		dma_cap_set(DMA_SLAVE, dmac->dma.cap_mask);
>   		dma_cap_set(DMA_CYCLIC, dmac->dma.cap_mask);
>   		dmac->dma.device_config = d350_slave_config;
> -		dmac->dma.device_prep_slave_sg = d350_prep_slave_sg;
> -		dmac->dma.device_prep_dma_cyclic = d350_prep_cyclic;
> +		if (dmac->is_d250) {
> +			dmac->dma.device_prep_slave_sg = d250_prep_slave_sg;
> +			dmac->dma.device_prep_dma_cyclic = d250_prep_cyclic;
> +		} else {
> +			dmac->dma.device_prep_slave_sg = d350_prep_slave_sg;
> +			dmac->dma.device_prep_dma_cyclic = d350_prep_cyclic;
> +		}
>   	}
>   
>   	if (memset) {
> @@ -1019,6 +1422,7 @@ static void d350_remove(struct platform_device *pdev)
>   
>   static const struct of_device_id d350_of_match[] __maybe_unused = {
>   	{ .compatible = "arm,dma-350" },
> +	{ .compatible = "arm,dma-250" },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, d350_of_match);
> @@ -1035,5 +1439,5 @@ module_platform_driver(d350_driver);
>   
>   MODULE_AUTHOR("Robin Murphy <robin.murphy@arm.com>");
>   MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
> -MODULE_DESCRIPTION("Arm DMA-350 driver");
> +MODULE_DESCRIPTION("Arm DMA-350/DMA-250 driver");
>   MODULE_LICENSE("GPL v2");

