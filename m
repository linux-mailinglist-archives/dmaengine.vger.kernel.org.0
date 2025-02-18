Return-Path: <dmaengine+bounces-4512-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D040A3960E
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 09:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DDE3B8950
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 08:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5947A23236C;
	Tue, 18 Feb 2025 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Kxu6ddBZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6A232377
	for <dmaengine@vger.kernel.org>; Tue, 18 Feb 2025 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868164; cv=none; b=U/eFNUD+68C/gzRkFK0pxd/sSUFmfRNEIcSB20BX0+WODXQm1vrk3FFchEs3B0kuS3T2CB6/k2LCHrae+WBXhJ/o1GkBv5jSis64yocoAP8gc0UGKPZnMoIlEw7L1cd42p4kt6bsFYsvd7FxxpQeSYBkrS6RmiKOjfZVpAiOr+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868164; c=relaxed/simple;
	bh=saVAfgYPKRn89eU0vt0BwT0rMzRndUiMwLipr4oYYbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmB+Xi0ANEYeviM35vHsFWSHDYa84eEtrnnbHCJYFxqrc9qjhRhY1w6r5P8k9DJ2wXhwhn120hWsuJ4AB5y/NJcwgNMD/1HccdkRi2wPKwG6u6EfE9DWULO4rxxoaoqMK3V6p70y4B4wEw7wGKX1Xg3JhmyDNRGSWSEfwf8CwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Kxu6ddBZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb7aecd39fso472762966b.0
        for <dmaengine@vger.kernel.org>; Tue, 18 Feb 2025 00:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739868161; x=1740472961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ch9WkK3xb+NyXSKj+cn4pbQshkuRqJJ8wERBuOfV3A=;
        b=Kxu6ddBZuTLNRbIgcDobCy8igSpRIcWQOgsgWM7joxsJ4ye+wEUZfdt5QU0scNdn8M
         PdnGVvz9o8n4eSv8JMCZd+5LW3wsw3uwboeRpcqkwtPeKgClHJcTPdTRiIwxZF5+dKDY
         331M8buQ0b1tWdgQjyaY1vsrE4wDzbfYxQglUdTSZU1+L0tsSU3tHjtwlk1GlDszG8ru
         b6Jkw4DcVQhyJbTjZ/KZHghLJ3WhRDZNVfkXmsWxblbZ1XFSUFUp7z0urPrJzzpj4FXv
         EzhVjFf07sPG6rFrv1AWTdMiiGCFq77I5nCDhicX815LDuPtxxkrsSrCi9p/m754FbS1
         r+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868161; x=1740472961;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ch9WkK3xb+NyXSKj+cn4pbQshkuRqJJ8wERBuOfV3A=;
        b=GQBvRmESOpXeXTGMSgXxshgLzFWrVO3ZaPJu3ReAng87RSMFoA8DN1GRtUIZPmmv9I
         qmkAFd4XVFwZsG+aW7ug6g3UETbUy4jvkdUopNYuZNLhqbFdY/X58rNpaDq6VGVTjk5I
         MBIDrjbJ6evCcSnZt34niBkj0f23nCjo+YWq9GLyZCQNqqcufArWZEI6rPFl3oNr3u7M
         l/IG5Y9g/5VET4Bi50sP8LKF3PWmBnsFsBTtJxPF8J7X8CLsAxNyq4t2bacGqmVuCeYD
         Hki4vspPrLmqRBPtps3MWfMxHFWBwTQURp7VkNQyzFvOBAyDh/JrA5Y4FEpT0FLkRYOU
         cGnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZp7uKB9Na4Rarc406N/N+QUQ9cJ3rS0RCY4rbx+COZoBEyoK0Ru6gfmpIKk5xjw9ivLRBS30/BUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx4VrepLA9djcJVzA2+FSCKTsRw9MYbx1GwdYh5ydlY/D9rZi2
	xfCLobVeSPYXU5DDPs83fYPE49mF4i4paDRxrYUcNWQOHIgglQWTW395POx+IWU=
X-Gm-Gg: ASbGncsuaHuCvWSWOSySccOOWENwfrZCYiC+y4U+s3JV71WnuwQ+fjjIBjpFWmFaSbI
	wAQLq/p9l6Uc2rRxpBspVXOp/DXH6uc40I/y+STpa6qpm9IqNwuL49aO2gDk8zaqYMRGq7OQRUG
	sxAww9LBwdSjRTPWaF7xaeg4how6b5foUiulLVlg0PGMIdJEHRGooFT7pA8HgN8Yogmi73KpkLs
	TNkIEHsD53ZMc7IOv2gF6VK677dI075MhZVLDRtJJ1BLNTLbJX3kqb4+DNryYCOz5S1A2al7HYu
	B2RCTDfhOG0VJo+8s2uEaUE=
X-Google-Smtp-Source: AGHT+IGhI03tdLg5oc0plVNCSO2LiVnGx57Sn+cYCVSUBsfb7XkEiF5iSWvlCx7bfmCKQKm3J+y6hw==
X-Received: by 2002:a17:906:308f:b0:ab6:504a:4c03 with SMTP id a640c23a62f3a-abb70c7a410mr933973166b.24.1739868159537;
        Tue, 18 Feb 2025 00:42:39 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5337673dsm1007937966b.89.2025.02.18.00.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:42:39 -0800 (PST)
Message-ID: <a1ebb518-ff69-4dff-a8b4-7c3b716450a5@tuxon.dev>
Date: Tue, 18 Feb 2025 10:42:36 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] dt-bindings: watchdog: sama5d4-wdt: Add sama7d65-wdt
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, vkoul@kernel.org, wim@linux-watchdog.org,
 linux@roeck-us.net
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-watchdog@vger.kernel.org
References: <cover.1739555984.git.Ryan.Wanner@microchip.com>
 <3c55e634f2993ac5a49e1b8bfceb2333e175d376.1739555984.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <3c55e634f2993ac5a49e1b8bfceb2333e175d376.1739555984.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14.02.2025 20:08, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add microchip,sama7d65-wdt compatible string to the dt-binding documentation.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> index cdf87db361837..e9c026194d403 100644
> --- a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> @@ -23,6 +23,9 @@ properties:
>            - const: microchip,sam9x7-wdt
>            - const: microchip,sam9x60-wdt
>

You could have keep this new line after the items section that you've added.

> +      - items:
> +          - const: microchip,sama7d65-wdt
> +          - const: microchip,sama7g5-wdt

here.

>    reg:
>      maxItems: 1
>  


