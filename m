Return-Path: <dmaengine+bounces-6859-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 925ECBDFA16
	for <lists+dmaengine@lfdr.de>; Wed, 15 Oct 2025 18:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A4404EE83F
	for <lists+dmaengine@lfdr.de>; Wed, 15 Oct 2025 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546F83375A5;
	Wed, 15 Oct 2025 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuqpDqa1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C45D202F71;
	Wed, 15 Oct 2025 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545332; cv=none; b=i9Ymlh9y+vHpkD+WKNFR6ns4fOCqKEYP+OIykcf4g7Jfw5RYpbd2FYl8g4WtMw+QgS5q/p+95UsYPQxwqYzZzxMeDteAnTe9Y5Lp/ZDf9UpdbF8iJkWhWZcsTQEkPRdXLj+A5TJmVzznw17zbJnITZCTe2Kn6wY0gQ1J8zUKu3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545332; c=relaxed/simple;
	bh=m5yz6FAGECP9+hJqdl/rehdUmr+YvIiUg5swfLlBFGk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CSvCgqjo5raeKdpK+QY0TDRFEVZ3yZZ6WRDDk2K865+Wd4VzK6TdP3X5JlA971IoKv4JOeQEP0PmMtrbeaeOGTU9IeAt1rDG6AX9KaDXVG4Oq9IK6yhN2xm+hRMQagQrsXovVRdvnMFRWKpX9jRS2RkPj2H/DgIWvLWs7ug1UDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuqpDqa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9C1C4CEF9;
	Wed, 15 Oct 2025 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760545330;
	bh=m5yz6FAGECP9+hJqdl/rehdUmr+YvIiUg5swfLlBFGk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JuqpDqa1YOpi244K0gRdbMaFRQVKXJFoxEajxUXv4EOncI+NW2gCfk6C6742EorfY
	 cHWVCgqZ+VehNMHDpgqcrg+YsZ8wvPLEtd8kpVQqJXwNN5RlTzeS1g1PCFgEcH+icC
	 PWH6v4b1CHP21kyfdHL6+Zeyiq0ElrjtEnBCxhZgzeDKYd4jKKuEa87Nrot6kchddH
	 gIBee+jSI6kiDRyJVhnZmU8NrwPlqXtUezcSyTgTXy+0cOmIc1pFj6SxDSq2pdG3bw
	 44Q8/16bVwfAyd4Zy+R27pZ6rdx/fZg3KfvPOeDY4NbvAO1GGUS4kb0CpnyJbzSJSC
	 oAS6zTG7kSgJQ==
From: Mark Brown <broonie@kernel.org>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 "Sheetal ." <sheetal@nvidia.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
 Sameer Pujar <spujar@nvidia.com>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org
In-Reply-To: <20250929105930.1767294-1-sheetal@nvidia.com>
References: <20250929105930.1767294-1-sheetal@nvidia.com>
Subject: Re: (subset) [PATCH V2 0/4] Add tegra264 audio device tree support
Message-Id: <176054532703.196625.10143802503112850077.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 17:22:07 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Mon, 29 Sep 2025 16:29:26 +0530, Sheetal . wrote:
> Add device tree support for tegra264 audio subsystem including:
> - Binding update for
>   - 64-channel ADMA controller
>   - 32 RX/TX ADMAIF channels
>   - tegra264-agic binding for arm,gic
> - Add device tree nodes for
>   - APE subsystem (ACONNECT, AGIC, ADMA, AHUB and children (ADMAIF, I2S,
>     DMIC, DSPK, MVC, SFC, ASRC, AMX, ADX, OPE and Mixer) nodes
>   - HDA controller
>   - sound
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/4] dt-bindings: sound: Update ADMAIF bindings for tegra264
      commit: 4d410ba9aa275e7990a270f63ce436990ace1bea

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


