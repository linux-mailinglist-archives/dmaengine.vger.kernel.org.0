Return-Path: <dmaengine+bounces-9540-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEtkDiYgvGnQswIAu9opvQ
	(envelope-from <dmaengine+bounces-9540-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:11:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A15A12CE7A1
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51C49319EEC8
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 16:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15773ED105;
	Thu, 19 Mar 2026 15:57:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3644B3E92B6;
	Thu, 19 Mar 2026 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935857; cv=none; b=QKNTRArx/Qm1jkeRNZPDxj4ZKI8snVrmGmlsLaQMYI/JQaAlAPUDG2G0BQ7lGhf/hLGbPmXa1xyzYC02hzLQJ1nzQuiw8Xwayhz90P/OahpEFN1tK3BJlRbUuYi9zTRmc/qJO4jU2T9CxSwQ/qEEhWX95K1IsTu0CHAyAQQDJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935857; c=relaxed/simple;
	bh=HD4ub3oiMZjVGLfKPj58IDNXwT2pisneCi2Nx3lhf1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CI0e64/9HRGU98OR4aQ7bA4xaxs/mXSXGW+WMzv3JP90WpCO5hdQfMU4LUsPEVQyF85clG5ojKaf2f4mmkfQ89uOSwQdebhm0klHIA/B30TaChmHoT2KolknK37dL8HFdjwzOyxk8AjrWtHLjH3urnWneHTY2nFuS0A6RIO7Stc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: rAmKXkMAQV6z+fC3wdD5tg==
X-CSE-MsgGUID: EpIKdKTYQ4mDVyEbExiVfA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Mar 2026 00:57:34 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.35])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6CD18401BC51;
	Fri, 20 Mar 2026 00:57:25 +0900 (JST)
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
Subject: [PATCH 18/22] arm64: dts: renesas: r9a09g047: Add R-Car Sound support
Date: Thu, 19 Mar 2026 16:53:30 +0100
Message-ID: <20260319155334.51278-19-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9540-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.658];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_PROHIBIT(0.00)[0.183.27.0:email];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.183.66.16:email,0.226.112.192:email,0.195.91.184:email,13c00000:email,0.173.243.64:email,0.219.186.0:email]
X-Rspamd-Queue-Id: A15A12CE7A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the rzg3e_sound node for the RZ/G3E SoC with all sub-components:

- SSI (Serial Sound Interface) units 0-9
- SSIU (Serial Sound Interface Unit) units 0-27
- SRC (Sample Rate Converter) units 0-9
- CTU (Channel Transfer Unit) units 0-7
- DVC (Digital Volume Control) units 0-1
- MIX (Mixer) units 0-1

Wire up all 5 DMA controllers (dmac0-dmac4) for each audio sub-node
with repeated channel names, so that the DMA core can pick the first
available controller. Update all DMA controllers' #dma-cells to 2 to
support the ACK signal routing required by audio peripherals through
the ICU.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 516 ++++++++++++++++++++-
 1 file changed, 511 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index 2787d316ea04..2eb9a6312281 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -357,7 +357,7 @@ dmac0: dma-controller@11400000 {
 			clocks = <&cpg CPG_MOD 0x0>;
 			power-domains = <&cpg>;
 			resets = <&cpg 0x31>;
-			#dma-cells = <1>;
+			#dma-cells = <2>;
 			dma-channels = <16>;
 			renesas,icu = <&icu 4>;
 		};
@@ -391,7 +391,7 @@ dmac1: dma-controller@14830000 {
 			clocks = <&cpg CPG_MOD 0x1>;
 			power-domains = <&cpg>;
 			resets = <&cpg 0x32>;
-			#dma-cells = <1>;
+			#dma-cells = <2>;
 			dma-channels = <16>;
 			renesas,icu = <&icu 0>;
 		};
@@ -425,7 +425,7 @@ dmac2: dma-controller@14840000 {
 			clocks = <&cpg CPG_MOD 0x2>;
 			power-domains = <&cpg>;
 			resets = <&cpg 0x33>;
-			#dma-cells = <1>;
+			#dma-cells = <2>;
 			dma-channels = <16>;
 			renesas,icu = <&icu 1>;
 		};
@@ -459,7 +459,7 @@ dmac3: dma-controller@12000000 {
 			clocks = <&cpg CPG_MOD 0x3>;
 			power-domains = <&cpg>;
 			resets = <&cpg 0x34>;
-			#dma-cells = <1>;
+			#dma-cells = <2>;
 			dma-channels = <16>;
 			renesas,icu = <&icu 2>;
 		};
@@ -493,7 +493,7 @@ dmac4: dma-controller@12010000 {
 			clocks = <&cpg CPG_MOD 0x4>;
 			power-domains = <&cpg>;
 			resets = <&cpg 0x35>;
-			#dma-cells = <1>;
+			#dma-cells = <2>;
 			dma-channels = <16>;
 			renesas,icu = <&icu 3>;
 		};
@@ -834,6 +834,512 @@ rsci9: serial@12803000 {
 			status = "disabled";
 		};
 
+		snd_rzg3e: sound@13c00000 {
+			/*
+			 * #sound-dai-cells is required
+			 *
+			 * Single DAI : #sound-dai-cells = <0>; <&snd_rzg3e>;
+			 * Multi  DAI : #sound-dai-cells = <1>; <&snd_rzg3e N>;
+			 */
+			/*
+			 * #clock-cells is required for audio_clkout0/1/2/3
+			 *
+			 * clkout       : #clock-cells = <0>;   <&snd_rzg3e>;
+			 * clkout0/1/2/3: #clock-cells = <1>;   <&snd_rzg3e N>;
+			 */
+			compatible = "renesas,rcar_sound-r9a09g047";
+			reg = <0 0x13c00000 0 0x10000>, /* SCU */
+			      <0 0x13c20000 0 0x10000>, /* ADG */
+			      <0 0x13c30000 0 0x1000>,  /* SSIU */
+			      <0 0x13c31000 0 0x1F000>, /* SSI */
+			      <0 0x13c50000 0 0x10000>; /* Audio DMAC peri peri */
+			reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
+			clocks = <&cpg CPG_MOD 245>,
+				 <&cpg CPG_MOD 394>,
+				 <&cpg CPG_MOD 393>,
+				 <&cpg CPG_MOD 392>,
+				 <&cpg CPG_MOD 391>,
+				 <&cpg CPG_MOD 390>,
+				 <&cpg CPG_MOD 389>,
+				 <&cpg CPG_MOD 388>,
+				 <&cpg CPG_MOD 387>,
+				 <&cpg CPG_MOD 386>,
+				 <&cpg CPG_MOD 385>,
+				 <&cpg CPG_MOD 381>,
+				 <&cpg CPG_MOD 380>,
+				 <&cpg CPG_MOD 379>,
+				 <&cpg CPG_MOD 378>,
+				 <&cpg CPG_MOD 377>,
+				 <&cpg CPG_MOD 376>,
+				 <&cpg CPG_MOD 375>,
+				 <&cpg CPG_MOD 374>,
+				 <&cpg CPG_MOD 373>,
+				 <&cpg CPG_MOD 372>,
+				 <&cpg CPG_MOD 371>,
+				 <&cpg CPG_MOD 370>,
+				 <&cpg CPG_MOD 371>,
+				 <&cpg CPG_MOD 370>,
+				 <&cpg CPG_MOD 368>,
+				 <&cpg CPG_MOD 369>,
+				 <&cpg CPG_MOD 251>,
+				 <&cpg CPG_MOD 252>,
+				 <&cpg CPG_MOD 253>,
+				 <&cpg CPG_MOD 250>,
+				 <&cpg CPG_MOD 384>,
+				 <&cpg CPG_MOD 246>,
+				 <&cpg CPG_MOD 247>,
+				 <&cpg CPG_MOD 382>,
+				 <&cpg CPG_MOD 361>,
+				 <&cpg CPG_MOD 360>,
+				 <&cpg CPG_MOD 359>,
+				 <&cpg CPG_MOD 358>,
+				 <&cpg CPG_MOD 357>,
+				 <&cpg CPG_MOD 356>,
+				 <&cpg CPG_MOD 355>,
+				 <&cpg CPG_MOD 354>,
+				 <&cpg CPG_MOD 353>,
+				 <&cpg CPG_MOD 352>,
+				 <&cpg CPG_MOD 248>,
+				 <&cpg CPG_MOD 249>;
+			clock-names = "ssi-all",
+				      "ssi.9", "ssi.8",
+				      "ssi.7", "ssi.6",
+				      "ssi.5", "ssi.4",
+				      "ssi.3", "ssi.2",
+				      "ssi.1", "ssi.0",
+				      "src.9", "src.8",
+				      "src.7", "src.6",
+				      "src.5", "src.4",
+				      "src.3", "src.2",
+				      "src.1", "src.0",
+				      "mix.1", "mix.0",
+				      "ctu.1", "ctu.0",
+				      "dvc.0", "dvc.1",
+				      "clk_a", "clk_b",
+				      "clk_c", "clk_i",
+				      "ssif_supply",
+				      "scu", "scu_x2",
+				      "scu_supply",
+				      "adg.ssi.9", "adg.ssi.8",
+				      "adg.ssi.7", "adg.ssi.6",
+				      "adg.ssi.5", "adg.ssi.4",
+				      "adg.ssi.3", "adg.ssi.2",
+				      "adg.ssi.1", "adg.ssi.0",
+				      "audmac_pp", "adg";
+			power-domains = <&cpg>;
+			resets = <&cpg 225>,
+				 <&cpg 235>,
+				 <&cpg 234>,
+				 <&cpg 233>,
+				 <&cpg 232>,
+				 <&cpg 231>,
+				 <&cpg 230>,
+				 <&cpg 229>,
+				 <&cpg 228>,
+				 <&cpg 227>,
+				 <&cpg 226>,
+				 <&cpg 236>,
+				 <&cpg 238>,
+				 <&cpg 237>;
+			reset-names = "ssi-all",
+				      "ssi.9", "ssi.8",
+				      "ssi.7", "ssi.6",
+				      "ssi.5", "ssi.4",
+				      "ssi.3", "ssi.2",
+				      "ssi.1", "ssi.0",
+				      "scu", "adg",
+				      "audmac_pp";
+			status = "disabled";
+
+			rcar_sound,ctu {
+				ctu00: ctu-0 { };
+				ctu01: ctu-1 { };
+				ctu02: ctu-2 { };
+				ctu03: ctu-3 { };
+				ctu10: ctu-4 { };
+				ctu11: ctu-5 { };
+				ctu12: ctu-6 { };
+				ctu13: ctu-7 { };
+			};
+
+			rcar_sound,dvc {
+				dvc0: dvc-0 {
+					dmas = <&dmac0 0x1db3 0x1a>,
+					       <&dmac1 0x1db3 0x1a>,
+					       <&dmac2 0x1db3 0x1a>,
+					       <&dmac3 0x1db3 0x1a>,
+					       <&dmac4 0x1db3 0x1a>;
+					dma-names = "tx", "tx", "tx", "tx", "tx";
+				};
+				dvc1: dvc-1 {
+					dmas = <&dmac0 0x1db4 0x1b>,
+					       <&dmac1 0x1db4 0x1b>,
+					       <&dmac2 0x1db4 0x1b>,
+					       <&dmac3 0x1db4 0x1b>,
+					       <&dmac4 0x1db4 0x1b>;
+					dma-names = "tx", "tx", "tx", "tx", "tx";
+				};
+			};
+
+			rcar_sound,mix {
+				mix0: mix-0 { };
+				mix1: mix-1 { };
+			};
+
+			rcar_sound,src {
+				src0: src-0 {
+					interrupts = <GIC_SPI 902 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1d9f 0x6>, <&dmac0 0x1da9 0x10>,
+					       <&dmac1 0x1d9f 0x6>, <&dmac1 0x1da9 0x10>,
+					       <&dmac2 0x1d9f 0x6>, <&dmac2 0x1da9 0x10>,
+					       <&dmac3 0x1d9f 0x6>, <&dmac3 0x1da9 0x10>,
+					       <&dmac4 0x1d9f 0x6>, <&dmac4 0x1da9 0x10>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src1: src-1 {
+					interrupts = <GIC_SPI 903 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da0 0x7>, <&dmac0 0x1daa 0x11>,
+					       <&dmac1 0x1da0 0x7>, <&dmac1 0x1daa 0x11>,
+					       <&dmac2 0x1da0 0x7>, <&dmac2 0x1daa 0x11>,
+					       <&dmac3 0x1da0 0x7>, <&dmac3 0x1daa 0x11>,
+					       <&dmac4 0x1da0 0x7>, <&dmac4 0x1daa 0x11>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src2: src-2 {
+					interrupts = <GIC_SPI 904 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da1 0x8>, <&dmac0 0x1dab 0x12>,
+					       <&dmac1 0x1da1 0x8>, <&dmac1 0x1dab 0x12>,
+					       <&dmac2 0x1da1 0x8>, <&dmac2 0x1dab 0x12>,
+					       <&dmac3 0x1da1 0x8>, <&dmac3 0x1dab 0x12>,
+					       <&dmac4 0x1da1 0x8>, <&dmac4 0x1dab 0x12>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src3: src-3 {
+					interrupts = <GIC_SPI 905 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da2 0x9>, <&dmac0 0x1dac 0x13>,
+					       <&dmac1 0x1da2 0x9>, <&dmac1 0x1dac 0x13>,
+					       <&dmac2 0x1da2 0x9>, <&dmac2 0x1dac 0x13>,
+					       <&dmac3 0x1da2 0x9>, <&dmac3 0x1dac 0x13>,
+					       <&dmac4 0x1da2 0x9>, <&dmac4 0x1dac 0x13>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src4: src-4 {
+					interrupts = <GIC_SPI 906 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da3 0xa>, <&dmac0 0x1dad 0x14>,
+					       <&dmac1 0x1da3 0xa>, <&dmac1 0x1dad 0x14>,
+					       <&dmac2 0x1da3 0xa>, <&dmac2 0x1dad 0x14>,
+					       <&dmac3 0x1da3 0xa>, <&dmac3 0x1dad 0x14>,
+					       <&dmac4 0x1da3 0xa>, <&dmac4 0x1dad 0x14>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src5: src-5 {
+					interrupts = <GIC_SPI 907 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da4 0xb>, <&dmac0 0x1dae 0x15>,
+					       <&dmac1 0x1da4 0xb>, <&dmac1 0x1dae 0x15>,
+					       <&dmac2 0x1da4 0xb>, <&dmac2 0x1dae 0x15>,
+					       <&dmac3 0x1da4 0xb>, <&dmac3 0x1dae 0x15>,
+					       <&dmac4 0x1da4 0xb>, <&dmac4 0x1dae 0x15>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src6: src-6 {
+					interrupts = <GIC_SPI 908 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da5 0xc>, <&dmac0 0x1daf 0x16>,
+					       <&dmac1 0x1da5 0xc>, <&dmac1 0x1daf 0x16>,
+					       <&dmac2 0x1da5 0xc>, <&dmac2 0x1daf 0x16>,
+					       <&dmac3 0x1da5 0xc>, <&dmac3 0x1daf 0x16>,
+					       <&dmac4 0x1da5 0xc>, <&dmac4 0x1daf 0x16>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src7: src-7 {
+					interrupts = <GIC_SPI 909 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da6 0xd>, <&dmac0 0x1db0 0x17>,
+					       <&dmac1 0x1da6 0xd>, <&dmac1 0x1db0 0x17>,
+					       <&dmac2 0x1da6 0xd>, <&dmac2 0x1db0 0x17>,
+					       <&dmac3 0x1da6 0xd>, <&dmac3 0x1db0 0x17>,
+					       <&dmac4 0x1da6 0xd>, <&dmac4 0x1db0 0x17>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src8: src-8 {
+					interrupts = <GIC_SPI 910 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da7 0xe>, <&dmac0 0x1db1 0x18>,
+					       <&dmac1 0x1da7 0xe>, <&dmac1 0x1db1 0x18>,
+					       <&dmac2 0x1da7 0xe>, <&dmac2 0x1db1 0x18>,
+					       <&dmac3 0x1da7 0xe>, <&dmac3 0x1db1 0x18>,
+					       <&dmac4 0x1da7 0xe>, <&dmac4 0x1db1 0x18>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src9: src-9 {
+					interrupts = <GIC_SPI 911 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da8 0xf>, <&dmac0 0x1db2 0x19>,
+					       <&dmac1 0x1da8 0xf>, <&dmac1 0x1db2 0x19>,
+					       <&dmac2 0x1da8 0xf>, <&dmac2 0x1db2 0x19>,
+					       <&dmac3 0x1da8 0xf>, <&dmac3 0x1db2 0x19>,
+					       <&dmac4 0x1da8 0xf>, <&dmac4 0x1db2 0x19>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+			};
+
+			rcar_sound,ssi {
+				ssi0: ssi-0 {
+					interrupts = <GIC_SPI 889 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi1: ssi-1 {
+					interrupts = <GIC_SPI 890 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi2: ssi-2 {
+					interrupts = <GIC_SPI 891 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi3: ssi-3 {
+					interrupts = <GIC_SPI 892 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi4: ssi-4 {
+					interrupts = <GIC_SPI 893 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi5: ssi-5 {
+					interrupts = <GIC_SPI 894 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi6: ssi-6 {
+					interrupts = <GIC_SPI 895 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi7: ssi-7 {
+					interrupts = <GIC_SPI 896 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi8: ssi-8 {
+					interrupts = <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi9: ssi-9 {
+					interrupts = <GIC_SPI 898 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+
+			rcar_sound,ssiu {
+				ssiu00: ssiu-0 {
+					dmas = <&dmac0 0x1d61 0x1c>, <&dmac0 0x1d62 0x1d>,
+					       <&dmac1 0x1d61 0x1c>, <&dmac1 0x1d62 0x1d>,
+					       <&dmac2 0x1d61 0x1c>, <&dmac2 0x1d62 0x1d>,
+					       <&dmac3 0x1d61 0x1c>, <&dmac3 0x1d62 0x1d>,
+					       <&dmac4 0x1d61 0x1c>, <&dmac4 0x1d62 0x1d>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu01: ssiu-1 {
+					dmas = <&dmac0 0x1d63 0x1e>, <&dmac0 0x1d64 0x1f>,
+					       <&dmac1 0x1d63 0x1e>, <&dmac1 0x1d64 0x1f>,
+					       <&dmac2 0x1d63 0x1e>, <&dmac2 0x1d64 0x1f>,
+					       <&dmac3 0x1d63 0x1e>, <&dmac3 0x1d64 0x1f>,
+					       <&dmac4 0x1d63 0x1e>, <&dmac4 0x1d64 0x1f>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu02: ssiu-2 {
+					dmas = <&dmac0 0x1d65 0x20>, <&dmac0 0x1d66 0x21>,
+					       <&dmac1 0x1d65 0x20>, <&dmac1 0x1d66 0x21>,
+					       <&dmac2 0x1d65 0x20>, <&dmac2 0x1d66 0x21>,
+					       <&dmac3 0x1d65 0x20>, <&dmac3 0x1d66 0x21>,
+					       <&dmac4 0x1d65 0x20>, <&dmac4 0x1d66 0x21>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu03: ssiu-3 {
+					dmas = <&dmac0 0x1d67 0x22>, <&dmac0 0x1d68 0x23>,
+					       <&dmac1 0x1d67 0x22>, <&dmac1 0x1d68 0x23>,
+					       <&dmac2 0x1d67 0x22>, <&dmac2 0x1d68 0x23>,
+					       <&dmac3 0x1d67 0x22>, <&dmac3 0x1d68 0x23>,
+					       <&dmac4 0x1d67 0x22>, <&dmac4 0x1d68 0x23>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu10: ssiu-4 {
+					dmas = <&dmac0 0x1d69 0x24>, <&dmac0 0x1d6a 0x25>,
+					       <&dmac1 0x1d69 0x24>, <&dmac1 0x1d6a 0x25>,
+					       <&dmac2 0x1d69 0x24>, <&dmac2 0x1d6a 0x25>,
+					       <&dmac3 0x1d69 0x24>, <&dmac3 0x1d6a 0x25>,
+					       <&dmac4 0x1d69 0x24>, <&dmac4 0x1d6a 0x25>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu11: ssiu-5 {
+					dmas = <&dmac0 0x1d6b 0x26>, <&dmac0 0x1d6c 0x27>,
+					       <&dmac1 0x1d6b 0x26>, <&dmac1 0x1d6c 0x27>,
+					       <&dmac2 0x1d6b 0x26>, <&dmac2 0x1d6c 0x27>,
+					       <&dmac3 0x1d6b 0x26>, <&dmac3 0x1d6c 0x27>,
+					       <&dmac4 0x1d6b 0x26>, <&dmac4 0x1d6c 0x27>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu12: ssiu-6 {
+					dmas = <&dmac0 0x1d6d 0x28>, <&dmac0 0x1d6e 0x29>,
+					       <&dmac1 0x1d6d 0x28>, <&dmac1 0x1d6e 0x29>,
+					       <&dmac2 0x1d6d 0x28>, <&dmac2 0x1d6e 0x29>,
+					       <&dmac3 0x1d6d 0x28>, <&dmac3 0x1d6e 0x29>,
+					       <&dmac4 0x1d6d 0x28>, <&dmac4 0x1d6e 0x29>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu13: ssiu-7 {
+					dmas = <&dmac0 0x1d6f 0x2a>, <&dmac0 0x1d70 0x2b>,
+					       <&dmac1 0x1d6f 0x2a>, <&dmac1 0x1d70 0x2b>,
+					       <&dmac2 0x1d6f 0x2a>, <&dmac2 0x1d70 0x2b>,
+					       <&dmac3 0x1d6f 0x2a>, <&dmac3 0x1d70 0x2b>,
+					       <&dmac4 0x1d6f 0x2a>, <&dmac4 0x1d70 0x2b>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu20: ssiu-8 {
+					dmas = <&dmac0 0x1d71 0x2c>, <&dmac0 0x1d72 0x2d>,
+					       <&dmac1 0x1d71 0x2c>, <&dmac1 0x1d72 0x2d>,
+					       <&dmac2 0x1d71 0x2c>, <&dmac2 0x1d72 0x2d>,
+					       <&dmac3 0x1d71 0x2c>, <&dmac3 0x1d72 0x2d>,
+					       <&dmac4 0x1d71 0x2c>, <&dmac4 0x1d72 0x2d>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu21: ssiu-9 {
+					dmas = <&dmac0 0x1d73 0x2e>, <&dmac0 0x1d74 0x2f>,
+					       <&dmac1 0x1d73 0x2e>, <&dmac1 0x1d74 0x2f>,
+					       <&dmac2 0x1d73 0x2e>, <&dmac2 0x1d74 0x2f>,
+					       <&dmac3 0x1d73 0x2e>, <&dmac3 0x1d74 0x2f>,
+					       <&dmac4 0x1d73 0x2e>, <&dmac4 0x1d74 0x2f>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu22: ssiu-10 {
+					dmas = <&dmac0 0x1d75 0x30>, <&dmac0 0x1d76 0x31>,
+					       <&dmac1 0x1d75 0x30>, <&dmac1 0x1d76 0x31>,
+					       <&dmac2 0x1d75 0x30>, <&dmac2 0x1d76 0x31>,
+					       <&dmac3 0x1d75 0x30>, <&dmac3 0x1d76 0x31>,
+					       <&dmac4 0x1d75 0x30>, <&dmac4 0x1d76 0x31>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu23: ssiu-11 {
+					dmas = <&dmac0 0x1d77 0x32>, <&dmac0 0x1d78 0x33>,
+					       <&dmac1 0x1d77 0x32>, <&dmac1 0x1d78 0x33>,
+					       <&dmac2 0x1d77 0x32>, <&dmac2 0x1d78 0x33>,
+					       <&dmac3 0x1d77 0x32>, <&dmac3 0x1d78 0x33>,
+					       <&dmac4 0x1d77 0x32>, <&dmac4 0x1d78 0x33>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu30: ssiu-12 {
+					dmas = <&dmac0 0x1d79 0x34>, <&dmac0 0x1d7a 0x35>,
+					       <&dmac1 0x1d79 0x34>, <&dmac1 0x1d7a 0x35>,
+					       <&dmac2 0x1d79 0x34>, <&dmac2 0x1d7a 0x35>,
+					       <&dmac3 0x1d79 0x34>, <&dmac3 0x1d7a 0x35>,
+					       <&dmac4 0x1d79 0x34>, <&dmac4 0x1d7a 0x35>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu31: ssiu-13 {
+					dmas = <&dmac0 0x1d7b 0x36>, <&dmac0 0x1d7c 0x37>,
+					       <&dmac1 0x1d7b 0x36>, <&dmac1 0x1d7c 0x37>,
+					       <&dmac2 0x1d7b 0x36>, <&dmac2 0x1d7c 0x37>,
+					       <&dmac3 0x1d7b 0x36>, <&dmac3 0x1d7c 0x37>,
+					       <&dmac4 0x1d7b 0x36>, <&dmac4 0x1d7c 0x37>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu32: ssiu-14 {
+					dmas = <&dmac0 0x1d7d 0x38>, <&dmac0 0x1d7e 0x39>,
+					       <&dmac1 0x1d7d 0x38>, <&dmac1 0x1d7e 0x39>,
+					       <&dmac2 0x1d7d 0x38>, <&dmac2 0x1d7e 0x39>,
+					       <&dmac3 0x1d7d 0x38>, <&dmac3 0x1d7e 0x39>,
+					       <&dmac4 0x1d7d 0x38>, <&dmac4 0x1d7e 0x39>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu33: ssiu-15 {
+					dmas = <&dmac0 0x1d7f 0x3a>, <&dmac0 0x1d80 0x3b>,
+					       <&dmac1 0x1d7f 0x3a>, <&dmac1 0x1d80 0x3b>,
+					       <&dmac2 0x1d7f 0x3a>, <&dmac2 0x1d80 0x3b>,
+					       <&dmac3 0x1d7f 0x3a>, <&dmac3 0x1d80 0x3b>,
+					       <&dmac4 0x1d7f 0x3a>, <&dmac4 0x1d80 0x3b>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu40: ssiu-16 {
+					dmas = <&dmac0 0x1d81 0x3c>, <&dmac0 0x1d82 0x3d>,
+					       <&dmac1 0x1d81 0x3c>, <&dmac1 0x1d82 0x3d>,
+					       <&dmac2 0x1d81 0x3c>, <&dmac2 0x1d82 0x3d>,
+					       <&dmac3 0x1d81 0x3c>, <&dmac3 0x1d82 0x3d>,
+					       <&dmac4 0x1d81 0x3c>, <&dmac4 0x1d82 0x3d>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu41: ssiu-17 {
+					dmas = <&dmac0 0x1d83 0x3e>, <&dmac0 0x1d84 0x3f>,
+					       <&dmac1 0x1d83 0x3e>, <&dmac1 0x1d84 0x3f>,
+					       <&dmac2 0x1d83 0x3e>, <&dmac2 0x1d84 0x3f>,
+					       <&dmac3 0x1d83 0x3e>, <&dmac3 0x1d84 0x3f>,
+					       <&dmac4 0x1d83 0x3e>, <&dmac4 0x1d84 0x3f>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu42: ssiu-18 {
+					dmas = <&dmac0 0x1d85 0x40>, <&dmac0 0x1d86 0x41>,
+					       <&dmac1 0x1d85 0x40>, <&dmac1 0x1d86 0x41>,
+					       <&dmac2 0x1d85 0x40>, <&dmac2 0x1d86 0x41>,
+					       <&dmac3 0x1d85 0x40>, <&dmac3 0x1d86 0x41>,
+					       <&dmac4 0x1d85 0x40>, <&dmac4 0x1d86 0x41>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu43: ssiu-19 {
+					dmas = <&dmac0 0x1d87 0x42>, <&dmac0 0x1d88 0x43>,
+					       <&dmac1 0x1d87 0x42>, <&dmac1 0x1d88 0x43>,
+					       <&dmac2 0x1d87 0x42>, <&dmac2 0x1d88 0x43>,
+					       <&dmac3 0x1d87 0x42>, <&dmac3 0x1d88 0x43>,
+					       <&dmac4 0x1d87 0x42>, <&dmac4 0x1d88 0x43>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu50: ssiu-20 {
+					dmas = <&dmac0 0x1d89 0x44>, <&dmac0 0x1d8a 0x45>,
+					       <&dmac1 0x1d89 0x44>, <&dmac1 0x1d8a 0x45>,
+					       <&dmac2 0x1d89 0x44>, <&dmac2 0x1d8a 0x45>,
+					       <&dmac3 0x1d89 0x44>, <&dmac3 0x1d8a 0x45>,
+					       <&dmac4 0x1d89 0x44>, <&dmac4 0x1d8a 0x45>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu60: ssiu-21 {
+					dmas = <&dmac0 0x1d8b 0x46>, <&dmac0 0x1d8c 0x47>,
+					       <&dmac1 0x1d8b 0x46>, <&dmac1 0x1d8c 0x47>,
+					       <&dmac2 0x1d8b 0x46>, <&dmac2 0x1d8c 0x47>,
+					       <&dmac3 0x1d8b 0x46>, <&dmac3 0x1d8c 0x47>,
+					       <&dmac4 0x1d8b 0x46>, <&dmac4 0x1d8c 0x47>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu70: ssiu-22 {
+					dmas = <&dmac0 0x1d8d 0x48>, <&dmac0 0x1d8e 0x49>,
+					       <&dmac1 0x1d8d 0x48>, <&dmac1 0x1d8e 0x49>,
+					       <&dmac2 0x1d8d 0x48>, <&dmac2 0x1d8e 0x49>,
+					       <&dmac3 0x1d8d 0x48>, <&dmac3 0x1d8e 0x49>,
+					       <&dmac4 0x1d8d 0x48>, <&dmac4 0x1d8e 0x49>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu80: ssiu-23 {
+					dmas = <&dmac0 0x1d8f 0x4a>, <&dmac0 0x1d90 0x4b>,
+					       <&dmac1 0x1d8f 0x4a>, <&dmac1 0x1d90 0x4b>,
+					       <&dmac2 0x1d8f 0x4a>, <&dmac2 0x1d90 0x4b>,
+					       <&dmac3 0x1d8f 0x4a>, <&dmac3 0x1d90 0x4b>,
+					       <&dmac4 0x1d8f 0x4a>, <&dmac4 0x1d90 0x4b>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu90: ssiu-24 {
+					dmas = <&dmac0 0x1d91 0x4c>, <&dmac0 0x1d92 0x4d>,
+					       <&dmac1 0x1d91 0x4c>, <&dmac1 0x1d92 0x4d>,
+					       <&dmac2 0x1d91 0x4c>, <&dmac2 0x1d92 0x4d>,
+					       <&dmac3 0x1d91 0x4c>, <&dmac3 0x1d92 0x4d>,
+					       <&dmac4 0x1d91 0x4c>, <&dmac4 0x1d92 0x4d>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu91: ssiu-25 {
+					dmas = <&dmac0 0x1d93 0x4e>, <&dmac0 0x1d94 0x4f>,
+					       <&dmac1 0x1d93 0x4e>, <&dmac1 0x1d94 0x4f>,
+					       <&dmac2 0x1d93 0x4e>, <&dmac2 0x1d94 0x4f>,
+					       <&dmac3 0x1d93 0x4e>, <&dmac3 0x1d94 0x4f>,
+					       <&dmac4 0x1d93 0x4e>, <&dmac4 0x1d94 0x4f>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu92: ssiu-26 {
+					dmas = <&dmac0 0x1d95 0x50>, <&dmac0 0x1d96 0x51>,
+					       <&dmac1 0x1d95 0x50>, <&dmac1 0x1d96 0x51>,
+					       <&dmac2 0x1d95 0x50>, <&dmac2 0x1d96 0x51>,
+					       <&dmac3 0x1d95 0x50>, <&dmac3 0x1d96 0x51>,
+					       <&dmac4 0x1d95 0x50>, <&dmac4 0x1d96 0x51>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu93: ssiu-27 {
+					dmas = <&dmac0 0x1d97 0x52>, <&dmac0 0x1d98 0x53>,
+					       <&dmac1 0x1d97 0x52>, <&dmac1 0x1d98 0x53>,
+					       <&dmac2 0x1d97 0x52>, <&dmac2 0x1d98 0x53>,
+					       <&dmac3 0x1d97 0x52>, <&dmac3 0x1d98 0x53>,
+					       <&dmac4 0x1d97 0x52>, <&dmac4 0x1d98 0x53>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+			};
+		};
+
 		wdt1: watchdog@14400000 {
 			compatible = "renesas,r9a09g047-wdt", "renesas,r9a09g057-wdt";
 			reg = <0 0x14400000 0 0x400>;
-- 
2.25.1


