Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9716BF84F
	for <lists+dmaengine@lfdr.de>; Sat, 18 Mar 2023 07:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjCRGXE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Mar 2023 02:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCRGXD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 18 Mar 2023 02:23:03 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B7B132E6;
        Fri, 17 Mar 2023 23:23:02 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso9567654pjf.0;
        Fri, 17 Mar 2023 23:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679120582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngDoAe2SMF8O9JG38OYK9h6kTvKqSQulQP0C6GqWh/Q=;
        b=e2pQqreq7rkm52RLzPxDS3uNVqdQLahxPO1muWuYQZQgyQ54svwC4aU0VCGlGFneLj
         DQ2yHyqweqV9sPjmDLB+UW0wBaBSvyO9k+36htJIUzYc1I5gf0EiQPXcnLBGaYCo6+Si
         HJoX2RntExcDQN+HnrbWITFrO6PKu/QL9YBalQmcJKje3G772pIv4mbjsva4alDfxP19
         JCMie1oVzDa4n0nQgHhZFXiG6YG6v2J0B33ZkNaNcpoYZjiaN+YhrC7b/3w/EnF9u0vU
         RpGrK3cjy0RRcaO1bhhr2+szznRCbwxmZ5e04kLHFQswh8qtCnj+iNmxlCvKKkL1lDd7
         Qddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679120582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngDoAe2SMF8O9JG38OYK9h6kTvKqSQulQP0C6GqWh/Q=;
        b=q4lfVhQxe+qFNIJDZyPQD95UGKQKUIxwT8n6WZlgzpw2L4HiWjOJ/qeiKWDpY5nwCY
         9B0aC7h2YkXAhz1RYEzcWN4Lz3lpUCZDT9XeFauVw+v16Tf9FTkMzCsiNmvPSDGxiWWi
         1PhpAi+ZJDRHX1Ox7lyW12CxNWeUnAppGCKWp5xfmbPcfSHEQKsEG+u0OzfWF5PsSX0F
         fAQYdeZ+kQCDE68u9TyD7WadQNL4gckh5jncBBv1/EGCjGIMrGn7Doi5t2iYbFO/JLfu
         finVeqpEtVGiOsDxDWQLXBSPCX+pQc8MHrBZDk3jFY0TChjhnQ9SnMMcQg27MpLMDtLg
         +kgQ==
X-Gm-Message-State: AO0yUKVwkaPKqEIC85tDSPKu/Z+KgVRHQla3JqwJE3IfNRUO9jVJA6Jb
        c65B9hDuco3c/uDwiWE/T2Z8rO7Ni6cGcw==
X-Google-Smtp-Source: AK7set9Apsyg0sCnkb7f2s8fWryv7QSWnxLCvkc3B9H3iqN3lLZtTlLctNJiovC7B05SypnJN2f0bQ==
X-Received: by 2002:a17:903:234a:b0:19e:6e29:2a8c with SMTP id c10-20020a170903234a00b0019e6e292a8cmr11290347plh.5.1679120581746;
        Fri, 17 Mar 2023 23:23:01 -0700 (PDT)
Received: from DESKTOP-HHR6EMI.localdomain ([143.244.50.165])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902aa9200b001a1add0d616sm1471208plr.161.2023.03.17.23.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 23:23:01 -0700 (PDT)
From:   void0red <void0red@gmail.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter.ujfalusi@gmail.com, void0red@gmail.com
Subject: [PATCH v2 1/2] dmaengine: ti: add null check of devm_kasprintf in udma_probe
Date:   Sat, 18 Mar 2023 14:22:54 +0800
Message-Id: <20230318062255.76-1-void0red@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZBSj/0kIGVROIGi7@matsya>
References: <ZBSj/0kIGVROIGi7@matsya>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Kang Chen <void0red@gmail.com>

devm_kasprintf may fails, uc->name might be null and wrong irq
name will be used in request.

Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Kang Chen <void0red@gmail.com>
---
v2 -> v1: split into two patches and add some tags

 drivers/dma/ti/k3-udma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 7e23a6fdef95..692d1d25c70a 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5494,6 +5494,8 @@ static int udma_probe(struct platform_device *pdev)
 		uc->config.dir = DMA_MEM_TO_MEM;
 		uc->name = devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
 					  dev_name(dev), i);
+		if (!uc->name)
+			return -ENOMEM;
 
 		vchan_init(&uc->vc, &ud->ddev);
 		/* Use custom vchan completion handling */
-- 
2.34.1

