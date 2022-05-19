Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2797D52D3A1
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 15:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbiESNLP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 09:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbiESNLO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 09:11:14 -0400
X-Greylist: delayed 184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 06:11:12 PDT
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [221.176.66.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB48C286EA
        for <dmaengine@vger.kernel.org>; Thu, 19 May 2022 06:11:10 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9])
        by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56286413123c-a8463;
        Thu, 19 May 2022 21:08:03 +0800 (CST)
X-RM-TRANSID: 2ee56286413123c-a8463
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.99])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56286412f650-e91c1;
        Thu, 19 May 2022 21:08:02 +0800 (CST)
X-RM-TRANSID: 2ee56286412f650-e91c1
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     hyun.kwon@xilinx.com, laurent.pinchart@ideasonboard.com,
        vkoul@kernel.org, michal.simek@xilinx.com
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] dmaengine: xilinx_dpdma: Omit superfluous error message in xilinx_dpdma_probe()
Date:   Thu, 19 May 2022 21:08:55 +0800
Message-Id: <20220519130855.7664-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In the function xilinx_dpdma_probe(), when get irq failed,
the function platform_get_irq() logs an error message,
so remove redundant message here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/dma/xilinx/xilinx_dpdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index b0f4948b0..f708808d7 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -1652,10 +1652,8 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
 	dpdma_hw_init(xdev);
 
 	xdev->irq = platform_get_irq(pdev, 0);
-	if (xdev->irq < 0) {
-		dev_err(xdev->dev, "failed to get platform irq\n");
+	if (xdev->irq < 0)
 		return xdev->irq;
-	}
 
 	ret = request_irq(xdev->irq, xilinx_dpdma_irq_handler, IRQF_SHARED,
 			  dev_name(xdev->dev), xdev);
-- 
2.20.1.windows.1



