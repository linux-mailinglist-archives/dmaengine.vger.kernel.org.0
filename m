Return-Path: <dmaengine+bounces-8200-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B307ED0F283
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 15:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B367B30210EB
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB63346AE8;
	Sun, 11 Jan 2026 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NoTM+k2S"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BFF342169
	for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142635; cv=none; b=bwhq3Iv8+RtFYuStg8WNYRbd8msxOjCg43ivGuyFurcdijOfqZURkQq6FzUelBRK/WPHOC/6gNpzoqeHiL/r726L7FmflqIiRBATbTfaYUMdsgBKhxv+OZTJsh2pPK2zu/+m68/LPMU27BVXjH2rJ+c7zqcRFqBgAMWy4Y58eiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142635; c=relaxed/simple;
	bh=PnoQRnuiOPkoaR4OWKdkvM54htM4YQiVOhdkWK0qg5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ts/hkKfXBBLB8zPo/DpDfMAtXhrkBCDBJ1Jn0MybvdijJytY4BXPM2rHq1OYhmG/WUglembGKGLx0DlV6nI6nsNEqlmefS6FmJlyTUFugJBMJuQv6K5eg80HDc/bECnU3HGqVqc1aSpIKE3p3YtwarFFVDI95tKZFTI20p10Dt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NoTM+k2S; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so922355566b.2
        for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 06:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142633; x=1768747433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J8ivZWfcmepYc5T+3Up0ol6uJ6XFnUAYmd34ka9AIUo=;
        b=NoTM+k2SO5HylCVHcHNqCec7b7gBIoX2QQd6dHlIYohJij5ffigE1XqVlvs93gRqWu
         zSIkpxTis8OI66sDUEw9DNOr0vv38lEu0MABsxGfO4mb7PU0O/BAenxo8CfbBvrIUjvJ
         LRD7tBDt5dQcbYHF3oqbQYYGIp7uzpqccEsipOONv2jXTM+d2xEwUlLYcgjMnPd3UHaG
         v1LNXlJiyOp211uIT/EXTZAXo6ZwY2pa/ypM6jMTRJzxVWBG9VG0jzGXdKX5J6OsbGrT
         +1rzoSd6z1syRrs42BwDqXaqn95JEU2D+Qx2+rM7+dRq6TJYCADcu6Rbo1rrtVkRqMN4
         drtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142633; x=1768747433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8ivZWfcmepYc5T+3Up0ol6uJ6XFnUAYmd34ka9AIUo=;
        b=J6DGTXeupoNmRJTEpgZiqIEKVKyf9NHjiI2F7Y89VhQa9sJqgSbuGFG8l258l1d4HY
         TG+bB72tVvGDd5jTgTJeFPI0o+285NYchbNByuERIk2Z/F28815nWVum2krBx/Oiq9BN
         zAHSuSJcO2edUFnY4YNPQPNnmxdDXB4xvJsKdxguNWHNzIXu0zdv1FeLiG4vWIMuDLh7
         6G54dPM2QwJBM25leEpmjUOk+S15P4TsqersjLJtn3QQ/V6w5u1GOzOplIrkOmYQTtvq
         3sWa+9MMQsaGJe86LOKvYGxzzLN2hbKGCUGM5jkjognHNQY8UqzEMcMHwevPrw69gLJz
         5uXw==
X-Forwarded-Encrypted: i=1; AJvYcCVUySt4j0SolybM1Y9HDOQIozmKm5EsWKRZ08hMPDZX7tzbrBPsyHu6c1lBRJZCagtfC4QxgaKLhx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBhr16lGouqwI5AhhmeHu11/GBRoZds2hHZmKP5KAFaGZ0lQfZ
	uZ6yC+zh8Dy8wYwNFg5JdY6WxeGkBC/mHNQke7Bi7bm1c/bUzCL/s78d9OyoS0pAyjM=
X-Gm-Gg: AY/fxX7TF4kg6HeuKyQHFhG9GOnO3CVBqohdt4SjMqo01pxJFcVJDUwIUDEzUPq0J4a
	n6MTZ4q63fAA1gxCT866mFp3T22bdHpvz/939vVGOH7kHosYnqnbNzhiFYPFrVwhjnqSULGZjYb
	O2hW6aRliAzrUivL0DAoU/ujuvm8olzarAtpz16l1JhWLF6hhMZcPHYYe5ijj3n0Wo8x85D0ZyG
	OJMKZl8W/FYqS7MTRmGwEVUN5Ra7el+5U7/2Jo0a71/NC49bzAqkhI4vU6SwiFXul6VwYXBZLBJ
	ivsJzg0QiBbGRXC64RDVjNecf86e3BT/d3bRnwFkJtDx3B6OPlq1lMWKfjUZar2vw51ZiddHQ3R
	SobQ8v3ZlqQf+lgwV6FoxsK+GdcqorvbofhnTE/p7qFdWBVbhqlwKYk6jKUO9I1tV+YpcCd8aNE
	HI0t99SRRNS6O955nCtCHOJSA=
X-Google-Smtp-Source: AGHT+IEIDu7YG5XG/nu65TCe1ZGy2PfVFAGljLAgOLVEydIa/k97PZQn/n1VHfMaw/abNX/NIg40nQ==
X-Received: by 2002:a17:907:980e:b0:b72:5d9c:b47b with SMTP id a640c23a62f3a-b8444f6f7dcmr1568524366b.36.1768142632630;
        Sun, 11 Jan 2026 06:43:52 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86ebfd007fsm491365166b.31.2026.01.11.06.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:43:52 -0800 (PST)
Message-ID: <d97c48eb-ebbe-4742-a4f6-220d4515a65f@tuxon.dev>
Date: Sun, 11 Jan 2026 16:43:47 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] dt-bindings: mfd: atmel,sama5d2-flexcom: add
 microchip,lan9691-flexcom
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
 <20251229184004.571837-3-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-3-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Add binding documentation for Microchip LAN969x.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

