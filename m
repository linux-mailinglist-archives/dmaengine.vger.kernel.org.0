Return-Path: <dmaengine+bounces-1542-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303AE88D5B5
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 06:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A891F2B481
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 05:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FE2D26A;
	Wed, 27 Mar 2024 05:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJ4cvSY6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B963BF
	for <dmaengine@vger.kernel.org>; Wed, 27 Mar 2024 05:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711516058; cv=none; b=iyu3UICaeQfnrMoRJHLnC1VJGjA1ENE0rBd0/KsMIzzBvr7hTKDe335/XQDreIF+l+IKWWtQmOfKyEh6OW5usl5LZtWsbxlnZb/acr3X+jj8nMc2uKEWjyqfy0eLyTuAlN7AlZcCBkMQaeN1My7ko+XkCARdZRn7/KKxTxN5WhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711516058; c=relaxed/simple;
	bh=6hRrPE77vMG9UB+u2FZ3N08FEfbvyAhJGxbSd6EuVlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgV+xqs0ChO27qknhWzUe3XBxRqhGOQRXQOZi2Df/RDOINR60Cdifq257DIG7DdGvcGNEn6A8XRQ6UVOsVM1d3IHaDYwzAOhCUZI6ppFHGCe5WdBmI8HNSnvG/tQ2U4eB3SjfQpt7ZDmztvMs++8+NHG5bB2b/EvaNeswmj2krI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nJ4cvSY6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a468004667aso846421566b.2
        for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 22:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711516054; x=1712120854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/j/wkfnU1VMtlD/kDo+x6lLCbpnn8+R/4k1WBBOkFIQ=;
        b=nJ4cvSY6gnVf4RRHoeSMIHgnar5jPBgsCwbnnW6oSdwx6NrcvEb3w50No93GB2LVhf
         /PlRabLRgZV5JZz1QhBJgs66UDJidTrOe2S86AanQ3O+meXq5lOY+06eQvicBhRpKyCR
         kiqERp/I2widroPubgcF508ITqKMzG/TzXxwBKEVIa2ftAZTcoD6PgD/VhZ+v2TTV1tA
         WirLlFulCjEX4/cMMsw6waqIzAh/Jo9GpCRmhsRxVGOhRF7lW9SwGz0P+MSgkW05suEe
         jv+JKIdzG+S0oTXVXL5iybsv7XdoEzDTFkjr82ORR0Rkl3HkMmHx0DptNcGA+R9MArEC
         wbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711516054; x=1712120854;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/j/wkfnU1VMtlD/kDo+x6lLCbpnn8+R/4k1WBBOkFIQ=;
        b=ZZSrqtVEvi6iAqqsrb9HJT9F3M+v+2NgyoiZm98WqhONyrH1X7FVrFJJP+jqQFo76a
         GmY9RjdrmRizHQJ4NirzS8rmaaBZPQe84awFLl823ryZzFMLF6dXwHJiyrYcrN4Iw6sp
         i95UaXGGlKWqKMA+EAOx5/JSyocAuLhfGTia9T2OgqjMWo+55XhtZBjniv1nEFIGCI49
         BNKNkxUZHaYQ8r2cpnMdvglvp6OVtYkj6j1XwJqlPSV/Kg/wxrN3Ydw0dlmW1pWP/1tm
         2Ia/uTW8/3fv+7kWZUWB+TDNxYO0xcoeYuPpxijVqQsnB6CkMa40iJU2Q/oZNzQQeU43
         KYYg==
X-Forwarded-Encrypted: i=1; AJvYcCV4YLHHTPJV9xssnvrLwvn7OD6Lkz1e+FdTex7nHEY7AJDW8wwogtDpYsOmxqkivy2lxFwmhZZ14stI0SGolg7bvz7AtiH8eV6S
X-Gm-Message-State: AOJu0YyWJQ2x6VXv5IN1J96+7OL6DVJEsgWfYjQXOvmFwf5F9dHV8h8w
	IwG5U3V9Pto1ocd6t6AaBGF4E/y2qZIZyTsKzCXGKS/BB7x0OPItCNwLUoUIz60=
X-Google-Smtp-Source: AGHT+IHlo+FYMJRDViGKDBKHGZt4C85CAdTPEoXLJs8oiXtdIa99YCUHjkKw6jicrE8R7Bo7TiFa/A==
X-Received: by 2002:a17:906:7cd:b0:a4d:f2d9:cf1a with SMTP id m13-20020a17090607cd00b00a4df2d9cf1amr1965395ejc.63.1711516054468;
        Tue, 26 Mar 2024 22:07:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id l19-20020a17090612d300b00a46cffe6d06sm4950533ejb.42.2024.03.26.22.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 22:07:33 -0700 (PDT)
Message-ID: <a16f45c9-747c-4a19-98a3-aa5f47ee5c4d@linaro.org>
Date: Wed, 27 Mar 2024 06:07:30 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/38] ep93xx device tree conversion
To: Andy Shevchenko <andy@kernel.org>
Cc: nikita.shubin@maquefel.me, Hartley Sweeten
 <hsweeten@visionengravers.com>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Lukasz Majewski <lukma@denx.de>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Mark Brown <broonie@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Damien Le Moal <dlemoal@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Ralf Baechle <ralf@linux-mips.org>,
 "Wu, Aaron" <Aaron.Wu@analog.com>, Lee Jones <lee@kernel.org>,
 Olof Johansson <olof@lixom.net>, Niklas Cassel <cassel@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
 netdev@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-ide@vger.kernel.org, linux-input@vger.kernel.org,
 linux-sound@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
 <dc3e2cb4-f631-4611-8814-0dc04c5502f0@linaro.org>
 <ZgLgY11N8dkpTZJB@smile.fi.intel.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZgLgY11N8dkpTZJB@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 15:49, Andy Shevchenko wrote:
> On Tue, Mar 26, 2024 at 11:19:54AM +0100, Krzysztof Kozlowski wrote:
>> On 26/03/2024 10:18, Nikita Shubin via B4 Relay wrote:
>>> The goal is to recieve ACKs for all patches in series to merge it via Arnd branch.
>>>
>>> Some changes since last version (v8):
>>>
>>> - Most important, fixed bug in Device Tree resulting in CS4271 not working by Alexander Sverdlin.
>>> - added #interrupt-cells to gpio nodes with interrupts-controller
>>> - fixed some EOF in dtsi files
>>> - fixed identation and type in ep93xx-keypad thanks to Andy Shevchenko
>>>
>>> Stephen Boyd, Vinod Koul PLEASE! give some comments on following, couse i hadn't one for a couple of iterations already:
>>>
>>> Following patches require attention from Stephen Boyd, as they were converted to aux_dev as suggested:
>>>
>>> - ARM: ep93xx: add regmap aux_dev
>>> - clk: ep93xx: add DT support for Cirrus EP93xx
>>>
>>> Following patches require attention from Vinod Koul:
>>>
>>> - dma: cirrus: Convert to DT for Cirrus EP93xx
>>> - dma: cirrus: remove platform code
>>
>> A lot of this could have been already merged if you split it... Just
>> saying...
> 
> But you able to apply DT schema patches if you wish.
> Just doing? :-)

Me? Why? DT bindings are supposed to go via subsystem maintainers, not
DT tree. Plus, I do not apply any bindings patches, except for managed
subsystems and none of them are touched here.

Best regards,
Krzysztof


