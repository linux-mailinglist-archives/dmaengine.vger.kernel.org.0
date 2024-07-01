Return-Path: <dmaengine+bounces-2601-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDED91D796
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 07:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDA11C22222
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 05:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920A12A8E5;
	Mon,  1 Jul 2024 05:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdnCP3L6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A29939FCF
	for <dmaengine@vger.kernel.org>; Mon,  1 Jul 2024 05:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719812526; cv=none; b=Csj9trl5jcPlWScgCNH74mW+Deh8GLUpgbaSqRX2d5kB/pbOmma05bXYY7o3GKPjBAMjphZOn40e98kUdO20FMs1JNEfm/7GBMYw18849K2E/D+72USyowRPQN52dDlhFRLs+gjUh5cpUxCAdFjWU2MpYskjeTDe3qMtkrcv/A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719812526; c=relaxed/simple;
	bh=URBql0tdkG8weo7qslMgXtQqS7z1an3iLJvVeKwFk6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSF7yk9jUIgow5eHg0Vibb6duWAiHIOj7F3rdKuZtZ9Nw360aZMoOy+KMO/JwGH0iOm/AZMthwgIYaR54S2T8QnvX3bvBbjO4NeHvtQZwHSApSBKYJiP96jDTQfYWMqO6qKrlS8t+QaaGCMg4h1Lka9yjx/wDlTj4dUV5+XP2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SdnCP3L6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-364ff42999eso663369f8f.3
        for <dmaengine@vger.kernel.org>; Sun, 30 Jun 2024 22:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719812523; x=1720417323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K1RP7Fpk8x/fLqAOvJCm2fvlERvfv14/xhETHMn8PzY=;
        b=SdnCP3L6fLRyDuWCSl2PrHaSybYB1c8hyciiYFPAn3OBIyVs77uVYSo/gsc18XJvn0
         1GVs3lgubddxKwegjInCCOwumPOU8GZI3lEuRRhLBYCEx7hoPnBznkhyb78UIv5ae1/8
         ekY7LSt/cQRiIsE0cMmL1wT8irmB+6LhkQwiTeTy6CRjiGvQRqnTS5mhy5RMquzvr6kN
         7dfAbFIW5Xm2bephIUEnfSTcaHQQNlH5dnBRwBDjzzuqypem4zDU6yQKzrGAn6UMXwH2
         RP1dad90jW+xBi5DjgkL2GsT2UbDKZnl+POnhFRaZciGEtH5bX78kMn8CV1n+Uxx2gc/
         g4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719812523; x=1720417323;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1RP7Fpk8x/fLqAOvJCm2fvlERvfv14/xhETHMn8PzY=;
        b=t0QiAswfyXozqAQwFcLM+aXSB2C6nHn7H0Oql2YhZT/I9FPZnjQpc1o/qRsP34bBqO
         M0nA4pmbFRB5ExM4Wn1fkcE4DXcO4ygNQUY07zyf5MresIcZ/GtTvYvn//TOLXiCuVm5
         d640ACt8SXx3wcccmyCkmMbmTilMM2ErdNBvWEyAqDx8GcnULY5jGgZpB3wreJz9GxmA
         vCDX1yOETUG3VFXEjMW9xepH88Wfxd8Z+E5TlYsjcwohbuQHcD+zpsz7FWrndbGrDjQW
         2Z7hpUVYGsC8uxB2IDjNSyM9cdAgsEEIVKZuahY4jcV2qHDWpfk5WRKPMAX6MrSLGwuz
         mMAg==
X-Forwarded-Encrypted: i=1; AJvYcCXjm6SOWJUKv2I2jU5g0hPdG3Qg+ihhuH5lufbl9a1z98ujCRaDWz2njvxwQrFbKkqvXsgZd+o6jHabonQNLsrQ/HmQf3j7ieXy
X-Gm-Message-State: AOJu0Yyc4XouOAXAv+Tc4CSKCP1rbs5uJzZD2H3LOeoQQbpWoloe3UPl
	ONXMwNXzjc/qrKvHZy2ODRp/OKMxa3IROs6NwfEXxT1LxNOLn0L0YtnyrvXODyI=
X-Google-Smtp-Source: AGHT+IHSKBmHrhw/AYhWM82y6sx7nEDDCK+Cj+oGMZFjhX97MXohzQV+8dJGlqZohNNB2+Ja+HNgaA==
X-Received: by 2002:a5d:47c6:0:b0:367:2d2f:e634 with SMTP id ffacd0b85a97d-367757249a4mr5411546f8f.55.1719812522948;
        Sun, 30 Jun 2024 22:42:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd687sm9063218f8f.14.2024.06.30.22.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 22:42:02 -0700 (PDT)
Message-ID: <9f1fa742-28c1-428a-9f85-2d3b352abb44@linaro.org>
Date: Mon, 1 Jul 2024 07:42:00 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: intel,lgm: drop inactive maintainers from
 intel
To: Rob Herring <robh@kernel.org>, Chuanhua Lei <lchuanhua@maxlinear.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Rahul Tanwar <rtanwar@maxlinear.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-gpio@vger.kernel.org
References: <20240626101809.25227-1-krzysztof.kozlowski@linaro.org>
 <20240628215350.GA267712-robh@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240628215350.GA267712-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/06/2024 23:53, Rob Herring wrote:
> On Wed, Jun 26, 2024 at 12:18:09PM +0200, Krzysztof Kozlowski wrote:
>> Emails to chuanhua.lei@intel.com, mallikarjunax.reddy@intel.com,
>> yixin.zhu@intel.com and vadivel.muruganx.ramuthevar@linux.intel.com
>> bounce with the same message:
>>
>>   Your message wasn't delivered to Yixin.zhu@intel.com because the
>>   address couldn't be found or is unable to receive email.
>>
>> The Intel LGM SoC was apparently part of Home Gateway division which was
>> acquired by Maxlinear, so switch maintenance of affected bindings to the
>> only known non-bouncing Maxlinear address: Rahul Tanwar.
>>
>> I do not know if Rahul Tanwar or Maxlinear want to maintain the
>> bindings, so regardless of this change we should consider bindings
>> abandoned and probably drop soon.
> 
> No bounces on this? According to this[1], Rahul is not with Maxlinear 
> any more. Maybe an address in that thread will work. But seems like it 
> is abandoned.

I did not get any bounces, maybe there is some sort of redirection
within Maxlinear. I can change the maintainer to Chuanhua Lei.

Best regards,
Krzysztof


