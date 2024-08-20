Return-Path: <dmaengine+bounces-2920-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B079587FB
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2024 15:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CF11F2250B
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2024 13:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CE218A6D1;
	Tue, 20 Aug 2024 13:31:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538A71AACB;
	Tue, 20 Aug 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160677; cv=none; b=fQX0ZrkD5qjZIfQhmRPX5H0wlhAqJUQe0K9Yf0b8H6QEli+TPvXc7SwapJslo4M7odYHKv+ytd4j5dQdBT3VAQ47dkZ2oyV9Gb76vqoOs11HEFOBA4qYM8+WVV35ivUJGTxDk28V+VzrOxW1Kjx53KLFvS3LnPG6v+Pf6jgLZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160677; c=relaxed/simple;
	bh=DJc9hc6gCqzJBBus8OoCrIRCsEW8p58OR+4+pW29R9I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TTmqjCJuO34+aOSi+6bIq2iNYCVudrdm19VHo/fLlLYEZ6Oy2HOMz/Qp5ENDOzNsDQardfmZy8sEE+KUFfAN3QCrhwkxE9J38b5LW5WeC1xzhzzyl1GAnDFfEkqW9zWL1ZkHQUtY8kluoFJomhSckrxDEwC0FaKALrqtxc4v+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wp9GD1v8pz1j6q1;
	Tue, 20 Aug 2024 21:26:12 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id EC1E51401F4;
	Tue, 20 Aug 2024 21:31:11 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Aug
 2024 21:31:11 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <lizhi.hou@amd.com>, <brian.xu@amd.com>, <raj.kumar.rampelli@amd.com>,
	<vkoul@kernel.org>, <michal.simek@amd.com>, <sonal.santan@amd.com>,
	<max.zhen@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] dmaengine: xilinx: xdma: Fix NULL vs IS_ERR() bug
Date: Tue, 20 Aug 2024 21:28:27 +0800
Message-ID: <20240820132827.52108-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

devm_regmap_init_mmio() never returns NULL pointer, it will
return ERR_PTR() when it fails, so check it with IS_ERR().

Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/dma/xilinx/xdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 718842fdaf98..44fae351f0a0 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -1240,7 +1240,8 @@ static int xdma_probe(struct platform_device *pdev)
 
 	xdev->rmap = devm_regmap_init_mmio(&pdev->dev, reg_base,
 					   &xdma_regmap_config);
-	if (!xdev->rmap) {
+	if (IS_ERR(xdev->rmap)) {
+		ret = PTR_ERR(xdev->rmap);
 		xdma_err(xdev, "config regmap failed: %d", ret);
 		goto failed;
 	}
-- 
2.34.1


