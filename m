Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7864C77A67E
	for <lists+dmaengine@lfdr.de>; Sun, 13 Aug 2023 15:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjHMNWI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 13 Aug 2023 09:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMNWH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 13 Aug 2023 09:22:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405EB1710;
        Sun, 13 Aug 2023 06:22:10 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-687ca37628eso3383615b3a.1;
        Sun, 13 Aug 2023 06:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691932930; x=1692537730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rlAU7V+DE92fJK3cHH1A9FDJdGr7RffOpPtSmRFtDOA=;
        b=ofNTcR3bb3mvxTKI8DCM7SH4HItpLkos7Td4MnrUAyjxsmAwli7lDq7uTy5s95Zh4p
         SvBAxVDbRQQuEWdWPKs65HJRzcXXWPrB9321MW38gvU7y1D4t9MGk6ZFBmPy/6+gP+EW
         rRbb+kxp5m+w++H8F5grAM/Fyyj2AJu0uZGywyjDtmEO9fH5nGc2+sZPHunbU/CKPkxO
         dUAzObiaAhozGgnBOQZ26H5hmx/lTQukBA5Jx1Hx7inNJtTAQORwrmy5mhqIeq4/khjX
         31P7A3d8uDPVuCouEtWvW0Y/tIaWfLeNUk/vSM6yrl7k9TUfhCX++ZAan3tS+dwEcWhL
         +Hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691932930; x=1692537730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlAU7V+DE92fJK3cHH1A9FDJdGr7RffOpPtSmRFtDOA=;
        b=jBrXSJO1kWx51APPT6KnJs8gRHG5CPUm7rHKuHMTJxFtEoMkB1GCmHM1iKlWVWxXcp
         j/UCHPLvIVYq5Q+wKGAPmPNbKnEddb1Fr1h/Z2WZbwXkbZrOlaQgjYRGH+MqlgO7fUOM
         x9IVuTQS2+ZpSrjmKdOGtrnhiko2hcgycixgo/pBmPw4j7dj2ENwTLsg0VoUhb7sX21T
         jvqhrruzRV9sN2YCynACqKZ1ju7riqDrGGHrg6pa35vcVIutDrvAfKRrq9WjalU3Kdzo
         huWsrB1Zh5TVhYLqjhAkmetb6l7uVLytwTc0DVtfDU1RZ7GRJTtd79CZee/lGkHNiEhn
         jzDA==
X-Gm-Message-State: AOJu0YzcIp+KJVaILJ79I5eRVFM2HBN5Ybz287geaMrftg3TvG707Btv
        V7gXlRRjbdZwViJMdw3mYW4=
X-Google-Smtp-Source: AGHT+IHdYotXitNOi15TdfxNA3enRhYX4Vvgdv/GuDs9z6Ks2Qh1fh2iimVWPqCSEnJmIf8liIZ/aw==
X-Received: by 2002:a05:6a00:ad3:b0:687:20d6:fade with SMTP id c19-20020a056a000ad300b0068720d6fademr10219995pfl.20.1691932929613;
        Sun, 13 Aug 2023 06:22:09 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1022:f538:d00a:1992:423:e24e])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78008000000b00682868714fdsm6419824pfi.95.2023.08.13.06.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 06:22:09 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     fenghua.yu@intel.com, dave.jiang@intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH] dma: device: Remove redundant code
Date:   Sun, 13 Aug 2023 18:52:03 +0530
Message-Id: <20230813132203.139580-1-coolrrsh@gmail.com>
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

dma_alloc_coherent function already zeroes the array 'addr'.
So, memset function call is not needed. 

This fixes warning such as:
drivers/dma/idxd/device.c:783:8-26:
WARNING: dma_alloc_coherent used in addr already zeroes out memory,
so memset is not needed.

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
---
 drivers/dma/idxd/device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5abbcc61c528..7c74bc60f582 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -786,8 +786,6 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
 		goto err_alloc;
 	}
 
-	memset(addr, 0, size);
-
 	spin_lock(&evl->lock);
 	evl->log = addr;
 	evl->dma = dma_addr;
-- 
2.25.1

