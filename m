Return-Path: <dmaengine+bounces-9850-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHtdKGY1zmk8mAYAu9opvQ
	(envelope-from <dmaengine+bounces-9850-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:22:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7AF386D1E
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1EFA311CC08
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 09:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84AC36F431;
	Thu,  2 Apr 2026 09:10:48 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EFD36F42C;
	Thu,  2 Apr 2026 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121048; cv=none; b=d6TXIHm2EfvPYOgHV1XJN9qSzgrB6tjqz+bVy/0Te0UpELK3Okc/QxLFeqKR79/es+hSSPa7wShobzy7f1D2SqX1CVUFg6ttYt2UfWbzy6BW09CEsTA43LoHnhmiXdBTQGCT7msxACCfVTP0osOClP17P3A1SVmZlWbeHe47cyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121048; c=relaxed/simple;
	bh=QW8cZbfDDiUr80rG6B5tOV1+EyT4O9IB3pA0VtBwJ2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PD38Uf2mBDCfisW6bBPUv3cD0dEC/KjVKmnY9h4KP7oFg4njUldeipLYWqjc3OwSBGYU7/96YCDVpuOlpaYUTgnfjZUNkZJhCR5Fxr1EM9dDjJd0bmrlVqigp1eOTN+oIR8KGpgioFm5APFXe+7/IeAyPi2z8R/KVDSO004PzDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: JOsPZ5AVSH6Bp/A0rTPYtg==
X-CSE-MsgGUID: OBsxnicMSCukZfqs3gLNEg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2026 18:10:45 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.136])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DBE9C40E1DDD;
	Thu,  2 Apr 2026 18:10:36 +0900 (JST)
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
Subject: [PATCH v2 24/24] arm64: dts: renesas: r9a09g047e57-smarc: add DA7212 audio codec support
Date: Thu,  2 Apr 2026 11:05:23 +0200
Message-ID: <20260402090524.9137-25-john.madieu.xa@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9850-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0E7AF386D1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RZ/G3E SMARC board has a DA7212 audio codec connected via I2C1 for
sound input/output using SSI3/SSI4 where:

 - The codec receives its master clock from the Versa3 clock
   generator present on the SoM
 - SSI4 shares clock pins with SSI3 to provide a separate data
   line for full-duplex audio capture.

Enable audio support on RZ/G3E SMARC2 EVK boards with a DA7212 audio codec.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v2: No changes

 .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index 9be57785d9d5..2f4795e5e82b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -32,6 +32,37 @@
 #include "rzg3e-smarc-som.dtsi"
 #include "renesas-smarc2.dtsi"
 
+/*
+ * SSI-DA7212
+ *
+ * These commands are required when Playback/Capture
+ *
+ *	amixer -q cset name='Aux Switch' on
+ *	amixer -q cset name='Mixin Left Aux Left Switch' on
+ *	amixer -q cset name='Mixin Right Aux Right Switch' on
+ *	amixer -q cset name='ADC Switch' on
+ *	amixer -q cset name='Mixout Right Mixin Right Switch' off
+ *	amixer -q cset name='Mixout Left Mixin Left Switch' off
+ *	amixer -q cset name='Headphone Volume' 70%
+ *	amixer -q cset name='Headphone Switch' on
+ *	amixer -q cset name='Mixout Left DAC Left Switch' on
+ *	amixer -q cset name='Mixout Right DAC Right Switch' on
+ *	amixer -q cset name='DAC Left Source MUX' 'DAI Input Left'
+ *	amixer -q cset name='DAC Right Source MUX' 'DAI Input Right'
+ *	amixer -q sset 'Mic 1 Amp Source MUX' 'MIC_P'
+ *	amixer -q sset 'Mic 2 Amp Source MUX' 'MIC_P'
+ *	amixer -q sset 'Mixin Left Mic 1' on
+ *	amixer -q sset 'Mixin Right Mic 2' on
+ *	amixer -q sset 'Mic 1' 90% on
+ *	amixer -q sset 'Mic 2' 90% on
+ *	amixer -q sset 'Lineout' 80% on
+ *	amixer -q set "Headphone" 100% on
+ *
+ * When Capture chained with DVC, use this command to amplify sound
+ *	amixer set 'DVC In',0 80%
+ * For playback, use: amixer set 'DVC Out',0 80%
+ */
+
 / {
 	model = "Renesas SMARC EVK version 2 based on r9a09g047e57";
 	compatible = "renesas,smarc2-evk", "renesas,rzg3e-smarcm",
@@ -55,6 +86,22 @@ vqmmc_sd1_pvdd: regulator-vqmmc-sd1-pvdd {
 		gpios-states = <0>;
 		states = <3300000 0>, <1800000 1>;
 	};
+
+	sound_card: sound {
+		compatible = "audio-graph-card";
+
+		label = "snd-rzg3e";
+
+		dais = <&rsnd_port0>;	/* DA7212 */
+	};
+};
+
+&audio_clkb {
+	clock-frequency = <11289600>;
+};
+
+&audio_clkc {
+	clock-frequency = <12288000>;
 };
 
 &canfd {
@@ -99,6 +146,37 @@ &i2c0 {
 	pinctrl-names = "default";
 };
 
+&i2c1 {
+	da7212: codec@1a {
+		compatible = "dlg,da7212";
+		#sound-dai-cells = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x1a>;
+
+		clocks = <&versa3 1>;
+		clock-names = "mclk";
+
+		dlg,micbias1-lvl = <2500>;
+		dlg,micbias2-lvl = <2500>;
+		dlg,dmic-data-sel = "lrise_rfall";
+		dlg,dmic-samplephase = "between_clkedge";
+		dlg,dmic-clkrate = <3000000>;
+
+		VDDA-supply = <&reg_1p8v>;
+		VDDSP-supply = <&reg_3p3v>;
+		VDDMIC-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_1p8v>;
+
+		port {
+			da7212_endpoint: endpoint {
+				remote-endpoint = <&rsnd_endpoint0>;
+				mclk-fs = <256>;
+			};
+		};
+	};
+};
+
 &keys {
 	pinctrl-0 = <&nmi_pins>;
 	pinctrl-names = "default";
@@ -280,6 +358,42 @@ &sdhi1 {
 	vqmmc-supply = <&vqmmc_sd1_pvdd>;
 };
 
+&snd_rzg3e {
+	pinctrl-0 = <&sound_clk_pins &sound_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	/* audio_clkout */
+	#clock-cells = <0>;
+	clock-frequency = <11289600>;
+
+	/* Multi DAI */
+	#sound-dai-cells = <1>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		rsnd_port0: port@0 {
+			reg = <0>;
+			rsnd_endpoint0: endpoint {
+				remote-endpoint = <&da7212_endpoint>;
+
+				dai-format = "i2s";
+				bitclock-master = <&rsnd_endpoint0>;
+				frame-master = <&rsnd_endpoint0>;
+
+				playback = <&ssi3>, <&src1>, <&dvc1>;
+				capture = <&ssi4>, <&src0>, <&dvc0>;
+			};
+		};
+	};
+};
+
+&ssi4 {
+	shared-pin;
+};
+
 &xhci {
 	pinctrl-0 = <&usb3_pins>;
 	pinctrl-names = "default";
-- 
2.25.1


