Return-Path: <dmaengine+bounces-909-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3710F842D42
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 20:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B6DCB23B68
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 19:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F8D7B3FD;
	Tue, 30 Jan 2024 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkxMaNfK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F0C383BA;
	Tue, 30 Jan 2024 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644128; cv=none; b=UbWBVQa7xTEeUkYRcdmSMAcy6PPdi+Q309spzF3WqXz8Y0rKINzICYjGhCdC/DsH6GUaMoE9nBAWjxmnit9FwZ8q9ZejBfknoi5cdY55++yCInyorl/6rBfM9X2hCB8rBwec/XBtIIJZfTVxjIjMRUteBSzSWYkp7Ft/HgBGk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644128; c=relaxed/simple;
	bh=hnS05lukx2Rc7Jjyk2rgzbNfJHNBRDEpUQ7Lv4HY3vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itvhioLoWkKoKlOohz/kysUV6XmK/CjDyuDYylVAnAZcZZPR6PvLXaQee3Ga1+9RTW482uUOyknAF8nXuDanxsJsGldcm1w/xhfoKyEgRbzd3dQ47sBy/SrbJ4Cjq1olIdFTr6kGcT8qEseSYvX9RbbgW3QNAKzm0srdiFGo8qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkxMaNfK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55f496d60e4so1300838a12.2;
        Tue, 30 Jan 2024 11:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706644124; x=1707248924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJeQzLZeVsfqqVy/IRIzUBnzfv+gRBsQWCb8iOaJluA=;
        b=QkxMaNfKlxZqGZx1MyRaBO/dxH+TZwiFMHHjGlhGBqekHBNRQ4RLcfL0phF2BHE6o0
         hXdsqTjuu+rirC69uRLGYh5h1MnK11wtfrl8nxPiDyl66+Cui8xyFt7rlFsN7I7N0a3X
         LZ0phri7oYWmnLC2GZY48X/hcTI5wsnRmeYv01BBD0ry5OkRMGW9Lt7iVT8BHXJmosQ5
         Oia3AHJsEuPOGdpts2drHcrncg1zf0Tl6t6ZPex7AtOf749tAMntybsxdGl+cJUXyNKh
         PgwgBn/bd8DulF8jDD9k9CdtiG5ZyDKGoF04++cGbrQgnGz8gujVzk8ngn+yc736zpfS
         J6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706644124; x=1707248924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJeQzLZeVsfqqVy/IRIzUBnzfv+gRBsQWCb8iOaJluA=;
        b=Z6bVGRkYSs/rgqMsPjpNX44/rOTJCsHTYu6jDKIiySG9CWQXnBvfWYacB9aysD8ZKK
         vu/5s86c25+4Ebk9FjfrNIi269a4XAwLg469IqLMIFqB9HMD5j3ak9Gxh/bQKiFISryL
         Xhf64/wmhUy4L31+QxD3DHWuHIjwG/Rr4VQxdkdKm4wYuj+109MsXHtRvpUvjWUNC6fi
         ockk67tvYOSlAn/6N4uZZq8V+JWM2zaRcT+DvVNz2y39dEBaJ3RQT8fJ95AXxcZgBTgH
         eHK8PK/7PVITKtJOdspuAG5DrMt/iLfr+ytYihbIWnCKGhPF6auX6eT7WgOGCBjSm8xX
         jsLg==
X-Gm-Message-State: AOJu0YyHpEju0UX7301Lom6Z/RJRCDgiUTc3v80ox8qHuZNGmifNY66r
	D19p5U2cn7g128xKJ2Qqtq6zvJiWSQiVIP2Xn71QgCNDw5lEthZm++RcgV4A
X-Google-Smtp-Source: AGHT+IFf3uIFgKLDiLg9UvZu2Lh1EJ+Gp9y7um4mQ5+zM0LwgiEuvgFwE4KceV9gO1NkGgepHcxJpA==
X-Received: by 2002:a17:906:4088:b0:a35:b7e6:e6f1 with SMTP id u8-20020a170906408800b00a35b7e6e6f1mr4382872ejj.1.1706644124332;
        Tue, 30 Jan 2024 11:48:44 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090628c200b00a311092d2f8sm5378460ejd.169.2024.01.30.11.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:48:44 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-sound@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] arm64: sun50i-h616: Add DMA and SPDIF controllers
Date: Tue, 30 Jan 2024 20:48:42 +0100
Message-ID: <2170768.irdbgypaU6@jernej-laptop>
In-Reply-To: <20240127163247.384439-1-wens@kernel.org>
References: <20240127163247.384439-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne sobota, 27. januar 2024 ob 17:32:40 CET je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Hi everyone,
> 
> This is v2 of my H616/H618 DMA and SPDIF controller series.
> 
> Changes since v1:
> - Switch to "contains" for if-properties statement
> - Fall back to A100 instead of H6
> - Add DMA channels for r_i2c
> 
> This series adds DMA and SPDIF controllers for the H616 and H618.
> There's also a fix for SPDIF on H6: the controller also has a
> receiver that was not correctly modeled.
> 
> Patch 1 fixes the binding for the SPDIF controller on the H6 by adding
> the RX DMA channel.
> 
> Patch 2 adds a compatible string for the H616's SPDIF transmitter to the
> binding.
> 
> Patch 3 adds a compatible string for the H616's SPDIF transmitter to the
> driver.
> 
> Patch 4 adds a compatible string for the H616's DMA controller.
> 
> Patch 5 adds the RX DMA channel to the SPDIF controller on the H6.
> 
> Patch 6 adds a device node for the H616's DMA controller.
> 
> Patch 7 adds a device node for the H616's SPDIF controller.
> 
> 
> This was tested on the Orange Pi Zero 3 with SPI flash transfers and
> SPDIF audio output. The H6 SPDIF change is superficial as the driver
> does not support receiving / capturing an audio stream.
> 
> Please have a look. I expect the first three patches to go through the
> ASoC tree, the fourth patch to either go through the DMA tree, or
> through the sunxi tree with an Ack, and the last three through the sunxi
> tree.
> 
> 
> Thanks
> ChenYu
> 
> 
> Chen-Yu Tsai (7):
>   dt-bindings: sound: sun4i-spdif: Fix requirements for H6
>   dt-bindings: sound: sun4i-spdif: Add Allwinner H616 compatible
>   ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
>   dt-bindings: dma: allwinner,sun50i-a64-dma: Add compatible for H616
>   arm64: dts: allwinner: h6: Add RX DMA channel for SPDIF
>   arm64: dts: allwinner: h616: Add DMA controller and DMA channels
>   arm64: dts: allwinner: h616: Add SPDIF device node
> 
>  .../dma/allwinner,sun50i-a64-dma.yaml         | 12 ++--
>  .../sound/allwinner,sun4i-a10-spdif.yaml      |  5 +-
>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  2 +
>  .../boot/dts/allwinner/sun50i-h6-tanix.dtsi   |  2 +
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  7 +--
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 61 +++++++++++++++++++
>  sound/soc/sunxi/sun4i-spdif.c                 |  5 ++
>  7 files changed, 85 insertions(+), 9 deletions(-)
> 
> 

Applied patches 5-7 to sunxi tree, thanks!

Best regards,
Jernej





