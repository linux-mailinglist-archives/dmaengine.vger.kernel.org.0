Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26083509C07
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 11:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377263AbiDUJYx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 05:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357478AbiDUJYu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 05:24:50 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA4C26559;
        Thu, 21 Apr 2022 02:22:00 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 71A5244E78;
        Thu, 21 Apr 2022 09:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1650532918; x=
        1652347319; bh=rOJ0XVAQ/xdObrmr4EZjjsd3fyHJyaGnzJz9olY/nj8=; b=B
        LOW7iLCyXXf4kW08cBsOrLbITN4KIaWXm09TtJlf9jfcrxM9xV1jkFVFh9+QfTi5
        AAM8mdyAA+rbpvCzA+zi21h/4N2qI+Fxg4/362jdwcswxUncFb4jgj69Y4GYvDpw
        zOBDa//OMCVSLvcQrJFrz7r3mNtmv8e3KKXEKVVb0Q=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0h_BWXo10m-n; Thu, 21 Apr 2022 12:21:58 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id D4BD644E3C;
        Thu, 21 Apr 2022 12:21:50 +0300 (MSK)
Received: from ubuntu.yadro.com (10.199.0.136) by T-EXCH-04.corp.yadro.com
 (172.17.100.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 21
 Apr 2022 12:21:50 +0300
From:   <i.m.novikov@yadro.com>
To:     <vkoul@kernel.org>
CC:     <i.m.novikov@yadro.com>, <sanju.mehta@amd.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@yadro.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] dmaengine: PTDMA: statify pt_tx_status
Date:   Thu, 21 Apr 2022 12:21:43 +0300
Message-ID: <20220421092143.18281-1-i.m.novikov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Ilya Novikov <i.m.novikov@yadro.com>

LKP bot reports a new warning:
Warning:
drivers/dma/ptdma/ptdma-dmaengine.c:262:1: warning: no previous
prototype for 'pt_tx_status' [-Wmissing-prototypes]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ilya Novikov <i.m.novikov@yadro.com>
---
 drivers/dma/ptdma/ptdma-dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
index ea07cc42f4d0..cc22d162ce25 100644
--- a/drivers/dma/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -258,7 +258,7 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
 		pt_cmd_callback(desc, 0);
 }
 
-enum dma_status
+static enum dma_status
 pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 		struct dma_tx_state *txstate)
 {
-- 
2.25.1

