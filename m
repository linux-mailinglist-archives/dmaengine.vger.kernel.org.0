Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2068525D37
	for <lists+dmaengine@lfdr.de>; Fri, 13 May 2022 10:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378117AbiEMIQe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 May 2022 04:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378015AbiEMIQ3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 May 2022 04:16:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4498E36B58;
        Fri, 13 May 2022 01:16:27 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i24so7055026pfa.7;
        Fri, 13 May 2022 01:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EK0O1fYZJFf35pOM+tjzuhmWCmIVAqptbvd0uhls+tc=;
        b=YomIj+/QU2OBScvBXyVkMa5DWCWubXOsrgbzqj8+tknT8Ds+AiBJ2mmQnQQN63rdZ7
         fiJQNuLB+5K84N6hrWLgZbr0pIzPW8NNj0GZxtQLoBE3t++PZ5St5ESERQwJ+bpr+dtL
         ak6iHQjFoGNzV2T8sEWluf0ioCQ9ROEDG0nlNFxtLOBPriysMLUdFbFAih1N6dmQH2kw
         vn3Z6TDdcvAX4I5DBNvkhsmOFlhhiI6rD0zJFJ46aJ21t8PmeEDm+2NhFmCOsGXK2kxH
         q+5brmTvArCFQofx0temsKUZKHLEZhnoXY5xk7aykwI5cGpY9utihWZxKM+yTltMhpil
         VQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EK0O1fYZJFf35pOM+tjzuhmWCmIVAqptbvd0uhls+tc=;
        b=U/Gl9P/eOJW4eq6wwL9qdOaEQZeivqJxdaVAPW84NvLX6Yp3NtejCOfB1ofxX4NeMS
         jTXOO8d1AXUnaNUKMcYlj943zGl7ekExG6nkcHH7JAYDJlqwEBdfPtnoNXfNNo5nSLh9
         l7CPIah+Fs8N7hnBHM0wK8YCyUbBVn5deWaFZCKgYsSUVFNs/tVaBhI8ud/ugM1mvyZg
         olb06oJp+P7GSoOIXcH1f7aNz7a/gBRnfGjxBsuXeR7kxBrDJqNZFuRIQL6nuarBrM1n
         JhNxglh1cSDWdo5VNsn2euvBT5ZukrsPuaAanfQppbcL4VshIwhNUa3TeCSOr/MSY3BA
         zkVQ==
X-Gm-Message-State: AOAM532JtVwKGXmHIHy8I0HniH7DodMdMY4kzGVVBVcfwQA5mUKN7L+n
        3tFvc0wYOg/EJPBxsTns1/quLNAzT9E=
X-Google-Smtp-Source: ABdhPJyFkI6ahX9P93GxDokV+KAtFn7JmYzSPV8gVmNWusiVN6HOhqLJNi1Ob3CzWYHSNlFgWM0YCA==
X-Received: by 2002:a05:6a00:c8f:b0:510:60cf:55fa with SMTP id a15-20020a056a000c8f00b0051060cf55famr3384342pfv.37.1652429786741;
        Fri, 13 May 2022 01:16:26 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ij14-20020a170902ab4e00b0015e8d4eb1c2sm1220143plb.12.2022.05.13.01.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 01:16:26 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     dave.jiang@intel.com
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] dmaengine: idxd: Remove unnecessary synchronize_irq() before free_irq()
Date:   Fri, 13 May 2022 08:16:22 +0000
Message-Id: <20220513081622.1631073-1-chi.minghao@zte.com.cn>
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

Calling synchronize_irq() right before free_irq() is quite useless. On one
hand the IRQ can easily fire again before free_irq() is entered, on the
other hand free_irq() itself calls synchronize_irq() internally (in a race
condition free way) before any state associated with the IRQ is freed.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/dma/idxd/device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5363fb9218f2..9dd8e6bb21e6 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1179,7 +1179,6 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
 	struct idxd_device *idxd = wq->idxd;
 	struct idxd_irq_entry *ie = &wq->ie;
 
-	synchronize_irq(ie->vector);
 	free_irq(ie->vector, ie);
 	idxd_flush_pending_descs(ie);
 	if (idxd->request_int_handles)
--
2.25.1


