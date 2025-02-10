Return-Path: <dmaengine+bounces-4381-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62BAA2EB7A
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 12:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951913A1E44
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 11:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6907E1DFE3A;
	Mon, 10 Feb 2025 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJeHZuiF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743171E376E
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187563; cv=none; b=uxGOU/Qy4CE/Bs51YwB8gOZdRSOC6duAVjDOO3JvDUF1fZszvjXq2OKETvo2ao4oP7+Uy1ErXBGDJF6zVqZyd6WL7Rn2zL9OYnaeYNDpoC9bLTwwuF8mlLeckNlqMyRckOjif7Dg26glDICitZZX8R95B53conu00bvcXEZcGt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187563; c=relaxed/simple;
	bh=3gWCjUdrhEX5o1hKIRRVUTniivb3NGT2sSazolj94l0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iCqNxDYl0wfRuPIwLBp1GlEvP3q4lj+FY9k5jk1gpOf9tHzh4ak4uiKdpfmNdHWu/4QgRXTWcTMBy4zQyrmh+HSbmYXLRmfKeqHMxSOXA3lGOTCaH7m2GijbQZiIl9Z4a/q359m3PY8vE1jC3Ndtqw0uY59eYpUsw3rTaJCm29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CJeHZuiF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dd14c99c3so1137418f8f.3
        for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 03:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739187560; x=1739792360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdyKhWNG/YV+fyvzEZfQRru8urZE6HyQB3qAUgMoUvM=;
        b=CJeHZuiFrPuXkIFLMe5bzHB218M6zjuW0wEF/1URPNN8Pj3aFGu+vnLbBZzRwxJ8cy
         6VZ4qq1ShLKEPxWUlv+lFo8fDwk+Npjj2/uTtEBz3q63m8F1rgS0372AIBPf/m2h2Lux
         89vMzWIzDzOK0V3utQmhRvHOed+nEP9Bg5tTfVUUaGSV2yyNhfJswNjs5epZZVJq8LvT
         uuLXEL6tqYU8zlRTcUXe+gb5gkyCQBc7ppYLEirO6P/9KZKfF7231wcbqCK38IU6vV89
         AhWeyOMQCJWfAGqgH8KGMGqjfu4y0TKH07eskuqWotCZzLknPrApSw58XCUlpfmnHdJv
         tg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739187560; x=1739792360;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HdyKhWNG/YV+fyvzEZfQRru8urZE6HyQB3qAUgMoUvM=;
        b=w1Ags2gbjIQYSYs3pa7SA1y5GZ/pGi1vuQr/fP7Y81m+fm/YABZdhWvwWUfWR0vFXI
         ybSy2288yHrk1qwLpaJsEDf3vmocDsQVJsI0VNnRQylHMKBIRI8T5U0VzSuSed7agVEO
         jq8FtZEWoV5BAKrgSk1CeodMAGGSuhqqZreu3Z7u8aJCzJJs575YhySqWSuwybTtJthI
         w0nEJsqI2l06YjIH5i0e2QLfcpMD044A0fa2CbzroSzjV0XUnhCs83dzMWXpvxkT8cv8
         I3Summh9YrxVL5cprFhTAgm47abgdZV5oTH7362jipHyh0ZqunEsTHb+kHjuy+werqXr
         TIeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaBV8nz8+akT0tHijtvhbK3Hg23uRalJ+7/ZtP1zk4hAwd8fDeGjh0lYHdU6oPhbtcdsoT8a9aNu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3JtTytqs3QJbQ97TbonI6E9nfwedIu2L05SknQFuTNJB88jVW
	HYEX8zAgypQTHg2b/urnWz0+6WgREZ8AKMm5rKiO5PhejNg0V8/qqrayiwSstlQ=
X-Gm-Gg: ASbGnctlQ464yok51fD80yhTI1EINJol9tKsQ+gWQ1JVAbKpKdi9gVjwsct67IhahjA
	vTtG4XD8JCb3s2mvfp5gSyi/KjvtliAUxZlT6ZQ+NTuP1sHq4PrrRbzEZBCXCDC8A9gk6QhemAG
	3qvrZnQhcTCErF6xS5yb4m1Dz109bnADi+Y/I8Z0SbAa3MGVX3nwI1WFZXR12cITr6pGESrcLz6
	FptyI+uPEWCWWwqP3l+xsNmHX4Z6Hk4nM9FWEijdAsxtZjOXm9zHKEZkWJ4hdDJ4AiURiFwBhCC
	5xfLAPtqu9HvaQ8oX93xn2r9QeBX75sFrEpF/+4shxQ37IK3R6Q5fG7EH6uM98FLLzSA
X-Google-Smtp-Source: AGHT+IGhf9lS3crLEoNLUnBANd1l1OnXNNmmhTax0NZR8qnDFb0O9+hRSYiZbS083bbEEChIcHAjXA==
X-Received: by 2002:a05:6000:4009:b0:38d:be2c:2f5 with SMTP id ffacd0b85a97d-38dc8dc3a56mr7631659f8f.6.1739187559686;
        Mon, 10 Feb 2025 03:39:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8235:1ea0:1a75:c4d5? ([2a01:e0a:982:cbb0:8235:1ea0:1a75:c4d5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc4d00645sm10937178f8f.66.2025.02.10.03.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 03:39:19 -0800 (PST)
Message-ID: <d1a1c179-664c-48af-baa1-2c8329575174@linaro.org>
Date: Mon, 10 Feb 2025 12:39:18 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] Revert "dmaengine: qcom: bam_dma: Avoid writing
 unavailable register"
To: Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Amit Vadhavana <av2082000@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Kees Cook <kees@kernel.org>,
 Md Sadre Alam <quic_mdalam@quicinc.com>, Robin Murphy
 <robin.murphy@arm.com>, Vinod Koul <vkoul@kernel.org>
Cc: David Heidelberg <david@ixit.cz>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dmaengine@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20250208223112.142567-1-caleb.connolly@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250208223112.142567-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

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

This fixes the BAM DMA crash happening on DB845c & ifc6410.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on sdm845-DB845c
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on apq8064-ifc6410

CI: https://git.codelinaro.org/linaro/qcomlt/ci/staging/linux/-/pipelines/131277

Thanks,
Neil

