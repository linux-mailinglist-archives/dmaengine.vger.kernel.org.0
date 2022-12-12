Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B858B649842
	for <lists+dmaengine@lfdr.de>; Mon, 12 Dec 2022 04:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiLLDfc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 11 Dec 2022 22:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiLLDfb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 11 Dec 2022 22:35:31 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3124B493;
        Sun, 11 Dec 2022 19:35:29 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=0;PH=DS;RN=7;SR=0;TI=SMTPD_---0VX16Mju_1670816116;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VX16Mju_1670816116)
          by smtp.aliyun-inc.com;
          Mon, 12 Dec 2022 11:35:27 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     fenghua.yu@intel.com
Cc:     dave.jiang@intel.com, vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] dmaengine: idxd: Remove the unused function set_completion_address()
Date:   Mon, 12 Dec 2022 11:35:14 +0800
Message-Id: <20221212033514.5831-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The function set_completion_address is defined in the dma.c file, but not
called elsewhere, so remove this unused function.

drivers/dma/idxd/dma.c:66:20: warning: unused function 'set_completion_address'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3416
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/dma/idxd/dma.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index e0874cb4721c..eb35ca313684 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -63,12 +63,6 @@ static void op_flag_setup(unsigned long flags, u32 *desc_flags)
 		*desc_flags |= IDXD_OP_FLAG_RCI;
 }
 
-static inline void set_completion_address(struct idxd_desc *desc,
-					  u64 *compl_addr)
-{
-		*compl_addr = desc->compl_dma;
-}
-
 static inline void idxd_prep_desc_common(struct idxd_wq *wq,
 					 struct dsa_hw_desc *hw, char opcode,
 					 u64 addr_f1, u64 addr_f2, u64 len,
-- 
2.20.1.7.g153144c

