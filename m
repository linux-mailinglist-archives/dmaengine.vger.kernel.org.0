Return-Path: <dmaengine+bounces-4101-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B011A08E04
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 11:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D77A3A63E7
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 10:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4CB20B1F2;
	Fri, 10 Jan 2025 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="af8bFHwU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB09F20ADFE
	for <dmaengine@vger.kernel.org>; Fri, 10 Jan 2025 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504982; cv=none; b=KUmrUY2pYxIDx16gUievwm1Db0Q4oV/kcv3WBEKbYT7lnQ+qAlVsAitnj2lIk1ZDJqexk2yYI/GsmPwVzkhUx6Nn2CVp74y2l3/hi+/6F5E0zVWZHpTyiSpgGZaqFMLdD2CAE23EifadLRuEBPeXkaM8yq5oLAvy1Em+mTOwlE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504982; c=relaxed/simple;
	bh=mT7hLXo0OAyRVomNCCOY75eOUAVIlmDmdMbe5y8doQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwnjtErrXK7AG1cAkBAi6OSL5ES1kg7rZ73ncSYIQPMR0ylAhlnfK9mmiDe62rJNkoKAvbjj04boqK5KVyWQ29r5yQf8/NPMZWul0qZGWXSYjBjB3lHd2J9AmCFA5x4vq6Dt6n/ptBNGfev1YOQ+sJcwLtrSApok+qOc78Vifi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=af8bFHwU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso317140566b.1
        for <dmaengine@vger.kernel.org>; Fri, 10 Jan 2025 02:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736504979; x=1737109779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DFXbwysOSLDtoIDrz04DXm6/Zw3SDx6zPfwlh2JFNx8=;
        b=af8bFHwUXyGfmfD+Kho3wnX3TXq2rrs58CFph7XdDrjR+t+EELx0nljulcIm+oEZx5
         3OJjv9xD2mLvJDk5Yk/tRLdUrfCQmJijQ7Azd7wfy4SXJP5ecAZR4G7xxRsmV5adfCHV
         tKKugtx7Q//00d2ps7HSzl+2ncM70umvKFByCUEjQfAKGEFKw91O4W7IE+4gaEgIf/wz
         WYWB/Syn93uUey4nSno/Y6ZVUhfj6ZwnQiVtLU3bwvCTLAm9CPDiXHDg5sNPcRdm2IO7
         KbyZpu/oOxpK0IclTk6Hye39UMhEYOxtsc5SkhIvSKTm0wXY/kiuccblBB5RGkgxJgqF
         C8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504979; x=1737109779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFXbwysOSLDtoIDrz04DXm6/Zw3SDx6zPfwlh2JFNx8=;
        b=b0VbGcG11fqUOtHbYbYBpv0q28jaBg1DnsTp7+wLWaMAS7auLPSEHVS6onzeAsoj6e
         yH1KT5LKzjbtw1j6gYJHDUYQ4bpQVfzcX4Lzq3TPejvQpGWmmpxcgpv2ZnUc4ZjViMXv
         Ut3KUXwhBVKdyuSb+UL2FICQux7Jp0y63XJMaBpy04IgJUPJ79AldjF0ySMMLj3ubHZu
         apB/jceNp0jJNV+IhacdrQpBGSEb6Mvq7VJkUTZxp2ybButg3uWCGrb25T9Y9fKttcSU
         ND0PH84ta15LdfzCS6IM9e1pSwxe09Di8G5fGRTLgLHJy1jEzYrl8igCM+Sdkav85nXK
         aC9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvCCGaZFOXupNgEfYmcRNkYZGg9EkdiBWVxG9GAct9JnIbV8vaAU5KaX2evupikuU/WSHP9aEfaxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziFPWKLVAorzRN9FlrwDBpWtgT8aWFmTuuOGp4X1Avboyrwnzq
	FOkU8RlPKu9N8EN21GZ2vzrDjan29SbCpvEZZ2UN1l879VWNBTv7NsDcoHTQJ+w=
X-Gm-Gg: ASbGncvNSd0DhwMijtpypT2BjlnJJAZeFWxIypUMaODQhafclarmBeyXhe7TSTExj1s
	ASKAzywH7Ox/O2m9ujtdZC63ICNyBehD3h7kpdTNmit80olOQCFvQUHYibkzX7KEWqifp7W57wK
	TvypC9+xP+i+AYdT38w5Vt9jfj1+p1/vTOMGpYnGzI17seirnyhNX87q6bOM+XLEOMKRLHn2I5y
	Yn2KuD0e30E02xDCv8lEoO5YxKzsPY/7Wgowz4V8JbRIEr/R+bEt6/AWvZ1YRSeo1Db
X-Google-Smtp-Source: AGHT+IFMqpCwcqX2sHs5/lhB+pWcvO3m7YKVkr7BbL4UklMWafwFeJcgHUkq0HgfG2Fc/USROn7i9g==
X-Received: by 2002:a17:907:72cf:b0:aa6:a33c:70a7 with SMTP id a640c23a62f3a-ab2abc8ecb1mr84005266b.49.1736504979103;
        Fri, 10 Jan 2025 02:29:39 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:d2b5:f46c:e0e4:a1af])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c96468afsm153806366b.170.2025.01.10.02.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:29:38 -0800 (PST)
Date: Fri, 10 Jan 2025 11:29:33 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: vkoul@kernel.org, robin.murphy@arm.com, u.kleine-koenig@baylibre.com,
	martin.petersen@oracle.com, fenghua.yu@intel.com,
	av2082000@gmail.com, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_mmanikan@quicinc.com, quic_srichara@quicinc.com,
	quic_varada@quicinc.com
Subject: Re: [PATCH v4] dmaengine: qcom: bam_dma: Avoid writing unavailable
 register
Message-ID: <Z4D2jQNNW94qGIlv@linaro.org>
References: <20241220094203.3510335-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220094203.3510335-1-quic_mdalam@quicinc.com>

On Fri, Dec 20, 2024 at 03:12:03PM +0530, Md Sadre Alam wrote:
> Avoid writing unavailable register in BAM-Lite mode.
> BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
> mode. Its only available in BAM-NDP mode. So only write
> this register for clients who is using BAM-NDP.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

What are we actually fixing here? Which platform is affected? Is there a
crash, reset, or incorrect behavior?

We have had this code for years without reported issues, with both
BAM-NDP and BAM-Lite instances. The register documentation on APQ8016E
documents the BAM_DESC_CNT_TRSHLD register even for the BAM-Lite
instance. There is a comment that it doesn't apply to BAM-Lite, but I
would expect the written value just ends up being ignored in that case.

Also, there is not just BAM-NDP and BAM-Lite, but also plain "BAM". What
about that one? Should we write to BAM_DESC_CNT_TRSHLD?

> ---
> Change in [v4]
> 
> * Added in_range() macro
> 
> Change in [v3]
> 
> * Removed BAM_LITE macro
> 
> * Updated commit message
> 
> * Adjusted if condition check
> 
> * Renamed BAM-NDP macro to BAM_NDP_REVISION_START and
>    BAM_NDP_REVISION_END
> 
> Change in [v2]
> 
> * Replace 0xff with REVISION_MASK in the statement
>    bdev->bam_revision = val & REVISION_MASK
> 
> Change in [v1]
> 
> * Added initial patch
> 
>  drivers/dma/qcom/bam_dma.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index bbc3276992bb..c14557efd577 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -59,6 +59,9 @@ struct bam_desc_hw {
>  #define DESC_FLAG_NWD BIT(12)
>  #define DESC_FLAG_CMD BIT(11)
>  
> +#define BAM_NDP_REVISION_START	0x20
> +#define BAM_NDP_REVISION_END	0x27
> +

Are you sure this covers all SoCs we support upstream? If one of the
older or newer supported SoCs uses a value outside of this range, it
will now be missing the register write.

Thanks,
Stephan

