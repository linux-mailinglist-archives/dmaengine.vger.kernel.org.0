Return-Path: <dmaengine+bounces-9845-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HZ/LCQ0zmk8mAYAu9opvQ
	(envelope-from <dmaengine+bounces-9845-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:17:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C757386B05
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 227CA3116700
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 09:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C8E377009;
	Thu,  2 Apr 2026 09:10:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676F3372B3D;
	Thu,  2 Apr 2026 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121001; cv=none; b=Xh103Dom82DagS/0gOwJCrFBads9xY57bpBXWzc1hUloQaP8l3GXjrowfq5W1ds3vovGh7M6CufTSUePRESD36Rl5BmJUzKb2Iug4/9uYWIankkzA3TDfejK7LU+3G3/Mk7PXw+LbT6YBZYeevfo8tn4VH+JjpaOeMX7G/5WXdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121001; c=relaxed/simple;
	bh=y4EzCKKiopoHg/znfWBec1qbsdzNAEoa9AkuC605oS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gz9i7APc6+wNpy0d4xIxezCN72mAZigSrdq1+lSodmrxEgRfdmjjc8mxbPuhP9cV0KajJgz/pvsnqLtrxwyKhWAJpG3X7Ww69ZaD5Z7QwbmEq8shpZYrTV91MiJbojG8bW+gK+UBfpsDc2E4YiAgoFGxQIKHNqCwtVw1ox7lUnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: uwkZORpySROGp9kttIWysw==
X-CSE-MsgGUID: FsH2pJENQ7KkPHhO48pRIQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2026 18:09:58 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.136])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9A27C413EABB;
	Thu,  2 Apr 2026 18:09:49 +0900 (JST)
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
Subject: [PATCH v2 19/24] arm64: dts: renesas: rzv2h: Add audio clock inputs
Date: Thu,  2 Apr 2026 11:05:18 +0200
Message-ID: <20260402090524.9137-20-john.madieu.xa@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9845-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4C757386B05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Model external audio clock inputs as CPG input clocks for RZ/V2H family
SoCs (RZ/V2H, RZ/V2N, RZ/G3E), allowing the Audio Clock Generator (ADG)
to derive internal audio clocks from these external sources.

The clock frequencies are board-specific and must be overridden in the
board DTS files.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v2: No changes

 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 27 ++++++++++++++++++++--
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 27 ++++++++++++++++++++--
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 27 ++++++++++++++++++++--
 3 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index 95a4e30a064d..1ff48c8f98e1 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -14,6 +14,27 @@ / {
 	#size-cells = <2>;
 	interrupt-parent = <&gic>;
 
+	audio_clka: audio-clka {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	audio_clkb: audio-clkb {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	audio_clkc: audio-clkc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
 	audio_extal_clk: audio-clk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -270,8 +291,10 @@ pinctrl: pinctrl@10410000 {
 		cpg: clock-controller@10420000 {
 			compatible = "renesas,r9a09g047-cpg";
 			reg = <0 0x10420000 0 0x10000>;
-			clocks = <&audio_extal_clk>, <&rtxin_clk>, <&qextal_clk>;
-			clock-names = "audio_extal", "rtxin", "qextal";
+			clocks = <&audio_extal_clk>, <&rtxin_clk>, <&qextal_clk>,
+				 <&audio_clka>, <&audio_clkb>, <&audio_clkc>;
+			clock-names = "audio_extal", "rtxin", "qextal",
+				      "audio_clka", "audio_clkb", "audio_clkc";
 			#clock-cells = <2>;
 			#reset-cells = <1>;
 			#power-domain-cells = <0>;
diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
index 40525470194e..d2ac78006f15 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -32,6 +32,27 @@ / {
 	#size-cells = <2>;
 	interrupt-parent = <&gic>;
 
+	audio_clka: audio-clka {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	audio_clkb: audio-clkb {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	audio_clkc: audio-clkc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
 	audio_extal_clk: audio-clk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -293,8 +314,10 @@ pinctrl: pinctrl@10410000 {
 		cpg: clock-controller@10420000 {
 			compatible = "renesas,r9a09g056-cpg";
 			reg = <0 0x10420000 0 0x10000>;
-			clocks = <&audio_extal_clk>, <&rtxin_clk>, <&qextal_clk>;
-			clock-names = "audio_extal", "rtxin", "qextal";
+			clocks = <&audio_extal_clk>, <&rtxin_clk>, <&qextal_clk>,
+				 <&audio_clka>, <&audio_clkb>, <&audio_clkc>;
+			clock-names = "audio_extal", "rtxin", "qextal",
+				      "audio_clka", "audio_clkb", "audio_clkc";
 			#clock-cells = <2>;
 			#reset-cells = <1>;
 			#power-domain-cells = <0>;
diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index 9581af58024e..e15b47dc93d4 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -14,6 +14,27 @@ / {
 	#size-cells = <2>;
 	interrupt-parent = <&gic>;
 
+	audio_clka: audio-clka {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	audio_clkb: audio-clkb {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	audio_clkc: audio-clkc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
 	audio_extal_clk: audio-clk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -275,8 +296,10 @@ pinctrl: pinctrl@10410000 {
 		cpg: clock-controller@10420000 {
 			compatible = "renesas,r9a09g057-cpg";
 			reg = <0 0x10420000 0 0x10000>;
-			clocks = <&audio_extal_clk>, <&rtxin_clk>, <&qextal_clk>;
-			clock-names = "audio_extal", "rtxin", "qextal";
+			clocks = <&audio_extal_clk>, <&rtxin_clk>, <&qextal_clk>,
+				 <&audio_clka>, <&audio_clkb>, <&audio_clkc>;
+			clock-names = "audio_extal", "rtxin", "qextal",
+				      "audio_clka", "audio_clkb", "audio_clkc";
 			#clock-cells = <2>;
 			#reset-cells = <1>;
 			#power-domain-cells = <0>;
-- 
2.25.1


