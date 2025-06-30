Return-Path: <dmaengine+bounces-5680-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189B6AEDB60
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jun 2025 13:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C823AA0C2
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jun 2025 11:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8AB2609C4;
	Mon, 30 Jun 2025 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgLez+HX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DE6260585;
	Mon, 30 Jun 2025 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283651; cv=none; b=SGtssXPA5ThwRGabpnCMmNQhHCXQMzEHjblLalYJG0GmRCYVk5KRVK0+eyWuqZlBKsSCbIx4SgfQqey3Q/RVFzAuXh2Kr6fdaL+GdyhIy6dDOZjQrq/+BuPT2dfWYm5U1+5VBod0bVbfAqiNbjecA7dz+V7zQ9Oq7G2k9VsO9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283651; c=relaxed/simple;
	bh=ftNktXx3viZwDTtRvJBBYVylno1HnW9Egn+Kkhk6AGc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=klSrQwrtmqgA9iFVFigHXCzATlfnuPotAzDd8gtUtnzIzz0Rk4N89aeyLvS6Qu3exL9+kn+T7hhwsZv1mvU2+2GFipOoyLvPLL7+EuU87pgC0kd8/OU5OSay0SuiDfblhCKMcPAUKKWxDUgkpNBsJi+HQhJ0iHatCeLdkQgtnso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgLez+HX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74121C4CEE3;
	Mon, 30 Jun 2025 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751283650;
	bh=ftNktXx3viZwDTtRvJBBYVylno1HnW9Egn+Kkhk6AGc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bgLez+HXlFANtNBrQDtXBKnd3LtN7bLY5hLHEsx+pDJtWlg9HvhK5sazMio5sQijC
	 MUtdekGSSf3sPBFjhb0RtVom5b2C9pra/P0PDIrTvncDBzScCO2IRLkKd5NGwaCvhz
	 +1zBi+Bf6q5R0N4i56Tw64XQlFGPO7b1AcDpd7JIvFsD+Nhlm4xE+PS7RoAAFE/5gp
	 +p9AM7W46qckbniToFXS8bCzcPHF0fBAdUEBgaDyrgGm62jwPraqo28n1nXR1hkePV
	 wP/aho+87KhbJf4iRb/alT+xt+K2x2ZIiD5tSbXPP2HllyuHJ4JCApclvNnRYPv6B6
	 V3yO5ytFHpAnQ==
From: Mark Brown <broonie@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Cc: Vinod Koul <vkoul@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250505184936.312274-1-csokas.bence@prolan.hu>
References: <20250505184936.312274-1-csokas.bence@prolan.hu>
Subject: Re: (subset) [PATCH v5 0/2] Add `devm_dma_request_chan()` to
 simplify probe path in atmel-quadspi.c
Message-Id: <175128364820.28911.16876247019790951320.b4-ty@kernel.org>
Date: Mon, 30 Jun 2025 12:40:48 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 05 May 2025 20:49:32 +0200, Bence Csókás wrote:
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


