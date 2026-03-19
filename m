Return-Path: <dmaengine+bounces-9523-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHZTChYdvGlEsQIAu9opvQ
	(envelope-from <dmaengine+bounces-9523-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 16:58:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE012CE235
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 16:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1943A3054FA0
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F803E95B0;
	Thu, 19 Mar 2026 15:55:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9C43E8C67;
	Thu, 19 Mar 2026 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935704; cv=none; b=B54brxNyRIuRipCm8dYxtYnddcDtCqLmvryiCif7qDmCpyLZzps5DFSpv7xxIRRy21xyZswrJWoTjYR77VDSrWDo6VDlf41GLltN4QXpCQvkGq2uSSNh4sKNqQ48Y5DbxI/GCKJp4/sblh9IT7ix8K3pZRRvlC2g1LVWl4VYDLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935704; c=relaxed/simple;
	bh=SV/OayDQfhRBvC34hoRJqvFiBa2hhApp5q8zHXZd8dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sULF9J9a8DzduvRMyWsWlc5FBfirBOwMU49mFxyumLZCqY2F2g5cSEiv7q1WsOtIii9hQ5E02OF58iSD7pHfLoum6K/ZQfF+FK1qrJOTlW7HDpFI3bGY/Nj8kPbEz4byoddICCJ50soid6Jw5YlaTQh8+1ytzgwEV1RQsE4ysm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: iOnTbv/sQICmFYQO4rOrwQ==
X-CSE-MsgGUID: 42cgRTraSzC981uwCYPIJA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Mar 2026 00:54:55 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.35])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8EA104018A06;
	Fri, 20 Mar 2026 00:54:46 +0900 (JST)
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
Subject: [PATCH 01/22] dt-bindings: clock: renesas: Add audio clock inputs for RZ/V2H family
Date: Thu, 19 Mar 2026 16:53:13 +0100
Message-ID: <20260319155334.51278-2-john.madieu.xa@bp.renesas.com>
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
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9523-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	NEURAL_SPAM(0.00)[0.639];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BEE012CE235
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RZ/V2H, RZ/V2N, and RZ/G3E support external audio clock inputs
(AUDIO_CLKA, AUDIO_CLKB, AUDIO_CLKC) that can be used by the Audio Clock
Generator (ADG) to derive internal audio clocks. These clocks are optional
and their frequencies are set by the board.

Update the bindings to allow these optional clocks for all RZ/V2H family
SoCs.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 .../devicetree/bindings/clock/renesas,rzv2h-cpg.yaml   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml
index f261445bf341..bed5643b39d3 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml
@@ -26,16 +26,26 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 3
+    maxItems: 6
     items:
       - description: AUDIO_EXTAL clock input
       - description: RTXIN clock input
       - description: QEXTAL clock input
+      - description: AUDIO_CLKA clock input
+      - description: AUDIO_CLKB clock input
+      - description: AUDIO_CLKC clock input
 
   clock-names:
+    minItems: 3
+    maxItems: 6
     items:
       - const: audio_extal
       - const: rtxin
       - const: qextal
+      - const: audio_clka
+      - const: audio_clkb
+      - const: audio_clkc
 
   '#clock-cells':
     description: |
-- 
2.25.1


