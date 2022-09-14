Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4D05B8619
	for <lists+dmaengine@lfdr.de>; Wed, 14 Sep 2022 12:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiINKUD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Sep 2022 06:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiINKUB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Sep 2022 06:20:01 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3816EBB;
        Wed, 14 Sep 2022 03:20:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VPn2uAR_1663150790;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VPn2uAR_1663150790)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 18:19:58 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     peter.ujfalusi@gmail.com
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] dmaengine: ti: edma: Remove some unused functions
Date:   Wed, 14 Sep 2022 18:19:43 +0800
Message-Id: <20220914101943.83929-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

These functions are defined in the edma.c file, but not called elsewhere,
so delete these unused functions.

drivers/dma/ti/edma.c:746:31: warning: unused function 'to_edma_cc'.
drivers/dma/ti/edma.c:420:20: warning: unused function 'edma_param_or'.
drivers/dma/ti/edma.c:414:20: warning: unused function 'edma_param_and'.
drivers/dma/ti/edma.c:402:20: warning: unused function 'edma_param_write'.
drivers/dma/ti/edma.c:373:28: warning: unused function 'edma_shadow0_read'.
drivers/dma/ti/edma.c:396:28: warning: unused function 'edma_param_read'.
drivers/dma/ti/edma.c:355:20: warning: unused function 'edma_or_array'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2152
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/dma/ti/edma.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 4cbca80ee16e..fa06d7e6d8e3 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -352,12 +352,6 @@ static inline void edma_modify_array(struct edma_cc *ecc, int offset, int i,
 	edma_modify(ecc, offset + (i << 2), and, or);
 }
 
-static inline void edma_or_array(struct edma_cc *ecc, int offset, int i,
-				 unsigned or)
-{
-	edma_or(ecc, offset + (i << 2), or);
-}
-
 static inline void edma_or_array2(struct edma_cc *ecc, int offset, int i, int j,
 				  unsigned or)
 {
@@ -370,11 +364,6 @@ static inline void edma_write_array2(struct edma_cc *ecc, int offset, int i,
 	edma_write(ecc, offset + ((i * 2 + j) << 2), val);
 }
 
-static inline unsigned int edma_shadow0_read(struct edma_cc *ecc, int offset)
-{
-	return edma_read(ecc, EDMA_SHADOW0 + offset);
-}
-
 static inline unsigned int edma_shadow0_read_array(struct edma_cc *ecc,
 						   int offset, int i)
 {
@@ -393,36 +382,12 @@ static inline void edma_shadow0_write_array(struct edma_cc *ecc, int offset,
 	edma_write(ecc, EDMA_SHADOW0 + offset + (i << 2), val);
 }
 
-static inline unsigned int edma_param_read(struct edma_cc *ecc, int offset,
-					   int param_no)
-{
-	return edma_read(ecc, EDMA_PARM + offset + (param_no << 5));
-}
-
-static inline void edma_param_write(struct edma_cc *ecc, int offset,
-				    int param_no, unsigned val)
-{
-	edma_write(ecc, EDMA_PARM + offset + (param_no << 5), val);
-}
-
 static inline void edma_param_modify(struct edma_cc *ecc, int offset,
 				     int param_no, unsigned and, unsigned or)
 {
 	edma_modify(ecc, EDMA_PARM + offset + (param_no << 5), and, or);
 }
 
-static inline void edma_param_and(struct edma_cc *ecc, int offset, int param_no,
-				  unsigned and)
-{
-	edma_and(ecc, EDMA_PARM + offset + (param_no << 5), and);
-}
-
-static inline void edma_param_or(struct edma_cc *ecc, int offset, int param_no,
-				 unsigned or)
-{
-	edma_or(ecc, EDMA_PARM + offset + (param_no << 5), or);
-}
-
 static void edma_assign_priority_to_queue(struct edma_cc *ecc, int queue_no,
 					  int priority)
 {
@@ -743,11 +708,6 @@ static void edma_free_channel(struct edma_chan *echan)
 	edma_setup_interrupt(echan, false);
 }
 
-static inline struct edma_cc *to_edma_cc(struct dma_device *d)
-{
-	return container_of(d, struct edma_cc, dma_slave);
-}
-
 static inline struct edma_chan *to_edma_chan(struct dma_chan *c)
 {
 	return container_of(c, struct edma_chan, vchan.chan);
-- 
2.20.1.7.g153144c

