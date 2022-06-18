Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F585504F4
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jun 2022 15:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiFRNEV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Jun 2022 09:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiFRNEV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 18 Jun 2022 09:04:21 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1157BF41;
        Sat, 18 Jun 2022 06:04:16 -0700 (PDT)
X-QQ-mid: bizesmtp86t1655557451tni8bcgo
Received: from localhost.localdomain ( [125.70.163.206])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 18 Jun 2022 21:04:08 +0800 (CST)
X-QQ-SSF: 01000000002000D0I000B00A0000000
X-QQ-FEAT: Adk7n3szVYHr/pIy2iWGziYUhNJCOz7mKoVcCrT6mJ+1vssvxIO7m72Ao+mmQ
        1ABJ5x6Dq3wzYZ0hXRm8JdFrrIEXCibTWDf0ZHHoniizK6p4XpcSwQKopolxuxmMS0odv0U
        eWpWdr+EqtqfSPB39GCBOqvzeHog1fK1tdm2fQKdeFN83ijuwEr0e5ky3AbHJfgdBCxJTiq
        i+AghExOyrWhXAlPj8iBfa3gbuZlm6F9RDRVexgwVicY7bd5wHaiTXH7OZOnwrd7Izp1tmT
        qnKAwvAOsPfWod7AtM+Ed5DpOVIZBN6b0aGwQnuXUoWnhaapaAdImSwdFYerMTgxAU0dNS1
        LnXIKvCMUr6VWe+0iA=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     vkoul@kernel.org
Cc:     ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] dmaengine: at_xdmac: Fix typo in comment
Date:   Sat, 18 Jun 2022 21:03:49 +0800
Message-Id: <20220618130349.11507-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/dma/at_xdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 3e9d726504e2..90cbff44f884 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -649,7 +649,7 @@ static int at_xdmac_compute_chan_conf(struct dma_chan *chan,
 }
 
 /*
- * Only check that maxburst and addr width values are supported by the
+ * Only check that maxburst and addr width values are supported by
  * the controller but not that the configuration is good to perform the
  * transfer since we don't know the direction at this stage.
  */
-- 
2.36.1

