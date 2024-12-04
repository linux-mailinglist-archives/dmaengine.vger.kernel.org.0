Return-Path: <dmaengine+bounces-3879-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A579E3A96
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 13:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E6EB25196
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 12:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36312500CE;
	Wed,  4 Dec 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZ5Odcm0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F512EAE0
	for <dmaengine@vger.kernel.org>; Wed,  4 Dec 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316321; cv=none; b=YuHdkpDrmE/YqkIf+XCtKFa4eezbDVryTamEUPXNYmQU52odft26Q2ijeQuR68/FP77yLdkq89H/Vb9Gy3T8e66hYsl29u67NCse75HwprXBq96t+bzgNqMIEv/Pt+IMbO1FOSduGR0EebffMb2zRKRh2bpLMeY+mQbeNs2Owpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316321; c=relaxed/simple;
	bh=HvLXew/ekNZYNw4+Tzj0GTsu0hLpHjPce/LR5fnETRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msuTQkHOBOsTLN2yjMdg4BQtrWh9wwE3rwe9KA2E/Ws1xiMi+kDlOPr+DefjKnok2wwY3n5lxEZ53pIQf+9Pca1AjQpCZMYeMlkOYlrBPsLCNRGOQRF/Zyky0+FdT+CUjzC/WBMB+uN9kWvQhsep654M+nYxH62efJ+TqJU4tZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OZ5Odcm0; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53df1d1b6e8so6793551e87.1
        for <dmaengine@vger.kernel.org>; Wed, 04 Dec 2024 04:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733316318; x=1733921118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WTp0TBvwsa7+s4hy1diR7pekA2iSgGBReO3LOvUKkxQ=;
        b=OZ5Odcm0kIlvs4fsY9zfhvSyf3ObiQ08uglgV60jmdkMoXJ0rejitZh6jFlFBuBnzO
         VnYkF2AMcXOda+qtGz2wWqtq/alc0BblaYkl40YvpVRACFtGzl3XgerRi4Z9ZB2O+e2/
         /WvwX8kG7MABjUKgNA24JlsyY2dAjjl793nTGSV6TOO1Cl30245KO2fEUeZNnYVOjQlZ
         65+c1gAF1+gHAD74LFyX/mOiqWsIUlk/UYcgiqBNksXo6JEziK4/sXhp/WUB1/o2/kZx
         Y0odP8YfvpF8U16hsSgohh3MTm+YSh/Zhpv3MX0harJG5avVAq+nbQD5vX4ZN/QaqjOI
         wKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316318; x=1733921118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTp0TBvwsa7+s4hy1diR7pekA2iSgGBReO3LOvUKkxQ=;
        b=NLBsT+tYqlbiBRGnhtDbZstU20ihAm0mUbvUgBoeSufjoSimImXPZ3OkOXO71UYdHD
         UcVj3Oe5lWy+FQSS0TCUDl20/7EhfPzrqHv3mvD3xJdL+Ei9VhFEcwM+JKH0AXRA6NQz
         bodQxQKIsYWFnvKpgBkFYIFE6BB1uQTaUUwsr/03Qcp8LGIu6opL9qliKmYo6d6Am5FC
         PSkX75bBgsN+YNQLvI+wTDS/a9AY25CkX5T05RquPMAyMGQqoPOlUYOmn59oowijeMh1
         iOB/f05Orw/E8/hsFEaXYbJw+K4oOVxvb/jTQzZ1FHgmBFUdpSquUgIzHx6up/tOJr9N
         4fyw==
X-Forwarded-Encrypted: i=1; AJvYcCV3jct54CsxgOdZPaLl0l7q0yTNZ7AsWd8ScSG+qxzQCCy1+7wrYsjc95Op5hNRrVVUFJZU8Pz7nKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSeeFiOZBiVQY7VlB9Nt+QSEWF7qF0knbr2Rb2LO6eFeZhTULe
	NjRtmKza0B3f2rHiNAMFsBs71umM7KiA/nNIvKv+yEALy4ESMlYSoPkUPtDiDGw=
X-Gm-Gg: ASbGncthyJSJcomrXc6BaEILcX8J08xstvRe3Tx+D1XEwHgK9VcKUrUDojRNdBRa3+I
	ucXzkPuOPA8X4u70cRbaPrkiWYthVjhOizfnC8rbuOEvChetRVBWTSn0PNzP2dyl3uC28Ux6i4p
	18xj05J9sInHznueTYiR+V/6nPCeMMXRtdte4uyKdb8wHZtA+FsfjEYZQZq0wrccO3sr57fhwQU
	F414lpVlDrFdeZyvvUSkVkbLBtYi4n8ehcJilsiDb9OBqTdUrkXBZ23E/ZbmLa22BS3zByWqAu1
	uA7+4dpTX19894lIRCHkIAuK55hnfg==
X-Google-Smtp-Source: AGHT+IH0r+x2jrOlaIXcqF4xiCo9+ErTtCXYbj7uwSRx6lcnQBk1/ALdLJelIohTiEnYb6ScgPxCSg==
X-Received: by 2002:a05:6512:3d18:b0:53d:a2b5:d8b9 with SMTP id 2adb3069b0e04-53e1b898282mr1393294e87.34.1733316317683;
        Wed, 04 Dec 2024 04:45:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e16b169f7sm501102e87.16.2024.12.04.04.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 04:45:16 -0800 (PST)
Date: Wed, 4 Dec 2024 14:45:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com, 
	quic_vtanuku@quicinc.com
Subject: Re: [PATCH v3] dmaengine: qcom: gpi: Add GPI immediate DMA support
 for SPI protocol
Message-ID: <higpzg6b4e66zpykuu3wlcmaxzplzz3qasoycfytidunp7yqbn@nunjmucxkjbe>
References: <20241204122059.24239-1-quic_jseerapu@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204122059.24239-1-quic_jseerapu@quicinc.com>

On Wed, Dec 04, 2024 at 05:50:59PM +0530, Jyothi Kumar Seerapu wrote:
> The DMA TRE(Transfer ring element) buffer contains the DMA
> buffer address. Accessing data from this address can cause
> significant delays in SPI transfers, which can be mitigated to
> some extent by utilizing immediate DMA support.
> 
> QCOM GPI DMA hardware supports an immediate DMA feature for data
> up to 8 bytes, storing the data directly in the DMA TRE buffer
> instead of the DMA buffer address. This enhancement enables faster
> SPI data transfers.
> 
> This optimization reduces the average transfer time from 25 us to
> 16 us for a single SPI transfer of 8 bytes length, with a clock
> frequency of 50 MHz.
> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---
> 
> v2-> v3:
>    - When to enable Immediate DMA support, control is moved to GPI driver
>      from SPI driver. 
>    - Optimizations are done in GPI driver related to immediate dma changes.
>    - Removed the immediate dma supported changes in qcom-gpi-dma.h file
>      and handled in GPI driver. 
> 
>    Link to v2: 
> 	https://lore.kernel.org/all/20241128133351.24593-2-quic_jseerapu@quicinc.com/
> 	https://lore.kernel.org/all/20241128133351.24593-3-quic_jseerapu@quicinc.com/ 
> 
> v1 -> v2:
>    - Separated the patches to dmaengine and spi subsystems
>    - Removed the changes which are not required for this feature from
>      qcom-gpi-dma.h file.
>    - Removed the type conversions used in gpi_create_spi_tre.
>   
>    Link to v1:
> 	https://lore.kernel.org/lkml/20241121115201.2191-2-quic_jseerapu@quicinc.com/ 
> 
>  drivers/dma/qcom/gpi.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 52a7c8f2498f..35451d5a81f7 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -27,6 +27,7 @@
>  #define TRE_FLAGS_IEOT		BIT(9)
>  #define TRE_FLAGS_BEI		BIT(10)
>  #define TRE_FLAGS_LINK		BIT(11)
> +#define TRE_FLAGS_IMMEDIATE_DMA	BIT(16)
>  #define TRE_FLAGS_TYPE		GENMASK(23, 16)
>  
>  /* SPI CONFIG0 WD0 */
> @@ -64,6 +65,7 @@
>  
>  /* DMA TRE */
>  #define TRE_DMA_LEN		GENMASK(23, 0)
> +#define TRE_DMA_IMMEDIATE_LEN	GENMASK(3, 0)
>  
>  /* Register offsets from gpi-top */
>  #define GPII_n_CH_k_CNTXT_0_OFFS(n, k)	(0x20000 + (0x4000 * (n)) + (0x80 * (k)))
> @@ -1711,6 +1713,8 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>  	dma_addr_t address;
>  	struct gpi_tre *tre;
>  	unsigned int i;
> +	int len;
> +	u8 immediate_dma;
>  
>  	/* first create config tre if applicable */
>  	if (direction == DMA_MEM_TO_DEV && spi->set_config) {
> @@ -1763,14 +1767,32 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>  	tre_idx++;
>  
>  	address = sg_dma_address(sgl);
> -	tre->dword[0] = lower_32_bits(address);
> -	tre->dword[1] = upper_32_bits(address);
> +	len = sg_dma_len(sgl);
>  
> -	tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
> +	immediate_dma = (direction == DMA_MEM_TO_DEV) && len <= 2 * sizeof(tre->dword[0]);

inline this condition, remove extra brackets and split the line after &&.

> +
> +	/* Support Immediate dma for write transfers for data length up to 8 bytes */
> +	if (immediate_dma) {
> +		/*
> +		 * For Immediate dma, data length may not always be length of 8 bytes,
> +		 * it can be length less than 8, hence initialize both dword's with 0
> +		 */
> +		tre->dword[0] = 0;
> +		tre->dword[1] = 0;
> +		memcpy(&tre->dword[0], sg_virt(sgl), len);
> +
> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);
> +	} else {
> +		tre->dword[0] = lower_32_bits(address);
> +		tre->dword[1] = upper_32_bits(address);
> +
> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_LEN);
> +	}
>  
>  	tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
> -	if (direction == DMA_MEM_TO_DEV)
> -		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
> +	tre->dword[3] |= u32_encode_bits(!!immediate_dma, TRE_FLAGS_IMMEDIATE_DMA);
> +	tre->dword[3] |= u32_encode_bits(!!(direction == DMA_MEM_TO_DEV),
> +					 TRE_FLAGS_IEOT);
>  
>  	for (i = 0; i < tre_idx; i++)
>  		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

