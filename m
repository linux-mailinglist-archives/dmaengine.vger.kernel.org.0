Return-Path: <dmaengine+bounces-4704-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C49A5CA29
	for <lists+dmaengine@lfdr.de>; Tue, 11 Mar 2025 17:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4926A18992E6
	for <lists+dmaengine@lfdr.de>; Tue, 11 Mar 2025 16:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D798825DD06;
	Tue, 11 Mar 2025 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="We0KcTLt"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F30510E5;
	Tue, 11 Mar 2025 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708930; cv=none; b=O4ZkOzaSGrIojRHJSaLJZvW3PmK/3hdgv9jqtXU34LjNSvEP0C10roKlb5fqPt6NpDRi1SecIIVqg9Cq8HzCMzpoV2oZeHEf0HVLdrJak5RybMIQCYMj0dNgfSpB7LaZj/8CFJEYhfE8pW3eTieTjhDcyScV1i6y4adsv6kgE+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708930; c=relaxed/simple;
	bh=pTO0oEqPOMpJ+F6xgXl9453/01qXaTv34Qd/NHTo5js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvCs3xjDfqpDWafi5ERDa7OWVX+MMBlAgcwM5kEb8Efv54m+bH5oR//5yaPxZ0Ifgr4X6SqJ1IbKukfNqdC5QDW0yCNp0cTQ+lbfxNqc4KWbS1RlQ8deWOELJd40B4Rehf/nQKphuk8y/NdtN1PQzDwy+q40Ii0XPzCuZ2dpf1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=We0KcTLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16DDC4CEE9;
	Tue, 11 Mar 2025 16:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741708930;
	bh=pTO0oEqPOMpJ+F6xgXl9453/01qXaTv34Qd/NHTo5js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=We0KcTLtFqa262LOKD5ujKR9E95p2fDi04W/Y0TXcTpqeLNt4dfMPAAth8XBcB2e5
	 VMWfb/PT7/gxp7ZsmPIlgoDFh+l4XN5xXA+sygR0vOMafHCUf3p27UFExXLZjoSiVc
	 Q302Gh5XePHcUi96sERI7Menw8c3Vu0YTB/4iMPQcZOtzQoVmPURsUfxpTIHu+QXgH
	 LAwwXF/k0CkVphtiH1lvYcNKLdbNmre6sSUIOvOzAQGKw+9C0C0qfjyl3YSgE7LyeW
	 s1AHIifRh5Bh1ulrke5IRFYvkKejSTdCrqarARMdZN13O/B0uYf2LI+MJ2PkkNkuPm
	 Gh3GrRe/Y0PvQ==
Date: Tue, 11 Mar 2025 18:02:04 +0200
From: Dmitry Baryshkov <lumag@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thara Gopinath <thara.gopinath@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Md Sadre Alam <quic_mdalam@quicinc.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 3/8] dmaengine: qcom: bam_dma: add bam_pipe_lock flag
 support
Message-ID: <da4u6uceevf264ycemxvutkvmw77z6vlt6td2vtwuz7zm2csqk@4km3vnletgky>
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

On Tue, Mar 11, 2025 at 10:25:34AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Extend the device match data with a flag indicating whether the IP
> supports the BAM lock/unlock feature. Set it to true on BAM IP versions
> 1.4.0 and above.

This is obvious from the patch itself. I think this might be a good
place for the description that you had in patch 1.

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

Should it fail if there is no support for those flags?
Is it an error to set the UNLOCK flag if there was no LOCK set
beforehand?

> +				}
> +			}
>  
>  			desc->addr = cpu_to_le32(sg_dma_address(sg) +
>  						 curr_offset);
> 
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

