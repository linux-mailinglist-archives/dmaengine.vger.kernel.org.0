Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C3D4C61B1
	for <lists+dmaengine@lfdr.de>; Mon, 28 Feb 2022 04:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiB1DRT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 27 Feb 2022 22:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiB1DRS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 27 Feb 2022 22:17:18 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0174D9ED;
        Sun, 27 Feb 2022 19:16:40 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id s25so15522231lji.5;
        Sun, 27 Feb 2022 19:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zg0TIK6XMtGo2+14WVBQUgTNyr+m/JGQHLQZEW5xU2I=;
        b=aHejDxFQsXsgx3XVZLEqq9TlixGkYqPrCIfPFbBd7mAZQ6VxBRYBe5q94HBazcyANR
         dixNKatc8h1aM+HMbkO4gkwZZh4EkA94iLCQ0z1/0cwDA2QGds9TWdCQwDqxLD9xFe7w
         eEcDVtLGXlthkIiBHe/kNtE/ddhIoTy9wyisvqsx51UFhkDo58OymdhFcAGTOMk7uLhn
         ZVKE031sYhK30BqRg0FiFy37agwlXZVfv3BKZSWzGflQ405gucXgl0AdmaiH30p6WuEI
         TqaVUUGncLpzXK9k1G6hLym5Zxp4H6aGpJ+p0jc6C1ShDisuTs+JDitkePqapLqINbRx
         6EFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zg0TIK6XMtGo2+14WVBQUgTNyr+m/JGQHLQZEW5xU2I=;
        b=B5UTqJse0+qDQ/Hs/we47CXVRZ6gGCzgYAZm/NaTcUA0aJuIRuvQ04S5vTDnwVV5IL
         vLomZbKQ9zz8Qrr04jzF8DHIYtA4MSe/jZqYDYiJ8rSJAcKGQLasKU2rHJH5cua9D9Dt
         ga8P/Gyt7A1lXIOsobGpzo/lTObeCO7t8c0bcTmIq3BAdeWC+CPr+ivpdksmjYjAu9JW
         AdXyARJh3VC2rI2UZL6RJyhxNc1b5d7RgQLQyGCFZdegGGDgxlvlO0B6N3DDaINmjbuc
         mO0hU1W1ezVLMImTesnCDUJQJXcSPJBfomhd6qNtO/Z5mMZv13ljPvHxlFaaYGOTfKtN
         kr9Q==
X-Gm-Message-State: AOAM530V5GIotRblpq7OP6OsjEWpFPsxzjbCJa6PvyrxjJCPtCh4uKin
        KtnqKC1ESg0C+/8e6eq6SfLZEutFsf1s1Q==
X-Google-Smtp-Source: ABdhPJzW1JTC8WiBx3ECVWXpvKbkrV24ahGPQaJZO/16cqVJvcaLnQHB591UnXukLQkV18W6teMTpQ==
X-Received: by 2002:a2e:a810:0:b0:23d:7904:dac3 with SMTP id l16-20020a2ea810000000b0023d7904dac3mr12448195ljq.194.1646018198701;
        Sun, 27 Feb 2022 19:16:38 -0800 (PST)
Received: from TebraArch.. ([81.198.32.225])
        by smtp.gmail.com with ESMTPSA id h15-20020a19700f000000b00443e2a42010sm783852lfc.56.2022.02.27.19.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 19:16:38 -0800 (PST)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH] ccp: ccp_dmaengine_unregister release dma channels
Date:   Mon, 28 Feb 2022 05:15:45 +0200
Message-Id: <20220228031545.11639-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

ccp_dmaengine_register adds dma_chan->device_node to dma_dev->channels list
but ccp_dmaengine_unregister didn't remove them.
That can cause crashes in various dmaengine methods that tries to use dma_dev->channels

Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
---
 drivers/crypto/ccp/ccp-dmaengine.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/crypto/ccp/ccp-dmaengine.c b/drivers/crypto/ccp/ccp-dmaengine.c
index d718db224be42..7d4b4ad1db1f3 100644
--- a/drivers/crypto/ccp/ccp-dmaengine.c
+++ b/drivers/crypto/ccp/ccp-dmaengine.c
@@ -632,6 +632,20 @@ static int ccp_terminate_all(struct dma_chan *dma_chan)
 	return 0;
 }
 
+static void ccp_dma_release(struct ccp_device *ccp)
+{
+	struct ccp_dma_chan *chan;
+	struct dma_chan *dma_chan;
+	unsigned int i;
+
+	for (i = 0; i < ccp->cmd_q_count; i++) {
+		chan = ccp->ccp_dma_chan + i;
+		dma_chan = &chan->dma_chan;
+		tasklet_kill(&chan->cleanup_tasklet);
+		list_del_rcu(&dma_chan->device_node);
+	}
+}
+
 int ccp_dmaengine_register(struct ccp_device *ccp)
 {
 	struct ccp_dma_chan *chan;
@@ -736,6 +750,7 @@ int ccp_dmaengine_register(struct ccp_device *ccp)
 	return 0;
 
 err_reg:
+	ccp_dma_release(ccp);
 	kmem_cache_destroy(ccp->dma_desc_cache);
 
 err_cache:
@@ -752,6 +767,7 @@ void ccp_dmaengine_unregister(struct ccp_device *ccp)
 		return;
 
 	dma_async_device_unregister(dma_dev);
+	ccp_dma_release(ccp);
 
 	kmem_cache_destroy(ccp->dma_desc_cache);
 	kmem_cache_destroy(ccp->dma_cmd_cache);
-- 
2.35.1

