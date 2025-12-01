Return-Path: <dmaengine+bounces-7424-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00980C976A4
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 13:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E1D3A2571
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 12:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83EB30E0C2;
	Mon,  1 Dec 2025 12:50:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DD530DD2F;
	Mon,  1 Dec 2025 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593417; cv=none; b=qYIb7TmCKruxapAn/GkkBHpcirMJ36UruIOIJqWVEpaGx5ui5zlkUyVgGrfkLNQki8I+xnE9tHwjx1g3hMrs80XrxOz1+o3e0KczNxS/6fmWSQq2/l9AhjY9I95oFDCan9JH3phSLwsN5Wc3PmhGosRKZ13THBu91FUjGUKoM6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593417; c=relaxed/simple;
	bh=WhAJGCEAM/F7bLNFt0kKw1qhkRc+WVMYlcXR1S0/xnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGypcfD9SyZAsczXwJDkWuEprxxBv6neuVtpAPeqpszlOghcfn8q2Pwy844Bl7cDrk9THx0RS3NskI6KK1HuI3VOjL6FnCtfYgZLDzvALQxxumywhv5aCiNROMzHRzNellt0RSHbj9ONFsjf39Y1cq+NA90FWx7HkbKsVvs3KIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: OPWaf4kaTA2c+leRWioepg==
X-CSE-MsgGUID: RGLmopkhThaJ2d9iHxhS0A==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Dec 2025 21:50:14 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7869742100DB;
	Mon,  1 Dec 2025 21:50:09 +0900 (JST)
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
Subject: [PATCH v2 1/6] dmaengine: sh: rz_dmac: make error interrupt optional
Date: Mon,  1 Dec 2025 14:49:06 +0200
Message-ID: <20251201124911.572395-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs do not have
an error interrupt for the DMACs, and the current driver implementation
does not make much use of it.

To prepare for adding support for these SoCs, do not error out if the
error interrupt is missing.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * remove notes

 drivers/dma/sh/rz-dmac.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 38137e8d80b9..20a5c1766a58 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -954,16 +954,15 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	}
 
 	/* Register interrupt handler for error */
-	irq = platform_get_irq_byname(pdev, irqname);
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
-			       irqname, NULL);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
-			irq, ret);
-		return ret;
+	irq = platform_get_irq_byname_optional(pdev, irqname);
+	if (irq > 0) {
+		ret = devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
+				       irqname, NULL);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
+				irq, ret);
+			return ret;
+		}
 	}
 
 	/* Initialize the channels. */
-- 
2.52.0

