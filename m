Return-Path: <dmaengine+bounces-6999-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD338C0DCA8
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 14:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB953B402A
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C044242D99;
	Mon, 27 Oct 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZT4zYMCs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79924397A;
	Mon, 27 Oct 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569820; cv=none; b=Al5FnptjUqhrGYT841Q4FhscJO1zUQ5LuvH2APRO4vMKO5odxqzb+t5GkY5RwRPNM53k1SjxIO4gcYCxdfyGsn8F6sqbibfOSXQip3M/gi1emVesij/Huy1YsJ3D9D9xKrRpZJKC6P8PN5wZCPvoYkAvMikoqmWU5d0p0VHJefY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569820; c=relaxed/simple;
	bh=jc28/M+RNzFr0Zbyp//cvE+46yBuDnf2OXIpuegk+vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXfS161cGdBBXU6EAhaoPQ5Y74Rcf/0H1nexW2Bq3t4NLRU6dl6ShySL04lr4JkKcsoO4ZOSLa7+CEP20Dt8wfKiKye+WQYrAZbcT3+NAe2uEvUKwmyjp7KyZtMKVFIdcPb2ooT+NGoloTH/HggFOEh+a9kIzMdtCDo4UXVVDmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZT4zYMCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2E6C4CEF1;
	Mon, 27 Oct 2025 12:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761569819;
	bh=jc28/M+RNzFr0Zbyp//cvE+46yBuDnf2OXIpuegk+vs=;
	h=From:To:Cc:Subject:Date:From;
	b=ZT4zYMCsCgCJWd9fI+KJCO2uu0gxjzCv+pZgMdoPtPMf5cR3GCV8+zN2STgSIPD3z
	 A5mucLn4z4Qd74SiZ1MydHMX+QXknZBCSkcoV+DLAjYSL1AYA+4G50ugM2sz00CjAw
	 v1M6ffWPotRBMZH9+NiNubGym6fPdUXEoNDkoCE+C+ytJT9ljyf6wRNMiZE+J8oT6+
	 sYuRxYI+9E4E8CPwxVtkCrIMH8fhG+XzIOcYeTDc17jwzLrTgU5ScbmXt1ck/psm+b
	 wjVEPu0IKGcIU+4FXxE1UJowNlO5sY+6a8bbEQJazcQNEPa6Yq/Gvl4RSvOCwBwsc3
	 Mz6eC0pGT5Byg==
Received: by wens.tw (Postfix, from userid 1000)
	id 6215D5FE2C; Mon, 27 Oct 2025 20:56:57 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Mark Brown <broonie@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] allwinner: a523: Enable I2S and SPDIF TX
Date: Mon, 27 Oct 2025 20:56:41 +0800
Message-ID: <20251027125655.793277-1-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This is v2 of my Allwinner A523 family I2S and SPDIF enablement series.

Changes since v1:
- Collected tags
- Dropped clk patches that were merged
- Added patch for SPDIF pinmux settings that was missing in v1
- Dropped bogus change to DAI name in SPDIF driver
- Dropped clk rate message in SPDIF driver
- Switched my email to kernel.org one

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

Patch 5 adds devices nodes for the DMA controllers.

Patch 6 adds a devices node for the SPDIF interface controller.

Patch 7 adds device nodes for the I2S interface controllers.

Patch 8 adds one set of pinmux settings for I2S2.

Patch 9 adds pinmux settings for SPDIF.

Patch 10 is what I used to test the changes, and serves as an example
for how to use these new interfaces.


Patch 1 can go through the dmaengine tree, or I can take it through the
sunxi tree.

Patches 2 through 4 should go through the ASoC tree.

The rest, except the example, will go through the sunxi tree.


Please take a look.


Thanks
ChenYu


Chen-Yu Tsai (10):
  dt-bindings: dma: allwinner,sun50i-a64-dma: Add compatibles for A523
  ASoC: dt-bindings: allwinner,sun4i-a10-i2s: Add compatible for A523
  ASoC: dt-bindings: allwinner,sun4i-a10-spdif: Add compatible for A523
  ASoC: sun4i-spdif: Support SPDIF output on A523 family
  arm64: dts: allwinner: a523: Add DMA controller device nodes
  arm64: dts: allwinner: a523: Add device node for SPDIF block
  arm64: dts: allwinner: a523: Add device nodes for I2S controllers
  arm64: dts: allwinner: a523: Add I2S2 pins on PI pin group
  arm64: dts: allwinner: a523: Add SPDIF TX pin on PB and PI pins
  [EXAMPLE] arm64: dts: allwinner: a527-cubie-a5e: Enable I2S and SPDIF
    output

 .../dma/allwinner,sun50i-a64-dma.yaml         |   5 +-
 .../sound/allwinner,sun4i-a10-i2s.yaml        |   4 +-
 .../sound/allwinner,sun4i-a10-spdif.yaml      |  44 +++++-
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 149 ++++++++++++++++++
 .../dts/allwinner/sun55i-a527-cubie-a5e.dts   |  52 ++++++
 sound/soc/sunxi/sun4i-spdif.c                 |  26 ++-
 6 files changed, 270 insertions(+), 10 deletions(-)

-- 
2.47.3


