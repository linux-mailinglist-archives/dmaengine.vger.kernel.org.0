Return-Path: <dmaengine+bounces-6908-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7431BF2D6D
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF5318C14D9
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FE4333433;
	Mon, 20 Oct 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDAJU26Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C62F332ECE
	for <dmaengine@vger.kernel.org>; Mon, 20 Oct 2025 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983176; cv=none; b=SpcIW77Blok9NzE7I/w+jBK2N4GWZ2D9MOsc3/AovU/WcKVohyoN9nZNsN1pyA8U85wUoxpo3dcxD1ghZLpimfSYsPGUrzCSwCfBzkBoY7TnMfoGvxtWLlTFbwOWb1ovXBjMknVGuqrDoPPtQJlihB0eBoJcDbfBLjzefqIkla0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983176; c=relaxed/simple;
	bh=aUreeKtpN2WmnEqKckespxLIC5wGlm6WN8+84n04a2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q60TBL7SjSySFryXNFny55HV/c4CqaDYTJ9uKCIZoOtuMXRyV1z7ZgcOK4z2Ps28f2tEEXfg+Wq8zh/oVL53bLhvz4F74GRrBIvVqy8gEhdxR23XWWhNTy7yn0LYw7Ltsloo4MbVjEdJNOxbwmEF0ZCZwrdrQAKX7/M+74Fd5+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDAJU26Z; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso2111642f8f.2
        for <dmaengine@vger.kernel.org>; Mon, 20 Oct 2025 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760983172; x=1761587972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUreeKtpN2WmnEqKckespxLIC5wGlm6WN8+84n04a2c=;
        b=TDAJU26Z1JCMKfmUGDyMgFDWfG/BKzVyeythVxkCiY1UImv2QpnNdy+eFtyd9iPHvV
         mAY9DNLERY5mNX/qTEjZT7JT9A3DEKVoJYEgpStEjf7nz4GPewjBhLLvbQZPxTrL3a2e
         WA4RCHzI4/bPWZyQxVm+PD5BM4VYrFOAz5xMKi3B+NIYMeY9tIF3gU7tTlaDb9HfY2ht
         Heqmi5HMQmlquHu+lpFmtBZfGTIggDmjpxl42gTzV4y50+jVxaQB91o1SAjcKZ/inJlz
         UHMxVqZlqZb5UnGZZp7alNSrnMTaDxuqSXH4kt8Mqcq9DKt4pyoD8wsgr3NQi44cduiR
         mE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983172; x=1761587972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUreeKtpN2WmnEqKckespxLIC5wGlm6WN8+84n04a2c=;
        b=hOCB7g8HLUK+HOB6eDd4LbGHd+WSiR7KmLEcJmefBizMTqMzEWFBj9mdhydvUZ5Cbu
         Rea+Ho2VyX0GOdK/UNE9aB4M5ifPiyraMC1+WwMHSy5oa92CuRP41VE05Ag4lLNcRgpP
         0MpBnDSS7XLvBn17ThoZe3QxbzGFYIv/VhJof6Jytbyr03ew8gQ/HDD+BbYBfyJ8xUW4
         JwHPxg90KZP/APqUg37XUfP7qObr1c1zLpfWLhPfupXWptnSn9S0T033YxUGnvGX+WOV
         oXJJhdk6tjLv7FDV5f2H/tqnq2+zPqtY4Pm84JgOx1YaUNuZPdokuI7/fNCzZruVLsZK
         FB+g==
X-Forwarded-Encrypted: i=1; AJvYcCVo3mv2vRBkYUIiVpHe9uwo9R7kWhSQvZfEL3kuGdFQM0ELsypXzVwKvKoDNaz/1i2mtVrGijFcGMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx72Rla0JZ9Iml9MpJ78qzjTnlSDjRaSL3cV2kgPEfjsj8I6ByY
	6GBRer9KmijfOdIGybZfLr0AvCDqinbB/vSIP4f2g0/5ZfN/QpbjBtgK
X-Gm-Gg: ASbGncu0sFlpXPSYPn4eQuYdCjNdKt2dDVMuC3LackT+3otVLFc9bLESJ7Y5uFel8h/
	96FpgtP3FhfdN4vbPdfVylUywmQE6+eSaixbLLKH1O3Bl8ERW9+qqJC8+DrR6GOFC7UAMvdspmI
	Uihh1GiHDvTX6RR6TaovMjJY73FEA9KE0txWnTrRWgiMIEKcQxzQ9F5Tjn3gi3BG/f/x1z/jJtZ
	0e9hN6KG5c2LlX/yDuAx9ilVy9bUrafos0hUA0A1kt/Y6LcKPKe/8Q1x/IcLoOwO3gVLzggXl82
	hDQHHhpy8bHdMpWJddq0ydkG9+ogDVKHakOQEAtDLYxv4PCAEJRnv+sobelFvUIZN0oOvrNoL7A
	aqEzNga/hvUdSM7mcmGyzJT0sGBHbIRih8hJe9kdNNIcL6uJ+XErwyh+Rs1Vef6Ju9RYrv/dLgL
	RX2J3ZYjoX6lIpPuzIwebSvnVFMUPPYvMbZvb5E8oE2Vwv7vhxrdnzvaAi5QR2jlaqg8U=
X-Google-Smtp-Source: AGHT+IHtpDIuvy4/yF6LdQ4qVWSEOm8AetCbAHS/ajv9TB9bfuiRLOt0expo+wltP4XyjrMHK3544A==
X-Received: by 2002:a5d:64e4:0:b0:413:473f:5515 with SMTP id ffacd0b85a97d-42704da2b6bmr9352936f8f.48.1760983171751;
        Mon, 20 Oct 2025 10:59:31 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm16822163f8f.28.2025.10.20.10.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:59:31 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Mark Brown <broonie@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, linux-sound@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 09/11] arm64: dts: allwinner: a523: Add device nodes for I2S
 controllers
Date: Mon, 20 Oct 2025 19:59:30 +0200
Message-ID: <3906069.kQq0lBPeGt@jernej-laptop>
In-Reply-To: <20251020171059.2786070-10-wens@kernel.org>
References:
 <20251020171059.2786070-1-wens@kernel.org>
 <20251020171059.2786070-10-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 20. oktober 2025 ob 19:10:55 Srednjeevropski poletni =C4=8D=
as je Chen-Yu Tsai napisal(a):
> The A523 family of SoCs have four I2S controllers capable of both
> playback and capture. The user manual also implies that I2S2 also
> outputs to the eDP interface controller.
>=20
> Add device nodes for all of them.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



