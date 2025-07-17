Return-Path: <dmaengine+bounces-5832-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B8EB0881B
	for <lists+dmaengine@lfdr.de>; Thu, 17 Jul 2025 10:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687F63BF7E7
	for <lists+dmaengine@lfdr.de>; Thu, 17 Jul 2025 08:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E238283128;
	Thu, 17 Jul 2025 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9p5phMy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85212279798
	for <dmaengine@vger.kernel.org>; Thu, 17 Jul 2025 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741933; cv=none; b=et7HCB5dK/yrcpZcqPVX4zjiiXpBQcn7BAJufupj9/sobyc17SGRjxnMnWwm0GLN/xxupAr3WSfMoNazOhCXrtgSu34ufR08KZLOVXhLvjbbFw8yxRQK9RvRRORYkd/RVAgtJchz4N6D7pD1jei4z1h0vy2IO+GooQk+xFsKd5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741933; c=relaxed/simple;
	bh=KeBoICQi5vCriX+lE0bMVyU8SmgjFFfJAbuXSXLwOvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzPujdRussuNIEc7M/2lzITQTvotGQ6CsvxFnYjJaRWvL5H+bOd+7cx0U/eXUKde1WhT4THOqR/QjG2ag9w3RvSkGyBY3foqOp05En2dJXJTtXFbPIOyB8QXggnHe9qRv10s7Ekss9lXfwJPM6kMVkrhEv/KU4m0gc8ptVfuei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z9p5phMy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso390107f8f.3
        for <dmaengine@vger.kernel.org>; Thu, 17 Jul 2025 01:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752741930; x=1753346730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lI0pEfmVhQWkOv8EPGMn/xg7zISwfZGg3TSb4XZEXe4=;
        b=Z9p5phMyeHNhIDU3Bgy2gPhCpHerknLxBYm7WCG/LwPrxjMpI4USLbCyaOjiVnN2Bc
         0akJB43+4J3uta7FFI0j6VAD1cP64fyKo/TvC47bs35lBzsSewyivPQegM6s9TIKd63z
         zLB0zu4ZpRlUhXJHIcCrIoDgY4BSLNerw6TUyhoKJeJMG21cVl/AazO7JVwTdN92tt7v
         099tssRKwqNSXSCtTIWnjJPEs728HkTSydhzSa/WbaKLaFxrfvfE+FWEOlo2CKKsRJqK
         XTw3F5eThczER5JNuWtg/B8Qf9LF5GvqrgYn4O2CPnmm9LqxPQNtQaAJIFAaheUVJEwl
         x0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752741930; x=1753346730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lI0pEfmVhQWkOv8EPGMn/xg7zISwfZGg3TSb4XZEXe4=;
        b=Ya/5LatU0oA7RMnhmCSo08+GQgvKqPlx1hit2SWXMRnKqtQPyTsZsSUmEZA49HYH8q
         qPP/+U4y8qwVA/TxcG6oK/6T00fY29XlQ5AoSq85hB6NHWZS0mmlylhfW6QVGasZIB4O
         rLPTM7rk8V4idaJgIQMwIimVMD11Ppz7JqcX13VjMPcNjtvVgwM3B6JP+HNKLaDxSOxO
         OOr7FH0xUjjU75bM7fK9H0hSc5UxPZOEyOdgJGZqBQ3qP8DuUjWRDZK5WH04c7+g1Xl2
         bTHgxKVqVGA6IAI/FCrxdz7J3eafxUU8Up2Q/pbHTC/jzzj7qM8zqG0C0hJqGYfIZt38
         FuJw==
X-Forwarded-Encrypted: i=1; AJvYcCVMRaVRmjRjIkkD6IL8M+CF2uwKJNB5U7mhyZ8PUlsiHA3gqHMCvsOGZnKLGTq3UZgLWllPsa/YdGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlLAGZ6jfjYdFOPC+hkuq6nkpTtbEyss6cWIGWd9SRGuzNCtJo
	Zed+pOMUzKJPdLcehRXj87EyT5o18u93k78ZHa0OdVAfcb0eS3jQNpqMkB9n29kSTkU=
X-Gm-Gg: ASbGncsQnWTDIWzmrDsmY7cRGqKI730+6k49u/Cq5KGUGz2zAm03ZKv9O6wELeUe+hv
	aXZKFbGeDB/Iov17wyff7y1291cTW4aZRLg+e/10Dbai/E2DJ+/Se9kxoC/KaNcMAu10XErUJUN
	4G7rObuXuGmTu05OI3Byx6Ve6zW3aOhoJB+qVBm6xYpGyvhTRg9jegNrahuWSUAusYGbb21PdGX
	jXXS+oamN5JVnn+seL097MfOt+Rb7fGEv1wzMzbkEsXqGrAc4dFjfLPDsVhxytZ4PEzJp5qwbEB
	Zieov2CIfKfErri9qf85zJdVyvmhvkC8JACoB3zQ1qTKetUYbzeEMpU5fvI+aYARfVb0GcT0slc
	5I+1D9vBmTO74a6KkyjoOgdb/8HsnJ/EGlOfGS3yfA30JXyBTA0NTwwpPUJDw92FRWqrC3Oa0W0
	dC
X-Google-Smtp-Source: AGHT+IHynfEiO6GXy/zERfnUna5/ILOl/Jpu2n8FLydUo9tQGpFN5rGKrkj6TlP/t2+2sNcZBF+q3Q==
X-Received: by 2002:a05:6000:250d:b0:3a5:58a5:6a83 with SMTP id ffacd0b85a97d-3b613e66eaemr1561801f8f.13.1752741929767;
        Thu, 17 Jul 2025 01:45:29 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:37e:ce58:94c8:a752:de4:96bb? ([2a0d:e487:37e:ce58:94c8:a752:de4:96bb])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45634f5cad3sm15783305e9.9.2025.07.17.01.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 01:45:29 -0700 (PDT)
Message-ID: <d1e84ad9-eeea-4d0b-9f29-1dd4be49225c@linaro.org>
Date: Thu, 17 Jul 2025 10:45:24 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] dt-bindings: thermal: qcom-tsens: document the
 Milos Temperature Sensor
To: Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>, Thomas Gleixner
 <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-8-e8f9a789505b@fairphone.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-8-e8f9a789505b@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/13/25 10:05, Luca Weiss wrote:
> Document the Temperature Sensor (TSENS) on the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 0e653bbe9884953b58c4d8569b8d096db47fd54f..94311ebd7652d42eb6f3ae0dba792872c90b623f 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -49,6 +49,7 @@ properties:
>         - description: v2 of TSENS
>           items:
>             - enum:
> +              - qcom,milos-tsens
>                 - qcom,msm8953-tsens
>                 - qcom,msm8996-tsens
>                 - qcom,msm8998-tsens
> 

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

