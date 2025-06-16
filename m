Return-Path: <dmaengine+bounces-5485-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B54ADADBA
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 12:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B843D3A7E45
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 10:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C1D275112;
	Mon, 16 Jun 2025 10:48:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9658713B7AE;
	Mon, 16 Jun 2025 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750070900; cv=none; b=E65N0SEg934ftlWiqJG9W0B6jxZsNtq0xagmBtngPyNm7TLAWna9EtMbuoTOCAS20xYw4hjYRc+lEUrRlkKXeQG89xv8hesomyFV8i/eOqUNREkI1KTOkwWfcv5hIomWUB2napgZjxdHvFi46DRFnbfOHYZEtbwvI0uI5IjQG/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750070900; c=relaxed/simple;
	bh=x5FniQdBF81UjKI7MTU91bNOmr2CkQuBY4UD77/WCV8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jIWoMl+TBL+fr88L2nKGtIJy9I2BXyXLUi40n4UnEx6OoG2WRQvyunx08YDM7Uevh1GO1YH3+L05UroNh4IrXsUd9ov75Vf7v9XIa/pClh8s1Ij5H3rDd/kDZA4aaRPIoeYY0Gk6AzPqYax+DqQCety1Og/tjgqjm6y99QVEMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201609.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202506161848138885;
        Mon, 16 Jun 2025 18:48:13 +0800
Received: from locahost.localdomain.com (10.94.7.47) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server id
 15.1.2507.57; Mon, 16 Jun 2025 18:48:12 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <vireshk@kernel.org>, <andriy.shevchenko@linux.intel.com>,
	<vkoul@kernel.org>, <miquel.raynal@bootlin.com>,
	<ilpo.jarvinen@linux.intel.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] dmaengine: dw: dmamux: Add NULL check in rzn1_dmamux_route_allocate()
Date: Mon, 16 Jun 2025 18:48:10 +0800
Message-ID: <20250616104810.2222-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20256161848136ebfb9d244cae38bcdbb2842ebaab288
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The function of_find_device_by_node() may return NULL if the device
node cannot be found or CONFIG_OF is not defined, dereferencing
it without NULL check may lead to NULL dereference.
Add a check to verify whether the return value is NULL.

Fixes: 134d9c52fca2 ("dmaengine: dw: dmamux: Introduce RZN1 DMA router support")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/dma/dw/rzn1-dmamux.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw/rzn1-dmamux.c b/drivers/dma/dw/rzn1-dmamux.c
index 4fb8508419db..a21623d98e41 100644
--- a/drivers/dma/dw/rzn1-dmamux.c
+++ b/drivers/dma/dw/rzn1-dmamux.c
@@ -41,13 +41,19 @@ static void rzn1_dmamux_free(struct device *dev, void *route_data)
 static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 					struct of_dma *ofdma)
 {
-	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
-	struct rzn1_dmamux_data *dmamux = platform_get_drvdata(pdev);
+	struct platform_device *pdev;
+	struct rzn1_dmamux_data *dmamux;
 	struct rzn1_dmamux_map *map;
 	unsigned int dmac_idx, chan, val;
 	u32 mask;
 	int ret;
 
+	pdev = of_find_device_by_node(ofdma->of_node);
+	if (!pdev)
+		return ERR_PTR(-ENODEV);
+
+	dmamux = platform_get_drvdata(pdev);
+
 	if (dma_spec->args_count != RNZ1_DMAMUX_NCELLS)
 		return ERR_PTR(-EINVAL);
 
-- 
2.43.0


