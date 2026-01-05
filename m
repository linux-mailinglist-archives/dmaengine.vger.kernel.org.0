Return-Path: <dmaengine+bounces-8012-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FCFCF3547
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 12:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA66F301E58D
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 11:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016C2332EAD;
	Mon,  5 Jan 2026 11:46:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7209B332918;
	Mon,  5 Jan 2026 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613570; cv=none; b=fxjmKQgsSz3pLjJMOCQfi6uT5XYQ/tLzLffhKTftAI5V2ki4AeyTBQM7jFzNBffqwI01c6tXAWRSRrxqGvzuO5XneUt2HHmgPWA6Ek9IF0+mdh4U2XnTPOlPA0ll3m3Zs7yowK++vUxZdR0AXS1IWBZ3x0s7Eh5bIFjI970h6Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613570; c=relaxed/simple;
	bh=5NaoM49GzV7popx8iNvV5GKjrT/oZGdOz547aUUDssM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2CkDEhP3jWrBNq7BENzgzQUGoLEEN1xPODwn+zwm1DPs/YiEW2PzdtVYeCkwQYNDsL/2gjurXr7Qk9BC8vhqx54Lsk1RJuzMBjNI0cI3WDZM0Mcvd7IVOohl8MzAltq+jC84yKghutHEfRVR4oemmABDpyDYtFurakmTeQndQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 5PqvRYpgSXeutxZjwFSE4w==
X-CSE-MsgGUID: fH5+xeNzRLiF8vipSL6zmw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jan 2026 20:46:06 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.160])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6DD8D41AF7F0;
	Mon,  5 Jan 2026 20:46:01 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Johan Hovold <johan@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 4/4] dmaengine: sh: rz_dmac: add RZ/{T2H,N2H} support
Date: Mon,  5 Jan 2026 13:44:45 +0200
Message-ID: <20260105114445.878262-5-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105114445.878262-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260105114445.878262-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs use a
completely different ICU unit compared to RZ/V2H, which requires a
separate implementation.

Add support for them.

RZ/N2H will use RZ/T2H as a fallback.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

V4:
 * pick up Geert's Reviewed-by

V3:
 * no changes

V2:
 * remove notes

 drivers/dma/sh/rz-dmac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index b3e38bd294b2..3dde4b006bcc 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/irqchip/irq-renesas-rzv2h.h>
+#include <linux/irqchip/irq-renesas-rzt2h.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -1075,12 +1076,18 @@ static const struct rz_dmac_info rz_dmac_v2h_info = {
 	.default_dma_req_no = RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
 };
 
+static const struct rz_dmac_info rz_dmac_t2h_info = {
+	.icu_register_dma_req = rzt2h_icu_register_dma_req,
+	.default_dma_req_no = RZT2H_ICU_DMAC_REQ_NO_DEFAULT,
+};
+
 static const struct rz_dmac_info rz_dmac_generic_info = {
 	.default_dma_req_no = 0,
 };
 
 static const struct of_device_id of_rz_dmac_match[] = {
 	{ .compatible = "renesas,r9a09g057-dmac", .data = &rz_dmac_v2h_info },
+	{ .compatible = "renesas,r9a09g077-dmac", .data = &rz_dmac_t2h_info },
 	{ .compatible = "renesas,rz-dmac", .data = &rz_dmac_generic_info },
 	{ /* Sentinel */ }
 };
-- 
2.52.0

