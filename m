Return-Path: <dmaengine+bounces-9524-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMuTCjwfvGnQswIAu9opvQ
	(envelope-from <dmaengine+bounces-9524-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:07:24 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5B02CE5DE
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8A16311035B
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 15:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1633E9F65;
	Thu, 19 Mar 2026 15:55:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4337F3E9F8B;
	Thu, 19 Mar 2026 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935708; cv=none; b=aL86/k9QLNIwRoIYXwV/nYHEAYuKc7JBbsrsh1bwFzr9iOL2iKFmFFS+kAc/H8QApjnkX6rjNkt99plUCmNiywPLHZSiBr916OoxrbJjupHnj4aIPyjq3flDCwU1eriGpSkEMo6xu+WAINNOl0tcoEq5rjZuaai6PwzJi37YSbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935708; c=relaxed/simple;
	bh=5AiOb3jETxyRJvZGUFJ/xnBLl99mPGjZTXFFvUFA3ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LimGDLYai2JTwURGejJ++dLjFwX7xr41POxJwRxSWsiBjOsuTZryYzVFtoHO3rE5Iyjik5HvFPWACbwXoWinFIddLBJcll+uGljnYSF1qI8duhYvnFoh23pqZafKmixNsXzR0QhH0pbpl8+/DXoR8sd3M5fezjqkMAgUuL7/eXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: eSkdCWfbRIeMYiQynzDSPw==
X-CSE-MsgGUID: CV76qGvRQTWOkZiEj7rQ+g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Mar 2026 00:55:05 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.35])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 45F7040189E4;
	Fri, 20 Mar 2026 00:54:55 +0900 (JST)
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
Subject: [PATCH 02/22] arm64: dts: renesas: rzv2h: Add audio clock inputs
Date: Thu, 19 Mar 2026 16:53:14 +0100
Message-ID: <20260319155334.51278-3-john.madieu.xa@bp.renesas.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9524-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	NEURAL_SPAM(0.00)[0.617];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8E5B02CE5DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Model external audio clock inputs as CPG input clocks for RZ/V2H family
SoCs (RZ/V2H, RZ/V2N, RZ/G3E), allowing the Audio Clock Generator (ADG)
to derive internal audio clocks from these external sources.

The clock frequencies are board-specific and must be overridden in the
board DTS files.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 27 ++++++++++++++++++++--
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 27 ++++++++++++++++++++--
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 27 ++++++++++++++++++++--
 3 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index cbb48ff5028f..2787d316ea04 100644
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
index 9192c5bf7e59..a16474184d92 100644
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


