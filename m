Return-Path: <dmaengine+bounces-8205-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8AFD0F365
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 15:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6592D304BD3D
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 14:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D8E34A79F;
	Sun, 11 Jan 2026 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="g58+wShN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB69E3491D3
	for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142744; cv=none; b=N7y04TEhBT6w3UHYTVCljS+/q6JapVPJebh00e+JKLN94nDSN3ZaNJGc1WROofX9HuYC5AgBqHtErInLdn+vR8PllXeJCrppSA57EkIe4fSYVdmZjhixULvzR9rRw/r30SGcAUBRHki9cn3VAsdLjwjmrSEYpB4OqH4N2t8mVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142744; c=relaxed/simple;
	bh=8+o9CrQDP9rR7vhYrkmBD4TEK1Ah1Um118V33OBjIn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvm9QT8QFNqfK61QhH0cf5WYyI3UewY+UPgjslpazPxFCdhoF9BeKjGviBSLcb/CB9o/IQjJm5kuMEOGrYphqejnrbMCCsPexerVNemr8uEx51UVUR4H6UVvA78tHIXWTQTXZL6ksJUyiWIluQNCmGgg4fVWc3LiT0Batu9yfIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=g58+wShN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so7925396a12.2
        for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 06:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142741; x=1768747541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfDtjbPnZQpFER+nbClQWcn44IBaDvTgM6H9iNz+Pz0=;
        b=g58+wShNUGm4cSq/cIFs5BcjtBtziWlVwOnRIYJ0JBVThU79/8vxkDEUyOzt7AzJBB
         cTZ9e0Q9nDikPkEBLmzCCkAYBMC9A64/OO6AU4Ed+EOGygTBTQEKuknv7Bvpc0Hq4pfW
         tWuCEazhna5tzsEGgmV/QS1mDV7AI8F7irWQCIvLFAdd6UBceXKAjkUon+m8Sp9IuWPs
         p2XYZJYaezhBjl4awlNqxLX5lYDftU2jHR0SSz7JmKdP4CM//mkBYchNBUXZFooCPe+6
         dp21GWl3JMqXh5qWiJlPzG2nBfXylKpA9kssFDHJxDnXDPKiHgK0Z6Kpaw+F7SivT7OY
         h9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142741; x=1768747541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfDtjbPnZQpFER+nbClQWcn44IBaDvTgM6H9iNz+Pz0=;
        b=apuwM+PZZ4nSSnAIvyAI1YdcghlPYdixscuwDanf8vx96EXBU5tOYZbiBsBEETrLfn
         Ks31OvkYFMeSKd9mKC0I5tbTyHxOqn+mlkYL7d7Hmi19DGuW7ueJxFV6qiPnXV7axAQH
         B3sW8xt0m1JKPLkel7/YL97HqkiQoyV7MzuF3W9oEhxP48Pk52t9K8eJ7NS4HHThyV7z
         9NuV6BJGgEtVyNXhUhsabpUomgC1StuZAUiBZFBBk/Ebm2M3aQXOLjXMdBIa3o1oKXXV
         1UhiQj29rBnvk3AhOlbXxzcYhRunK8lglpj73IuvuolZRSjJ5fb30byGUQBSwKCKm9hS
         du6A==
X-Forwarded-Encrypted: i=1; AJvYcCU3x2AvU2AOWsxDRu0eNvQEMIAWpgEcNZ1OqpliWLcXPQltfYT/JQz7vBnFBM1CcgD8CNy4NCHjLXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAJFPYULGtOjG4KeHqZyqSZugNztnbN5BA/+6GWfCMpkaR+Sjs
	mk7lv2RmCCVwNs2r+YYhKh1of9vwU/bz2mcgR6qBX0Ni5PWqqQnkKLhdf0OFhI02kao=
X-Gm-Gg: AY/fxX6zQKwV0t2HewbKaLlKNcvG1+fVlngJc2N/PJjHznrMnL5doQYDCnHnqaSMOwo
	uv5xw8racrqCH41fi89w7bqh9pTGfkqAsgGOk8VqrkxpYkSn2Pn3MZbiHD1eInr50dGQdpa1GVJ
	+69rsjvE0dGQGEHtlq28y/dOHZSLeasmPiE9hmuGvL1fYi1/1ii1ZA2dfgfjQgA2hxrpYmpButZ
	l8+yLd2qZhuT5XUZ6/PBoZKfNCTOvZ+ZdM7HruJF8mDhSsTO0alDmSGs8ATJ4MpugTctWqGWSIb
	EdfTkPBe3TP8Bkgt/WjlyPHi1Jkr+vgw/ZEC4+H/OAZ6m4vNBwNDxC605j065CczLiimr89rAsX
	KwBmaidc5aZnfBrVmgFlv4bF2a22uNesXHHWvEkfPC3ZF94VaqMM5HQ2VCmsIWB9kkTvgrgEcIB
	drn6Udr10XEcYnwdk+uxTuGs8=
X-Google-Smtp-Source: AGHT+IGzzRSG9JPiSsYLBto386guzGNBLdjrzZm8+JQDEKUQ0tWs5J3FidjE880cd/bBYxLZJrvW2A==
X-Received: by 2002:a17:907:9455:b0:b3b:5fe6:577a with SMTP id a640c23a62f3a-b8445169517mr1585237766b.8.1768142741298;
        Sun, 11 Jan 2026 06:45:41 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8706c2604bsm260020066b.16.2026.01.11.06.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:45:40 -0800 (PST)
Message-ID: <555883af-66da-43a0-a4d6-bd3bc52581b6@tuxon.dev>
Date: Sun, 11 Jan 2026 16:45:36 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] dt-bindings: net: mscc-miim: add
 microchip,lan9691-miim
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
 <20251229184004.571837-11-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-11-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN969x MIIM compatible.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

