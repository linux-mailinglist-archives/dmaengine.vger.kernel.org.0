Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE41C63CE6D
	for <lists+dmaengine@lfdr.de>; Wed, 30 Nov 2022 05:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiK3EnD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Nov 2022 23:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiK3Emx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 29 Nov 2022 23:42:53 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF4D60E5
        for <dmaengine@vger.kernel.org>; Tue, 29 Nov 2022 20:42:51 -0800 (PST)
Received: from localhost.localdomain (unknown [123.112.66.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AD0093F5DE;
        Wed, 30 Nov 2022 04:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669783369;
        bh=RpKuu5yt2vbDg/BjymcSxfLMc3SMMUCP+4+Ayv3XmXQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=or5JeNELrlQMi4BeGhGsUX+yQ9WXtp5Lqh7zv+jwoaTn7bnn/LF2imZnVToio6YZE
         SuI4TR5GzaDWPNT0W2s3/TgJTgd7/QsX8oJNaPuvWs3ekOWFHm6Nt3NDtIK4ahb/5Q
         LDx1LxQvdje0WPowCnHE/QclaxB9yMDVzNxVQPRcfodeDRsl6DetxcQitCpAi/T6lz
         /fN3SxqvTDoPq56om8GIgpP56W1Gb8cu5UNdVHLLdUzoryIfn9Mf7p4dcgyoPoigOZ
         Xrz/47CmBmDlVk0QW0mI2RQO2ulwksLZcJkoZpszD/YqXJMYAI8jCBTMQinkRYFDm+
         9m4llB4xf3o2g==
From:   Hui Wang <hui.wang@canonical.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org
Cc:     s.hauer@pengutronix.de, shawnguo@kernel.org, hui.wang@canonical.com
Subject: [PATCH] dmaengine: imx-sdma: Fix a possible memory leak in sdma_transfer_init
Date:   Wed, 30 Nov 2022 12:42:37 +0800
Message-Id: <20221130044237.29525-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If the function sdma_load_context() fails, the sdma_desc will be
freed, but the allocated desc->bd is forgot to be freed.

We already met the sdma_load_context() failure case and the log as
below:
[ 450.699064] imx-sdma 30bd0000.dma-controller: Timeout waiting for CH0 ready
...

In this case, the desc->bd will not be freed without this change.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/dma/imx-sdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index fbea5f62dd98..235a4e12d660 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1520,8 +1520,10 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
 	if (direction == DMA_MEM_TO_MEM)
 		sdma_config_ownership(sdmac, false, true, false);
 
-	if (sdma_load_context(sdmac))
+	if (sdma_load_context(sdmac)) {
+		sdma_free_bd(desc);
 		goto err_desc_out;
+	}
 
 	return desc;
 
-- 
2.34.1

