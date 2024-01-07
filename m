Return-Path: <dmaengine+bounces-697-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0928263AC
	for <lists+dmaengine@lfdr.de>; Sun,  7 Jan 2024 11:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972062827D6
	for <lists+dmaengine@lfdr.de>; Sun,  7 Jan 2024 10:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9239134A3;
	Sun,  7 Jan 2024 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NVbya2GM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7612B84
	for <dmaengine@vger.kernel.org>; Sun,  7 Jan 2024 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id MPysrRwtE9WXyMPz3rZ58J; Sun, 07 Jan 2024 11:02:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704621742;
	bh=aJxzVqIgfQ6I8zkGzF9gzvRPzwUJvo/hE6MLhe9DP3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NVbya2GMo5OoRxXFFv5NHUY1L5eI3ttmziRZBoCzBx3k2g4l0RVemOhW3s3ev15Xv
	 JP/ka/4sMZzNpbbS8uvsrd3/rztuz7RryCRIJMQGZFUSLh8VnkKFzr7RVGnExUiksG
	 DEXImPZ8BoBYIrbooWiLi9qNF1goQR+I9HAlwxQVfMQVLwrQCadDteRFR7XJL6CKOO
	 LlUeOs+jWHBgAkrJt5vBJGUAHhaAlVRss9zch1nNUEm58zs3yDixHuNLxi6zKqJo/6
	 bChNKkx+GYaL1pRF5lQXh79VqNUNTWZRIU6ShctpGHEUEtsiVfFhuGCBmZo2vjYwSJ
	 9G/EdahnL8X9g==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Jan 2024 11:02:22 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: vkoul@kernel.org,
	jiaheng.fan@nxp.com,
	peng.ma@nxp.com,
	wen.he_1@nxp.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3] dmaengine: fsl-qdma: Fix a memory leak related to the queue command DMA
Date: Sun,  7 Jan 2024 11:02:04 +0100
Message-Id: <7f66aa14f59d32b13672dde28602b47deb294e1f.1704621515.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1704621515.git.christophe.jaillet@wanadoo.fr>
References: <cover.1704621515.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This dma_alloc_coherent() is undone neither in the remove function, nor in
the error handling path of fsl_qdma_probe().

Switch to the managed version to fix both issues.

Fixes: b092529e0aa0 ("dmaengine: fsl-qdma: Add qDMA controller driver for Layerscape SoCs")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/fsl-qdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 38409e06040a..3a5595a1d442 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -514,11 +514,11 @@ static struct fsl_qdma_queue
 			queue_temp = queue_head + i + (j * queue_num);
 
 			queue_temp->cq =
-			dma_alloc_coherent(&pdev->dev,
-					   sizeof(struct fsl_qdma_format) *
-					   queue_size[i],
-					   &queue_temp->bus_addr,
-					   GFP_KERNEL);
+			dmam_alloc_coherent(&pdev->dev,
+					    sizeof(struct fsl_qdma_format) *
+					    queue_size[i],
+					    &queue_temp->bus_addr,
+					    GFP_KERNEL);
 			if (!queue_temp->cq)
 				return NULL;
 			queue_temp->block_base = fsl_qdma->block_base +
-- 
2.34.1


