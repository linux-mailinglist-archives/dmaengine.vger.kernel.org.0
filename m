Return-Path: <dmaengine+bounces-7419-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE28C971DA
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 12:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0BFB9343F68
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5042EBDF2;
	Mon,  1 Dec 2025 11:50:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CC72EFD9B;
	Mon,  1 Dec 2025 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764589825; cv=none; b=UBNOk2eGnYtGp9p5tm+rfeMfRJI3g/NH5gq+K6CfGj/8EUGp9dmzgyYnFNcTwOuIv+o96XLshMkJEgx1MA5OlbmJnhiDgEVuEdSV308TyBimT+2c7flk9udtMYvyA5zbi5AQF60lM/qMBnaDAVSgPO0cjsF2dbE0EAl1sTNv2Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764589825; c=relaxed/simple;
	bh=OX0N8uGNmq3Fo4ls/tZWOJEeeTc4QqXYJWD3ZpPwr6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apApZ62fMxEN3nvB9RNSN9jbhUE86nsQCINFnFd0l0OlVnT5etSUNvYOYJShOFiZ40Br33bxYbc3N8scsLm1GzVa66KdmS1AkUmCitN0yYQvJHeMlYBlct5novPTeBssD4AM3sxti0kQ1GlWEmtiZeEO8gEDmKxiFiNmq/qXD/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 77ZHTJs1Scyx6hgSnAMbeQ==
X-CSE-MsgGUID: BG38dAjHTuKRsKMJRNBQpg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Dec 2025 20:50:22 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3D07441F9E1E;
	Mon,  1 Dec 2025 20:50:17 +0900 (JST)
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
Subject: [PATCH 4/6] dmaengine: sh: rz_dmac: add RZ/{T2H,N2H} support
Date: Mon,  1 Dec 2025 13:49:08 +0200
Message-ID: <20251201114910.515178-5-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201114910.515178-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251201114910.515178-1-cosmin-gabriel.tanislav.xa@renesas.com>
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

V2:
 * pick up Fab's Reviewed-by

 drivers/dma/sh/rz-dmac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index f94be3f8e232..c0c23c39a626 100644
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
@@ -1073,12 +1074,18 @@ static const struct rz_dmac_info rz_dmac_v2h_info = {
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

