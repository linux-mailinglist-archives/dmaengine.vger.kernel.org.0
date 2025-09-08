Return-Path: <dmaengine+bounces-6426-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AF4B48D96
	for <lists+dmaengine@lfdr.de>; Mon,  8 Sep 2025 14:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E097A2195
	for <lists+dmaengine@lfdr.de>; Mon,  8 Sep 2025 12:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB94B2E7BA7;
	Mon,  8 Sep 2025 12:33:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216AE1EB5B;
	Mon,  8 Sep 2025 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334786; cv=none; b=ltqTjfdFmVkntiKFP7iy6UQVGhuB6OKkvpB8J2J0xH5kPOJnT51VhO3l3wCJXI3i5M0tNKp9Y19bfE6VMg+6SD9HZ9a+5ZQV5pgvyxXbrWVZ6mu08NbC89aLkfFJcUnR3n2T67KXVfCUX8dEswF2bi/2Usg+gOG/GtI1/jNkdX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334786; c=relaxed/simple;
	bh=BKg4H9nK6xetSrB+Afl1BMmTduUEIwRyxICyGKhQulA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DgftW+fahsOWYoH5XzQN1pRdj+g0NHoT426OvVNhdDZ6DnwMO2HFhhzgIa/23kbbyveoJ80k6g4ghwbPzQJKG7/KAaOYu2/DGgqIwmXvRe4sHp9VHdBxo/Hq2ltdjOycVfJNgmlUzZAJzSbw7VSOJS/4o9UWXh04McWCP8sSamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cL5vM60s0z14N1k;
	Mon,  8 Sep 2025 20:32:47 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D4CC180488;
	Mon,  8 Sep 2025 20:33:00 +0800 (CST)
Received: from kwepemq500007.china.huawei.com (7.202.195.21) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Sep 2025 20:33:00 +0800
Received: from huawei.com (10.67.174.117) by kwepemq500007.china.huawei.com
 (7.202.195.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 8 Sep
 2025 20:32:59 +0800
From: Lin Yujun <linyujun809@h-partners.com>
To: <lizhi.hou@amd.com>, <brian.xu@amd.com>, <raj.kumar.rampelli@amd.com>,
	<vkoul@kernel.org>, <michal.simek@amd.com>, <sonal.santan@amd.com>,
	<max.zhen@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] dmaengine: Fix incorrect handling for return value of devm_regmap_init_mmio.
Date: Mon, 8 Sep 2025 20:22:06 +0800
Message-ID: <20250908122206.1315473-1-linyujun809@h-partners.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500007.china.huawei.com (7.202.195.21)

The devm_regmap_init_mmio() is described as follows:
"The return value will be an ERR_PTR() on error or a valid pointer"
Use IS_ERR() to fix incorrect handling return value
of devm_regmap_init_mmio.

Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
Signed-off-by: Lin Yujun <linyujun809@h-partners.com>
---
 drivers/dma/xilinx/xdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 0d88b1a670e1..5db8f077dcc0 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -1234,11 +1234,11 @@ static int xdma_probe(struct platform_device *pdev)
 		goto failed;
 	}
 
 	xdev->rmap = devm_regmap_init_mmio(&pdev->dev, reg_base,
 					   &xdma_regmap_config);
-	if (!xdev->rmap) {
+	if (IS_ERR(xdev->rmap)) {
 		xdma_err(xdev, "config regmap failed: %d", ret);
 		goto failed;
 	}
 	INIT_LIST_HEAD(&xdev->dma_dev.channels);
 
-- 
2.34.1


