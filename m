Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E2767EFE7
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jan 2023 21:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjA0Upj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Jan 2023 15:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjA0Upf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Jan 2023 15:45:35 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4872A7F699
        for <dmaengine@vger.kernel.org>; Fri, 27 Jan 2023 12:45:20 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id i18-20020a4a2b12000000b00510ebea37bfso741015ooa.6
        for <dmaengine@vger.kernel.org>; Fri, 27 Jan 2023 12:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sO0M/9id5QzqnIj7L9/3X+OzKn1jfWdUPZ3eWy6l07M=;
        b=hZTwUXw4hQnTAnxxVu6TBvFEjVMR07HtG2vvp/8cCJN9P/Wgz0UvjSjIaluvHKV6Q2
         b14+CzQQ9N0BHj7wPo6jVI7RCF6Rj1BLcsGC1GOIyL01rJTvhyjcdQFE7cAK73OAx1cG
         /7fO5brePd1bZ0hC54m8fIYa0dqUG0xB6ChOyK1FMDUGeWq5BmdDWKZnj0ba0CWT1YQ5
         np3MmYQ4E9pjHs0asX4jv5rfe0JrCUyuyeomB+T5F9FJmmE/kbja3shePEqBjcPZfhDm
         /ncfYZEtocedstJR0R3zlYAeVhU2ZHxKZpuPRrxta57P7uERjGiyMpBamhROJ2/iwQ4j
         B48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sO0M/9id5QzqnIj7L9/3X+OzKn1jfWdUPZ3eWy6l07M=;
        b=qxq873OfEII1OoUSZEpgfeGmNLTUi2JbiB4dVeugNUD5MnA80d3SikO3bJjCS55iSr
         BXSvJPjOW4r2Rv9QvrZG7oV81VMbwY+4MYjvPUkdK+hJWezAI9i4869y4fOlzs1Of6pK
         c8g5cAVFb+8keHmJxnJnXNyuNx4gOtXy1Do+5PROS25/eG0RUNHkhhf2Frc8Ld0HmpfT
         FtF8JxRSueb36YVJpuuhgI+zkHXF+FlQ7O+0T6VOvgbnRE0UAcHWF10xtzy11oKKHaSh
         EGp9dwpd9OeunH/uzWZ53KBxILqLvoYxnRy2ccufUIMT5wF+RI9Krel2xRVJb4MtEVGO
         alRA==
X-Gm-Message-State: AO0yUKUtRa1FQe5OC8t+SN5Q05wbOLHtpI6ZdsPFjHst4HdpbMkhNlNB
        Q9wkC2pAPrcIVK+nSLWJEwH+3Q==
X-Google-Smtp-Source: AK7set9XOH9icej9k4pOwGQtiQVS+5Vex3uGxFxUng1R4NnlzMO/X9v28fxfU8okEpVKUc6S0dxkMg==
X-Received: by 2002:a4a:e9e4:0:b0:515:22bf:3eb6 with SMTP id w4-20020a4ae9e4000000b0051522bf3eb6mr2344194ooc.7.1674852319197;
        Fri, 27 Jan 2023 12:45:19 -0800 (PST)
Received: from bigtwin1b.gigaio.com ([12.22.252.226])
        by smtp.gmail.com with ESMTPSA id r9-20020a4ae5c9000000b0051134f333d3sm2104303oov.16.2023.01.27.12.45.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jan 2023 12:45:18 -0800 (PST)
From:   Eric Pilmore <epilmore@gigaio.com>
To:     Sanju.Mehta@amd.com, dmaengine@vger.kernel.org, vkoul@kernel.org,
        epilmore@gigaio.com
Subject: [PATCH] dmaengine: ptdma: check for null desc before calling pt_cmd_callback
Date:   Fri, 27 Jan 2023 12:44:51 -0800
Message-Id: <20230127204451.95190-1-epilmore@gigaio.com>
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

Resolves a panic that can occur on AMD systems during host shutdown
where pt_issue_pending() could potentially call pt_cmd_callback()
with a NULL desc pointer.
Ref: Bugzilla Bug 216856.

Fixes: 6fa7e0e836e2 ("dmaengine: ptdma: fix concurrency issue with multiple dma transfer")
Signed-off-by: Eric Pilmore <epilmore@gigaio.com>
---
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

