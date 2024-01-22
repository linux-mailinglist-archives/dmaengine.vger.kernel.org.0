Return-Path: <dmaengine+bounces-790-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FF5836E08
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBDF283424
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 17:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D1F48791;
	Mon, 22 Jan 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ls8LeXzS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F73D99C;
	Mon, 22 Jan 2024 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943133; cv=none; b=h7OyCLU7BYUEddkFubkYcwlRT+Cedh92mjYSZKW/84hW/jHongEt0Ge9AsfRzw1hQ4rDivwgMaehtu91lEDgZGdXzwPNkwcR5Cs6Ikpj97FwRjenJGXOj23gZZOhRrsbt5gBNfmJElXxECuXs3v/B5NZ9t97LRoCFSHl5mmAMSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943133; c=relaxed/simple;
	bh=u+x2WqX+nY6J7+OJiu4BqOVl1NPhZVvy6votpSfLE0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BwWz6O7sMcoHKvdy3qLBOSiTwBo3vgXIbT+eoN+Okj0dL8ld1ABtbvQATD7pBayMQZkIUXsIuPt6pJkqIAhvO4Rs1mKstpK1lfw4DsKwyat73nf2ChN2sP7mdG45XIv4rKy7oadfAquKLF5CPiAXExAAHptHRP5wevtGsxhSwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ls8LeXzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A419C43399;
	Mon, 22 Jan 2024 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705943132;
	bh=u+x2WqX+nY6J7+OJiu4BqOVl1NPhZVvy6votpSfLE0c=;
	h=From:To:Cc:Subject:Date:From;
	b=Ls8LeXzSsBDex36hOEm07Q1pH2lApQFpET1O3m9R72GJwx1Ny2qNTo810BCKU+yzd
	 bzrCLfNBiukHr+NuXvRx4K9kTrH923dwcUHlEBlLKxYEQrakBMezpZkcVOaDgGICBe
	 UilMbxPHOYAc70nxLnyvu8p2DqrPD71PzCEUDR+u61C6jfWK6YIejcVjkh7StG2S7S
	 sl/SvB8ODCV5YN0LXLJy6na0/Tdtl9vS+UBaTaNlLsNEW7ysJm0S2rvDu4UemTGZp2
	 /O8rLlOvGN67ym9iYYkIIaSHGfpPLKa6sGNrvsjhFd8Vl1enslebadYsKmMTFWkTEa
	 nOsqzR2ypckBQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 8E58C5FEE9; Tue, 23 Jan 2024 01:05:29 +0800 (CST)
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
Subject: [PATCH 0/7] arm64: sun50i-h616: Add DMA and SPDIF controllers
Date: Tue, 23 Jan 2024 01:05:11 +0800
Message-Id: <20240122170518.3090814-1-wens@kernel.org>
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

 .../dma/allwinner,sun50i-a64-dma.yaml         | 15 +++--
 .../sound/allwinner,sun4i-a10-spdif.yaml      |  5 +-
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  2 +
 .../boot/dts/allwinner/sun50i-h6-tanix.dtsi   |  2 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  7 +--
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 59 +++++++++++++++++++
 sound/soc/sunxi/sun4i-spdif.c                 |  5 ++
 7 files changed, 86 insertions(+), 9 deletions(-)

-- 
2.39.2


