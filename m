Return-Path: <dmaengine+bounces-5010-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 970C4A98D3B
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 16:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F941B63832
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 14:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A60D281365;
	Wed, 23 Apr 2025 14:34:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCFC280CF6;
	Wed, 23 Apr 2025 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418891; cv=none; b=UYbz3UQ/akCe/jKZRbjMvfNDn+4VxwzDo1ZpBg+TEDBuCI4/lqZ3gxAqP4Bf8YX2CyA09BO3RrgiQ690PCrPxoewO9R1pRSfnESIGUCHt+iPCckTgw/qP1gplfRqeL47BHQC1PX1Wrvq2JD8/8+xOf1fMrf4AjvHtFJJku11Fn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418891; c=relaxed/simple;
	bh=39Myn6SU36ZC1jjIB6XpmRWcE8nF+9seNNLrHhgujNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BfylWvKJ9Y6EmhlBTnDGk3gcmti6A5oQg6mJxA/6lDrugPVsCWkBnVSiZTRFXdONDHBRBUp1vKZKhu10uYydAa7mmfLPrKi/mbT24IvHsPDMDCjn4Q1IkbFx8HL/xGG6/tFQRkYz56BdRJFKejNd6KuWWoaHXoE3ssYiAT5hbKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: +39MR4TkTpqoBEQaEvi0Dg==
X-CSE-MsgGUID: rWdHj1y2T3CYRdon539GJA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Apr 2025 23:34:48 +0900
Received: from mulinux.home (unknown [10.226.92.16])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C6F0642722E4;
	Wed, 23 Apr 2025 23:34:45 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v7 4/6] dmaengine: sh: rz-dmac: Allow for multiple DMACs
Date: Wed, 23 Apr 2025 15:34:20 +0100
Message-Id: <20250423143422.3747702-5-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423143422.3747702-1-fabrizio.castro.jz@renesas.com>
References: <20250423143422.3747702-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_request_channel() calls into __dma_request_channel() with
NULL as value for np, which won't allow for the selection of the
correct DMAC when multiple DMACs are available.

Switch to using __dma_request_channel() directly so that we can
choose the desired DMA for the channel. This is in preparation
of adding DMAC support for the Renesas RZ/V2H(P) and similar SoCs.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v6->v7:
* No change.
v5->v6:
* No change.
v4->v5:
* Collected tags.
v3->v4:
* No change.
v2->v3:
* Added () for calls in changelog.
v1->v2:
* No change.
---
 drivers/dma/sh/rz-dmac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 9235db551026..d7a4ce28040b 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -748,7 +748,8 @@ static struct dma_chan *rz_dmac_of_xlate(struct of_phandle_args *dma_spec,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	return dma_request_channel(mask, rz_dmac_chan_filter, dma_spec);
+	return __dma_request_channel(&mask, rz_dmac_chan_filter, dma_spec,
+				     ofdma->of_node);
 }
 
 /*
-- 
2.34.1


