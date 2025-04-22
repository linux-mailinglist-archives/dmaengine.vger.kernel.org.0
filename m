Return-Path: <dmaengine+bounces-4940-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B56D1A973C3
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 19:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74DEE7AD5BD
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 17:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8865B1DDA1E;
	Tue, 22 Apr 2025 17:40:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE872980C2;
	Tue, 22 Apr 2025 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343603; cv=none; b=cQt/dmINPNTtWLRJY21XhqQcDN/rvFZS6jdnZ8nEEECaizaPMUZ786DY8XsTLLbAVqeZfhCrKfvhPlQNn2fNzdkBmMCyKTGvfIYK2j/jV08J0AkrqMOXZn1G/WkZM9yo1Rc0Kc4SyQROFn63ch3rXFbdN/NWZ36gVWdzJ306s34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343603; c=relaxed/simple;
	bh=T1nezSAU2/i7clh4+utfsA6OXaqiGq6mmwz7s1fsqpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N9UjZVUW2EovlEQPpVIGNQUqkPaGV9YzvXhXPkHKwnYkUL9L9vFJPRyml0fRX+nMXcEngeuq9hnQ6gPZWiVLYWgm2fmsOWeP5uCrxqL9wMflKT1NfyQwiNLDQkXu8ir+pjxODtmRypDmTYm/J3USyHMsdZR/exxuDbaboaMVYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: D+ZhbfOhTMS0BfJxF91gaw==
X-CSE-MsgGUID: /R0BtqE8QyGNEoBhH4Xr/w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Apr 2025 02:40:01 +0900
Received: from mulinux.home (unknown [10.226.92.16])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 399C140437A5;
	Wed, 23 Apr 2025 02:39:57 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v6 4/6] dmaengine: sh: rz-dmac: Allow for multiple DMACs
Date: Tue, 22 Apr 2025 18:39:35 +0100
Message-Id: <20250422173937.3722875-5-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422173937.3722875-1-fabrizio.castro.jz@renesas.com>
References: <20250422173937.3722875-1-fabrizio.castro.jz@renesas.com>
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


