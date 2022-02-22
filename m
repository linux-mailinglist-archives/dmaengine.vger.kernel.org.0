Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB354BEF57
	for <lists+dmaengine@lfdr.de>; Tue, 22 Feb 2022 03:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiBVB7s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Feb 2022 20:59:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiBVB7s (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Feb 2022 20:59:48 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4401EECA;
        Mon, 21 Feb 2022 17:59:23 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u20so21870034lff.2;
        Mon, 21 Feb 2022 17:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4e0Or5RWevHd+mvZ+oPOZ9BD4lXm7waqKeZmhpiEe8=;
        b=HvRx0IuZd0XT6yuS0ZZUz/89gM8iXDEjmGhF2pXnT5CWZAj9B//bSwT0Q/H1FYjUyf
         gyAS28/L7MKeypEo3xteO2B4W82J7OOAlKuQjEqh9qtfAq95N65BUIV/nUTuIXakhN58
         MimOcmF077XqKlrqrGdYULn7rtOux4KBqKyAdvFm1ddyIzJByVDpmz8s3fu7w5SondJh
         Y3zEOM6grOEr5WZ3mQ33dOXWFlRJCKQH+6g+NtjryqyUAYHWypDUBr1/6z1NPxTrDiE0
         ucaczRo8RgBVIp2+9JEZRFgHbP1Psmq5X50Jc6E+kUROob6Ri0Y3rn2nloQwwYVYmF5a
         0zCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4e0Or5RWevHd+mvZ+oPOZ9BD4lXm7waqKeZmhpiEe8=;
        b=ZtzK9VUoe7YL2W6M7nLrApkpJZ6lRdvtn/O+cLlQryp1A4Q+/wLtbdB1hftNhH9yRy
         g68q7GILrlVsVXXux/PC3dzH3yp8c9+5H67iNRGIOThP1ajs4N+aO5YTq5A6sH5OT24X
         I7WuMPpxv3rRU/tXkR5xsb/JtA6EDviCwOfXOxFX/R4K4P02w4RtoknCgpl6C8orEZDs
         kikajNI0/NTxwViQREytDPHUNuMu9s0X1mom9bnE7lwrNESXBdl51VQvhspy01f9zoXz
         7JU/Gxb+ymg99Xl02RtbnLebYGY6CSahoNfbFgJdxO++7HWo7+cEzhaCgNfHgvMYqirj
         G2Gw==
X-Gm-Message-State: AOAM533U/D265S0sSIN3hTNF2VBwRyEdM1YS3nROrrDi1Zkqp+Xf9f62
        QwJDnKesIoj7VVSlgqmqow5+M/Wj/HT0YZqX
X-Google-Smtp-Source: ABdhPJyxKnDiUyaEYLNQqp5Kqvel/Q6b0YfU1P6b3CMSNq+vJFwgs/wzbJJqEmkkKObqtyac0BBilA==
X-Received: by 2002:a05:6512:31cf:b0:443:7eb6:3440 with SMTP id j15-20020a05651231cf00b004437eb63440mr15283210lfe.367.1645495161995;
        Mon, 21 Feb 2022 17:59:21 -0800 (PST)
Received: from TebraArch.. ([81.198.32.225])
        by smtp.gmail.com with ESMTPSA id 10sm1255051lfq.201.2022.02.21.17.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 17:59:21 -0800 (PST)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH] dmaengine: fix locking for dma_channel_rebalance
Date:   Tue, 22 Feb 2022 03:58:49 +0200
Message-Id: <20220222015849.14727-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.35.1
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

dma_channel_rebalance comment says:
>  Must be called under dma_list_mutex

We have few places where it wasn't done and could cause crashes.
So invoke it only when it's under mutex.
---
 drivers/dma/dmaengine.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2cfa8458b51be..5198bdf7ee804 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1098,7 +1098,10 @@ int dma_async_device_channel_register(struct dma_device *device,
 	if (rc < 0)
 		return rc;
 
+	mutex_lock(&dma_list_mutex);
 	dma_channel_rebalance();
+	mutex_unlock(&dma_list_mutex);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dma_async_device_channel_register);
@@ -1124,7 +1127,9 @@ void dma_async_device_channel_unregister(struct dma_device *device,
 					 struct dma_chan *chan)
 {
 	__dma_async_device_channel_unregister(device, chan);
+	mutex_lock(&dma_list_mutex);
 	dma_channel_rebalance();
+	mutex_unlock(&dma_list_mutex);
 }
 EXPORT_SYMBOL_GPL(dma_async_device_channel_unregister);
 
-- 
2.35.1

