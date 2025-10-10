Return-Path: <dmaengine+bounces-6796-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B595BCC4DC
	for <lists+dmaengine@lfdr.de>; Fri, 10 Oct 2025 11:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563721A65C90
	for <lists+dmaengine@lfdr.de>; Fri, 10 Oct 2025 09:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E242258EE2;
	Fri, 10 Oct 2025 09:18:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m3297.qiye.163.com (mail-m3297.qiye.163.com [220.197.32.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705D1F4C99;
	Fri, 10 Oct 2025 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087917; cv=none; b=pAy5btswWo4N82fFRANPg+IhuzzyP7zYeISgAVwaedC1r9S30FOrNA+DHY0VlYIXDYY/uJrGcRzH89Ggaglp5mdiu5LP5Hn2zwcYf5rw7Nxl+8A4zGt1tCoMlhzQE2FSsiN3R0lOw7m2vtfq0i0ipkx+JzNTpaAv4ckvcp0VAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087917; c=relaxed/simple;
	bh=7ZH+y4GwW0ll9Chc7h2vRwCsuxsE0d4guvxwRLiqQAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OVYonzHEoVRVSrJvbk8ICrYVQSIuykjwmYCcy+p/Aba+QMfxzlSEj5r/zMxunevhnWUerM5RgdAdrwW2hzc97CSEPKfJrYB+rOyJoKlm245VxHKfG4lr13xIhGtlsDfE/Ao58A9o7aOG1zSsnAckz0FzqqNMP16Zdm+golJReis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.32.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1154d67e2;
	Fri, 10 Oct 2025 17:03:07 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: Frank.Li@nxp.com,
	vkoul@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: fsl-edma: Fix clk leak on alloc_chan_resources failure
Date: Fri, 10 Oct 2025 17:02:57 +0800
Message-Id: <20251010090257.212694-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99cd5c11d40229kunmb4490e2b9daa55
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZT09LVk1MGh4eSxgfGU5KGVYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

When fsl_edma_alloc_chan_resources() fails after clk_prepare_enable(),
the error paths only free IRQs and destroy the TCD pool, but forget to
call clk_disable_unprepare(). This causes the channel clock to remain
enabled, leaking power and resources.

Fix it by disabling the channel clock in the error unwind path.

Fixes: d8d4355861d8 ("dmaengine: fsl-edma: add i.MX8ULP edma support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 drivers/dma/fsl-edma-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 4976d7dde080..bd673f08f610 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -852,6 +852,8 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 		free_irq(fsl_chan->txirq, fsl_chan);
 err_txirq:
 	dma_pool_destroy(fsl_chan->tcd_pool);
+	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
+		clk_disable_unprepare(fsl_chan->clk);
 
 	return ret;
 }
-- 
2.20.1


