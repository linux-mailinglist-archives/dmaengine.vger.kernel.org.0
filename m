Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7702E256790
	for <lists+dmaengine@lfdr.de>; Sat, 29 Aug 2020 14:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgH2Mqb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 29 Aug 2020 08:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH2Mq2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 29 Aug 2020 08:46:28 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F57C061236;
        Sat, 29 Aug 2020 05:46:20 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id u1so1498277edi.4;
        Sat, 29 Aug 2020 05:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e52rc4zDcLwYIKS8oi+duVhjBLUdNkpPNyhl018nj50=;
        b=Hew/ODMpbqiuT9ygl7dWUZSpQZgywitQhWoLluFmNui8dQaHgiK/bLImqDIrgVgAQ5
         PjRIH9yQC8MLwQP4HNuy6fJVJ3XVryhg96DmdtzoH6ZxSSNHpqFp3V+s+EOFkwunED2x
         kt2Yt1RHfXzxHedJakqGsX5XYPoiIf4okPs5x8wGGd8+VqKBzd4njqmVYIvA6g9J5fFq
         xTLWqaOOwU3VW1//s34T1bR0hSQqu9FGRT9ZftBUnN1nxtA0tjPBWywms2S4HPQFdzzn
         /ADSzcrhdFDm7mfsxvuxkN2qEdKnYTAMIuJI5i5jyLweW8HTZnmHWo56owUWOsvr3zMs
         qTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e52rc4zDcLwYIKS8oi+duVhjBLUdNkpPNyhl018nj50=;
        b=qv6Pd+7BBY4MF788c1YpQJnj5rrVzZxp+GGmGbIDSvMYPasI4HL7jtQGssqQwYoqoY
         BK7BkpaLeRciU7aj47O6yUnhgPusjIEyMXsWPxH1DiY++VGA1uqpmME0gy0hhje1xYk6
         RQLPhLifclZe9EzeEXGuAF8tZDIR6QTy+pdOJ+5RrX54Gt6WcplXDRFXIeEjIpAVh8Zt
         OXzzKXDJsiJIjQHB3kRDny+UZa5P7CyjGztqlv9sFSYED+4UjVXrs2l3Yy4FsNd6gZ7y
         YDigKhV17ZsnuSvFgIHkP/FANpaEI06FQyDnFwyvZhyIKQRdfaIh8NasVrUukP+4+VQ3
         /17Q==
X-Gm-Message-State: AOAM531IrIbDwSAUWva9hOMSXO37Eg08CuQKUx4RuAfgq8gcbt+KnH7i
        2Lyr/hXfAd4zFV5Bju8SxZA=
X-Google-Smtp-Source: ABdhPJzcjxxnjokV5mGXr56iS0uOolltS1jUKTNzwMECcvPSzNJ1LTFu8Bh5mASuKnhQx67V/u4hGg==
X-Received: by 2002:a50:b946:: with SMTP id m64mr3374913ede.92.1598705179494;
        Sat, 29 Aug 2020 05:46:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:414a:8107:3def:ee41])
        by smtp.gmail.com with ESMTPSA id h2sm2054664edz.60.2020.08.29.05.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 05:46:18 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fsldma: fsl_ioread64*() do not need lower_32_bits()
Date:   Sat, 29 Aug 2020 14:45:38 +0200
Message-Id: <20200829124538.7475-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200829105116.GA246533@roeck-us.net>
References: <20200829105116.GA246533@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For ppc32, the functions fsl_ioread64() & fsl_ioread64be()
use lower_32_bits() as a fancy way to cast the pointer to u32
in order to do non-atomic 64-bit IO.

But the pointer is already 32-bit, so simply cast the pointer to u32.

This fixes a compile error introduced by
   ef91bb196b0d ("kernel.h: Silence sparse warning in lower_32_bits")

Fixes: ef91bb196b0db1013ef8705367bc2d7944ef696b
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: Zhang Wei <zw@zh-kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/dma/fsldma.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 56f18ae99233..6f6fa7641fa2 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -205,7 +205,7 @@ struct fsldma_chan {
 #else
 static u64 fsl_ioread64(const u64 __iomem *addr)
 {
-	u32 fsl_addr = lower_32_bits(addr);
+	u32 fsl_addr = (u32) addr;
 	u64 fsl_addr_hi = (u64)in_le32((u32 *)(fsl_addr + 1)) << 32;
 
 	return fsl_addr_hi | in_le32((u32 *)fsl_addr);
@@ -219,7 +219,7 @@ static void fsl_iowrite64(u64 val, u64 __iomem *addr)
 
 static u64 fsl_ioread64be(const u64 __iomem *addr)
 {
-	u32 fsl_addr = lower_32_bits(addr);
+	u32 fsl_addr = (u32) addr;
 	u64 fsl_addr_hi = (u64)in_be32((u32 *)fsl_addr) << 32;
 
 	return fsl_addr_hi | in_be32((u32 *)(fsl_addr + 1));
-- 
2.28.0

