Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E697FD326
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2019 04:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKODKf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Nov 2019 22:10:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42223 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfKODKe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Nov 2019 22:10:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id s5so5645200pfh.9
        for <dmaengine@vger.kernel.org>; Thu, 14 Nov 2019 19:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TRkIoUi0GBj9I4dT2JvmosKGsiQbJSEbDRvIbo63/Gs=;
        b=fYgwOJG4p9E2bxbHOo4pCi89Hr08mSB/gRVLkMDo8YVyIIskkfZmcetI7SGL1kvyqy
         3eO1N/T57ru6/euwUaEJejoKH6VZACKTd5iN4k1772MFSuuka+MmixMTp3yVdTIpQGK2
         6XY3GqQeP5Yla8O5YPKiW+8loVXwnFV6MAaE8ptt3nqnwPYGr4CMtkGhjPr9UilcBvvh
         sBZ0Yqczu5m/VGWJ+dJ1fphpOECSRurVOpLgb5VHTqsXsuFmgZaI3IlO7FE9T93iRSFt
         UakLoWh57bVXCLTBaVk1wXwvKzlONOWYRoxwdIOs4uuBK5IwWRy4XqgQVfKVfu3Zjd7J
         mHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TRkIoUi0GBj9I4dT2JvmosKGsiQbJSEbDRvIbo63/Gs=;
        b=B5KKCvoRtj6Q+W9SD3D7SBs6IUmN2he0Cq78Tc7jhVn2XOAwm+9N1H4LfIoHxUInQE
         Ug9ZUTfBVOhqxYGWtuYRzbmyk4i/gs0dnhRnC+I4KJ6gFdJn3B2mtvqPbWB9YftSrzM8
         GB0NAl8mJdVAGYfjbFqXVWYY4tTOfauyo9/zl7c8DRkq8QXPwQpV1DzQqSfQnMebJkad
         Nu0Hl3FoUfawOIkj8A7xdtH2pvOrU6v8zFjT00RK7CbqdhXJraOkDWDWU57eEyYLF9Ck
         f28SlPV+O5ucjJS5m1S/dzYKhtGBhagrTwLS74fIBF8p+nX6zxHNi5D35yT+Rb123TDW
         4vDw==
X-Gm-Message-State: APjAAAVwJzGUQNXBzB1SaF4jXFAaJ/DDxinuxSwK27+ULN1H6S5Ai95w
        4nTRGRiY07EVcaY1FkIfN6OP8A==
X-Google-Smtp-Source: APXvYqxUrktXvFs7jzxCHAmUbP3k8BfyrSbz4O+ZCgj98MyJK5NAdeX2EiyFlAwcnLMJqUyG3/Rkag==
X-Received: by 2002:a63:f743:: with SMTP id f3mr10817140pgk.410.1573787431911;
        Thu, 14 Nov 2019 19:10:31 -0800 (PST)
Received: from localhost.localdomain (111-241-173-86.dynamic-ip.hinet.net. [111.241.173.86])
        by smtp.gmail.com with ESMTPSA id z23sm7260287pgj.43.2019.11.14.19.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 19:10:31 -0800 (PST)
From:   Green Wan <green.wan@sifive.com>
Cc:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: sf-pdma: fix kernel-doc W=1 warning
Date:   Fri, 15 Nov 2019 11:10:09 +0800
Message-Id: <20191115031013.30448-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix kernel-doc W=1 warning. There are several comments starting from "/**"
but not for function comment purpose. Remove them to fix the warning.
Another definition in front of function causes warning. Move definition
to header file.

kernel-doc warning:

drivers/dma/sf-pdma/sf-pdma.c:28: warning: Function parameter or member
	'addr' not described in 'readq'
drivers/dma/sf-pdma/sf-pdma.c:438: warning: Function parameter or member
	'ch' not described in 'SF_PDMA_REG_BASE'
drivers/dma/sf-pdma/sf-pdma.c:438: warning: Excess function parameter
	'pdma' description in 'SF_PDMA_REG_BASE'

Changes:
 - Replace string '/**' with '/*' not for comment purpose
 - Move definition, "SF_PDMA_REG_BASE", fomr sf-pdma.c to sf-pdma.h

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 3 +--
 drivers/dma/sf-pdma/sf-pdma.h | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 16fe00553496..465256fe8b1f 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * SiFive FU540 Platform DMA driver
  * Copyright (C) 2019 SiFive
  *
@@ -435,7 +435,6 @@ static int sf_pdma_irq_init(struct platform_device *pdev, struct sf_pdma *pdma)
  *
  * Return: none
  */
-#define SF_PDMA_REG_BASE(ch)	(pdma->membase + (PDMA_CHAN_OFFSET * (ch)))
 static void sf_pdma_setup_chans(struct sf_pdma *pdma)
 {
 	int i;
diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
index 55816c9e0249..0c20167b097d 100644
--- a/drivers/dma/sf-pdma/sf-pdma.h
+++ b/drivers/dma/sf-pdma/sf-pdma.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/**
+/*
  * SiFive FU540 Platform DMA driver
  * Copyright (C) 2019 SiFive
  *
@@ -57,6 +57,8 @@
 /* Error Recovery */
 #define MAX_RETRY					1
 
+#define SF_PDMA_REG_BASE(ch)	(pdma->membase + (PDMA_CHAN_OFFSET * (ch)))
+
 struct pdma_regs {
 	/* read-write regs */
 	void __iomem *ctrl;		/* 4 bytes */

base-commit: a7e335deed174a37fc6f84f69caaeff8a08f8ff8
-- 
2.17.1

