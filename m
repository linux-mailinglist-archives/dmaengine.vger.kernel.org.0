Return-Path: <dmaengine+bounces-3904-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 815819E5873
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 15:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8181692CB
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C4421A447;
	Thu,  5 Dec 2024 14:25:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAD8217F50;
	Thu,  5 Dec 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408742; cv=none; b=jsnqCyGuDdyqE4nnqxDO3jDWqzN//JqWM1UF+LsZYUVBtGLE4h1aQOQ4M2j6//RyZZaiO223TjixtgcokqZ0CmPBZoDz0Jf5kxLFBYAKD93QUvHA8mc0uYvrQxRsAvU2/bObTbC3JzsFfpJWWf+GNO5TE6mtEId1G2V9Y+IaH0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408742; c=relaxed/simple;
	bh=Z485lVPUoZmW8dAMvkKVCKL68+bmHCcXkRHAdO8N4fE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qsXjFEAGpjCrTKm7AQGti2nbWyFQmIrxi/3v2KXDDI6JnEvp92oFSy2NTPv7/dPU+MVVD5+RCwl7GNzj6D5KowVpquQFJB/dSuHDny5QrBf+t4qpQRSVuFHJ8dKMlriyjx3M2STIQxDFhyk160DC3Tcx8bRSF6skNcK6UbTJXd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B752DC4CEDC;
	Thu,  5 Dec 2024 14:25:41 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id CF00A5FA91;
	Thu,  5 Dec 2024 22:25:38 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Cs=C3=B3k=C3=A1s=2C_Bence?= <csokas.bence@prolan.hu>
Cc: Mark Brown <broonie@kernel.org>, Mesih Kilinc <mesihkilinc@gmail.com>, 
 Vinod Koul <vkoul@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20241122161128.2619172-1-csokas.bence@prolan.hu>
References: <20241122161128.2619172-1-csokas.bence@prolan.hu>
Subject: Re: [PATCH v5 0/5] Add support for DMA of F1C100s
Message-Id: <173340873878.1777403.11710031355609971039.b4-ty@csie.org>
Date: Thu, 05 Dec 2024 22:25:38 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Fri, 22 Nov 2024 17:11:23 +0100, Csókás, Bence wrote:
> Support for Allwinner F1C100s/200s series audio was
> submitted in 2018 as an RFC series, but was not merged,
> despite having only minor errors. However, this is
> essential for having audio on these SoCs.
> This series was forward-ported/rebased to the best of
> my abilities, on top of Linus' tree as of now:
> commit 28eb75e178d3 ("Merge tag 'drm-next-2024-11-21' of https://gitlab.freedesktop.org/drm/kernel")
> 
> [...]

Applied to dt-for-6.14 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!

[1/5] dma-engine: sun4i: Add a quirk to support different chips
      (no commit info)
[2/5] dma-engine: sun4i: Add has_reset option to quirk
      (no commit info)
[3/5] dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA
      (no commit info)
[4/5] dma-engine: sun4i: Add support for Allwinner suniv F1C100s
      (no commit info)
[5/5] ARM: dts: suniv: f1c100s: Add support for DMA
      commit: 7336701f6467381af87a462008793178925a03bf

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


