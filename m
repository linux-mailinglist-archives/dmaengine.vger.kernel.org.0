Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0547509740
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 08:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384688AbiDUGQe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 02:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384687AbiDUGQd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 02:16:33 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410CB13DE1
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 23:13:43 -0700 (PDT)
Received: from pop-os.home ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id hQ4RnnGg8iK8nhQ4Sno46S; Thu, 21 Apr 2022 08:13:41 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 21 Apr 2022 08:13:41 +0200
X-ME-IP: 86.243.180.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Fix the error handling path in idxd_cdev_register()
Date:   Thu, 21 Apr 2022 08:13:38 +0200
Message-Id: <1b5033dcc87b5f2a953c413f0306e883e6114542.1650521591.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If a call to alloc_chrdev_region() fails, the already allocated resources
are leaking.

Add the needed error handling path to fix the leak.

Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/idxd/cdev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index b9b2b4a4124e..033df43db0ce 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -369,10 +369,16 @@ int idxd_cdev_register(void)
 		rc = alloc_chrdev_region(&ictx[i].devt, 0, MINORMASK,
 					 ictx[i].name);
 		if (rc)
-			return rc;
+			goto err_free_chrdev_region;
 	}
 
 	return 0;
+
+err_free_chrdev_region:
+	for (i--; i >= 0; i--)
+		unregister_chrdev_region(ictx[i].devt, MINORMASK);
+
+	return rc;
 }
 
 void idxd_cdev_remove(void)
-- 
2.32.0

