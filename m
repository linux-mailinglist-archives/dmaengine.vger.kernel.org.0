Return-Path: <dmaengine+bounces-9624-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UINjFGeMwml9ewQAu9opvQ
	(envelope-from <dmaengine+bounces-9624-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 14:06:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C841308E88
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 14:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DEFB30E7CB3
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA743F7E71;
	Tue, 24 Mar 2026 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jfMPjaLl"
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDD03F165F;
	Tue, 24 Mar 2026 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357173; cv=none; b=m7K4+AenUUkahbuh2RKmkMTA9bQ8jnQgcmjpKsgzyPWhVY3YOk15qAxZiMu+bq6eJLXDu6/Ygs4uZK0IbuXvzAQC3+75B4OQ3Ip4Uoh0pSpvdbHRtgofZ8SH6Usbp0KTUMVgAeaNlek8s9l8af92WPMH89qYWSujHJa8JOWmO+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357173; c=relaxed/simple;
	bh=mc1JYt6Q34dTbHsOfipO1diSgxMhivHZV5XxnYNM60Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQwbsbtFsrItShlOXS0CrAtfRSm3g2tJae/7wCQsy1Wn7Ai3AW+gIsZzzY/ybmgsw4A6W3WNHZoI5igTRSz8cxKKJoHN/v8YxWvPSGW3/BO1to/T/UqMLDBGVIzy30Z9VWIBbL5oKsnhYlymHOAR7gi96bsOzwRKiAfFAokSPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jfMPjaLl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BCA31476;
	Tue, 24 Mar 2026 05:59:25 -0700 (PDT)
Received: from [10.57.76.67] (unknown [10.57.76.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CD403FAF5;
	Tue, 24 Mar 2026 05:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774357171; bh=mc1JYt6Q34dTbHsOfipO1diSgxMhivHZV5XxnYNM60Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jfMPjaLl1fE6h48beZGNvPXZF3kJ/7ptotcBlXqjXO30EO0GFf1bapbHtMffGtuOo
	 K9EeDGNVk37mQAV/xY2fg6uCV2ggUTD94ttQFBH7OgfBFzrKMwjlxBiW1wOhNHA95K
	 CDSZY1ehKQj026uy1zd68JW3G6jTTUHanNuYQeH0=
Message-ID: <b92fa8c5-6330-4093-9066-20eacf2c8974@arm.com>
Date: Tue, 24 Mar 2026 12:59:27 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dma: arm-dma350: support combined IRQ mode with
 runtime IRQ topology detection
To: Jun Guo <jun.guo@cixtech.com>, peter.chen@cixtech.com,
 fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20260323114822.1925869-1-jun.guo@cixtech.com>
 <20260323114822.1925869-3-jun.guo@cixtech.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260323114822.1925869-3-jun.guo@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-9624-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C841308E88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-23 11:48 am, Jun Guo wrote:
> DMA-350 can be integrated with either per-channel IRQ lines or a single
> combined IRQ line. Add support for both layouts in a unified way.
> 
> Detect IRQ topology at probe time via platform_irq_count(), then:
> - request one global IRQ and enable DMANSECCTRL.INTREN_ANYCHINTR for
>    combined mode, or
> - request per-channel IRQs for channel mode.
> 
> Refactor IRQ completion/error handling into a shared channel handler
> used by both global and per-channel IRQ paths, and guard against IRQs
> arriving without an active descriptor.
> 
> Assisted-by: Cursor: GPT-5.3-Codex
> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
> ---
>   drivers/dma/arm-dma350.c | 165 +++++++++++++++++++++++++++++++++------
>   1 file changed, 139 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
> index 84220fa83029..2cf6f783b44f 100644
> --- a/drivers/dma/arm-dma350.c
> +++ b/drivers/dma/arm-dma350.c
> @@ -14,6 +14,7 @@
>   #include "virt-dma.h"
>   
>   #define DMAINFO			0x0f00
> +#define DRIVER_NAME		"arm-dma350"

Why is this here in the middle of register definitions? But frankly why 
is it being added at all?

>   #define DMA_BUILDCFG0		0xb0
>   #define DMA_CFG_DATA_WIDTH	GENMASK(18, 16)
> @@ -142,6 +143,9 @@
>   #define LINK_LINKADDR		BIT(30)
>   #define LINK_LINKADDRHI		BIT(31)
>   
> +/* DMA NONSECURE CONTROL REGISTER */
> +#define DMANSECCTRL		0x20c

Please follow the existing code rather than making a confusing ugly 
mess. DMANSECCTRL is a register frame at offset 0x0200; it contains 
(among others) a register named NSEC_CTRL at offset 0x0c.

> +#define INTREN_ANYCHINTR_EN	BIT(0)
>   
>   enum ch_ctrl_donetype {
>   	CH_CTRL_DONETYPE_NONE = 0,
> @@ -192,6 +196,7 @@ struct d350_chan {
>   
>   struct d350 {
>   	struct dma_device dma;
> +	void __iomem *base;

Why?

>   	int nchan;
>   	int nreq;
>   	struct d350_chan channels[] __counted_by(nchan);
> @@ -461,18 +466,40 @@ static void d350_issue_pending(struct dma_chan *chan)
>   	spin_unlock_irqrestore(&dch->vc.lock, flags);
>   }
>   
> -static irqreturn_t d350_irq(int irq, void *data)
> +static void d350_handle_chan_irq(struct d350_chan *dch, struct device *dev,
> +				 int chan_id, u32 ch_status)
>   {
> -	struct d350_chan *dch = data;
> -	struct device *dev = dch->vc.chan.device->dev;
> -	struct virt_dma_desc *vd = &dch->desc->vd;
> -	u32 ch_status;
> +	struct virt_dma_desc *vd;
> +	bool intr_done = ch_status & CH_STAT_INTR_DONE;
> +	bool intr_err = ch_status & CH_STAT_INTR_ERR;
>   
> -	ch_status = readl(dch->base + CH_STATUS);
> -	if (!ch_status)
> -		return IRQ_NONE;
> +	if (!intr_done && !intr_err) {

Why is the logic being changed here?

> +		if (chan_id >= 0)
> +			dev_warn(dev, "Channel %d unexpected IRQ: 0x%08x\n",
> +				 chan_id, ch_status);

Why? I see no reason why "dev" shouldn't still be the channel device.

> +		else
> +			dev_warn(dev, "Unexpected IRQ source? 0x%08x\n", ch_status);
> +		writel_relaxed(ch_status, dch->base + CH_STATUS);
> +		return;
> +	}
> +
> +	writel_relaxed(ch_status, dch->base + CH_STATUS);
> +
> +	spin_lock(&dch->vc.lock);
> +	if (!dch->desc) {
> +		if (chan_id >= 0)
> +			dev_warn(dev,
> +				 "Channel %d IRQ without active descriptor: 0x%08x\n",
> +				 chan_id, ch_status);
> +		else
> +			dev_warn(dev, "IRQ without active descriptor: 0x%08x\n",
> +				 ch_status);
> +		spin_unlock(&dch->vc.lock);
> +		return;
> +	}

This seems entirely new and nothing to do with refactoring. Why do you 
think it's necessary?

> -	if (ch_status & CH_STAT_INTR_ERR) {
> +	vd = &dch->desc->vd;
> +	if (intr_err) {
>   		u32 errinfo = readl_relaxed(dch->base + CH_ERRINFO);
>   
>   		if (errinfo & (CH_ERRINFO_AXIRDPOISERR | CH_ERRINFO_AXIRDRESPERR))
> @@ -483,14 +510,10 @@ static irqreturn_t d350_irq(int irq, void *data)
>   			vd->tx_result.result = DMA_TRANS_ABORTED;
>   
>   		vd->tx_result.residue = d350_get_residue(dch);
> -	} else if (!(ch_status & CH_STAT_INTR_DONE)) {
> -		dev_warn(dev, "Unexpected IRQ source? 0x%08x\n", ch_status);
>   	}
> -	writel_relaxed(ch_status, dch->base + CH_STATUS);
>   
> -	spin_lock(&dch->vc.lock);

I can't recall the details off-hand right now, but I have a strong 
feeling the order of operations here was reasonably significant - what's 
the justifcation for changing it?

>   	vchan_cookie_complete(vd);
> -	if (ch_status & CH_STAT_INTR_DONE) {
> +	if (intr_done) {
>   		dch->status = DMA_COMPLETE;
>   		dch->residue = 0;
>   		d350_start_next(dch);
> @@ -499,6 +522,44 @@ static irqreturn_t d350_irq(int irq, void *data)
>   		dch->residue = vd->tx_result.residue;
>   	}
>   	spin_unlock(&dch->vc.lock);
> +}
> +
> +static irqreturn_t d350_global_irq(int irq, void *data)
> +{
> +	struct d350 *dmac = (struct d350 *)data;

This isn't C++

> +	irqreturn_t ret = IRQ_NONE;
> +	int i;
> +
> +	(void)irq;

Why?

> +	for (i = 0; i < dmac->nchan; i++) {
> +		struct d350_chan *dch = &dmac->channels[i];
> +		u32 ch_status;
> +
> +		ch_status = readl(dch->base + CH_STATUS);
> +		if (!ch_status)

Why is this factored out, only to be duplicated in both callers?

> +			continue;
> +
> +		ret = IRQ_HANDLED;
> +		d350_handle_chan_irq(dch, dmac->dma.dev, i, ch_status);
> +	}
> +
> +	return ret;
> +}
> +
> +static irqreturn_t d350_channel_irq(int irq, void *data)
> +{
> +	struct d350_chan *dch = data;
> +	struct device *dev = dch->vc.chan.device->dev;
> +	u32 ch_status;
> +
> +	(void)irq;
> +
> +	ch_status = readl(dch->base + CH_STATUS);
> +	if (!ch_status)
> +		return IRQ_NONE;
> +
> +	d350_handle_chan_irq(dch, dev, -1, ch_status);
>   
>   	return IRQ_HANDLED;
>   }
> @@ -506,10 +567,18 @@ static irqreturn_t d350_irq(int irq, void *data)
>   static int d350_alloc_chan_resources(struct dma_chan *chan)
>   {
>   	struct d350_chan *dch = to_d350_chan(chan);
> -	int ret = request_irq(dch->irq, d350_irq, IRQF_SHARED,
> -			      dev_name(&dch->vc.chan.dev->device), dch);
> -	if (!ret)
> -		writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base + CH_INTREN);
> +	int ret = 0;
> +
> +	if (dch->irq >= 0) {
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
> @@ -519,18 +588,21 @@ static void d350_free_chan_resources(struct dma_chan *chan)
>   	struct d350_chan *dch = to_d350_chan(chan);
>   
>   	writel_relaxed(0, dch->base + CH_INTREN);
> -	free_irq(dch->irq, dch);
> +	if (dch->irq >= 0) {
> +		free_irq(dch->irq, dch);
> +		dch->irq = -EINVAL;
> +	}
>   	vchan_free_chan_resources(&dch->vc);
>   }
>   
>   static int d350_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> -	struct d350 *dmac;
> +	struct d350 *dmac = NULL;

Why?

>   	void __iomem *base;
>   	u32 reg;
> -	int ret, nchan, dw, aw, r, p;
> -	bool coherent, memset;
> +	int ret, nchan, dw, aw, r, p, irq_count;
> +	bool coherent, memset, combined_irq;
>   
>   	base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(base))
> @@ -556,6 +628,7 @@ static int d350_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	dmac->nchan = nchan;
> +	dmac->base = base;
>   
>   	reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG1);
>   	dmac->nreq = FIELD_GET(DMA_CFG_NUM_TRIGGER_IN, reg);
> @@ -582,12 +655,46 @@ static int d350_probe(struct platform_device *pdev)
>   	dmac->dma.device_issue_pending = d350_issue_pending;
>   	INIT_LIST_HEAD(&dmac->dma.channels);
>   
> +	irq_count = platform_irq_count(pdev);
> +	if (irq_count < 0)
> +		return dev_err_probe(dev, irq_count,
> +				     "Failed to count interrupts\n");
> +
> +	if (irq_count == 1) {
> +		combined_irq = true;

What if there's only 1 channel and it is actually using its dedicated IRQ?

> +	} else if (irq_count >= nchan) {
> +		combined_irq = false;
> +	} else {
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid IRQ count %d for %d channels\n",
> +				     irq_count, nchan);

Thsi is a change in behaviour, since we wouldm't currently consider it 
an error if the last 1 or more channels don't have an interrupt, but 
aren't accessible anyway - if a system *always* reserved the last couple 
of channels for the Secure world, arguably there would be no real 
requiremnt to describe them in the Non-Secure DT at all.

> +	}
> +
> +	if (combined_irq) {
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
> +		/* Combined Non-Secure Channel Interrupt Enable */
> +		writel_relaxed(INTREN_ANYCHINTR_EN, dmac->base + DMANSECCTRL);
> +	}
> +
>   	/* Would be nice to have per-channel caps for this... */
>   	memset = true;
>   	for (int i = 0; i < nchan; i++) {
>   		struct d350_chan *dch = &dmac->channels[i];
>   
>   		dch->base = base + DMACH(i);
> +		dch->irq = -EINVAL;
>   		writel_relaxed(CH_CMD_CLEAR, dch->base + CH_CMD);
>   
>   		reg = readl_relaxed(dch->base + CH_BUILDCFG1);
> @@ -595,10 +702,15 @@ static int d350_probe(struct platform_device *pdev)
>   			dev_warn(dev, "No command link support on channel %d\n", i);
>   			continue;
>   		}
> -		dch->irq = platform_get_irq(pdev, i);
> -		if (dch->irq < 0)
> -			return dev_err_probe(dev, dch->irq,
> -					     "Failed to get IRQ for channel %d\n", i);
> +
> +		if (!combined_irq) {
> +			dch->irq = platform_get_irq(pdev, i);

But here's the thing - even if we *were* to do something special in the 
DT binding, why not simply have:

	if (combined_irq)
		dch->irq = combined_irq_num;
	else
		dch->irq = platform_get_irq(pdev, i);

at this point, and then let everything else keep working the way it 
already does?

Thanks,
Robin.

> +			if (dch->irq < 0)
> +				return dev_err_probe(
> +					dev, dch->irq,
> +					"Failed to get IRQ for channel %d\n",
> +					i);
> +		}
>   
>   		dch->has_wrap = FIELD_GET(CH_CFG_HAS_WRAP, reg);
>   		dch->has_trig = FIELD_GET(CH_CFG_HAS_TRIGIN, reg) &
> @@ -640,6 +752,7 @@ static void d350_remove(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id d350_of_match[] __maybe_unused = {
> +	{ .compatible = "cix,sky1-dma-350" },
>   	{ .compatible = "arm,dma-350" },
>   	{}
>   };


