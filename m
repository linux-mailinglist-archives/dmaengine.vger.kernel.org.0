Return-Path: <dmaengine+bounces-1607-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B374F88F92A
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 08:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28DD2B25C89
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 07:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09D553E3F;
	Thu, 28 Mar 2024 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bSQ2IEQM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C2653E17
	for <dmaengine@vger.kernel.org>; Thu, 28 Mar 2024 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612321; cv=none; b=ZVCnIyUb3rdM8aZxVFs81UKEj8Tj0U78ujyGBYpSbXK92Mu7Xn0L/3/6If6nvN+O2hVKG5HWfcP3FTyaaV/jeAmMO1CiwliRNVJibir446LOHrNgeS/Gw6reCa+j9tqpUBVRObmRleM1lYkgLPG76ausrVWVqtCQuWvEnzz20yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612321; c=relaxed/simple;
	bh=Oi4D9lTrBK5LxMVsvn+m+xvSmAC6nHrSQxGDBSqviBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+XAgWjhYoukV8hhsbsN9gBD9PVdW4Q7/Ng1PnLYdVTdT7IJBXzoSAUQkG67yptxPMgM9seq6lu+9FLsanfnxdbXBEf6sazUgVxouZf3Rp0KSxJ7DVp3srMUqKucOPE8gcMlK53BDZbr6SHH/NjCDiCzKAZZN2eHVfdGBh60aO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bSQ2IEQM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4154471fb59so2425245e9.3
        for <dmaengine@vger.kernel.org>; Thu, 28 Mar 2024 00:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711612318; x=1712217118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2WIu5epjAJHOEWnR5hcLu+XP8J82cuP3g6jjZF3M8iI=;
        b=bSQ2IEQMn8xpszHJwx/k5kzPvGQr1aJ7xVN5DDD3Q2yUVDq2H279NO9BAhSXDUmVub
         FW7i3yzc23EQkUbIb1OsW5oo/OfJsa/jtIRd+6QmGlUXsWDFlX1fbO9MUJUmuE1pMoBr
         Hl8o05NVG5NPAQPAi4yJGW9msXrdun3cxgOdJKHGqrtQhm269hv59GHXgiUdGqmkSLFA
         kB4mwv9Mh+RExoRZEAN2vfcD6pQIW4IuzvhcOoR0aYRMXbW9y51Qua1KT0JdNv8JEuos
         r5uwYO6CQcmjY3puG/6Wk1Ea3j7OD2DjXhaZqBLEdEXR0v/s3JMEkBaE09R5y5RhPS+P
         PeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612318; x=1712217118;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WIu5epjAJHOEWnR5hcLu+XP8J82cuP3g6jjZF3M8iI=;
        b=nMVPywmINa0JQKTHUf48o5X0WAsbExPtzMgIdvM/rd4A4OTXGJaInGyoWAcZldBQ9E
         hGidA3zLHq41uXyUtUjNwswfOtkWz/PWIUuOXHz/M15CZSuoecrD7ENbyjgtpwTOdpR9
         prBVYd5+uQQuRZzIhxzrgkZ8XJcgAFBtgs9lEYwQX41t3bdBsKUdPcGaaa7wzAQE6n6K
         /deoJM5zBxknKX8RcPVOkKBjgZG/+++o1msG0UgcY59mIG8zBe1jmgEissNCY6+Go1Bh
         o5EqtsDUhTdvLnQdAtFazjMV1x2INjw4uTRp2eqkVfANrj0hVavt6KgifT2HbzTzmuae
         swog==
X-Forwarded-Encrypted: i=1; AJvYcCW86t1fuVRAy+HRsFoI5eSu7pGyNJlEq6bp+1eO7fiVc6/ev4ELUc5z9gYKmOCkdwPNgJLel7edhDMDwqJKXvZJ5FptpmJJ3/P3
X-Gm-Message-State: AOJu0YwzMeE1t9eVrqFpvG+jvD5zSxXNcaAYESMV17qNu9kNRPpUSaR8
	8bA91+OletwT/fU+FGZwvH7N+TokzeZ2kHmKeIFprSFuC9FrH737imH31DQsFU0=
X-Google-Smtp-Source: AGHT+IFXMQWdOmZhU5YF1GpARsMqHvRsZ6j2ByO2I8Vygrxh4HD+auy0yyJigMMJuCmYaSgf3lHGDg==
X-Received: by 2002:a05:600c:3c9f:b0:414:6211:14a7 with SMTP id bg31-20020a05600c3c9f00b00414621114a7mr1475302wmb.14.1711612318113;
        Thu, 28 Mar 2024 00:51:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.148])
        by smtp.gmail.com with ESMTPSA id bg34-20020a05600c3ca200b004148cd4d484sm4594451wmb.9.2024.03.28.00.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 00:51:57 -0700 (PDT)
Message-ID: <c33833ad-9102-40e6-97bf-9a4e1bf0a3d9@linaro.org>
Date: Thu, 28 Mar 2024 08:51:55 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] amba: store owner from modules with
 amba_driver_register()
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Linus Walleij <linus.walleij@linaro.org>, Olivia Mackall
 <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Vinod Koul <vkoul@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michal Simek <michal.simek@amd.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-i2c@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-input@vger.kernel.org, kvm@vger.kernel.org
References: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org>
 <20240326-module-owner-amba-v1-1-4517b091385b@linaro.org>
 <6p4cdmbhrezm7fqbe3kgrkblqgrhaq4fgiw5x4n5dnptii7kjp@vmbj2pkjglp7>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6p4cdmbhrezm7fqbe3kgrkblqgrhaq4fgiw5x4n5dnptii7kjp@vmbj2pkjglp7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 21:33, Andi Shyti wrote:
> Hi Krzysztof,
> 
> ...
> 
>>  /**
>> - *	amba_driver_register - register an AMBA device driver
>> + *	__amba_driver_register - register an AMBA device driver
>>   *	@drv: amba device driver structure
>> + *	@owner: owning module/driver
>>   *
>>   *	Register an AMBA device driver with the Linux device model
>>   *	core.  If devices pre-exist, the drivers probe function will
>>   *	be called.
>>   */
>> -int amba_driver_register(struct amba_driver *drv)
>> +int __amba_driver_register(struct amba_driver *drv,
> 
> ...
> 
>> +/*
>> + * use a macro to avoid include chaining to get THIS_MODULE
>> + */
> 
> Should the documentation be moved here? Well... I don't see any
> documentation linking this file yet, but in case it comes we want
> documented amba_driver_register() rather than
> __amba_driver_register().
> 

That's just a wrapper, not API... why would we care to have kerneldoc
for it?

Best regards,
Krzysztof


