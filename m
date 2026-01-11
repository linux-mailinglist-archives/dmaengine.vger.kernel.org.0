Return-Path: <dmaengine+bounces-8203-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5998CD0F30B
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 15:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14379303D6B7
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 14:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E403321A2;
	Sun, 11 Jan 2026 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="K9ADx+2q"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86FC34A3CC
	for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142710; cv=none; b=kzIydS1JPhgOU5ctEasb8I5wAihHDeIkjDiGHQJ81dZSAcijxlZT/0OIys1K4I+V73ktXpJYrYBtTtzh37uwU3ZJQH0rDgjSgf0rWW/BF7HqUpUQRyRnm31LLq3JvyOoYvtpXgW5HSFYtkJjqXaqOo6XXBuPxGLPfv11HzWTks0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142710; c=relaxed/simple;
	bh=gDiL7diPPllfiqdrICUaz2pklt2cpfwEzlq/42pPJS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLozaBgWrUyWl1PLMeCqZ3mzepUscAGrAzqyHtwMDSuoPAiCItJEVWTSx4zOv636Yoo5dSwdhvvTXbVQZpHR60VPlCPZZB1rucJ+UeJ86z2ocgixFeLmsUqrm27IwgG09UBeZpk/ve+8iWb6A/W9Czm0BUuakspuEL0IBv9f6oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=K9ADx+2q; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b86f69bbe60so99370666b.1
        for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 06:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142707; x=1768747507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bR5pMB9Z21CNTk1B6+opWEfUH+WjtdKh40K9u7GvYSs=;
        b=K9ADx+2q85hi1Y4+enhphqyqyZpZ50jBbUQejVQ9+lAyuPt1J7eUMJcsTH5Bdu91+/
         8uKGBqR2SSjJrxX/lCcEn9SiYTF/WVBgYkIGEyzvckX0wje75OhEfcmjaMUigKJwIZRs
         e06XzNxpm7i19SZ0LSNbNWyN8H9SmAT8nuB4Q15uT1Uv8OpT/U/AiGflgqftkaUx04wS
         FC9tKAq3ltBYaTZkCdn5SXY0EGMBHqbdzuQwDPZYYV0jMRzS64ApUPcVOjXPvySqbrOy
         U8+WS76PxjSbXLX1BI4gqBrNFoWcvXvKZgA6KNPOhcW9KOI4VzIXbxSQNQP75cdKv3IF
         4osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142707; x=1768747507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bR5pMB9Z21CNTk1B6+opWEfUH+WjtdKh40K9u7GvYSs=;
        b=jgzxewKgQtMOllpixuk9VZdbNtkjaeCTR6HsK0UrBmK2PMpOMk856SNXVvgB2FDqVa
         JHJbv6Ykbw+42akeErwl18Ccneo9vwbkwpX91vHkVCSW2L3Zz6say7TaaguBA2acZiHE
         KL4Z+j0JXSXX0oD7VRcx+RHhUiERbgQ9+sq35LjAG7cZrHu1AtP6jMj7Bxbt5HHaF/d+
         SfM6O9gMF9eDss4qMr7DPvMDlR+I7xrJu5/o4RL0TDhji/xLYEwXCdrqdd0YKptp8Ad/
         lsK9ekRuJaJO6hbbSKLkUPFB3Z77HCvNi/5ukgXVPVzcQNe7UHcFUwtA45azZIYln2wB
         MCaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSqmigSVDC0lCCwoBPOC0yRMFzA4+2ZmU4FXu2AyExw4H7xn74oFDaTJQ1Oi4cN9GHMnrWr14JQ9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YykG+nT+Ih3kmL+xo0dPYtuerLwqu7x68bts3h4UlcNma/BnegZ
	RQV4WNnPj1UNFh4R2CzunLhVDItKWRtNBEusi2LNETE9dWHqCgH/53FRrIYtg0MWOSk=
X-Gm-Gg: AY/fxX6vq7PVWqx55jiiegvJoNwUukbc1pzJ4ckcPeqLJLAd/yk0G0ftY0Lqi41dDbW
	vlRa8Nb9BH5YM4t16ohU8nYnyHgj+ejA6Cii+ZiSsp+issjMgNjLLSvmiig5Z8N8Y7WzTr6pd1u
	vtOJHN1U6eKdh9CWNrn8xFoLj2q+hgnX4p5GWS6Houqz+CBMm8csA1TaRagoDVvJmhWMCppZJFz
	YaHUPX/4dlWNVpgTIS9OWcAypGrnt3PQKn2g2uL177MQ5YZvzzAIVyKnZFPyCJFvq+QX+KwkOCQ
	g/zuM9VrF/VMe5GiiXRLMcH8avWdtvdV9eo8yVX7FaptlAIE3Uq0bVDq7EDGjDM3uTTLdcv/7AS
	ewuXbGPLFuknCV3l7q+uCpPvaurOJ5bKWmR3mLV/V8D2nMy39wKDk3idsmawCKwiF6YvR2UAhPr
	XrRsV3I391RjlReSa8+OKyM22TCHAwbUn+1g==
X-Google-Smtp-Source: AGHT+IEnRprofKW6iUFW+aOMnt2p1AYruny/NjK8tSS/dtcvBYVRc/tCV4eudi2xBk8lGr0c6zLI/A==
X-Received: by 2002:a17:906:dc94:b0:b87:b87:cdbf with SMTP id a640c23a62f3a-b870b880077mr194416066b.53.1768142707046;
        Sun, 11 Jan 2026 06:45:07 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a235c0fsm1673227466b.9.2026.01.11.06.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:45:06 -0800 (PST)
Message-ID: <19f25a94-fc90-4298-b3ea-58bd66cad11d@tuxon.dev>
Date: Sun, 11 Jan 2026 16:45:01 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/15] dt-bindings: crypto: atmel,at91sam9g46-sha: add
 microchip,lan9691-sha
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
 <20251229184004.571837-9-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-9-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN969x SHA compatible.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

