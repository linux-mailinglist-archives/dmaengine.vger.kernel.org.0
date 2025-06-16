Return-Path: <dmaengine+bounces-5484-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7BAADADB0
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 12:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0DA188CD97
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 10:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AADA27A133;
	Mon, 16 Jun 2025 10:46:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C20727F00A;
	Mon, 16 Jun 2025 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750070809; cv=none; b=qTnarwkOPkVfs08WdAOOjPl3IMokVgRJF/58zyOJiVF3YGtgeBVoYyilZ+klCyeuNis3+KGyTFE4UsarCdm7cxCrMIFSHxYMuKJAsypibhkH09x1FWxztsnoAntfJ7fL6Vpwlp4TeGTxQ8MR2xUQnjjUFGRhi7kUdi3EDBPco40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750070809; c=relaxed/simple;
	bh=jsyFZB5Fr/EB0pLhs8+GaPSAzMA1fHzvdzfQK45PG0Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T+A53Li74eBJz0sXMBM0dHGBjfu8jSPG7QJN8cTe1gch2JE5n/vzqzTqSIf2MDN3VHBxY9MmXe875bqK3amR7tK8aImMzQT97A6wswWrmRgvxqao82ynIWdIGVXMIpW/SIjh6KCLGI6nM5B5ld2ppFTt190zwuC9CRzdV6K8NUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201609.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202506161846428300;
        Mon, 16 Jun 2025 18:46:42 +0800
Received: from locahost.localdomain.com (10.94.7.47) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server id
 15.1.2507.57; Mon, 16 Jun 2025 18:46:41 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <vkoul@kernel.org>, <vz@mleia.com>, <piotr.wojtaszczyk@timesys.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] dmaengine: Add NULL check in lpc32xx_dmamux_reserve()
Date: Mon, 16 Jun 2025 18:46:39 +0800
Message-ID: <20250616104639.1935-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20256161846422d0a45c691b7d8b77f613f0ad9ce8be6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The function of_find_device_by_node() may return NULL if the device
node cannot be found or if CONFIG_OF is not defined, dereferencing
it without NULL check may lead to NULL dereference.
Add a check to verify whether the return value is NULL.

Fixes: 5d318b595982 ("dmaengine: Add dma router for pl08x in LPC32XX SoC")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/dma/lpc32xx-dmamux.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/lpc32xx-dmamux.c b/drivers/dma/lpc32xx-dmamux.c
index 351d7e23e615..6dc67d2f3335 100644
--- a/drivers/dma/lpc32xx-dmamux.c
+++ b/drivers/dma/lpc32xx-dmamux.c
@@ -90,13 +90,20 @@ static void lpc32xx_dmamux_release(struct device *dev, void *route_data)
 static void *lpc32xx_dmamux_reserve(struct of_phandle_args *dma_spec,
 				    struct of_dma *ofdma)
 {
-	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
-	struct device *dev = &pdev->dev;
-	struct lpc32xx_dmamux_data *dmamux = platform_get_drvdata(pdev);
+	struct platform_device *pdev;
+	struct device *dev;
+	struct lpc32xx_dmamux_data *dmamux;
 	unsigned long flags;
 	struct lpc32xx_dmamux *mux = NULL;
 	int i;
 
+	pdev = of_find_device_by_node(ofdma->of_node);
+	if (!pdev)
+		return ERR_PTR(-ENODEV);
+
+	dev = &pdev->dev;
+	dmamux = platform_get_drvdata(pdev);
+
 	if (dma_spec->args_count != 3) {
 		dev_err(&pdev->dev, "invalid number of dma mux args\n");
 		return ERR_PTR(-EINVAL);
-- 
2.43.0


