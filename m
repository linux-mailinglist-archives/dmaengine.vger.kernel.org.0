Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5200576C9F
	for <lists+dmaengine@lfdr.de>; Sat, 16 Jul 2022 10:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiGPIrB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 16 Jul 2022 04:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGPIrA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 16 Jul 2022 04:47:00 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C39732AC51
        for <dmaengine@vger.kernel.org>; Sat, 16 Jul 2022 01:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Ze23J
        HIq0PY4GotmMCcpSUtTGrzVji/CTlj2NzaUdec=; b=ohBBTWh5yJmEKi72zUEOC
        9LUNR5eyhx5OBLWRYy5jFwXhoHR4d17BSK32trVVQhRObMOPtt7aMPLhpxHpDKXb
        zwuDgUx1gS0ljj5Unl6zzSD9WTGy+ddB9MAOSWUgJRF3ryTZcockzRSl5UUYH+de
        7m77d0a853n8pG/ITRSozM=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowAAHNyfzetJidnNXGw--.2003S2;
        Sat, 16 Jul 2022 16:46:44 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     peter.ujfalusi@gmail.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, windhl@126.com
Subject: [PATCH] dmaengine: ti: k3-udma-private: Fix refcount leak bug in of_xudma_dev_get()
Date:   Sat, 16 Jul 2022 16:46:42 +0800
Message-Id: <20220716084642.701268-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowAAHNyfzetJidnNXGw--.2003S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW3XrWkWFyrtr15Ar1rtFb_yoW8Xr4rpF
        95C34S9rWkKr4jkr10va48Z343tw1xtrWYga97A39xZrnxXw1DXr4UXry5urZ8AryrtFW3
        tw1UtFyFkFy8AaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi4rWxUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGhRAF1-HZgl4QgAAsU
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
---

I cannot find the 'k3-udma-private.c' comiple item in drivers/dma/ti/Makefile, 
I wonder if the author has forgotten the compile item and the
k3-udma-private.c has not been compiled before.

I have tried to add k3-udma-private.o in the Makefile, but there are lots of
compile errors.  
Please check it carefully and if possbile please teach me how to compile it, thanks.


 drivers/dma/ti/k3-udma-private.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index d4f1e4e9603a..ec274ef7d5ea 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -31,14 +31,13 @@ struct udma_dev *of_xudma_dev_get(struct device_node *np, const char *property)
 	}
 
 	pdev = of_find_device_by_node(udma_node);
+	if (np != udma_node)
+		of_node_put(udma_node);
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

