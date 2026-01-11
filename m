Return-Path: <dmaengine+bounces-8201-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A20DCD0F2AD
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 15:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A7133012A5B
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DAD349B18;
	Sun, 11 Jan 2026 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="isTsJ1t8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7345034887C
	for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142660; cv=none; b=aEfQaJGuzzYK43OjEWpJMzW2b5lbHv7NgzJ3sOo0UB+cJ1nXkbQ2GPuLOk03zEZc3h/baiCU6uhRzg4bgczl6ABfz/0qJSYsXTPTa67CQWUomIZASNCX/0kstWuJO0dKoPjDMS+9keWbGvDRsU8aVfG9E+cvecMA4YqPqNlI6SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142660; c=relaxed/simple;
	bh=w4Acm3yPEzhNfgXHej8RhBm1qF1q4y2VgssP/5Zk1hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3JWS/DZXBW9SzfmiAaAUiBmhElrHp15ezr39SG24pHVi8GtW6LBJQzv4rKHNkkhQe62Uwm1cErmj1j97kto5snhmClZ2G3liFIbhDkEigk83nJR2jrhdsMEoIMNXRUbm+c3AzshXyeobAgJWWmv/QApO2TEBKGaO0KxQieWhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=isTsJ1t8; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b72b495aa81so1072716766b.2
        for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 06:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142657; x=1768747457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vh0+NaFNSqUUr0lRvi0qh/0gFpaLfgRir9e/Vu9U7W4=;
        b=isTsJ1t8ThUdJlPcckoMxmOQN5p6f/iPi1Qz4+ymaOaMGg0HLRsEsqSZm3KEyOWwaR
         ZyJVvDBUIjMFYRKBQWAAqUA2E8lh2ITkmYgecHewN41dPFpOps4j1iduS0RDablFZa6b
         HpMQqEuK2qHm4wLB8ElCKvNNwpBajX3awNIIukUBvuu/LJEu1PULd34b1y6SP3deF3w/
         ntQWAuPAxbyU1xlmVWz0zMWNGEeFBHz89/gZfq4/2h+F0xF4+AreQNuoFSvgXYEv2bpu
         Oy7HVBxdxvC5W0dQ4KZbQxmbi94FjFBo9OMaPT1Trz8YzH8aDwWO3B6X+slFxjvyAKcG
         eCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142657; x=1768747457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vh0+NaFNSqUUr0lRvi0qh/0gFpaLfgRir9e/Vu9U7W4=;
        b=FTdGPsCkwKZtMfMehhdZ/acHqM/JOpT3bq2JGeRy242V4hUouKMD7fSNyCWlBN0r8R
         a11Vt1V5ZHOoaFUZczYur+UCjwrMnUn+p2K7EayaoJwiDNdLxyMWPL1/1AlMefT5cP7Z
         Rp/xi9LJ0g5fXz4AMq5dvuQc/UTRpxkocB2WexOYf9PXrAQ1tKiAvGlI6l5KTqi/sjpi
         2ZssHPCsRw9p8bOPNRqtMW309wlBugvW2WD/X9CMw2ef6IYU71wrm7zJPtkUta+JAAW/
         g0Tq92V44L/uclaLZ7iitjiV6wYx/UuKSWA4ZxnRLVlkMcVX4Un+ziFj6d4u87QWnNq0
         OgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmWsMe5I+KDmxymKFpX85lLvQF6vYIXOQomHVHNVQw8xoIjt+Ktl6LsfwRVGNwMn0hJef3EI+wlnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ7ldroVw7B2nhfYDMym0ox//JrkUbNVM38MeNZZUbzYaPgavR
	qCWnKP1dMoY0vGay1YXKxrTZlhvL/kIIkUO+WoaxFMv9oLc4vUkCkgpeNf6MQnk9SNo=
X-Gm-Gg: AY/fxX6Qg60njiNSsQS1u7SiOXLNa0B7YFSxJrGaUmbR43UNi5G0n/Yk8TtTKJtlPni
	uzwunpwqr+ujzJuEMv1kNRQZ/gp7+WVMtrLz6HBWCyehRRdxdIfP4ME7ctZ78eGBiSivaiY8U6u
	C/EqrjRwUL7yAe+N/Ld1K4jFbMHsBLun3GKlmO2lBp3c0GVQrbw2jRYOT2YWeqT18cQ2aKbQP01
	drD+lJ7m0X3zhyOlvd1tdtSRo+Xpox2fyYtvRZzKoUo/AQDnAmZ8aQYSunEtPijzzLejfJZEUlC
	lRh/W5IP4fe7MY6R6wBqxtc3Y6vn6rvGCfB1j8AMOZXiQl5Cp30P/R/SvG1tcOXifipLGiAuC2m
	Os0XAQfm/oWV+ChfB3WvcWIhP32yn400YX4JmlxUwM11prWEdeojVDoSHxvxhM3DWmgjhuuC5v7
	bJi1oH8qnKRtlv9mFh0bSF+lQ=
X-Google-Smtp-Source: AGHT+IGSkgRdvFAJszoEIUVPnmxFKxpG81LZeaQDTCtjgK8/9NBkGo4UJCrHj8/qs3u8e7/Yxpu5vQ==
X-Received: by 2002:a17:907:96a1:b0:b80:6ddc:7dcd with SMTP id a640c23a62f3a-b84453a123amr1485279866b.31.1768142656775;
        Sun, 11 Jan 2026 06:44:16 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d3831sm1727347466b.44.2026.01.11.06.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:44:16 -0800 (PST)
Message-ID: <bb0c473d-0a86-407b-9c4b-9a39f9985ab9@tuxon.dev>
Date: Sun, 11 Jan 2026 16:44:12 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/15] dt-bindings: serial: atmel,at91-usart: add
 microchip,lan9691-usart
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
Cc: luka.perkov@sartura.hr, Conor Dooley <conor.dooley@microchip.com>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-4-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-4-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN969x USART compatible.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

