Return-Path: <dmaengine+bounces-6906-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E7EBF2D2B
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FE9E4E53ED
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35BE3321C0;
	Mon, 20 Oct 2025 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB6sa/bx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA582330B38
	for <dmaengine@vger.kernel.org>; Mon, 20 Oct 2025 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983084; cv=none; b=si1yBMFunGXOI+vY7+lP88XHMQygzsa+A/oPVXvM/7pLJBEGDt2R75F5YM0MC3HPm+CvcS4bGA6iSB8ct/brh2vkkM0q6exm6c75Ou/JqC0yWjZBlZaj8x1Fit6Y3twICnXjdkOa5Q+lvfpoER8VX4qI2i7wdh+MO8Ci1RL4sSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983084; c=relaxed/simple;
	bh=iJYNXDViBNg9H23IU+cEG/iUlaVVosMhC4bKdCUk1To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cppUy67ztXTPaFsneHK89ipdnIUdVfjPvkeLetpBS5Vngl/tg8YTMIpjraKkgrIT7S3D+o9i73bYJ/JPT2fZS7PqhG/rMxzKP8jhedwAai0vS4U8bGivm76AsngWgJamBbBry+v9wbdUQRxZM4ZEg+MKnHZ0iHhVg5hxiWBSD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB6sa/bx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42701b29a7eso2114586f8f.0
        for <dmaengine@vger.kernel.org>; Mon, 20 Oct 2025 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760983080; x=1761587880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJYNXDViBNg9H23IU+cEG/iUlaVVosMhC4bKdCUk1To=;
        b=TB6sa/bx5bkTjJ5MaRhcpoj6Tf+mFleUpkzyR1LtkRSW/kXnqrrcGWLQ7C9+UprhCu
         K1XY1qd1HVhm3OvgiCsqJNj0FM4j2JMbZEDSRepw3+TdidZRy4/ZurPhN5XLQYdrbMmO
         Lsn/gkkqUQ/7qMWdk3UfjUTRMGxLLUJTKxihy2FsmjW/5+zCubXFEEs+/IaRPFEzQzEJ
         wJ7pyfU1HWpXxsuNJTR7E9RGoDFMVintFSrrcBougdWmQv/+YiDsKLoHahosFgX35b6R
         9i4JyJGfT0SlDNxpF2MpizZ67ZIo8q3L3+faAIJW6gXLbFpDbZUvzsbnJ8bJjvb24p4r
         LE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983080; x=1761587880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJYNXDViBNg9H23IU+cEG/iUlaVVosMhC4bKdCUk1To=;
        b=t5mNTQ5LjDiICT4feWr6xz2pLUdJRGEVRferkw4sKDCSZrmnDBK/LvuoUzTyLOysaM
         Kmhru1taMFCfK4DEl3ppl2G4pQ3CbJWeR3uZvoJ1+IMkQlfP/hvzmQSyUNrYe+Z4Uclw
         GFLKPeoVv0/bcGk+JeV19+upcvTaNPYkpF6c5l6b0ypsm16I3/4wAiAEo2isuv6tyYgJ
         eKX2do/+n0+UPUH4D+jXuH8yCbTtEDfparUZebXIIfg6KMUPax4H5dnbfz82hBbVKEzW
         NpcwwzDbEdTfqardrK3aCFRFoSK9QWRy7MxDpSjf4zWwn/PsW10+O+QrpCtiUeGwnfAn
         xXlw==
X-Forwarded-Encrypted: i=1; AJvYcCWHjebE7MZoZz6HLbm5iJKToLQF6zhY6O5VsaE/jKnlZ2eIMP3OJKQcC9r3kHnuDduFJNvyvE/RfYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5MPy6CRseyPVwDUiPqYHpSyeBTHfo/a7/eoi36YK+s0hciV9m
	guc0CTaDCB9u36spf2R5q9k80g2MPjGBhRjD0Iljx7brcJwPGHl0qZK1
X-Gm-Gg: ASbGnctagp13jADqXJB4TKJAnIktxoTrGAOMrcre05TDrWiQqNWzei1iDivpAU0FK20
	qXb7TeAL+tLcF5Zl30TWE6iPhasBoiHI8eYwVPbnIBHikYIpwYlwTF5N7B+NuBk34tmH9kidp51
	d9pWDmgcctHfTt1czH7ke5q+th18sNBkfFMH+h+P0GQ4IFiVJk16ITrN7XTtU5CwN7IQDQMhQic
	3ArurIFosY6loGpXpXwaelGq4pmFjX/f2wgkYcmcuLeVzTXIgW5mx1H3zXTv4nL0L107XCakjHQ
	f71eiBbAIvZ3yUDAn9FBnaq6RnO7L3yiBbzShOkN0VGzAHUYxPHySjLWBKbx8cnl6yrW0I2+rjd
	8kYnSCB+MeZq/grzKkr3N5lRj4EMcoM2MlHsaje3BUsMY6+UioQIUu9VXk176zslnx2bkgOWCJS
	0mvnXrXra804blbKZHkkJAscnWotW+lbjJp+5mTsw7R/EsRxHkY3AUh5NgLQo5v3sPwNIf
X-Google-Smtp-Source: AGHT+IEQQl9YZkR1BgzZ6Z2Nufpu9HBikDewEvyF4EuaS29j/RILS2DM6SBqWX87g+1TkKzsAinQ/A==
X-Received: by 2002:a05:6000:705:b0:426:f9d3:2feb with SMTP id ffacd0b85a97d-42704beea1emr10367539f8f.23.1760983080172;
        Mon, 20 Oct 2025 10:58:00 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce08asm16294878f8f.44.2025.10.20.10.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:57:59 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Mark Brown <broonie@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
 linux-sound@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 07/11] arm64: dts: allwinner: a523: Add DMA controller device
 nodes
Date: Mon, 20 Oct 2025 19:57:58 +0200
Message-ID: <2324646.iZASKD2KPV@jernej-laptop>
In-Reply-To: <20251020171059.2786070-8-wens@kernel.org>
References:
 <20251020171059.2786070-1-wens@kernel.org>
 <20251020171059.2786070-8-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 20. oktober 2025 ob 19:10:53 Srednjeevropski poletni =C4=8D=
as je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The A523 has two DMA controllers. Add device nodes for both. Also hook
> up DMA for existing devices.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



