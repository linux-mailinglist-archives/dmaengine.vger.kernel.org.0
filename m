Return-Path: <dmaengine+bounces-7512-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 639A3CA82A0
	for <lists+dmaengine@lfdr.de>; Fri, 05 Dec 2025 16:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFA61320090D
	for <lists+dmaengine@lfdr.de>; Fri,  5 Dec 2025 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C61345CA5;
	Fri,  5 Dec 2025 15:14:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3473446D4;
	Fri,  5 Dec 2025 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947643; cv=none; b=k3wo49X6sZab8P1h2rLPw4bB1BREPrhyTHvwkBZMQ6V9sJkquiweelM3WYjvPFp7p1z/oiFHaPYy1kemFVjuAeHdiZ1dBFI90RY+nsPUaFtx5sjzti4yIa0t8ZwCXW19laqK5Fsc5TwLMXNiEJA4ccArS2VLGeqYwb697bfz3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947643; c=relaxed/simple;
	bh=x1YVE2yjw3ZRn2O5N3QTAjBV9AFut/Cx/KiKXDYBhbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoALZG/I1/Ao4TgrrTDfBSFpmsQTtWQO7iayafCI4AJsKQQ1jwwgz8bMJohk6StnByGI+og/eE569d9SMHI/tM75/xm0B9dAGJz0AumYUKGx6RNWC2qTXLl/zuU9AenIOzbLf3lMqOLgMuogpVnlfGwyAtArN4Nu8xSuxCIyFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: BuvU9K+aRR+6yV7VTkwjYg==
X-CSE-MsgGUID: XHx0sXa0TiyQN5aRIYJueg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 Dec 2025 00:13:53 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.202])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 45CB24005E29;
	Sat,  6 Dec 2025 00:13:49 +0900 (JST)
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
Subject: [PATCH v3 1/6] dmaengine: sh: rz_dmac: make error interrupt optional
Date: Fri,  5 Dec 2025 17:12:49 +0200
Message-ID: <20251205151254.2970669-2-cosmin-gabriel.tanislav.xa@renesas.com>
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

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs do not have
an error interrupt for the DMACs, and the current driver implementation
does not make much use of it.

To prepare for adding support for these SoCs, do not error out if the
error interrupt is missing.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * no changes

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

