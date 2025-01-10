Return-Path: <dmaengine+bounces-4100-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37528A08DAB
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 11:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED0D7A34D7
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB1220B1E7;
	Fri, 10 Jan 2025 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="loLG3CMo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC320ADE6
	for <dmaengine@vger.kernel.org>; Fri, 10 Jan 2025 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504148; cv=none; b=jaKaphXJZminsN+Ov3LcdsFF5eVNhOiC/70972JBc5ZpngDwzjXRea9eGrzMhicI5y52lsXIStMJGcmlLxdSI3o1f8Zez0ruWKiCqhtueoUvZRE8p7Ar0MZ9XCna2/lrwkgJX5/Odxcz+moBFMrPBNJkN2d1vtqoLv4OFrI/03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504148; c=relaxed/simple;
	bh=OG5Slfzzn+4YZ57E3I8Aah1Mfpy3Cxh1SjEqcqb7rMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEK1bNm4UFAG7/bv0jpZTT7DkUXTlAIPlfoQAaB7b6/H+cOyJXWFsy3qB7wJlJ6l0aEmVGPhn+KghFeNimjskXJGGQmCMRfbmRPX/ncn46Tikj2d0889j68qmmcJp8dj8FKVGM1Xcur63kqUlqgDomZG2wbqNNK7N2chBPVfVwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=loLG3CMo; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaf8f0ea963so371112266b.3
        for <dmaengine@vger.kernel.org>; Fri, 10 Jan 2025 02:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736504143; x=1737108943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8I5F2q/E1Uyw0awphW5FocvFmJIVkEVv/Vv7zorOGUY=;
        b=loLG3CMo7Hl/ncnnldCodaVvckSO1hOXgE7NsB7BfPOoe/dmLNMeZVS4WXDPuc7lyr
         om8DkFWMd/7FB9kNjZuGpt96qtyRTao/+Xb/gQbRPUb5aH4/vHu7ejBnaukbCrKsL/OH
         1eIrRhY4hx5niuI/wirw1Ifah0P92g9STnrYkzYpxZ09dGLyrz7ZYEv/89BvbDcDmxRR
         sCXoFpFVTNH2Cs04FYupVm/JuKS7hQg/UOCSKwfPWb6xL+7wuaZmJ0dCRCaQvW9+0+T6
         31xiLMDk9AnqZti0Omlp5j2WQ1TVF/1DB4Kc04EAj/GvCyPCtZVTODUUF42DRz3NJxyv
         LBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504143; x=1737108943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I5F2q/E1Uyw0awphW5FocvFmJIVkEVv/Vv7zorOGUY=;
        b=hkOeceNxx+2KNUeRaaZWLNs7YOjer6jIt0BMJCqXfmR5JdBR819wU3TM761GscGwEY
         953B5biVB95NXKTc4acjGRMvk3n7TCPh8D9wZC2Pe/qrPEgGMUjXeLt9qGniftHt9HkD
         84gWgM0EyksAGaP7I3TSt+a7Ysn3fle0Ch+TjZ77ywNLL/h0/zc0+OcsX7D+cc4SQZRF
         dyMJRqdt6uAUZrKh1yBycCfvtnaR8YyllHUYUdh9msXY5As2h2Ltc2noTcH3VXdooO1R
         u6GHxoywGArkl9pt9TTIxN/UE/5zLHLG/UlsCsT0do4V3GIAIY+Lwlyb3n7SnHny7Btj
         ZNOg==
X-Forwarded-Encrypted: i=1; AJvYcCVQI8Md3O/m8m9pzXgIGEdvbLUFpLanUgB0MpTkWe1OadsUUKsBVbZ4JSLrDoL0mj2F0ljf/kc2fWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBy5PeccpqpGTs32eg5Qx2EKTPVxibSYQ/LoBaDPfSO6hgyt5f
	9xwBiMZw9Bz1cLOv0LklAqXpZ62diNocW+M6WAiIx3o9gLomh+ZZNzMSymAhJ8s=
X-Gm-Gg: ASbGnctWVa3KCrzZ2A8JNtBzY49FnTbIxmUEL3HMSf8pzlDsXtapbStg1X5qDURJ9MN
	SLDChvAeNXi6d4zB37Yn84cIkYrkNdgyODNxz8KVyybryU2WPQ7j/qPF3EFJmXUzsnx3FBa4ReZ
	OsGnl8g5+Sqkuds8nGlRx2gAscICPchaRHmrpF4PLHAUEkDjWCCkj/PovyYLV7VbR8+cSjtBq3Z
	opSk8yBmB5NNSRaT2OuQKZmKGWFQ4eUC9kOmSxkPq7DyF3I9ihyOuQRA3l3c8WLRQJq
X-Google-Smtp-Source: AGHT+IFxOfe+uLe4Ftus+tUMtlwHJqHVL74w+6Tuu37QcKSdGFuUOdk5R49N8KAeZXoV1/5uRbSyeA==
X-Received: by 2002:a17:906:c141:b0:aa6:5eae:7ed6 with SMTP id a640c23a62f3a-ab2ab6a2f04mr761193166b.13.1736504143287;
        Fri, 10 Jan 2025 02:15:43 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:d2b5:f46c:e0e4:a1af])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90d52edsm151801166b.42.2025.01.10.02.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:15:42 -0800 (PST)
Date: Fri, 10 Jan 2025 11:15:38 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: vkoul@kernel.org, ulf.hansson@linaro.org, robin.murphy@arm.com,
	kees@kernel.org, u.kleine-koenig@baylibre.com,
	linux-arm-msm@vger.kernel.org, av2082000@gmail.com,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	djakov@kernel.org, quic_varada@quicinc.com,
	quic_srichara@quicinc.com
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Fix BAM_RIVISON register
 handling
Message-ID: <Z4DzHs0gtbTPxq2_@linaro.org>
References: <20250110051409.4099727-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110051409.4099727-1-quic_mdalam@quicinc.com>

On Fri, Jan 10, 2025 at 10:44:09AM +0530, Md Sadre Alam wrote:
> This patch fixes a bug introduced in the previous commit where the
> BAM_DESC_CNT_TRSHLD register was conditionally written based on BAM-NDP
> mode. Additionally, it addresses an issue where reading the BAM_REVISION
> register hangs if num-ees is not zero. A check has been added to prevent
> this.
> 
> Cc: stable@vger.kernel.org
> Fixes: 57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing unavailable register")
> Reported-by: Georgi Djakov <djakov@kernel.org>
> Link: https://lore.kernel.org/lkml/9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org/
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
>  drivers/dma/qcom/bam_dma.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index c14557efd577..2b88b27f2f91 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -445,11 +445,15 @@ static void bam_reset(struct bam_device *bdev)
>  	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
>  
>  	/* set descriptor threshold, start with 4 bytes */
> -	if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
> -		     BAM_NDP_REVISION_END))
> +	if (!bdev->num_ees && in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
> +				       BAM_NDP_REVISION_END))
>  		writel_relaxed(DEFAULT_CNT_THRSHLD,
>  			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>  
> +	if (bdev->num_ees && !bdev->bam_revision)
> +		writel_relaxed(DEFAULT_CNT_THRSHLD, bam_addr(bdev, 0,
> +							     BAM_DESC_CNT_TRSHLD));
> +
>  	/* Enable default set of h/w workarounds, ie all except BAM_FULL_PIPE */
>  	writel_relaxed(BAM_CNFG_BITS_DEFAULT, bam_addr(bdev, 0, BAM_CNFG_BITS));
>  
> @@ -1006,10 +1010,14 @@ static void bam_apply_new_config(struct bam_chan *bchan,
>  			maxburst = bchan->slave.src_maxburst;
>  		else
>  			maxburst = bchan->slave.dst_maxburst;
> -		if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
> -			     BAM_NDP_REVISION_END))
> +		if (!bdev->num_ees && in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
> +					       BAM_NDP_REVISION_END))
>  			writel_relaxed(maxburst,
>  				       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
> +
> +		if (bdev->num_ees && !bdev->bam_revision)
> +			writel_relaxed(DEFAULT_CNT_THRSHLD, bam_addr(bdev, 0,
> +								     BAM_DESC_CNT_TRSHLD));

I guess you meant writel_relaxed(maxburst, ...) here?

This patch is quite confusing. We shouldn't duplicate the register
writes here just to have different handling for if (bdev->num_ees) and
if (!bdev->num_ees).

Also, num-ees is unrelated to the question if the BAM is BAM-NDP or
BAM-Lite. Typically we specify qcom,num-ees in the device tree for a BAM
if the BAM is either:

 - Controlled remotely (= powered on and initialized outside of Linux)
   This is the case for the SLIMbus BAM Georgi mentioned.

 - Powered remotely (= powered on outside of Linux, but must be
   initialized inside Linux)

Reading BAM_REVISION in these cases will hang in bam_init(), because we
cannot guarantee the BAM is already powered on when the bam_dma driver
is being loaded in Linux. We need to delay reading the register until
the BAM is up.

Given that these writes happen only for the !bdev->controlled_remotely
case, you could fix this more cleanly by reading the BAM revision inside
bam_reset().

Thanks,
Stephan

