Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A453458FBEE
	for <lists+dmaengine@lfdr.de>; Thu, 11 Aug 2022 14:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbiHKMKV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Aug 2022 08:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiHKMKU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Aug 2022 08:10:20 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99AB5466C;
        Thu, 11 Aug 2022 05:10:18 -0700 (PDT)
X-QQ-mid: bizesmtp84t1660219808t257rave
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 20:10:06 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: BlCEEhbwceZ42iDDS+I2K7ro8/+dFD8sE1sTUHBVmhgwuWhcj0cbasPVVbJor
        Qs3xKyCCpBzHh/keBR+fbW5nZvbZaXWuLzsfkY2uPvw7W3SeDA5sFdG5jxS002eCS+yLIfB
        p2vQWb9UNzrga+EJzXNcH+7ypDa/Y1ATrVWHVBo2fctEYIxjrks5t68Y7a97MAl+KNeCr/d
        8Tm0AfswwCu19trE4ZHVO/jylTiESaBv2vV5Z397ZUV6yPZ9wwGW3rY2mJRg/r1+l51NTXe
        P+znsBJa1dY9pwTCRZUUg+PMDAKV1l09HrNxXwJdol25pw5JRcQHW4iN2rcWY23gc1yv07h
        MkKlKrcTjf2z/cOHYX013yXgTGqKW8jDkNj65e59WrYo0G01z5eEbYs4xk9PSrsPEZLPaFK
        RbmmTn4KOlE=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mcoquelin.stm32@gmail.com
Cc:     vkoul@kernel.org, alexandre.torgue@foss.st.com,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] dmaengine: stm32-dmamux: Fix comment typo
Date:   Thu, 11 Aug 2022 20:09:59 +0800
Message-Id: <20220811120959.18752-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The double `end' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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
2.36.1

