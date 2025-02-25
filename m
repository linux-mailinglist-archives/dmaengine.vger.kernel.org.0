Return-Path: <dmaengine+bounces-4577-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FE2A4461C
	for <lists+dmaengine@lfdr.de>; Tue, 25 Feb 2025 17:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B6819E0095
	for <lists+dmaengine@lfdr.de>; Tue, 25 Feb 2025 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D4194A60;
	Tue, 25 Feb 2025 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AGPOuvXK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E019342E
	for <dmaengine@vger.kernel.org>; Tue, 25 Feb 2025 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501193; cv=none; b=u1+D5H+VLpb7Ua8/2rCUKa1QombUwDY7HU36uqRvoV+1A/LMM/PF5CS4p1TFKERHH0EmVpbOIG2+edcrIODEY1cQdG/jwKpu1ipFonYpRwtFzs/zhJSJHf5TKC/uYkBxDBaA1midT5ZcrjWb+U+2qICHiqoDDo7bbJHpT/MXGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501193; c=relaxed/simple;
	bh=hGWSqIgg/rBZbqcfD2ICgQjcgKFhcZPXUXCI6ZsG+70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sH72WBNZkvbcgKWWuoH4bSGfYAwD5J4n9sPeSC5npTCorKQf3yK9z6+zGDm7t+/h17QQGu3dbyVjUsDG/fEUq/OW/Kf+JXuFpIqAtP4di5lvLjMrMenKHbMuxCJTzYa3VHjy8/TtcE7qKlgqsstQtUWNRwuzKTlr56E5+B2mmeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AGPOuvXK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394a823036so55763675e9.0
        for <dmaengine@vger.kernel.org>; Tue, 25 Feb 2025 08:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740501190; x=1741105990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESHe5tOObnpKqqZ922yCUdfxuhB0YSTVuyOcdcMSVyA=;
        b=AGPOuvXKLC+9ws0AMGpZq8o/5jISLMMuUYac2tZx/ig+Mu3vvseZnOJ1S2G55vG56F
         5cto8FvQJskn28Mgefi6F44w1SBFzmQ5Dxk/rrfPLsOwf23ZPvt3E7NSr/1WqskkStlV
         xHN5p92E66aRGC6rfxWrEIFDbq9BfB6NmRN/4VJPSQqK0vWAhoJrVZyesrg+Ey0Ftwlj
         MJbmXYpyaD2tz3YVdoqPJ7VKt8XFHLMjT3GkDQxvDRtxEUCyI57a+AqeiglpJKJr+p7K
         p5TtJOG/tg96tUsa7z9ZL9M3No8YBCCTG+PuD1s1tc/QgG5+afhFp0sSasIzlxdoXeRs
         yuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501190; x=1741105990;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESHe5tOObnpKqqZ922yCUdfxuhB0YSTVuyOcdcMSVyA=;
        b=NwORwbxsU7w1pXS6MMzpnn+UwGxGlHNx9OddqsitXu52Vhy2CUejRcSmc89VPAW+lU
         DFRzKWICLQ8VNmgVcfV1hCCfBvyyYR3WmzCl6svPCWuoPYlY7Yg32jpph+a6Kqw5Qms6
         W9aWbhNbJ+YeDRRRHFEOX1WM9C38U4l2T9ySaWF0quUUT5+mCFN3Od4LhFqzt8tN8Jmd
         YPceKBqGIHTW8geA/6upEyL913jS6tHjb46m3wWw3ubBA5C+pA/tLaM1kZ3JVqv0H596
         xtKFZBsqOz3hv85IgUsQDBPYVSLGXkPtsWIVpdxezMkECFjf6M5W2HU1ROLBJjPWlOAS
         erZw==
X-Forwarded-Encrypted: i=1; AJvYcCVrvTwIDKzv5asXuqCGHWozTeIBh1ArI/dSvGjXnu066jo3MiMtiVTibkQ31S5nzTLd00zkQhh5S/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhZFT7ovJJYJeMDCnt4u3KHvyLL+n+GqPMKGbfC5bWJDXgpeiC
	NjqYZkTlDUK1D9ySNCN9ZD1pxqC/PRO7il89v8qOZY8IFouF4BM5JrG4uCGeA+Y=
X-Gm-Gg: ASbGncsrjkEapYDOqpy6K+2xNo9AzsJhy+VUiWQk4kQDi4brHRS5JOzqNf/H9zHVE3t
	HbW8+Q2gbppveZfNO8mfxGzXS/uAm4WFbMmbuileD/w+0CZ2BfUYbGi2e6t72LNzkfraic76ZXd
	gMS650D14DEvUwbA07kk/opO/Tednbgj2J9x6/ZB3zy5bVSM+CiHRR/CPjttK8x30XoClKUjVRu
	uAfMGmfctoqX2UCl24KZooftxmnpXvMVNYuF1QYMx1YqNCfga7ZFJB5kstJnYEflP1hl6tiR9Wr
	RkZhHfHjKhIjNFEdMhVrPMGPzKB2fj6atg==
X-Google-Smtp-Source: AGHT+IH8putBj58H1Qc2/Pc5IYBftrUEfWyIiIH/BzccCEeS7d12VbdeMMF1dKqYrd30iJtTHLg91Q==
X-Received: by 2002:a05:600c:350a:b0:439:9b82:d6b2 with SMTP id 5b1f17b1804b1-439aeb34f86mr181448335e9.16.1740501189564;
        Tue, 25 Feb 2025 08:33:09 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab153a7bcsm31838645e9.13.2025.02.25.08.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:33:09 -0800 (PST)
Message-ID: <09eafe54-c262-4db4-b11d-0644a1f90a14@tuxon.dev>
Date: Tue, 25 Feb 2025 18:33:06 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Add System Components for Microchip SAMA7D65 SoC
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, vkoul@kernel.org, wim@linux-watchdog.org,
 linux@roeck-us.net
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-watchdog@vger.kernel.org
References: <cover.1739555984.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <cover.1739555984.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14.02.2025 20:08, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Ryan Wanner (8):
>   dt-bindings: atmel-sysreg: Add SAMA7D65 Chip ID
>   ARM: at91: Add Support in SoC driver for SAMA7D65

Applied to at91-soc, thanks!

>   ARM: dts: microchip: sama7d65: Add chipID for sama7d65
>   ARM: dts: microchip: sama7d65: Add DMAs to sama7d65 SoC
>   ARM: dts: microchip: sama7d65: Enable DMAs

Applied to at91-dt, thanks!


