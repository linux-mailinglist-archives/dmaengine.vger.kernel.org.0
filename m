Return-Path: <dmaengine+bounces-899-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1788429EF
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 17:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F230A1F22540
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30951292D7;
	Tue, 30 Jan 2024 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nkl0C6Bd"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722D3823AA;
	Tue, 30 Jan 2024 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633462; cv=none; b=ZgOZqxmXBpGbQ3igZq3ibD8s/z0M2nsfTvCb6OcyQjNq2X3skpkBR6FJGsZ5IKCyI0rzxWHuoB03uAW6y50PWVrHEG5QA6UVz6it+wgwS1PDhk3NTAb9zr4z0B311AwzxWdt7pEHImujXStyO3B7ZWop9MkUo53bu4EW+McfQDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633462; c=relaxed/simple;
	bh=RaXuGC+ILopm/118dxaYm1RJctuzPkfs9VeKd+ZeDMA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e5rWHQgA5e9ZDI7cR6yGLhoJ4VOj9iho05xKrktSW1s9DClT/psA3kDXrj0nGQCl19OTQZY5dsEzuYqXXyC75Py4EUjSBfcGcpHU/Vl0Hl+ZYDJZBMhQg7lHnMrSRC4ansFKcecKhlp0LUnGp69h++CakXfDXCIjbZC1SlsNekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nkl0C6Bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805D4C433F1;
	Tue, 30 Jan 2024 16:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706633461;
	bh=RaXuGC+ILopm/118dxaYm1RJctuzPkfs9VeKd+ZeDMA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Nkl0C6BdHutK53KDb6YR6uBWAvoa5ov9DxEKxaAj6AeP7mAxBMvwJMYVWodkhFPDd
	 c5ceZMK1ANtGz8in5Xyo/yLq5PZLU8xaYoCKkYQMPUyx0C+zw1jzZ5g5gYMnWXP7zg
	 N3980lVu7ENNCE3NmxsKI/Qg6KjcW+IV+Fyg03xrz6xrhhAAxxiQ7QQEPRNlWNNhL2
	 D8fP8klfI8Hrc94c41ON7HpxmULAScJFDbHqfJRJnnUpFk8LeGr6b/R2F6atkUeeu+
	 ugNc60cnWh8Ry/SDaM/dc921YP8q+NzwqkUQSzSrvgVfJezwG3dDvBLY9xT65Ld/Zq
	 hBnjhdg+luEKw==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-sound@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240127163247.384439-1-wens@kernel.org>
References: <20240127163247.384439-1-wens@kernel.org>
Subject: Re: (subset) [PATCH v2 0/7] arm64: sun50i-h616: Add DMA and SPDIF
 controllers
Message-Id: <170663345601.658154.16420910246714061637.b4-ty@kernel.org>
Date: Tue, 30 Jan 2024 22:20:56 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sun, 28 Jan 2024 00:32:40 +0800, Chen-Yu Tsai wrote:
> This is v2 of my H616/H618 DMA and SPDIF controller series.
> 
> Changes since v1:
> - Switch to "contains" for if-properties statement
> - Fall back to A100 instead of H6
> - Add DMA channels for r_i2c
> 
> [...]

Applied, thanks!

[4/7] dt-bindings: dma: allwinner,sun50i-a64-dma: Add compatible for H616
      commit: b32eb97edeb8d69092d57419917b19c909ff962a

Best regards,
-- 
~Vinod



