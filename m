Return-Path: <dmaengine+bounces-8197-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0C1D0F0D0
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 15:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DC57303A007
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 14:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ED234029C;
	Sun, 11 Jan 2026 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="A5h3J93L"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C4233D4F8
	for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140345; cv=none; b=Ki7Jss+oFE5KUrF4NwPJRJYGuwsFMvF50JYT4BsvC49bi3vEYb3/rGhiUx7UvAwdTKDGa3b151PkiSAHGyL8kkq4lcJ+4NJ6DCpQD9DUBldSNfhGCIO4MZM1v7cUKOCo/tOZHQQi1+NeQ9exdBmhhfjR3MJ/Q2Fdk8fuL/CAJws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140345; c=relaxed/simple;
	bh=La7kZA2oSwRqBuL7cT5ghruILrR4PN0GG8fEmUQohxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErCeBMgHpDv53pOr309+ccsw7AqFZgM7fPXg8xOCzi0sZAIPykLfl4ciO3aOMo+Hs4Cb6nXL2WQzA2uHcukRAB1xfg9LiHaniFonbfzMJ/qp9IeVayPo4zw2AWJTMuW789DUsapfRkASXtprSarFwayBZGlU7rhvuqlFM63aE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=A5h3J93L; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b871ba73f49so9424066b.1
        for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 06:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768140340; x=1768745140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXunsOKck5NLaqPP1pj13fhYNQN15zYs+l2jwEoFO8U=;
        b=A5h3J93LIBKbImOKSk/PuMD1cA9Z5C6EZEowbXbuQQWRqoIAibYcsoDlQw3TBJfR+T
         u0BiOjCEJXktgpsZjOdLv3j4NKLAL6vWzf02hINhGw9gtNLdyMqKWd3DOyEcZSvo3jYX
         8ZK4HrP0vXDrFAoG6NVNSCZ3YaSVLqWlNr0VD2t95cLlw4Jh61dPCSWNeQ6oulesS2tN
         wj79fRG7ILgJ3A7li2jIzTbZtZZjrXs2jKlLHtMo0WNwEe++CfnFmumACmX2K4HiMsrY
         hZYR2bZ1STtKcGYBa3SuMqw2+bwsgdTMBUMyBFpULbdi1sES9VrFIvs1UBE/wqWbzzwP
         APAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768140340; x=1768745140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXunsOKck5NLaqPP1pj13fhYNQN15zYs+l2jwEoFO8U=;
        b=rdX2M9iSmmm1UXOxh+sscm2SIPY2rTeukPyk7CpbYNPHI6TpSAiYrp/oSo0s1jMYcs
         x787lQ+7EwKFZ8IJP4Ifl3DYWOANzjj0R1KZewM70OvCOiHgXFSc/SU/m+OzMWdAy++j
         YLMXtHvo418ZToZ5E8HNhWgizzVgv62yWN23aXNtBlHPAMOnUJitr0H1Krr9Glu78T3+
         nQpDo0M6nwTnAMxfSS7V4k8CggAF5+2uE1GdFHP6t1lt3MLSh65mhEWbUNedbJgFy10U
         lGtweuL9/WbIoMqLuabYEb3YwjXbmH9gcWp9Z33q+Q2dMxTHWdGQ74NXXD4wYm72jkk2
         fG5g==
X-Forwarded-Encrypted: i=1; AJvYcCVeKBNn42beedAUM7DI5Y5VZyZpKHYw58/SoTiS/MsUogGZ3/EfePZ58mVbeA7Aq6K1+I/cY+xgvFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGhi+uPtKyIUBu+S4dQCX2SE0SpJfXimadheYkU+2zzTEuvN0N
	MFDirH5zGAASTQ+sxxsET8eYFl5KSucbnUFenaJ0p8yy/GdMO9r47Zw438LXcqJuO3Q=
X-Gm-Gg: AY/fxX6pTwkSB+4uaeMl4PaYNRFS+cQA2oC/cacJrgWFRRfK1q6kiWPzJdte12Mtg9F
	GjY+r5GD7eWBlnQbMC0nfeeFWzbqiYCtPS0RY64roVU1bNL/GXne4QFLcWRfwJhpP+oyTd7tQJV
	UreB1XB03KiwC69iQTOEpyPhKYR+bsrsvsnFHgv8eG1GHiA/NymBjc03CA83YmIZDih8gTbiwoi
	70KCJXwIRadgx8p7Svl4UjZFx4brb4MR4xJSby6Th11J84DKFMI5+ly0mNHE1+EahdswGukTq+O
	3dY6U3YjGXanLS9ecJSF94W5YArGu+HL30Eyw7wFg4fvyHkLFPIJwlHRp75RkxWqhnaTc3EKmlo
	fHNF3XiOCFOpsFcctdagIyyvNAoicIA6mkMZ0c5as/KSZM9vWxn4wGcPLtkk5Z0wvxeoFZC2OWA
	sXrc/RNlbKTm2Os6zahw93GOGtfr06v947PA==
X-Google-Smtp-Source: AGHT+IGAomJOik8MqjiZHm7eirNShLlujIRGUrfTNhxgz3sez9ZGd+euk5Raj7DyHYRFF75x4SXADw==
X-Received: by 2002:a17:907:3fa1:b0:b87:908:9aca with SMTP id a640c23a62f3a-b870908b37bmr200612566b.9.1768140340256;
        Sun, 11 Jan 2026 06:05:40 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86f1e95273sm439916866b.62.2026.01.11.06.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:05:39 -0800 (PST)
Message-ID: <05184245-9767-45ef-a4a6-d221f90fd20b@tuxon.dev>
Date: Sun, 11 Jan 2026 16:05:33 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] arm64: dts: microchip: add LAN969x support
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, vkoul@kernel.org, andi.shyti@kernel.org,
 lee@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linusw@kernel.org, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 olivia@selenic.com, radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.org,
 lars.povlsen@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-14-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-14-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Add support for Microchip LAN969x switch SoC series by adding the SoC DTSI.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

