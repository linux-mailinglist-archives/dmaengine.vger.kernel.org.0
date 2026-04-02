Return-Path: <dmaengine+bounces-9838-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EkZEe8zzmk8mAYAu9opvQ
	(envelope-from <dmaengine+bounces-9838-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:16:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C07386AB3
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9134030945E8
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 09:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B6236DA0B;
	Thu,  2 Apr 2026 09:08:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BD4363C47;
	Thu,  2 Apr 2026 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120935; cv=none; b=A5mToKRJo+n34n1MAHzMIyEXZRrZXXaPdcCYlukswqyYDtKDXi3wH7hfS4x8m8QK4KX0hu9TiOw2pq2kzalMYNjrOQ13nAT6Vb18D2q7IPzyIBn8dGIut/X86an2vbkyJasjWD4HpNhXBN6oPLdTQcP9dPDvTt6dMuBkg6gm2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120935; c=relaxed/simple;
	bh=v+gkshf1L7MN6s89cO8GojKeVmTxfjoB2Nrbfou6omE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNENuw76vdYDIYE+r7M6oc3jv3N7OmC2PjFqO02J3KGv9K/Cyy2YTjSJ+U2WrqgMh3fmRxJQ5Pg7dhh0BcW7Cdts/gSENkqrJsg737xA5U/A4jSpxcAyG6KdHr7Xspig48G1lWroK3mXz6bE7Ij0IQwciNMJYSjp20CTylBOnuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: DRq8Zg/0T9WCdsMSPxa0/w==
X-CSE-MsgGUID: Y1HhWbftSVGJOJl3/+u9Uw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2026 18:08:52 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.136])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CABC1413EA85;
	Thu,  2 Apr 2026 18:08:43 +0900 (JST)
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
Subject: [PATCH v2 12/24] ASoC: rsnd: Add SSI reset support for RZ/G3E platforms
Date: Thu,  2 Apr 2026 11:05:11 +0200
Message-ID: <20260402090524.9137-13-john.madieu.xa@bp.renesas.com>
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
	TAGGED_FROM(0.00)[bounces-9838-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 41C07386AB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add SSI reset support for the Renesas RZ/G3E SoC, which differs from earlier
generations in several ways:

 - The SSI block always operates in BUSIF mode; RZ/G3E does not implement
   the SSITDR/SSIRDR registers used by R-Car Gen2/Gen3/Gen4 for direct SSI
   DMA. Consequently, all audio data must pass through BUSIF.
 - Each SSI instance has its own reset line, exposed using per-SSI names
   such as "ssi0", "ssi1", etc., rather than a single shared reset.

To support these differences, rsnd_ssi_use_busif() always return 1 on
RZ/G3E, ensuring that the driver consistently selects the BUSIF DMA path.
While at it, update the reset acquisition logic to request the appropriate
per-SSI reset controller based on the SSI instance name.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v2:
 - Drop rsnd_dma_detach() from rsnd_ssi_common_remove() upon NULL pointer
   dereference on R-Car Gen3/Gen4 (reported by Geert)
 - Drop RSND_SSI_ALWAYS_BUSIF flag; use direct rsnd_is_rzg3e() check instead


 sound/soc/renesas/rcar/ssi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/renesas/rcar/ssi.c b/sound/soc/renesas/rcar/ssi.c
index c06cebb36170..c65435551283 100644
--- a/sound/soc/renesas/rcar/ssi.c
+++ b/sound/soc/renesas/rcar/ssi.c
@@ -1158,6 +1158,7 @@ int __rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod)
 
 int rsnd_ssi_probe(struct rsnd_priv *priv)
 {
+	struct reset_control *rstc;
 	struct device_node *node;
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct rsnd_mod_ops *ops;
@@ -1207,6 +1208,16 @@ int rsnd_ssi_probe(struct rsnd_priv *priv)
 			goto rsnd_ssi_probe_done;
 		}
 
+		/*
+		 * RZ/G3E uses per-SSI reset controllers.
+		 * R-Car platforms typically don't have SSI reset controls.
+		 */
+		rstc = devm_reset_control_get_optional(dev, name);
+		if (IS_ERR(rstc)) {
+			ret = PTR_ERR(rstc);
+			goto rsnd_ssi_probe_done;
+		}
+
 		if (of_property_read_bool(np, "shared-pin"))
 			rsnd_flags_set(ssi, RSND_SSI_CLK_PIN_SHARE);
 
@@ -1225,7 +1236,7 @@ int rsnd_ssi_probe(struct rsnd_priv *priv)
 			ops = &rsnd_ssi_dma_ops;
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(ssi), ops, clk,
-				    NULL, RSND_MOD_SSI, i);
+				    rstc, RSND_MOD_SSI, i);
 		if (ret)
 			goto rsnd_ssi_probe_done;
 
-- 
2.25.1


