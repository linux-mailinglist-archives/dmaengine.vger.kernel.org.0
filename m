Return-Path: <dmaengine+bounces-7023-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D83C15BA5
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 17:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CE1188F20E
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB90346A16;
	Tue, 28 Oct 2025 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Klvoy4DM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25992346A0F;
	Tue, 28 Oct 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667799; cv=none; b=Pl6R1yniyprb60OuuADozUbqOCxOGSAKzYuTg93NWIkL0F7YBj2eJBpxIwvTa+imNVVOo/byPr/tOs5N8IXof3ilqFO/tfCE+nKHNAFHmFIKJkBiGgDK7kJZIraY1IhB8wQTMGT5z+9zxohsv+A8tYQU0N1JZdzdI7kjuAGAqgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667799; c=relaxed/simple;
	bh=yS9M85o0R1tVxIA9C9jEiGOV1H8VwCUJawV1LHO0FmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lS0YWxnOmJQ+x9j5u5Bxg9KJg4Ewj06ar3EjM25qBQSBh1M1FB0rQE42TciuEjuedF416sXUdlrOMEoXZi1/O3LCHcu8kCyM9/Shgg2RvYKNN3AWp7QsamwcDuujc/0tnd1/vGpSxRJ35K/gSShGBLu1dpV6ogBoEaKLmmrgj8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Klvoy4DM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713ECC113D0;
	Tue, 28 Oct 2025 16:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761667798;
	bh=yS9M85o0R1tVxIA9C9jEiGOV1H8VwCUJawV1LHO0FmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Klvoy4DM0bfRyYdMUJy+zBkWNEL+Q2goNadja/TnrTf4DM91nNMBozc1k89jNw1Of
	 pC7+YdVRhVKTlzhIA5Y38VSaMSCqAJX3RU1Dx9ltV548c6zTJ+UhdQejy919N8WQX2
	 x86YaAuQDf99auJcSlOv9y7wAtAmwKiXSVkTg2mAFOkAiLdcQ5Yfeuctn4bSwtVL2n
	 bL/iCAd35vlxMFBvU1MPX34VzDWiqB9KEde1exDoHxv35O1dF5BBoKNdwWcXuPm4wE
	 Gg7tJ8EZ3KIOFONRcW03HRdTmdN/z8oMvto6rRoIQrdmHD1/LKdQCUUgORlsTIuXkE
	 bhbVwN8bkHmOQ==
From: Mark Brown <broonie@kernel.org>
To: Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Vinod Koul <vkoul@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev, 
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027125655.793277-1-wens@kernel.org>
References: <20251027125655.793277-1-wens@kernel.org>
Subject: Re: (subset) [PATCH v2 00/10] allwinner: a523: Enable I2S and
 SPDIF TX
Message-Id: <176166779616.143847.10303188319180115816.b4-ty@kernel.org>
Date: Tue, 28 Oct 2025 16:09:56 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Mon, 27 Oct 2025 20:56:41 +0800, Chen-Yu Tsai wrote:
> This is v2 of my Allwinner A523 family I2S and SPDIF enablement series.
> 
> Changes since v1:
> - Collected tags
> - Dropped clk patches that were merged
> - Added patch for SPDIF pinmux settings that was missing in v1
> - Dropped bogus change to DAI name in SPDIF driver
> - Dropped clk rate message in SPDIF driver
> - Switched my email to kernel.org one
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[02/10] ASoC: dt-bindings: allwinner,sun4i-a10-i2s: Add compatible for A523
        commit: 67e4b0dfcc6702a31fbb6a3015c0dc867e295eb4
[03/10] ASoC: dt-bindings: allwinner,sun4i-a10-spdif: Add compatible for A523
        commit: 6ddcd78aa7f85e1d94ab7f90c72d1ad0c0c7b6ea
[04/10] ASoC: sun4i-spdif: Support SPDIF output on A523 family
        commit: 4a5ac6cd05a7e54f1585d7779464d6ed6272c134

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


