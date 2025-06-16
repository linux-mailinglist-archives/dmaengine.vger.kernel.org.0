Return-Path: <dmaengine+bounces-5483-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42432ADADA5
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 12:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E647716341A
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 10:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9802926F471;
	Mon, 16 Jun 2025 10:44:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFB71DDC23;
	Mon, 16 Jun 2025 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750070672; cv=none; b=o3kPOsJVtUc2GdhGQPsWozhaLliXyL2e0X9+H47hvXN02pbXCkp8rAZPbvCNCV4DWwxm+iadKOKENSFmnjbWWkiw/N+5R/of39moC4wxwDZtJ6bDAOsf4kd41uUjqmZlXzO8FsC3hfydCGqrcDPtq72zXxDiHal3dtx9IfkeNH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750070672; c=relaxed/simple;
	bh=LgglmT9a5i4f+e3Hdc2uHkjad54ebIatzamizH+LMFE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ob19OYCEYimNqA2cakBBJFPFTSqYxsPakCDp75ZE6yFHxAwWryo2OJE+4KccqZOSSAZHPj35JCnx1qXm/z+ur5XecmQ3Maqz4MXZ10qFcPVEf0A9j9nJiZIF6uAWYtU8hi0tXl0tymCFgZAHakTWzybQ7+/rGj7RDU9d1jwklIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201609.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202506161844237586;
        Mon, 16 Jun 2025 18:44:23 +0800
Received: from locahost.localdomain.com (10.94.7.47) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server id
 15.1.2507.57; Mon, 16 Jun 2025 18:44:22 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <eugen.hristev@linaro.org>, <vkoul@kernel.org>, <vz@mleia.com>,
	<manabian@gmail.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH V2] dmaengine: Add NULL check in lpc18xx_dmamux_reserve()
Date: Mon, 16 Jun 2025 18:44:19 +0800
Message-ID: <20250616104420.1720-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025616184423c1b5f9bdf3a34ef1958d2b3d4c38fecf
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
 drivers/dma/lpc18xx-dmamux.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/lpc18xx-dmamux.c b/drivers/dma/lpc18xx-dmamux.c
index 2b6436f4b193..f61183a1d0ba 100644
--- a/drivers/dma/lpc18xx-dmamux.c
+++ b/drivers/dma/lpc18xx-dmamux.c
@@ -53,11 +53,17 @@ static void lpc18xx_dmamux_free(struct device *dev, void *route_data)
 static void *lpc18xx_dmamux_reserve(struct of_phandle_args *dma_spec,
 				    struct of_dma *ofdma)
 {
-	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
-	struct lpc18xx_dmamux_data *dmamux = platform_get_drvdata(pdev);
+	struct platform_device *pdev;
+	struct lpc18xx_dmamux_data *dmamux;
 	unsigned long flags;
 	unsigned mux;
 
+	pdev = of_find_device_by_node(ofdma->of_node);
+	if (!pdev)
+		return ERR_PTR(-ENODEV);
+
+	dmamux = platform_get_drvdata(pdev);
+
 	if (dma_spec->args_count != 3) {
 		dev_err(&pdev->dev, "invalid number of dma mux args\n");
 		return ERR_PTR(-EINVAL);
-- 
2.43.0


