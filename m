Return-Path: <dmaengine+bounces-9542-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OExYFIEfvGnQswIAu9opvQ
	(envelope-from <dmaengine+bounces-9542-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:08:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E5B2CE67C
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B8C6304CA6C
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 16:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1AF3F0764;
	Thu, 19 Mar 2026 15:57:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4823F075A;
	Thu, 19 Mar 2026 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935876; cv=none; b=itP57RlWHvUgnklJ2XbWUB/2razMQDU0cugCzIWux/iTgmcBqiNdFV5TDkHWtDWVmQnzfXmgwUlf6U8yPFi7aVqAVml4NfJkWbx5wAuoOfy3NVdTgyRIDDSvu1zHj36XQ3aM6FwQfJy+FS++ZS4/NMtGeoYjMP8eQRUByJjaWlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935876; c=relaxed/simple;
	bh=FDO0KhtbWTyzjQ7kQYEbbIB1sDBMg1RGeyaucjcHzHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TskdAYeLIeyAGnORdX1uIFz8l/v2hodGy69tieH/vZMDoKyuHStJTCOR8HS1O3UAv43tD2Lxh7eJQAvzM1dV1BPZfil3jJ+A+XTmGndn+k94Ia7T6f2Zfo+eAgKim6BlcrLxX8FgECrpb57e2GN6eGbS2Vb3IABIWKXAqgHeC6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 5JWdIweaSACC21HosvVOPA==
X-CSE-MsgGUID: ERo1TbVaR8qHLveBOXzg2g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Mar 2026 00:57:53 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.35])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1A093401BC72;
	Fri, 20 Mar 2026 00:57:44 +0900 (JST)
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
Subject: [PATCH 20/22] arm64: dts: renesas: rzg3e-smarc-som: Add I2C1 support
Date: Thu, 19 Mar 2026 16:53:32 +0100
Message-ID: <20260319155334.51278-21-john.madieu.xa@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9542-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_SPAM(0.00)[0.618];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,bp.renesas.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7E5B2CE67C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add and enable I2C1 controller support with pin configuration.
The I2C1 bus is routed to the carrier board and used for peripherals
such as the audio codec.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
index 2f1548d78c2c..6fc6d5283eae 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -32,6 +32,7 @@ / {
 	aliases {
 		ethernet0 = &eth0;
 		ethernet1 = &eth1;
+		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		mmc0 = &sdhi0;
 		mmc2 = &sdhi2;
@@ -112,6 +113,12 @@ &gpu {
 	mali-supply = <&reg_vdd0p8v_others>;
 };
 
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
 	pinctrl-names = "default";
@@ -246,6 +253,11 @@ ctrl {
 		};
 	};
 
+	i2c1_pins: i2c1 {
+		pinmux = <RZG3E_PORT_PINMUX(3, 2, 1)>, /* SCL1 */
+			 <RZG3E_PORT_PINMUX(3, 3, 1)>; /* SDA1 */
+	};
+
 	i2c2_pins: i2c {
 		pinmux = <RZG3E_PORT_PINMUX(3, 4, 1)>, /* SCL2 */
 			 <RZG3E_PORT_PINMUX(3, 5, 1)>; /* SDA2 */
-- 
2.25.1


