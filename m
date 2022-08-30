Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F3D5A66D4
	for <lists+dmaengine@lfdr.de>; Tue, 30 Aug 2022 17:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiH3PEl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Aug 2022 11:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiH3PEk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Aug 2022 11:04:40 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432B711B3DC;
        Tue, 30 Aug 2022 08:04:36 -0700 (PDT)
X-QQ-mid: bizesmtp82t1661871870t8iggrns
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 Aug 2022 23:04:05 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: 5mtg6EGDOv7CKWRTCkhsEx4OjHeB+nlND5qgfznMXxB8U9rvwSL64VwrPVm6P
        2FQIDpGOkhxFJW8UfdQNc02o666JTU1stc3/dNVWrhE4tzNwTnMgFZ68n2xyN5EzESDv8Dp
        WZtJbTEHAfJ/roYxUtyVyil5kyEyeaIXe4CVcrc6Z2ClAwWPWWq9hXj0WXgDKgCU0QKM5Qg
        BvkWUQaqo5NPQ8TZJIYSZjSBd75MqZZFpGwBIC9rzCwCvMS3Il3CwkDsTr2gr6to8j6b09a
        gJ1L34lH/bVVlJZBOvQKvtOgBG7y1eJ48Y0hhXnhwXEB3ZcFEfuzQycZ2I+PZJVGi7/XW96
        X7PC00OH3yv7O2ckSiERlO4Ob2IPyA+VOmGppSACRmfJPIbBX8iSWyHoEaEig==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     vkoul@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] maengine: stm32-dmamux: Fix double word in comments
Date:   Tue, 30 Aug 2022 11:04:05 -0400
Message-Id: <20220830150405.23581-1-dengshaomin@cdjrlc.com>
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

Delete the repeated word "end" in stm32-dmamux.c.

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

