Return-Path: <dmaengine+bounces-5085-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C08B7AAC2D5
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 13:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 192B97AF388
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 11:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4175279902;
	Tue,  6 May 2025 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6TN1P1H"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857733DF;
	Tue,  6 May 2025 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531381; cv=none; b=M+itehJrUpi+fTtaT3bnhXNKa+NQ5GQcFQsIUu+ay62SdaIEib5qkvCBKUC0yXKsrK+utZ9II7mZqTUdPBu7/ScRN7KlN/f9SQclROTNfUSbsxaRynJiJiskuVPp7yjgSV5sLJnNCEyhSK7cWZGNbz1LcF0aWs5SKVb2CQQaoVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531381; c=relaxed/simple;
	bh=9keMmpZSyqI5tSOuG8Pqrhgf7LjyBxdO9UY563YM01k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/xQQOg4NEhD4RToAPS//EfmVjPjoze2g3Q3GUQQfJof/t4bRG5pnI32Qj/qg5kFDv7y3Qn6Wyta7mQ2KMaFPqfTpxaPOCLV1UJtRi4XG+tEKlMif8/MOF40McUCT0xKecqMM6brON2GS+EFn/DJwTB+RVGyZcnEFdn6xZEh//k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6TN1P1H; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736b98acaadso5238663b3a.1;
        Tue, 06 May 2025 04:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746531377; x=1747136177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+r2etV5TTN9GUy5eqZyzlOSAzsHs6a0GmxwX3NuYtQ=;
        b=P6TN1P1Hsclhuy3OaKRoyDpFsC4498j+pm93S107dVOwPLWl3NRNPUWZrAfVlalfbi
         16uALdgn9A/3ntRZFi9+nvq7CpJrrSRfIgJXpHCS2z8QRpdlbJq7oxBmVtO6FgteRn4c
         oGOeRJWQhGxPevOwhQKcTuT3piPRl/PzO7W9WcTjNc0hZr7FJIeVoMfrUHL3TEIKc8hQ
         bMzZC8dgEl/XsRn5LVAf1MMz4dKmIZ+3h/L1uODIbvGn5cZi8/wldmhwBmys4juBXv5U
         VPzvztNQe1LCE59ebLuZbW1VqCzJCqOraSFP1GQgKJckUBq4qWHGCmycLZSqqAsRVJ+p
         7NLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746531377; x=1747136177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+r2etV5TTN9GUy5eqZyzlOSAzsHs6a0GmxwX3NuYtQ=;
        b=f69hT1YN72N+RzwKATAAwHs6ULhJr2FMv75pyviUulNFobALAkNBb99VIeNpGQP+XM
         WrhQ2GHMX98xCiIq4k9EvZpES5OQEod27rWZCxfUMwuNtrS5RWatIDTJSMQkauHRS+aL
         io+vcW5gw/zpxazNrOTaLB+Kh9nDbG5dgOvu2jEoJ3cFn8IyFYWdDqpu8j9y2si+0Emu
         BFaXNaBfBXEl5Pb5IkzCNPoMSCitAdO8VpyVH8O6kRmALHoOZVvTh/eWqFLKKjn0NMYu
         1u31WLGhKZuKPb/NfElAPrgXYnvua9ngRTGVjl2Oi0Xz43E3tz8jN2xmLcZUektsNxYh
         EtsA==
X-Forwarded-Encrypted: i=1; AJvYcCVEcatReaJoGhHsvnvSKzqz3lMoYEHayxmctnihgMH5j2tiQNsTD34z5ChRUOHbA5d6QjdFUiycRzUPUHM=@vger.kernel.org, AJvYcCXLCTLO86FrxTe/yP5xuvApWxlw9EFfRNd9WPH0ioNIU8SW26tV/Q9RyWQCVT3av5WKIjHVpBRsVU+js+Il@vger.kernel.org, AJvYcCXYojOuGRrna1ozM7AvVCrGmHlkVgIxCxghdfzxINy3F4lnXpokEz9F/YMZWJoKyIkAmj3jJ+xgaBhC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqq50BFTK12YyAnkFMIBcNkidl0VA4znl00qXti+HdVsn14FzQ
	BPXNBkMfn2gX1RWPYFbDhkEDo7gUjBF0J2Qg9aoi5OmGoX8Ju6a6
X-Gm-Gg: ASbGncsNThjt4n2z4gswsWm+QDDaFbpRB1NsBkJD/MMJ/AlsM8uW7+gvAnlUMExcL8L
	Xa3dVfxO5ZhIKXDbs0JD5tqGovS21K25TVLy3R3MrkCK0aL1dESTzsqJz8a11gL7DTIa1AhC0rw
	g63QTeJnU8fid6c/adW5PMkYQ68qsh0RzwgB93qjA5vUhsHRfWbq92DT2HZaGLVq7eExlw9JpSR
	jJ+UEKz2v7J/p8pTJMwRRL4jOqsIvFzR5IomEBmBWvRfZ1dDJvShqRzQJc9BLFDHmjN7wUsSEvE
	P8kPSczz51NJRBVi/xCQQz0PVb5AiV1oTH2KOYQXzsnAfPH3kl4IBxunHyOoz388JA==
X-Google-Smtp-Source: AGHT+IE6XF0LC0bfX0riu351c7PSdWNsATp9NoJ9u5v3diJd1yyBdZH6E2imJcSroJJnM0fVZfgakQ==
X-Received: by 2002:a05:6a20:244c:b0:1ee:e46d:58a2 with SMTP id adf61e73a8af0-2118153c0c5mr4211536637.3.1746531377426;
        Tue, 06 May 2025 04:36:17 -0700 (PDT)
Received: from [192.168.1.5] ([122.174.61.156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902154dsm8995529b3a.90.2025.05.06.04.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 04:36:17 -0700 (PDT)
Message-ID: <d0bfbcd7-4fde-41d4-a8fd-796dc7db814c@gmail.com>
Date: Tue, 6 May 2025 17:06:10 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dt-bindings: dma: nvidia,tegra20-apbdma: convert
 text based binding to json schema
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250506-nvidea-dma-v3-0-3add38d49c03@gmail.com>
 <20250506-nvidea-dma-v3-2-3add38d49c03@gmail.com>
 <28757bb3-61b4-423d-850a-70fd5a4c2786@kernel.org>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <28757bb3-61b4-423d-850a-70fd5a4c2786@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06-05-2025 16:42, Krzysztof Kozlowski wrote:
> On 06/05/2025 13:02, Charan Pedumuru wrote:
>> +
>> +allOf:
>> +  - $ref: dma-controller.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/reset/tegra186-reset.h>
>> +    dma-controller@6000a000 {
>> +        compatible = "nvidia,tegra30-apbdma", "nvidia,tegra20-apbdma";
>> +        reg = <0x6000a000 0x1200>;
>> +        interrupts = <0 136 0x04>,
> 
> You gave me little time to respond - 15 minutes - and then you sent v3.
> 
> Use the header and its defines instead of hard-coding it. Wasn't this
> the entire point why you included the header in the first place in v1?
> Otherwise why was it included?


Oh my bad, now I got it, I will use #include <dt-bindings/interrupt-controller/arm-gic.h> header and redefine the interrupts with 
interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH> format instead of hard coding. Thanks for your patience and clarification.

> 
>>
> 
> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Charan.


