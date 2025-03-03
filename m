Return-Path: <dmaengine+bounces-4639-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC0BA4CB73
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 19:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3BA63A3F47
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 18:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16E322DFBA;
	Mon,  3 Mar 2025 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aGVYKuGy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCF9218AB0
	for <dmaengine@vger.kernel.org>; Mon,  3 Mar 2025 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028213; cv=none; b=r+IdpJ25cM1QmvWwB+aG4Y5J1O9I1DwQfqdo5MZipiyxNtyiwYBZY0eLotewz7Qe2lzfoS4+hOQHaFTPCYHCH2JJ37SZoOMFBAKLLUnHaTIMsKNsIxwSAsVYa/wR+UVJkakEVo0X9ps6adjyszfs4atuI/L+1lIaL7I9EfpfNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028213; c=relaxed/simple;
	bh=I+YMifaWTe/KtcKWykwnguS02DQwUt/9Nd7ZBZTaipM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emVD+1IwQV5y4iyckTE2Pg3o0Evj33Nx/Nay3soXULmWyRfUhYKCLPsCoBaeZdzgxvAeHqFHIWtWmuPl26vGxRz05dI/NGoY/Kp85AVLY53NK48H+mrkrvQUF0nm483tKHQ4eL4meF0WnQFaiYgjWdZ4gLzJ3J75JKCIL5b39mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=aGVYKuGy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-439a4fc2d65so51800485e9.3
        for <dmaengine@vger.kernel.org>; Mon, 03 Mar 2025 10:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1741028210; x=1741633010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ByURWW4/51grEFFoJ5cNbGWq84mjT1dgOMDzzVdymTY=;
        b=aGVYKuGyOfyU9UcQavzr01XQNPAZs5kAe6gKMjYHl4T7XQjPiPHek5YgM1iqH/1oDM
         M0xI8p3Ty1nK0IPEGz9ZQi0Ti2fi764sF/BZDfJRzJncCTkfG/BV4xA7z4hwkmtdzjLI
         BspErz0GpDg707j8UFSbl1drZaCkibpsQkcmK2/+F4wB8YW+ednOV946QvKqE1UxUMYL
         uahffyCxut23erQrfWsI577jiTlvec0IJqDVFYy29BKWM5xvEgAdxqXmM1yboAzK/geS
         YhgO5eOFtBbhSGu7L54G/fhZfS116c/uvGPtEOEtEQR/7yKFHqyulGPuVWupTgeZ9s2S
         7XqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741028210; x=1741633010;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByURWW4/51grEFFoJ5cNbGWq84mjT1dgOMDzzVdymTY=;
        b=WJlF0qLBV5m58mCVFllJYrs/Jzg1YtmfrQnR7oj33O1NSVrPnpapv7f6Bp9NZ+nxus
         aeZxJyGKp7FrdXrAg1OXR86oXZVJe99L1SJIKYN57GNh4dkpK2QsJMk7hkQqvGRSYlKf
         oCoy14LF10GzdRmAjxzw3YDCtouVCgv7457CJ6jvq9ylTfw3lmNuXPsQH0Y7pqP5SY6P
         N0p/wRoU1/q4yWpnW8dktVxnlUY8WwY1lcDECmt/Sz3KuQAWZ4AtTzGAwRuhXN3cj8Re
         N/uFe0CUsYkod6vr6T30b0dkKA14boL2C7H8G8zsF1FAUcE2RVW0yCMTR6OmUG0kMVSe
         f+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUj7MscxkHhj9ZIz73VcJzmhwWPQo0nZP6DdsNTnrwNQSeeCOxqVm382o2/JEHBjPPHfAorRmVWznc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX3tlB+ggNuxEzRnfwR6FaTF4hye7TnYu/AOinSs/xG4ITeOer
	1YJm5nFb1T/qd/Dp8mMznmunD32gMTZdasT34x+Kxg1ZMA6ZZHKqkMlulfPwH6Y=
X-Gm-Gg: ASbGncvuqsYOA6OT/b9vgya0CW42Y72ZGntMx48kYOX9p6nEipZUR5n4L3QouDK8kUZ
	E5Are7lpzkWTmnCOFlACnSGgPAn8MjI6fFD/QwKXbMsw42TWCKmQHZ0mYEPrwHyj678tPCVc+kF
	rWF12mcNi77SFrAPMEeWdW8P+VbWyTywS+BTriDZoZ6h/hTErY/6Fvn8ezroWk4rk8IhHtcejM8
	E8XleddjY9+4eUt9O0lQb0Y3DF8hsisOr+ADdvEUyOUp4H+7+C0eNxyFXBfsAYD04UOYwCqQ2hi
	dq8P2tpVrX7xZxX+JEANQ8ZSDgShBs6IVhP/OFK+X+PZK0oedt88+A==
X-Google-Smtp-Source: AGHT+IGVUE0CQu4ReThqwR4ny9E8a1exZ2jLsRFt7w170BeB8vADyu6EQUUGy2xTMtQFYKiXpDs9Pg==
X-Received: by 2002:a05:600c:4fd3:b0:439:a255:b2ed with SMTP id 5b1f17b1804b1-43ba66e5f09mr144551665e9.9.1741028209871;
        Mon, 03 Mar 2025 10:56:49 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc9c0fb1esm12229025e9.20.2025.03.03.10.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 10:56:49 -0800 (PST)
Message-ID: <39213e99-3041-4602-9dd2-536e9b09ad11@tuxon.dev>
Date: Mon, 3 Mar 2025 20:56:47 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add System Components for Microchip SAMA7D65 SoC
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux@roeck-us.net
Cc: vkoul@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1740675317.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <cover.1740675317.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28.02.2025 17:24, Ryan.Wanner@microchip.com wrote:
> Ryan Wanner (2):
>   ARM: dts: microchip: sama7d65: Add watchdog for sama7d65

Applied to at91-dt, thanks!

