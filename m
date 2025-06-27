Return-Path: <dmaengine+bounces-5656-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF56AEB829
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 14:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A8E3BD62A
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 12:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C46329E0E0;
	Fri, 27 Jun 2025 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnX5UCJ2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDC52D3EFB;
	Fri, 27 Jun 2025 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751028698; cv=none; b=uuqX/YsYf7M2sP8xMc0jShTK1YwPbutiE2oZ6bjOOY1xS8VzcBdepSckvOV+V4vXqHPgar0N5RZ9UlnBoyiZALE4cORF97egNY77DEqGoUuVV5ADBw3DJ0WsCBW4ajUg57R+U6Qq7+RML8oCf9rrMkWEplgVUEqUbhYe23lj6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751028698; c=relaxed/simple;
	bh=OV5rE1Egth+rX0x2sNvM7ePPH3s60fZPUkM/cp/VU/I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b+8hnmtRHlPNPfuOhOsfmbH8Ys6Sf4jAHBiH+vU2+NXBoXyq1wIPKiWvupXy2VJQlygCcTBfd1eJSrMHd3yw+8OaF2dPnSwzVK8iLcaT1NFdx1Qm8hUurkqwIwBJdIlvtoPGL3iJ4kAAHim1x3Emrpa3QGNFN9Hjxb24QrEsf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnX5UCJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72064C4CEE3;
	Fri, 27 Jun 2025 12:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751028696;
	bh=OV5rE1Egth+rX0x2sNvM7ePPH3s60fZPUkM/cp/VU/I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YnX5UCJ2VZODMIac638/iCrEzmTSFGezr7liVfqz3IiV8g8OggwHu0Ac1cjz64g81
	 nb+G2u4YsJZmbI5/Ace3gDfDt3iKJQrcTJsLZbomxSuzTyD3/xaQCmcHTSVk7MDg4q
	 uVDZUNOLqalhnvCYVCfwTL6val+O3k6ozOpl3lkOCSnb5DjRluwItHmccb8VANX0lm
	 2dyws2QQfXXulbajDqZBZ2wcPmuedYcGaee84hFY4+r/BiVfzIgDYtgAD/ylNI9gnY
	 eXi/FTvKZo3sQfF6VBiqBDcupY34u0tps19otPyWof7lvLcLtEMK17fWMQwn0rqp9Q
	 0S9nu9hPGtI/A==
From: Mark Brown <broonie@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Cc: Vinod Koul <vkoul@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250610082256.400492-1-csokas.bence@prolan.hu>
References: <20250610082256.400492-1-csokas.bence@prolan.hu>
Subject: Re: [PATCH v7 0/2] Add `devm_dma_request_chan()` to simplify probe
 path in atmel-quadspi.c
Message-Id: <175102869373.390499.16488467994340140791.b4-ty@kernel.org>
Date: Fri, 27 Jun 2025 13:51:33 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-07fe9

On Tue, 10 Jun 2025 10:22:52 +0200, Bence Csókás wrote:
> The probe function of the atmel-quadspi driver got quite convoluted,
> especially since the addition of SAMA7G5 support, that was forward-ported
> from an older vendor kernel. To alleivate this - and similar problems in
> the future - an effort was made to migrate as many functions as possible,
> to their devm_ managed counterparts. Patch 1/2 adds the new
> `devm_dma_request_chan()` function. Patch 2/2 then uses this APIs to
> simplify the probe() function.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dma: Add devm_dma_request_chan()
      (no commit info)
[2/2] spi: atmel-quadspi: Use `devm_dma_request_chan()`
      commit: 2555691165a0285a4617230fed859f20dcc51608

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


