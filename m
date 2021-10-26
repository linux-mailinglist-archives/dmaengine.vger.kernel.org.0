Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A2C43AA14
	for <lists+dmaengine@lfdr.de>; Tue, 26 Oct 2021 04:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhJZCHk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 22:07:40 -0400
Received: from mx24.baidu.com ([111.206.215.185]:56146 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230216AbhJZCHk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 22:07:40 -0400
Received: from BC-Mail-Ex26.internal.baidu.com (unknown [172.31.51.20])
        by Forcepoint Email with ESMTPS id 1D7A79FF81B90FB8BF1C;
        Tue, 26 Oct 2021 10:05:15 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex26.internal.baidu.com (172.31.51.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 26 Oct 2021 10:05:14 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 26 Oct 2021 10:05:14 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dmaengine: sa11x0: Mark PM functions as __maybe_unused
Date:   Tue, 26 Oct 2021 10:05:07 +0800
Message-ID: <20211026020508.550-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX08.internal.baidu.com (172.31.51.48) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Without CONFIG_PM_SLEEP, the runtime suspend/resume functions
are unused, producing a warning:

../drivers/dma/sa11x0-dma.c:1042:12: error: 'sa11x0_dma_resume' defined but not used
../drivers/dma/sa11x0-dma.c:1004:12: error: 'sa11x0_dma_suspend' defined but not used

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/dma/sa11x0-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index 38f318b2f80d..a29c13cae716 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -1001,7 +1001,7 @@ static int sa11x0_dma_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int sa11x0_dma_suspend(struct device *dev)
+static __maybe_unused int sa11x0_dma_suspend(struct device *dev)
 {
 	struct sa11x0_dma_dev *d = dev_get_drvdata(dev);
 	unsigned pch;
@@ -1039,7 +1039,7 @@ static int sa11x0_dma_suspend(struct device *dev)
 	return 0;
 }
 
-static int sa11x0_dma_resume(struct device *dev)
+static __maybe_unused int sa11x0_dma_resume(struct device *dev)
 {
 	struct sa11x0_dma_dev *d = dev_get_drvdata(dev);
 	unsigned pch;
-- 
2.25.1

