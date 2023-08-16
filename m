Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05B677DA17
	for <lists+dmaengine@lfdr.de>; Wed, 16 Aug 2023 08:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241845AbjHPGEY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Aug 2023 02:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241991AbjHPGEI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Aug 2023 02:04:08 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D099D1984;
        Tue, 15 Aug 2023 23:04:07 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3741581a12.2;
        Tue, 15 Aug 2023 23:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692165847; x=1692770647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbPoi4ehPomih+rqf88RiO5h1U0eqpVIVYqKIjGhfGk=;
        b=fAN3GcynkbGimSGd2qlO/ZSNWCeT3xkrYpQcSIIZBCfaZUGK136dTx7VICBO/DLBNy
         n0dLVuxcOvRL8EOHgnJY0tC+nJI26VtMve8hYOh7OH7cNGfBwEwYi5WzXM4hJJPgjG35
         VxpIziT3Ps/7HldFE1PM/AnvsUSIRHHH4yhQxR8Iw/5UNldR37lTpqJtd8AKMR0YNZ4T
         UPo0YFT1KwDdO9b4HEVvyDNpk5COap+IynGbHMU3A1WdN2qDW24XmoKEzFMHDKbI+5F/
         Z+YHLEolVPM9DYCqtH+dllQBx/t7zDoTV3u1Sn9jK4H4qFtvQd4RqE4Ni8rvmkc73QjT
         3rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692165847; x=1692770647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbPoi4ehPomih+rqf88RiO5h1U0eqpVIVYqKIjGhfGk=;
        b=jFKuj26si88Lwug5wgBB/g0DxEVCZHvstHEY1zH8oypEpka+eaGU421SOrHItk0YyG
         OzGD7NdxG5ey3R66PrJvmIuZ6j8lctEpetDZpVkTlSEgWkasJ7BfRNbSME5UI2/4Z19u
         lEsZU9LYeoK+EbVwC+ptyzsitK48TzJQ7E3IY7dNi3QCaaJwmGO7OiVG5RY1tBapt33K
         GqxTBObRcRnCRWqNYS4s5r0Hic+O99fGjUeq+6zvODv8JIkMKwyIrkJKXMSmM0fer7fP
         0gHdUp23oid15KMsHm+MeJZUFmKQyVkHxqONUX08YkoLfUYn6HKZfEkhPUPfGcVlxNOW
         AdRA==
X-Gm-Message-State: AOJu0YzHERe8vXYn2r8sbtH8ftPi/tc/ngPl81xED+O2uImeMvf/0qNs
        UeN+T1P9wxIudZIpBWwCx3ez2WN3WSY=
X-Google-Smtp-Source: AGHT+IHCvKBGYexTHi4GxrfOP23dA+hKP/eU7GIHNxlDSlDm0J0q4sI4luT5s/Z9TtM8wQP8JQZgSA==
X-Received: by 2002:a17:902:e892:b0:1be:f2a1:22d8 with SMTP id w18-20020a170902e89200b001bef2a122d8mr484944plg.14.1692165847095;
        Tue, 15 Aug 2023 23:04:07 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:100b:771e:e5ae:d854:9f75:d38f])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001b89466a5f4sm12093376plx.105.2023.08.15.23.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 23:04:06 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH] dma: dmatest: Use div64_s64
Date:   Wed, 16 Aug 2023 11:34:00 +0530
Message-Id: <20230816060400.3325-1-coolrrsh@gmail.com>
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

