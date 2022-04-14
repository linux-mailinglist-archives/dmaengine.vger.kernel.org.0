Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FB25008DF
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 10:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbiDNIzR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 04:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbiDNIyw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 04:54:52 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFEB66238;
        Thu, 14 Apr 2022 01:52:14 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 32so4230442pgl.4;
        Thu, 14 Apr 2022 01:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDWGdxJhFsxcNNUteEWhKVijX9qVkGiF7WeSXdTWmXI=;
        b=LKt+dQAa1ppfZi/SzA3+Alnlf7kW1nzl/w8YG98sUCn1sR645pItyBn0vX1vmguEyE
         NfKb1CY4sv41k0kGquCOk7rIahMhoTOJugyQCzXhey9HMkHfgLZNh3JHzPrtqPa6oYgW
         RK0YnW0x8cGMSeQTVasigahOHx0X/L73KuS1uKWbXKyLVgoPFhbeoguyjH5+1x4q8znr
         Alpxnc8tp1jEYiXAWWd1hJQBHa61Jx9mJYBZh5JeudT3lMM+b9ic2Zdj1yIL3Z6nlaXj
         pNmkOmiwMlfjjnc/DQL8RyQ4o1ZJ6aElnUe0vFapNtM7KKthqgi9mhf3L9B/sKbTO6Vm
         HMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDWGdxJhFsxcNNUteEWhKVijX9qVkGiF7WeSXdTWmXI=;
        b=oGsJbHPScY/SlFE7IXv+GSvjEtS2x4pXznpikiGVxkGZZC/W3UQ344loDH+eoaUYHT
         26Y5Dd0iDd2zYKSmOEgMiLDF3ssD6JYWKWQ5zfclZd97M2j6SWKZJ34TX3fY3eASyUsl
         m7rNRS9IlHr6Hfb8YPqePVPGL/TYfMZq0erOWJ7p5UGkIQqdw+Qrk8rmsA0Cw9pZlqSx
         nqdFTnvw7+F4+m4u2Kg7wYKCGcGngtx9KYk0AoEHTBl60Vv/J2Bj376jKJZFLBrijZeJ
         lrqigH4pMLHt/8tF3ktJtdibZ1EspXd08GEWhHYCyJVqvmrw6zU+t20T7jdutjWVyvV4
         FliA==
X-Gm-Message-State: AOAM530UXCSNubZBwudZ7w2W0fCLmqoO3hs43YgVaEZY5tKQE9Y7Sl4b
        pEQZBEcZcK6iQsEk5Dytzt0UmANsXTI=
X-Google-Smtp-Source: ABdhPJyrrGwYvaw+Ko1XagjxjEwBjCMFJu7TrWZ7k6E1EzMLljruP968lnhC0Qf9+4bL8nsvSEA65w==
X-Received: by 2002:a63:5409:0:b0:382:7e1:db0c with SMTP id i9-20020a635409000000b0038207e1db0cmr1478101pgb.204.1649926333321;
        Thu, 14 Apr 2022 01:52:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a67-20020a621a46000000b005060c73ef43sm1428315pfa.195.2022.04.14.01.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:52:12 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     vkoul@kernel.org
Cc:     rdunlap@infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] dmaengine: cppi41: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Thu, 14 Apr 2022 08:52:09 +0000
Message-Id: <20220414085209.2541420-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/dma/ti/cppi41.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
index 062bd9bd4de0..44363a731409 100644
--- a/drivers/dma/ti/cppi41.c
+++ b/drivers/dma/ti/cppi41.c
@@ -374,11 +374,10 @@ static int cppi41_dma_alloc_chan_resources(struct dma_chan *chan)
 	struct cppi41_dd *cdd = c->cdd;
 	int error;
 
-	error = pm_runtime_get_sync(cdd->ddev.dev);
+	error = pm_runtime_resume_and_get(cdd->ddev.dev);
 	if (error < 0) {
 		dev_err(cdd->ddev.dev, "%s pm runtime get: %i\n",
 			__func__, error);
-		pm_runtime_put_noidle(cdd->ddev.dev);
 
 		return error;
 	}
@@ -402,12 +401,9 @@ static void cppi41_dma_free_chan_resources(struct dma_chan *chan)
 	struct cppi41_dd *cdd = c->cdd;
 	int error;
 
-	error = pm_runtime_get_sync(cdd->ddev.dev);
-	if (error < 0) {
-		pm_runtime_put_noidle(cdd->ddev.dev);
-
+	error = pm_runtime_resume_and_get(cdd->ddev.dev);
+	if (error < 0)
 		return;
-	}
 
 	WARN_ON(!list_empty(&cdd->pending));
 
-- 
2.25.1


