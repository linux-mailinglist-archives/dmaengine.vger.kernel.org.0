Return-Path: <dmaengine+bounces-4356-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6EAA2D953
	for <lists+dmaengine@lfdr.de>; Sat,  8 Feb 2025 23:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A223616674D
	for <lists+dmaengine@lfdr.de>; Sat,  8 Feb 2025 22:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51731F2B88;
	Sat,  8 Feb 2025 22:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fBqCZJWq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55411F2B86
	for <dmaengine@vger.kernel.org>; Sat,  8 Feb 2025 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739054017; cv=none; b=mUnNTOO/Exbm5gh+mRSb87uAhMEy84DHvBdcQ0YNzwvT9jcGWkCvpYDJHRxWG7A/vEr4MPbaeicKd077/up6ctdtTYIfmk8/Ta2a6DN47XXHpxT5Rnp0XXsV79LylFyh41G7L41SrQeIoHlcbd8DJ29KUKdIs58E7vpRT56/Guo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739054017; c=relaxed/simple;
	bh=9R9+GjbfgtWDzIqo04bvXnOwtBS/PkbYk1UtsJ2vBYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mqr7A+EHMzBRNaV7hRSS7kK1ynQaqtsBMpaG3MamxwlwQsA/vUeNjFEb9K0DvgnpVILmnwn1Rv6+vNksm1EEOxfIDyWMYbbizI1lIHFXWafwnjL5f0XmFOyv5rGlnz2N705OVlYBExST6lxxvgq/iLj6/aqSitHTgv5Y3Vmsk6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fBqCZJWq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38dd14c99d3so951091f8f.3
        for <dmaengine@vger.kernel.org>; Sat, 08 Feb 2025 14:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739054014; x=1739658814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mmCZoALgTPKPGHinlcl5J6z2VMpBdw6SS/bK8xvteAg=;
        b=fBqCZJWqqxf+/MOZl2R39iTj9zBgj7pRLOgvKzzhpD7YBxjLTm6u8LjXYYRnOET+CJ
         ZRBzUD27rrChPi4URs0u9F5QiRteutHe7WK4nAltSiYciX1Fbcu5ezOVoPhZI/AkAVnx
         CYuTD8oL1+DkbY8PWzLfBPAMiXhNb1fMDZgmaLD2QQLuNRWQ04p28+3M/GQZR9a0UHqj
         gacBa8VZFGE0efw1brIyl+hKOA802bW4Jltwo/3/Zd3l2N79KPG43WIuJ669iIv0Niy/
         zIKY1cIU9C9jcvp4p+Wpf2E+PxEMtwEheDs/LaXAwWbQ1P28PKMavzmTXyKvjHAhufTU
         rb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739054014; x=1739658814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmCZoALgTPKPGHinlcl5J6z2VMpBdw6SS/bK8xvteAg=;
        b=WfW0cHPiOeJiSQMIXfmKZ1VLJLaspSy/Xzrp8o8ASLih5D1pzuO4pRPnWhZIiibfnb
         zlyA0BrHh4LrHw5IY3ujcDJeTQf+q7yM57pdZ66darPpXp+DZZoEM1Yl1BogCz9DTh8E
         lSH/BdmCuMpH1kvuSafpCC/WOARnHgIVnKbygKcVPtq01aAyMwALc+ggQyKYVPQ+l/kg
         7N8NLm4MIal01bMOl2AcVlTmeyg7L8ZNRaKaZT7C0aHZc1lroOC77vRmw1zTFKST/ZRM
         3hfho7QuhvvDaKImWpt+rqMYH0MAKcCYi9LrfAtiWCVcTWXTaqrG55TTvKu1a5rvYZty
         Sqkw==
X-Forwarded-Encrypted: i=1; AJvYcCVcIFLsHZXugmPkcF03lL3HVBtQG/+q4yzn4CCNWB7Sg8tOT200CmzBoKWGVCPLkFpN58UbZ9hO/dA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY0kIHhhs0+nFJLn7NDZt4bVV2VKD1FdR1hQ205oqkX4zFJpRy
	5nm8oPQSgBowc/vPMSQf9cFnlLQis/lJhg+8XdIVS30qO0ipW7bOVUT+WOQFIMk=
X-Gm-Gg: ASbGncvF+UGZ2LtX/3rBYOd3lZTJv4m8hHHRST0485nzVNspf6KQE7zIKv1Lf/Jml48
	XvRvWVCuOIvK1VyFw/W8OkniNxngCu0TTRBfdaCGl8eq/y7qvlD5Ep5BheiBISFaMlumedZT4R+
	R3c6qLnW/RYPoVazbWLocj9SdWwaWBN844+ZHjyf4jJ4xrB4yQ1J2t2nauDAmxmGZxdqz/5Qe3L
	T92prj5rQC/PksRovj+l4lWGsoZIQZkVky99zSx0hD7kNwR7RMEM3eqm8iIyzJVJMMGpDo59pD1
	kEYhw7yP2d7FNzmMz7qu6l6FHfxW7I/MhK8Phnkup+vHZCo1VNQrc4zr+W5godHC+HDU66nc
X-Google-Smtp-Source: AGHT+IGRCV0aWm6VAHZJx5pGErputBzVkT9c+hC8hv+9pts8L//MC9dbIDaZeqQInA4bKCE7dLkvNg==
X-Received: by 2002:a5d:6d0d:0:b0:38d:c087:98d5 with SMTP id ffacd0b85a97d-38dc8da6713mr6711150f8f.8.1739054014231;
        Sat, 08 Feb 2025 14:33:34 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:ce4f:b99d:6477:b544? ([2a0a:ef40:1d11:ab01:ce4f:b99d:6477:b544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d94d40csm131833045e9.9.2025.02.08.14.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2025 14:33:32 -0800 (PST)
Message-ID: <818caf8e-6eb5-4af2-ab45-644f063e9b1f@linaro.org>
Date: Sat, 8 Feb 2025 22:33:31 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "dmaengine: qcom: bam_dma: Avoid writing
 unavailable register"
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Amit Vadhavana <av2082000@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
 Kees Cook <kees@kernel.org>, Md Sadre Alam <quic_mdalam@quicinc.com>,
 Robin Murphy <robin.murphy@arm.com>, Vinod Koul <vkoul@kernel.org>
Cc: David Heidelberg <david@ixit.cz>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dmaengine@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20250208223112.142567-1-caleb.connolly@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250208223112.142567-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/8/25 22:30, Caleb Connolly wrote:
> This commit causes a hard crash on sdm845 and likely other platforms.
> Revert it until a proper fix is found.
> 
> This reverts commit 57a7138d0627309d469719f1845d2778c251f358.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Missing fixes tag

Fixes: 57a7138d0627 (dmaengine: qcom: bam_dma: Avoid writing unavailable 
register)
> ---
>   drivers/dma/qcom/bam_dma.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index c14557efd577..bbc3276992bb 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -58,11 +58,8 @@ struct bam_desc_hw {
>   #define DESC_FLAG_EOB BIT(13)
>   #define DESC_FLAG_NWD BIT(12)
>   #define DESC_FLAG_CMD BIT(11)
>   
> -#define BAM_NDP_REVISION_START	0x20
> -#define BAM_NDP_REVISION_END	0x27
> -
>   struct bam_async_desc {
>   	struct virt_dma_desc vd;
>   
>   	u32 num_desc;
> @@ -400,9 +397,8 @@ struct bam_device {
>   	int irq;
>   
>   	/* dma start transaction tasklet */
>   	struct tasklet_struct task;
> -	u32 bam_revision;
>   };
>   
>   /**
>    * bam_addr - returns BAM register address
> @@ -444,12 +440,10 @@ static void bam_reset(struct bam_device *bdev)
>   	val |= BAM_EN;
>   	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
>   
>   	/* set descriptor threshold, start with 4 bytes */
> -	if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
> -		     BAM_NDP_REVISION_END))
> -		writel_relaxed(DEFAULT_CNT_THRSHLD,
> -			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
> +	writel_relaxed(DEFAULT_CNT_THRSHLD,
> +			bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>   
>   	/* Enable default set of h/w workarounds, ie all except BAM_FULL_PIPE */
>   	writel_relaxed(BAM_CNFG_BITS_DEFAULT, bam_addr(bdev, 0, BAM_CNFG_BITS));
>   
> @@ -1005,12 +999,11 @@ static void bam_apply_new_config(struct bam_chan *bchan,
>   		if (dir == DMA_DEV_TO_MEM)
>   			maxburst = bchan->slave.src_maxburst;
>   		else
>   			maxburst = bchan->slave.dst_maxburst;
> -		if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
> -			     BAM_NDP_REVISION_END))
> -			writel_relaxed(maxburst,
> -				       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
> +
> +		writel_relaxed(maxburst,
> +			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>   	}
>   
>   	bchan->reconfigure = 0;
>   }
> @@ -1198,13 +1191,12 @@ static int bam_init(struct bam_device *bdev)
>   {
>   	u32 val;
>   
>   	/* read revision and configuration information */
> -	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
> -	if (!bdev->num_ees)
> +	if (!bdev->num_ees) {
> +		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
>   		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
> -
> -	bdev->bam_revision = val & REVISION_MASK;
> +	}
>   
>   	/* check that configured EE is within range */
>   	if (bdev->ee >= bdev->num_ees)
>   		return -EINVAL;

-- 
Caleb (they/them)


