Return-Path: <dmaengine+bounces-885-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A1684168C
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 00:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 919CCB2199F
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 23:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2221453E09;
	Mon, 29 Jan 2024 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKH0RC7L"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40F751C38;
	Mon, 29 Jan 2024 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706569732; cv=none; b=imrsvivn8LOfVswc6TCkAeQvuyCZ7LR/efDGGVXvvUEk67kL6+gwaE8xKdfFNKrLeCSH1zp4XXtdiuaVId/SB9lZIKFWQQlZnb8ByK10/sTQELYg7/YT+7pXLzS6w2GpOBKRIXkny8hp6N4XvRwX+BLWMOaoNzURo59EKuxfpW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706569732; c=relaxed/simple;
	bh=lItnbNGGXomc1ezwmJocmF4YnmIqkbj5vgu4qZ5idUI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MN2TAFcL6DmZVgptFxxv32RQ7/45fvHfnlpJcnSY+dWZem0FKUZFoJISV/SgzEUhtY6c/hyoWTyh/NDbHKXK3y2RtoZefQ7lDxt91JHNn4wLsuh2ehcTmU14j+uBV428X5520aI5ThZRRQnrDKJNmZziGCdikn+te65b/SDuVxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKH0RC7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684AEC43390;
	Mon, 29 Jan 2024 23:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706569731;
	bh=lItnbNGGXomc1ezwmJocmF4YnmIqkbj5vgu4qZ5idUI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tKH0RC7Lz0TRXF7WE7pjITfFTLoXHk6LbjuaSpf35QJ8RhZVWxz2w+i1B4HTxPE8k
	 arGMTBdQ6xdeK0mUGtUWP0HGpy3UF/3jV4Iq52jEBxJhQAzIJBolkSGIZyUo7aEcLS
	 UR1kHkfRI3xGkVq0b/qP9iG49KIyqlHOewUXX+v5/LTpZAFYx+f/OiRdbCSxh/sp9N
	 WdZBjQOxzDEQg+hUNlpWoDLA9P6rDUQMUSeqkk+xZh/1lZAWwvuTC0lyerGwiJk/zG
	 fesIEUMkRpeWjAVP4IaRvpeYyoKm/voq+Hx4lEyZOqScKmbblD6pmgrbtvkIm0GmCP
	 4b0G90Ih8w39Q==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-sound@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240127163247.384439-1-wens@kernel.org>
References: <20240127163247.384439-1-wens@kernel.org>
Subject: Re: (subset) [PATCH v2 0/7] arm64: sun50i-h616: Add DMA and SPDIF
 controllers
Message-Id: <170656972816.167619.13760688172149565550.b4-ty@kernel.org>
Date: Mon, 29 Jan 2024 23:08:48 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Sun, 28 Jan 2024 00:32:40 +0800, Chen-Yu Tsai wrote:
> This is v2 of my H616/H618 DMA and SPDIF controller series.
> 
> Changes since v1:
> - Switch to "contains" for if-properties statement
> - Fall back to A100 instead of H6
> - Add DMA channels for r_i2c
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] dt-bindings: sound: sun4i-spdif: Fix requirements for H6
      commit: 57b3c130d97e45b8a07586e0ae113e43776c5ea8
[2/7] dt-bindings: sound: sun4i-spdif: Add Allwinner H616 compatible
      commit: 7a9dc944f129bb56ef855d9c0b0647bc3e98a56f
[3/7] ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
      commit: 0adf963b8463faa44653e22e56ce55f747e68868

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


