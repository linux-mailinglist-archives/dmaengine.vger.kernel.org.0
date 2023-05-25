Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D40F71087A
	for <lists+dmaengine@lfdr.de>; Thu, 25 May 2023 11:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjEYJQo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 May 2023 05:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEYJQn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 May 2023 05:16:43 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04EDA7;
        Thu, 25 May 2023 02:16:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VjRf0H8_1685006198;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VjRf0H8_1685006198)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 17:16:39 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, okaya@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] dmaengine: hidma: Fix cast to smaller integer type warning
Date:   Thu, 25 May 2023 17:16:37 +0800
Message-Id: <20230525091637.62315-1-yang.lee@linux.alibaba.com>
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

Fix the following warning:
drivers/dma/qcom/hidma.c:748:8: warning: cast to smaller integer type 'enum hidma_cap' from 'const void *'

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/dma/qcom/hidma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 344525c3a32f..0165e2fa7be4 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -745,7 +745,7 @@ static bool hidma_test_capability(struct device *dev, enum hidma_cap test_cap)
 {
 	enum hidma_cap cap;
 
-	cap = (enum hidma_cap) device_get_match_data(dev);
+	cap = (unsigned long) device_get_match_data(dev);
 	return cap ? ((cap & test_cap) > 0) : 0;
 }
 
-- 
2.20.1.7.g153144c

