Return-Path: <dmaengine+bounces-3914-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8619E5CDC
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 18:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BE616BF06
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 17:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2E2225783;
	Thu,  5 Dec 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnH/cwnU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CAF21C16C
	for <dmaengine@vger.kernel.org>; Thu,  5 Dec 2024 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419020; cv=none; b=ARVgbPSPeO9E/RIcAGj9IRYRLKcz3EZFhGQaEuMORFokxTMchBqN7y4c5QAhE0qM3xkG1SgW157pzj9zdFIDInHk8FRGKoeK7n3fw+hFROawzIWLt1DvWVkF0RgJufDTjQzmwtxYRqH9fczkQOgmI5CT8B57uuPrg08s5Fx8Buw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419020; c=relaxed/simple;
	bh=bq3+bNN7RlTO3LzluOulsa1FFZoUNl4cRiM8pa4tVJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/hA4KQljdtSrVfskUKd1uLEX0NRWwjJmFAXFmLCfdlNJDMDzWl1RfHmp8w2O6+5k0GvBGB/YRImRNT2+POtfo2T7MYQzClJw2PjcXxUJVm2Fv/qW6pb7Neji2QB0qUPquPC7WhaZMChadCdXg/cE4+lvX1uSG4MJ+UpOGrmLSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BnH/cwnU; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffc81cee68so8831731fa.0
        for <dmaengine@vger.kernel.org>; Thu, 05 Dec 2024 09:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733419015; x=1734023815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dk6qeu/c0aGQfq+iRGPsbk8IOsfqn1Rscd5YILluES4=;
        b=BnH/cwnUIxgrOlQcrvIzL5k5FYyrzFXriVP9v6rT00mU3hmp3yoN1HOtshV03Y2G1r
         vxCCMXQc52Uf8vaIfv74OzPs5LCSeu2tST7yr9PHTB0do1R0RB9JZ6hI/fe/CXB4BQPu
         GSqGiOIkQsuCDrbVcJ3Ir2HRh/k+CXd0SuNo/rTIMhkwEz/nQfozUz8Z8lm818BvVyPc
         IVUFMaRm89L95467XLACtZJVpBvWOS6W1nFL7eqPlUcub0rX3B8e9SkJxueZgGvJb+vx
         Et0XkaqeYM1h9RoEXoBS2mrWVU6Vi4rYoIknb5Lx0MeaD4U+vddmEaC4eRVHW19ZCt8T
         bbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733419015; x=1734023815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dk6qeu/c0aGQfq+iRGPsbk8IOsfqn1Rscd5YILluES4=;
        b=bo32GIad3hBXYrUEChOrj1ND7eE5hS+v0ZxU7NHzLuCmMaCtxUGoszeDtSNih6ip0K
         lIAPq91CFZ4vJbVyRGov6c57pHoreRlS+No5MU3d5KUTHM9B3K5+8hXPWt7NRbninVtE
         BhGo4cWIVzuOUhlcnRE7S7BHqbKYVvZK4VUl72xXrv9njYfqrhky95V/jCTkxV5JOKbv
         DQVbM2o3H8oxL0vxQttO9ulTS9QROQy2w1W8YqMbin8csQqg4PjJWQiYDRXL3iCvRHub
         goxbPk8qYidSMgXscoK6Owey9edbZixTlLuuq2U5RDrxtI2GMlHWqWGSU9hlHO1Si451
         MPLw==
X-Forwarded-Encrypted: i=1; AJvYcCVXcEcOpCpfs7iuq6NID6H+ORq2Y+M2wBR9W84iPPTyKb9emjZQjLb3qbvgr3B5dEa+glwaWc/Y2yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWnTXZGhyR443H9M7/MK+c0otXoLJj7KkU+H8hGD0wZo7+vK3f
	Fi6xMDSKWIxqTcEljPre4MoHogPvq9TrAL8OgP5p3rWH8CL5mdyMW7E4AePCUW4=
X-Gm-Gg: ASbGnctmyd48CweCF0NHr3AKNodULmeRCXAVz+UMonWKEd3IX+WYAIdKZwiN7y6vgvy
	jP5ziQVVUWyu8/erwnHoIqfP0hLReAv+iu/Whc94UXxFVahlKpQ9RqHHFS6P1JD/09gY73C4qRm
	vXlsIO4XBzN5cvWi2UWJi5TxhIr+3oFHgSjNlOWToWQdQ7DPXi2LwrVT0Wsw+PLLd8uXyD6T9gI
	r/VQVuUPcykLfaLEzMM+r/hWwKzAHOqlQ59TE35XfKQ2OuddMOmdYJa5bUhsG5ep+fWVNxr4HvR
	eIN7fGiY5sg1M7WsGX3WCI58XI/30Q==
X-Google-Smtp-Source: AGHT+IEQVBkrgjioAw00LjhLtyaVjJhAuyebF7gUV1LhQmmwc8b638t447Vk/yLDEXbFDy5Y4yCjMA==
X-Received: by 2002:a05:6512:4024:b0:53e:28ec:6000 with SMTP id 2adb3069b0e04-53e28ec6045mr525398e87.34.1733419014352;
        Thu, 05 Dec 2024 09:16:54 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e22974fccsm295501e87.69.2024.12.05.09.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:16:53 -0800 (PST)
Date: Thu, 5 Dec 2024 19:16:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com, 
	quic_vtanuku@quicinc.com
Subject: Re: [PATCH v4] dmaengine: qcom: gpi: Add GPI immediate DMA support
 for SPI protocol
Message-ID: <d74ibj74mrluovh3ylok3dyctf3r4iimoosegdair5acvpre6c@w5xfl6adtfto>
References: <20241205170611.18566-1-quic_jseerapu@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205170611.18566-1-quic_jseerapu@quicinc.com>

On Thu, Dec 05, 2024 at 10:36:11PM +0530, Jyothi Kumar Seerapu wrote:
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
> v3 -> v4:
>    - Instead using extra variable(immediate_dma) for Immediate dma
>      condition check, made it to inlined.
>    - Removed the extra brackets around Immediate dma condition check.
> 
>    Link to v3:
> 	https://lore.kernel.org/lkml/20241204122059.24239-1-quic_jseerapu@quicinc.com/ 
> 
> v2 -> v3:
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
>  drivers/dma/qcom/gpi.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 52a7c8f2498f..9d4fc760bbe6 100644
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
> @@ -1711,6 +1713,7 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>  	dma_addr_t address;
>  	struct gpi_tre *tre;
>  	unsigned int i;
> +	int len;
>  
>  	/* first create config tre if applicable */
>  	if (direction == DMA_MEM_TO_DEV && spi->set_config) {
> @@ -1763,14 +1766,32 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>  	tre_idx++;
>  
>  	address = sg_dma_address(sgl);
> -	tre->dword[0] = lower_32_bits(address);
> -	tre->dword[1] = upper_32_bits(address);
> +	len = sg_dma_len(sgl);
>  
> -	tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
> +	/* Support Immediate dma for write transfers for data length up to 8 bytes */
> +	if (direction == DMA_MEM_TO_DEV && len <= 2 * sizeof(tre->dword[0])) {
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
> +	tre->dword[3] |= u32_encode_bits(direction == DMA_MEM_TO_DEV &&
> +					 len <= 2 * sizeof(tre->dword[0]),
> +					 TRE_FLAGS_IMMEDIATE_DMA);

Don't repeat the condition, put it inside if.

> +	tre->dword[3] |= u32_encode_bits(direction == DMA_MEM_TO_DEV,
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

