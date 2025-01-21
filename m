Return-Path: <dmaengine+bounces-4169-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E842CA17C53
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2025 11:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906B1167D44
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2025 10:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1486F1F0E4B;
	Tue, 21 Jan 2025 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hi3IJUlj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1415A1F0E32
	for <dmaengine@vger.kernel.org>; Tue, 21 Jan 2025 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737456902; cv=none; b=seYHmQnpeIcQZTf08Jvh4haInXVp/rbP8QHBJJu6Xau4ZtQ8z+/B+sPW8Q1V4EkYFKFDvURWiDg+SyYmNgEyipV42MA8IZGwApBl6O73Ej/vpm9Q7wDmJHVbry9PLtOBGjKH3SydJF3efV7M8BJ7HcAOmnckiS5RdCriFjEh4JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737456902; c=relaxed/simple;
	bh=suqN2ZHLOyvnJ0tEJG+a+/bAxC2+XOOpTblkLaQ0/c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFuIeozu0JBDkgVghAZ0kFKzUl1oFztZo2tr4QQG3HeDEnS8vmjU71Tw/0f8t8Gn9BF7sXqoQ4imRxjXCBSUhZrN3C9zHPUhlJecjXkVpp4giNtPwWFqbyBNEfpKeS9D+ODFkCr/4QHlt4dNDHEDTHZMecFVsbjlxujr1dl4QZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hi3IJUlj; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54024ecc33dso5487390e87.0
        for <dmaengine@vger.kernel.org>; Tue, 21 Jan 2025 02:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737456898; x=1738061698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OdPCNN0jYghlYbdGF2QDtzVKgPUcQQH5ilSSdrg5tIs=;
        b=Hi3IJUlj3Nedk5CndIMcLELEtRV17lFVrdvkQmQyZMMP2Ha4XlyK/1jIao6PpknDvS
         QxuK2cNu0AXu28F/YGg1txWElJpT+0sACAWmrPQl43uEYjBYdGAdvHph4E7QjTvQh8bd
         RyuELhcuFHU+6b8I1BYrZr5MwYq30+OjE63WlpzZWJABH6Dt7Y66prFCi6qDhhOSben8
         EngxWFK53G2uBeU6j/M3EO8lion44cwjUxVJLQCdecgUHLzwfT1ewHQo7o3hRJLqMGaC
         nrmUSDDwIm8BT939fdlpw9n8d4/6FwpqwVz+aPb+lnpg/20env/7sVwZyhw4a/dvarsB
         ex+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737456898; x=1738061698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdPCNN0jYghlYbdGF2QDtzVKgPUcQQH5ilSSdrg5tIs=;
        b=Q+GXkBnZbPb+3AcNnl7WMze34klacOJWoc+vWYmgkf0juWR3pftaoQfwuZl2xxeW9m
         /vXHSzlsik9N/Le8A41YV153ZSLEPmgB8ShxoMo9DpWPlv03+2MuWO1wwSHfYQGLlzZQ
         7aaxjQwPXNRO4lnv5JxiNyfpeat8bkss0bkGeC/t1Og0Rd2tRbRRs1rX3kE/y5ovjCEs
         Hg6C/y6XtBwZZns0GQGYvwpyF8sUwCczMra46LDAQsTHhKu2Em476QRKu+QNRsxeVZ3+
         ZwTYGeasLr6v/L5vAWFqRxnOYuZWXAq/yagJ+kHjMZVIrTXVB2G/t13FFhmir3FdD+pY
         OWTg==
X-Forwarded-Encrypted: i=1; AJvYcCV507muzXSAbew34SbfD0btGuA145F1o9UsEqveyJdWFYDWZO+/iiCS0xr09MMJtNxIs/7gj9+CtB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmdE26TnTOcRHICUTiCMquDNiyDnfmCkWE7QWot2fQstZ7dwI8
	nt6L2W1g0XSB3SuBLYoaEKk06RdjZrX6HAr3Sz32T3tfi2xUVGT7DNXaqP/5YJo=
X-Gm-Gg: ASbGncuxsTLxKu13e1yQAnW9VfsreBVnp7RmbpERfUCvcLokOCIUWPwxJs6AYo1A/Xp
	WJbTB9L6wX84gN4FoFjEbo0jK9xlZ18pH1D/4abnVKSxhT1q8JM720ZWugjPOw4AKGpI7weXHoT
	RzlPpo6GJTX+QJYDp2WGwG/qkvusONWpLL9P++XrTJGPYTyq6U4pAnWpB3u2uSt2jRT3Y5xEa32
	Oy7jd2ajOaC3dTnEynM+wweIXS3Fbs5Ue3O8oWUMq8+TYGM5rWMOaj46SIaz4AiFLMGqb8i+F2E
	s/06GQ7xI/0S2D4LghGQap6v2eWHg+pIbCy6Zxmz+ET+b4VzOg==
X-Google-Smtp-Source: AGHT+IFLUhwiFrI3r8Ts8Y2LzxmuODFGe2bP585A/BiMX2EBYDp+GEEGfcOtuoPp/9NtEAw1iqdAKQ==
X-Received: by 2002:a05:6512:4887:b0:542:8da7:242f with SMTP id 2adb3069b0e04-5439c21f218mr4503926e87.10.1737456898023;
        Tue, 21 Jan 2025 02:54:58 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af78c2csm1764126e87.226.2025.01.21.02.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 02:54:57 -0800 (PST)
Date: Tue, 21 Jan 2025 12:54:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: vkoul@kernel.org, kees@kernel.org, fenghua.yu@intel.com, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	djakov@kernel.org, quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: [PATCH v3] dmaengine: qcom: bam_dma: Fix BAM_RIVISON register
 handling
Message-ID: <okiy7n5nvjadbfczmnn2eoxwe36ilug5xutben3rg2nkvpehb5@kr2t4hvidaht>
References: <20250121091241.2646532-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121091241.2646532-1-quic_mdalam@quicinc.com>

On Tue, Jan 21, 2025 at 02:42:41PM +0530, Md Sadre Alam wrote:
> This patch resolves a bug from the previous commit where the

Please check Documentation/process/submitting-patches.rst, 'This
patch...'

> BAM_DESC_CNT_TRSHLD register was conditionally written based on BAM-NDP
> mode. The issue was reading the BAM_REVISION register hanging if num-ees

First start with the issue description, then proceed to the changes
description.

> was not zero, which occurs when the SoCs power on BAM remotely. So the
> BAM_REVISION register read has been moved to inside if condition.

Imperative language, please. While we are at it, please also fix commit
subject.

> 
> Fixes: 57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing unavailable register")
> Reported-by: Georgi Djakov <djakov@kernel.org>
> Link: https://lore.kernel.org/lkml/9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org/
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> 
> Change in [v3]
> 
> * Revised commit details
> 
> Change in [v2]
> 
> * Removed unnecessary if checks.
> * Relocated the BAM_REVISION register read within the if condition.
> 
> Change in [v1]
> 
> * https://lore.kernel.org/lkml/1a5fc7e9-39fe-e527-efc3-1ea990bbb53b@quicinc.com/
> * Posted initial fixup for BAM revision register read handling
>  drivers/dma/qcom/bam_dma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index c14557efd577..d227b4f5b6b9 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -1199,11 +1199,11 @@ static int bam_init(struct bam_device *bdev)
>  	u32 val;
>  
>  	/* read revision and configuration information */

Please extend the comment, mentioning why the register is read only in
!num_ees case. BTW: how do we get revision if num_ees != 0?

> -	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
> -	if (!bdev->num_ees)
> +	if (!bdev->num_ees) {
> +		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
>  		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
> -
> -	bdev->bam_revision = val & REVISION_MASK;
> +		bdev->bam_revision = val & REVISION_MASK;
> +	}
>  
>  	/* check that configured EE is within range */
>  	if (bdev->ee >= bdev->num_ees)
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

