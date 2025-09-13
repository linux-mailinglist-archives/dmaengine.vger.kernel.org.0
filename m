Return-Path: <dmaengine+bounces-6502-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE4FB561D3
	for <lists+dmaengine@lfdr.de>; Sat, 13 Sep 2025 17:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2D7487434
	for <lists+dmaengine@lfdr.de>; Sat, 13 Sep 2025 15:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D381FBCA7;
	Sat, 13 Sep 2025 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="WDogDo44"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297F2DC775;
	Sat, 13 Sep 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757777678; cv=none; b=moBG1bI1zEOFMW/p5F4zeqSpDpcvcd8alAkAkqOkyhUyXVa8+bwfoX6XFSgIV/wHybGitsnIFrenVimnEBKvixebJN2FI6XNxAlHPS9/9gzGCDg+nUiYpU1aIZLWOV9s/DpA0hmpL2z7x/WYhuOeTM0AVmQorKV8YfN/gnl+fwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757777678; c=relaxed/simple;
	bh=zDJkXksHNWkyV+fdAhhRBfBvys/CBOptat8c01q9QH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uCS08lcxn4IqxLGj7lxwexfqtHQwxFDLje+v6BM7qSk9jTIF9ltdVDLSM/oCNbLwhzH3Xaap8GJdlrG5H+YPWa+SWkff+uM9KvOVIXHq0uhjhfHP2uijJGGfyPBGPUUZK3HPTSyrx/vaeBIWut+9RO33Dybuuqpkp0K48iaWDCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=WDogDo44; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 22b0da6a0;
	Sat, 13 Sep 2025 23:34:25 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH V2] drivers/dma: replace dma_free_coherent with dma_free_wc
Date: Sat, 13 Sep 2025 15:34:23 +0000
Message-Id: <20250913153423.1030647-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9943b69ccd03a1kunm5794e2c332b5f8
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSkNJVkkeHh8fGB9DS0pMTFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=WDogDo44+fVb/f7/Dfff/7bKWN1cvDBDVQqJfIbxEGgDNj9FLrs0DKvMEO0UYM1zySz6xKR+8kTl4QLyqooZ6vKExKieNzZoVxKwp4i2GpjtLYqdVJDQQcrqiVg+lwWRAcodxuLCDlZ9q69Z/JCtDKm1tti/NvCpbW69Jx9yDSY=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=dyqR32UqNnk9Y8tN2tYYYzjHOOHBLhvnORrO7fpnSKI=;
	h=date:mime-version:subject:message-id:from;

The DMA descriptor pool is allocated with dma_alloc_wc but freed with
dma_free_coherent in the error handling path. This mismatch prevents
the resource from being released properly and may lead to memory leaks
or other issues.

Fix this by freeing the DMA descriptor pool with dma_free_wc to match
the dma_alloc_wc allocation.

Fixes: b503fa01990f ("dma: mv_xor: remove the pool_size from platform_data")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---

Changes in v2:
- Fix the incorrect description in the commit log.
- Add "Fixes" tag accordingly.

 drivers/dma/mv_xor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 1fdcb0f5c9e7..58de208fc50d 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1163,7 +1163,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 err_free_irq:
 	free_irq(mv_chan->irq, mv_chan);
 err_free_dma:
-	dma_free_coherent(&pdev->dev, MV_XOR_POOL_SIZE,
+	dma_free_wc(&pdev->dev, MV_XOR_POOL_SIZE,
 			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
 err_unmap_dst:
 	dma_unmap_single(dma_dev->dev, mv_chan->dummy_dst_addr,
-- 
2.34.1


