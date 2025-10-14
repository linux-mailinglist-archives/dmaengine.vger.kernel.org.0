Return-Path: <dmaengine+bounces-6832-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E5CBD87B4
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 11:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572473A6B25
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 09:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9453529993F;
	Tue, 14 Oct 2025 09:41:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m3269.qiye.163.com (mail-m3269.qiye.163.com [220.197.32.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A592E7BD3;
	Tue, 14 Oct 2025 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434868; cv=none; b=GmTTzjYdPwzC1eZGGTRl7xeZQy3D6gml9tE6oPjXY71pOuY/kcnEyM0vseFr1+Jai4aarNmvWs9VkAUUpz8cCahfFeigJM7BV6VZqAu/rzOGc63Y2yb9hKrR9xRvvwasg1F/f5weh5X0fowg3coMoY0izTfzx2uRLVvUA9HF8Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434868; c=relaxed/simple;
	bh=wIX9z9fGBkzackI3qTx/wlLQYePO6us1ly3fqDoLPSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cUpAUUuDa3dPrr0SmyQy3ShDzDvLkK5JDdJrZuIDElwGMCk8WdP3K4GjQ3OX7RaIQ87wYTvh9To8fS6gx/g/BHVjXd9qbHx/wZDsDhcUglFVvVR4l1aFxZ+sKJgCRwGC0sl2lHEiODCBcygG2ZDBypNZ4MoiavuAAA95inL8c64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.32.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 11843a334;
	Tue, 14 Oct 2025 17:05:30 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: Frank.Li@nxp.com,
	vkoul@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH v4] dmaengine: fsl-edma: Fix clk leak on alloc_chan_resources failure
Date: Tue, 14 Oct 2025 17:05:22 +0800
Message-Id: <20251014090522.827726-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99e1f7b29b0229kunmab906d2b3d2473
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTE8YVkJOSkpKQkNIT04aGlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

When fsl_edma_alloc_chan_resources() fails after clk_prepare_enable(),
the error paths only free IRQs and destroy the TCD pool, but forget to
call clk_disable_unprepare(). This causes the channel clock to remain
enabled, leaking power and resources.

Fix it by disabling the channel clock in the error unwind path.

Fixes: d8d4355861d8 ("dmaengine: fsl-edma: add i.MX8ULP edma support")
Cc: stable@vger.kernel.org
Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
Changes in v2:
- Remove FSL_EDMA_DRV_HAS_CHCLK check
Changes in v3:
- Remove cleanup
Changes in v4:
- Re-send as a new thread
---
 drivers/dma/fsl-edma-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 4976d7dde080..11655dcc4d6c 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -852,6 +852,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 		free_irq(fsl_chan->txirq, fsl_chan);
 err_txirq:
 	dma_pool_destroy(fsl_chan->tcd_pool);
+	clk_disable_unprepare(fsl_chan->clk);
 
 	return ret;
 }
-- 
2.20.1


