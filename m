Return-Path: <dmaengine+bounces-6829-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CC5BD72E0
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 05:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B60F19A0732
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 03:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCFE1F4297;
	Tue, 14 Oct 2025 03:23:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m49248.qiye.163.com (mail-m49248.qiye.163.com [45.254.49.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A62AD2C
	for <dmaengine@vger.kernel.org>; Tue, 14 Oct 2025 03:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760412217; cv=none; b=qMkJ4m9J0Eb8jG/1XDuF6rLAOtStw6zd/pmouIVAr4rhe7rbQignJT1b2aT3rbsbYBb4YCW4bFn13b9hpZWIPpROJTYSVO1y5pssLUAHJ+iFpLdW5IsL5l34vWo1RYvvx6DYfaw0oesbcBOGN7tyk6ULLQKSM4VaD5ZABs/+TTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760412217; c=relaxed/simple;
	bh=G9tH+JtbxqLShzsNQzUUFvtnz5O4c0ExrGAfJFLW9bM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c3q+tfGruA4oKa6A6V6BXPUuxrIwGfSnE6rzRVSxhwezO4oEJeHvS3n7NgCAeMeG7phBP/EFvlmubgRsu+lAqTN+yepe57vb1nJ3RUqLTr0sqkC4rD+zw7aFhlkspG9LpjmYbQOGAvCHdPZSEOCpPvp+6EgkqsRrhY2nB9QxT0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.254.49.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 117ea7788;
	Tue, 14 Oct 2025 10:47:58 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: Frank.Li@nxp.com,
	vkoul@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] dmaengine: fsl-edma: Remove redundant check in fsl_edma_free_chan_resources()
Date: Tue, 14 Oct 2025 10:47:30 +0800
Message-Id: <20251014024730.751237-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99e09e0d4b0229kunm9eba912d36a9bf
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTBkdVhoaTk4eSUofQ0tDSlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

clk_disable_unprepare() is safe to call with a NULL clk, the
FSL_EDMA_DRV_HAS_CHCLK check is reduntante. Clean up redundant checks.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 drivers/dma/fsl-edma-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 11655dcc4d6c..3007d5b7db55 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -884,8 +884,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_chan->is_sw = false;
 	fsl_chan->srcid = 0;
 	fsl_chan->is_remote = false;
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
-		clk_disable_unprepare(fsl_chan->clk);
+	clk_disable_unprepare(fsl_chan->clk);
 }
 
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
-- 
2.20.1


