Return-Path: <dmaengine+bounces-2835-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 898B394DC15
	for <lists+dmaengine@lfdr.de>; Sat, 10 Aug 2024 11:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A03281CD5
	for <lists+dmaengine@lfdr.de>; Sat, 10 Aug 2024 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3316F14AD3D;
	Sat, 10 Aug 2024 09:48:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5D914A4F3;
	Sat, 10 Aug 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723283296; cv=none; b=FPPkNctYWMD+2Gfl8CbmZKwEK3I8Wn2FzAnaoT0HCrAVAB/WNl9M6O7zimkg5Fj4ZglEgdfCSPH8IRs7fADmxmQqe5f3v9xPegi46g8GEDazt/gWeW2BPat6uyVIOPgERPNBrpHvk65JgqDEM5IIxpQUN8LGYUPaiRS45gzdi+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723283296; c=relaxed/simple;
	bh=H/TI4d/I5AjRBE7OwQgTZOyiWIX6fJXl5eHm0V45UsI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XDeUMo6wVMFTQN0dv3GKVrLBIGHeznvbsO9lslfKd4rYunn1D3OyxgkD3zV5oIcecg85RY+DymiM6o4wZ+C9X/vjv4Nvpkf3VkiAeov5NdL/zNeWXF4C2jwXVbQT6btWRxOLCceiLGEmw1zYm4qfhgAUcTQ0/VcCYCLFHeSBc9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wgwnd2dtMz1j6Pj;
	Sat, 10 Aug 2024 17:43:17 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 00DDC1A0188;
	Sat, 10 Aug 2024 17:48:04 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 10 Aug
 2024 17:48:03 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <yuehaibing@huawei.com>,
	<s-vadapalli@ti.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] dmaengine: ti: k3-udma: Remove unused declarations
Date: Sat, 10 Aug 2024 17:45:40 +0800
Message-ID: <20240810094540.2589310-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine users")
declared but never implemented these.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 drivers/dma/ti/k3-udma.h         | 1 -
 include/linux/dma/k3-udma-glue.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index d349c6d482ae..9062a237cd16 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -131,7 +131,6 @@ int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
 struct udma_dev *of_xudma_dev_get(struct device_node *np, const char *property);
 struct device *xudma_get_device(struct udma_dev *ud);
 struct k3_ringacc *xudma_get_ringacc(struct udma_dev *ud);
-void xudma_dev_put(struct udma_dev *ud);
 u32 xudma_dev_get_psil_base(struct udma_dev *ud);
 struct udma_tisci_rm *xudma_dev_get_tisci_rm(struct udma_dev *ud);
 
diff --git a/include/linux/dma/k3-udma-glue.h b/include/linux/dma/k3-udma-glue.h
index 1e491c5dcac2..2dea217629d0 100644
--- a/include/linux/dma/k3-udma-glue.h
+++ b/include/linux/dma/k3-udma-glue.h
@@ -136,8 +136,6 @@ u32 k3_udma_glue_rx_flow_get_fdq_id(struct k3_udma_glue_rx_channel *rx_chn,
 u32 k3_udma_glue_rx_get_flow_id_base(struct k3_udma_glue_rx_channel *rx_chn);
 int k3_udma_glue_rx_get_irq(struct k3_udma_glue_rx_channel *rx_chn,
 			    u32 flow_num);
-void k3_udma_glue_rx_put_irq(struct k3_udma_glue_rx_channel *rx_chn,
-			     u32 flow_num);
 void k3_udma_glue_reset_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
 		u32 flow_num, void *data,
 		void (*cleanup)(void *data, dma_addr_t desc_dma),
-- 
2.34.1


