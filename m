Return-Path: <dmaengine+bounces-1669-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20918892B29
	for <lists+dmaengine@lfdr.de>; Sat, 30 Mar 2024 13:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C994228380E
	for <lists+dmaengine@lfdr.de>; Sat, 30 Mar 2024 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F7937714;
	Sat, 30 Mar 2024 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bTDp6mzS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A833EAC6
	for <dmaengine@vger.kernel.org>; Sat, 30 Mar 2024 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711801151; cv=none; b=nX/vrqYvvu1uscH3NWND3zrbfu9hA1RlDfp6MRx02YYBacvo1xy0QCXwomllHKub8QFwFH2L9H0AlqE/GfKX2MfcDqHXgF5REncwI/yswHa4D2zogQRmPtMqQUiou61oiKod3OH0O4i2oVTK7F9V89qKv+XGKLvrBwDg5DMcDEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711801151; c=relaxed/simple;
	bh=gnEUiTCGAKgaizTXQISk0bLTxTnE9U1qA4LHHyfKv8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHVv3D3H5HIwGFTnVbXfF40naFVBZJQDZSYEDmA16BRv+z5Wr4eaM0kfcQw2lPi96USyLJ8eO1hOcJgGs71zEqUUv0iViM3O5enW6crZGDfvgHUZNMrTYcwlrQaRJeaLjcaOWe5EnTC4c0kracol+FUJ9RGnTHYKqhbhPUKkXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bTDp6mzS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ddd1624beso1664585f8f.1
        for <dmaengine@vger.kernel.org>; Sat, 30 Mar 2024 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711801148; x=1712405948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pwRsl4tW7J5i09nNsaEN0WbRHBKT2ZFbRiuCSTzWq2c=;
        b=bTDp6mzSAuWx4lL5cooxcDpZ9W1mea8O0kdKPspePGuynZIKtNZ/QodKPUZUYN6Sxn
         bqgHPtu7au3ng4zlAbkXPtudj/aOo+e/SYgeh3gbkQs3UFieCRn6QafMakiJalsq+lK3
         hRdc3OS2wTijyLDh8yYEofGgKTNGupdxOeqdDR9HQGdzBeiJpnXWjIZ/5X/bPmICFzv6
         Q7CGGrTCphDqmfQ7M/Vv0ypdsFDyCkarg5/LBvAAefhoqAV1HezQHE9XBLoiN1+Ekq9f
         QadJbIRoslyjrl6gukO+WRurbyLtrkeopHU0OJvO2+HQbPl8W+KV2yiYvjnied+VaIHN
         I0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711801148; x=1712405948;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwRsl4tW7J5i09nNsaEN0WbRHBKT2ZFbRiuCSTzWq2c=;
        b=dQlIvX9kGDF3eIg57zKWYdf/Zr5iArVvzVvM6NvkC4V7tUvuhusmULLNnwHotKbR1u
         pvwCZksd7xqFdZ1zQ8sY3fDIsfVU50pCjrlaQiJXopgBBcr4/0SjNsDHtm6ZIvjhEGGE
         Qe0Hl3ipvh4fAZfOVtKtFyrtpVTLJPZIVU035LNSqJZvoAwVTbNm9r0C314YsS49rsSR
         okQLO9oWfJR2Z1OgAzhk+ASHP7/ZeeFujbyGXZEdvnScFMEenZ860Jfl4aakkSyQ879r
         myK7hCgwis0hrH1PLnfRzg5kawHnjHBjOMNR6q3Nz58b1euGljAf6iVaKadat/skTtjf
         f8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEWcs1TEIK5AzGA/WbAVuWhgxL/ec0lCDbMC5f4avUPrWYqnDuV0jGlOjpQqXDRcV/I9XdIHuPEe2sh1bxt5DVJ+H20frDHRds
X-Gm-Message-State: AOJu0YzQLHq/95LW6GcoAReqd4sMcjpFf7VnK9JLlkVzNMXHHvWkx5Uw
	x24OmyMDZrDlGw/0wMIILdXqZ1073mBvt+3kqeVC+5IN4Ns14KRnFdyT5R8cLL8=
X-Google-Smtp-Source: AGHT+IGxitXr7L7h8CUcKtleeDnrSZmBoUk9QkYBw9ltjVABur0LBmd4a6MEByPy5E4LS7vzmYpyOA==
X-Received: by 2002:adf:f403:0:b0:343:39a6:93bc with SMTP id g3-20020adff403000000b0034339a693bcmr3335018wro.11.1711801147697;
        Sat, 30 Mar 2024 05:19:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v17-20020adfe291000000b0034174566ec4sm6339522wri.16.2024.03.30.05.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 05:19:07 -0700 (PDT)
Message-ID: <edd167fb-df0c-4434-8f9f-7c4016b87d83@linaro.org>
Date: Sat, 30 Mar 2024 13:19:05 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] amba: store owner from modules with
 amba_driver_register()
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Russell King <linux@armlinux.org.uk>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andi Shyti
 <andi.shyti@kernel.org>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Vinod Koul <vkoul@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michal Simek <michal.simek@amd.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-i2c@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-input@vger.kernel.org, kvm@vger.kernel.org
References: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org>
 <3f61d6d3-a0d6-4c49-b094-6ba62d09ab14@arm.com>
 <f23f2e60-e5c0-4c3c-9722-dba63a6e7ef6@linaro.org>
 <d8fa8e1a-b2ce-4d91-9ab5-ad1b160111c6@arm.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d8fa8e1a-b2ce-4d91-9ab5-ad1b160111c6@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 10:22, Suzuki K Poulose wrote:
> On 27/03/2024 05:57, Krzysztof Kozlowski wrote:
>> On 27/03/2024 00:24, Suzuki K Poulose wrote:
>>> Hi Krzysztof
>>>
>>> On 26/03/2024 20:23, Krzysztof Kozlowski wrote:
>>>> Merging
>>>> =======
>>>> All further patches depend on the first amba patch, therefore please ack
>>>> and this should go via one tree.
>>>
>>> Are you able to provide a stable branch with these patches once you pull
>>
>> I doubt I will be merging this. I think amba code goes through Russell.
>>
>>> them in to "one tree" here ? We have changes coming up in the coresight
>>> tree, which would conflict with the changes here (horribly).
>>>
>>
>> You mean conflict with  coresight conversion to platform driver? Worst
> 
> Yes.
> 
>> case it is solveable: just drop .owner.
> 
> Or, we could merge the CoreSight changes (as they are really not
> affected by the problem this series is trying to address) after the
> base changes land in AMBA, via the CoreSight tree.

I'll provide you a stable branch to fetch. I was defeated by Russell's
patch tracking system.

Best regards,
Krzysztof


