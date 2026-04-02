Return-Path: <dmaengine+bounces-9849-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJKrEs81zmmAmAYAu9opvQ
	(envelope-from <dmaengine+bounces-9849-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:24:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E008386DC1
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14F0730C8C67
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13AB372681;
	Thu,  2 Apr 2026 09:10:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79F236F41C;
	Thu,  2 Apr 2026 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121038; cv=none; b=N0EAo88SawF0PttlOrBHT7hqjwRWafed/MM6aLGhpfIEi9pDNjvMYG4TMnIJ3fO0rJKSQJ2KhLfgdF6c1muO1wiw/q4pmObMtc5jzsoyfyKMEWcXk6jDjYSl+rtV3kSU/T7PSCbZZuwGah5ehXZLO2CSsH7igTLmk/KGI1clTlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121038; c=relaxed/simple;
	bh=odtl+jf2kYMFISoRKoWdgDUEZ70XVVGPlRghynRovno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ty+FMnHDxFBAFqAor1Y/R0foqbtBSp3JAOV5PPtiSEJJ1W4+XFIZzSzgv5XWXjq2GkUrnFBFzpGpYLbzoVTMswYoT6xq/jKHfdlEqhQs+C6XaT/XMEzyrnm/400Y+0Mh8uYeqfh5H66CqebpcnEOTNQ0FDjcHYUK060ev5E44K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: aW59KSgXSFK3DtSBXm3Pug==
X-CSE-MsgGUID: lyngML5OTcG4KAeGa37U1w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2026 18:10:36 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.136])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4052340E1DDD;
	Thu,  2 Apr 2026 18:10:26 +0900 (JST)
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
Subject: [PATCH v2 23/24] arm64: dts: renesas: rzg3e-smarc-som: add audio pinmux definitions
Date: Thu,  2 Apr 2026 11:05:22 +0200
Message-ID: <20260402090524.9137-24-john.madieu.xa@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9849-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5E008386DC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add pinmux definitions for SSI3/SSI4 audio interface on RZ/G3E SMARC SoM:

- sound_clk_pins: AUDIO_CLKB and AUDIO_CLKC clock outputs
- sound_pins: SSI3_SCK, SSI3_WS, SSI3_SDATA (playback) and
  SSI4_SDATA (capture)

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v2: No changes

 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
index 493f6783d583..f4532a06cc31 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -353,6 +353,18 @@ sd2-pwen {
 		};
 	};
 
+	sound_clk_pins: sound_clk {
+		pinmux = <RZG3E_PORT_PINMUX(4, 2, 8)>, /* AUDIO_CLKB */
+			 <RZG3E_PORT_PINMUX(4, 3, 8)>; /* AUDIO_CLKC */
+	};
+
+	sound_pins: sound {
+		pinmux = <RZG3E_PORT_PINMUX(0, 3, 9)>, /* SSI3_SCK */
+			 <RZG3E_PORT_PINMUX(0, 4, 9)>, /* SSI3_WS */
+			 <RZG3E_PORT_PINMUX(0, 2, 9)>, /* SSI3_SDATA */
+			 <RZG3E_PORT_PINMUX(0, 5, 9)>; /* SSI4_SDATA */
+	};
+
 	xspi_pins: xspi0 {
 		pinmux = <RZG3E_PORT_PINMUX(M, 0, 0)>, /* XSPI0_IO0 */
 			 <RZG3E_PORT_PINMUX(M, 1, 0)>, /* XSPI0_IO1 */
-- 
2.25.1


