Return-Path: <dmaengine+bounces-3880-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99E59E3A33
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 13:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3192835EA
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AE11B413D;
	Wed,  4 Dec 2024 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev1ho5M6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715381AF0AA;
	Wed,  4 Dec 2024 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316358; cv=none; b=jsfYxxwMCEl++2tHfVpGga9b2ICnp00ugcvAJ46SGaxzloF5G9Rd08SoWtERk49ZilGWvB0zRDoKKp65DFNd1aLIUrB/ji9OxCFC/k/GcaNjAAKQFtsEy2ETuQdaYe85R8bynbe3NPAwuHWd7yRfaryGLSGky/U6qRW6NMs3kBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316358; c=relaxed/simple;
	bh=2QDSecObE6wwLJzkdSzKWQZqdDB/m3+uI1Nge5/iGTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBVR0ktdEyOHcwRfPLhCKqoQTKn2BeV4r5jbBmVQr2KG0NoGRMSdhm7Dq+6be4VOL+fhQdW3Sm1V+czmr5A7JY4sIweyC6tuxOx4ezTMtHLp8G/1najC0pB3nkwt8kNkDOrQJBTKE/YdSUpchMc4+R+BrWEsOiY6WqiS1zl2bzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev1ho5M6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768F7C4CED1;
	Wed,  4 Dec 2024 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733316358;
	bh=2QDSecObE6wwLJzkdSzKWQZqdDB/m3+uI1Nge5/iGTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ev1ho5M6lAHwSLKXZG9JKWEIYTfGOXSGYuqsck413CBkUqkmTAIsbHyhybpRfTHxT
	 Y5tANApUnQCtCeGxHzgfyVfe/y4UQv6cV2R1P4SFudt5zFvsOqpHvNiGtHyh7KV7Li
	 pavqLH/GzZnJwm+eTk/BAL/HTT1VRo3je8GoAqxlzJtnPEm83wHpfnjwvlq73C3lMV
	 w/zjgv1cREfq0KeUiLFyPymeNzN7C/5UXIyh3CFwSHdpE5ZBh4ryEkK6nezJ66mYic
	 8qC6keGoZLt+8o51A2p47xtsVZV9//MihEXZw6rRyPeeyv6COXesdk9LPmYJC0m/7d
	 y9tKzAOLVcGCw==
Date: Wed, 4 Dec 2024 18:15:54 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: thara.gopinath@gmail.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, kees@kernel.org, robin.murphy@arm.com,
	fenghua.yu@intel.com, av2082000@gmail.com,
	u.kleine-koenig@pengutronix.d, linux-crypto@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, quic_varada@quicinc.com,
	quic_srichara@quicinc.com
Subject: Re: [PATCH v4 02/11] dmaengine: qcom: bam_dma: add LOCK & UNLOCK
 flag support
Message-ID: <Z1BPApOvYoDaTR57@vaman>
References: <20240909092632.2776160-1-quic_mdalam@quicinc.com>
 <20240909092632.2776160-3-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909092632.2776160-3-quic_mdalam@quicinc.com>

On 09-09-24, 14:56, Md Sadre Alam wrote:
> Add lock and unlock flag support on command descriptor.
> Once lock set in requester pipe, then the bam controller
> will lock all others pipe and process the request only
> from requester pipe. Unlocking only can be performed from
> the same pipe.
> 
> If DMA_PREP_LOCK flag passed in command descriptor then requester
> of this transaction wanted to lock the BAM controller for this
> transaction so BAM driver should set LOCK bit for the HW descriptor.
> 
> If DMA_PREP_UNLOCK flag passed in command descriptor then requester
> of this transaction wanted to unlock the BAM controller.so BAM driver
> should set UNLOCK bit for the HW descriptor.
> 
> BAM IP version 1.4.0 and above only supports this LOCK/UNLOCK
> feature. So adding check for the same and setting bam_pipe_lock
> based on BAM SW Version.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> 
> Change in [v4]
> 
> * Added BAM_SW_VERSION read for major & minor
>   version
> 
> * Added bam_pipe_lock flag 
> 
> Change in [v3]
> 
> * Moved lock/unlock bit set inside loop
> 
> Change in [v2]
> 
> * No change
>  
> Change in [v1]
> 
> * Added initial support for BAM pipe lock/unlock
> 
>  drivers/dma/qcom/bam_dma.c | 25 ++++++++++++++++++++++++-
>  include/linux/dmaengine.h  |  6 ++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 3a2965939531..d30416a26d8e 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -53,11 +53,20 @@ struct bam_desc_hw {
>  
>  #define BAM_DMA_AUTOSUSPEND_DELAY 100
>  
> +#define SW_VERSION_MAJOR_SHIFT	28
> +#define SW_VERSION_MINOR_SHIFT	16
> +#define SW_VERSION_MAJOR_MASK	(0xf << SW_VERSION_MAJOR_SHIFT)

Use GENMASK for this

> +#define SW_VERSION_MINOR_MASK	0xf

Can you define only masks and use FIELD_PREP etc to handle this

> +#define SW_MAJOR_1	0x1
> +#define SW_VERSION_4	0x4
> +
>  #define DESC_FLAG_INT BIT(15)
>  #define DESC_FLAG_EOT BIT(14)
>  #define DESC_FLAG_EOB BIT(13)
>  #define DESC_FLAG_NWD BIT(12)
>  #define DESC_FLAG_CMD BIT(11)
> +#define DESC_FLAG_LOCK BIT(10)
> +#define DESC_FLAG_UNLOCK BIT(9)
>  
>  struct bam_async_desc {
>  	struct virt_dma_desc vd;
> @@ -393,6 +402,7 @@ struct bam_device {
>  	u32 ee;
>  	bool controlled_remotely;
>  	bool powered_remotely;
> +	bool bam_pipe_lock;
>  	u32 active_channels;
>  	u32 bam_sw_version;
>  
> @@ -696,9 +706,15 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>  		unsigned int curr_offset = 0;
>  
>  		do {
> -			if (flags & DMA_PREP_CMD)
> +			if (flags & DMA_PREP_CMD) {
>  				desc->flags |= cpu_to_le16(DESC_FLAG_CMD);
>  
> +				if (bdev->bam_pipe_lock && flags & DMA_PREP_LOCK)
> +					desc->flags |= cpu_to_le16(DESC_FLAG_LOCK);
> +				else if (bdev->bam_pipe_lock && flags & DMA_PREP_UNLOCK)
> +					desc->flags |= cpu_to_le16(DESC_FLAG_UNLOCK);
> +			}
> +
>  			desc->addr = cpu_to_le32(sg_dma_address(sg) +
>  						 curr_offset);
>  
> @@ -1242,6 +1258,7 @@ static int bam_dma_probe(struct platform_device *pdev)
>  {
>  	struct bam_device *bdev;
>  	const struct of_device_id *match;
> +	u32 sw_major, sw_minor;
>  	int ret, i;
>  
>  	bdev = devm_kzalloc(&pdev->dev, sizeof(*bdev), GFP_KERNEL);
> @@ -1305,6 +1322,12 @@ static int bam_dma_probe(struct platform_device *pdev)
>  
>  	bdev->bam_sw_version = readl_relaxed(bam_addr(bdev, 0, BAM_SW_VERSION));
>  	dev_info(bdev->dev, "BAM software version:0x%08x\n", bdev->bam_sw_version);
> +	sw_major = (bdev->bam_sw_version & SW_VERSION_MAJOR_MASK) >> SW_VERSION_MAJOR_SHIFT;
> +	sw_minor = (bdev->bam_sw_version >> SW_VERSION_MINOR_SHIFT) & SW_VERSION_MINOR_MASK;

FIELD_GET

> +
> +	if (sw_major == SW_MAJOR_1 && sw_minor >= SW_VERSION_4)
> +		bdev->bam_pipe_lock = true;
> +
>  
>  	ret = bam_init(bdev);
>  	if (ret)
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index b137fdb56093..70f23068bfdc 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -200,6 +200,10 @@ struct dma_vec {
>   *  transaction is marked with DMA_PREP_REPEAT will cause the new transaction
>   *  to never be processed and stay in the issued queue forever. The flag is
>   *  ignored if the previous transaction is not a repeated transaction.
> + *  @DMA_PREP_LOCK: tell the driver that there is a lock bit set on command
> + *  descriptor.
> + *  @DMA_PREP_UNLOCK: tell the driver that there is a un-lock bit set on command
> + *  descriptor.
>   */
>  enum dma_ctrl_flags {
>  	DMA_PREP_INTERRUPT = (1 << 0),
> @@ -212,6 +216,8 @@ enum dma_ctrl_flags {
>  	DMA_PREP_CMD = (1 << 7),
>  	DMA_PREP_REPEAT = (1 << 8),
>  	DMA_PREP_LOAD_EOT = (1 << 9),
> +	DMA_PREP_LOCK = (1 << 10),
> +	DMA_PREP_UNLOCK = (1 << 11),

this should be a separate patch to define how to use these new flags,
what it means etc...


>  };
>  
>  /**
> -- 
> 2.34.1

-- 
~Vinod

