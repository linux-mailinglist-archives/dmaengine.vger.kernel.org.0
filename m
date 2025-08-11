Return-Path: <dmaengine+bounces-5976-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA0EB200CB
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 09:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7728B188CC52
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 07:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ACA1F76A5;
	Mon, 11 Aug 2025 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jR4thrEb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF01B214812
	for <dmaengine@vger.kernel.org>; Mon, 11 Aug 2025 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898666; cv=none; b=ZattM2HYeabNiKI9cdq4VhdFDTFCM8unI4+UpaEQT+pLxNzLGNhjxM+adB7VbaKVFpL5DvTpAfnvExtW0NrHxi66q+tgcClooBfGbT6HCgeYEQo1k9rMn0MPzroZ32Zuz2o5I24vrdlClPRNW5nJZE+l1cdp+O8tFYZbdU/gHxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898666; c=relaxed/simple;
	bh=v625ymQxFS+YCBJDvagQuBLz+d89QJreJSRQKzXaYps=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mRuYaRH29XLj9300t5k1753NwRk9lFHxWkm6KG5JNevKNoMET0bqXyPbSwN7g+F1EtRvZ3XWpXj+RIxzDFmU3hmzOAv0yVxOnKi5ywZfx1csS2PBBmzMsTE7Ak3PkQ/3BF3l+QFev/nYn+smd+zClB34LIwW8ZyJZV9o3ajpY+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jR4thrEb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45994a72356so31634155e9.0
        for <dmaengine@vger.kernel.org>; Mon, 11 Aug 2025 00:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754898663; x=1755503463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCxvGReB/YdPK1TB+jaxnIWUKnSdJ0qulaewLmYALDA=;
        b=jR4thrEbD1wq0fBAcWnhk/RnP4klbCJUBUA8JSiWwrp3txhbQwbnTzSGLgE8PCYFsK
         C42DzOTEGfNpMEJGTJoc9+UyZ9ObyH1dzhGTt58Gudl0SBwNkf/o/CvbKsQgXp14Mx4M
         QMe8NoqvSA5zDVTgjZCIL60oUkowxZ2tjfZH8aW1r2ihcZUSga3M/2vPnGxHRL+MgQwq
         x/ZHcG9/kT4OyEMJol5oGK5esTIKVA5+7aWF96rkjz2EArQ+de6NpPO91VM2nkdS0kJm
         m0ZFjqPRKVxOfz9MWwFzjmDw719L1iiKi+gKaUMbPwq9CRtPP3l+0/uLxrvt5dZmPGEk
         DsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754898663; x=1755503463;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SCxvGReB/YdPK1TB+jaxnIWUKnSdJ0qulaewLmYALDA=;
        b=lr8Bpj5TCFP5S5KB3gh2tiCrxxkEvTk7Sa9jyLPKkGkK1pBFK7WNOXjGFDeQ920+fI
         RoBvPZO7gQtIQbMpfpZ7dW+gMmTB6CvJZKLNWuO+bctxXd/fbIp+Gy5jfCdTr+j5bWon
         yUQRvtehGvtfX+P//YKh3PCSgf8igiubuIs4QJznUMZBLXQf6gpxfqoREGPg0C76Ro8n
         hh/9tWvtmWAanWEP4OsPQDRz7BAzrOzMc3NOBFtGHZH7mNvIzkTYSwpXqMJ4WzIaI7C5
         ZqwokNP8rRakZ3Wz+12c1gD+d3pFN7UKCA/rzEMuBWgBkb2tMWzM6N2Tsng/glduykxT
         KoVw==
X-Forwarded-Encrypted: i=1; AJvYcCWaL/uiMIZF0zo2s8FHrEmZkcK0LaOSdayuFmTHdQiL0eTt79ME3f9WkOwLvDYmrb1GH2VTH1qD0n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHR6IK6VyPLrZiGq482HvGlOW2/+Comp+T4K4dHQILAWhi1X+u
	zr0YFOFy2Ixq4w/PUIwjDXPHRSr2iUqhqUcMWYRPGBAmmiKWFczf97SNJzSuIQA06iE=
X-Gm-Gg: ASbGncscvpBgXUWHm/EbZd1KZ0yL77EnEQ5aNCXtpNKPdW+EmqCxt51IDtbzk1KR0u5
	NabACap+oi7AwwU2fAzvhXC+JApwn+YKCwk5aKaNAWsdj0tc6KSR/GD491aMwmW87KvdanMwJVv
	/u4szG0uhfShdVC18m8YvZpOyWyWIRZWdA2BDspszNtRkqb2EUMWL0JKjF3HJQ9aS3m7yIg2sYD
	CmLriLOZRPwvwLfpG4osvPxVcer4xCKEzbO9C8/X4QHppRbpycRWbTXuEmdy5BZDoBZo8IH/JTa
	qEyaKZJEefKjaG3MtbN258f07OYsdAGvvrPdBN4D4MOUAZDefYCRODQemURUhFUwO1TU3wVsJzO
	lJUeLopHKlmNII7KuyRsIl5unXdp6Bjomqu8bAEUp7L5gY+d0E8N7k76c9OffjDXx3zrrKVxLfQ
	M=
X-Google-Smtp-Source: AGHT+IHVV30FoowHptAlEajvZgXMFWrsREGbOySyGN+RbPFO0235lfTNd4xbMnBALGm7ACcJo6UbZQ==
X-Received: by 2002:a05:600c:c089:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-459f3a7ee89mr89086075e9.10.1754898662994;
        Mon, 11 Aug 2025 00:51:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b0fa:b045:4b82:de09? ([2a01:e0a:3d9:2080:b0fa:b045:4b82:de09])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5c40eb1sm121405305e9.6.2025.08.11.00.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 00:51:02 -0700 (PDT)
Message-ID: <37c6a22e-e47a-4559-a765-a7779575d6df@linaro.org>
Date: Mon, 11 Aug 2025 09:51:01 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/8] arm64: dts: qcom: sm8650: Add missing properties for
 cryptobam
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Yuvaraj Ranganathan <quic_yrangana@quicinc.com>,
 Anusha Rao <quic_anusha@quicinc.com>, Md Sadre Alam
 <quic_mdalam@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
References: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
 <20250212-bam-dma-fixes-v1-4-f560889e65d8@linaro.org>
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
In-Reply-To: <20250212-bam-dma-fixes-v1-4-f560889e65d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2025 18:03, Stephan Gerhold wrote:
> num-channels and qcom,num-ees are required for BAM nodes without clock,
> because the driver cannot ensure the hardware is powered on when trying to
> obtain the information from the hardware registers. Specifying the node
> without these properties is unsafe and has caused early boot crashes for
> other SoCs before [1, 2].
> 
> Add the missing information from the hardware registers to ensure the
> driver can probe successfully without causing crashes.
> 
> [1]: https://lore.kernel.org/r/CY01EKQVWE36.B9X5TDXAREPF@fairphone.com/
> [2]: https://lore.kernel.org/r/20230626145959.646747-1-krzysztof.kozlowski@linaro.org/
> 
> Cc: stable@vger.kernel.org
> Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 86684cb9a9325618ddb74458621cf4bbdc1cc0d1..c8a2a76a98f000610f33cd1ada82eebd6ae95343 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2533,6 +2533,8 @@ cryptobam: dma-controller@1dc4000 {
>   				 <&apps_smmu 0x481 0>;
>   
>   			qcom,ee = <0>;
> +			qcom,num-ees = <4>;
> +			num-channels = <20>;
>   			qcom,controlled-remotely;
>   		};
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

