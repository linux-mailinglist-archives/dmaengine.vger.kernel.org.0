Return-Path: <dmaengine+bounces-8206-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB913D0F2FF
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 15:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B9D2303ACEF
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837E034AAFB;
	Sun, 11 Jan 2026 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZFz5/xt1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACB134A3CB
	for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142769; cv=none; b=spl8CHufNv2KokW939yLSxQxhuUiVojNSm793Cp4tzZE5KPz6xNxzjhZusRM8pN/z61un+qNFx9Ai/Ks/HOIaDT8VHYC5bOYeiNdxbXqFI4J8c8N7HHpm2FsoFq3/ICERO7OEuVh53bQEzOv7Hvu17OK1TaUCwzWRAteo9mbqBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142769; c=relaxed/simple;
	bh=E3fIUBLPFnEXAfwoSTB7dOLky4Cj+/epBMllkCL2GpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJyCma02K/uJNIdjhloUaE25xeERabXieNdRzbLSkZHLU3pjKYL/VFm0050ATEd0X+xFiaVUhEIszsecVnZYdRNtSnpC9Az7LuAYyCg430VLFauFMG26gr2AETFqUT8lLL6jjrsBv/QMLNCOxQ1POHUb9O91B949vnMkcScsewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZFz5/xt1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8710c9cddbso52234266b.2
        for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 06:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142765; x=1768747565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSh5A9C/ikcooPDg3GNmd0+fIcS/l8zoJ1QKaA55bnM=;
        b=ZFz5/xt1R3RPg0IfhqILS6DeIcAi+Q7dknvvl7zujx9QVOvzKxPv6PbFWkA+xsWdwy
         q4RvbDBtR/HjlASIiVjVE8AqQ+cFMmSpSmHz/9zLrH9twpLhuoDOp2ifbX2+2rz35r8W
         EZggkt2Z25Ce3wkYydKW1eTb6s6zNkVGI4+qfKwk56y0v5hgCqKDZMbRcQU8iiV6WcXD
         bNlH8BXPaurlSjuMuJ8jWyp7GKnMkFz+dHJmqtCjFfpct6Tch/J1+bYJfTm+imAjQNT4
         bYlIO26xS8CbA20ia+8l9ila1DeJP0BiFxQQHuZUchuSBxxfuj1eBGaY4zansROWmVws
         ybLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142765; x=1768747565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSh5A9C/ikcooPDg3GNmd0+fIcS/l8zoJ1QKaA55bnM=;
        b=UX0Uk7XmeTqgbdEH9X7OXk52FGZOPUQ5g78O1KHmIOoZ5uwjDGsj78MyAxVF1Pxmsl
         FM/gZihUXq2IopgkU6jgxZbOolXKkDLNSp72MRUuKCE5bmQ1J5bbce0L/M71N6vcbKsh
         Uy8wujUD/K5CNY5K9OkaBHFtrprzguKhnqHTun1/qXm+G8yIwcZpiJremPKCQ1d+p/bb
         7gJr+hx5RKVelZ96xpjqTOfLImObuaB23obsw7lAkyEt+3aahDf4HsI+ioCWYNBa+Y7X
         RPbERNhURoBa+NB9//pY9Z78q2CQBYlt8vQKRKhPAVT2zCAnThADK5Visqu/hPQ1FPBL
         8NaA==
X-Forwarded-Encrypted: i=1; AJvYcCXh89zMSvvAtloiLmCXpT1Eoc/fwgA+ifv666A4nzwh4O2oPBAkaMa00ScVE3Ei7nOrq4yez6+QeO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws1SOTO2T0ZYQfri72xvXKJDtKBMia9KCuqUfYiBc9RlLSjiFk
	BmCI4LPyfbaUrDI1gQz8VnuvysgkrmW9PbW5ImZf430k2bNo5D4c3HCfhv4qx6gfSoY=
X-Gm-Gg: AY/fxX4T1k3cBSL8k7g/UJweqtyVGeHVZWottJTE3x+KcdkYYyQiY7bpyRjNukgucUI
	XrC1ikY4AMvznnr9DgUChPJFr9KNOZ0yUYypFoeQAhLfECWGzaXEFnNIWt2tIiBT+2ciMHHfiDF
	LkMDEfxsQBjeo216jiLpzL0u6aj3Hqh9H8ozhwiFXlbU+/cn1BwJvAXiPxIjxMR4aDqo54EPVWB
	maWysOxVJ2JeIc6jaUN+RTVUe1XsjIn9Vf5cjIHtSbegsV0aQ2HwunIIHy2MsaggH9AL+sHvuxK
	bAn0/jvUtsuBSPJEz2VOXEBMbCoRRAUkahDV/4VO4OWnZIOz1D2MfrjcgwaoEfZ6Z/bgC+HMAIa
	W0A6xAfDBxVRhO1Vz8D+d7I4sxsSbnDFtMFtUKQ0Q0No0GdJaexz2kjYQ9iwvSGldkI9aGi1Xng
	QvuyNMqe4P0JMGX8/NyLuevs8=
X-Google-Smtp-Source: AGHT+IHdSgN1j5CfCwzzuZuuUE6k4oOsy7A6FyHYN7fpU3s7QMByt1Yrcz5j8phSUL1uwYAKt/FfvA==
X-Received: by 2002:a17:907:3c8a:b0:b87:1b2b:32fc with SMTP id a640c23a62f3a-b871b2b3d67mr52172166b.0.1768142765029;
        Sun, 11 Jan 2026 06:46:05 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870b0dba4esm216046666b.17.2026.01.11.06.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:46:04 -0800 (PST)
Message-ID: <dd70bce6-77c5-4d73-96ae-6a0bd8ab7b22@tuxon.dev>
Date: Sun, 11 Jan 2026 16:46:00 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/15] dt-bindings: pinctrl: pinctrl-microchip-sgpio:
 add LAN969x
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
 <20251229184004.571837-12-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-12-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document LAN969x compatibles for SGPIO.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

