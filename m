Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4107788E5
	for <lists+dmaengine@lfdr.de>; Fri, 11 Aug 2023 10:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjHKI0S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Aug 2023 04:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbjHKI0R (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Aug 2023 04:26:17 -0400
X-Greylist: delayed 553 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 01:26:17 PDT
Received: from out-95.mta1.migadu.com (out-95.mta1.migadu.com [IPv6:2001:41d0:203:375::5f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020732D41
        for <dmaengine@vger.kernel.org>; Fri, 11 Aug 2023 01:26:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691741819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vVm1O0Syg4ejjYMdJVi4z6kpg+fEh4jWNr9Mz8DjEBU=;
        b=licdqO+sDYnJfKHnR0CE+bAjXPWEEG0jX68sg1wtWqG9HnP5fShB2CEZBloNS31eVOXP9E
        +kIno0g5qZCfGEgn+WQKsQHHQTa/fSCbLqGizfA8epUW0w6ze0fIkui5ffD8tgyWtmB3Z6
        WPElMr+vxUMdHCYTaFR1DbnbGt8yCmk=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     vkoul@kernel.org, bhelgaas@google.com, dave.jiang@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] dmaengine: ioat: fixing the wrong chancnt
Date:   Fri, 11 Aug 2023 16:16:45 +0800
Message-Id: <20230811081645.1768047-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The chancnt would be updated in __dma_async_device_channel_register(),
but it was assigned in ioat_enumerate_channels(). Therefore chancnt has
the wrong value.

Clear chancnt before calling dma_async_device_register().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/dma/ioat/init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index c4602bfc9c74..928fc8a83a36 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -536,8 +536,11 @@ static int ioat_probe(struct ioatdma_device *ioat_dma)
 
 static int ioat_register(struct ioatdma_device *ioat_dma)
 {
-	int err = dma_async_device_register(&ioat_dma->dma_dev);
+	int err;
+
+	ioat_dma->dma_dev.chancnt = 0;
 
+	err = dma_async_device_register(&ioat_dma->dma_dev);
 	if (err) {
 		ioat_disable_interrupts(ioat_dma);
 		dma_pool_destroy(ioat_dma->completion_pool);
-- 
2.25.1

