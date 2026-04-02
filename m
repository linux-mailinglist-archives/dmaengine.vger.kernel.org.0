Return-Path: <dmaengine+bounces-9846-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIpDEUo0zmk8mAYAu9opvQ
	(envelope-from <dmaengine+bounces-9846-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:18:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D79AB386B4B
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D241B30CAB79
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 09:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396A1371CED;
	Thu,  2 Apr 2026 09:10:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7768C3624D4;
	Thu,  2 Apr 2026 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121011; cv=none; b=XwClgrpzuejNMxcTtIY1UAOgtNHb0XEoGgFrinVldCyHlhjZZRnKwhDTjYchb3NYRHsjodUVD/VlZLmGD/azCdKI64ZDaDuWbwWR0u0CvuWnx4GqA1QBHAnr4TpCoemMD1no0eYfOyZKV0uh9wHYmS+yLw9FYR34GiO35qVKH7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121011; c=relaxed/simple;
	bh=IKqbW+eX+HXA5Z7kfQcw3ua/Fr6+fjr+TqVEeZe8vXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CctGvRRq4H4qgO/Av56DOSWUuvGotsOyLkAo0cNhXE8QvKDmXBmpxDkfqYWr0hceK7doxdIj/4CGLLJuAYLDNsu59OJKsfJsjlEVIJxvQYTUHZYCvSDa6LMTUzgcTMrgac92Eq3rA4DD97gNyQ9hI/v00MogUvZpzlF2QWUW5JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: e9mZFhknR2WZSvqa/FWTdQ==
X-CSE-MsgGUID: jY19ZEZGRGaDtySI4VTInA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2026 18:10:07 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.136])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 33DB2413EABB;
	Thu,  2 Apr 2026 18:09:58 +0900 (JST)
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
Subject: [PATCH v2 20/24] arm64: dts: renesas: r9a09g047: Add R-Car Sound support
Date: Thu,  2 Apr 2026 11:05:19 +0200
Message-ID: <20260402090524.9137-21-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com>
References: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9846-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D79AB386B4B
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
available controller.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v2:
 - Remove 2-cells specifier on audio DMA assignment
 - Do not update DMAC #dma-cells anymore 

 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 502 +++++++++++++++++++++
 1 file changed, 502 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index 1ff48c8f98e1..b1e567d71c26 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -918,6 +918,508 @@ rsci9: serial@12803000 {
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
+			compatible = "renesas,r9a09g047-sound";
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
+				      "audmapp", "adg";
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
+				      "audmapp";
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
+					dmas = <&dmac0 0x1db3>, <&dmac1 0x1db3>,
+					       <&dmac2 0x1db3>, <&dmac3 0x1db3>,
+					       <&dmac4 0x1db3>;
+					dma-names = "tx", "tx", "tx", "tx", "tx";
+				};
+				dvc1: dvc-1 {
+					dmas = <&dmac0 0x1db4>, <&dmac1 0x1db4>,
+					       <&dmac2 0x1db4>, <&dmac3 0x1db4>,
+					       <&dmac4 0x1db4>;
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
+					dmas = <&dmac0 0x1d9f>, <&dmac0 0x1da9>,
+					       <&dmac1 0x1d9f>, <&dmac1 0x1da9>,
+					       <&dmac2 0x1d9f>, <&dmac2 0x1da9>,
+					       <&dmac3 0x1d9f>, <&dmac3 0x1da9>,
+					       <&dmac4 0x1d9f>, <&dmac4 0x1da9>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src1: src-1 {
+					interrupts = <GIC_SPI 903 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da0>, <&dmac0 0x1daa>,
+					       <&dmac1 0x1da0>, <&dmac1 0x1daa>,
+					       <&dmac2 0x1da0>, <&dmac2 0x1daa>,
+					       <&dmac3 0x1da0>, <&dmac3 0x1daa>,
+					       <&dmac4 0x1da0>, <&dmac4 0x1daa>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src2: src-2 {
+					interrupts = <GIC_SPI 904 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da1>, <&dmac0 0x1dab>,
+					       <&dmac1 0x1da1>, <&dmac1 0x1dab>,
+					       <&dmac2 0x1da1>, <&dmac2 0x1dab>,
+					       <&dmac3 0x1da1>, <&dmac3 0x1dab>,
+					       <&dmac4 0x1da1>, <&dmac4 0x1dab>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src3: src-3 {
+					interrupts = <GIC_SPI 905 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da2>, <&dmac0 0x1dac>,
+					       <&dmac1 0x1da2>, <&dmac1 0x1dac>,
+					       <&dmac2 0x1da2>, <&dmac2 0x1dac>,
+					       <&dmac3 0x1da2>, <&dmac3 0x1dac>,
+					       <&dmac4 0x1da2>, <&dmac4 0x1dac>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src4: src-4 {
+					interrupts = <GIC_SPI 906 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da3>, <&dmac0 0x1dad>,
+					       <&dmac1 0x1da3>, <&dmac1 0x1dad>,
+					       <&dmac2 0x1da3>, <&dmac2 0x1dad>,
+					       <&dmac3 0x1da3>, <&dmac3 0x1dad>,
+					       <&dmac4 0x1da3>, <&dmac4 0x1dad>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src5: src-5 {
+					interrupts = <GIC_SPI 907 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da4>, <&dmac0 0x1dae>,
+					       <&dmac1 0x1da4>, <&dmac1 0x1dae>,
+					       <&dmac2 0x1da4>, <&dmac2 0x1dae>,
+					       <&dmac3 0x1da4>, <&dmac3 0x1dae>,
+					       <&dmac4 0x1da4>, <&dmac4 0x1dae>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src6: src-6 {
+					interrupts = <GIC_SPI 908 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da5>, <&dmac0 0x1daf>,
+					       <&dmac1 0x1da5>, <&dmac1 0x1daf>,
+					       <&dmac2 0x1da5>, <&dmac2 0x1daf>,
+					       <&dmac3 0x1da5>, <&dmac3 0x1daf>,
+					       <&dmac4 0x1da5>, <&dmac4 0x1daf>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src7: src-7 {
+					interrupts = <GIC_SPI 909 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da6>, <&dmac0 0x1db0>,
+					       <&dmac1 0x1da6>, <&dmac1 0x1db0>,
+					       <&dmac2 0x1da6>, <&dmac2 0x1db0>,
+					       <&dmac3 0x1da6>, <&dmac3 0x1db0>,
+					       <&dmac4 0x1da6>, <&dmac4 0x1db0>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src8: src-8 {
+					interrupts = <GIC_SPI 910 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da7>, <&dmac0 0x1db1>,
+					       <&dmac1 0x1da7>, <&dmac1 0x1db1>,
+					       <&dmac2 0x1da7>, <&dmac2 0x1db1>,
+					       <&dmac3 0x1da7>, <&dmac3 0x1db1>,
+					       <&dmac4 0x1da7>, <&dmac4 0x1db1>;
+					dma-names = "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx";
+				};
+				src9: src-9 {
+					interrupts = <GIC_SPI 911 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&dmac0 0x1da8>, <&dmac0 0x1db2>,
+					       <&dmac1 0x1da8>, <&dmac1 0x1db2>,
+					       <&dmac2 0x1da8>, <&dmac2 0x1db2>,
+					       <&dmac3 0x1da8>, <&dmac3 0x1db2>,
+					       <&dmac4 0x1da8>, <&dmac4 0x1db2>;
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
+					dmas = <&dmac0 0x1d61>, <&dmac0 0x1d62>,
+					       <&dmac1 0x1d61>, <&dmac1 0x1d62>,
+					       <&dmac2 0x1d61>, <&dmac2 0x1d62>,
+					       <&dmac3 0x1d61>, <&dmac3 0x1d62>,
+					       <&dmac4 0x1d61>, <&dmac4 0x1d62>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu01: ssiu-1 {
+					dmas = <&dmac0 0x1d63>, <&dmac0 0x1d64>,
+					       <&dmac1 0x1d63>, <&dmac1 0x1d64>,
+					       <&dmac2 0x1d63>, <&dmac2 0x1d64>,
+					       <&dmac3 0x1d63>, <&dmac3 0x1d64>,
+					       <&dmac4 0x1d63>, <&dmac4 0x1d64>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu02: ssiu-2 {
+					dmas = <&dmac0 0x1d65>, <&dmac0 0x1d66>,
+					       <&dmac1 0x1d65>, <&dmac1 0x1d66>,
+					       <&dmac2 0x1d65>, <&dmac2 0x1d66>,
+					       <&dmac3 0x1d65>, <&dmac3 0x1d66>,
+					       <&dmac4 0x1d65>, <&dmac4 0x1d66>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu03: ssiu-3 {
+					dmas = <&dmac0 0x1d67>, <&dmac0 0x1d68>,
+					       <&dmac1 0x1d67>, <&dmac1 0x1d68>,
+					       <&dmac2 0x1d67>, <&dmac2 0x1d68>,
+					       <&dmac3 0x1d67>, <&dmac3 0x1d68>,
+					       <&dmac4 0x1d67>, <&dmac4 0x1d68>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu10: ssiu-4 {
+					dmas = <&dmac0 0x1d69>, <&dmac0 0x1d6a>,
+					       <&dmac1 0x1d69>, <&dmac1 0x1d6a>,
+					       <&dmac2 0x1d69>, <&dmac2 0x1d6a>,
+					       <&dmac3 0x1d69>, <&dmac3 0x1d6a>,
+					       <&dmac4 0x1d69>, <&dmac4 0x1d6a>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu11: ssiu-5 {
+					dmas = <&dmac0 0x1d6b>, <&dmac0 0x1d6c>,
+					       <&dmac1 0x1d6b>, <&dmac1 0x1d6c>,
+					       <&dmac2 0x1d6b>, <&dmac2 0x1d6c>,
+					       <&dmac3 0x1d6b>, <&dmac3 0x1d6c>,
+					       <&dmac4 0x1d6b>, <&dmac4 0x1d6c>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu12: ssiu-6 {
+					dmas = <&dmac0 0x1d6d>, <&dmac0 0x1d6e>,
+					       <&dmac1 0x1d6d>, <&dmac1 0x1d6e>,
+					       <&dmac2 0x1d6d>, <&dmac2 0x1d6e>,
+					       <&dmac3 0x1d6d>, <&dmac3 0x1d6e>,
+					       <&dmac4 0x1d6d>, <&dmac4 0x1d6e>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu13: ssiu-7 {
+					dmas = <&dmac0 0x1d6f>, <&dmac0 0x1d70>,
+					       <&dmac1 0x1d6f>, <&dmac1 0x1d70>,
+					       <&dmac2 0x1d6f>, <&dmac2 0x1d70>,
+					       <&dmac3 0x1d6f>, <&dmac3 0x1d70>,
+					       <&dmac4 0x1d6f>, <&dmac4 0x1d70>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu20: ssiu-8 {
+					dmas = <&dmac0 0x1d71>, <&dmac0 0x1d72>,
+					       <&dmac1 0x1d71>, <&dmac1 0x1d72>,
+					       <&dmac2 0x1d71>, <&dmac2 0x1d72>,
+					       <&dmac3 0x1d71>, <&dmac3 0x1d72>,
+					       <&dmac4 0x1d71>, <&dmac4 0x1d72>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu21: ssiu-9 {
+					dmas = <&dmac0 0x1d73>, <&dmac0 0x1d74>,
+					       <&dmac1 0x1d73>, <&dmac1 0x1d74>,
+					       <&dmac2 0x1d73>, <&dmac2 0x1d74>,
+					       <&dmac3 0x1d73>, <&dmac3 0x1d74>,
+					       <&dmac4 0x1d73>, <&dmac4 0x1d74>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu22: ssiu-10 {
+					dmas = <&dmac0 0x1d75>, <&dmac0 0x1d76>,
+					       <&dmac1 0x1d75>, <&dmac1 0x1d76>,
+					       <&dmac2 0x1d75>, <&dmac2 0x1d76>,
+					       <&dmac3 0x1d75>, <&dmac3 0x1d76>,
+					       <&dmac4 0x1d75>, <&dmac4 0x1d76>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu23: ssiu-11 {
+					dmas = <&dmac0 0x1d77>, <&dmac0 0x1d78>,
+					       <&dmac1 0x1d77>, <&dmac1 0x1d78>,
+					       <&dmac2 0x1d77>, <&dmac2 0x1d78>,
+					       <&dmac3 0x1d77>, <&dmac3 0x1d78>,
+					       <&dmac4 0x1d77>, <&dmac4 0x1d78>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu30: ssiu-12 {
+					dmas = <&dmac0 0x1d79>, <&dmac0 0x1d7a>,
+					       <&dmac1 0x1d79>, <&dmac1 0x1d7a>,
+					       <&dmac2 0x1d79>, <&dmac2 0x1d7a>,
+					       <&dmac3 0x1d79>, <&dmac3 0x1d7a>,
+					       <&dmac4 0x1d79>, <&dmac4 0x1d7a>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu31: ssiu-13 {
+					dmas = <&dmac0 0x1d7b>, <&dmac0 0x1d7c>,
+					       <&dmac1 0x1d7b>, <&dmac1 0x1d7c>,
+					       <&dmac2 0x1d7b>, <&dmac2 0x1d7c>,
+					       <&dmac3 0x1d7b>, <&dmac3 0x1d7c>,
+					       <&dmac4 0x1d7b>, <&dmac4 0x1d7c>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu32: ssiu-14 {
+					dmas = <&dmac0 0x1d7d>, <&dmac0 0x1d7e>,
+					       <&dmac1 0x1d7d>, <&dmac1 0x1d7e>,
+					       <&dmac2 0x1d7d>, <&dmac2 0x1d7e>,
+					       <&dmac3 0x1d7d>, <&dmac3 0x1d7e>,
+					       <&dmac4 0x1d7d>, <&dmac4 0x1d7e>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu33: ssiu-15 {
+					dmas = <&dmac0 0x1d7f>, <&dmac0 0x1d80>,
+					       <&dmac1 0x1d7f>, <&dmac1 0x1d80>,
+					       <&dmac2 0x1d7f>, <&dmac2 0x1d80>,
+					       <&dmac3 0x1d7f>, <&dmac3 0x1d80>,
+					       <&dmac4 0x1d7f>, <&dmac4 0x1d80>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu40: ssiu-16 {
+					dmas = <&dmac0 0x1d81>, <&dmac0 0x1d82>,
+					       <&dmac1 0x1d81>, <&dmac1 0x1d82>,
+					       <&dmac2 0x1d81>, <&dmac2 0x1d82>,
+					       <&dmac3 0x1d81>, <&dmac3 0x1d82>,
+					       <&dmac4 0x1d81>, <&dmac4 0x1d82>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu41: ssiu-17 {
+					dmas = <&dmac0 0x1d83>, <&dmac0 0x1d84>,
+					       <&dmac1 0x1d83>, <&dmac1 0x1d84>,
+					       <&dmac2 0x1d83>, <&dmac2 0x1d84>,
+					       <&dmac3 0x1d83>, <&dmac3 0x1d84>,
+					       <&dmac4 0x1d83>, <&dmac4 0x1d84>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu42: ssiu-18 {
+					dmas = <&dmac0 0x1d85>, <&dmac0 0x1d86>,
+					       <&dmac1 0x1d85>, <&dmac1 0x1d86>,
+					       <&dmac2 0x1d85>, <&dmac2 0x1d86>,
+					       <&dmac3 0x1d85>, <&dmac3 0x1d86>,
+					       <&dmac4 0x1d85>, <&dmac4 0x1d86>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu43: ssiu-19 {
+					dmas = <&dmac0 0x1d87>, <&dmac0 0x1d88>,
+					       <&dmac1 0x1d87>, <&dmac1 0x1d88>,
+					       <&dmac2 0x1d87>, <&dmac2 0x1d88>,
+					       <&dmac3 0x1d87>, <&dmac3 0x1d88>,
+					       <&dmac4 0x1d87>, <&dmac4 0x1d88>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu50: ssiu-20 {
+					dmas = <&dmac0 0x1d89>, <&dmac0 0x1d8a>,
+					       <&dmac1 0x1d89>, <&dmac1 0x1d8a>,
+					       <&dmac2 0x1d89>, <&dmac2 0x1d8a>,
+					       <&dmac3 0x1d89>, <&dmac3 0x1d8a>,
+					       <&dmac4 0x1d89>, <&dmac4 0x1d8a>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu60: ssiu-21 {
+					dmas = <&dmac0 0x1d8b>, <&dmac0 0x1d8c>,
+					       <&dmac1 0x1d8b>, <&dmac1 0x1d8c>,
+					       <&dmac2 0x1d8b>, <&dmac2 0x1d8c>,
+					       <&dmac3 0x1d8b>, <&dmac3 0x1d8c>,
+					       <&dmac4 0x1d8b>, <&dmac4 0x1d8c>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu70: ssiu-22 {
+					dmas = <&dmac0 0x1d8d>, <&dmac0 0x1d8e>,
+					       <&dmac1 0x1d8d>, <&dmac1 0x1d8e>,
+					       <&dmac2 0x1d8d>, <&dmac2 0x1d8e>,
+					       <&dmac3 0x1d8d>, <&dmac3 0x1d8e>,
+					       <&dmac4 0x1d8d>, <&dmac4 0x1d8e>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu80: ssiu-23 {
+					dmas = <&dmac0 0x1d8f>, <&dmac0 0x1d90>,
+					       <&dmac1 0x1d8f>, <&dmac1 0x1d90>,
+					       <&dmac2 0x1d8f>, <&dmac2 0x1d90>,
+					       <&dmac3 0x1d8f>, <&dmac3 0x1d90>,
+					       <&dmac4 0x1d8f>, <&dmac4 0x1d90>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu90: ssiu-24 {
+					dmas = <&dmac0 0x1d91>, <&dmac0 0x1d92>,
+					<&dmac1 0x1d91>, <&dmac1 0x1d92>,
+					<&dmac2 0x1d91>, <&dmac2 0x1d92>,
+					<&dmac3 0x1d91>, <&dmac3 0x1d92>,
+					<&dmac4 0x1d91>, <&dmac4 0x1d92>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu91: ssiu-25 {
+					dmas = <&dmac0 0x1d93>, <&dmac0 0x1d94>,
+					       <&dmac1 0x1d93>, <&dmac1 0x1d94>,
+					       <&dmac2 0x1d93>, <&dmac2 0x1d94>,
+					       <&dmac3 0x1d93>, <&dmac3 0x1d94>,
+					       <&dmac4 0x1d93>, <&dmac4 0x1d94>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu92: ssiu-26 {
+					dmas = <&dmac0 0x1d95>, <&dmac0 0x1d96>,
+					       <&dmac1 0x1d95>, <&dmac1 0x1d96>,
+					       <&dmac2 0x1d95>, <&dmac2 0x1d96>,
+					       <&dmac3 0x1d95>, <&dmac3 0x1d96>,
+					       <&dmac4 0x1d95>, <&dmac4 0x1d96>;
+					dma-names = "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx";
+				};
+				ssiu93: ssiu-27 {
+					dmas = <&dmac0 0x1d97>, <&dmac0 0x1d98>,
+					       <&dmac1 0x1d97>, <&dmac1 0x1d98>,
+					       <&dmac2 0x1d97>, <&dmac2 0x1d98>,
+					       <&dmac3 0x1d97>, <&dmac3 0x1d98>,
+					       <&dmac4 0x1d97>, <&dmac4 0x1d98>;
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


