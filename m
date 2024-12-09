Return-Path: <dmaengine+bounces-3934-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4159E9903
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2024 15:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49924167504
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2024 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4F623313D;
	Mon,  9 Dec 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S3g6Hntz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A840F1ACEB8
	for <dmaengine@vger.kernel.org>; Mon,  9 Dec 2024 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754929; cv=none; b=QVd7qOyEbMo8/O3/6NRGQLWUvr8MTzTvTX/OxWevdg0/i/AfoqUNrkJFskDUMg66QSapmk/UBKK2M0CvTBENFKczXuE9XpsUPNnIMgpUMaxagwvsQEkTVo8kv7+229VEDxG/29HSyIDA+AhxLOnp3ctcajBp/VNXQ0lXrFdVOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754929; c=relaxed/simple;
	bh=ufblJQhubkWdNSz+41KJyY9zdrSAk/NQLzNngY7UCKE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pGs/a/dDBhmvjYBzH3un1e6F9I4NVsrbFVzlw5ZooRJ+HEJfvXmBTaveG3iBo0RgAW2yjE+qL+KEFDA4ZKELaPv6E7OO4cxTyuz5FUH13lLkhdibTBaLHU5Lx7slkLz2bVj2a7jUNe9V9sn1KGtXdXpsFGEZmjz00Z9bbBvEn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S3g6Hntz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434f74e59c7so12279205e9.3
        for <dmaengine@vger.kernel.org>; Mon, 09 Dec 2024 06:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733754925; x=1734359725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K59ipWzTXtlLAZNdAEKf0wKFJDolleON2F2oMOHVR48=;
        b=S3g6HntzF2k7ZfPO9F4Wa5d/2tTap7D+C/42TF8OIRpbBcahEEUYGuiDJXVEpmVSrf
         YXGqXYJrtrGskX++E4bPwUoiREo6vFCYo/qIMcQRpV5UBjx2ae4ddW/KqIHaCVP/GQzQ
         vqfAocrvuT7wvNMZ3VkXXXwzDLaukFJCanBqOUQ3rUvx/e60EXZmr0frtlNJnV8ae1DZ
         PWULE/hwHkbsOjJZxZSiNZ0knFY2sAeZxZ7yAdMM7tUwgvr0h7HNR8DGuUykPzoj+R3D
         14LQMghCfjEINfxINlAmIXRQ7ZI9r4cQKXxTjJTVT6/VaEPolAbHrUP8KrAGZB9INxse
         wimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733754925; x=1734359725;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K59ipWzTXtlLAZNdAEKf0wKFJDolleON2F2oMOHVR48=;
        b=xHP+S/Uem+xBlMwTKR13E/620GDdtBWSxzGhw6gHAnSSb8bl+8r1CMV5heriL+sMi8
         AERUqO6mCZvRq5+N7C3fzNTWd81Elbvoa5ZGEEW873YQsnQhuwtQP/gNzQr3AXgWW53/
         pUlJUS6KcQkojz7HK60rLlhr3ZOLud4PoB403dN+4wiDUMI7kaD9CNCRicf/wwnYm1cv
         jQ4pyTjFmy2r5eRtoJic02M53VFFBUvSQrkrMVtdmTqg55g1mp+Pz1vRLG0TMNIGMBtD
         QY9KZgIMiOte0JgdMoxI2R03Ht+3H9frFLn1dSv9Qnb9iKVb8pAcCyDsDiEsAVUdU6yg
         /OxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcN3Q4Xb0YSJRhUDMW7spH5kRof8E/RY+z+i0xOJfsMMQZkQNxBxCn1RtYRe3P+QR2qdsxpjJ7ms8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynkw6XZeSru1wqEVaHY7dVqBppmkgEOoEOepKxWWLq0hbIw/kf
	axGhhDfVmliB98OZQb7Jr95yjgAHFE8ciVptXRpyzoIZAU6tqYTwzJaAIXq4cyI=
X-Gm-Gg: ASbGncs9PU3LyDAAUI7L8xacKLX3myy012oyJg0ytk3b4K7c9UD4oP3MeVG++Ebc3VL
	S0oQUwawD3V7Y/3aFPyhLmZ7x/Frk+YFMC1zzS8aAj5ym1SxV1fNBtFBK9gxCwwhTmic0zz5Khz
	DRQL95wksyNoFnJIPcstQ6FbTO2e1QUpwgOwftSUb5C5P9IJJ1T+JCMefVXVbpMik3YMzopmuf6
	plPT3s6QUwjJc8Tc+L/pAMG2TzYJqGfkA3+xBME+cY4tzFj7dv4F2RL+mLPKuj5HhamQLoaQLkr
	GdwSTFK1l2Nt6BarvJL6IIdjkvc=
X-Google-Smtp-Source: AGHT+IHEHgVZ4BtFj2EudC110P7cX9PDnI2WAkl4XZ0Uu6nICivxOsTUaM1D0asAvQX61oYw3/5nIA==
X-Received: by 2002:a05:600c:5101:b0:434:f131:1e71 with SMTP id 5b1f17b1804b1-434fff3d84cmr8719065e9.8.1733754924889;
        Mon, 09 Dec 2024 06:35:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7546:6147:f006:709b? ([2a01:e0a:982:cbb0:7546:6147:f006:709b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a8758sm13130881f8f.27.2024.12.09.06.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 06:35:24 -0800 (PST)
Message-ID: <d641c361-278d-4ebe-88be-c872290e474f@linaro.org>
Date: Mon, 9 Dec 2024 15:35:23 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5] dmaengine: qcom: gpi: Add GPI immediate DMA support
 for SPI protocol
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
 quic_vtanuku@quicinc.com
References: <20241209075033.16860-1-quic_jseerapu@quicinc.com>
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
In-Reply-To: <20241209075033.16860-1-quic_jseerapu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/12/2024 08:50, Jyothi Kumar Seerapu wrote:
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
> v4 -> v5:
>     - For Immediate DMA, instead of making dma type as 0x10 and then
>       enable 16th bit of dword3, directly updating the dma type as 0x11.
> 
>     Link to v4:
> 	https://lore.kernel.org/all/20241205170611.18566-1-quic_jseerapu@quicinc.com/
> 
> v3 -> v4:
>     - Instead using extra variable(immediate_dma) for Immediate dma
>       condition check, made it to inlined.
>     - Removed the extra brackets around Immediate dma condition check.
> 
>     Link to v3:
>          https://lore.kernel.org/lkml/20241204122059.24239-1-quic_jseerapu@quicinc.com/
> 
> v2 -> v3:
>     - When to enable Immediate DMA support, control is moved to GPI driver
>       from SPI driver.
>     - Optimizations are done in GPI driver related to immediate dma changes.
>     - Removed the immediate dma supported changes in qcom-gpi-dma.h file
>       and handled in GPI driver.
> 
>     Link to v2:
>          https://lore.kernel.org/all/20241128133351.24593-2-quic_jseerapu@quicinc.com/
>          https://lore.kernel.org/all/20241128133351.24593-3-quic_jseerapu@quicinc.com/
> 
> v1 -> v2:
>     - Separated the patches to dmaengine and spi subsystems
>     - Removed the changes which are not required for this feature from
>       qcom-gpi-dma.h file.
>     - Removed the type conversions used in gpi_create_spi_tre.
> 
>     Link to v1:
>          https://lore.kernel.org/lkml/20241121115201.2191-2-quic_jseerapu@quicinc.com/
> 
>   drivers/dma/qcom/gpi.c | 31 +++++++++++++++++++++++++------
>   1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 52a7c8f2498f..b1f0001cc99c 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -18,6 +18,7 @@
>   #include "../virt-dma.h"
>   
>   #define TRE_TYPE_DMA		0x10
> +#define TRE_TYPE_IMMEDIATE_DMA	0x11
>   #define TRE_TYPE_GO		0x20
>   #define TRE_TYPE_CONFIG0	0x22
>   
> @@ -64,6 +65,7 @@
>   
>   /* DMA TRE */
>   #define TRE_DMA_LEN		GENMASK(23, 0)
> +#define TRE_DMA_IMMEDIATE_LEN	GENMASK(3, 0)
>   
>   /* Register offsets from gpi-top */
>   #define GPII_n_CH_k_CNTXT_0_OFFS(n, k)	(0x20000 + (0x4000 * (n)) + (0x80 * (k)))
> @@ -1711,6 +1713,7 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>   	dma_addr_t address;
>   	struct gpi_tre *tre;
>   	unsigned int i;
> +	int len;
>   
>   	/* first create config tre if applicable */
>   	if (direction == DMA_MEM_TO_DEV && spi->set_config) {
> @@ -1763,14 +1766,30 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>   	tre_idx++;
>   
>   	address = sg_dma_address(sgl);
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
>   
> -	tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
> -	if (direction == DMA_MEM_TO_DEV)
> -		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);
> +		tre->dword[3] = u32_encode_bits(TRE_TYPE_IMMEDIATE_DMA, TRE_FLAGS_TYPE);
> +	} else {
> +		tre->dword[0] = lower_32_bits(address);
> +		tre->dword[1] = upper_32_bits(address);
> +
> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_LEN);
> +		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
> +	}
> +
> +	tre->dword[3] |= u32_encode_bits(direction == DMA_MEM_TO_DEV,
> +					 TRE_FLAGS_IEOT);
>   
>   	for (i = 0; i < tre_idx; i++)
>   		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

