Return-Path: <dmaengine+bounces-9836-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAZDEMU0zmk8mAYAu9opvQ
	(envelope-from <dmaengine+bounces-9836-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:20:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE025386C0D
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8135318D3EB
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 09:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6119369236;
	Thu,  2 Apr 2026 09:08:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D12364EAE;
	Thu,  2 Apr 2026 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120916; cv=none; b=h/LwcWPq/mK4EjsmLuexiz8VtGfr+1+HpZUrsWF5Vf+8fA/9ksJ3XhkNNyu2oAMJUrTDy39gsSHgdTaMPpQQdQwgOBOD4NiZQvNyqRSkQPitZ5jddVkgOSOatOatpYKiINec9NPdLFfOrt1/BntM8fQSUmu0eoCHa/5iv/dMDTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120916; c=relaxed/simple;
	bh=fZ/qw7rwFs7YeRpQDSZdnvJ/B25t93s8KpamxZlE8QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KunB6XNJRcIjMB3FjGB65L7YUvKfD5iX10iAb1YRiGNzkje0PIEPZBfMm5WiAHIkVgpG+nMnT+WPP+0Acy2MZsd6LX2GNsKcyf0oiQiXqfOa9qhFh4q6jef1dsXUs+cGDDtIIangtKA2o3KfkmPSHJqHfa+RUDyHGdFwTocMo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: aFg3YBWkQpGLplxjIv20EA==
X-CSE-MsgGUID: 2MGOAGLtQPKj2JdKIEKpBQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2026 18:08:33 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.136])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B7F3E413EA85;
	Thu,  2 Apr 2026 18:08:25 +0900 (JST)
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
Subject: [PATCH v2 10/24] ASoC: rsnd: Add RZ/G3E DMA address calculation support
Date: Thu,  2 Apr 2026 11:05:09 +0200
Message-ID: <20260402090524.9137-11-john.madieu.xa@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9836-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AE025386C0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RZ/G3E has different DMA register base addresses and offset
calculations compared to R-Car platforms.

Add dedicated rsnd_rzg3e_dma_addr() function with dispatch from
rsnd_dma_addr(), following the existing per-generation pattern.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v2:
 - Split into separate patches: one for DMA address support, one for
   audmac-pp clock/reset management
 - Replace ternary macro wrappers with dedicated rsnd_rzg3e_dma_addr()
   function dispatched from rsnd_dma_addr(), following existing
   rsnd_gen4_dma_addr() pattern

 sound/soc/renesas/rcar/dma.c | 137 +++++++++++++++++++++++++++++------
 1 file changed, 113 insertions(+), 24 deletions(-)

diff --git a/sound/soc/renesas/rcar/dma.c b/sound/soc/renesas/rcar/dma.c
index 0afe4636b005..5b63206361ef 100644
--- a/sound/soc/renesas/rcar/dma.c
+++ b/sound/soc/renesas/rcar/dma.c
@@ -496,7 +496,35 @@ static struct rsnd_mod_ops rsnd_dmapp_ops = {
  *	SSIU: 0xec541000 / 0xec100000 / 0xec100000 / 0xec400000 / 0xec400000
  *	SCU : 0xec500000 / 0xec000000 / 0xec004000 / 0xec300000 / 0xec304000
  *	CMD : 0xec500000 /            / 0xec008000                0xec308000
+ *
+ *	ex) G3E case
+ *	      mod        / DMAC in    / DMAC out   / DMAC PP in / DMAC pp out
+ *	SSI : 0x13C31000 / 0x13C40000 / 0x13C40000
+ *	SSIU: 0x13C31000 / 0x13C40000 / 0x13C40000 / 0xEC400000 / 0xEC400000
+ *	SCU : 0x13C00000 / 0x13C10000 / 0x13C14000 / 0xEC300000 / 0xEC304000
+ *	CMD : 0x13C00000 /            / 0x13C18000                0xEC308000
  */
+
+/* RZ/G3E DMA address macros */
+#define RDMA_SSI_I_N_G3E(addr, i)	(addr ##_reg + 0x0000F000 + (0x1000 * i))
+#define RDMA_SSI_O_N_G3E(addr, i)	(addr ##_reg + 0x0000F000 + (0x1000 * i))
+
+#define RDMA_SSIU_I_N_G3E(addr, i, j)	(addr ##_reg + 0x0000F000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
+#define RDMA_SSIU_O_N_G3E(addr, i, j)	RDMA_SSIU_I_N_G3E(addr, i, j)
+
+#define RDMA_SSIU_I_P_G3E(addr, i, j)	(addr ##_reg + 0xD87CF000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
+#define RDMA_SSIU_O_P_G3E(addr, i, j)	RDMA_SSIU_I_P_G3E(addr, i, j)
+
+#define RDMA_SRC_I_N_G3E(addr, i)	(addr ##_reg + 0x00010000 + (0x400 * i))
+#define RDMA_SRC_O_N_G3E(addr, i)	(addr ##_reg + 0x00014000 + (0x400 * i))
+
+#define RDMA_SRC_I_P_G3E(addr, i)	(addr ##_reg + 0xD8700000 + (0x400 * i))
+#define RDMA_SRC_O_P_G3E(addr, i)	(addr ##_reg + 0xD8704000 + (0x400 * i))
+
+#define RDMA_CMD_O_N_G3E(addr, i)	(addr ##_reg + 0x00018000 + (0x400 * i))
+#define RDMA_CMD_O_P_G3E(addr, i)	(addr ##_reg + 0xD8708000 + (0x400 * i))
+
+/* R-Car DMA address macros */
 #define RDMA_SSI_I_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0x8)
 #define RDMA_SSI_O_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0xc)
 
@@ -515,15 +543,18 @@ static struct rsnd_mod_ops rsnd_dmapp_ops = {
 #define RDMA_CMD_O_N(addr, i)	(addr ##_reg - 0x004f8000 + (0x400 * i))
 #define RDMA_CMD_O_P(addr, i)	(addr ##_reg - 0x001f8000 + (0x400 * i))
 
+struct rsnd_dma_addr {
+	dma_addr_t out_addr;
+	dma_addr_t in_addr;
+};
+
 static dma_addr_t
-rsnd_gen2_dma_addr(struct rsnd_dai_stream *io,
-		   struct rsnd_mod *mod,
-		   int is_play, int is_from)
+rsnd_dma_addr_lookup(struct rsnd_dai_stream *io,
+		     struct rsnd_mod *mod,
+		     const struct rsnd_dma_addr tbl[3][2][3],
+		     int is_play, int is_from)
 {
-	struct rsnd_priv *priv = rsnd_io_to_priv(io);
-	struct device *dev = rsnd_priv_to_dev(priv);
-	phys_addr_t ssi_reg = rsnd_gen_get_phy_addr(priv, RSND_BASE_SSI);
-	phys_addr_t src_reg = rsnd_gen_get_phy_addr(priv, RSND_BASE_SCU);
+	struct device *dev = rsnd_priv_to_dev(rsnd_io_to_priv(io));
 	int is_ssi = !!(rsnd_io_to_mod_ssi(io) == mod) ||
 		     !!(rsnd_io_to_mod_ssiu(io) == mod);
 	int use_src = !!rsnd_io_to_mod_src(io);
@@ -531,11 +562,77 @@ rsnd_gen2_dma_addr(struct rsnd_dai_stream *io,
 		      !!rsnd_io_to_mod_mix(io) ||
 		      !!rsnd_io_to_mod_ctu(io);
 	int id = rsnd_mod_id(mod);
+
+	/* it shouldn't happen */
+	if (use_cmd && !use_src)
+		dev_err(dev, "DVC is selected without SRC\n");
+
+	/* use SSIU or SSI? */
+	if (is_ssi && rsnd_ssi_use_busif(io))
+		is_ssi++;
+
+	dev_dbg(dev, "dma%d addr : is_ssi=%d use_src=%d use_cmd=%d\n",
+		id, is_ssi, use_src, use_cmd);
+
+	return is_from ?
+		tbl[is_ssi][is_play][use_src + use_cmd].out_addr :
+		tbl[is_ssi][is_play][use_src + use_cmd].in_addr;
+}
+
+static dma_addr_t
+rsnd_rzg3e_dma_addr(struct rsnd_dai_stream *io,
+		    struct rsnd_mod *mod, int is_play, int is_from)
+{
+	struct rsnd_priv *priv = rsnd_io_to_priv(io);
+	phys_addr_t ssi_reg = rsnd_gen_get_phy_addr(priv, RSND_BASE_SSI);
+	phys_addr_t src_reg = rsnd_gen_get_phy_addr(priv, RSND_BASE_SCU);
+	int id    = rsnd_mod_id(mod);
 	int busif = rsnd_mod_id_sub(rsnd_io_to_mod_ssiu(io));
-	struct dma_addr {
-		dma_addr_t out_addr;
-		dma_addr_t in_addr;
-	} dma_addrs[3][2][3] = {
+	const struct rsnd_dma_addr tbl[3][2][3] = {
+		/* SRC */
+		/* Capture */
+		{{{ 0,				0, },
+		  { RDMA_SRC_O_N_G3E(src, id),	RDMA_SRC_I_P_G3E(src, id) },
+		  { RDMA_CMD_O_N_G3E(src, id),	RDMA_SRC_I_P_G3E(src, id) } },
+		 /* Playback */
+		 {{ 0,				0 },
+		  { RDMA_SRC_O_P_G3E(src, id),	RDMA_SRC_I_N_G3E(src, id) },
+		  { RDMA_CMD_O_P_G3E(src, id),	RDMA_SRC_I_N_G3E(src, id) } }
+		},
+		/* SSI */
+		/* Capture */
+		{{{ RDMA_SSI_O_N_G3E(ssi, id),			0 },
+		  { RDMA_SSIU_O_P_G3E(ssi, id, busif),		0 },
+		  { RDMA_SSIU_O_P_G3E(ssi, id, busif),		0 } },
+		 /* Playback */
+		 {{ 0,			RDMA_SSI_I_N_G3E(ssi, id) },
+		  { 0,			RDMA_SSIU_I_P_G3E(ssi, id, busif) },
+		  { 0,			RDMA_SSIU_I_P_G3E(ssi, id, busif) } }
+		},
+		/* SSIU */
+		/* Capture */
+		{{{ RDMA_SSIU_O_N_G3E(ssi, id, busif),		0 },
+		  { RDMA_SSIU_O_P_G3E(ssi, id, busif),		0 },
+		  { RDMA_SSIU_O_P_G3E(ssi, id, busif),		0 } },
+		 /* Playback */
+		 {{ 0,			RDMA_SSIU_I_N_G3E(ssi, id, busif) },
+		  { 0,			RDMA_SSIU_I_P_G3E(ssi, id, busif) },
+		  { 0,			RDMA_SSIU_I_P_G3E(ssi, id, busif) } } },
+	};
+
+	return rsnd_dma_addr_lookup(io, mod, tbl, is_play, is_from);
+}
+
+static dma_addr_t
+rsnd_gen2_dma_addr(struct rsnd_dai_stream *io,
+		   struct rsnd_mod *mod, int is_play, int is_from)
+{
+	struct rsnd_priv *priv = rsnd_io_to_priv(io);
+	phys_addr_t ssi_reg = rsnd_gen_get_phy_addr(priv, RSND_BASE_SSI);
+	phys_addr_t src_reg = rsnd_gen_get_phy_addr(priv, RSND_BASE_SCU);
+	int id    = rsnd_mod_id(mod);
+	int busif = rsnd_mod_id_sub(rsnd_io_to_mod_ssiu(io));
+	const struct rsnd_dma_addr tbl[3][2][3] = {
 		/* SRC */
 		/* Capture */
 		{{{ 0,				0 },
@@ -574,20 +671,10 @@ rsnd_gen2_dma_addr(struct rsnd_dai_stream *io,
 	 * out of calculation rule
 	 */
 	if ((id == 9) && (busif >= 4))
-		dev_err(dev, "This driver doesn't support SSI%d-%d, so far",
-			id, busif);
-
-	/* it shouldn't happen */
-	if (use_cmd && !use_src)
-		dev_err(dev, "DVC is selected without SRC\n");
-
-	/* use SSIU or SSI ? */
-	if (is_ssi && rsnd_ssi_use_busif(io))
-		is_ssi++;
+		dev_err(rsnd_priv_to_dev(priv),
+			"This driver doesn't support SSI%d-%d, so far", id, busif);
 
-	return (is_from) ?
-		dma_addrs[is_ssi][is_play][use_src + use_cmd].out_addr :
-		dma_addrs[is_ssi][is_play][use_src + use_cmd].in_addr;
+	return rsnd_dma_addr_lookup(io, mod, tbl, is_play, is_from);
 }
 
 /*
@@ -636,6 +723,8 @@ static dma_addr_t rsnd_dma_addr(struct rsnd_dai_stream *io,
 		return 0;
 	else if (rsnd_is_gen4(priv))
 		return rsnd_gen4_dma_addr(io, mod, is_play, is_from);
+	else if (rsnd_is_rzg3e(priv))
+		return rsnd_rzg3e_dma_addr(io, mod, is_play, is_from);
 	else
 		return rsnd_gen2_dma_addr(io, mod, is_play, is_from);
 }
-- 
2.25.1


