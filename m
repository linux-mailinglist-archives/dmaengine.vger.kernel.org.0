Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2E977B181
	for <lists+dmaengine@lfdr.de>; Mon, 14 Aug 2023 08:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjHNGXL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Aug 2023 02:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjHNGWw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Aug 2023 02:22:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A258E6D;
        Sun, 13 Aug 2023 23:22:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso22144315ad.1;
        Sun, 13 Aug 2023 23:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691994172; x=1692598972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbPoi4ehPomih+rqf88RiO5h1U0eqpVIVYqKIjGhfGk=;
        b=KhDw23MPuanlxAjuOO9NR13Z2WYuW3raUWEz4gIyh50I7S9W6COU84lhou/islhuWG
         JSx1EdP5rUQ3HOxdGBLpqirzE99ZgMAYgbX8x8oGoqV1ji/NhTp+mhJtiY0l75uA+ey1
         l+P6LErd6YseDOnBrum+aHGJFn4hM9kHv45mTXp3WTfX+2/JiV7xri8y+AJ7eMBl7tcB
         15lOshmWIrGSCgi7f2W0zY0Sl64bW/DTBmkHWfdOjDfBlDmqHTUdINaKD9xw6BOuVO+e
         F4VqOvUd2DK5uPI8wczYxmc31wK+Zx3nY33dGPlzuX2WsQOBUHqolD3hyjNnJegTQFcR
         SLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691994172; x=1692598972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbPoi4ehPomih+rqf88RiO5h1U0eqpVIVYqKIjGhfGk=;
        b=AYVttxnexOvPDbZsNdfOMA3oKg/pDizIlS3tEsbLClQGw2+gpGlv1S/hjanGZZHkJp
         PmtGGolVgQCCCCJhCRLYw7VVnNpoQOJlrk+1RWzqBMe0Jgp42hypxnFinj7NCLrVIDUR
         C8k/PmP9hBRYZ8SBD5aOilAY3CYHmydaXlPwg0CAdfPvRL0QauKDhFRKZaBVMGFsY7gT
         nB/U+K88UTBrlIJ7wvIZGGNs+V1CcTONu8mWggIgcBg+VoHpnLoj67bTcgQv5NoZPiV3
         VO7IXuH8dp86OUDpyNezEwkRnt1/TsK86/YQQ5qaxJXYz2/VdySivMp8RUCmJlsNwnjp
         PzPg==
X-Gm-Message-State: AOJu0Ywjj/VZVxVP6YL1DCEKpecxK9RKhxVBaQpICSGB0qSASUxEHz76
        S8WcwTygK3SA8iO7Q9z5uWk=
X-Google-Smtp-Source: AGHT+IF+hhw4+dNlT2tD/DxR4eF682l4n3CUzSyipbEn7gbo8Ubv6r7h5vVViuR8MLR8LniVrE9L/w==
X-Received: by 2002:a17:902:e550:b0:1bb:809d:ae72 with SMTP id n16-20020a170902e55000b001bb809dae72mr8763076plf.33.1691994171421;
        Sun, 13 Aug 2023 23:22:51 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:103c:3fe4:b95c:5882:bac7:2668])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ab8200b001b9da42cd7dsm8434571plr.279.2023.08.13.23.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 23:22:50 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH] dma: dmatest: Use div64_s64
Date:   Mon, 14 Aug 2023 11:52:46 +0530
Message-Id: <20230814062246.4636-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

In the function do_div, the dividend is evaluated multiple times
so it can cause side effects. Therefore replace it with div64_s64.

This fixes warning such as:
drivers/dma/dmatest.c:496:1-7:
WARNING: do_div() does a 64-by-32 division,
please consider using div64_s64 instead.

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
---
 drivers/dma/dmatest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index ffe621695e47..07042f239db8 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -9,6 +9,7 @@
 
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/math64.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/freezer.h>
@@ -493,7 +494,7 @@ static unsigned long long dmatest_persec(s64 runtime, unsigned int val)
 
 	per_sec *= val;
 	per_sec = INT_TO_FIXPT(per_sec);
-	do_div(per_sec, runtime);
+	per_sec=div64_s64(per_sec, runtime);
 
 	return per_sec;
 }
-- 
2.25.1

