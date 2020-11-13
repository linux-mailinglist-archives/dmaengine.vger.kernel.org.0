Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CBB2B16FF
	for <lists+dmaengine@lfdr.de>; Fri, 13 Nov 2020 09:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgKMINZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Nov 2020 03:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgKMINZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Nov 2020 03:13:25 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77749C0613D1;
        Fri, 13 Nov 2020 00:13:06 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id oq3so12055276ejb.7;
        Fri, 13 Nov 2020 00:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UjUFjlo+lUVXh8aCv+mLF8td/QwZTXfYmMYnlYnHUQY=;
        b=a0MVam7prtCppJVUx7x8/S5UjN0gVePh0iKNlHZpI5aYqnWk0lwk34/fQSR55nCvKZ
         svaJIKfrPmDxNw26TVSO3n/8PZj2dmNHXT7c+pP0Uo0NnVR7pXWlIRhw5q4uRwAh/d8q
         v3yyoaAq18OfnHt2qdMouaMcSDDQDrY4Rb42f6woKXLLGjcBhZG+XVyx1EA2DpuGeX78
         JFPTCwcTrUA4YqR8EqDnkHdq93RK9ALQF9cD3pJyRlApSyjpFoB4e5wlzjh0wtv6YsGC
         fzKpE61vIe6tDyUOoFhbLIQgXFCdMePK1fueDfudymqH50J87CIIvxH7NKeY4WcvBqQU
         vpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UjUFjlo+lUVXh8aCv+mLF8td/QwZTXfYmMYnlYnHUQY=;
        b=Q281S5BDEmeenmu8snXS51RDqQdfLBKOjPM2qu/HvWQBUhwm4gLWoE/GC23XQzxAEm
         nmK5l8x6OrNPjbyoY6GgHdwH4mt1vXhWvRp2i+Ig4xsOlrOVaOQsHwyzfUXlhhvukhBu
         MFAf+zl72ogLQT5gShncdwEDQWLOQYxVE+mYagLx7SVGOpcsoXOuo5HU6p3vZ/ZQ0LAi
         5+8EDZbMeJ0gP7HFbI0MCjJ3ixkP+vphGPPNX6oasB0NzwWP/TyFr5CKOdTxhxJGKbcV
         qPyvpcXpsyqyU6Yec7YKnuVqlXb5VDy+LoxUH5iPr4iFLNTYR3F+Cxi7+u9GhorDBrKv
         Jikg==
X-Gm-Message-State: AOAM531ReeURtAjwTWJGBnRE9jSKMdFJgeM+vSMRY/no6pGbMSyvRWSe
        wxqPhIMyy4CCuQAibkV925N7zP36b0rsGQ==
X-Google-Smtp-Source: ABdhPJzYr0uqqkZpmU5AkBmZGruoS+wNbzoXwSoxwwYoPZUxVaKF/+NbFzed2xC0HWR9bTAVkLD3BQ==
X-Received: by 2002:a17:906:3d1:: with SMTP id c17mr838007eja.187.1605255185182;
        Fri, 13 Nov 2020 00:13:05 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2de6:6700:5d16:c2b3:483:ff70])
        by smtp.gmail.com with ESMTPSA id n25sm3075936ejd.114.2020.11.13.00.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 00:13:04 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Maciej Sosnowski <maciej.sosnowski@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Cc:     Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] dmaengine: ioatdma: remove unused function missed during dma_v2 removal
Date:   Fri, 13 Nov 2020 09:12:48 +0100
Message-Id: <20201113081248.26416-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit 7f832645d0e5 ("dmaengine: ioatdma: remove ioatdma v2 registration")
missed to remove dca2_tag_map_valid() during its removal. Hence, since
then, dca2_tag_map_valid() is unused and make CC=clang W=1 warns:

  drivers/dma/ioat/dca.c:44:19:
    warning: unused function 'dca2_tag_map_valid' [-Wunused-function]

So, remove this unused function and get rid of a -Wused-function warning.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201112

Maciej, please ack.

Vinod, Dan, please pick this minor non-urgent clean-up patch.

 drivers/dma/ioat/dca.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/dma/ioat/dca.c b/drivers/dma/ioat/dca.c
index 0be385587c4c..289c59ed74b9 100644
--- a/drivers/dma/ioat/dca.c
+++ b/drivers/dma/ioat/dca.c
@@ -40,16 +40,6 @@
 #define DCA2_TAG_MAP_BYTE3 0x82
 #define DCA2_TAG_MAP_BYTE4 0x82
 
-/* verify if tag map matches expected values */
-static inline int dca2_tag_map_valid(u8 *tag_map)
-{
-	return ((tag_map[0] == DCA2_TAG_MAP_BYTE0) &&
-		(tag_map[1] == DCA2_TAG_MAP_BYTE1) &&
-		(tag_map[2] == DCA2_TAG_MAP_BYTE2) &&
-		(tag_map[3] == DCA2_TAG_MAP_BYTE3) &&
-		(tag_map[4] == DCA2_TAG_MAP_BYTE4));
-}
-
 /*
  * "Legacy" DCA systems do not implement the DCA register set in the
  * I/OAT device.  Software needs direct support for their tag mappings.
-- 
2.17.1

