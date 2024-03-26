Return-Path: <dmaengine+bounces-1510-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B5088C13F
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 12:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F651C3ECF8
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 11:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6756CDCC;
	Tue, 26 Mar 2024 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="efXwt10d"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB41B6BFCB
	for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453839; cv=none; b=k1Hr4Q3eJlZlQK6VFjx9IJi4NX5szv9/FssHIubkerv7WjLA8huuQFs6f1GaTw9SOB70e8ZVQFLEWGqrosLbhaZZE3GJ3ntGwNu3yEl3rbboxQd/UEPR9ONWZK7IyXq7x3gxZy87JJwPKq+5GSbqrBdkFqVIcvIvKAAq1Mytk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453839; c=relaxed/simple;
	bh=zIsRPBERtYd9KT5eFf4SlflyWfRi00voryrIaoJ7HcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i43ayJIOKDzbJsY9xRYU7ZTqfTRAegTaNsqgqArbkcDKrrG67ir7PlYx8zC8jfF5q1RcJOi3LDKrn5oOUU3fdTQC683rRTk2cq7Oo4mFrFK+Ucynnzr4Ayb/pvl+BzHHrhhg36Odp/SaR0tyrKq83ry10cbE9yD06c79oZfQvwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=efXwt10d; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a466fc8fcccso694963666b.1
        for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 04:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711453836; x=1712058636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+RQirBONGT7g/mBKFr4U8ujDZu4jx0LwzCH8oxof1pw=;
        b=efXwt10d+TBl/th7kmwdARkdsJ550WK7fniQuY88pwMOqDEyGqZPepJ+NuG02/w/kV
         Lzksz8gyOcA6soelNFE1voH5K2gjvbBFfoq2gXapfdCqwqkPQutCqy6GOcEYxU9iaaO1
         Nd9Dh86DFpjQ0bSCmNJoSLs43tw4GlVh0NQ5ZB27TLQq4MydQ+KIncicELEAxDlqdtNP
         xv+V8apMvGHRQFwvhAgrXcaf1hulQKcxeDg/KCaFJXJnSCzm9i6CE21GtRK5fy7NvgLk
         j8L47Pp/lj82jVm3WFHP4jDsmxQqNQM73jKAeqL9RQH4/gRGS0HEf6ybFXichUHoGPLx
         Yz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711453836; x=1712058636;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RQirBONGT7g/mBKFr4U8ujDZu4jx0LwzCH8oxof1pw=;
        b=SxnaIL0Xg5+U+vO/7E1wzgaTpBipi74oe3UEogl5n5SNYVJvMMlZqcg4EF5UmTf5F/
         Yi1gfUtdqP9FPp98Tw54QNuf7TPlfgnaUHL4i3M7hggkZlfnGrob9jH97DC9Uahes2gD
         /H6gxeAYCdIod9zehdYZ2OFQT7KxKShhwXlHovvtKCupaTqHLmnbThSuE3eF9+LN5aPZ
         0dCoCErLu8W+8XtOUlbyrXIo7iFDI79wNPK9AMthvPfxApsrSPPa7FGNNhZZ7tfD0J6v
         Sa5m7DBXRZj1nM0FfOcwZ8NCzrjn4xMub1QIB6pDD8Xi1Xy67TZFwDFAH7JEBJXFI76S
         8Fnw==
X-Forwarded-Encrypted: i=1; AJvYcCX8ZzkaFE+ZU8mJVDSjeWBjc9zAtMlg7elQ8azsjJ3mXsPne9svbAfAQ+u2nIxepkEVmHyzD3u6WBlN/re7uQvkMm+p7hLmxUU5
X-Gm-Message-State: AOJu0Yyc/OhII1bU7XhFo4DwqI0ETxtaVmQYhL65+wHX8GZ2u7+V0q2z
	J5GQ+VvRcVuCrbWFPlg6X2FBXyg8WaIreGbr53O62G+eJlcXV1+2Azi6OZqikkk=
X-Google-Smtp-Source: AGHT+IHpoEVb/26aK2O+7U5or3L/IkOBa5iS8jIYohvuDTytIFqlj/I8s6WOjKZTQm/IuKv3EZnZFA==
X-Received: by 2002:a17:906:2810:b0:a47:2036:dbc4 with SMTP id r16-20020a170906281000b00a472036dbc4mr654986ejc.25.1711453835868;
        Tue, 26 Mar 2024 04:50:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id kq1-20020a170906abc100b00a46a04d7dc4sm4148259ejb.61.2024.03.26.04.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 04:50:35 -0700 (PDT)
Message-ID: <1525c377-af73-4204-8a2b-983c6d99316c@linaro.org>
Date: Tue, 26 Mar 2024 12:50:33 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: dmaengine: Add dmamux for
 CV18XX/SG200X series SoC
To: Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>,
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E2937788D9D92C91ABBBBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <57398ee0-212c-4c82-bfed-bf38f4faa111@linaro.org>
 <IA1PR20MB4953EDEEFC3128741F8E152EBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <473528ac-dce2-41e3-a6d7-28f8c53a89ef@linaro.org>
 <IA1PR20MB4953517450F0E622A66E9A7DBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <cf42e020-9a5b-48bb-bc14-c0cc9498627b@linaro.org>
 <IA1PR20MB4953EA589A0FF36DC6FCF0E8BB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <IA1PR20MB4953EA589A0FF36DC6FCF0E8BB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 12:41, Inochi Amaoto wrote:
>>>
>>> The driver does use this file.
>>
>> I checked and could not find. Please point me to specific parts of the code.
>>
> 
> In cv1800_dmamux_route_allocate.
>> +	regmap_set_bits(dmamux->regmap,
>> +			DMAMUX_CH_REG(chid),
>> +			DMAMUX_CH_SET(chid, devid));
>> +
>> +	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
>> +			   DMAMUX_INT_CH_MASK(chid, cpuid),
>> +			   DMAMUX_INT_CH_BIT(chid, cpuid));
> 
> I think this is.

So where exactly? I don't see any define being used here.
CV1800_SDMA_DMA_INT_MUX is not in your header. DMAMUX_ is not in your
header. So what are you pointing?

I don't understand this communication. Are you mocking me here or what?
It's waste of my time.

> 
>>>
>>>>> And considering the limitation of this dmamux, maybe only devices that 
>>>>> require dma as a must can have the dma assigned. 
>>>>> Due to the fact, I think it may be a long time to wait for this header
>>>>> to be used as the binding header.
>>>>
>>>> I don't understand. You did not provide a single reason why this is a
>>>> binding. Reason is: mapping IDs between DTS and driver. Where is this
>>>> reason?
>>>>
>>>
>>> It seems like that I misunderstood something. This file provides one-one
>>> mapping between the dma device id and cpuid, which is both used in the
>>> dts and driver. For dts, it provides device id and cpu id mapping. And
>>> for driver, it is used as the directive to tell how to write the mapping
>>> register.
>>
>> So where is it? I looked for DMA_TDM0_RX - nothing. Then DMA_I2C1_RX -
>> nothing. Then any "DMA_" - also looks nothing.
>>
> 
> It is just the value writed, so I say it is just a one-one mapping.
> Maybe I misunderstand the binding meaning? Is the binding a mapping 
> between the dts and something defind in the driver (not the real 
> device)?

Binding headers contains IDs which are used by the driver and DTS code.
Hardware constants are not bindings. Register values, addresses,
whatever hardware is using is not a binding.


Best regards,
Krzysztof


