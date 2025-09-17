Return-Path: <dmaengine+bounces-6596-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42840B7E6E6
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 14:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1BA462CF8
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 08:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E992857C4;
	Wed, 17 Sep 2025 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lkePpMzL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC88C305075
	for <dmaengine@vger.kernel.org>; Wed, 17 Sep 2025 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096011; cv=none; b=NQ2afEB+Q6Grlywnqzl1AMoGjPvunnEjK6puhflgvMkEV5qaUY+JGbsge7Xr48nFplYbwl3NkCDwjcme+BzUJXhstGGh1DEmTC3I0bcuLSr2rNfZ2qxAHScfOXI/4Gl+CTD6ilFYwUoXcGx3ryFKcKoTkYDvydVeNw5zQEsy6xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096011; c=relaxed/simple;
	bh=dq3u9o5VWwtiIVB9KcK9a0uDpon6l3TwOmFBbD+ZsXQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqiHM+mZNthF+5SPLqUjG68QjMLfsJ0vi0F4NKd4bWzbEoO5TUEQ5RCtSS789QoiBoNQiGeXLmxwk7g6QLuqMuLTCqPP0khqJw+vI9TlqJNK+dyWDZ06ULTujdVk6luAACBTowp32b2P9PNQJ2tocSiMdW8bXyoAR1c91E0+p0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lkePpMzL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-573855e2afeso4036302e87.0
        for <dmaengine@vger.kernel.org>; Wed, 17 Sep 2025 01:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758096007; x=1758700807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UEKtnillVVFfRZ+5u504JAMAMZFI1GIHyIZay2lch2M=;
        b=lkePpMzLNcm7aCq272zukiz/FVDmvMyQlS67iwrPiPQOXg44ECBVrtKATxCROLXrPg
         UEfhItceDdfZFf4tyG8LN4L0Hs2ZddvbYwXOzfLty0jTvVJCigbDP0hWkaav5ftIqp80
         i4A11ruQpDhXCpBAchMuU6XdF//4OS51z/u/kkAab/+wsCc4YLMN6+2Ob/ttMZRej/cT
         vRNa0qUAd/kQChcXtlOzyZc3Wq/wKAQhOs0p7p6liV2vpDWYGhcLSV2FmusnNpz05Wbl
         vz8WKXGxBfnynnSYfAP81dljJWUdNmSSKnRoNUL3CdiyeJCrLkyTtKEZ5rZcOqm3ntyq
         LFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096007; x=1758700807;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEKtnillVVFfRZ+5u504JAMAMZFI1GIHyIZay2lch2M=;
        b=LlI8G+IvKPNW7zaswlM/qqfA8D+AZL+fm1sh8xxUrQI/3icypWpRMVjUnJMvzY/+w6
         OgpoMxCUpXv1OlpYmDkuYUq2ieDg58FRgYTS7gJKwPiWaeFZIbOCqk6+/jx98Jc2/JSV
         nUwP8HYnTfUdmu/bbeh0HNAWFKTzmJXADICU8xR4ZQlfVmO3Z670LEGwKJ0Sf8FN3RfF
         3m0lq/6sRJ54xKiOTWIAwOVuTCiATBSfr0+NjmVTEf3kQg73Z0auH3xPhMeHuy/QR6ED
         l9fzjSfmJMkWGteRUmuJz+Vu9SoESlnKfoMIFtoPfeACMEE8c7UISjvc8hPxVWkr+JN2
         Ma6g==
X-Forwarded-Encrypted: i=1; AJvYcCUljIv1heFEOvpoJP4YRv6Laouu4zfIIpZ7x/k3qHa2YjsvOeK9QeVJRzL83AWenYXtb/q3dfCJ2Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsD/7Cmg/qSu9rs5B/tdVDK3ZTqtEHXTAtXkAvQFWB4CioIZ5C
	3Zrmcg3wxilW91dU3bwXZqCfN74z3/kP40Hm4lmMfRRKmQhDoiyJ4anDyVc3vFzCp/oQlJpoxB7
	v1lwaeRkU6orCJB96/XVQEs3k2eVeKCUMmyS5sC2IhQ==
X-Gm-Gg: ASbGncvXP6xHyxGlNz/4+LnOyXS0pJ9HZ6EfLIu2lHPro0mh+V7hWA3IiTg3p8wYKl3
	bdgQGpNh6shj8tM+x3Qd6BOfZ5Oswzm9Q8UZLEK0I2ohJQPOmfGorkRu7eUC1hb25fskzZ1lK+J
	AubYQaqR5PE9MnEpq2nDDdxXoPg/Th62ODwosGkHAvP7FJbQa8mGoPivg94U1/WnQsSZWgiiKli
	2a4mO4=
X-Google-Smtp-Source: AGHT+IFb7uT1amCYEcbDk/aG1gXDqhuVxynj2vweh0X8HkHwURxRRNA23Yw7fUXf7MR74tQK3DcqqGV4vVXMX6Mmtb8=
X-Received: by 2002:a05:651c:1503:b0:35e:401e:a8a2 with SMTP id
 38308e7fff4ca-35f653c888emr3283521fa.39.1758096006643; Wed, 17 Sep 2025
 01:00:06 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 04:00:03 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 04:00:03 -0400
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20250917-rda8810pl-drivers-v1-17-9ca9184ca977@mainlining.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org> <20250917-rda8810pl-drivers-v1-17-9ca9184ca977@mainlining.org>
Date: Wed, 17 Sep 2025 04:00:03 -0400
X-Gm-Features: AS18NWCZjow2-dnpLe_oaxtKdrNMg3nTySj8u9HPhpYEQB-s6-z3-oDqLWpwlyY
Message-ID: <CAMRc=MeHQf_Oa2DRR0T7tum-Tuk3qPh5r5gimxGY3EXTyvoKZQ@mail.gmail.com>
Subject: Re: [PATCH 17/25] drivers: gpio: rda: Make direction register unreadable
To: dang.huynh@mainlining.org
Cc: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sep 2025 22:25:14 +0200, Dang Huynh via B4 Relay
<devnull+dang.huynh.mainlining.org@kernel.org> said:
> From: Dang Huynh <dang.huynh@mainlining.org>
>
> The register doesn't like to be read, this causes the SD Card
> Card Detect GPIO to misbehaves in the OS.
>

Hi!

Sorry but this message is unintelligible, please say precisely what is going
on and why you need this and why it won't break existing users.

Also: the title should be "gpio: rda: ...".

Bartosz

> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> ---
>  drivers/gpio/gpio-rda.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-rda.c b/drivers/gpio/gpio-rda.c
> index b4db8553a2371ae407fdb7e681d0f82c4d9f74b7..56aaa9f33d29469dfb1bf86ed7b63c54b413c89c 100644
> --- a/drivers/gpio/gpio-rda.c
> +++ b/drivers/gpio/gpio-rda.c
> @@ -245,7 +245,7 @@ static int rda_gpio_probe(struct platform_device *pdev)
>  		.clr = rda_gpio->base + RDA_GPIO_CLR,
>  		.dirout = rda_gpio->base + RDA_GPIO_OEN_SET_OUT,
>  		.dirin = rda_gpio->base + RDA_GPIO_OEN_SET_IN,
> -		.flags = BGPIOF_READ_OUTPUT_REG_SET,
> +		.flags = BGPIOF_READ_OUTPUT_REG_SET | BGPIOF_UNREADABLE_REG_DIR,
>  	};
>
>  	ret = gpio_generic_chip_init(&rda_gpio->chip, &config);
>
> --
> 2.51.0
>
>
>

