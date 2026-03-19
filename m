Return-Path: <dmaengine+bounces-9539-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C3wGnkivGnQswIAu9opvQ
	(envelope-from <dmaengine+bounces-9539-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:21:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D12CA2CEAA1
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6CDC3197662
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 15:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873033ECBF1;
	Thu, 19 Mar 2026 15:57:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1CE3DD50C;
	Thu, 19 Mar 2026 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935847; cv=none; b=HUq8LRjS6I9VUW9UFNwxu2pP8Or2mHU5/AYlHV94WFyoUUpfBST0kJ6rNI9qHv4t713J/JZ9gpUz2wevoyNOr4dB85WF9zLE7reM6ejfKg/JZJQyMPwKRfj1Eee1p18G5kxO5DDaPFgtVY7qU3CBmPt22s3LxQCKzKduDXtYLhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935847; c=relaxed/simple;
	bh=+zrwIyAAi1BvsO0DwGr5+Q2OiR2vGMzMUDIUztidatU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7/MDvCoX71NdZwU0azsNxddvKYuyOz0DMmE/j8WfLHGjWlAdrdthTFfRiONmVxo2QC0aB9Dbps0vtvGSNkKARMm6kTjmvnrmSd8K6ZF6DxcfIuyeaApcaXj8mI1ObTsSEx87HNd4pQwocHhkdQl7Kc6cB5VUdsUoL3JbOyzWQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 30WpKlxkTHexIAunFk5UOA==
X-CSE-MsgGUID: lMvSfJQwQRKVsTdYO2QxrA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Mar 2026 00:57:24 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.35])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A10EB401BC51;
	Fri, 20 Mar 2026 00:57:15 +0900 (JST)
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
Subject: [PATCH 17/22] ASoC: rsnd: Add system suspend/resume support
Date: Thu, 19 Mar 2026 16:53:29 +0100
Message-ID: <20260319155334.51278-18-john.madieu.xa@bp.renesas.com>
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
	TAGGED_FROM(0.00)[bounces-9539-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_SPAM(0.00)[0.606];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: D12CA2CEAA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On RZ/G3E and similar SoCs, the audio subsystem loses its state during
deep sleep, due to lacking of proper clock and reset management in the
PM path.

Implement suspend/resume callbacks that save and restore the hardware
state by managing clocks and reset controls in the correct order:
- Suspend follows reverse probe order
- Resume follows probe order

Note that module clocks (mod->clk) are left in "prepared but disabled"
state after rsnd_mod_init(), so suspend only needs to unprepare them
and resume only needs to prepare them.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 sound/soc/renesas/rcar/core.c | 108 +++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 2 deletions(-)

diff --git a/sound/soc/renesas/rcar/core.c b/sound/soc/renesas/rcar/core.c
index 6a25580b9c6a..eb504551e410 100644
--- a/sound/soc/renesas/rcar/core.c
+++ b/sound/soc/renesas/rcar/core.c
@@ -962,7 +962,8 @@ static int rsnd_soc_hw_rule_channels(struct snd_pcm_hw_params *params,
 static const struct snd_pcm_hardware rsnd_pcm_hardware = {
 	.info =		SNDRV_PCM_INFO_INTERLEAVED	|
 			SNDRV_PCM_INFO_MMAP		|
-			SNDRV_PCM_INFO_MMAP_VALID,
+			SNDRV_PCM_INFO_MMAP_VALID	|
+			SNDRV_PCM_INFO_RESUME,
 	.buffer_bytes_max	= 64 * 1024,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 8192,
@@ -2059,11 +2060,70 @@ static void rsnd_remove(struct platform_device *pdev)
 		remove_func[i](priv);
 }
 
+static void rsnd_suspend_mod(struct rsnd_mod *mod)
+{
+	if (!mod)
+		return;
+
+	clk_unprepare(mod->clk);
+	reset_control_assert(mod->rstc);
+}
+
+static void rsnd_resume_mod(struct rsnd_mod *mod)
+{
+	if (!mod)
+		return;
+
+	reset_control_deassert(mod->rstc);
+	clk_prepare(mod->clk);
+}
+
 static int rsnd_suspend(struct device *dev)
 {
 	struct rsnd_priv *priv = dev_get_drvdata(dev);
+	int i;
+
+	/*
+	 * Reverse order of probe:
+	 * ADG -> DVC -> MIX -> CTU -> SRC -> SSIU -> SSI -> DMA
+	 */
 
+	/* ADG */
+	/* ADG clock disabled via rsnd_adg_clk_disable() -> adg->adg */
 	rsnd_adg_clk_disable(priv);
+	rsnd_suspend_mod(rsnd_adg_mod_get(priv));
+
+	/* DVC */
+	for (i = priv->dvc_nr - 1; i >= 0; i--)
+		rsnd_suspend_mod(rsnd_dvc_mod_get(priv, i));
+
+	/* MIX */
+	for (i = priv->mix_nr - 1; i >= 0; i--)
+		rsnd_suspend_mod(rsnd_mix_mod_get(priv, i));
+
+	/* CTU */
+	for (i = priv->ctu_nr - 1; i >= 0; i--)
+		rsnd_suspend_mod(rsnd_ctu_mod_get(priv, i));
+
+	/* SRC */
+	for (i = priv->src_nr - 1; i >= 0; i--)
+		rsnd_suspend_mod(rsnd_src_mod_get(priv, i));
+
+	clk_disable_unprepare(priv->clk_scu_x2);
+	clk_disable_unprepare(priv->clk_scu);
+
+	/* SSIU */
+	for (i = priv->ssiu_nr - 1; i >= 0; i--)
+		rsnd_suspend_mod(rsnd_ssiu_mod_get(priv, i));
+
+	/* SSI */
+	for (i = priv->ssi_nr - 1; i >= 0; i--)
+		rsnd_suspend_mod(rsnd_ssi_mod_get(priv, i));
+
+	/* DMA */
+	clk_disable_unprepare(priv->clk_audmac_pp);
+	if (priv->rstc_audmac_pp)
+		reset_control_assert(priv->rstc_audmac_pp);
 
 	return 0;
 }
@@ -2071,8 +2131,52 @@ static int rsnd_suspend(struct device *dev)
 static int rsnd_resume(struct device *dev)
 {
 	struct rsnd_priv *priv = dev_get_drvdata(dev);
+	int i;
+
+	/*
+	 * Same order as probe:
+	 * DMA -> SSI -> SSIU -> SRC -> CTU -> MIX -> DVC -> ADG
+	 */
+
+	/* DMA */
+	if (priv->rstc_audmac_pp)
+		reset_control_deassert(priv->rstc_audmac_pp);
 
-	return rsnd_adg_clk_enable(priv);
+	clk_prepare_enable(priv->clk_audmac_pp);
+
+	/* SSI */
+	for (i = 0; i < priv->ssi_nr; i++)
+		rsnd_resume_mod(rsnd_ssi_mod_get(priv, i));
+
+	/* SSIU */
+	for (i = 0; i < priv->ssiu_nr; i++)
+		rsnd_resume_mod(rsnd_ssiu_mod_get(priv, i));
+
+	/* SRC */
+	clk_prepare_enable(priv->clk_scu);
+	clk_prepare_enable(priv->clk_scu_x2);
+
+	for (i = 0; i < priv->src_nr; i++)
+		rsnd_resume_mod(rsnd_src_mod_get(priv, i));
+
+	/* CTU */
+	for (i = 0; i < priv->ctu_nr; i++)
+		rsnd_resume_mod(rsnd_ctu_mod_get(priv, i));
+
+	/* MIX */
+	for (i = 0; i < priv->mix_nr; i++)
+		rsnd_resume_mod(rsnd_mix_mod_get(priv, i));
+
+	/* DVC */
+	for (i = 0; i < priv->dvc_nr; i++)
+		rsnd_resume_mod(rsnd_dvc_mod_get(priv, i));
+
+	/* ADG */
+	rsnd_resume_mod(rsnd_adg_mod_get(priv));
+	/* ADG clock enabled via rsnd_adg_clk_enable() -> adg->adg */
+	rsnd_adg_clk_enable(priv);
+
+	return 0;
 }
 
 static const struct dev_pm_ops rsnd_pm_ops = {
-- 
2.25.1


