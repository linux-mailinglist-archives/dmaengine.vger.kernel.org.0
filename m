Return-Path: <dmaengine+bounces-3763-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A5F9D552F
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2024 23:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B91283698
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2024 22:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEB01DA103;
	Thu, 21 Nov 2024 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNFoYxws"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6C21DD0FE
	for <dmaengine@vger.kernel.org>; Thu, 21 Nov 2024 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226929; cv=none; b=mxtMKN8rIK/7HDMuXNu+T+ju/E+EVJVo9agyjjvZHMrQH0QDOB5urROT79S4HoYk1a5X8ZaiRB/RE7quM3/1dxw+SCu1tXvW8tiIv8c7h0/I4uQewAaEz+kBrAO74eu8AteUfJm4nAyOr5BhAXr3WhylnEFWvMuqXW+0kJif494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226929; c=relaxed/simple;
	bh=rAzXnHe2SBhDMw27QAAIXDlh7GeOePkPJvRWdVpqQz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvGi3IKFBFY0jPfRDSaaDCkCa3LytsKh/6mZmow1RLYxLmtOChkzYtoXjuyTGEAalGArCks/lyoCzP9m4lA/CocLQVQlmpowfxQP6V2mn4MmuEUAByoRqxLe9e2tP5D3qxSwSblvQz23yZyi6pxbwNb1NS+xwXoYv0QSbibltEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kNFoYxws; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53dd1829b56so940882e87.1
        for <dmaengine@vger.kernel.org>; Thu, 21 Nov 2024 14:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732226926; x=1732831726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OkX+U05RiYpd3FpHw3ImL6zcHYL+a4J2Aov+jcxxZh4=;
        b=kNFoYxwsnIgeumw31gwWeCytcWiOZclfqX3hbV+mUbo9IToAEr9Buyuedg4p+3Y3e3
         4FDFgRgbc9oio2lNcXW0ky9yY+16h8bPE7SPo+t1M7eqwVlwV+2CQyvLEvDnjUJSyQrP
         Th+TGSOQpsfP9/oiFAKVMVrj74aoW6qSqDkm+zViL4Mkfc7qjli89nIamZzncvNWNgam
         uknBmNZsLcmhl9tJI4G2bq7VfsekYylRh08K+vBZam+bQsGOApHNcaUWOfd1X5alAK07
         H/T+mKLlHCH+Rsu2QCaptt7Hz/BnnV9nXx2VIzTJEGkdBTtbqZA9MhtmKO0nRER3Kp5x
         kVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732226926; x=1732831726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkX+U05RiYpd3FpHw3ImL6zcHYL+a4J2Aov+jcxxZh4=;
        b=TbEDXLCfdhzIz1FysceQuYwcAa3mSgm1ZEKR1nKsfxr9IWgJrTlWUOezgNOxdJyOQg
         0OANwhCKSL9VAqHd71JZATl4V+oLF2MMa40g1ia3OOExUr1CE3YVk2atrIM+fX3ZC6pn
         Mk5OEP/c2IhXUYGGCpfHtt0nTwjtvuYQ8Lu9mRbSnwr9I1Ia0rvUwjDAGJOS5NYZHmkk
         hz1IexeMRPAUoDmnTrtA+c5uCCVfQ/ni9L9Pvm4lOR19M7dy6JMzxH8+pCRDmX8UGtJX
         URu9RxFbyamRpWF3AOtmcFs9ws1+cEmYQHkDqD36kzfuVhj7jCmZCQ9gScIn+6ocP8Bx
         az/w==
X-Forwarded-Encrypted: i=1; AJvYcCWPMaTp03ZuUpNynza5T0mGuAz/O1pyLTree/owSHkNEEOSQmUkPNoSohwywMIrtHSN1xX7XGpH4G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCNO5Spfdz9F4EDNdFsEQsKZcMazHOi5m3Hit/tIbWtAgj9m+c
	ZacuoLmK5eTXvXqiNrZcugK5tB1auINOPgarqCyOW9CE7cmXcPlKtyw208qNRHw=
X-Gm-Gg: ASbGncslUxbQFeEzQKGVhbqLJcV4Yv/5U4euA57i33iljWQJBwMKHznO8ACk0e8GBqU
	cBxdUhSQNwNj6I478vzcoSmtmAn/FkRRFsWsgPfrECpJakWwg66UEeFJhPGmGkGQcvVkxlVbRcd
	CKReohSRAZNXNY1NEMjtA0EnHlbe38E357aPVoSHo295Vd8YzztJMCjBnRVU3qSy7jh5uAjskIA
	5yl9aIB4TR00d8CnDesUansFwD9c46d0d1Fsn24hIWV7Q+1qszK1b7aYSTai96HID3Z7CGwwNG3
	3hzJtbyGXRjwR5aeTIW02Mic/9uWHA==
X-Google-Smtp-Source: AGHT+IFuSwv+GpzK+sOK+hKbldDpyos/a2WLCYStBI83LunKlMjHra2urT+tQtcpGQjiSTEPq3cXng==
X-Received: by 2002:a05:6512:1111:b0:53d:cfd6:d49c with SMTP id 2adb3069b0e04-53dd36a0314mr255859e87.14.1732226925721;
        Thu, 21 Nov 2024 14:08:45 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451862sm94277e87.78.2024.11.21.14.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:08:44 -0800 (PST)
Date: Fri, 22 Nov 2024 00:08:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
Subject: Re: [PATCH v1 1/1] spi: spi-geni-qcom: Add immediate DMA support
Message-ID: <d2ybuvo676ouxhj2rejx6swlwkofycms2iwqsfcnwbfl3llbdr@4yoxxbmalpyf>
References: <20241121115201.2191-1-quic_jseerapu@quicinc.com>
 <20241121115201.2191-2-quic_jseerapu@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121115201.2191-2-quic_jseerapu@quicinc.com>

On Thu, Nov 21, 2024 at 05:22:01PM +0530, Jyothi Kumar Seerapu wrote:
> The DMA TRE(Transfer ring element) buffer contains the DMA
> buffer address. Accessing data from this address can cause
> significant delays in SPI transfers, which can be mitigated to
> some extent by utilizing immediate DMA support.
> 
> QCOM GPI DMA hardware supports an immediate DMA feature for data
> up to 8 bytes, storing the data directly in the DMA TRE buffer
> instead of the DMA buffer address. This enhancement enables faster
> SPI data transfers.

Is it supported on all GPI DMA platforms, starting from SDM845?

> 
> This optimization reduces the average transfer time from 25 us to
> 16 us for a single SPI transfer of 8 bytes length, with a clock
> frequency of 50 MHz.
> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---
>  drivers/dma/qcom/gpi.c           | 32 +++++++++++++++++++++++++++-----
>  drivers/spi/spi-geni-qcom.c      |  7 +++++++
>  include/linux/dma/qcom-gpi-dma.h |  7 +++++++

How is this supposed to be merged? Please try to separate the patches by
the subsystem, letting maintainers to handle possible dependencies.

>  3 files changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 52a7c8f2498f..a8df1e835e27 100644
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
> +		buf = (u8 *)sg_virt(sgl);
>  
> -	tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
> -	if (direction == DMA_MEM_TO_DEV)
> +		/* memcpy may not always be length of 8, hence pre-fill both dword's with 0 */
> +		tre->dword[0] = 0;
> +		tre->dword[1] = 0;
> +		memcpy((u8 *)&tre->dword[0], buf, len);

Drop all type conversions, they should not be necessary. memcpy()
functions accepts void pointers.

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
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 768d7482102a..53c8f6b7f3c5 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -472,11 +472,18 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
>  		mas->cur_speed_hz = xfer->speed_hz;
>  	}
>  
> +	/*
> +	 * Set QCOM_GPI_IMMEDIATE_DMA flag if transfer length up to 8 bytes.
> +	 */
>  	if (xfer->tx_buf && xfer->rx_buf) {
>  		peripheral.cmd = SPI_DUPLEX;
> +		if (xfer->len <= QCOM_GPI_IMMEDIATE_DMA_LEN)
> +			peripheral.flags |= QCOM_GPI_IMMEDIATE_DMA;
>  	} else if (xfer->tx_buf) {
>  		peripheral.cmd = SPI_TX;
>  		peripheral.rx_len = 0;
> +		if (xfer->len <= QCOM_GPI_IMMEDIATE_DMA_LEN)
> +			peripheral.flags |= QCOM_GPI_IMMEDIATE_DMA;
>  	} else if (xfer->rx_buf) {
>  		peripheral.cmd = SPI_RX;
>  		if (!(mas->cur_bits_per_word % MIN_WORD_LEN)) {
> diff --git a/include/linux/dma/qcom-gpi-dma.h b/include/linux/dma/qcom-gpi-dma.h
> index 6680dd1a43c6..0eb96e62a1f1 100644
> --- a/include/linux/dma/qcom-gpi-dma.h
> +++ b/include/linux/dma/qcom-gpi-dma.h
> @@ -15,6 +15,11 @@ enum spi_transfer_cmd {
>  	SPI_DUPLEX,
>  };
>  
> +#define QCOM_GPI_BLOCK_EVENT_IRQ	BIT(0)

Unrelated, please drop.

> +#define QCOM_GPI_IMMEDIATE_DMA		BIT(1)

Can GPI driver deduce whether it should use immediate DMA based on the
transfer length?

> +
> +#define QCOM_GPI_IMMEDIATE_DMA_LEN	8
> +
>  /**
>   * struct gpi_spi_config - spi config for peripheral
>   *
> @@ -30,6 +35,7 @@ enum spi_transfer_cmd {
>   * @cs: chip select toggle
>   * @set_config: set peripheral config
>   * @rx_len: receive length for buffer
> + * @flags: flags for immediate dma and block event interrupt support
>   */
>  struct gpi_spi_config {
>  	u8 set_config;
> @@ -44,6 +50,7 @@ struct gpi_spi_config {
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

