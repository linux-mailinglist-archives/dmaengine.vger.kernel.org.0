Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BCF5A14C1
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 16:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiHYOp7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Aug 2022 10:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241756AbiHYOp6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Aug 2022 10:45:58 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8795B0B28;
        Thu, 25 Aug 2022 07:45:56 -0700 (PDT)
X-QQ-mid: bizesmtp87t1661438752tbdd92on
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 Aug 2022 22:45:46 +0800 (CST)
X-QQ-SSF: 01000000002000B0B000B00A0000000
X-QQ-FEAT: SN3wGuzO13GaP+3CyY0sa7p2Us4IBkqD6l5/BggaS9VGmXD61pxn/lcCtP7zU
        8tmPFhsl6Fbq0yuuZmYstTobwONn6q0GY8uY8WfRF14AKg/UHsU8G9ZJNfHjke4EcMi+cmE
        bn0QRjUetRTbLpSODQWnslaLDpOlhck8iqis1fk3HR2nFeWb9u8i34fuadX9SBDHuuuemlp
        JglFR7Z8PW3roM486s9WXktgLh9lh0mntX24t3A4ax0/rj4jRZAL8efnzVSOLgi8FOVDkn9
        G+oPO+7vsF1bEB4ouIXEXllEZbS7LFgwTab3chY+OaAKTJCLezSsSpjiv6WT27nGMlQ7Xbv
        svltKSJSDsCsT60pgQlwqsRLtu4C1T9wKyn02eCbrZRhHlFZGK7FnFTHeEyJOi0JrljMZpf
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     krzysztof.kozlowski@linaro.org, vkoul@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     alim.akhtar@samsung.com, Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH]  dmaengine: virt-dma: Fix double word in comments
Date:   Thu, 25 Aug 2022 10:45:45 -0400
Message-Id: <20220825144545.3528-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Delete the double word "many" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/dma/s3c24xx-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index 8e14c72d03f0..2298cc5bed41 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -1094,7 +1094,7 @@ static int s3c24xx_dma_init_virtual_channels(struct s3c24xx_dma_engine *s3cdma,
 	INIT_LIST_HEAD(&dmadev->channels);
 
 	/*
-	 * Register as many many memcpy as we have physical channels,
+	 * Register as many memcpy as we have physical channels,
 	 * we won't always be able to use all but the code will have
 	 * to cope with that situation.
 	 */
-- 
2.35.1

