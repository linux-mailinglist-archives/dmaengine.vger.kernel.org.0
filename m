Return-Path: <dmaengine+bounces-8194-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DB8D0D839
	for <lists+dmaengine@lfdr.de>; Sat, 10 Jan 2026 16:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9DC8302B43C
	for <lists+dmaengine@lfdr.de>; Sat, 10 Jan 2026 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9415F34B1B7;
	Sat, 10 Jan 2026 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UR3LYot3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5C34A79E
	for <dmaengine@vger.kernel.org>; Sat, 10 Jan 2026 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057798; cv=none; b=tQD7qx+oVsK0vWsy9RxKTdibpTuESG96KsLf7vk+0Nzl9qu46MjtKMirajWZhNzz5C77u3+bgaU3nFERj1ojrOcaHh8b5E50/C/qdONcwCMoe4jZ6MiuRRiKbnSORPnuiibVjtA9QmG9qJluCQfjHRJulJpyM9tALrrT0X4fIUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057798; c=relaxed/simple;
	bh=veOrw/m8cCXNOzS0YhBEMZHiqb+wrCM+D/j1ZadzRgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXQPSZhEvOLYupC8pxvPQnnKW5i1kjV5j5yrpAJFjbl30O538Fjtlj1ki68FNPomAbBYptYgj/4XMnpeCGvmdtLEqsNQal578PUZCcH89bcJG7b7mu8ML0r6PJssDw/BNWmW5286YZZUcOsj7uRwsAgTNDQtbYVRFPUfpU1sOnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UR3LYot3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbc305882so2701470f8f.0
        for <dmaengine@vger.kernel.org>; Sat, 10 Jan 2026 07:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768057784; x=1768662584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZYFiIfX0/KjQWE2M1MYc+2i7VSmAxQXe92tai7T06wg=;
        b=UR3LYot3X99B0iocnSlHLBo6xcEdvqWff5fJcdU9Exm6L/VyIsE1xVQ3sVYgXj7q3/
         AJgsd1EMgirOEF5wAn7H3E2taaHVG0xxbScSmK/eNkl7JVSrD9tlrn9K3U+JEY1JherW
         Qz8doesvUqWD5kfvD+tIrJouA/o6VYr3xVkPxj51Z9B+MKoAfeYgqiPVYyYZKZrNhk/F
         P9bB6TJNL306n/2z4mmOJ83Oy5KeskaYSjMWq2a8PkNrM/SO+irij/BR+IX+izMpqtjd
         cF/nBHWOZQPzwd+sng08PL/DHPEqiDOLBhZ8Qyrf6Ffy1AiCqVfxLza0Qx4ukc3S/Gwv
         Y6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057784; x=1768662584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYFiIfX0/KjQWE2M1MYc+2i7VSmAxQXe92tai7T06wg=;
        b=EgStgBFq51jnHRQTRDGtobqLyFXHOerIdcPzWgY6rY9VRZv4JVdXK6w8WY4SCM50J7
         tbBXAMmkyd1imXxPpFaBMJfPrg+R1DKsdbdZ8Tsi0gYysCwacM7O6AYPtz9WPJk90Au0
         239vf8vjGZZ6OkeXjV/83hcFlmp5B1S5wGGyThDIQebm32aUvo9oz2O6AAaPtHkPBTvq
         2YN7kZsA2lIzaouyeOT9OdNnDRz2LfLNfNIRqzmk8E76WKL+5JLJv5hxTsZjM8FlAzM+
         I04Uhk+5ZH7gPgwRk3lmkDBMqUMjkDQ5dmanyn2vo9e0ipxstatM41B8H1EN4hCamvpY
         NOqg==
X-Forwarded-Encrypted: i=1; AJvYcCXgMOcjzFEe1CzR4ldsjUt59/YM+GGFbGWeOVG973wtRkchPIRw/umbZArtqCehEnmkS2KbQ4o7/G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIBs9mp2owbcpqjvYK47epwYrC3wYMTi+EsDSSC+Pkm96A5Izg
	yPBt787oTH4Qd7iAl4H4TinUQDrOOCx9+Ev+I2d28Y9SWPaU8iiIEU7/CP5xeIvj9hY=
X-Gm-Gg: AY/fxX5o+iYqlU8QzPEoA1ukzaBPeCSULU5Krcf5t0DrItPLEGb3ufOV5R0+CHOiAcO
	ona0kUfwnR6x5phZdxBjHdS39KSlmlETrCaiU3MK/aNhwWX7Bfa+bQAXJ8+eKJVNOv0JrzzQTPU
	6Oz8wsIfzWTOdVnieL174qIzvuwL5B7NLvnQsmqQWC8x0f79mB3m2cGwjdw6olDjWae1z+vEWUf
	I8d8QOn/lsXnEyirf+flCsRDsFUMOz8W7mam5jn4R1l7xnsQJVvzRiCT9Uf6OuO6D5zRYTORsCZ
	8KOxjpyj6TaYNzxpgFoqIL5H/3ImxHMeSLXbIKOm80INdM+VwHlg0753r5/IMpDFbEfP7eEzSB3
	9Ih3nQRcjBjC7VB0Wv+G+WQ8DnpWgasPfMXpzZFi7PztsArzGx+afNTK4l5U1pHXZL8nUG55mtM
	3qfTuyev40aqRPjIbmPe0MOh8blBXz
X-Google-Smtp-Source: AGHT+IHwvRNK+qwBLjP9mJj148RzU5png6+Rsy9u3J7EYhE07UUYa3vVSxYXarlT5BZGC6AC5xVP2w==
X-Received: by 2002:a05:6000:40da:b0:430:f23f:4bc5 with SMTP id ffacd0b85a97d-432c3760d02mr14529601f8f.45.1768057784134;
        Sat, 10 Jan 2026 07:09:44 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e199bsm28208208f8f.16.2026.01.10.07.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 07:09:43 -0800 (PST)
Message-ID: <6c2612f9-97de-49e4-a7c2-eacea2d33f51@tuxon.dev>
Date: Sat, 10 Jan 2026 17:09:40 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] ARM: at91: Simplify with scoped for each OF
 child loop
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Russell King <linux@armlinux.org.uk>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-clk@vger.kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260109-of-for-each-compatible-scoped-v3-0-c22fa2c0749a@oss.qualcomm.com>
 <20260109-of-for-each-compatible-scoped-v3-2-c22fa2c0749a@oss.qualcomm.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260109-of-for-each-compatible-scoped-v3-2-c22fa2c0749a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/9/26 18:57, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

