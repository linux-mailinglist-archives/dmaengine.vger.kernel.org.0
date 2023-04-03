Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA906D4CBD
	for <lists+dmaengine@lfdr.de>; Mon,  3 Apr 2023 17:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjDCPz1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Apr 2023 11:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjDCPzN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Apr 2023 11:55:13 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C64844AC;
        Mon,  3 Apr 2023 08:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1680536901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=beF+K1NHWP/zsnX7POz8yyiiOBr7zCFi5ikb61FvcI4=;
        b=rEQlu75pE1XlxvEiW2Vp6Q2DrJqFlXQRWGAGO/qViDKRDquUpd4KRJ2jtCkCphUkqIMmkc
        kCibghuDBjplYnoTYkLj+VJLDOiOKickpRJaP+TywS3SWmlYLN2xIf8YpVNxnxU3wY3Pj7
        8OG7sKOHPKMOxagqrUvT8h8+0YtaZik=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 08/11] iio: buffer-dma: split iio_dma_buffer_fileio_free() function
Date:   Mon,  3 Apr 2023 17:47:57 +0200
Message-Id: <20230403154800.215924-9-paul@crapouillou.net>
In-Reply-To: <20230403154800.215924-1-paul@crapouillou.net>
References: <20230403154800.215924-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

This change splits the logic into a separate function, which will be
re-used later.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 43 +++++++++++---------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 86eced458236..e14814e0d4c8 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -374,6 +374,29 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL_GPL(iio_dma_buffer_request_update);
 
+static void iio_dma_buffer_fileio_free(struct iio_dma_buffer_queue *queue)
+{
+	unsigned int i;
+
+	spin_lock_irq(&queue->list_lock);
+	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
+		if (!queue->fileio.blocks[i])
+			continue;
+		queue->fileio.blocks[i]->state = IIO_BLOCK_STATE_DEAD;
+	}
+	spin_unlock_irq(&queue->list_lock);
+
+	INIT_LIST_HEAD(&queue->incoming);
+
+	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
+		if (!queue->fileio.blocks[i])
+			continue;
+		iio_buffer_block_put(queue->fileio.blocks[i]);
+		queue->fileio.blocks[i] = NULL;
+	}
+	queue->fileio.active_block = NULL;
+}
+
 static void iio_dma_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 	struct iio_dma_buffer_block *block)
 {
@@ -695,27 +718,9 @@ EXPORT_SYMBOL_GPL(iio_dma_buffer_init);
  */
 void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue)
 {
-	unsigned int i;
-
 	mutex_lock(&queue->lock);
 
-	spin_lock_irq(&queue->list_lock);
-	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
-		if (!queue->fileio.blocks[i])
-			continue;
-		queue->fileio.blocks[i]->state = IIO_BLOCK_STATE_DEAD;
-	}
-	spin_unlock_irq(&queue->list_lock);
-
-	INIT_LIST_HEAD(&queue->incoming);
-
-	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
-		if (!queue->fileio.blocks[i])
-			continue;
-		iio_buffer_block_put(queue->fileio.blocks[i]);
-		queue->fileio.blocks[i] = NULL;
-	}
-	queue->fileio.active_block = NULL;
+	iio_dma_buffer_fileio_free(queue);
 	queue->ops = NULL;
 
 	mutex_unlock(&queue->lock);
-- 
2.39.2

