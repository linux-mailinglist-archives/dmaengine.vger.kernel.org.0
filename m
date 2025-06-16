Return-Path: <dmaengine+bounces-5480-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FAFADA7E9
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 08:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32083188E442
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 06:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA1F111AD;
	Mon, 16 Jun 2025 06:02:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96DD20ED;
	Mon, 16 Jun 2025 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750053757; cv=none; b=F9fuN0mTJ8xuxXui1SEhzv/dq+k1uIAxMq7fBWSqjIXb14Lht93sNir/P5VH29ShW0joqxZO/VA6iHqxFP/Q87+JrDzIPXWTjfCvNljNKJNt9UBML6UOiF5bH4cib9L5tflzGcgByIuJjcGzJVsxszTJHtWte2pzoXXBq/VCd4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750053757; c=relaxed/simple;
	bh=3dzi+DuJW/eGwwI89boACf0v3cJ4I7ZAMLTr2wvjUog=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nAoZOIdzt0t7d63JkzPXLXaRYHkx6BGQrrhEt2MDZ/telEbmuinIQ84Go2Q9EmM4nt5g7bKcKV3/9bQUJiIYiM45JT4a/3JUhx0TfBhO/bR+oJXyW1TxrlOhqdrVMplsOv5O/6T37/sB6RXAGifOHvClJMOMqsokt0vxx1NkKjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201611.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202506161402218282;
        Mon, 16 Jun 2025 14:02:21 +0800
Received: from locahost.localdomain.com (10.94.7.110) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server id
 15.1.2507.57; Mon, 16 Jun 2025 14:02:20 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <vkoul@kernel.org>, <vz@mleia.com>, <manabian@gmail.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] dmaengine: Add NULL check in lpc18xx_dmamux_reserve()
Date: Mon, 16 Jun 2025 14:02:12 +0800
Message-ID: <20250616060212.1560-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025616140221cf4a46ee16339d92f0bdbd1e77ac196c
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The function of_find_device_by_node() may return NULL if the device
node is not found or CONFIG_OF not defined.
Add  check whether the return value is NULL and set the error code
to be returned as -ENODEV.

Fixes: e5f4ae84be74 ("dmaengine: add driver for lpc18xx dmamux")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/dma/lpc18xx-dmamux.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/lpc18xx-dmamux.c b/drivers/dma/lpc18xx-dmamux.c
index 2b6436f4b193..ef9aed4ba173 100644
--- a/drivers/dma/lpc18xx-dmamux.c
+++ b/drivers/dma/lpc18xx-dmamux.c
@@ -53,11 +53,16 @@ static void lpc18xx_dmamux_free(struct device *dev, void *route_data)
 static void *lpc18xx_dmamux_reserve(struct of_phandle_args *dma_spec,
 				    struct of_dma *ofdma)
 {
-	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
-	struct lpc18xx_dmamux_data *dmamux = platform_get_drvdata(pdev);
 	unsigned long flags;
 	unsigned mux;
 
+	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
+
+	if (!pdev)
+		return ERR_PTR(-ENODEV);
+
+	struct lpc18xx_dmamux_data *dmamux = platform_get_drvdata(pdev);
+
 	if (dma_spec->args_count != 3) {
 		dev_err(&pdev->dev, "invalid number of dma mux args\n");
 		return ERR_PTR(-EINVAL);
-- 
2.43.0


