Return-Path: <dmaengine+bounces-11831-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OYaDFPuhQWqBswkAu9opvQ
	(envelope-from <dmaengine+bounces-11831-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 00:36:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 778EB6D52B0
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 00:36:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=XJ1E8+Pq;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11831-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11831-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FF09300D467
	for <lists+dmaengine@lfdr.de>; Sun, 28 Jun 2026 22:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3003E365A17;
	Sun, 28 Jun 2026 22:36:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D79E555;
	Sun, 28 Jun 2026 22:36:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782686200; cv=none; b=r4cBbSXtKJOGD0TTW81bPtJ2bTNvMcShIeKdhBzv8SGkgIdM0rzueiUFq0WW1ZV1uLNnD6vNglE5Y8IW9pk3ddUlFNRGLizUueSaDoAYJ1S8FK8FhOkLXPwPoquQOfhOG+2tL3+EYBRbPE+IkZp2N5b54f0shJBdPEiT2Jlkx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782686200; c=relaxed/simple;
	bh=3EAEjMZAYVKXS5U6NlBIQHsW6fxxJrTWwM/ywyv/Oz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mzk/mf7P//CKIxnSpNeYjxPOkpr3w+3PKmshixbe3Pr5/5MQpVS4CliE17Sdvih2GbIHA0uoK2lK5Pl765lW/FHCv4LpDvQBFaC5XumGNc+85SiWeMto5yvm1ei9F0ApAvPla6SxN1SXiPFMbCkHmhyU1D6heIeRTsgK3agfG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XJ1E8+Pq; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 880941BB2;
	Sun, 28 Jun 2026 15:36:26 -0700 (PDT)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9AC53F905;
	Sun, 28 Jun 2026 15:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782686191; bh=3EAEjMZAYVKXS5U6NlBIQHsW6fxxJrTWwM/ywyv/Oz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XJ1E8+PqcpU+O6RGcFveSMZoZlYEJ0OLd9ibnked9jm1zuH9G1JV4BTZMNdAW1ZbI
	 FvdvsnwMDqb4a2jEor2sofpkf6GzZjlDCbO+W4ewVDijNiu5cbwQXO1OMODyV+pOVo
	 TAXwJiAeEaE6vvojySxUKGxOKCIfBMe/zz3hjWZk=
Date: Mon, 29 Jun 2026 00:35:05 +0200
From: Andre Przywara <andre.przywara@arm.com>
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: conor+dt@kernel.org, mripard@kernel.org, krzk+dt@kernel.org,
 robh@kernel.org, samuel@sholland.org, wens@kernel.org,
 jernej.skrabec@gmail.com, Frank.Li@kernel.org, vkoul@kernel.org,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 1/5] dmaengine: sun6i-dma: Refactor to support A733
 interrupt and register handling
Message-ID: <20260629003505.18f0053d@ryzen.lan>
In-Reply-To: <20260622-sun60i-a733-dma-v3-1-f697ef296cbc@gmail.com>
References: <20260622-sun60i-a733-dma-v3-0-f697ef296cbc@gmail.com>
	<20260622-sun60i-a733-dma-v3-1-f697ef296cbc@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11831-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:conor+dt@kernel.org,m:mripard@kernel.org,m:krzk+dt@kernel.org,m:robh@kernel.org,m:samuel@sholland.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Frank.Li@nxp.com,m:alexcaoys@gmail.com,m:conor@kernel.org,m:krzk@kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,sholland.org,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,nxp.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andre.przywara@arm.com,dmaengine@vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.przywara@arm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 778EB6D52B0

On Mon, 22 Jun 2026 01:36:23 +0000
Yuanshen Cao <alex.caoys@gmail.com> wrote:

Hi,

first, many thanks for sending this, also for structuring the changes
nicely, so that they remain reviewable!

> Refactor to support the Allwinner A733 DMA controller. Currently, the
> `sun6i-dma` driver has several functions related to interrupt handling
> (reading/writing interrupt enable and status registers) and register
> dumping that are hardcoded.
> 
> To support the A733, which has different register layouts and interrupt
> handling logic, these functions are being moved into the
> `sun6i_dma_config` structure as function pointers.

So I see that this driver already makes use of per-device function
pointer, though personally I don't like this approach very much, as it
decreases the readability, and suggests significant differences between
the SoC generations that are not really there: each function just reads
or write an MMIO register, it's just the offset that differs.

So I think it's better to express the differences through data
entries in the config struct, for the IRQ enable/stat functions I think
this should be something like this:

struct sun6i_dma_config {
	...
	u32	irq_stride;
	u32	irq_en_offset;
	u32	irq_stat_offset;
	...
};

-	irq_val = readl(sdev->base + DMA_IRQ_EN(irq_reg));
+	irq_val = readl(sdev->base + sdev->cfg->irq_en_offset + irq_reg * sdev->cfg->irq_stride);

the existing configs set .stride to 0x04, and .en_offset to 0x0, the
A733 later uses .stride = 0x40 and .en_offset = 0x134.
Maybe we still move that now longish line into a helper function, but
not a config specific one. 

I think that's more readable, and avoids unnecessary redirections and
potential pipeline stalls.

dump_com_regs is a different story, since the two instances of that
function are significantly different.

What do you think?

> This allows the
> driver to use a polymorphic approach where the specific implementation
> is determined by the hardware configuration assigned during device
> probing.
> 
> Changes:
> - Added function pointers to `struct sun6i_dma_config` for:

By the way: the preferred style to list changes in commit messages in
imperative mood [1], not in past tense. Think about you ask the
code base what to change:

Add function pointers to ...
Implement generic functions ...

Cheers,
Andre

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n94

>     - `dump_com_regs`
>     - `read_irq_en`
>     - `write_irq_en`
>     - `read_irq_stat`
>     - `write_irq_stat`
> - Implemented generic `sun6i_read/write_irq_*` functions for existing
>   hardware.
> - Added a macro and updated existing `sun6i_dma_config` instances (A31,
>   A23, H3, A64, A100, H6, V3S) to use these new function pointers.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> ---
>  drivers/dma/sun6i-dma.c | 50 ++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb..ef3052c4ab36 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -138,6 +138,11 @@ struct sun6i_dma_config {
>  	void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
>  	void (*set_drq)(u32 *p_cfg, s8 src_drq, s8 dst_drq);
>  	void (*set_mode)(u32 *p_cfg, s8 src_mode, s8 dst_mode);
> +	void (*dump_com_regs)(struct sun6i_dma_dev *sdev);
> +	u32 (*read_irq_en)(struct sun6i_dma_dev *sdev, u32 irq_reg);
> +	void (*write_irq_en)(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 irq_val);
> +	u32 (*read_irq_stat)(struct sun6i_dma_dev *sdev, u32 irq_reg);
> +	void (*write_irq_stat)(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 status);
>  	u32 src_burst_lengths;
>  	u32 dst_burst_lengths;
>  	u32 src_addr_widths;
> @@ -347,6 +352,26 @@ static void sun6i_set_mode_h6(u32 *p_cfg, s8 src_mode, s8 dst_mode)
>  		  DMA_CHAN_CFG_DST_MODE_H6(dst_mode);
>  }
>  
> +static u32 sun6i_read_irq_en(struct sun6i_dma_dev *sdev, u32 irq_reg)
> +{
> +	return readl(sdev->base + DMA_IRQ_EN(irq_reg));
> +}
> +
> +static void sun6i_write_irq_en(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 irq_val)
> +{
> +	writel(irq_val, sdev->base + DMA_IRQ_EN(irq_reg));
> +}
> +
> +static u32 sun6i_read_irq_stat(struct sun6i_dma_dev *sdev, u32 irq_reg)
> +{
> +	return readl(sdev->base + DMA_IRQ_STAT(irq_reg));
> +}
> +
> +static void sun6i_write_irq_stat(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 status)
> +{
> +	writel(status, sdev->base + DMA_IRQ_STAT(irq_reg));
> +}
> +
>  static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
>  {
>  	struct sun6i_desc *txd = pchan->desc;
> @@ -460,16 +485,16 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
>  
>  	vchan->irq_type = vchan->cyclic ? DMA_IRQ_PKG : DMA_IRQ_QUEUE;
>  
> -	irq_val = readl(sdev->base + DMA_IRQ_EN(irq_reg));
> +	irq_val = sdev->cfg->read_irq_en(sdev, irq_reg);
>  	irq_val &= ~((DMA_IRQ_HALF | DMA_IRQ_PKG | DMA_IRQ_QUEUE) <<
>  			(irq_offset * DMA_IRQ_CHAN_WIDTH));
>  	irq_val |= vchan->irq_type << (irq_offset * DMA_IRQ_CHAN_WIDTH);
> -	writel(irq_val, sdev->base + DMA_IRQ_EN(irq_reg));
> +	sdev->cfg->write_irq_en(sdev, irq_reg, irq_val);
>  
>  	writel(pchan->desc->p_lli, pchan->base + DMA_CHAN_LLI_ADDR);
>  	writel(DMA_CHAN_ENABLE_START, pchan->base + DMA_CHAN_ENABLE);
>  
> -	sun6i_dma_dump_com_regs(sdev);
> +	sdev->cfg->dump_com_regs(sdev);
>  	sun6i_dma_dump_chan_regs(sdev, pchan);
>  
>  	return 0;
> @@ -549,14 +574,14 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
>  	u32 status;
>  
>  	for (i = 0; i < sdev->num_pchans / DMA_IRQ_CHAN_NR; i++) {
> -		status = readl(sdev->base + DMA_IRQ_STAT(i));
> +		status = sdev->cfg->read_irq_stat(sdev, i);
>  		if (!status)
>  			continue;
>  
>  		dev_dbg(sdev->slave.dev, "DMA irq status %s: 0x%x\n",
>  			str_high_low(i), status);
>  
> -		writel(status, sdev->base + DMA_IRQ_STAT(i));
> +		sdev->cfg->write_irq_stat(sdev, i, status);
>  
>  		for (j = 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
>  			pchan = sdev->pchans + j;
> @@ -1101,6 +1126,13 @@ static inline void sun6i_dma_free(struct sun6i_dma_dev *sdev)
>  	}
>  }
>  
> +#define SUN6I_DMA_IRQ_A31_COMMON_OPS	\
> +	.dump_com_regs    = sun6i_dma_dump_com_regs,	\
> +	.read_irq_en      = sun6i_read_irq_en,	\
> +	.write_irq_en     = sun6i_write_irq_en,	\
> +	.read_irq_stat    = sun6i_read_irq_stat,	\
> +	.write_irq_stat   = sun6i_write_irq_stat,
> +
>  /*
>   * For A31:
>   *
> @@ -1132,6 +1164,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
>  	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>  
>  /*
> @@ -1155,6 +1188,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
>  	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>  
>  static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
> @@ -1173,6 +1207,7 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
>  	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>  
>  /*
> @@ -1200,6 +1235,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> +	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>  
>  /*
> @@ -1221,6 +1257,7 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> +	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>  
>  /*
> @@ -1244,6 +1281,7 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
>  	.has_high_addr = true,
>  	.has_mbus_clk = true,
> +	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>  
>  /*
> @@ -1266,6 +1304,7 @@ static struct sun6i_dma_config sun50i_h6_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
>  	.has_mbus_clk = true,
> +	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>  
>  /*
> @@ -1289,6 +1328,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
>  	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>  
>  static const struct of_device_id sun6i_dma_match[] = {
> 


