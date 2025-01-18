Return-Path: <dmaengine+bounces-4151-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C31A15C3B
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jan 2025 10:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9926F188913E
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jan 2025 09:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC318170A37;
	Sat, 18 Jan 2025 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNzvFrX4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29537175D48;
	Sat, 18 Jan 2025 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737193886; cv=none; b=IP+tv99atk8ijfSWizBdOM0r+qWlxfP9kkfo9TDCuP3sR4KoANfjKScqSJa/mjIc+HFfPFQ4PpzhNRO5ka1O0mgWHr3n45h3I7rgp6nyePlcc7svlKPuIbQg5cPpBNajygc5WAsYSRH5c8fgVBaeTghwAP0aLblfGC1ySo+kXas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737193886; c=relaxed/simple;
	bh=P5POeLB1HYM4r7q+jyyRBr+bveo3NgD/uLDfzg3k38Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5o3tbEeE3bHeNroNPiCUZnB8GpaVKNiQYjAPJOZQTjMtlUqi0mYpkPNE2548A8pAIh4KdyUMNinOwf1/ETm45dAh7pSlRGPUSLrCOmSo8hPnFuXRuscKRWeRx13yW9RLLeEBtyC5bHgmyFbMPJfJW/mmheagdCvR0dYR5VdFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNzvFrX4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaeec07b705so537606966b.2;
        Sat, 18 Jan 2025 01:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737193883; x=1737798683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=db8wy+NAvFX7oWbNNZfkOxUsDhaAAm9ZkDqWuFl4MaM=;
        b=UNzvFrX4XLEy8v+4x3IWYXjXCZdWx2/bqjFVwO3JnUBG5Ip03w8NT3aLdpAWIuV8mv
         B4v0duWno86K2SNU7Xq3ntZXOWqXTxrfnVmssMW57aqCd2QVrPbLVIXYIoNy4/z02HbU
         j5yc6DyCAM5RjvT15oknksvIIOBBivt8FRmybaNHKwtNXhJ6Qvq8Oo35lOrlpBSkP8jR
         koX5keRDLTD4GDKHH2yRX9hnq/JS37buI40rwnOt7j8duGDY3u62JKsF94u18AEgxj9g
         wKMRvQdrJ5a+jK8foAEqseif84+JnqFtoKeFP27dg84a99C/QYevlr9+MoeskOS8gxIx
         6m+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737193883; x=1737798683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=db8wy+NAvFX7oWbNNZfkOxUsDhaAAm9ZkDqWuFl4MaM=;
        b=ESsIZ5wICJWkHYYyM2c8klFO631EwB8T2GVl4jU0ZxXUK1WsQ25yTG5wZfP3grYWFJ
         zI4jczaaNXoP/tpBc1GR5If3TP9GHMp/HFCLSwABTkBxmcJgAbW6J7POsFlV7AqeAQGS
         GeqFo7BriL/DXMa4STtbizJu+v1ekeTKMdypuWBRNJMxbbxRiHQo53477lymbWknmqdI
         Z7U08WVBmnzyThnyCeeGOQvzYTOzrqBWw8/aca+BQGgZXWrVMtqOwkdt1/aZ05dHDUV2
         0PfZqMNaQq5Myr7ech2XLXeX2QO8PHbp31VJxEoAv00nSVU3zXYsuvjR6/V3ag7LCzkT
         8XMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJFefHcgt/8kaVn/VC92+058M8/Gcxo+NmVDtYOrHpRXpzDDg3k32lFWBSklmYhJnDVdxImxJoWzQ=@vger.kernel.org, AJvYcCXjlG1R0j00SoqXkk/bhgOLTKnRt/8R5b0oY0h+AK4sjarso9wQyr0gbTqrK7lhJ+jtVVuy6W5n3m1794y7@vger.kernel.org
X-Gm-Message-State: AOJu0YwEwY2idRYOZX7lEIpMn+NpXUdXqm81jmz7hwkPVotmSnNbcNa8
	ABgqIgyfLLhAH4+SNOHfmtOq5qMIAAIqJfj/SR22pFCaVeZk4PC+
X-Gm-Gg: ASbGncsg3Vde8b9lU3xaubr1Cdgu82TucW27CyUtBSVaA7qmzSmLs/swEC6JBc0YnlA
	Q7KRgtCa3F1ewIePo9veu47c29Gzg1X3N2etYR6FA8oZvFRh9T9Ubjw8YXplVUZjPFgbYvhr/P8
	DYScUbQY383lAr8KKyf23A7mYeKsCddQ3owXe0IaJSNF+moSArzR66DgQERLL0CwAiktZg0aztJ
	KR9umkdry4jt6VOGKfRYED2/oXFiqktO88XvoTQRzvipz0yyBrRXeKTjJzc8btEBMkUOIVAxaxb
	qtoQ5xcutxuJjhVxxOAcxEqITw==
X-Google-Smtp-Source: AGHT+IGSL4U5Xl+C2sAjU6wiHAWjkKHC+CgAd09MaHyOr2GDuAn9GsU+UuWVUF99+lnXmPsQs58C8g==
X-Received: by 2002:a17:907:930b:b0:aa6:a9fe:46e5 with SMTP id a640c23a62f3a-ab38b3dae38mr578880566b.53.1737193883243;
        Sat, 18 Jan 2025 01:51:23 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f86244sm307104766b.152.2025.01.18.01.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 01:51:22 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] dmaengine: Use str_enable_disable-like helpers
Date: Sat, 18 Jan 2025 10:51:21 +0100
Message-ID: <3794610.MHq7AAxBmi@jernej-laptop>
In-Reply-To: <20250114191021.854080-1-krzysztof.kozlowski@linaro.org>
References: <20250114191021.854080-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 14. januar 2025 ob 20:10:20 Srednjeevropski standardni =C4=8Das =
je Krzysztof Kozlowski napisal(a):
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> Changes in v2:
> 1. Also drivers/dma/dw-edma/dw-edma-core.c and drivers/dma/sun6i-dma.c
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 6 ++++--
>  drivers/dma/imx-dma.c              | 3 ++-
>  drivers/dma/pxa_dma.c              | 4 ++--
>  drivers/dma/sun6i-dma.c            | 3 ++-

=46or sun6i-dma:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/dma/ti/edma.c              | 3 ++-
>  drivers/dma/xilinx/xilinx_dma.c    | 3 ++-
>  6 files changed, 14 insertions(+), 8 deletions(-)




