Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248DE57B1CF
	for <lists+dmaengine@lfdr.de>; Wed, 20 Jul 2022 09:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbiGTHcx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Jul 2022 03:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiGTHcw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Jul 2022 03:32:52 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBF38675BC
        for <dmaengine@vger.kernel.org>; Wed, 20 Jul 2022 00:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ElsLS
        6cbojx86fSptXjJY9RoFxAg9UsxhI26jmFc1yc=; b=d+TCQbKMElnRoU/99Mzmp
        QPDyqQEVZRCHUzOsqZWgYFQDe6A9oeHpk22Zq0V1/YoAhBAVjV2pnT7fyyiAMH68
        LabeXv6aMTDipYyuezDeIDH3tPHP+RbcL6WVF8z4pYTNQn1qfpPLfp5hGykjLVlj
        WfiA47XzLgNeLka5Vgjwdk=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowABHifiSr9diwqBsFQ--.21270S2;
        Wed, 20 Jul 2022 15:32:35 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     peter.ujfalusi@gmail.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, windhl@126.com
Subject: [PATCH v2] dmaengine: ti: k3-udma-private: Fix refcount leak bug in  of_xudma_dev_get()
Date:   Wed, 20 Jul 2022 15:32:34 +0800
Message-Id: <20220720073234.1255474-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowABHifiSr9diwqBsFQ--.21270S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW3XrWkWFyruF47WryfJFb_yoW8Gryfpa
        n7C3yS9r97Kr1UCr109a48Zry3tF1xKrWYgayIywnxZrsxXw1UXry0qry5uws8AFyrKF43
        tw1Uta4FvFy8Z3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi4lkfUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BREF1pED9DTRwAAsO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We should call of_node_put() for the reference returned by
of_parse_phandle() in fail path or when it is not used anymore.
Here we only need to move the of_node_put() before the check.

Fixes: d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine users")
Signed-off-by: Liang He <windhl@126.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 changelog:

 v2: (1) add blank line based on Peter's advice
     (2) successfully compile the code based on Peter's explaination

 v1: https://lore.kernel.org/all/20220716084642.701268-1-windhl@126.com/

 drivers/dma/ti/k3-udma-private.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index d4f1e4e9603a..85e00701473c 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -31,14 +31,14 @@ struct udma_dev *of_xudma_dev_get(struct device_node *np, const char *property)
 	}
 
 	pdev = of_find_device_by_node(udma_node);
+	if (np != udma_node)
+		of_node_put(udma_node);
+
 	if (!pdev) {
 		pr_debug("UDMA device not found\n");
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-	if (np != udma_node)
-		of_node_put(udma_node);
-
 	ud = platform_get_drvdata(pdev);
 	if (!ud) {
 		pr_debug("UDMA has not been probed\n");
-- 
2.25.1

