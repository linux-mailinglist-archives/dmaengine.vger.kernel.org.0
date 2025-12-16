Return-Path: <dmaengine+bounces-7665-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E3BCC4952
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA7C8305DB4E
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3A134F27D;
	Tue, 16 Dec 2025 12:51:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7694F34DCE9;
	Tue, 16 Dec 2025 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765889469; cv=none; b=cplpRDaSkj28+kqHwpIxkKlaiWUN1ZsCM2LR4vgGm6sY4IX5M9Zbc+mnbRt6ujumkavjzhVvZ4U9CAxqNxqgSWx/5GFnZ15EO7eSr/jFjCsO5niwja/J8TCwX/Pb3dqUH5uwATT3YsINmzzr7noWpFTs7Hw0urNJ+IhsLbisafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765889469; c=relaxed/simple;
	bh=mcmnDlU9X2YImHpKQA7Bd9UBFqiCXpNB6xWvDm3kEO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvBczTUnQDglWhGaz506qb33421YKb4ue5NtJg/hT8RzKm2SlcHYcIh6Zyb73eEr4grSAn1k8k/SSFTb365jgMbKAHhaCsxjsHfyx5JuHRSWl407YlvYf0wbK8sTuY4SIdToBh58Obpvcrw4y9oM8KSL5yXfBijlb1bdGPE2D68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B9C0FEC;
	Tue, 16 Dec 2025 04:50:59 -0800 (PST)
Received: from [10.57.43.186] (unknown [10.57.43.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B6363F694;
	Tue, 16 Dec 2025 04:51:04 -0800 (PST)
Message-ID: <910e3db2-c4ef-4c21-9336-49469234b8e6@arm.com>
Date: Tue, 16 Dec 2025 12:51:02 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dma: arm-dma350: add support for shared interrupt
 mode
To: Jun Guo <jun.guo@cixtech.com>, peter.chen@cixtech.com,
 fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org, jelly.jia@cixtech.com
References: <20251216123026.3519923-1-jun.guo@cixtech.com>
 <20251216123026.3519923-3-jun.guo@cixtech.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251216123026.3519923-3-jun.guo@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-16 12:30 pm, Jun Guo wrote:
> The arm dma350 controller's hardware implementation varies: some
> designs dedicate a separate interrupt line for each channel, while
> others have all channels sharing a single interrupt.This patch adds
> support for the hardware design where all DMA channels share a
> single interrupt.
> 
> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
> ---
>   drivers/dma/arm-dma350.c | 124 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 114 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
> index 9efe2ca7d5ec..6bea18521edd 100644
> --- a/drivers/dma/arm-dma350.c
> +++ b/drivers/dma/arm-dma350.c
> @@ -14,6 +14,7 @@
>   #include "virt-dma.h"
>   
>   #define DMAINFO			0x0f00
> +#define DRIVER_NAME		"arm-dma350"
>   
>   #define DMA_BUILDCFG0		0xb0
>   #define DMA_CFG_DATA_WIDTH	GENMASK(18, 16)
> @@ -142,6 +143,9 @@
>   #define LINK_LINKADDR		BIT(30)
>   #define LINK_LINKADDRHI		BIT(31)
>   
> +/* DMA NONSECURE CONTROL REGISTER */
> +#define DMANSECCTRL		0x20c
> +#define INTREN_ANYCHINTR_EN	BIT(0)
>   
>   enum ch_ctrl_donetype {
>   	CH_CTRL_DONETYPE_NONE = 0,
> @@ -192,11 +196,16 @@ struct d350_chan {
>   
>   struct d350 {
>   	struct dma_device dma;
> +	void __iomem *base;
>   	int nchan;
>   	int nreq;
>   	struct d350_chan channels[] __counted_by(nchan);
>   };
>   
> +struct d350_driver_data {
> +	bool combined_irq;
> +};
> +
>   static inline struct d350_chan *to_d350_chan(struct dma_chan *chan)
>   {
>   	return container_of(chan, struct d350_chan, vc.chan);
> @@ -461,7 +470,61 @@ static void d350_issue_pending(struct dma_chan *chan)
>   	spin_unlock_irqrestore(&dch->vc.lock, flags);
>   }
>   
> -static irqreturn_t d350_irq(int irq, void *data)
> +static irqreturn_t d350_global_irq(int irq, void *data)
> +{
> +	struct d350 *dmac = (struct d350 *)data;
> +	struct device *dev = dmac->dma.dev;
> +	irqreturn_t ret = IRQ_NONE;
> +	int i;
> +
> +	for (i = 0; i < dmac->nchan; i++) {
> +		struct d350_chan *dch = &dmac->channels[i];
> +		u32 ch_status;
> +
> +		ch_status = readl(dch->base + CH_STATUS);
> +		if (!ch_status)
> +			continue;
> +
> +		ret = IRQ_HANDLED;
> +
> +		if (ch_status & CH_STAT_INTR_ERR) {
> +			struct virt_dma_desc *vd = &dch->desc->vd;
> +			u32 errinfo = readl_relaxed(dch->base + CH_ERRINFO);
> +
> +			if (errinfo &
> +			    (CH_ERRINFO_AXIRDPOISERR | CH_ERRINFO_AXIRDRESPERR))
> +				vd->tx_result.result = DMA_TRANS_READ_FAILED;
> +			else if (errinfo & CH_ERRINFO_AXIWRRESPERR)
> +				vd->tx_result.result = DMA_TRANS_WRITE_FAILED;
> +			else
> +				vd->tx_result.result = DMA_TRANS_ABORTED;
> +
> +			vd->tx_result.residue = d350_get_residue(dch);
> +		} else if (!(ch_status & CH_STAT_INTR_DONE)) {
> +			dev_warn(dev, "Channel %d unexpected IRQ: 0x%08x\n", i,
> +				 ch_status);
> +		}
> +
> +		writel_relaxed(ch_status, dch->base + CH_STATUS);
> +
> +		spin_lock(&dch->vc.lock);
> +		if (ch_status & CH_STAT_INTR_DONE) {
> +			vchan_cookie_complete(&dch->desc->vd);
> +			dch->status = DMA_COMPLETE;
> +			dch->residue = 0;
> +			d350_start_next(dch);
> +		} else if (ch_status & CH_STAT_INTR_ERR) {
> +			vchan_cookie_complete(&dch->desc->vd);
> +			dch->status = DMA_ERROR;
> +			dch->residue = dch->desc->vd.tx_result.residue;
> +		}
> +		spin_unlock(&dch->vc.lock);
> +	}
> +
> +	return ret;
> +}
> +
> +static irqreturn_t d350_channel_irq(int irq, void *data)
>   {
>   	struct d350_chan *dch = data;
>   	struct device *dev = dch->vc.chan.device->dev;
> @@ -506,10 +569,18 @@ static irqreturn_t d350_irq(int irq, void *data)
>   static int d350_alloc_chan_resources(struct dma_chan *chan)
>   {
>   	struct d350_chan *dch = to_d350_chan(chan);
> -	int ret = request_irq(dch->irq, d350_irq, IRQF_SHARED,
> -			      dev_name(&dch->vc.chan.dev->device), dch);
> -	if (!ret)
> -		writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base + CH_INTREN);
> +	int ret = 0;
> +
> +	if (dch->irq) {
> +		ret = request_irq(dch->irq, d350_channel_irq, IRQF_SHARED,
> +				  dev_name(&dch->vc.chan.dev->device), dch);
> +		if (ret) {
> +			dev_err(chan->device->dev, "Failed to request IRQ %d\n", dch->irq);
> +			return ret;
> +		}
> +	}
> +
> +	writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base + CH_INTREN);
>   
>   	return ret;
>   }
> @@ -526,7 +597,8 @@ static void d350_free_chan_resources(struct dma_chan *chan)
>   static int d350_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> -	struct d350 *dmac;
> +	struct d350 *dmac = NULL;
> +	const struct d350_driver_data *data;
>   	void __iomem *base;
>   	u32 reg;
>   	int ret, nchan, dw, aw, r, p;
> @@ -556,6 +628,7 @@ static int d350_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	dmac->nchan = nchan;
> +	dmac->base = base;
>   
>   	reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG1);
>   	dmac->nreq = FIELD_GET(DMA_CFG_NUM_TRIGGER_IN, reg);
> @@ -582,6 +655,27 @@ static int d350_probe(struct platform_device *pdev)
>   	dmac->dma.device_issue_pending = d350_issue_pending;
>   	INIT_LIST_HEAD(&dmac->dma.channels);
>   
> +	data = device_get_match_data(dev);
> +	/* Cix Sky1 has a common host IRQ for all its channels. */
> +	if (data && data->combined_irq) {
> +		int host_irq = platform_get_irq(pdev, 0);
> +
> +		if (host_irq < 0)
> +			return dev_err_probe(dev, host_irq,
> +					     "Failed to get IRQ\n");
> +
> +		ret = devm_request_irq(&pdev->dev, host_irq, d350_global_irq,
> +				       IRQF_SHARED, DRIVER_NAME, dmac);
> +		if (ret)
> +			return dev_err_probe(
> +				dev, ret,
> +				"Failed to request the combined IRQ %d\n",
> +				host_irq);
> +	}
> +
> +	/* Combined Non-Secure Channel Interrupt Enable */
> +	writel_relaxed(INTREN_ANYCHINTR_EN, dmac->base + DMANSECCTRL);

This one line is all that should be needed - all the rest is pointless 
overcomplication and churn. And either way, copy-pasting the entire IRQ 
handler is not OK.

Thanks,
Robin.

> +
>   	/* Would be nice to have per-channel caps for this... */
>   	memset = true;
>   	for (int i = 0; i < nchan; i++) {
> @@ -595,10 +689,15 @@ static int d350_probe(struct platform_device *pdev)
>   			dev_warn(dev, "No command link support on channel %d\n", i);
>   			continue;
>   		}
> -		dch->irq = platform_get_irq(pdev, i);
> -		if (dch->irq < 0)
> -			return dev_err_probe(dev, dch->irq,
> -					     "Failed to get IRQ for channel %d\n", i);
> +
> +		if (!data) {
> +			dch->irq = platform_get_irq(pdev, i);
> +			if (dch->irq < 0)
> +				return dev_err_probe(
> +					dev, dch->irq,
> +					"Failed to get IRQ for channel %d\n",
> +					i);
> +		}
>   
>   		dch->has_wrap = FIELD_GET(CH_CFG_HAS_WRAP, reg);
>   		dch->has_trig = FIELD_GET(CH_CFG_HAS_TRIGIN, reg) &
> @@ -639,7 +738,12 @@ static void d350_remove(struct platform_device *pdev)
>   	dma_async_device_unregister(&dmac->dma);
>   }
>   
> +static const struct d350_driver_data sky1_dma350_data = {
> +	.combined_irq = true,
> +};
> +
>   static const struct of_device_id d350_of_match[] __maybe_unused = {
> +	{ .compatible = "cix,sky1-dma-350", .data = &sky1_dma350_data },
>   	{ .compatible = "arm,dma-350" },
>   	{}
>   };


