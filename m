Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7021C691960
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 08:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjBJHwo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 02:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjBJHwo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 02:52:44 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C8F7AE20
        for <dmaengine@vger.kernel.org>; Thu,  9 Feb 2023 23:52:43 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id a23so3148764pga.13
        for <dmaengine@vger.kernel.org>; Thu, 09 Feb 2023 23:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E5y6X4i2I/RlpR1E5QjxF9dNq4EYL8kIDGgdcDKrokU=;
        b=FxKHWLlWhosBiZs99+kPRoiW1vyKMJcCFQJvqDSO8NAsW1ybWP/ZBHrArWHkS1ZQfF
         kXYoPV1JOSm4R8wD2Q0w7MtRCGmUeSdQKFMp1Ld/L8Zry6wSl8mVLXH9/mGTulT76QJZ
         432+dkJEdna/EmNjTaKlrL6jqcSvHPFxoYLfW3QTQPUQonwfN4WQsWcZriN7tgr28gIa
         axNxdZVxbttEpZzhRkpaRBwIXEdoQCBe6PJyzpwO87nckjAbdglcPYIIJPB9yyzMbLzX
         5hx+JmFQngbG/j5/KSQxvnywZ3K/4ItwEd7epnYnt8RIrXaC5ul+RPPKPs0qJx2EWiAw
         O+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5y6X4i2I/RlpR1E5QjxF9dNq4EYL8kIDGgdcDKrokU=;
        b=SWy3pil3rfkgDg4lRKsZYW3Uzq3CaMRca6iEY7XPhsjolF/ZI8WFQV0QScnd1ge6jG
         wpyyhCMjIksxdQ0MSdaKFWEKwmjR5FTx1d4gr57cDQ1nvzY9vQjH92OlOrkf8FS9ckQe
         Iv6HVbxoGC10ODHNP/uVip1u5R1uzQjxSflJYq4TXEsd7PqIZ/7DgfgFfWehL9zvpOgd
         V3SkF/P4v/UoGgTbM3mJ4mxFhQiZ/gLx5ejXgDR+BNXSuui5WhbXalIX7sA40KwMaobh
         z3BAPLdX5D6LbIoROUO7dUQ3EeII9FumbGJXDVxMCaAUBhFzAwdBVH+wH6+1jI1ymkuz
         pFmA==
X-Gm-Message-State: AO0yUKUsjmptRLFDTetb55Sb64MOCdb7inD8Y3EA/nOE+wNwKIV7AYQm
        Zt7ayHWGJ+sqp0s4my7zAof4+OipTPTQFhD/
X-Google-Smtp-Source: AK7set+Ll49LrbtfkIpQmg9T4/ykkIIIMONH9ABy6p5Wnj+USfRMdJq1ndc1tTld4j6Kc7HEM8vN4A==
X-Received: by 2002:a62:1b0e:0:b0:5a8:18fa:2911 with SMTP id b14-20020a621b0e000000b005a818fa2911mr7798397pfb.3.1676015562922;
        Thu, 09 Feb 2023 23:52:42 -0800 (PST)
Received: from bigtwin1b.gigaio.com ([12.22.252.226])
        by smtp.gmail.com with ESMTPSA id y19-20020a62b513000000b00589a7824703sm2637900pfe.194.2023.02.09.23.52.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Feb 2023 23:52:42 -0800 (PST)
From:   Eric Pilmore <epilmore@gigaio.com>
To:     Sanju.Mehta@amd.com, dmaengine@vger.kernel.org, vkoul@kernel.org,
        epilmore@gigaio.com
Subject: [PATCH v2] dmaengine: ptdma: check for null desc before calling pt_cmd_callback
Date:   Thu,  9 Feb 2023 23:51:43 -0800
Message-Id: <20230210075142.58253-1-epilmore@gigaio.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Resolves a panic that can occur on AMD systems, typically during host
shutdown, after the PTDMA driver had been exercised. The issue was
the pt_issue_pending() function is mistakenly assuming that there will
be at least one descriptor in the Submitted queue when the function
is called. However, it is possible that both the Submitted and Issued
queues could be empty, which could result in pt_cmd_callback() being
mistakenly called with a NULL pointer.
Ref: Bugzilla Bug 216856.

Fixes: 6fa7e0e836e2 ("dmaengine: ptdma: fix concurrency issue with multiple dma transfer")
Signed-off-by: Eric Pilmore <epilmore@gigaio.com>
---
v2: clean-up patch format

 drivers/dma/ptdma/ptdma-dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
index cc22d162ce25..1aa65e5de0f3 100644
--- a/drivers/dma/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -254,7 +254,7 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	/* If there was nothing active, start processing */
-	if (engine_is_idle)
+	if (engine_is_idle && desc)
 		pt_cmd_callback(desc, 0);
 }
 
-- 
2.38.1

