Return-Path: <dmaengine+bounces-4359-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C347CA2DA56
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2025 03:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE81D3A6506
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2025 02:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D371243397;
	Sun,  9 Feb 2025 02:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B13a1Oxg"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D22F30;
	Sun,  9 Feb 2025 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739066637; cv=none; b=ufa/7raoHALy8WdPVkXj0Sw6e5Sd5Kq3A/Y5RloGxXERpxAAdeDGQwmiJm97gEAcMlJMOu+5+FpcHmPEcCtthieUJoatDnntzQfeD9q9per4uWsBRB57rGIL1hHlSpS4DPgu+dId2ln66SSEhhVD2yuUxqQJZ3I9W6d7wcrrXAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739066637; c=relaxed/simple;
	bh=FE0Jqk5YY21GWTtz+x5JwkDRGQl1loDlgHMN/kBLDJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPL2vwlttf1R4O9yAVepjQSlc7TUNwTVkzAol+P9/6gGiPm75CFKAVjaJ58eTG9OBqsSPL0U5rCKDDEzF1NXOEs4c4TRHin3NMknJEnrGVT+v/EiKxvS/Qy8RWNEd4kPly7kYZ7EOpSaA7CCD1zWHgj243X11KboGTR1FulRESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B13a1Oxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D024C4CEE0;
	Sun,  9 Feb 2025 02:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739066636;
	bh=FE0Jqk5YY21GWTtz+x5JwkDRGQl1loDlgHMN/kBLDJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B13a1OxgvGbzDTDPaaGGQYoZvGlwNg7G4cO+tzeNx516zXv65IXbbzx/LNL2rS0jZ
	 KkaWnbN3N5mpLXm43liJvtiGNQ4Wr+2Xy1UXi8jpZF5CVKxglyu90W4oL//nIBVC8C
	 ydjeeP4t81fcr5cWYzZyjsGF+hhStOyLvH/dEOQrMedSRr9b5kzH1vg6XsEPfaPK25
	 GY9w00Yu+a5T4/rHbJ9EjJ3DsRxR2ZV1nVjiyjLM5MVi8wkvc0q7Lm+htT8ZqtDCeH
	 pyyc0D05dDPtLxPxBeNaeglayp00xUqM8CABxrwGHCD91hsIvejaQ0DKmCww4kYT2p
	 XUmYodopFTF9Q==
Date: Sat, 8 Feb 2025 20:03:53 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Amit Vadhavana <av2082000@gmail.com>, Dave Jiang <dave.jiang@intel.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Kees Cook <kees@kernel.org>, 
	Md Sadre Alam <quic_mdalam@quicinc.com>, Robin Murphy <robin.murphy@arm.com>, 
	Vinod Koul <vkoul@kernel.org>, David Heidelberg <david@ixit.cz>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] Revert "dmaengine: qcom: bam_dma: Avoid writing
 unavailable register"
Message-ID: <mjyavvk5jymhfdn4czffihi55nvlxea5ldgchsmkyd6lomrlbr@7224az7nsnsa>
References: <20250208223112.142567-1-caleb.connolly@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208223112.142567-1-caleb.connolly@linaro.org>

On Sat, Feb 08, 2025 at 10:30:54PM +0000, Caleb Connolly wrote:
> This commit causes a hard crash on sdm845 and likely other platforms.
> Revert it until a proper fix is found.
> 
> This reverts commit 57a7138d0627309d469719f1845d2778c251f358.
> 

I posted below patch yesterday, which reverts the change for
bdev->num_ees != 0 (i.e. SDM845), while still retaining the introduced
NDP vs Lite logic.

https://lore.kernel.org/linux-arm-msm/0892dca2-e76b-4aab-95cf-7437dabfc7a4@kernel.org/T/#t

Regards,
Bjorn

> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index c14557efd577..bbc3276992bb 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -58,11 +58,8 @@ struct bam_desc_hw {
>  #define DESC_FLAG_EOB BIT(13)
>  #define DESC_FLAG_NWD BIT(12)
>  #define DESC_FLAG_CMD BIT(11)
>  
> -#define BAM_NDP_REVISION_START	0x20
> -#define BAM_NDP_REVISION_END	0x27
> -
>  struct bam_async_desc {
>  	struct virt_dma_desc vd;
>  
>  	u32 num_desc;
> @@ -400,9 +397,8 @@ struct bam_device {
>  	int irq;
>  
>  	/* dma start transaction tasklet */
>  	struct tasklet_struct task;
> -	u32 bam_revision;
>  };
>  
>  /**
>   * bam_addr - returns BAM register address
> @@ -444,12 +440,10 @@ static void bam_reset(struct bam_device *bdev)
>  	val |= BAM_EN;
>  	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
>  
>  	/* set descriptor threshold, start with 4 bytes */
> -	if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
> -		     BAM_NDP_REVISION_END))
> -		writel_relaxed(DEFAULT_CNT_THRSHLD,
> -			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
> +	writel_relaxed(DEFAULT_CNT_THRSHLD,
> +			bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>  
>  	/* Enable default set of h/w workarounds, ie all except BAM_FULL_PIPE */
>  	writel_relaxed(BAM_CNFG_BITS_DEFAULT, bam_addr(bdev, 0, BAM_CNFG_BITS));
>  
> @@ -1005,12 +999,11 @@ static void bam_apply_new_config(struct bam_chan *bchan,
>  		if (dir == DMA_DEV_TO_MEM)
>  			maxburst = bchan->slave.src_maxburst;
>  		else
>  			maxburst = bchan->slave.dst_maxburst;
> -		if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
> -			     BAM_NDP_REVISION_END))
> -			writel_relaxed(maxburst,
> -				       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
> +
> +		writel_relaxed(maxburst,
> +			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>  	}
>  
>  	bchan->reconfigure = 0;
>  }
> @@ -1198,13 +1191,12 @@ static int bam_init(struct bam_device *bdev)
>  {
>  	u32 val;
>  
>  	/* read revision and configuration information */
> -	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
> -	if (!bdev->num_ees)
> +	if (!bdev->num_ees) {
> +		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
>  		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
> -
> -	bdev->bam_revision = val & REVISION_MASK;
> +	}
>  
>  	/* check that configured EE is within range */
>  	if (bdev->ee >= bdev->num_ees)
>  		return -EINVAL;
> -- 
> 2.48.1
> 
> 

