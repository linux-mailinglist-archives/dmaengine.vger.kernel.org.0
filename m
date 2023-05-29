Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBCB71424B
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 05:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjE2DYc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 May 2023 23:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjE2DYb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 May 2023 23:24:31 -0400
Received: from out-37.mta1.migadu.com (out-37.mta1.migadu.com [95.215.58.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF80BB1
        for <dmaengine@vger.kernel.org>; Sun, 28 May 2023 20:24:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685330668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HrRea8JyN4C0qVNp9YvhwrTuvrMqec00lyXuOgrJnAg=;
        b=FLoAOT82LUNh+8YeB20/PYYrGEeG0cUJM7kyi1Qzm6DCphx44+EUwQVhJbBcn5wzrGvkHS
        jQvoQ6H1xex3wP3VPvCk777n94ZY1VZ6LugvQCiEzhOb0t17tZdaVGvo631AB7Ymag81WR
        Pn6BAQvvHk1W2eYKO0LQyOe1R6SDfM8=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     mani@kernel.org, fancer.lancer@gmail.com,
        gustavo.pimentel@synopsys.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cai Huoqing <cai.huoqing@linux.dev>
Subject: [PATCH] MAINTAINERS: Add Cai Huoqing as dw-edma maintainer
Date:   Mon, 29 May 2023 11:24:23 +0800
Message-Id: <20230529032423.11650-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since HDMA mode was merged, including the commits:
commit e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA"),
commit 353d5c241e83 ("dmaengine: dw-edma: Add HDMA DebugFS support"),
I would like to add myself as maintainer of the dw-edma driver
to recive patch for HDMA part. 

I can test HDMA part by our chip and cmodel and do some code review.
I'm active in linux contribution, if possible, I want to
take the dw-edma maintainership.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a0504731524..541601feabd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5881,6 +5881,7 @@ F:	drivers/mtd/nand/raw/denali*
 
 DESIGNWARE EDMA CORE IP DRIVER
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+M:	Cai Huoqing <cai.huoqing@linux.dev>
 R:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 R:	Serge Semin <fancer.lancer@gmail.com>
 L:	dmaengine@vger.kernel.org
-- 
2.34.1

