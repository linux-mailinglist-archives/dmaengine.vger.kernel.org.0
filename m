Return-Path: <dmaengine+bounces-4358-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA4DA2D9FC
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2025 01:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435953A5F29
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2025 00:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A1AA48;
	Sun,  9 Feb 2025 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="olwVLODN"
X-Original-To: dmaengine@vger.kernel.org
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C6F1FAA;
	Sun,  9 Feb 2025 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.177.23.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739061027; cv=none; b=pjf851Dj5TcImaHbbv9ZOsGVVm8QZzdOcXUssLP+mOgDXASUahW2LFdWvOtUbHWl4vlVw63n0FvPNUGjhacktkZ4byyhlffShqJ8O+2EC6quXHdQnXQzhSpyp2CpIsl2pCJ6lIhN+MoN0EMANWueM1GvdG1fSUjkF5sFsMez7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739061027; c=relaxed/simple;
	bh=uYjUoicn0RZevWWMG0EWbqoMvEJWmhTl/k34JO1Hwf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArvoOHwApbhIy60GRSpwCzhDVxJ6X8wQj5TKKt5zfTfO/Bh+48XEJSu0HkXSuLPG8KMZJKyVyxJGoYHFi6ckq5qdfzZxRz1iRYGhaLbNugtqFENQvSyO05BvXLOO4emqpatKlwQuZjbDOyWzUlGzMdZxbPT3Ys0PRZ270EBVJTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=olwVLODN; arc=none smtp.client-ip=89.177.23.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from [10.0.0.200] (unknown [10.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 945F6166630;
	Sun,  9 Feb 2025 01:23:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1739060592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HrVabAyIl6ZLLss+NfryXD+BO0Gy6+L829e7ZC91LjU=;
	b=olwVLODNfQkjZeHbluCO5C8PFixESlheVU+gArgBZN2YxtCzuHclPrjTVImS2/xcJSJBbf
	a41TGfofiHyFNM4qdaIemGNAe8poEGQsNtvaGkv72PapAOFzKjG5aCZ2+dgn/I++yI/0so
	E7zZy3ErsZzlbfYY48d3ZscBk/iPemA=
Message-ID: <cbca0f26-1f3d-47d4-8011-5f2513a4b08c@ixit.cz>
Date: Sun, 9 Feb 2025 01:23:12 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] Revert "dmaengine: qcom: bam_dma: Avoid writing
 unavailable register"
To: Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Amit Vadhavana <av2082000@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Kees Cook <kees@kernel.org>,
 Md Sadre Alam <quic_mdalam@quicinc.com>, Robin Murphy
 <robin.murphy@arm.com>, Vinod Koul <vkoul@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250208223112.142567-1-caleb.connolly@linaro.org>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20250208223112.142567-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Fixes initial boot crash into QCOM Crashdump.

Tested-by: David Heidelberg <david@ixit.cz>

On 08/02/2025 23:30, Caleb Connolly wrote:
> This commit causes a hard crash on sdm845 and likely other platforms.
> Revert it until a proper fix is found.
> 
> This reverts commit 57a7138d0627309d469719f1845d2778c251f358.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
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
David Heidelberg


