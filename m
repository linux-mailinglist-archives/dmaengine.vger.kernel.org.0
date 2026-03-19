Return-Path: <dmaengine+bounces-9530-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APsaDdghvGnQswIAu9opvQ
	(envelope-from <dmaengine+bounces-9530-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:18:32 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8D02CE9BA
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AEEFA30CDFF0
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 15:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783983E92A8;
	Thu, 19 Mar 2026 15:56:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075B93E3C42;
	Thu, 19 Mar 2026 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935763; cv=none; b=YvY7C/rACdpn6CBDPvxT+mDeT9v5PNXVbVtYRJsOvQRwQ6s9qx9sdNIWgsJqkg3LZbSuzKAusryGc+S6SidDWCmfE/TcdATWbvcT1Sgon2DEMHXOdjOaXUsvv8V55pORSW3Z7RfrDIfusyw7my/9eoX8t0g8khvqGgBcxuY9iiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935763; c=relaxed/simple;
	bh=xBi/6GdjjHb2f+q/zcIqO+EtIKlDvHhNI4h79qztEs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pipdAqaZVDj8d6c1Sh875UuCT3i0F3KdXmLtD4FAGgm7CBtW/JZWgzqEbzQFgO/k1BWvgu/V9tlZKsaRU0XQsYLdqYQXJcxAUGsZZ3u7Tkx/c5yiwT9Vb+M/rD04C1FOjozjxYMIwCK3W1lB3M9Tp/Kul1zFDcd5ROuKuX0vWVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: bPvZtcP1RB2LatR+u0I+NA==
X-CSE-MsgGUID: Os/YalWtRFWBrRxYQsVh9w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Mar 2026 00:56:00 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.35])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 85E05401B2FD;
	Fri, 20 Mar 2026 00:55:51 +0900 (JST)
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
Subject: [PATCH 08/22] ASoC: rsnd: Add reset controller support to rsnd_mod
Date: Thu, 19 Mar 2026 16:53:20 +0100
Message-ID: <20260319155334.51278-9-john.madieu.xa@bp.renesas.com>
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
	TAGGED_FROM(0.00)[bounces-9530-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_SPAM(0.00)[0.623];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 2C8D02CE9BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RZ/G3E SoC requires per-module reset control for the audio subsystem.
Add reset controller support to struct rsnd_mod and update rsnd_mod_init()
to accept and handle a reset_control parameter.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 sound/soc/renesas/rcar/adg.c  |  2 +-
 sound/soc/renesas/rcar/cmd.c  |  2 +-
 sound/soc/renesas/rcar/core.c | 14 +++++++++++++-
 sound/soc/renesas/rcar/ctu.c  |  2 +-
 sound/soc/renesas/rcar/dma.c  |  4 ++--
 sound/soc/renesas/rcar/dvc.c  |  2 +-
 sound/soc/renesas/rcar/mix.c  |  2 +-
 sound/soc/renesas/rcar/rsnd.h |  3 +++
 sound/soc/renesas/rcar/src.c  |  2 +-
 sound/soc/renesas/rcar/ssi.c  |  2 +-
 sound/soc/renesas/rcar/ssiu.c |  2 +-
 11 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/sound/soc/renesas/rcar/adg.c b/sound/soc/renesas/rcar/adg.c
index 8641b73d1f77..0105c60a144e 100644
--- a/sound/soc/renesas/rcar/adg.c
+++ b/sound/soc/renesas/rcar/adg.c
@@ -780,7 +780,7 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 		return -ENOMEM;
 
 	ret = rsnd_mod_init(priv, &adg->mod, &adg_ops,
-		      NULL, 0, 0);
+		      NULL, NULL, 0, 0);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/renesas/rcar/cmd.c b/sound/soc/renesas/rcar/cmd.c
index 8d9a1e345a22..13beef389797 100644
--- a/sound/soc/renesas/rcar/cmd.c
+++ b/sound/soc/renesas/rcar/cmd.c
@@ -171,7 +171,7 @@ int rsnd_cmd_probe(struct rsnd_priv *priv)
 
 	for_each_rsnd_cmd(cmd, priv, i) {
 		int ret = rsnd_mod_init(priv, rsnd_mod_get(cmd),
-					&rsnd_cmd_ops, NULL,
+					&rsnd_cmd_ops, NULL, NULL,
 					RSND_MOD_CMD, i);
 		if (ret)
 			return ret;
diff --git a/sound/soc/renesas/rcar/core.c b/sound/soc/renesas/rcar/core.c
index 69fb19964a71..6de576736507 100644
--- a/sound/soc/renesas/rcar/core.c
+++ b/sound/soc/renesas/rcar/core.c
@@ -90,6 +90,7 @@
  *
  */
 
+#include <linux/delay.h>
 #include <linux/pm_runtime.h>
 #include <linux/of_graph.h>
 #include "rsnd.h"
@@ -196,18 +197,29 @@ int rsnd_mod_init(struct rsnd_priv *priv,
 		  struct rsnd_mod *mod,
 		  struct rsnd_mod_ops *ops,
 		  struct clk *clk,
+		  struct reset_control *rstc,
 		  enum rsnd_mod_type type,
 		  int id)
 {
-	int ret = clk_prepare(clk);
+	int ret;
 
+	ret = clk_prepare_enable(clk);
 	if (ret)
 		return ret;
 
+	ret = reset_control_deassert(rstc);
+	if (ret) {
+		clk_disable_unprepare(clk);
+		return ret;
+	}
+
+	clk_disable(clk);
+
 	mod->id		= id;
 	mod->ops	= ops;
 	mod->type	= type;
 	mod->clk	= clk;
+	mod->rstc	= rstc;
 	mod->priv	= priv;
 
 	return 0;
diff --git a/sound/soc/renesas/rcar/ctu.c b/sound/soc/renesas/rcar/ctu.c
index bd4c61f9fb3c..81bba6a1af6e 100644
--- a/sound/soc/renesas/rcar/ctu.c
+++ b/sound/soc/renesas/rcar/ctu.c
@@ -360,7 +360,7 @@ int rsnd_ctu_probe(struct rsnd_priv *priv)
 		}
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(ctu), &rsnd_ctu_ops,
-				    clk, RSND_MOD_CTU, i);
+				    clk, NULL, RSND_MOD_CTU, i);
 		if (ret)
 			goto rsnd_ctu_probe_done;
 
diff --git a/sound/soc/renesas/rcar/dma.c b/sound/soc/renesas/rcar/dma.c
index 2035ce06fe4c..68c859897e68 100644
--- a/sound/soc/renesas/rcar/dma.c
+++ b/sound/soc/renesas/rcar/dma.c
@@ -803,7 +803,7 @@ static int rsnd_dma_alloc(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
 
 	*dma_mod = rsnd_mod_get(dma);
 
-	ret = rsnd_mod_init(priv, *dma_mod, ops, NULL,
+	ret = rsnd_mod_init(priv, *dma_mod, ops, NULL, NULL,
 			    type, dma_id);
 	if (ret < 0)
 		return ret;
@@ -879,5 +879,5 @@ int rsnd_dma_probe(struct rsnd_priv *priv)
 	priv->dma = dmac;
 
 	/* dummy mem mod for debug */
-	return rsnd_mod_init(NULL, &mem, &mem_ops, NULL, 0, 0);
+	return rsnd_mod_init(NULL, &mem, &mem_ops, NULL, NULL, 0, 0);
 }
diff --git a/sound/soc/renesas/rcar/dvc.c b/sound/soc/renesas/rcar/dvc.c
index 988cbddbc611..bf7146ceb5f6 100644
--- a/sound/soc/renesas/rcar/dvc.c
+++ b/sound/soc/renesas/rcar/dvc.c
@@ -364,7 +364,7 @@ int rsnd_dvc_probe(struct rsnd_priv *priv)
 		}
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(dvc), &rsnd_dvc_ops,
-				    clk, RSND_MOD_DVC, i);
+				    clk, NULL, RSND_MOD_DVC, i);
 		if (ret)
 			goto rsnd_dvc_probe_done;
 
diff --git a/sound/soc/renesas/rcar/mix.c b/sound/soc/renesas/rcar/mix.c
index aea74e703305..566e9b2a488c 100644
--- a/sound/soc/renesas/rcar/mix.c
+++ b/sound/soc/renesas/rcar/mix.c
@@ -328,7 +328,7 @@ int rsnd_mix_probe(struct rsnd_priv *priv)
 		}
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(mix), &rsnd_mix_ops,
-				    clk, RSND_MOD_MIX, i);
+				    clk, NULL, RSND_MOD_MIX, i);
 		if (ret)
 			goto rsnd_mix_probe_done;
 
diff --git a/sound/soc/renesas/rcar/rsnd.h b/sound/soc/renesas/rcar/rsnd.h
index 04c70690f7a2..cd7e7df62298 100644
--- a/sound/soc/renesas/rcar/rsnd.h
+++ b/sound/soc/renesas/rcar/rsnd.h
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/reset.h>
 #include <linux/sh_dma.h>
 #include <linux/workqueue.h>
 #include <sound/soc.h>
@@ -353,6 +354,7 @@ struct rsnd_mod {
 	struct rsnd_mod_ops *ops;
 	struct rsnd_priv *priv;
 	struct clk *clk;
+	struct reset_control *rstc;
 	u32 status;
 };
 /*
@@ -420,6 +422,7 @@ int rsnd_mod_init(struct rsnd_priv *priv,
 		  struct rsnd_mod *mod,
 		  struct rsnd_mod_ops *ops,
 		  struct clk *clk,
+		  struct reset_control *rstc,
 		  enum rsnd_mod_type type,
 		  int id);
 void rsnd_mod_quit(struct rsnd_mod *mod);
diff --git a/sound/soc/renesas/rcar/src.c b/sound/soc/renesas/rcar/src.c
index 6a3dbc84f474..8b58cc20e7a8 100644
--- a/sound/soc/renesas/rcar/src.c
+++ b/sound/soc/renesas/rcar/src.c
@@ -766,7 +766,7 @@ int rsnd_src_probe(struct rsnd_priv *priv)
 		}
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(src),
-				    &rsnd_src_ops, clk, RSND_MOD_SRC, i);
+				    &rsnd_src_ops, clk, NULL, RSND_MOD_SRC, i);
 		if (ret)
 			goto rsnd_src_probe_done;
 
diff --git a/sound/soc/renesas/rcar/ssi.c b/sound/soc/renesas/rcar/ssi.c
index 0420041e282c..c06cebb36170 100644
--- a/sound/soc/renesas/rcar/ssi.c
+++ b/sound/soc/renesas/rcar/ssi.c
@@ -1225,7 +1225,7 @@ int rsnd_ssi_probe(struct rsnd_priv *priv)
 			ops = &rsnd_ssi_dma_ops;
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(ssi), ops, clk,
-				    RSND_MOD_SSI, i);
+				    NULL, RSND_MOD_SSI, i);
 		if (ret)
 			goto rsnd_ssi_probe_done;
 
diff --git a/sound/soc/renesas/rcar/ssiu.c b/sound/soc/renesas/rcar/ssiu.c
index 244fb833292a..0cfa84fe5ea8 100644
--- a/sound/soc/renesas/rcar/ssiu.c
+++ b/sound/soc/renesas/rcar/ssiu.c
@@ -586,7 +586,7 @@ int rsnd_ssiu_probe(struct rsnd_priv *priv)
 		}
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(ssiu),
-				    ops, NULL, RSND_MOD_SSIU, i);
+				    ops, NULL, NULL, RSND_MOD_SSIU, i);
 		if (ret)
 			return ret;
 	}
-- 
2.25.1


