Return-Path: <dmaengine+bounces-9526-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKeALHIdvGlEsQIAu9opvQ
	(envelope-from <dmaengine+bounces-9526-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 16:59:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DE12CE2AF
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 16:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40746303120D
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4FC3E958D;
	Thu, 19 Mar 2026 15:55:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0919C3E5EFE;
	Thu, 19 Mar 2026 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935726; cv=none; b=FJU/5lzkvRTxg99nBT457XyGWUYvFQskaSdERgGB2JWd7n0UIrRaagiTa0mHbVDMC8ZfhI1LlvmseF76jwil5Gk84C93b+GLQ65PTpPA5W8F1KHj3O9L1RhUR0HoLn5chtuPF0XoO/XymNY6n0X93pONA8UW4heIAF9/jr6OGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935726; c=relaxed/simple;
	bh=jHN1z2RQBeF4SF4pTau84UmLX++ijP/BwnLa6SKIfIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsIsvbxklw4POtJ/yUFHX3yVY+Rm/IhD0etN+bpQtg8clB8S140SP8EsaK1PW6unZgmiwh7NfZMpWRA/3Wg5lScrcDBSgubN20SqpB2daCVKVh7oWojBldFRKtZe3X+dMjsUH0iTK+645pWSiGKOa1RT67G97nVVMiJv3kpGkCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 3Ks5o3k/RheGial0d3almQ==
X-CSE-MsgGUID: hTCTNvf2RIeo74gClBGz7Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Mar 2026 00:55:23 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.35])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8B930401B307;
	Fri, 20 Mar 2026 00:55:14 +0900 (JST)
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
Subject: [PATCH 04/22] dt-bindings: dma: renesas,rz-dmac: Document optional DMA ACK cell
Date: Thu, 19 Mar 2026 16:53:16 +0100
Message-ID: <20260319155334.51278-5-john.madieu.xa@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9526-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	NEURAL_SPAM(0.00)[0.657];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 94DE12CE2AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some peripherals on RZ/V2H, RZ/V2N, and RZ/G3E SoCs require explicit
ACK signal routing through the ICU. Document the optional second cell
in the DMA specifier for specifying the ACK signal number.

The first cell remains unchanged and specifies the encoded MID/RID and
channel configuration. The optional second cell specifies the DMA ACK
signal number for peripherals requiring level-based handshaking.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 .../bindings/dma/renesas,rz-dmac.yaml         | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index 0155a15e200b..f3966c288890 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -63,17 +63,27 @@ properties:
       - const: register
 
   '#dma-cells':
-    const: 1
-    description:
+    description: |
       The cell specifies the encoded MID/RID or the REQ No values of
       the DMAC port connected to the DMA client and the slave channel
       configuration parameters.
+      Use 1 cell for basic DMA configuration.
+      Use 2 cells when DMA ACK signal routing through ICU is required
+      (RZ/V2H, RZ/V2N, RZ/G3E audio peripherals such as SSIU, SPDIF, SRC, DVC).
+
+      First cell:
       bits[0:9] - Specifies the MID/RID or the REQ No value
       bit[10] - Specifies DMA request high enable (HIEN)
       bit[11] - Specifies DMA request detection type (LVL)
       bits[12:14] - Specifies DMAACK output mode (AM)
       bit[15] - Specifies Transfer Mode (TM)
 
+      Second cell (optional, when #dma-cells = <2>):
+      bits[6:0] - DMA acknowledge signal number (from ICU ACK table),
+                  where 0 is a valid signal number.
+                  Required for peripherals using level-based DMA
+                  handshaking (SSIU, SPDIF, RSPI, SCU, ADC, PDM).
+
   dma-channels:
     const: 16
 
@@ -212,6 +222,20 @@ allOf:
         - renesas,icu
         - resets
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g057-dmac
+    then:
+      properties:
+        '#dma-cells':
+          enum: [1, 2]
+    else:
+      properties:
+        '#dma-cells':
+          const: 1
+
   - if:
       properties:
         compatible:
-- 
2.25.1


