Return-Path: <dmaengine+bounces-3816-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED159DB938
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 15:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7792281708
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A541AB6F1;
	Thu, 28 Nov 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2/C9GvZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205EF145A0F
	for <dmaengine@vger.kernel.org>; Thu, 28 Nov 2024 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732802833; cv=none; b=C6fiEt3cahLhwYi9GUKgUjIdMw6Y3K/q6UenNpq1iHom6cviWg9khUboD4GJgCLsK1cDF9l8Dy5hOn6vRa+kyu1eTdCKCsQSV5tvkhaxUuoWGYq1Dvsi4UQsu1xp6G144qx6GfcwOVVOTuGNoxno4rxTmcC7VHCPIMpH3i4qJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732802833; c=relaxed/simple;
	bh=pT5jSZqDvkrdjh+q3rMAuuDFxNI3q0d0Yr08Mj3Z93g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stnHarMPGrOJoVbE2decnpBtryRkI7xPDBb8SDUoM6xaxvT+B++OMKOmQ7nSZXgL/B1LcRbOUN8Cys2XUin7IJW+UOXJf+1oE6TB1F/2IAFN0pHnZfWzsXbQTs/fOYRmvZ/5LGb88svLDZtc0xfAjOlV9NlEzLC+l6PVo/U3T8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m2/C9GvZ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53df67d6659so1221046e87.3
        for <dmaengine@vger.kernel.org>; Thu, 28 Nov 2024 06:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732802829; x=1733407629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fbeGv6UaRD4uMpdkGqweyQuTufuHdg0lb79N9dKK5ls=;
        b=m2/C9GvZGEPXfaJbaW20D7/LYiZMojhrSjdo9Vtz8FbnsPjsEJle2x4vuENLXPWw9r
         qRZUIEGrTqtLu6UqQlkKMEZdJAZ17iPxEbrDgt/AlRQ5EYEiBVXyHpR6vabY791h2HPp
         q8IdKxGJznCOwY9Wzn/+GKD7CUz5lJCxOrD+SbpzMwzu24z5u/VdY3QqBJVeXUUavkkL
         5y1UgZwFAeMNolh6lrPlip6Ecpj25Nr1NP9zBf1k06DisROq6u+sWXZnypr/i96/rvCW
         GK+KKhSmevYrsx4pBHztpbSSgOD9q4qwRt52QzECav377eyFDUR0yJO7XlY3OH64gFby
         sv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732802829; x=1733407629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbeGv6UaRD4uMpdkGqweyQuTufuHdg0lb79N9dKK5ls=;
        b=lPXH34K5Gfjg/PDIf+ewczt876lSIts60sVF6M/FeLK5O6YACwImobfLHQI3kAjj5d
         6Emb6s/3jaY4hUrH5B/G3/dAye12D/+05IVNaT4AJMieNV2/ynfzuXgjsKOdrtZM/7Qb
         I4cJi45rq0SY+EHzrm4OEoq6krNsCzM6Hp6GgExbzDsO3SQai0LSCVF7ubhYK64yMtZS
         psTcLjoTiMg+gO+MrJFhenSusfYYlywBkYc4WJJf3VF7zXdq9d2a0M2EkQicQ6uYWHrX
         JV576X2Hph6ipp9VTqV5UKN68OQ03l1rqiPvPkw2N5nXouJXvDgdcAhmBwMCXRbK0hmL
         lm4g==
X-Forwarded-Encrypted: i=1; AJvYcCUhOueN+42nrP7ta6cagVFPHu6W7opjKMMdroQNOgEvqaJUlJ5tTTP6rTK21V5tqr+Yf6PZMtCP6TI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3pgKEfQ3KwYEzGjTSCPhPRJwftSvqs0O5QWhgIJiGYmOv5NnZ
	W9cuKSnx9sGEh8GhQ7k7bNqs/s/OAtxuxSnlmEHGteiVJFU0vtVI2RRl9wWTbeM=
X-Gm-Gg: ASbGncuPl/HSFuQ92op20H8mjBHvizo4V6iehPRaWX6KE0crBhq7zFHYtafm0B0mgfC
	rzbfjEZ3MyoiRO8uX4HADoodo2E5ZQIUFHv7HPtuKR/EAXGswYaD0571iB0SDz46UANlcyeGc0+
	QlemONFX5QkrHBbFkNqH/y0L9j1foCDBMVgfi8bu08Oj75irH5M9JYSzcAvJ4dJiupH25vC+sip
	JAEEwK+y37ZB5TV/jYwKyXSZQyFTdawUE8aZJqb7nPa6F3tC3fdrpUdhV70UKWDxyJq3ONhcmRy
	AiKYpmM8frOWfuKc2msYj2i3xdhufg==
X-Google-Smtp-Source: AGHT+IHudcPrxOXg52IUNG3JRLPxmA9gUb+mUF9hUF9mSvRpLmyJ6XAURRHhdJgDc0ZDHiHrd1Gg5w==
X-Received: by 2002:a05:6512:1249:b0:53d:ed47:3017 with SMTP id 2adb3069b0e04-53df00a9743mr6573311e87.12.1732802829171;
        Thu, 28 Nov 2024 06:07:09 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649ffc8sm186022e87.260.2024.11.28.06.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 06:07:08 -0800 (PST)
Date: Thu, 28 Nov 2024 16:07:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
Subject: Re: [PATCH v2 1/2] dmaengine: qcom: gpi: Add GPI immediate DMA
 support
Message-ID: <b2awih7g7wq2o7546qfpnf5ft27n6zzial7w35jvwpcjlrg5qm@tqrbl7wueiks>
References: <20241128133351.24593-1-quic_jseerapu@quicinc.com>
 <20241128133351.24593-2-quic_jseerapu@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128133351.24593-2-quic_jseerapu@quicinc.com>

On Thu, Nov 28, 2024 at 07:03:50PM +0530, Jyothi Kumar Seerapu wrote:
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
> v1 -> v2:
>    - Separated the patches to dmaengine and spi subsystems
>    - Removed the changes which are not required for this feature from
>      qcom-gpi-dma.h file.
>    - Removed the type conversions used in gpi_create_spi_tre.
> 
>  drivers/dma/qcom/gpi.c           | 32 +++++++++++++++++++++++++++-----
>  include/linux/dma/qcom-gpi-dma.h |  6 ++++++
>  2 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 52a7c8f2498f..4c5df696ddd8 100644
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
> +	u8 *buf;
> +	int len = 0;
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
> +	/* Support Immediate dma for write transfers for data length up to 8 bytes */
> +	if ((spi->flags & QCOM_GPI_IMMEDIATE_DMA) && direction == DMA_MEM_TO_DEV) {

Please defer applying the patch until the discussion on v1 comes to
conclusion.

> +		buf = sg_virt(sgl);
>  
> -	tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
> -	if (direction == DMA_MEM_TO_DEV)
> +		/* memcpy may not always be length of 8, hence pre-fill both dword's with 0 */
> +		tre->dword[0] = 0;
> +		tre->dword[1] = 0;
> +		memcpy(&tre->dword[0], buf, len);
> +
> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);
> +
> +		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
>  		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
> +		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IMMEDIATE_DMA);
> +	} else {
> +		tre->dword[0] = lower_32_bits(address);
> +		tre->dword[1] = upper_32_bits(address);
> +
> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_LEN);
> +
> +		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
> +		if (direction == DMA_MEM_TO_DEV)
> +			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
> +	}
>  
>  	for (i = 0; i < tre_idx; i++)
>  		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
> diff --git a/include/linux/dma/qcom-gpi-dma.h b/include/linux/dma/qcom-gpi-dma.h
> index 6680dd1a43c6..84598848d53a 100644
> --- a/include/linux/dma/qcom-gpi-dma.h
> +++ b/include/linux/dma/qcom-gpi-dma.h
> @@ -15,6 +15,10 @@ enum spi_transfer_cmd {
>  	SPI_DUPLEX,
>  };
>  
> +#define QCOM_GPI_IMMEDIATE_DMA		BIT(1)
> +
> +#define QCOM_GPI_IMMEDIATE_DMA_LEN	8
> +
>  /**
>   * struct gpi_spi_config - spi config for peripheral
>   *
> @@ -30,6 +34,7 @@ enum spi_transfer_cmd {
>   * @cs: chip select toggle
>   * @set_config: set peripheral config
>   * @rx_len: receive length for buffer
> + * @flags: true for immediate dma support
>   */
>  struct gpi_spi_config {
>  	u8 set_config;
> @@ -44,6 +49,7 @@ struct gpi_spi_config {
>  	u32 clk_src;
>  	enum spi_transfer_cmd cmd;
>  	u32 rx_len;
> +	u8 flags;
>  };
>  
>  enum i2c_op {
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

