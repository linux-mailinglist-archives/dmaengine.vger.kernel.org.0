Return-Path: <dmaengine+bounces-3817-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1709DBA69
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 16:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D0E28169E
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4C71A9B2F;
	Thu, 28 Nov 2024 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4rq1DpD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4A847B;
	Thu, 28 Nov 2024 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807415; cv=none; b=TbYWK7Y6N8ZLd+4exg7cFwQATEkUzlQfhMMv+/vQm2QYKInbuI5PAW90GotmnTZet+edzLj+kdddCdOPEAzvq0tvrsQm1bPMhOCt4My7rlY0+EAgujCOHEY8Ibammtu4e1Cohxq4L6cgyGdyp0xgOBy5FqEug1WB0H+zjjaQ4iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807415; c=relaxed/simple;
	bh=zf3XI+duCmZMKJdMWvONc/8e5U+UV5sJ/cIMEjqAU74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUniJQS5nE+B9QaZNPgo5TTUqUlgQwyOx3OZRZbzCsPkf2qzPqg6B7AUMYVXv7hVHmD2sXeggf0+DhUgt0IaBGkwzpuQzlqqF4d8xXwjl0L5QD/P/lhngLOAKCVgN/cx/a+EFX9+uXz0zj5e0SCSpEYaJNcnGFJfdKMT0gc9DvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4rq1DpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8385C4CECE;
	Thu, 28 Nov 2024 15:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732807414;
	bh=zf3XI+duCmZMKJdMWvONc/8e5U+UV5sJ/cIMEjqAU74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4rq1DpDtIbHWYYkNQEIAaoVPCAMmMAlUk7mxdtgJHGryaJgMGceMCBy23NEdrp0c
	 MZeyqSKoZiGYYtc9NzFNcxa/nCokl03aKmERt1+cc9N8aOB/WeiRvz4LwK+2+FXPnB
	 SvmSi9dRO2IID778GIIGr9+uHP2m07epiFHmqXFZ4II8v4fn38C3JhbieUbSGUEPt+
	 AcM2UUrBqI96qDByhzZtBPr7kKTKaOVPXx8lYnv/Owpj6DppWQ+oIsRNIUrXvQXFPl
	 yd/L7qjbOPH+QRAp+IMjaLthMdQO6/gCkez90Net1yzgUkDsPO9f6oNssE6nxEXEz6
	 NZfr6WQQYZeJw==
Date: Thu, 28 Nov 2024 09:23:21 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
Subject: Re: [PATCH v2 1/2] dmaengine: qcom: gpi: Add GPI immediate DMA
 support
Message-ID: <obv72hhaqvremd7b4c4efpqv6vy7blz54upwc7jqx3pvrzg24t@zebke7igb3nl>
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

First use of "len" is an assignment, so you shouldn't zero-initialize it
here.

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

And what happens if the developer writing the SPI driver forgets to read
this comment and sets QCOM_GPI_IMMEDIATE_DMA for a 9 byte transfer?

> +	if ((spi->flags & QCOM_GPI_IMMEDIATE_DMA) && direction == DMA_MEM_TO_DEV) {

Why is this flag introduced?

If I understand the next patch, all DMA_MEM_TO_DEV transfers of <=
QCOM_GPI_IMMEDIATE_DMA_LEN can use the immediate mode, so why not move
the condition here?

Also ordering[1].

	if (direction == DMA_MEM_TO_DEV && len <= 2 * sizeof(tre->dword[0]))


[1] Compare "all transfers of length 8 or less, which are mem to device"
vs "all transfers which are mem to device, with a length of 8 or less".
The bigger "selection criteria" is the direction, then that's fine tuned
by the length query.

> +		buf = sg_virt(sgl);

It's a question of style, but I think you could just put the sg_virt()
directly in the memcpy() call and avoid the extra variable.

>  
> -	tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
> -	if (direction == DMA_MEM_TO_DEV)
> +		/* memcpy may not always be length of 8, hence pre-fill both dword's with 0 */

The implementation of memcpy() is always more than 8 bytes, it's buf
that might be less than 8 bytes ;)

Also you're not "pre-filling", you're "zero-initializing", or just
"initialize".


That said, does it matter? Will the QUP read beyond the
TRE_DMA_IMMEDIATE_LEN bytes? If so, please put _that_ in the comment
("QUP reads beyond the provided len, so additional content needs to be
cleared", or similar)

> +		tre->dword[0] = 0;
> +		tre->dword[1] = 0;
> +		memcpy(&tre->dword[0], buf, len);
> +
> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);

Does the format of tre->dword[2] really change when
TRE_FLAGS_IMMEDIATE_DMA is set, or is TRE_DMA_IMMEDIATE_LEN just a
mask to highlight that len can't be more than 4 bits?

It seems like you could drop TRE_DMA_IMMEDIATE_LEN and just use
TRE_DMA_LEN here? (But it should match what the hardware programming
guide states)


Perhaps you could reduce the scope of this if/else then as well, as the
assignment of of dword[2] and dword[3] is mostly the same with and
without immediate mode (just the one bit to enable it)

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

Per above I think you can remove this flag, but "true for immediate DMA
support" doesn't match what you have written in the code. (Also in
general u8 shouldn't be "true")

Regards,
Bjorn

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
> 

