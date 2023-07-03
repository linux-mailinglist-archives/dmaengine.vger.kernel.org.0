Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46828745F28
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jul 2023 16:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGCOx6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Jul 2023 10:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGCOx6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Jul 2023 10:53:58 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235AC10E;
        Mon,  3 Jul 2023 07:53:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so562110266b.2;
        Mon, 03 Jul 2023 07:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688396035; x=1690988035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nj6RWQmoOrElPG2s/9G/TB0K+w3PkNfdcrWXDb193cE=;
        b=Hq70A1i7yhzs1W5neAZ6mYcg4FV5acbes7/oOHmYlzA1qmpOutqn5uB/eFdD6cl6x7
         GCpwqxWA+VX20QE+lWprYhmi5ofH0ZOpEHdlUj4xlxpLejdErLB1CClgpAkD6v0Q76qo
         CNHAZw4QEDc/KHV5esfckBQG06VUZU0WhFNmKx7175ePnuE16aBOUR7N4L/3JL3EmM2s
         QhK8NSMnRr6Wjznv1bEkUoBuCf49BgaSEALsdSlUH+byg4ZLIrYesrrz1YPH+jV468Sp
         +Umohq6Yr/ph7m9QjIO/ggMlgojRyoIOgjxfXF7RH5/YUp0KLR2B64Hev3QzIzcmocMC
         kfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688396035; x=1690988035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj6RWQmoOrElPG2s/9G/TB0K+w3PkNfdcrWXDb193cE=;
        b=CEmDkZEgcoX6khqd2wQTfM8En5ZIAxeEC59GEVCfcnCV/QvIGKWZiKO9QZSlHFkHKJ
         4RjrgM64aJtUzJjDaZ8E2YsAGLDhkTDME5SQrf0R1hSVZj+mo8u23Cs+5L28/TBDxPoM
         1kkQEWA/d18fIe9il88iV6UFOvSlAsHtgcKnf8mxpg8nw4RVbueXyMDQLt1oT3ZBZCtn
         jQC/tjG2uxAcRCbsKrpNMC0SaPyFQ+BV9lglfbJ120y3WgEFvTprgDIj2IELy8YKBpZX
         mb0Oln3lGqFVpm0Bv/hhzPbgBeN7K3sWwm8HQfV4JaB8oseNJiNKJ0uzIXFqcg/L1qLy
         ieSA==
X-Gm-Message-State: ABy/qLZEyBHqqk5zAQqObWSgZClyn0E1w0ofzpp/9sqqRaxi/zjPgrPQ
        vPQsgtjTePK+nda1/HX4Quqbc2G0PJtrNA==
X-Google-Smtp-Source: APBJJlF+iQsKkzG2SHIpy1NJ1dEY9n2aYfijsAOWhIkdZ0QNYZ+2WjrrSX6nPmU8MHrZANAIcCdcWg==
X-Received: by 2002:a17:906:5904:b0:98e:973:d39f with SMTP id h4-20020a170906590400b0098e0973d39fmr8177403ejq.33.1688396035170;
        Mon, 03 Jul 2023 07:53:55 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090681d200b00992ed412c74sm4545661ejx.88.2023.07.03.07.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 07:53:54 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] dmaengine:idxd: Use local64_try_cmpxchg in perfmon_pmu_event_update
Date:   Mon,  3 Jul 2023 16:52:37 +0200
Message-ID: <20230703145346.5206-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Use local64_try_cmpxchg instead of local64_cmpxchg (*ptr, old, new) == old
in perfmon_pmu_event_update.  x86 CMPXCHG instruction returns success in
ZF flag, so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

No functional change intended.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 drivers/dma/idxd/perfmon.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
index d73004f47cf4..fdda6d604262 100644
--- a/drivers/dma/idxd/perfmon.c
+++ b/drivers/dma/idxd/perfmon.c
@@ -245,12 +245,11 @@ static void perfmon_pmu_event_update(struct perf_event *event)
 	int shift = 64 - idxd->idxd_pmu->counter_width;
 	struct hw_perf_event *hwc = &event->hw;
 
+	prev_raw_count = local64_read(&hwc->prev_count);
 	do {
-		prev_raw_count = local64_read(&hwc->prev_count);
 		new_raw_count = perfmon_pmu_read_counter(event);
-	} while (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-			new_raw_count) != prev_raw_count);
-
+	} while (!local64_try_cmpxchg(&hwc->prev_count,
+				      &prev_raw_count, new_raw_count));
 	n = (new_raw_count << shift);
 	p = (prev_raw_count << shift);
 
-- 
2.41.0

