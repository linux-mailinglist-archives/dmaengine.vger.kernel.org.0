Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251945F472C
	for <lists+dmaengine@lfdr.de>; Tue,  4 Oct 2022 18:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJDQJR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Oct 2022 12:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJDQJQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Oct 2022 12:09:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03885AC4B;
        Tue,  4 Oct 2022 09:09:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r13so590566wrj.11;
        Tue, 04 Oct 2022 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Hp8lb9LNUEjxKTnwJHF8rLkRYlGGlRrTvDi1FIM2Zvc=;
        b=j0U9rwRRSDQB7YDWzunD6M/etGelaZu8X+O0jd3R5f8FIewDu2T96w1VNNG/ZEaZdW
         poEOMFNV/9WeVvCAHC/seukhzJDnsv2MeiB9ruMllZFtWb11i8R0o07t85qfdT1GaNc5
         x+XadsVvo/X87mMHkY/CrmNvBOdqc5x7QpUO9vYn3uGCClk8M+oxWqGU35tKeL99gqQl
         1szAKHljjSz/pBLCySdbEjJ7V95Gf0VDZ3SBHFBnvmxEjnPUaqbpCN9Ff3iG3ZDlOW7Q
         +Vh1xqBI2zE7I9YEngak123bSw0UbBVbgTqXJ34qfE+ETwCjTZnUJ3ehdTB9TwLeN9lE
         aQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Hp8lb9LNUEjxKTnwJHF8rLkRYlGGlRrTvDi1FIM2Zvc=;
        b=t2dEmuY0jmSSZhaTFJzX2KCE+IGVp5dK3mdEADtS/gFoqR2jKQNYoTMB0H31yyK+WU
         SmBrZOaRs9F6lOwy91bEOa1UgLe7HfBIz/ntphvA5ll70STpyfcVwoPQ6BG6K6Cvm9/6
         dUuVk6eqZkm7QO4WRdMkB8fJLuDcYLBrhSAgDvYA2r4QtlTwoU14TKleteoawpMuRLh+
         7fmaUXQDJG4jYWwqoewfdTHMqSJL0EctmTld54EHnPskw+xP+gGeopBDm2hQs4dP8eci
         hMVp3WyjwxyoYZEGpqRYnM28SDRyFfrI8/D8nOFqQ4AGjB1hpoYEgfMClglGXeMuM77e
         xuuA==
X-Gm-Message-State: ACrzQf3o8RnM7KjlhyTlkoa8jNHrRxG0QXukULM4A5Oqv1k4iXgW5CGC
        qxlhfryFT4x9B11KGLDbi68=
X-Google-Smtp-Source: AMsMyM7YaciASkj4eSwgrzc0+S5/9x4rUKLbrNao+kbesZ5L5FALlzLQJnA4xtTjBUjhFu5yOk2mYw==
X-Received: by 2002:adf:ef43:0:b0:22d:c507:dd48 with SMTP id c3-20020adfef43000000b0022dc507dd48mr12756478wrp.416.1664899754525;
        Tue, 04 Oct 2022 09:09:14 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c3b0700b003a1980d55c4sm21708298wms.47.2022.10.04.09.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:09:14 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: ioat: Fix spelling mistake "idel" -> "idle"
Date:   Tue,  4 Oct 2022 17:09:13 +0100
Message-Id: <20221004160913.154739-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in the module description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/dma/ioat/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index e2070df6cad2..79d244011093 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -33,7 +33,7 @@ MODULE_PARM_DESC(completion_timeout,
 static int idle_timeout = 2000;
 module_param(idle_timeout, int, 0644);
 MODULE_PARM_DESC(idle_timeout,
-		"set ioat idel timeout [msec] (default 2000 [msec])");
+		"set ioat idle timeout [msec] (default 2000 [msec])");
 
 #define IDLE_TIMEOUT msecs_to_jiffies(idle_timeout)
 #define COMPLETION_TIMEOUT msecs_to_jiffies(completion_timeout)
-- 
2.37.1

