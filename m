Return-Path: <dmaengine+bounces-831-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9757083EEA2
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 17:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E3F282D48
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 16:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ECC2C6A4;
	Sat, 27 Jan 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK7PSKCY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F901E860;
	Sat, 27 Jan 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706373175; cv=none; b=iFws1Wy9ZWkXI5Jkl02ECxinOxMgVHu4GbecFaFEvoXGeya+naIUeICyxShakMmaUV1qlNk01y7sOsEkfumLFz2Cf7GrxnnM9lslFE1jzaHCQ7neDhXtsznsVEnAFtQMk1hfomyOWG3xl+jzP/z0wTIwQ5qAs00KNORminI1ZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706373175; c=relaxed/simple;
	bh=KAfVWbrl2OKLT7q1byYXuM4lIKN7zYfbYPsqezgJCYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oyVUaEuuS41eNNJxJgveIp/Iz2sLonGr7UlUmMKBACy4Fgd2byDpRp75Q5nXp30xc3wr6oeZA6H1r0xR8sS56emZgfW8GZZOT8SSguQ/g3KSLfF6I6UTNtI9Q4BYvYWv3/20dHDqgfTk+klIHqTQwXwJ2KFGtX+Kbtp8yZ4JGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK7PSKCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DC0C43394;
	Sat, 27 Jan 2024 16:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706373175;
	bh=KAfVWbrl2OKLT7q1byYXuM4lIKN7zYfbYPsqezgJCYI=;
	h=From:To:Cc:Subject:Date:From;
	b=JK7PSKCY+LB8W5oAPOptM9zT+5K7HyUnEY5aYJDIP/p0/w6jz1IFHPJ+KBIZZnntC
	 MG/FszS/kR3teA2mSIXCOkMcE/MiyK4TenSc0hlrwB6QrJq+KgDlWtYVnzazFlBq0C
	 HveOSMmwec9DYR7aomCTOroIAKcOc+gKXhrgRBwPnufZg/FzojXFnwMz0f8O67jZhQ
	 Ao+KnuY86B7WkjG8KtqIBSp77OlaehPHkemIbsi72By3nVzwpB0qbdiueZUKg0tizu
	 RztEevpslTMUc2S1r8UnyeM2afCO85LUdAhlM2Cx4wDuazY7wgZuN/GMOYtvOOeO3u
	 dWmWGoImzg+TA==
Received: by wens.tw (Postfix, from userid 1000)
	id 3CAC35FB4D; Sun, 28 Jan 2024 00:32:52 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] arm64: sun50i-h616: Add DMA and SPDIF controllers
Date: Sun, 28 Jan 2024 00:32:40 +0800
Message-Id: <20240127163247.384439-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

This is v2 of my H616/H618 DMA and SPDIF controller series.

Changes since v1:
- Switch to "contains" for if-properties statement
- Fall back to A100 instead of H6
- Add DMA channels for r_i2c

This series adds DMA and SPDIF controllers for the H616 and H618.
There's also a fix for SPDIF on H6: the controller also has a
receiver that was not correctly modeled.

Patch 1 fixes the binding for the SPDIF controller on the H6 by adding
the RX DMA channel.

Patch 2 adds a compatible string for the H616's SPDIF transmitter to the
binding.

Patch 3 adds a compatible string for the H616's SPDIF transmitter to the
driver.

Patch 4 adds a compatible string for the H616's DMA controller.

Patch 5 adds the RX DMA channel to the SPDIF controller on the H6.

Patch 6 adds a device node for the H616's DMA controller.

Patch 7 adds a device node for the H616's SPDIF controller.


This was tested on the Orange Pi Zero 3 with SPI flash transfers and
SPDIF audio output. The H6 SPDIF change is superficial as the driver
does not support receiving / capturing an audio stream.

Please have a look. I expect the first three patches to go through the
ASoC tree, the fourth patch to either go through the DMA tree, or
through the sunxi tree with an Ack, and the last three through the sunxi
tree.


Thanks
ChenYu


Chen-Yu Tsai (7):
  dt-bindings: sound: sun4i-spdif: Fix requirements for H6
  dt-bindings: sound: sun4i-spdif: Add Allwinner H616 compatible
  ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
  dt-bindings: dma: allwinner,sun50i-a64-dma: Add compatible for H616
  arm64: dts: allwinner: h6: Add RX DMA channel for SPDIF
  arm64: dts: allwinner: h616: Add DMA controller and DMA channels
  arm64: dts: allwinner: h616: Add SPDIF device node

 .../dma/allwinner,sun50i-a64-dma.yaml         | 12 ++--
 .../sound/allwinner,sun4i-a10-spdif.yaml      |  5 +-
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  2 +
 .../boot/dts/allwinner/sun50i-h6-tanix.dtsi   |  2 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  7 +--
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 61 +++++++++++++++++++
 sound/soc/sunxi/sun4i-spdif.c                 |  5 ++
 7 files changed, 85 insertions(+), 9 deletions(-)

-- 
2.39.2


