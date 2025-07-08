Return-Path: <dmaengine+bounces-5750-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75130AFCBC2
	for <lists+dmaengine@lfdr.de>; Tue,  8 Jul 2025 15:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A4A163249
	for <lists+dmaengine@lfdr.de>; Tue,  8 Jul 2025 13:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F522550D2;
	Tue,  8 Jul 2025 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qvoF8QQi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E4A22F75B
	for <dmaengine@vger.kernel.org>; Tue,  8 Jul 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980905; cv=none; b=fObFx7hd4so/opyPfOoACXy6BWJFO7YZz57Alwx/Fzgqnu3JlYaL0jijizxJkE8or1CDnTcxAbtK0R6zFu+o+PDsMifegNaWG/wC7VsYDbqUkYbpmqzIfES7GbMGxp3omYL4bCqO11O9gx+MFX4KWdE5txnS9D5OcgdQ9D2JNSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980905; c=relaxed/simple;
	bh=2yab2vCXAQ7b0O98Jnl0MCXdfirx43553TtNR4iz3K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVlh7TmvXNdko5tkTG5+mqqNOwXJJkt0croPfCmcxKvNh8jCVQ0IT64vHceNkl8TxDOt7ZxsNpd4YKNYIlM3irc4o0/X4V53fmL4XuW7wmk1rbOfNZIMmhF2RuxXV5oZQaQ0ldhjEea+DfuECs1Re4LXcOUtoFvnjXwGFpPAQXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qvoF8QQi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4535fc0485dso5036435e9.0
        for <dmaengine@vger.kernel.org>; Tue, 08 Jul 2025 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751980902; x=1752585702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dvvfjjW3xAddEV4yoFwAXd+ZIVfjy4w3ByllVwazu2o=;
        b=qvoF8QQiq/mu3mw8/dbofudhCJDjZ6IB4OsZJ+4bIR2QT9bxqe0R2fnDne6U0On7Ii
         CdWuhI8ZQrLsj2ZrQME+Oxpdp8X53YDXbo56l92/ELNeq+GVDxCLAQ112K2sZmfo1+aE
         hV8NMAZ5iye9TfZ+vpLXRormJ7/YQSn5cuKroxKF2hLVapJ5k0zHAKCduoT8Stqk2GW/
         6yHtzLeG44Cr8xs3NfK6MN5SOs+DWfgJWxuOQqJx2sY54gCIb6PO0/qxCZGj/zMu5fcF
         QK1vqWq9vFa2cRDuqY2t7X1toRRbWdEPCEa24+H95kMJzBp1rOHe2FA8UiwUz07czdC6
         WCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751980902; x=1752585702;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvvfjjW3xAddEV4yoFwAXd+ZIVfjy4w3ByllVwazu2o=;
        b=opV+lKfx27DGxunO/LoNM5lhGTPZhbUdfgaVG5PIlPt3GP5zUP6ArzyEUvCDLTciC5
         62WXFU/yrf+03ENvn6W8l7e3AokWspMXuHaMGE2bPEE3FysoD275OB7zXWrrp76GMP9j
         T5w+TNcRuRCjuDFQqFo7e7RVIbjwTHo46fa4NzQAiOKm3b1MLQDj4SsGsTzA6wz2Gynw
         +XAZrQ4d9nBYvx61hYO6jhLdrirQ4hs5eGc8C+LPR56JdhD+1Q8Ai4BZjDobo6Tl8dXU
         WDgIUSdiqUPiJ58jmnbZNqMD56FwimKeenzPhGepHGoaJjh4V+WwuOBVPtVJ+Tp0FG6w
         E12Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuIPITyn1QBf9jUPta3gixaA4otpRWWRwo8TKXcrW7AIMmOoJ+lpkOKzsp01YZ/FA1DyM4+cEIC1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YygqUqwsEhxhW4JrOqYesjkQsOWQQOS8q4fcT8sy7V7FyLzA5OT
	6dK4j1t7+flByRn4nuvIPgasWDC6oVgQN2n3JFIjix/6BRacskAwQCOLb1z6mmkQYsE=
X-Gm-Gg: ASbGncuKkxwkG+zHdSaSm/B8tPZ9SE/RrR0Zj4IdpM2lS+xTguYqXdcKmC3phCSJOAk
	Zj2so6VMjIFSjLft0Eoeg0Z4yicakA88Pdxzu6Z9VpHZYcKusqwMClH+ULlXSHIhiOWk01vXehT
	NvJz9VK5nBwDm+n0ClnbwNlW077k2hB/umjB25NeQ6IoWBCVcIYtBTPjhjdZ8FQQkiWAuZR5amQ
	GO7GcruU5pm8H/tJegC8jws20wo2ArXNe5caQu1WHQV5+GBx+7eTvrRAPbBnwDtTVwW9K033ZIf
	Vl5HfoZyjcy35itPFfZrglzDfcmw9aPGFBnS7nZ842Sr9Ycgbq+Kvd1UXfLL4WJFsa1/jzj0Ed6
	hiCebAw==
X-Google-Smtp-Source: AGHT+IGfH1hyCCuApZ/PbUkNkSLbp9c5bKTr/wL67Ccgc7rui+jruH2h0fyJtMX0xUmRb8nMe9Jqew==
X-Received: by 2002:a05:600c:1552:b0:453:6332:a98c with SMTP id 5b1f17b1804b1-454b35ef640mr56819015e9.1.1751980901933;
        Tue, 08 Jul 2025 06:21:41 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd49df05sm21614625e9.33.2025.07.08.06.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:21:41 -0700 (PDT)
Message-ID: <99ca93ef-ab26-4d6b-bc7b-fd2f98aecabe@linaro.org>
Date: Tue, 8 Jul 2025 15:21:40 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dmaengine: sh: Do not enable SH_DMAE_BASE by default
 during compile testing
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vinod Koul <vkoul@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux-sh list <linux-sh@vger.kernel.org>
References: <20250404122114.359087-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdUn=qOoKp+tNNCepb1eBXpnikJxg8w6aRR50QK562tE1w@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <CAMuHMdUn=qOoKp+tNNCepb1eBXpnikJxg8w6aRR50QK562tE1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/07/2025 15:07, Geert Uytterhoeven wrote:
> CC linux-sh
> 
> Hi Krzysztof,
> 
> On Fri, 4 Apr 2025 at 14:22, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> Enabling the compile test should not cause automatic enabling of all
>> drivers.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Thanks for your patch, which is now commit 587dd30449fb1012
> ("dmaengine: sh: Do not enable SH_DMAE_BASE by default during
> compile testing") in dmaengine/next.
> 
>> --- a/drivers/dma/sh/Kconfig
>> +++ b/drivers/dma/sh/Kconfig
>> @@ -16,7 +16,7 @@ config SH_DMAE_BASE
>>         depends on SUPERH || COMPILE_TEST
>>         depends on !SUPERH || SH_DMA
>>         depends on !SH_DMA_API
>> -       default y
>> +       default SUPERH || SH_DMA
> 
> I think the check for SUPERH is superfluous, due to the dependency on
> "!SUPERH || SH_DMA" above.
> 

Indeed it might be, but I must admit I don't understand the dependencies
here at all. I think commit 9f2c2bb31258 ("dmaengine: sh: Rework Kconfig
and Makefile") from Laurent made it confusing and this later just grew
to even more confusing.

What is the intention for "depends on"? This should be enabled when
SUPERH AND SH_DMA are enabled?

SH_DMA cannot be enabled without SUPERH (no compile test), right? But
this "depends on !SUPERH || SH_DMA" suggests it could be. This should be
read for humans as "if not SUPERH, then require at least SH_DMA".
Otherwise what is the meaning for humans? This driver will work fine
without SUERPH?

My change for default could be rewritten but I don't understand the goal
behind current depends, so not sure how should I rewrite it.

Best regards,
Krzysztof

