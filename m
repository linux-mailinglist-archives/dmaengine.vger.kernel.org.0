Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA33691802
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 06:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjBJFhX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 00:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBJFhW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 00:37:22 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E36EEC64
        for <dmaengine@vger.kernel.org>; Thu,  9 Feb 2023 21:37:21 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hx15so12882784ejc.11
        for <dmaengine@vger.kernel.org>; Thu, 09 Feb 2023 21:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jR/gtMKVUFr7rVFpJ5x80nDG1aPAAgxnE7khUidCI0g=;
        b=imL3gbXqJ/ef/0PSrrZTIS6+eI5j0/6iDx1QSPS9bL+y9QiIfWrn18zmZtAh0NW1fd
         KhXhoNY4MyzX0pp3iSaVoRLkev0k5nw9Sv7Zngtn2c/tlPX/aP3eC7XLfeGtZtmn4GgA
         FuA+spwQDbOiG6oBhGqESisXHaH7echGZNi9brXbarS653BTG4+eC2ThlQ7Vrww6ocSD
         8a4DxPHVMajmisnPBYxSj6q4GWlhQ1puqLpf2a0xmCjqEd7kh86A+5OjgZJbcOfJfzGE
         LQTSc8MEnjQ/ey3bGwfxCCkRXFD7v6gtxGvlY+7iK7qj0Z0OgeKFsR4wPNkySFsG6PMR
         pHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jR/gtMKVUFr7rVFpJ5x80nDG1aPAAgxnE7khUidCI0g=;
        b=bYZlf/drL4XnZwlVlbXcFCAb4YMGMkcoTupZpdZHfSdtQshUpJ5+mu8seW/cnDUYX5
         nC7WxNdj9gMiID0//vQP6HWnOAss3EpZTdz+8oaHHT+nlrj9OauJnAX1wic8qsjx2L+Z
         tLGDdTSyj7ZytCY38BNrPryUTjVKXsnrA1wmgocZwDhwj7xACTF18QQuplnmyZ4ADi7h
         JNMbPrW9FQaJJoNyIQ4vR8nkcJeE9bVUXNz7IbmVZ8ERnofW3SjVnz9ON/BsREssZCmM
         CYL9EN89YBtpJeL4wmW6cAIgwh57GvjbiCERMsyMmWHs0srFBmS5tFjXRIlEpFSAyS/l
         wbhw==
X-Gm-Message-State: AO0yUKUO8gERshCtmy4ZRL+s6yMpqcqV8JNnPTVdrxg8YkggWkPR4xiY
        /zdcVpf3XzgNz3N2XTXsjmHyIbgQmEJYbAN6PJBLYw==
X-Google-Smtp-Source: AK7set+lZHK3nlsCeRe1dW89bhub5GxkfLrRgZSbk7qll2z8eng0dTr02bgyRrF7FGLiStj8Wns99HPygvvC+469BHs=
X-Received: by 2002:a17:907:366:b0:88d:ba79:4310 with SMTP id
 rs6-20020a170907036600b0088dba794310mr1181276ejb.0.1676007439749; Thu, 09 Feb
 2023 21:37:19 -0800 (PST)
MIME-Version: 1.0
From:   Eric Pilmore <epilmore@gigaio.com>
Date:   Thu, 9 Feb 2023 21:37:08 -0800
Message-ID: <CAOQPn8tpjo5Jwz8jGi0JfTQd-hF+VS7N90T=GJpjG3wj5x8UHw@mail.gmail.com>
Subject: [RESEND PATCH] dmaengine: ptdma: check for null desc before calling pt_cmd_callback
To:     "Mehta, Sanju" <Sanju.Mehta@amd.com>, dmaengine@vger.kernel.org,
        Vinod <vkoul@kernel.org>
Cc:     Eric Pilmore <epilmore@gigaio.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Eric Pilmore <epilmore@gigaio.com>

Resolves a panic that can occur on AMD systems, typically during host
shutdown, after the PTDMA driver had been exercised. The issue was
the pt_issue_pending() function is mistakenly assuming that there will
be at least one descriptor in the Submitted queue when the function
is called. However, it is possible that both the Submitted and Issued
queues could be empty, which could result in pt_cmd_callback() being
mistakenly called with a NULL pointer.
Ref: Bugzilla Bug 216856.

Fixes: 6fa7e0e836e2 ("dmaengine: ptdma: fix concurrency issue with
multiple dma transfer")
Signed-off-by: Eric Pilmore <epilmore@gigaio.com>
---
 drivers/dma/ptdma/ptdma-dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c
b/drivers/dma/ptdma/ptdma-dmaengine.c
index cc22d162ce25..1aa65e5de0f3 100644
--- a/drivers/dma/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -254,7 +254,7 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
        spin_unlock_irqrestore(&chan->vc.lock, flags);

        /* If there was nothing active, start processing */
-       if (engine_is_idle)
+       if (engine_is_idle && desc)
                pt_cmd_callback(desc, 0);
 }

--
2.38.1
