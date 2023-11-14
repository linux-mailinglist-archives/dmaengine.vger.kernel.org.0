Return-Path: <dmaengine+bounces-104-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3B77EB2C8
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 15:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F581F24F6E
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 14:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A4141232;
	Tue, 14 Nov 2023 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WYk2bi0R"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B233FE5D
	for <dmaengine@vger.kernel.org>; Tue, 14 Nov 2023 14:52:07 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52189126;
	Tue, 14 Nov 2023 06:52:06 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A3D59240003;
	Tue, 14 Nov 2023 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1699973525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zfuTvre0UzAi4GpamYmN3E9uemUolgHrcnYVxe0/6o=;
	b=WYk2bi0RayS5KdrXFqbBs1ZUT9c5Dp0Ig/yyDAl+rGqTB0JGPqachk9W2nn3szazQliexh
	bJu4e+X7001Ndf3IAj2ulsFJoD+/h2Mr3OzLL8CNMtSVk8kx1VanZDTwjyPgIcoTKiQ46Q
	zddanlA29ytFqh6mN/fXTdq/iI1lfq2HfgLyDtO8MwREiWpc3C52OupHDWcrfrRqRySEk8
	HJzevquDlmD3osMZ2ChzrpwPLbIRlR7YObCAFt8aOF3O55P1+sKkaHcNu4ANYei6B/jldt
	mzu6Q2h93Q3YOj6sAHbNj6hRRqHW9qrbqhyR8xXGFZcQuam3c3iudq7sQYKSmg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 14 Nov 2023 15:51:55 +0100
Subject: [PATCH v5 2/6] dmaengine: dw-edma: Fix wrong interrupt bit set
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-b4-feature_hdma_mainline-v5-2-7bc86d83c6f7@bootlin.com>
References: <20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com>
In-Reply-To: <20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Cai Huoqing <cai.huoqing@linux.dev>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Herve Codina <herve.codina@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Fix "HDMA_V0_LOCAL_STOP_INT_EN" to "HDMA_V0_LOCAL_ABORT_INT_EN" as the STOP
bit is already set in the same line.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---

Changes in v3:
- Split the patch in two to differ bug fix and simple harmless typo.
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 1f4cb7db5475..108f9127aaaa 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -236,7 +236,7 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		/* Interrupt enable&unmask - done, abort */
 		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
 		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
-		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
+		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
 		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);

-- 
2.25.1


