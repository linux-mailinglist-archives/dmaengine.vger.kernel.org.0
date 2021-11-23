Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D457C45AE72
	for <lists+dmaengine@lfdr.de>; Tue, 23 Nov 2021 22:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhKWV3b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Nov 2021 16:29:31 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:62507 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbhKWV3a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Nov 2021 16:29:30 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id pdIymJBJ3BazopdIymCJZ0; Tue, 23 Nov 2021 22:26:20 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 23 Nov 2021 22:26:20 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dmaengine: sh: Use bitmap_zalloc() when applicable
Date:   Tue, 23 Nov 2021 22:26:18 +0100
Message-Id: <3efaf2784424ae3d7411dc47f8b6b03e7bb8c059.1637702701.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

'shdma_slave_used' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
improve the semantic and avoid some open-coded arithmetic in allocator
arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/sh/shdma-base.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 7f72b3f4cd1a..0a2eb5f5a6e8 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -1042,9 +1042,7 @@ EXPORT_SYMBOL(shdma_cleanup);
 
 static int __init shdma_enter(void)
 {
-	shdma_slave_used = kcalloc(DIV_ROUND_UP(slave_num, BITS_PER_LONG),
-				   sizeof(long),
-				   GFP_KERNEL);
+	shdma_slave_used = bitmap_zalloc(slave_num, GFP_KERNEL);
 	if (!shdma_slave_used)
 		return -ENOMEM;
 	return 0;
@@ -1053,7 +1051,7 @@ module_init(shdma_enter);
 
 static void __exit shdma_exit(void)
 {
-	kfree(shdma_slave_used);
+	bitmap_free(shdma_slave_used);
 }
 module_exit(shdma_exit);
 
-- 
2.30.2

