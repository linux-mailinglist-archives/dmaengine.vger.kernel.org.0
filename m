Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585BA71FE9
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2019 21:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfGWTIA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Jul 2019 15:08:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:1069 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfGWTIA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 23 Jul 2019 15:08:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 12:08:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,300,1559545200"; 
   d="scan'208";a="321094484"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 23 Jul 2019 12:07:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F089281; Tue, 23 Jul 2019 22:07:57 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] dmaengine: stm32-dmamux: Switch to use device_property_count_u32()
Date:   Tue, 23 Jul 2019 22:07:56 +0300
Message-Id: <20190723190757.67351-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use use device_property_count_u32() directly, that makes code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/stm32-dmamux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index b552949da14b..3c89bd39e096 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -185,8 +185,7 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 	if (!node)
 		return -ENODEV;
 
-	count = device_property_read_u32_array(&pdev->dev, "dma-masters",
-					       NULL, 0);
+	count = device_property_count_u32(&pdev->dev, "dma-masters");
 	if (count < 0) {
 		dev_err(&pdev->dev, "Can't get DMA master(s) node\n");
 		return -ENODEV;
-- 
2.20.1

