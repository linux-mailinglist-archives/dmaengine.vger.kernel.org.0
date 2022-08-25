Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CDB5A14CF
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 16:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241890AbiHYOtH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Aug 2022 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241031AbiHYOtG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Aug 2022 10:49:06 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A295FB2865
        for <dmaengine@vger.kernel.org>; Thu, 25 Aug 2022 07:49:03 -0700 (PDT)
X-QQ-mid: bizesmtp85t1661438938tnq9k2mq
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 Aug 2022 22:48:52 +0800 (CST)
X-QQ-SSF: 01000000002000B0B000B00A0000000
X-QQ-FEAT: ExN6mnmVozCHB9rzUJb2bWcWCbvtjCTYCWTJXH3HIWPzPaXyrdnXDCQcn5aYk
        HoSJ0JImuqB4hwQw8WfqNcB/ZHns5PpfwE0m3/ta1Qzj1WiaEHgnQiSGJ6PH7ksRWG8HG/X
        GKiVmZNkNg+yFsrQmAxsmVpJi20EuLElPtFtRNpoRcmID53WVtt1t7beBSRgMCgRYJKbhPB
        3nLlgqcb4Slerd7XUIqCHa/etk01KEq5j4CuW3Ig1pP7w4u3k/Ygf8VoAYdIphVJLBcWqQo
        /+IjSBffUjdseQtOxFjli5Wraaqgs22lpt8qQoPNZEYp6wXv7Y8N0+3wmuwMa3LLeqYlMJB
        0MTTC6eY5CqAaZvaNYi1vav9e5g3QR5nBzgCWAWxHoI5MnjSdOS3sYVwVhNvFs+wh7R0gJ/
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     vkoul@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, dmaengine@vger.kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] dmaengine: stm32-dmamux: Fix comments typo
Date:   Thu, 25 Aug 2022 10:48:51 -0400
Message-Id: <20220825144851.4490-1-dengshaomin@cdjrlc.com>
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

Fix the double word "end" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/dma/stm32-dmamux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index eee0c5aa5fb5..ca18dee3ccc0 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -45,7 +45,7 @@ struct stm32_dmamux_data {
 						 */
 	u32 dma_reqs[]; /* Number of DMA Request per DMA masters.
 			 *  [0] holds number of DMA Masters.
-			 *  To be kept at very end end of this structure
+			 *  To be kept at very end of this structure
 			 */
 };
 
-- 
2.35.1

