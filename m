Return-Path: <dmaengine+bounces-6890-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834C5BF29E5
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03ED0422543
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3C6331A6C;
	Mon, 20 Oct 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTQz/DbS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F2532F754;
	Mon, 20 Oct 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980280; cv=none; b=KL4JMiuQ1GKOFFkAUnSVz03AM0ogk/zwwzGBNPxHc3GZlIbshzcv4hm1C3u982P5Ay7bHMJLsf+VT9VR+/DgnpWneG85Za9lWLSeRAcZ74F4agyvN3Gdmsx99PwfnCtErJRKDNhEDpKcwIfuTAyGso/O+WIn3C+SJIqV46qR1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980280; c=relaxed/simple;
	bh=TJPYa24Z5KTj/XUQBDA+4muq/sKdsaWSFY+S+sPkdkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIfTC1fQRqpNr66bAWuk4T6M9eiIOTdheb/qPSCuISI2/s3pua+2mntMwNlnMTrrKPlNq9n91m3GM/iGciLfC4tqz9pTTOdUQHTmTRisQnS2BPTznNdzbBcdNl9741XH6rqsayyyKW/3PEAVCcBZEDKNuW3exIwRucp/ab84wiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTQz/DbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B395C4CEF9;
	Mon, 20 Oct 2025 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980280;
	bh=TJPYa24Z5KTj/XUQBDA+4muq/sKdsaWSFY+S+sPkdkw=;
	h=From:To:Cc:Subject:Date:From;
	b=RTQz/DbS3nDJtiW0gDdrU4/D+mk33QWYGezbsuDwSgW+xyVGsCuE7m2lbKyKoZDYg
	 Qxd2TUg5S8DD4fruNkVcz6j9K2v0gJFpE6uo4SZaiwN6gkdyVwLfkaneT53r5mDLH7
	 WoUBvzrF4qdszKMcVpagSm4DAFS+/vF12j6AL74W6f3HsqSeqZ3cfBsFgCvUocr291
	 Q84eyOe8eHgi1cUIQiImKIl+am2qIMJjFA3bkyY05VTwx/oHMC06eQm5Aq1xnKVWUt
	 odkOIZ8CHk2n+GNqzHgdEF7a5pMxYN0hWChZwXnFGS4LMAX5WhEe+eSD+gJ7lXcQdw
	 MLoZ4bYpOegMA==
Received: by wens.tw (Postfix, from userid 1000)
	id 1D6D45FDC3; Tue, 21 Oct 2025 01:11:18 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Mark Brown <broonie@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] allwinner: a523: Enable I2S and SPDIF TX
Date: Tue, 21 Oct 2025 01:10:46 +0800
Message-ID: <20251020171059.2786070-1-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This series enables the SPDIF and I2S hardware found on the Allwinner
A523/A527/T527 family SoCs. These SoCs have one SPDIF interface and
four I2S interfaces. All of them are capable of both playback and
capture, however the SPDIF driver only supports playback.

The series is organized by subsystem, so each maintainer can find the
patches they need to take.

Patch 1 adds SoC/hardware specific compatibles for the two DMA
controllers in the A523 SoC.

Patch 2 adds an SoC specific compatible for the I2S interface
controllers in the A523 SoC.

Patch 3 adds an SoC specific compatible for the SPDIF interface
controller in the A523 SoC.

Patch 4 adds driver support for the SPDIF interface.

Patch 5 marks a clock related to the DMA controller as critical. The
docs are quite vague on how this particular clock gate ties in with
the other memory bus gate that the DMA controller needs.

Patch 6 tweaks the software lower limit of the audio PLL.

Patch 7 adds devices nodes for the DMA controllers.

Patch 8 adds a devices node for the SPDIF interface controller.

Patch 9 adds device nodes for the I2S interface controllers.

Patch 10 adds one set of pinmux settings for I2S2.

Patch 11 is what I used to test the changes, and serves as an example
for how to use these new interfaces.


Patch 1 can go through the dmaengine tree, or I can take it through the
sunxi tree.

Patches 2 through 4 should go through the ASoC tree.

The rest, except the example, will go through the sunxi tree.


Please take a look.


Thanks
ChenYu


Chen-Yu Tsai (11):
  dt-bindings: dma: allwinner,sun50i-a64-dma: Add compatibles for A523
  ASoC: dt-bindings: allwinner,sun4i-a10-i2s: Add compatible for A523
  ASoC: dt-bindings: allwinner,sun4i-a10-spdif: Add compatible for A523
  ASoC: sun4i-spdif: Support SPDIF output on A523 family
  clk: sunxi-ng: sun55i-a523-r-ccu: Mark bus-r-dma as critical
  clk: sunxi-ng: sun55i-a523-ccu: Lower audio0 pll minimum rate
  arm64: dts: allwinner: a523: Add DMA controller device nodes
  arm64: dts: allwinner: a523: Add device node for SPDIF block
  arm64: dts: allwinner: a523: Add device nodes for I2S controllers
  arm64: dts: allwinner: a523: Add I2S2 pins on PI pin group
  [EXAMPLE] arm64: dts: allwinner: a527-cubie-a5e: Enable I2S and SPDIF
    output

 .../dma/allwinner,sun50i-a64-dma.yaml         |   5 +-
 .../sound/allwinner,sun4i-a10-i2s.yaml        |   4 +-
 .../sound/allwinner,sun4i-a10-spdif.yaml      |  44 +++++-
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 135 ++++++++++++++++++
 .../dts/allwinner/sun55i-a527-cubie-a5e.dts   |  52 +++++++
 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c      |   2 +-
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c        |   2 +-
 sound/soc/sunxi/sun4i-spdif.c                 |  28 +++-
 8 files changed, 259 insertions(+), 13 deletions(-)

-- 
2.47.3


