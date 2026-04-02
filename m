Return-Path: <dmaengine+bounces-9842-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAnVNZkzzmk8mAYAu9opvQ
	(envelope-from <dmaengine+bounces-9842-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:15:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B9E386A25
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22A3F3084741
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CF136D4F1;
	Thu,  2 Apr 2026 09:09:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB41368962;
	Thu,  2 Apr 2026 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120972; cv=none; b=urudQlts7whSviKqMpDBXBsqSKYXdzfZjD0WSUf312C8oIF3JVzcfxdBSRw3adpGoFxx5Xbkcl8oKD4hLLkMxoBA28i06Zukv6XSEW0AhKLQR1eMt2i1VxD732rdchrXmmtYPsXQe+vpiF0e7ugQ06klzz8osxyFshpeWOmPL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120972; c=relaxed/simple;
	bh=B5gfNRLRR4fsFVk5TfophHSDAeQm4qXUUgJAphh7Udc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhNu0PrfFh0lDh4wDw+IwqXfhD4LfxEodZqrJjDcqg/J1eJjFHw+eY04N9S3BM1sP0qy5izT3xgOD2owzNv4Bx8vLiVfnRCEzputXQyXKbZJ4c919oxCMGfiGenRUoD+uiBRlcoVaD1eUHI15PgxD13DKRFaxRHDpq+YJJafnAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: XYJiv6PpTcqv/Ua/rsmgqA==
X-CSE-MsgGUID: ABwzT1PcTD+PJxDF5x0Wqg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2026 18:09:29 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.136])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E89C6413EB4D;
	Thu,  2 Apr 2026 18:09:20 +0900 (JST)
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
Subject: [PATCH v2 16/24] ASoC: rsnd: Add rsnd_adg_mod_get() for PM support
Date: Thu,  2 Apr 2026 11:05:15 +0200
Message-ID: <20260402090524.9137-17-john.madieu.xa@bp.renesas.com>
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
	TAGGED_FROM(0.00)[bounces-9842-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 77B9E386A25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add rsnd_adg_mod_get() to retrieve the ADG module handle.

This is preparation for system suspend/resume support, where the PM
callbacks need to access the ADG module to manage its clock and reset
state. Other modules (SSI, SRC, CTU, MIX, DVC) already have their
getters exported.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v2: Moved export part into a new patch (the next one)

 sound/soc/renesas/rcar/adg.c  | 10 ++++++++++
 sound/soc/renesas/rcar/rsnd.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/renesas/rcar/adg.c b/sound/soc/renesas/rcar/adg.c
index 131a60689f6d..d73f29bc9de7 100644
--- a/sound/soc/renesas/rcar/adg.c
+++ b/sound/soc/renesas/rcar/adg.c
@@ -906,6 +906,16 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 	return 0;
 }
 
+struct rsnd_mod *rsnd_adg_mod_get(struct rsnd_priv *priv)
+{
+	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
+
+	if (!adg)
+		return NULL;
+
+	return rsnd_mod_get(adg);
+}
+
 void rsnd_adg_remove(struct rsnd_priv *priv)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
diff --git a/sound/soc/renesas/rcar/rsnd.h b/sound/soc/renesas/rcar/rsnd.h
index 8700b39b535e..3860e1c4943f 100644
--- a/sound/soc/renesas/rcar/rsnd.h
+++ b/sound/soc/renesas/rcar/rsnd.h
@@ -618,6 +618,7 @@ int rsnd_adg_set_cmd_timsel_gen2(struct rsnd_mod *cmd_mod,
 #define rsnd_adg_clk_disable(priv)	rsnd_adg_clk_control(priv, 0)
 int rsnd_adg_clk_control(struct rsnd_priv *priv, int enable);
 void rsnd_adg_clk_dbg_info(struct rsnd_priv *priv, struct seq_file *m);
+struct rsnd_mod *rsnd_adg_mod_get(struct rsnd_priv *priv);
 
 /*
  *	R-Car sound priv
-- 
2.25.1


