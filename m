Return-Path: <dmaengine+bounces-7415-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 420E5C971AA
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 12:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3DF94E196D
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABC52EA752;
	Mon,  1 Dec 2025 11:50:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAF12EA498;
	Mon,  1 Dec 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764589808; cv=none; b=K7Li630XWb4cnT8YtoKppfhtQCaovWQ0TQ7krg7/b/UDi9FJMp9rXcXLc483CZRoRiSMB6pp72MFM0qP2+gvHOgHr7c5ex8rRDogNIvzfR80j8np9Q+YWX5aKmIOfcfZ03RtBg5zEp7ZGUygshv6rMsSLmXmVi0R0Fo6s0xCwlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764589808; c=relaxed/simple;
	bh=wwU7sF+SGIZ7+oHTz+yuRshRcLVvH8YW4fY+bnGYzZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOp6ulYCubwTPB8QYERlHroryAh1JBH0JKCNIS5dHiKOuVo2aQpO8KBqdhXckZnYNXkZ9MniUbfcyEpUiKG2IHsKsKt7lnJxtPTX4qC4rq/DweEhuXzGAF6NOSlo74/3dICejQpfLUFfb8vovtlBBbt+m4fuJ33nkBeOBWxktRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: S8op3OR9RcuPC+74PiogMQ==
X-CSE-MsgGUID: uvqBFquBQGSTGpeY+8Eg3Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Dec 2025 20:50:05 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D819741F9E08;
	Mon,  1 Dec 2025 20:50:00 +0900 (JST)
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
Subject: [PATCH 1/6] dmaengine: sh: rz_dmac: make error interrupt optional
Date: Mon,  1 Dec 2025 13:49:05 +0200
Message-ID: <20251201114910.515178-2-cosmin-gabriel.tanislav.xa@renesas.com>
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

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs do not have
an error interrupt for the DMACs, and the current driver implementation
does not make much use of it.

To prepare for adding support for these SoCs, do not error out if the
error interrupt is missing.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * pick up Fab's Reviewed-by

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

