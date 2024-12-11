Return-Path: <dmaengine+bounces-3947-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A689ECA89
	for <lists+dmaengine@lfdr.de>; Wed, 11 Dec 2024 11:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642D6168F07
	for <lists+dmaengine@lfdr.de>; Wed, 11 Dec 2024 10:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F059E239BCC;
	Wed, 11 Dec 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivyBg04f"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C74C239BA8
	for <dmaengine@vger.kernel.org>; Wed, 11 Dec 2024 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913955; cv=none; b=KSHi+snQvhZFIJUQFmPMa4kOeSl/6sN9LRKxlIAQ9X9xpdkNSVezOtK82mVmL5qXErQD70kwWlK+PFL6zI9lq3k9UQGWQsjR35xbZmV2gw0SW52m801O68mAD3lrEMhpFSQyzC8PssuvMUWvvUHns1lsOOXzwCb13diAyzlezDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913955; c=relaxed/simple;
	bh=/0nz8GMgYbjibg1AJZfgbWaOMRK1pQveKRAawRj7cuE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gr3UTrPIedg9BpvxtT3e87Jowfish9+7929ymgYezcGshbF9AiC1kg8D0rg4AYn5NJ69cWGXiiIBxHgXWNpx0N2LYzVSouApRKPBXXcQe8tq4HabPEyfWUXh7Egt200/pODZj24H6VNo/ydDnX9WWenN16hi4MxfM53nkkpHM2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ivyBg04f; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a2033562so56904345e9.1
        for <dmaengine@vger.kernel.org>; Wed, 11 Dec 2024 02:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733913952; x=1734518752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVl9CCqA8sepv1pyuanhBg0DwqapAdDTETHeLWd/77c=;
        b=ivyBg04fXbwPbKTo8h4WpShu1gnwvDyDxrASqdmaWi7SmbFE9nFBm1oySLI5uQNOol
         kPoOxSuVc0YeE0fHWy0fNkg8MYGk80Cb1PQ0zv/dBoU4g3XJ1Ba68cwsQ3uIyQ564mFC
         JvDjOfXGt9taxisQiM0ZUWuaV3ZG46nGBcNO4sCzlGrV0lRFkw71AvZpz02n5nKocjL7
         e34z9xnWYEJX0pwpxnG+F2AdbPN3XolCzITaAn9QZbPpfTSNfCJSfDrTm+9FS8a5npcb
         9S48giWPSEDkkeWC+2IzMJgTCUcCY8TUwmew3gSe7a7UBsIdPm35DV6QfZ3Vwd4f/sLx
         Ca2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733913952; x=1734518752;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VVl9CCqA8sepv1pyuanhBg0DwqapAdDTETHeLWd/77c=;
        b=uVy/Xjsaa3RrUBGqySIKexqkaX24mZLZDx/G9K/3HzQuZXRqu9XD/8zegX/8F7Kq13
         sR30l5PVvOGtlET8bPBPsL71AYv/oWVheqmg1HoxKxPEhNNflmfPc5U1FbcXsyPZTo7w
         +xKuklRqM5usYZR9cQRdcX1lpKJtL/bJwZPqswqLEbEI1e9lmCKXJnPiSMmsHcWTFeBl
         r5x0EjNOVUP6Olj007HgPn3wuqYxBh+NkbksS11ELtCL7NqUpSXgAtoY5fFirPnGUnDj
         Us6y1LBhwTSfTwK/hI2A9yKezLrf6UKWNE630nCoehv6xiXGHMyDaGhaDdCdYvqWC868
         K+6w==
X-Forwarded-Encrypted: i=1; AJvYcCXeKnMadRtx+8VfJb6PT8dJLWWsJJoDSsj0am20ROMhfYPAiNX4WWArRSt6Lwv+e/AizoUjOr/KtKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZoA+GSltGG/CwmZVmTfZsqlJvAyR6eLV8UBN2eEgpuL/jEOPn
	f3s/YYZye9jOiMbcg4ec1FCCU4yphsLfvAnbquFufB52ifoo3FqsaAOtB8INtWo=
X-Gm-Gg: ASbGncsdylPVSS5xu8hx7I8itZPtj5eRBs79VG1rP1RN4ADqlLOc/ai/QOqui9PaL+E
	4/3u0+FwBir03PUV5ys05TMBN14sfRLdIO4ujCcLPCb8AqBs44ES5ZiNYIuPPHlRwZNaHypAOz9
	fjQUV3ALjEUsTjsfEuQnyIOXGN2YJFBl1KNnaP76vXxG181iJ9FzwummO7tW3msijF2uHZCPXU6
	BxF29qL8yTebROUnK0gN4uTDXRsR4MJN3HQ58aUF85ZUMbKrl0RzZdpgRsO3WPAXrjlSQSPEgOc
	c7R8miXJl8Ndh0Fdj8ePKaC1XqwYCWk=
X-Google-Smtp-Source: AGHT+IGvs58p6vC+ErPy81oI/lMqyX+7RfNYs06Ry809HjtrsOVGa4o+oX5zS95efpqugcpJBzVN1g==
X-Received: by 2002:a5d:5f84:0:b0:385:fd31:ca34 with SMTP id ffacd0b85a97d-3864ceab366mr1780514f8f.54.1733913952177;
        Wed, 11 Dec 2024 02:45:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:d426:8f10:1673:5657? ([2a01:e0a:982:cbb0:d426:8f10:1673:5657])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cad51sm252695755e9.36.2024.12.11.02.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 02:45:51 -0800 (PST)
Message-ID: <e3bee6eb-34af-4e90-9041-48ad79d3f63c@linaro.org>
Date: Wed, 11 Dec 2024 11:45:50 +0100
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

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

Both platforms uses QuP SPI with GPI to communicate with the Goodix touchscreen controller,
no regression observed.

Neil

