Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF35B63D166
	for <lists+dmaengine@lfdr.de>; Wed, 30 Nov 2022 10:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiK3JIS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Nov 2022 04:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiK3JIR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Nov 2022 04:08:17 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A7D31EC7
        for <dmaengine@vger.kernel.org>; Wed, 30 Nov 2022 01:08:16 -0800 (PST)
Received: from localhost.localdomain (unknown [123.112.66.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CF78341CE5;
        Wed, 30 Nov 2022 09:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669799295;
        bh=CApyMkzvPHqa9sGg0KKG6LpQrVDXX+NwyP+nnBPEuTs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=SWZWbdAArZyZUq7/LUnVWdcHVhLq6Nm5e1j8Sf0U9IhDHSCSKTKC5bgom7lTAcqBa
         JUJL9Ss9v1243VqACFF1sRfRmVXibjA2uIvjLrL/Kou1xgVJN3cSQm3Z+QlrHf6g7g
         +m05HuX8Y7YeabY2oUqkOZU/lnyNriOgtoQ1pzuw4K/ha7fhKVcJAOqTsKDcMihz6d
         cNukvNnbpeYRJz+ynHAcG9rIMWAhDYEwDbUcXItEuyUsoPOdI5pvvR5u/SoO0f0SAO
         u0Mh66rV3p/6mCOZPzqnz4cLX6OxaBZvtSEfgliYz7eBViGEnp1KPP++c1S07Jk6s1
         G2rSY4rgsXWhg==
From:   Hui Wang <hui.wang@canonical.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org
Cc:     s.hauer@pengutronix.de, shawnguo@kernel.org, hui.wang@canonical.com
Subject: [PATCH v2] dmaengine: imx-sdma: Fix a possible memory leak in sdma_transfer_init
Date:   Wed, 30 Nov 2022 17:08:00 +0800
Message-Id: <20221130090800.102035-1-hui.wang@canonical.com>
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
index fbea5f62dd98..b926abe4fa43 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1521,10 +1521,12 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
 		sdma_config_ownership(sdmac, false, true, false);
 
 	if (sdma_load_context(sdmac))
-		goto err_desc_out;
+		goto err_bd_out;
 
 	return desc;
 
+err_bd_out:
+	sdma_free_bd(desc);
 err_desc_out:
 	kfree(desc);
 err_out:
-- 
2.34.1

