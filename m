Return-Path: <dmaengine+bounces-9537-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPMiIwwgvGnQswIAu9opvQ
	(envelope-from <dmaengine+bounces-9537-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:10:52 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 236D12CE773
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50069318D0F9
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8343EF0A6;
	Thu, 19 Mar 2026 15:57:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AB83DD50C;
	Thu, 19 Mar 2026 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935828; cv=none; b=NMKSwSSfI0ulccgwGJG4Rye0pQNt5ec0nQTpSMFlpnIH3CI1wx/PAVhhIqbingWQJjFzZzSBlHubcSdOO+Mhl8Zz/Gp/utsvLmgsdHKcYKFkyqbkLfthum9Or8KsqJ3BWGmeHBEVU0dnuxCQtHs/2WLREOQ9K09TkUMEOCroNI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935828; c=relaxed/simple;
	bh=BiFjNbYTzxnk6ALKdyDPQZUoxOq+1KLiy6vWkM//XsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtfxRMWw6CrRSJFTGkfAI1rqV25SDcogvOpRquLSg2nS5aw+egpHynHfbvV7qQ+oqYeSF369ARttM/9Qv8ZhpL2A4Pvdu/gyjxMnDf1w5HiQSCOANg3r8rIBSgtwxrrv0qk7jQjOZ4OrZazF7ZXzh/InyG3FyJ22hwwOGLkXSvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: hxGmEF+LTbGWgg0WNz9hbw==
X-CSE-MsgGUID: TPrQGtIwSSqzP0avKxzA9w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Mar 2026 00:57:05 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.35])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C88B4401B647;
	Fri, 20 Mar 2026 00:56:56 +0900 (JST)
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
Subject: [PATCH 15/22] ASoC: rsnd: src: Add SRC reset and clock support for RZ/G3E
Date: Thu, 19 Mar 2026 16:53:27 +0100
Message-ID: <20260319155334.51278-16-john.madieu.xa@bp.renesas.com>
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
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9537-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_SPAM(0.00)[0.605];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 236D12CE773
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RZ/G3E SoC requires explicit SCU (Sampling Rate Converter Unit)
reset and clock management unlike previous R-Car generations:

- scu_clk: SCU module clock
- scu_clkx2: SCU double-rate clock
- scu_supply_clk: SCU supply clock

Without these clocks enabled, the SRC module cannot operate on RZ/G3E.
Add support for the shared SCU reset controller used by the SRC modules
on the Renesas RZ/G3E SoC. All SRC instances are gated by the same "scu"
reset line.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 sound/soc/renesas/rcar/rsnd.h |  7 ++++++
 sound/soc/renesas/rcar/src.c  | 45 +++++++++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/sound/soc/renesas/rcar/rsnd.h b/sound/soc/renesas/rcar/rsnd.h
index 6bde304f93a8..a803c0f03665 100644
--- a/sound/soc/renesas/rcar/rsnd.h
+++ b/sound/soc/renesas/rcar/rsnd.h
@@ -642,6 +642,13 @@ struct rsnd_priv {
 	struct clk *clk_audmac_pp;
 	struct reset_control *rstc_audmac_pp;
 
+	/*
+	 * Below values will be filled in rsnd_src_probe()
+	 */
+	struct clk *clk_scu;
+	struct clk *clk_scu_x2;
+	struct clk *clk_scu_supply;
+
 	spinlock_t lock;
 	unsigned int ssiu_busif_count;
 	unsigned long flags;
diff --git a/sound/soc/renesas/rcar/src.c b/sound/soc/renesas/rcar/src.c
index 8b58cc20e7a8..e1f609589406 100644
--- a/sound/soc/renesas/rcar/src.c
+++ b/sound/soc/renesas/rcar/src.c
@@ -516,6 +516,7 @@ static int rsnd_src_init(struct rsnd_mod *mod,
 			 struct rsnd_priv *priv)
 {
 	struct rsnd_src *src = rsnd_mod_to_src(mod);
+	struct device *dev = rsnd_priv_to_dev(priv);
 	int ret;
 
 	/* reset sync convert_rate */
@@ -526,6 +527,12 @@ static int rsnd_src_init(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
+	ret = clk_prepare_enable(priv->clk_scu_supply);
+	if (ret) {
+		dev_err(dev, "Cannot enable scu_supply_clk\n");
+		return ret;
+	}
+
 	rsnd_src_activation(mod);
 
 	rsnd_src_init_convert_rate(io, mod);
@@ -549,6 +556,8 @@ static int rsnd_src_quit(struct rsnd_mod *mod,
 	src->sync.val		=
 	src->current_sync_rate	= 0;
 
+	clk_disable_unprepare(priv->clk_scu_supply);
+
 	return 0;
 }
 
@@ -711,8 +720,9 @@ struct rsnd_mod *rsnd_src_mod_get(struct rsnd_priv *priv, int id)
 
 int rsnd_src_probe(struct rsnd_priv *priv)
 {
-	struct device_node *node;
 	struct device *dev = rsnd_priv_to_dev(priv);
+	struct reset_control *rstc;
+	struct device_node *node;
 	struct rsnd_src *src;
 	struct clk *clk;
 	char name[RSND_SRC_NAME_SIZE];
@@ -737,6 +747,27 @@ int rsnd_src_probe(struct rsnd_priv *priv)
 	priv->src_nr	= nr;
 	priv->src	= src;
 
+	priv->clk_scu = devm_clk_get_optional_enabled(dev, "scu");
+	if (IS_ERR(priv->clk_scu)) {
+		ret = dev_err_probe(dev, PTR_ERR(priv->clk_scu),
+				    "failed to get scu clock\n");
+		goto rsnd_src_probe_done;
+	}
+
+	priv->clk_scu_x2 = devm_clk_get_optional_enabled(dev, "scu_x2");
+	if (IS_ERR(priv->clk_scu_x2)) {
+		ret = dev_err_probe(dev, PTR_ERR(priv->clk_scu_x2),
+				    "failed to get scu_x2 clock\n");
+		goto rsnd_src_probe_done;
+	}
+
+	priv->clk_scu_supply = devm_clk_get_optional(dev, "scu_supply");
+	if (IS_ERR(priv->clk_scu_supply)) {
+		ret = dev_err_probe(dev, PTR_ERR(priv->clk_scu_supply),
+				    "failed to get scu_supply clock\n");
+		goto rsnd_src_probe_done;
+	}
+
 	i = 0;
 	for_each_child_of_node_scoped(node, np) {
 		if (!of_device_is_available(np))
@@ -759,6 +790,16 @@ int rsnd_src_probe(struct rsnd_priv *priv)
 			goto rsnd_src_probe_done;
 		}
 
+		/*
+		 * RZ/G3E uses a shared SCU reset controller for all SRC modules.
+		 * R-Car platforms typically don't have SRC reset controls.
+		 */
+		rstc = devm_reset_control_get_optional_shared(dev, "scu");
+		if (IS_ERR(rstc)) {
+			ret = PTR_ERR(rstc);
+			goto rsnd_src_probe_done;
+		}
+
 		clk = devm_clk_get(dev, name);
 		if (IS_ERR(clk)) {
 			ret = PTR_ERR(clk);
@@ -766,7 +807,7 @@ int rsnd_src_probe(struct rsnd_priv *priv)
 		}
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(src),
-				    &rsnd_src_ops, clk, NULL, RSND_MOD_SRC, i);
+				    &rsnd_src_ops, clk, rstc, RSND_MOD_SRC, i);
 		if (ret)
 			goto rsnd_src_probe_done;
 
-- 
2.25.1


