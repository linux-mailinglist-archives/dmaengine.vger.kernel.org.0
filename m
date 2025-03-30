Return-Path: <dmaengine+bounces-4793-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA6FA75AE4
	for <lists+dmaengine@lfdr.de>; Sun, 30 Mar 2025 18:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610F2188B62B
	for <lists+dmaengine@lfdr.de>; Sun, 30 Mar 2025 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6EE1D5174;
	Sun, 30 Mar 2025 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Swg103uf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062061AF0B4;
	Sun, 30 Mar 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743351742; cv=none; b=fp6r9AXRS9R07tjs/T4hiMuBauVJDR8qwHLC2a+1YXxnCwS7poNLSTCWAtGOqnRrO67G9dnFT8j0LYyXf2vbw7yEDuXK3qYOdnrXU36sAFPz6BbJQwUFPaWuY7fWky33SLz5iFK4n2sXi5Gr7lbCbyIXFBaQXUoqK7RCMa/W+0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743351742; c=relaxed/simple;
	bh=qUBag9B5StRidN5HLkgVvfa2PUN1Q7Fm4vRmNvVYu78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+D6YDIF8y63Kk0dX10T3VMuRECXeDt7vg63goFleVA+sYb7JqV5qy/dfeZfSvx/Df9mXP3yXMO8PS6fn2eI7jrsA9HCbvK81JsNu3UL01MVINO8C2c3B9xmpsRK3RMygF88eC98Fi2ZSRzhrL1YOSx2D1vTt6Y8W3STiRAAUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Swg103uf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4ADC4CEDD;
	Sun, 30 Mar 2025 16:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743351741;
	bh=qUBag9B5StRidN5HLkgVvfa2PUN1Q7Fm4vRmNvVYu78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Swg103ufzfdPCm0qK6fpdXzqL0eoAqqwc1GbXfJNE32jXajDTjHIXVQ8VxGMTmtPj
	 yZh+pWwHkrPkhkYx7U8Njltg6QeVNN2CmuDArWrehsjMal475gix0nUsefXfOmJ3K2
	 9Hi5YpvxsyfTTj3NikIYeGUfkDzo+dBcCmTDfIfwXwlZiCax5CdgLmDp2g5DKEjEUO
	 UojgJELNaeucLLWM2TElgeJqjUFRuc53+swGckBzukjb+HvXpPcxuGmFflKXJXpmO/
	 OY13+QM6sHChzTGFHa+7NjHpyR7vwJ6rRTiWARRrTl2fCKjIx3o6SEwzgeDFHF1Cn3
	 62k73MgbQXYQg==
Date: Sun, 30 Mar 2025 21:52:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 3/8] dmaengine: qcom: bam_dma: add bam_pipe_lock flag
 support
Message-ID: <Z+lvuVaV8DXQuAR3@vaman>
References: <20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org>
 <20250311-qce-cmd-descr-v7-3-db613f5d9c9f@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-qce-cmd-descr-v7-3-db613f5d9c9f@linaro.org>

On 11-03-25, 10:25, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Extend the device match data with a flag indicating whether the IP
> supports the BAM lock/unlock feature. Set it to true on BAM IP versions
> 1.4.0 and above.
> 
> Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 8861245314b1..737fce396c2e 100644
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
> @@ -113,6 +115,7 @@ struct reg_offset_data {
>  
>  struct bam_device_data {
>  	const struct reg_offset_data *reg_info;
> +	bool bam_pipe_lock;
>  };
>  
>  static const struct reg_offset_data bam_v1_3_reg_info[] = {
> @@ -179,6 +182,7 @@ static const struct reg_offset_data bam_v1_4_reg_info[] = {
>  
>  static const struct bam_device_data bam_v1_4_data = {
>  	.reg_info = bam_v1_4_reg_info,
> +	.bam_pipe_lock = true,
>  };
>  
>  static const struct reg_offset_data bam_v1_7_reg_info[] = {
> @@ -212,6 +216,7 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
>  
>  static const struct bam_device_data bam_v1_7_data = {
>  	.reg_info = bam_v1_7_reg_info,
> +	.bam_pipe_lock = true,
>  };
>  
>  /* BAM CTRL */
> @@ -707,8 +712,15 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>  		unsigned int curr_offset = 0;
>  
>  		do {
> -			if (flags & DMA_PREP_CMD)
> +			if (flags & DMA_PREP_CMD) {
>  				desc->flags |= cpu_to_le16(DESC_FLAG_CMD);
> +				if (bdev->dev_data->bam_pipe_lock) {
> +					if (flags & DMA_PREP_LOCK)
> +						desc->flags |= cpu_to_le16(DESC_FLAG_LOCK);
> +					else if (flags & DMA_PREP_UNLOCK)
> +						desc->flags |= cpu_to_le16(DESC_FLAG_UNLOCK);
> +				}

No else case? you are ignoring the flags passed by user...? This should
return an error...


-- 
~Vinod

