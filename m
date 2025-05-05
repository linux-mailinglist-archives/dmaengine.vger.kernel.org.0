Return-Path: <dmaengine+bounces-5063-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A6EAA9A55
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 19:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021871899CBE
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0F526A0CA;
	Mon,  5 May 2025 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K7kdvSAD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D62C269AF9
	for <dmaengine@vger.kernel.org>; Mon,  5 May 2025 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465713; cv=none; b=Zgy6Lrb81e2kXhsLI+2Yc1b6p4mfpxdjmyALGuf7psCAXN+DhddweCftEiYoETLJYAPWEgoT7UxkGalIle+l9v/ZX0Av0DmNO3nB1fSkxzquTd+IlfcFG/DpKR3ktLdte9HFHhmm+CaW86hFNqnio20dyn73qEyHH0ZaMto+jk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465713; c=relaxed/simple;
	bh=jcGEKN2FQmLYABFrgCfyNuY3i79lchvxrUlZtZoKNYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doQitbi/XCUa/kksbp1rRmFv/hDGSKElwjfsjl7Ofe3GVxG2zBaG1r9BvNIFtfX7rGZBEucIrVDELZjeicBH3AgMDG4mOP9gsHAitde14XE+JcE0pxLwhnVv4niD5Oczf31d2dfZWKXqDqjhcg2YWtCqTJVPrqxjvJuGGAjk1rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K7kdvSAD; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72c3b863b8eso1225517a34.2
        for <dmaengine@vger.kernel.org>; Mon, 05 May 2025 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746465709; x=1747070509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRVMb9oF5CEf/GpTXbkBHrDWFxgCwTjNlgPwnh4zqIU=;
        b=K7kdvSADgbh5WKqOoV0ictJAo4+XJkhJuOzEjOPJxHzFkfVPD4IDU3ihxXft8gSfEJ
         j8N4o0+QA6uinEdgMoVJLxPNbNVxnqxqwUTnpRfYb7YTRc1vUKoWJgozqF9sm/Bis2GU
         Pofw1VvzmATH3N3dQuMz+5Xa2yje8PkW/9UgVctXF65S2U8Yr4r1sBqxJRlZwkSzWKI4
         Q8Jsm7NE3ofShY5JnLtTZ/BYVrkP3vXVhjiP7sFpzQ6owq4ckXmVYGe9y5d3UeT1yk5D
         rXzDDVLaMiqmrQTyNmokFYKYBmsAgxuqiX9h3oBtI0DDi1EBmsa1ROeedR7RKvEV7goA
         N15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746465709; x=1747070509;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRVMb9oF5CEf/GpTXbkBHrDWFxgCwTjNlgPwnh4zqIU=;
        b=AwrX5mE3v9ftCpn6a3e5ePuaZlDwHUphOIQmSpvmMgpgB9nAsmlUl1fk/zIFHf6IMG
         rAzlGfJvuIve4XaJrN6TDF4dWgk9zTCkytb0sPXeGWVRZnRMAUq4+ARNa6a//n4wmkoc
         NwFm+VOvK0Q81qDbaZCC18Vx2Lpe3Xnm9yo0Mmk/d9ns0KdDglkwjM6/wnccNNLz27IN
         wNuzLJg1sJLQbFQBn0oTV7esNjg09GnqmJV9/YW5XM3WaQIFCQK7/KfeEQIKAtPVj+UN
         oIbirl8El1sdVZdEtk+KINheo5B02Vs3MYrQPw/TtOYbh46YFG7KkT+90lHRXx176YSS
         RBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHbCrNSzosslQ0jD4PIeC+bbmJ7U8jVWxJXVrq87jvPfW6AZkXt9ik4Q31XOaF1vRX4O/87HcAn+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgLCt0nAYUuQNcb+ZZJBkVBEEvBGnWeDWkf7IToXZVZNHl4Nj0
	vbFD8iVEGHwgJTWqPkgXVYEqdHoWXyS+8fZJj/D+kVR3W/+PwnQZFHhhPxAgEwk=
X-Gm-Gg: ASbGnctbMJMcazgOoWNxArWZGYQirpefMMMOZcoduuBe08IBIfo/Iy3Hjwg8V87SYEN
	Ka23vlhiNIPdwYUaVoW19tlUz5RnbxZQpv5FgsOJKLZdVUZJm4l+Jb+1OkpYDQoKNuCo8Psd41U
	rgJ9D8GdqO8IyWyuXBDwGG7zVoRQoClItlYvIucCRQFbUyRrcdrVFw6NRy2+RlSufxdAtM5DaoR
	jxF159C/m1KiSVhXfU8gkcgHQb5GS5F5X94773VgmF7sMCRWhFS+ruON95YiimVnoLxfprDFX0Y
	BIwprUbEkJXm5l4H9Ott2sAW6X4JuVBuiEMZCxEQhRZoObxZpieU132aUcz2LWKLCxz7Qazymmv
	wPXpbg+85xZup258=
X-Google-Smtp-Source: AGHT+IFcxApnoYjUY0w6idtC1pck4OIRHQ/tTPu3UVsNzFkW+p8gRi5HDRVw03HtHe1u6yZcOoXfUw==
X-Received: by 2002:a05:6870:4790:b0:2d5:2191:c8b3 with SMTP id 586e51a60fabf-2dae861a902mr5241443fac.29.1746465709654;
        Mon, 05 May 2025 10:21:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2151:6806:9b7:545d? ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2daa1207873sm2127468fac.38.2025.05.05.10.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 10:21:49 -0700 (PDT)
Message-ID: <b5a5a8a6-bb8a-44f0-ba94-7657aba83311@baylibre.com>
Date: Mon, 5 May 2025 12:21:48 -0500
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] clk: clk-axi-clkgen: fix coding style issues
To: nuno.sa@analog.com, linux-clk@vger.kernel.org,
 linux-fpga@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Moritz Fischer
 <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>
References: <20250505-dev-axi-clkgen-limits-v4-0-3ad5124e19e1@analog.com>
 <20250505-dev-axi-clkgen-limits-v4-7-3ad5124e19e1@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250505-dev-axi-clkgen-limits-v4-7-3ad5124e19e1@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/25 11:41 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> This is just cosmetics and so no functional changes intended.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/clk/clk-axi-clkgen.c | 74 +++++++++++++++++++++++---------------------
>  1 file changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> index d8634d1cb401fff2186702354ecda7b4fcda006f..63b7b7e48f8fa00842ce4cf2112ce7a89fa25dae 100644
> --- a/drivers/clk/clk-axi-clkgen.c
> +++ b/drivers/clk/clk-axi-clkgen.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/err.h>
> +#include <linux/types.h>
>  
Might as well sort the rest alphabetically while we are cleaning things up.


