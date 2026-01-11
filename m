Return-Path: <dmaengine+bounces-8195-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D965D0F080
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 15:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1691300E03C
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 14:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BEB33F39A;
	Sun, 11 Jan 2026 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="QExsiGGl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86482338939
	for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140299; cv=none; b=TI1hUGy49MVHOLwOi7vqA/1uTBb/zbTeanZV4daG1WX4n6LYWwkqPAL7aH13UFS1S5xrqxnWkgo74kUJWKLR17LfMuwKuEbjDRMmL6LBn/VHCvd7qEPoVV9Hg9T35nlAQSBrFzO/4KOyJcOyM0cvu9jIjqSfA8zSYBMyDWNgHkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140299; c=relaxed/simple;
	bh=btyv13yF1O8eLHTxPRhdfp8TKAEfJvTKBJK1fYmI6Xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nb3Hgx047uv16cm0NAxxiInA5JEHjIfWkMGv4ylp1U0jh0ZuTJ2gf3poFjOtxK2b2wNDgV8U95bvfk9Q3uBVkpswqqVuQMnA15Qm7vwnp+koA4sM6M2XbevLa7/x5Sjx481yQEpVJrFmRhl66pBvIheO3ZtMVGJywEHWiVl2kAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=QExsiGGl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so7208221a12.0
        for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 06:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768140296; x=1768745096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0XwABaHQba0TZXE5KSskxvkqQOly72ac18mmHR+qtCY=;
        b=QExsiGGlElrMbdLuVLF3vOqHwCf+WCT61him0YoQoIEWfiO4yNLyd4VPBUAKN40Gej
         x+S845X0jv6JN0VBlI7arOrMRZmUjNjdywGxqg5AZeDp411nr7Ct3jMkAyw9oGfZ80tp
         9peF5Nu7BK/4h9jjmebrpbIuSLELKFU7zvnFZqdA2gopeWLxeGHjMxwhymx3RIJ7uMfB
         hpCmIW4/qAYok/gFj8dEiDrfBxbl4cYeMBaBpOEfsfmWLMvsLKPHH+jcF56wU5GfMxNT
         Fk83jkyDvYSwRUyk76cF/DEUlxrfU34/Cp8JPQf9+99HmKUb0Ee91SKnRcSXxBM8h+ZI
         d3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768140296; x=1768745096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XwABaHQba0TZXE5KSskxvkqQOly72ac18mmHR+qtCY=;
        b=SIoi41HQJNJK3z+HQ+nx2ADmjvtBJUsZRjeBa1PiB5MihVrCvanC93w1b7iE31stSV
         FJ1ArzJ4uY2zew9OQ0yMFL1unkxUF7w+w8pL55mysnq9yKkDzwGZgCqHEYwfrmimBNVE
         28CaK5wwonhQwHEIRVHOyVmYKCDPxBUelQ1PE2QGv5VTlQw+5c/0nlI5F5b7cBV3L+pP
         70DcYMbOU6I7/ndS6PQZ9MS4MKTrFiUhAuShSDOiwKPU7P5huo+HuqTQ5P+qD5QpBd0N
         CvFirQosxkHR+CE2jza5ZqHAmVNtAll8WFOifhR5TabH7otu/dn2xdPe2OtKfj1SAXDM
         NB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcvahfCj2mvUAju33Of8eTTiYVVkawEWOrtvq5NlhRZBcaDcA2Q7DhcEFkldYP/Y56rIBMD1a1RUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDbkAOzlBJ2zLzMf10l/6H3arhrOPdxOrQSm7ZofxHbgoiYHml
	vX2QhCKoOygwZP6DuC7VBl193yCkyYviqLelJz94oE7NjWVsTY3veECPADtWWoyPbSQ=
X-Gm-Gg: AY/fxX679hZlMwYjDku0w8kdpHJDPp4LryxuuT2uCT9LrC+gPLQohnl22HgzEDRMPNH
	tL7RiJqbBtfosEP80VPu8qmy3XhEg2nBUWzYS0kPCLNmO8HxqUzzYHGcV4nS5NmINVG3bfvM+Gx
	FzfmQJhBrKwAEB7qYr4YBU3M6qnKbXvvz+DKRZ0S/IfU6wgG/Yl/FKMunK3S6/X0GGGBIqDwXOM
	NUAJaBfu1PtXTgACUJoOIgCmQGM7MZmGrdb1L8baXiav91gvbiPdm4842do+XhcjBYNobZC5NV6
	zWLpRb2vhz2qv0fd+jZg2O/0NkDJJWm+p1i+MNr4ZJ0p1GuHoT0Zg1W+GootLBUWOxyP36RAdsn
	OUlmpytZFfIE7UmRzBY61zx9YSkqarLyJ+gy6m/89VKghmXVS2L6yxrMcaPeAGAL4p3B1uBC/il
	VTyEWyDGJHQPeHRv0nEvz50mE=
X-Google-Smtp-Source: AGHT+IFH0IHMLB/e9VMPw+PNQvxklsKe4TmQmjkQDY/3vRiOU9XAUjD+Bmvv1dPy8Ir0WmHAJUU9Lg==
X-Received: by 2002:a17:907:a08:b0:b07:87f1:fc42 with SMTP id a640c23a62f3a-b8444f488f0mr1766243166b.16.1768140295378;
        Sun, 11 Jan 2026 06:04:55 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86f0d6d7c6sm455055266b.42.2026.01.11.06.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:04:54 -0800 (PST)
Message-ID: <3f82d755-552a-4074-bee4-b2660eb6a979@tuxon.dev>
Date: Sun, 11 Jan 2026 16:04:47 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] dt-bindings: usb: Add Microchip LAN969x support
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
 <20251229184004.571837-2-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-2-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Microchip LAN969x has DWC3 compatible controller, though limited to 2.0(HS)
> speed, so document it.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

