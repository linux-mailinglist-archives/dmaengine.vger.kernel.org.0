Return-Path: <dmaengine+bounces-8045-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62552CF6B7C
	for <lists+dmaengine@lfdr.de>; Tue, 06 Jan 2026 06:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15A6F3091F57
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jan 2026 04:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9161E29B8E6;
	Tue,  6 Jan 2026 04:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aeQ2T6sO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053529D293
	for <dmaengine@vger.kernel.org>; Tue,  6 Jan 2026 04:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767675438; cv=none; b=PZGBWoYoUppl8/6QI2v2Y96Y+4q4b/6YhDTTavbv2O4D+SJFv5Adnmwd+++2dCP475FPaeJjL80kH/2/Fs0mMqU4j1PrUkebLnm/bX4VvUrobAYVQsKV1m0RNSdxvLK6cM9wJZgOqshShkV/GUn3bnHAf/fyloI9FZa8JRUMgGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767675438; c=relaxed/simple;
	bh=p/jbSDGwTWmm/8mvuCIwU/V1ZevpiU/zQiFsYrx82/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyeQIegvfoAOPDKLxEyipRr7oUh32VreAbx83TzQpTvcgRF5DX41Q5sILIsjTtHw8P8opLfPbzs0+y0Okp8+Adg7crzCDI/stZyKF+NGEKO4Osaezp6JxSwfMetbVCWX7kIweXmLx6BQCbWnc1dBJkS9JyuWkivFUEletZkEbRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aeQ2T6sO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b75e366866so271562b3a.2
        for <dmaengine@vger.kernel.org>; Mon, 05 Jan 2026 20:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767675435; x=1768280235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oOlNWZ1ASjDiM8/EVArPiKc25ePbXneuyrH70Dm1FmA=;
        b=aeQ2T6sOEkR1IaNfr8UXMfSjh5qNK9MAaImJemXo/+yaLOlWUpH96nV3QHper9tI34
         rStl3Qqi/+bJGF/tWh6e7blPBEVBGE5/J8w+1bJwzmGFyCvyRAB2yJ4z7k+QSDJYoVjh
         ZAZBdYid28yGTZiwlQ9yzvAODUwazplO3gt0p/5TaEiUgixO19rVgQiwOme1hiNf3j2v
         yj9nm7qQKzJ2lggijzxUa58ddpfA7DfBv9F4SvJPBQ/44tNXZRnFbcouUl8PC3u2qiiO
         bgesopMTThGZA9EhIY/ib3a7wH2eh1cElOLZtXJDAzo0jujY3tJsyxbi7E2/WFB0ZbWX
         oQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767675435; x=1768280235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOlNWZ1ASjDiM8/EVArPiKc25ePbXneuyrH70Dm1FmA=;
        b=CBnzNo1U7jGx49zpbykHlTIrV1NJ7e3rYb1sLjMTQlitiopQQC8UQ93vM/DVS0FhE7
         hLBedym571BR7rKNLvJYjAek0TlrsZ8YtgB+kWurQbU6yDbJmvOeFGNMajZG6K4CqNPs
         NkaT8d4y+pPhgn5KPap3vS1gtyvm4d69qRBlcqXv4bZQPUfyZW2PyHR2tb1k6goQkdHn
         JCT7u3e2s4FELGZmfyt/1Yb2UTCfVK1iohLBGbhHtE/2niEHxlf9+9goX09+7nNFQc8M
         emTf172IKnkNb9ZmBaCKBbOKcStuxc36DfQPV5qQi1jrByZVdowc2p9sT/I2p59REa2v
         Gp9A==
X-Forwarded-Encrypted: i=1; AJvYcCXnxpHYkml//rpxPdBLaW9o36+hyRkJPG5dZfJ+iU+2WMJRJPXYrSltSpzsTkXVKO7iaH8oHpmFQTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLDGG8J1gC41FoqPQ7xzWtg/RKmKKqxzhLgOi3KHYdk48Q/VkT
	jKRT/kdgyqXpYIua/JRnF1IA+BmGKZzL1RbbpxYAZbXUViOcvnDMKJEr8xBXYIFOtOU=
X-Gm-Gg: AY/fxX4GrNzObahNQBwU4BUdcsbaYKHMycnSlcmMQO4ttkfNHuMPG26GlYWZKPN9zHm
	dDr+esXIhj4ZBbX6fpBPVO1xZoqMciQw6hVFoolnOC5lTmQN6wKNp0kw5xoFmK7n1F73YhMP1CU
	C4tused2OIcyk0jLIu0+6hCC1T/a4NvvOqBLsKVbBoLJtL7oSIHz+EkC4nsqoCgbydT+XqbbvEA
	eKHZBiMQsadQTkh9TRYa/nk7/giy/5kP9KPctvsxVjRHLR/rYrKfa7FKaMkW35t74CubI60iE1X
	jQjjzRBssJ9BZLS1YtEnLP8mi/Ey8IhAe7J2l6kfUXa+qw62Rk0h0Sk7RyKzyvoUKlhdul2hvDi
	N1dgPDgfLcxotw7oCZN9inq0kPQdgGt0PR7Un/Tlsm++HkR4+X+mhCW87Nq1QNfKA7sEZf81Vkv
	7VAdhRrbql0ofDFxyYHoCStA==
X-Google-Smtp-Source: AGHT+IH1HIV++y2p498uUKeXICIqTonP/XkL+xU6dt4xBDj6CXKEeUOGv7lJojUw920KVFSDaG10IA==
X-Received: by 2002:a05:6a00:ad86:b0:7e8:43f5:bd3e with SMTP id d2e1a72fcca58-8187f78d9fdmr1867900b3a.42.1767675434866;
        Mon, 05 Jan 2026 20:57:14 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819baa1936dsm727051b3a.12.2026.01.05.20.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 20:57:14 -0800 (PST)
Date: Tue, 6 Jan 2026 10:27:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Russell King <linux@armlinux.org.uk>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	imx@lists.linux.dev, dmaengine@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 11/11] cpufreq: s5pv210: Simplify with scoped for each OF
 child loop
Message-ID: <g4k2qdsihxfawfsi5ie3w2fhbsd2x6z5heifkcte75c2w3sjg3@cofrjgaiilta>
References: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
 <20260105-of-for-each-compatible-scoped-v1-11-24e99c177164@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-of-for-each-compatible-scoped-v1-11-24e99c177164@oss.qualcomm.com>

On 05-01-26, 14:33, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.  Note that there is another part of code using "np"
> variable, so scoped loop should not shadow it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Depends on the first patch.
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index ba8a1c96427a..e64e84e1ee79 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -629,19 +629,17 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
>  		goto err_clock;
>  	}
>  
> -	for_each_compatible_node(np, NULL, "samsung,s5pv210-dmc") {
> -		id = of_alias_get_id(np, "dmc");
> +	for_each_compatible_node_scoped(dmc, NULL, "samsung,s5pv210-dmc") {
> +		id = of_alias_get_id(dmc, "dmc");
>  		if (id < 0 || id >= ARRAY_SIZE(dmc_base)) {
> -			dev_err(dev, "failed to get alias of dmc node '%pOFn'\n", np);
> -			of_node_put(np);
> +			dev_err(dev, "failed to get alias of dmc node '%pOFn'\n", dmc);
>  			result = id;
>  			goto err_clk_base;
>  		}
>  
> -		dmc_base[id] = of_iomap(np, 0);
> +		dmc_base[id] = of_iomap(dmc, 0);
>  		if (!dmc_base[id]) {
>  			dev_err(dev, "failed to map dmc%d registers\n", id);
> -			of_node_put(np);
>  			result = -EFAULT;
>  			goto err_dmc;
>  		}
> 

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

