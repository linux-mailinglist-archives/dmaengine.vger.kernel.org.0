Return-Path: <dmaengine+bounces-9522-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EENgC2QhvGnQswIAu9opvQ
	(envelope-from <dmaengine+bounces-9522-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:16:36 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0022CE945
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0137630A891B
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E528E3E92AC;
	Thu, 19 Mar 2026 15:54:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C39E3E8C60;
	Thu, 19 Mar 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935695; cv=none; b=YkdNs/ihJyNDkN+YKx/mGnhAl7UJNWGo015jZzFFlhfyQTJRCwBzg/bWrWJYTqYGZDg6eKURZ9/SV7EB725L1hd/saXaIrxv+JgTCuybP5kpVgZ2+9j4UWAckiF8mClzUDc0ngXrteFyOx+Nh9+IZPmbeDbirkecwTd+3CQFQd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935695; c=relaxed/simple;
	bh=TvoFaZnDkHljuedn8mMgsQnpQsCc4CsQRQvlqeGSZK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ik52AHFxilHQpw/Z/xZIKScSjjc4r+ZwWDnP0/UpYS8Aqodcu9ov5BRjIxAGGjteqrCks2c0eofiKHFXLyQYQHP+XaVoFTkUJvDL4M6QetOUFBSl6ATAYCcM3rQS2gIZtKLArDb4XuzT83/qqAZ3s5y4RVBeG0LRsgS/CItNXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: q8RlAQb8QsmTHSjO3z1ysA==
X-CSE-MsgGUID: pYohW8xKSuiQFh6fyMKcsQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Mar 2026 00:54:45 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.35])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1381B40189E4;
	Fri, 20 Mar 2026 00:54:36 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Vinod Koul <vkoul@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	John Madieu <john.madieu@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-sound@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH 00/22] ASoC: rsnd: Add audio support for the Renesas RZ/G3E SoC
Date: Thu, 19 Mar 2026 16:53:12 +0100
Message-ID: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9522-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_SPAM(0.00)[0.797];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C0022CE945
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds audio support for the Renesas RZ/G3E SoC and enables
it on the SMARC EVK board with the Dialog DA7212 codec.

The RZ/G3E audio subsystem is based on R-Car Sound IP but has several
differences requiring dedicated handling:
  - SSI operates exclusively in BUSIF mode (no PIO)
  - 2 BUSIF channels per SSI instead of 4/8 on R-Car
  - Different register offsets for SCU, ADG, SSIU, and SSI
  - Per-SSI ADG and SSIF supply clocks
  - DMA ACK signal routing through ICU

This series includes:
  - Clock driver support for audio clocks and resets
  - DT bindings update for DMA ACK signal field
  - IRQ chip extension for DMA ACK signal routing
  - RZ-DMAC driver updates for ACK signal support
  - R-Car Sound driver updates for RZ/G3E support
  - System suspend/resume support
  - Device tree nodes for RZ/G3E SMARC EVK

Note: patch 06/22 depends on [1]. As this patch will propably be routed
through the DMA tree independently, the rest of the series can be reviewed
and the remaining patches applied without this dependency being resolved
first.

Audio configuration on SMARC EVK:
  - Codec: Dialog DA7212 on I2C1
  - Playback: SSI3 -> SRC1 -> DVC1
  - Capture: SSI4 -> SRC0 -> DVC0
  - MCLK: 12.288MHz from Versa3 clock generator
  - Format: I2S, RZ/G3E Sound as clock master
  - SSI4 shares clock pins with SSI3 (shared-pin)

Tested on RZ/G3E SMARC EVK with:
  - Playback to headphone output
  - Capture from line-in (AUX) input and/or Mic
  - Full duplex operation
  - System suspend/resume

[1] https://lore.kernel.org/all/20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com/

John Madieu (22):
  dt-bindings: clock: renesas: Add audio clock inputs for RZ/V2H family
  arm64: dts: renesas: rzv2h: Add audio clock inputs
  clk: renesas: r9a09g047: Add audio clock and reset support
  dt-bindings: dma: renesas,rz-dmac: Document optional DMA ACK cell
  irqchip/renesas-rzv2h: Add DMA ACK signal routing support
  dma: sh: rz-dmac: Add DMA ACK signal routing support
  ASoC: dt-bindings: renesas,rsnd: Add RZ/G3E support
  ASoC: rsnd: Add reset controller support to rsnd_mod
  ASoC: rsnd: Add RZ/G3E SoC probing and register map
  ASoC: rsnd: Add DMA support infrastructure for RZ/G3E
  ASoC: rsnd: ssui: Add RZ/G3E SSIU BUSIF support
  ASoC: rsnd: Update SSI for RZ/G3E support
  ASoC: rsnd: Add ADG reset support for RZ/G3E
  ASoC: rsnd: adg: Add per-SSI ADG and SSIF supply clock management
  ASoC: rsnd: src: Add SRC reset and clock support for RZ/G3E
  ASoC: rsnd: Export module getters for PM support
  ASoC: rsnd: Add system suspend/resume support
  arm64: dts: renesas: r9a09g047: Add R-Car Sound support
  arm64: dts: renesas: rzg3e-smarc-som: Add Versa3 clock generator
  arm64: dts: renesas: rzg3e-smarc-som: Add I2C1 support
  arm64: dts: renesas: rzg3e-smarc-som: add audio pinmux definitions
  arm64: dts: renesas: r9a09g047e57-smarc: add DA7212 audio codec
    support

 .../bindings/clock/renesas,rzv2h-cpg.yaml     |  10 +
 .../bindings/dma/renesas,rz-dmac.yaml         |  28 +-
 .../bindings/sound/renesas,rsnd.yaml          | 169 +++++-
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 543 +++++++++++++++++-
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 114 ++++
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    |  27 +-
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    |  27 +-
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  44 ++
 drivers/clk/renesas/r9a09g047-cpg.c           | 130 ++++-
 drivers/dma/sh/rz-dmac.c                      |  40 +-
 drivers/irqchip/irq-renesas-rzv2h.c           |  36 ++
 include/linux/irqchip/irq-renesas-rzv2h.h     |   5 +
 sound/soc/renesas/rcar/adg.c                  | 117 +++-
 sound/soc/renesas/rcar/cmd.c                  |   2 +-
 sound/soc/renesas/rcar/core.c                 | 128 ++++-
 sound/soc/renesas/rcar/ctu.c                  |   2 +-
 sound/soc/renesas/rcar/dma.c                  | 173 ++++--
 sound/soc/renesas/rcar/dvc.c                  |   2 +-
 sound/soc/renesas/rcar/gen.c                  | 184 ++++++
 sound/soc/renesas/rcar/mix.c                  |   2 +-
 sound/soc/renesas/rcar/rsnd.h                 |  39 ++
 sound/soc/renesas/rcar/src.c                  |  45 +-
 sound/soc/renesas/rcar/ssi.c                  |  40 +-
 sound/soc/renesas/rcar/ssiu.c                 |  49 +-
 24 files changed, 1855 insertions(+), 101 deletions(-)

-- 
2.25.1


