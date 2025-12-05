Return-Path: <dmaengine+bounces-7515-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE8ECA82D0
	for <lists+dmaengine@lfdr.de>; Fri, 05 Dec 2025 16:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E31FC3153E63
	for <lists+dmaengine@lfdr.de>; Fri,  5 Dec 2025 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27113491F5;
	Fri,  5 Dec 2025 15:14:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D594B19006B;
	Fri,  5 Dec 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947664; cv=none; b=GcH+pyLf0i32QDwSk1oGsA/VTDoGUGanoBxHbDM9NObWR1QLBAkZ3BhGu1UN8m/GdnhnxU6YRzhGFE8yVjGeUV/4HTbxZs2h7za67qOzjQ4COqI2wdDJgQsAcTHh806rEqGIob7Q/pStQQd3V0mkn1iaVVLNBIiGaF78HGO/cFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947664; c=relaxed/simple;
	bh=BI3xuJAU00rEkEy7Ppxjcva179LcP2IiwZo9Bd4ZgAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gtqbhhnl/980SSiThMx1U4p6giToEdkZbDQssYiKNTy8J20IyfdrhGGqrsRufgjqqs7a37T+zp4I3vUb1muU58vfCwEUy0I7Sf3WXF8MsIOh3A/ZGldAZqterM7nDbZI4q6Zw8b4HLS0x5P1joAiZgEb/vD1tpKAiIEIVjGbXAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: P/in2etHStCAJDD+SDw70A==
X-CSE-MsgGUID: qwRG+e5USd+M3Geopyhcaw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 Dec 2025 00:14:10 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.202])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E11064005E29;
	Sat,  6 Dec 2025 00:14:05 +0900 (JST)
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
Subject: [PATCH v3 4/6] dmaengine: sh: rz_dmac: add RZ/{T2H,N2H} support
Date: Fri,  5 Dec 2025 17:12:52 +0200
Message-ID: <20251205151254.2970669-5-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251205151254.2970669-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251205151254.2970669-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
---

V3:
 * no changes

V2:
 * remove notes

 drivers/dma/sh/rz-dmac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index e4b369f13cbc..2f06ed4025da 100644
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
@@ -1070,12 +1071,18 @@ static const struct rz_dmac_info rz_dmac_v2h_info = {
 	.dma_req_no_default = RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
 };
 
+static const struct rz_dmac_info rz_dmac_t2h_info = {
+	.register_dma_req = rzt2h_icu_register_dma_req,
+	.dma_req_no_default = RZT2H_ICU_DMAC_REQ_NO_DEFAULT,
+};
+
 static const struct rz_dmac_info rz_dmac_common_info = {
 	.dma_req_no_default = 0,
 };
 
 static const struct of_device_id of_rz_dmac_match[] = {
 	{ .compatible = "renesas,r9a09g057-dmac", .data = &rz_dmac_v2h_info },
+	{ .compatible = "renesas,r9a09g077-dmac", .data = &rz_dmac_t2h_info },
 	{ .compatible = "renesas,rz-dmac", .data = &rz_dmac_common_info },
 	{ /* Sentinel */ }
 };
-- 
2.52.0

