Return-Path: <dmaengine+bounces-1470-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6209D886CB6
	for <lists+dmaengine@lfdr.de>; Fri, 22 Mar 2024 14:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A471C21919
	for <lists+dmaengine@lfdr.de>; Fri, 22 Mar 2024 13:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD5F46441;
	Fri, 22 Mar 2024 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDIyjHHY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3351F46436;
	Fri, 22 Mar 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113684; cv=none; b=Jt3l9mnHhorap+AaUPRlSxU6i6Gp04VQwaOWxZ6efyRfHrIm7j0La3Blru46sL3pI2EXIkkZTCVBs2/Cvqi7NNa0QJJTdFx1TrDlBw+tb/ZzOiq53M/Eaodq3WTUxHIu8v3fJGa2kiL6I+ylAFuhMUgaDKV8yR3YmOOrR8nPX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113684; c=relaxed/simple;
	bh=jvyFcumM0Kgc3cvxmljqPEI3TA1ssaHzM5qXST5wFWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GJkVKGaZKewCP/4D9+YKUBa3QgrhlA3MxM9/Kt2IVIogdVDnqk8GnQxKZmi+1rPuL7T1DQ+h8ulXUq34Vu6OYOq/j1WUuMG/bmstwvuSHzEIl22dJihhrCFdMpMEl5QVtC2IIqfqb/tMc7BaUDRsGPVL88UKyckLIfl+RiOW164=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDIyjHHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A03C433A6;
	Fri, 22 Mar 2024 13:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711113683;
	bh=jvyFcumM0Kgc3cvxmljqPEI3TA1ssaHzM5qXST5wFWU=;
	h=From:To:Cc:Subject:Date:From;
	b=SDIyjHHYzIzkM1ZxDVfDOZHT6vMxkUjSs4aE6DL1byMVyt+l9ZVvb56So8nucENaA
	 PCTY15jtxyqPU6g5mgcvJGodAaiN+2fOjHh323i4WnkcJkBsEV7ZC+KNr/G5+U6gr5
	 c/FOW+tZPpXXMPrqOUxDHc3ybQ5pLQ5aGCdcdy0dvN5QZ6nRoofp06wb1IYr6jiipF
	 GujyavHdDLOPUjAzrNCI02AHdLyLHyWi1QCxjRwFk+JlV+HksHB8XD4P3jGVvbyfyh
	 ST7nvBUKQx3qFnH9hi60KK2k9/3JqR9RGfdsP246vhWM45efhlJ97d+YyR9QN50rBo
	 naQOrMhliewpQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rob Herring <robh@kernel.org>,
	Zhang Jianhua <chris.zjh@huawei.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] dmaengine: owl: fix register access functions
Date: Fri, 22 Mar 2024 14:21:07 +0100
Message-Id: <20240322132116.906475-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When building with 'make W=1', clang notices that the computed register
values are never actually written back but instead the wrong variable
is set:

drivers/dma/owl-dma.c:244:6: error: variable 'regval' set but not used [-Werror,-Wunused-but-set-variable]
  244 |         u32 regval;
      |             ^
drivers/dma/owl-dma.c:268:6: error: variable 'regval' set but not used [-Werror,-Wunused-but-set-variable]
  268 |         u32 regval;
      |             ^

Change these to what was most likely intended.

Fixes: 47e20577c24d ("dmaengine: Add Actions Semi Owl family S900 DMA driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/owl-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 4e76c4ec2d39..e001f4f7aa64 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -250,7 +250,7 @@ static void pchan_update(struct owl_dma_pchan *pchan, u32 reg,
 	else
 		regval &= ~val;
 
-	writel(val, pchan->base + reg);
+	writel(regval, pchan->base + reg);
 }
 
 static void pchan_writel(struct owl_dma_pchan *pchan, u32 reg, u32 data)
@@ -274,7 +274,7 @@ static void dma_update(struct owl_dma *od, u32 reg, u32 val, bool state)
 	else
 		regval &= ~val;
 
-	writel(val, od->base + reg);
+	writel(regval, od->base + reg);
 }
 
 static void dma_writel(struct owl_dma *od, u32 reg, u32 data)
-- 
2.39.2


