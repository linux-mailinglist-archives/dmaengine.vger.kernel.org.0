Return-Path: <dmaengine+bounces-2877-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEBA954EB6
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 18:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D19E4B223E2
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F42081BD00B;
	Fri, 16 Aug 2024 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pv+7Pmd1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BBC817;
	Fri, 16 Aug 2024 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825353; cv=none; b=GFueE1piu6Q5/jGuMb/CN1bXfU85dqgMaJIRrUQNtbC3s/jnP97asAAX9MP/zvAtSBEHozkELRIYe9poWVGfQKD5QYai8L29yW9gZy8jX697AR9q5ZuBczn9yH0m9iGfb5R/Nl5ZTdiNWxc+ls3SHdpSHZy9SZ0a6dmTFO+e5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825353; c=relaxed/simple;
	bh=5bM/+gMH6YeK6p9UWhTLUC1eR9DgYt1YNPoIMImSiO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX4k1Ec1Eh8gZjtpgDOjNVK5k3qZvfTVsoQ02le456hLT8ylibd1NL+fHQvlbtyO8cQp6P5ppWj4qpwSUDSXRwXqJyNens3n+/LShmRp3DeFNiKq/VRDtS7wHDVhRA9CQu2Tm2Zch1EiuutnERL9UBs9fNQg67uPEqkUIVsaFac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pv+7Pmd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC01AC32782;
	Fri, 16 Aug 2024 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723825353;
	bh=5bM/+gMH6YeK6p9UWhTLUC1eR9DgYt1YNPoIMImSiO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pv+7Pmd1kACFZxzIUAdZ2un+e62Xi6DceMWdZeVLaXPqhsbZX4WK1ZXHcYUiDGMtM
	 6EeCw5L7Pnqtq1MLPX3+HkMSxWkf9AP2AmDVMfbsp7MzrcwXrb2NNoHiwdpH6oap75
	 3CD+R0wvp4rySmpKLgobsF0Dan7f/MSQGEREW8QbaO9oPrD6bysk9mwWN2U67Inkhi
	 Bebk/NWgCSLYUNlli/Zw/vHsRyR8FyUXSspKnWhIP1IAtOKJe6bQjmKwFqliAl/q7O
	 3tVs5IjFW3Bl0XaoW95SZNLDfSMObrqMn5VCpJ5zFT2HeIxaT5K8CTVjtjkbzfnb51
	 DDmjuclRg7Jtg==
Date: Fri, 16 Aug 2024 11:22:29 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, konradybcio@kernel.org, thara.gopinath@gmail.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, gustavoars@kernel.org, 
	u.kleine-koenig@pengutronix.de, kees@kernel.org, agross@kernel.org, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, quic_srichara@quicinc.com, 
	quic_varada@quicinc.com, quic_utiwari@quicinc.com
Subject: Re: [PATCH v2 03/16] dmaengine: qcom: bam_dma: add LOCK & UNLOCK
 flag support
Message-ID: <knhqbj2pyluwrvr2f4h6zgpfosa6o2qgnhtl4qltadpuyfexgu@kk5knurc4v7h>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
 <20240815085725.2740390-4-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815085725.2740390-4-quic_mdalam@quicinc.com>

On Thu, Aug 15, 2024 at 02:27:12PM GMT, Md Sadre Alam wrote:
> Add lock and unlock flag support on command descriptor.
> Once lock set in requester pipe, then the bam controller
> will lock all others pipe and process the request only
> from requester pipe. Unlocking only can be performed from
> the same pipe.
> 

Is the lock per channel, or for the whole BAM instance?

> If DMA_PREP_LOCK flag passed in command descriptor then requester
> of this transaction wanted to lock the BAM controller for this
> transaction so BAM driver should set LOCK bit for the HW descriptor.

You use the expression "this transaction" here, but if I understand the
calling code the lock is going to be held over multiple DMA operations
and even across asynchronous operations in the crypto driver.

DMA_PREP_LOCK indicates that this is the beginning of a transaction,
consisting of multiple operations that needs to happen while other EEs
are being locked out, and DMA_PREP_UNLOCK marks the end of the
transaction.

That said, I'm not entirely fond of the fact that these flags are not
just used on first and last operation in one sequence, but spread out.

Locking is hard, when you spread the responsibility of locking and
unlocking across different entities it's made harder...

> 
> If DMA_PREP_UNLOCK flag passed in command descriptor then requester
> of this transaction wanted to unlock the BAM controller.so BAM driver
> should set UNLOCK bit for the HW descriptor.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> 
> Change in [v2]
> 
> * Added LOCK and UNLOCK flag in bam driver
> 
> Change in [v1]
> 
> * This patch was not included in [v1]

v1 can be found here:
https://lore.kernel.org/all/20231214114239.2635325-7-quic_mdalam@quicinc.com/

And it was also posted once before that:
https://lore.kernel.org/all/1608215842-15381-1-git-send-email-mdalam@codeaurora.org/

In particular during the latter (i.e. first post) we had a rather long
discussion about this feature, so that's certainly worth linking to.

Looks like this series provides some answers to the questions we had
back then.

Regards,
Bjorn

> 
>  drivers/dma/qcom/bam_dma.c | 10 +++++++++-
>  include/linux/dmaengine.h  |  6 ++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 1ac7e250bdaa..ab3b5319aa68 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -58,6 +58,8 @@ struct bam_desc_hw {
>  #define DESC_FLAG_EOB BIT(13)
>  #define DESC_FLAG_NWD BIT(12)
>  #define DESC_FLAG_CMD BIT(11)
> +#define DESC_FLAG_LOCK BIT(10)
> +#define DESC_FLAG_UNLOCK BIT(9)
>  
>  struct bam_async_desc {
>  	struct virt_dma_desc vd;
> @@ -692,9 +694,15 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
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
>  };
>  
>  /**
> -- 
> 2.34.1
> 

