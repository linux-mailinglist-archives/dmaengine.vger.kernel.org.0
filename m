Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E24F448A4
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2019 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393276AbfFMRKL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jun 2019 13:10:11 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:52556 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfFLWyY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jun 2019 18:54:24 -0400
Received: by mail-yb1-f202.google.com with SMTP id w6so16742229ybp.19
        for <dmaengine@vger.kernel.org>; Wed, 12 Jun 2019 15:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cg4GgLRitlpfBz4sDsL5vn6FUGoGpxbPJh3gLwSUUBQ=;
        b=ZLHNttwEAgZTax7rHR8gaWDTXQZJ50l9DUDJnEdnLxBOaXGxDAr82EtnSc5BX1ZWBu
         nGJKRhsThNGVvZjC//PkMhwScvrQlOyP9acktXyXZiLBLkohjjzxz9oQK/GLNKEE0WbS
         CekX2XykSzztg5BPNJ4Ba1pKuiiPYL3QuR3V8LRPu1FUPcNtlHbxIDMVZPvOEX6qH0ZT
         RX5KjrpwAaxBp7PiupG96uSfVr0LPni1gXJftlW/tejqqKtNqYr8nzXyxYJX9DhpHfWT
         cgWOXAcDsqT373njAwO6alaZyznYwla1mQVySwvSwEa8/FXROvDQH8tYtIij7HTFtbm4
         hIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cg4GgLRitlpfBz4sDsL5vn6FUGoGpxbPJh3gLwSUUBQ=;
        b=oFrVwz6ymtXVilIfFc6dkj9z5UEZzjfefhXIEImKpSAC85Dc3c1VDsLh0ToaY01GPE
         BsyF2+rHvOFa9kFbzZBx5YQQl3KdIrQkbmDiZcHAPXktHzXKDbQUqH1H/imlOZgBK75v
         EhT6LBH52DcWkHi2ZgrHkkoEti4nGqwpBDun1hQKi/qK5EuMMiF90JuihvxhgfeGo0lV
         GruQnNQLkB92Uu/TGGNJRi4VmSCbVQxTjrtNZyu6ZzcxoG9mXAPABVSbVt7dfwBZ9Xek
         6HDRa/4wzTMP5eyQiMyJz/tMT+7t5yIJx4yus9nj9+5Enuwda7FJW0q2G/UFEHjZZWeZ
         q07w==
X-Gm-Message-State: APjAAAUP14xDggOU2BAuBwemAazdLE4E0R8aEFzvXwrBtAm9KfWk/zUu
        rPw38G/333YqQIFpSrqtTATGht0pog==
X-Google-Smtp-Source: APXvYqyp1vwDO0ridmK87WclU3RaE0JJbNMleIO7nj8j5IDLHINL+tdloA5ZhJOYL7Kuj/7NKE884DhW4w==
X-Received: by 2002:a25:87:: with SMTP id 129mr41644872yba.196.1560380063404;
 Wed, 12 Jun 2019 15:54:23 -0700 (PDT)
Date:   Wed, 12 Jun 2019 15:54:19 -0700
Message-Id: <20190612225419.241618-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH] dmaengine: mv_xor_v2: Fix -Wshift-negative-value
From:   Nathan Huckleberry <nhuck@google.com>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Clang produces the following warning

drivers/dma/mv_xor_v2.c:264:40: warning: shifting a negative signed value
	is undefined [-Wshift-negative-value]
        reg &= (~MV_XOR_V2_DMA_IMSG_THRD_MASK <<
	MV_XOR_V2_DMA_IMSG_THRD_SHIFT);
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
drivers/dma/mv_xor_v2.c:271:46: warning: shifting a negative signed value
	is undefined [-Wshift-negative-value]
        reg &= (~MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK <<
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^

Upon further investigation MV_XOR_V2_DMA_IMSG_THRD_SHIFT and
MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT are both 0. Since shifting by 0 does
nothing, these variables can be removed.

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/521
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/dma/mv_xor_v2.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index fa5dab481203..5d2e0d1f3ec9 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -33,7 +33,6 @@
 #define MV_XOR_V2_DMA_IMSG_CDAT_OFF			0x014
 #define MV_XOR_V2_DMA_IMSG_THRD_OFF			0x018
 #define   MV_XOR_V2_DMA_IMSG_THRD_MASK			0x7FFF
-#define   MV_XOR_V2_DMA_IMSG_THRD_SHIFT			0x0
 #define   MV_XOR_V2_DMA_IMSG_TIMER_EN			BIT(18)
 #define MV_XOR_V2_DMA_DESQ_AWATTR_OFF			0x01C
   /* Same flags as MV_XOR_V2_DMA_DESQ_ARATTR_OFF */
@@ -50,7 +49,6 @@
 #define MV_XOR_V2_DMA_DESQ_ADD_OFF			0x808
 #define MV_XOR_V2_DMA_IMSG_TMOT				0x810
 #define   MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK		0x1FFF
-#define   MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT		0
 
 /* XOR Global registers */
 #define MV_XOR_V2_GLOB_BW_CTRL				0x4
@@ -261,16 +259,15 @@ void mv_xor_v2_enable_imsg_thrd(struct mv_xor_v2_device *xor_dev)
 
 	/* Configure threshold of number of descriptors, and enable timer */
 	reg = readl(xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_THRD_OFF);
-	reg &= (~MV_XOR_V2_DMA_IMSG_THRD_MASK << MV_XOR_V2_DMA_IMSG_THRD_SHIFT);
-	reg |= (MV_XOR_V2_DONE_IMSG_THRD << MV_XOR_V2_DMA_IMSG_THRD_SHIFT);
+	reg &= (~MV_XOR_V2_DMA_IMSG_THRD_MASK);
+	reg |= (MV_XOR_V2_DONE_IMSG_THRD);
 	reg |= MV_XOR_V2_DMA_IMSG_TIMER_EN;
 	writel(reg, xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_THRD_OFF);
 
 	/* Configure Timer Threshold */
 	reg = readl(xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_TMOT);
-	reg &= (~MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK <<
-		MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT);
-	reg |= (MV_XOR_V2_TIMER_THRD << MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT);
+	reg &= (~MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK);
+	reg |= (MV_XOR_V2_TIMER_THRD);
 	writel(reg, xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_TMOT);
 }
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

