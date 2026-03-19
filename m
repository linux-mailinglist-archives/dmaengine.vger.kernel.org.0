Return-Path: <dmaengine+bounces-9532-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F5MF8sfvGnQswIAu9opvQ
	(envelope-from <dmaengine+bounces-9532-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:09:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C731B2CE700
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B1123155537
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4103EBF03;
	Thu, 19 Mar 2026 15:56:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B62C3EBF05;
	Thu, 19 Mar 2026 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935781; cv=none; b=DIZw1cb4ytuK5Odkh9mukeBzcmdZcLFcoPuIGDkfqYOwpr80aVuCg2wsoffsKtZREzq8Ew5/6DSGfoRCU+8AeVorlfY3Zd2lo74FMIi6UID5mi348UZP8J/dDzlHj8EEX+G8FrmuFVFo6nsBRQP9x4eI0kJyZi3tGEojuTaMwgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935781; c=relaxed/simple;
	bh=YaT1vm3ZGZQJADPdtO3h5jlr2l0NVkxzr+E0zGp10+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4Ayao29RqUo6/culptaG85wrkxmEelww2q6aPXKMMHvAsSXp7cO3oRScNtQ197b7cARAxfbkvLq6u/C3vFZKZ+WF7Ad31jAOsEe+F1StAGVSgoJ0j7IBR1Rz3j0JeVhvmzg9zkyY7FvCMfehLm7WME66qIW5iDcMCK27lssiPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 9f3zlsATTEme95ClzlDzQw==
X-CSE-MsgGUID: OoIBrNMxQAK+fz3fhjmBDA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Mar 2026 00:56:18 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.35])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F26DF401B307;
	Fri, 20 Mar 2026 00:56:09 +0900 (JST)
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
Subject: [PATCH 10/22] ASoC: rsnd: Add DMA support infrastructure for RZ/G3E
Date: Thu, 19 Mar 2026 16:53:22 +0100
Message-ID: <20260319155334.51278-11-john.madieu.xa@bp.renesas.com>
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
	TAGGED_FROM(0.00)[bounces-9532-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_SPAM(0.00)[0.657];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bp.renesas.com:mid]
X-Rspamd-Queue-Id: C731B2CE700
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RZ/G3E has different DMA register base addresses and offset calculations
compared to R-Car platforms, and requires additional audmac-pp clock and
reset lines for Audio DMAC operation.

Add RZ/G3E-specific DMA address macros and audmac-pp clock/reset support
using optional APIs to remain transparent to other platforms.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 sound/soc/renesas/rcar/core.c |   2 +-
 sound/soc/renesas/rcar/dma.c  | 171 +++++++++++++++++++++++++++-------
 sound/soc/renesas/rcar/rsnd.h |  12 +++
 3 files changed, 152 insertions(+), 33 deletions(-)

diff --git a/sound/soc/renesas/rcar/core.c b/sound/soc/renesas/rcar/core.c
index 86b2e9d06f9b..2f9c32c647a6 100644
--- a/sound/soc/renesas/rcar/core.c
+++ b/sound/soc/renesas/rcar/core.c
@@ -615,7 +615,7 @@ int rsnd_dai_connect(struct rsnd_mod *mod,
 	return 0;
 }
 
-static void rsnd_dai_disconnect(struct rsnd_mod *mod,
+void rsnd_dai_disconnect(struct rsnd_mod *mod,
 				struct rsnd_dai_stream *io,
 				enum rsnd_mod_type type)
 {
diff --git a/sound/soc/renesas/rcar/dma.c b/sound/soc/renesas/rcar/dma.c
index 68c859897e68..d3123ae3b402 100644
--- a/sound/soc/renesas/rcar/dma.c
+++ b/sound/soc/renesas/rcar/dma.c
@@ -496,24 +496,71 @@ static struct rsnd_mod_ops rsnd_dmapp_ops = {
  *	SSIU: 0xec541000 / 0xec100000 / 0xec100000 / 0xec400000 / 0xec400000
  *	SCU : 0xec500000 / 0xec000000 / 0xec004000 / 0xec300000 / 0xec304000
  *	CMD : 0xec500000 /            / 0xec008000                0xec308000
+ *
+ * 	ex) G3E case
+ *	      mod        / DMAC in    / DMAC out   / DMAC PP in / DMAC pp out
+ *	SSI : 0x13C31000 / 0x13C40000 / 0x13C40000
+ *	SSIU: 0x13C31000 / 0x13C40000 / 0x13C40000 / 0xEC400000 / 0xEC400000
+ *	SCU : 0x13C00000 / 0x13C10000 / 0x13C14000 / 0xEC300000 / 0xEC304000
+ *	CMD : 0x13C00000 /            / 0x13C18000                0xEC308000
  */
-#define RDMA_SSI_I_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0x8)
-#define RDMA_SSI_O_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0xc)
 
-#define RDMA_SSIU_I_N(addr, i, j) (addr ##_reg - 0x00441000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
-#define RDMA_SSIU_O_N(addr, i, j) RDMA_SSIU_I_N(addr, i, j)
+/* RZ/G3E DMA address macros */
+#define RDMA_SSI_I_N_G3E(addr, i)	(addr ##_reg + 0x0000F000 + (0x1000 * i))
+#define RDMA_SSI_O_N_G3E(addr, i)	(addr ##_reg + 0x0000F000 + (0x1000 * i))
+
+#define RDMA_SSIU_I_N_G3E(addr, i, j) (addr ##_reg + 0x0000F000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
+#define RDMA_SSIU_O_N_G3E(addr, i, j) RDMA_SSIU_I_N_G3E(addr, i, j)
+
+#define RDMA_SSIU_I_P_G3E(addr, i, j) (addr ##_reg + 0xD87CF000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
+#define RDMA_SSIU_O_P_G3E(addr, i, j) RDMA_SSIU_I_P_G3E(addr, i, j)
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
+#define RDMA_SSI_I_N_RCAR(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0x8)
+#define RDMA_SSI_O_N_RCAR(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0xc)
 
-#define RDMA_SSIU_I_P(addr, i, j) (addr ##_reg - 0x00141000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
-#define RDMA_SSIU_O_P(addr, i, j) RDMA_SSIU_I_P(addr, i, j)
+#define RDMA_SSIU_I_N_RCAR(addr, i, j) (addr ##_reg - 0x00441000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
+#define RDMA_SSIU_O_N_RCAR(addr, i, j) RDMA_SSIU_I_N_RCAR(addr, i, j)
 
-#define RDMA_SRC_I_N(addr, i)	(addr ##_reg - 0x00500000 + (0x400 * i))
-#define RDMA_SRC_O_N(addr, i)	(addr ##_reg - 0x004fc000 + (0x400 * i))
+#define RDMA_SSIU_I_P_RCAR(addr, i, j) (addr ##_reg - 0x00141000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
+#define RDMA_SSIU_O_P_RCAR(addr, i, j) RDMA_SSIU_I_N_RCAR(addr, i, j)
 
-#define RDMA_SRC_I_P(addr, i)	(addr ##_reg - 0x00200000 + (0x400 * i))
-#define RDMA_SRC_O_P(addr, i)	(addr ##_reg - 0x001fc000 + (0x400 * i))
+#define RDMA_SRC_I_N_RCAR(addr, i)	(addr ##_reg - 0x00500000 + (0x400 * i))
+#define RDMA_SRC_O_N_RCAR(addr, i)	(addr ##_reg - 0x004fc000 + (0x400 * i))
 
-#define RDMA_CMD_O_N(addr, i)	(addr ##_reg - 0x004f8000 + (0x400 * i))
-#define RDMA_CMD_O_P(addr, i)	(addr ##_reg - 0x001f8000 + (0x400 * i))
+#define RDMA_SRC_I_P_RCAR(addr, i)	(addr ##_reg - 0x00200000 + (0x400 * i))
+#define RDMA_SRC_O_P_RCAR(addr, i)	(addr ##_reg - 0x001fc000 + (0x400 * i))
+
+#define RDMA_CMD_O_N_RCAR(addr, i)	(addr ##_reg - 0x004f8000 + (0x400 * i))
+#define RDMA_CMD_O_P_RCAR(addr, i)	(addr ##_reg - 0x001f8000 + (0x400 * i))
+
+/* Platform-agnostic address macros */
+#define RDMA_SSI_I_N(p, addr, i)	rsnd_is_rzg3e(p) ? RDMA_SSI_I_N_G3E(addr, i) : RDMA_SSI_I_N_RCAR(addr, i)
+#define RDMA_SSI_O_N(p, addr, i)	rsnd_is_rzg3e(p) ? RDMA_SSI_O_N_G3E(addr, i) : RDMA_SSI_O_N_RCAR(addr, i)
+
+#define RDMA_SSIU_I_N(p, addr, i, j) rsnd_is_rzg3e(p) ? RDMA_SSIU_I_N_G3E(addr, i, j) : RDMA_SSIU_I_N_RCAR(addr, i, j)
+#define RDMA_SSIU_O_N(p, addr, i, j) rsnd_is_rzg3e(p) ? RDMA_SSIU_O_N_G3E(addr, i, j) : RDMA_SSIU_O_N_RCAR(addr, i, j)
+
+#define RDMA_SSIU_I_P(p, addr, i, j) rsnd_is_rzg3e(p) ? RDMA_SSIU_I_P_G3E(addr, i, j) : RDMA_SSIU_I_P_RCAR(addr, i, j)
+#define RDMA_SSIU_O_P(p, addr, i, j) rsnd_is_rzg3e(p) ? RDMA_SSIU_O_P_G3E(addr, i, j) : RDMA_SSIU_O_P_RCAR(addr, i, j)
+
+#define RDMA_SRC_I_N(p, addr, i)	rsnd_is_rzg3e(p) ? RDMA_SRC_I_N_G3E(addr, i) : RDMA_SRC_I_N_RCAR(addr, i)
+#define RDMA_SRC_O_N(p, addr, i)	rsnd_is_rzg3e(p) ? RDMA_SRC_O_N_G3E(addr, i) : RDMA_SRC_O_N_RCAR(addr, i)
+
+#define RDMA_SRC_I_P(p, addr, i)	rsnd_is_rzg3e(p) ? RDMA_SRC_I_P_G3E(addr, i) : RDMA_SRC_I_P_RCAR(addr, i)
+#define RDMA_SRC_O_P(p, addr, i)	rsnd_is_rzg3e(p) ? RDMA_SRC_O_P_G3E(addr, i) : RDMA_SRC_O_P_RCAR(addr, i)
+
+#define RDMA_CMD_O_N(p, addr, i)	rsnd_is_rzg3e(p) ? RDMA_CMD_O_N_G3E(addr, i) : RDMA_CMD_O_N_RCAR(addr, i)
+#define RDMA_CMD_O_P(p, addr, i)	rsnd_is_rzg3e(p) ? RDMA_CMD_O_P_G3E(addr, i) : RDMA_CMD_O_P_RCAR(addr, i)
 
 static dma_addr_t
 rsnd_gen2_dma_addr(struct rsnd_dai_stream *io,
@@ -522,8 +569,8 @@ rsnd_gen2_dma_addr(struct rsnd_dai_stream *io,
 {
 	struct rsnd_priv *priv = rsnd_io_to_priv(io);
 	struct device *dev = rsnd_priv_to_dev(priv);
-	phys_addr_t ssi_reg = rsnd_gen_get_phy_addr(priv, RSND_BASE_SSI);
-	phys_addr_t src_reg = rsnd_gen_get_phy_addr(priv, RSND_BASE_SCU);
+	phys_addr_t ssi_reg = rsnd_gen_get_phy_addr(priv, rsnd_is_rzg3e(priv) ? RSND_RZG3E_SSI : RSND_BASE_SSI);
+	phys_addr_t src_reg = rsnd_gen_get_phy_addr(priv, rsnd_is_rzg3e(priv) ? RSND_RZG3E_SCU : RSND_BASE_SCU);
 	int is_ssi = !!(rsnd_io_to_mod_ssi(io) == mod) ||
 		     !!(rsnd_io_to_mod_ssiu(io) == mod);
 	int use_src = !!rsnd_io_to_mod_src(io);
@@ -539,32 +586,32 @@ rsnd_gen2_dma_addr(struct rsnd_dai_stream *io,
 		/* SRC */
 		/* Capture */
 		{{{ 0,				0 },
-		  { RDMA_SRC_O_N(src, id),	RDMA_SRC_I_P(src, id) },
-		  { RDMA_CMD_O_N(src, id),	RDMA_SRC_I_P(src, id) } },
+		  { RDMA_SRC_O_N(priv, src, id),	RDMA_SRC_I_P(priv, src, id) },
+		  { RDMA_CMD_O_N(priv, src, id),	RDMA_SRC_I_P(priv, src, id) } },
 		 /* Playback */
 		 {{ 0,				0, },
-		  { RDMA_SRC_O_P(src, id),	RDMA_SRC_I_N(src, id) },
-		  { RDMA_CMD_O_P(src, id),	RDMA_SRC_I_N(src, id) } }
+		  { RDMA_SRC_O_P(priv, src, id),	RDMA_SRC_I_N(priv, src, id) },
+		  { RDMA_CMD_O_P(priv, src, id),	RDMA_SRC_I_N(priv, src, id) } }
 		},
 		/* SSI */
 		/* Capture */
-		{{{ RDMA_SSI_O_N(ssi, id),		0 },
-		  { RDMA_SSIU_O_P(ssi, id, busif),	0 },
-		  { RDMA_SSIU_O_P(ssi, id, busif),	0 } },
+		{{{ RDMA_SSI_O_N(priv, ssi, id),		0 },
+		  { RDMA_SSIU_O_P(priv, ssi, id, busif),	0 },
+		  { RDMA_SSIU_O_P(priv, ssi, id, busif),	0 } },
 		 /* Playback */
-		 {{ 0,			RDMA_SSI_I_N(ssi, id) },
-		  { 0,			RDMA_SSIU_I_P(ssi, id, busif) },
-		  { 0,			RDMA_SSIU_I_P(ssi, id, busif) } }
+		 {{ 0,			RDMA_SSI_I_N(priv, ssi, id) },
+		  { 0,			RDMA_SSIU_I_P(priv, ssi, id, busif) },
+		  { 0,			RDMA_SSIU_I_P(priv, ssi, id, busif) } }
 		},
 		/* SSIU */
 		/* Capture */
-		{{{ RDMA_SSIU_O_N(ssi, id, busif),	0 },
-		  { RDMA_SSIU_O_P(ssi, id, busif),	0 },
-		  { RDMA_SSIU_O_P(ssi, id, busif),	0 } },
+		{{{ RDMA_SSIU_O_N(priv, ssi, id, busif),	0 },
+		  { RDMA_SSIU_O_P(priv, ssi, id, busif),	0 },
+		  { RDMA_SSIU_O_P(priv, ssi, id, busif),	0 } },
 		 /* Playback */
-		 {{ 0,			RDMA_SSIU_I_N(ssi, id, busif) },
-		  { 0,			RDMA_SSIU_I_P(ssi, id, busif) },
-		  { 0,			RDMA_SSIU_I_P(ssi, id, busif) } } },
+		 {{ 0,			RDMA_SSIU_I_N(priv, ssi, id, busif) },
+		  { 0,			RDMA_SSIU_I_P(priv, ssi, id, busif) },
+		  { 0,			RDMA_SSIU_I_P(priv, ssi, id, busif) } } },
 	};
 
 	/*
@@ -803,8 +850,12 @@ static int rsnd_dma_alloc(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
 
 	*dma_mod = rsnd_mod_get(dma);
 
-	ret = rsnd_mod_init(priv, *dma_mod, ops, NULL, NULL,
-			    type, dma_id);
+	/*
+	 * Pass NULL for clock/reset - audmac_pp is managed globally in
+	 * rsnd_dma_probe() and core.c suspend/resume, not per-DMA-module.
+	 * See detailed explanation in rsnd_dma_probe().
+	 */
+	ret = rsnd_mod_init(priv, *dma_mod, ops, NULL, NULL, type, dma_id);
 	if (ret < 0)
 		return ret;
 
@@ -838,6 +889,12 @@ int rsnd_dma_attach(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
 	return rsnd_dai_connect(*dma_mod, io, (*dma_mod)->type);
 }
 
+void rsnd_dma_detach(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
+		     struct rsnd_mod **dma_mod)
+{
+	rsnd_dai_disconnect(*dma_mod, io, (*dma_mod)->type);
+}
+
 int rsnd_dma_probe(struct rsnd_priv *priv)
 {
 	struct platform_device *pdev = rsnd_priv_to_pdev(priv);
@@ -860,6 +917,56 @@ int rsnd_dma_probe(struct rsnd_priv *priv)
 		return 0; /* it will be PIO mode */
 	}
 
+	/*
+	 * audmac_pp clock/reset management strategy:
+	 *
+	 * Unlike other modules (SSI, SRC, etc.) which have their own dedicated
+	 * clocks, all DMA modules share the single audmac_pp clock/reset.
+	 * Managing it per-stream or per-DMA-module causes
+	 * reference count imbalances:
+	 *
+	 *   - rsnd_mod_init() does clk_prepare_enable() then clk_disable(),
+	 *     leaving prepare_count=1 per module
+	 *   - With N DMA modules sharing the same clock handle, prepare_count=N
+	 *   - suspend does single clk_disable_unprepare() (-1)
+	 *   - resume does single clk_prepare_enable() (+1)
+	 *   - Result: prepare_count leaks on each suspend/resume cycle
+	 *
+	 * Per-stream management (iterating DMA modules in suspend/resume) is
+	 * not worth the complexity:
+	 *
+	 *   - No power benefit: audmac_pp is needed whenever ANY stream is
+	 *     active, and every stream uses DMA, so it's essentially always on
+	 *   - Architecture mismatch: DMA modules live in io->dma, not in a
+	 *     priv array -- no clean way to iterate like SSI/SRC/DVC
+	 *   - Shared handle problem: all DMA modules point to the same clock,
+	 *     so iterating would call clk_unprepare() N times on one clock
+	 *   - Would require manual refcounting ("enable on first stream,
+	 *     disable on last") -- reimplementing what clk framework does
+	 *
+	 * The correct approach is to treat audmac_pp as always-on infrastructure
+	 * (same pattern as clk_adg), managed globally:
+	 *   - Probe: acquire + enable (via devm_clk_get_optional_enabled)
+	 *   - Suspend/Resume: toggle in core.c rsnd_suspend/rsnd_resume
+	 *   - Remove: devm cleanup
+	 *   - DMA modules: pass NULL clock/reset to rsnd_mod_init()
+	 *
+	 * Use devm variants that handle deassert/enable automatically.
+	 * Order: reset deasserted first, then clock enabled.
+	 */
+	priv->rstc_audmac_pp =
+		devm_reset_control_get_optional_exclusive_deasserted(dev, "audmac_pp");
+	if (IS_ERR(priv->rstc_audmac_pp)) {
+		return dev_err_probe(dev, PTR_ERR(priv->rstc_audmac_pp),
+				     "failed to get audmac_pp reset\n");
+	}
+
+	priv->clk_audmac_pp = devm_clk_get_optional_enabled(dev, "audmac_pp");
+	if (IS_ERR(priv->clk_audmac_pp)) {
+		return dev_err_probe(dev, PTR_ERR(priv->clk_audmac_pp),
+				     "failed to get audmac_pp clock\n");
+	}
+
 	/* for Gen4 doesn't have DMA-pp */
 	if (rsnd_is_gen4(priv))
 		goto audmapp_end;
diff --git a/sound/soc/renesas/rcar/rsnd.h b/sound/soc/renesas/rcar/rsnd.h
index 173fe475b7f8..8f3637904884 100644
--- a/sound/soc/renesas/rcar/rsnd.h
+++ b/sound/soc/renesas/rcar/rsnd.h
@@ -271,6 +271,8 @@ u32 rsnd_get_busif_shift(struct rsnd_dai_stream *io, struct rsnd_mod *mod);
  */
 int rsnd_dma_attach(struct rsnd_dai_stream *io,
 		    struct rsnd_mod *mod, struct rsnd_mod **dma_mod);
+void rsnd_dma_detach(struct rsnd_dai_stream *io,
+		     struct rsnd_mod *mod, struct rsnd_mod **dma_mod);
 int rsnd_dma_probe(struct rsnd_priv *priv);
 struct dma_chan *rsnd_dma_request_channel(struct device_node *of_node, char *name,
 					  struct rsnd_mod *mod, char *x);
@@ -590,6 +592,9 @@ int rsnd_rdai_width_ctrl(struct rsnd_dai *rdai, int width);
 int rsnd_dai_connect(struct rsnd_mod *mod,
 		     struct rsnd_dai_stream *io,
 		     enum rsnd_mod_type type);
+void rsnd_dai_disconnect(struct rsnd_mod *mod,
+			 struct rsnd_dai_stream *io,
+			 enum rsnd_mod_type type);
 
 /*
  *	R-Car Gen1/Gen2
@@ -628,6 +633,13 @@ void rsnd_adg_clk_dbg_info(struct rsnd_priv *priv, struct seq_file *m);
 struct rsnd_priv {
 
 	struct platform_device *pdev;
+
+	/*
+	 * below value will be filled on rsnd_dma_probe()
+	 */
+	struct clk *clk_audmac_pp;
+	struct reset_control *rstc_audmac_pp;
+
 	spinlock_t lock;
 	unsigned long flags;
 #define RSND_GEN_MASK	(0xF << 0)
-- 
2.25.1


