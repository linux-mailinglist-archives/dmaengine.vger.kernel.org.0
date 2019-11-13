Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F47BFA307
	for <lists+dmaengine@lfdr.de>; Wed, 13 Nov 2019 03:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfKMCHe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Nov 2019 21:07:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730542AbfKMCAk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Nov 2019 21:00:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03D942053B;
        Wed, 13 Nov 2019 02:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610439;
        bh=5W2ErCyc47JdlxUbc9VA8AEfZ4i7AtaSVHCx4GuH8Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUwLJwZUQmAxRQcTvt8AlMeeckNlqN6O9aBC9XUuuKXwIICk5dBfbJpPf653kjAez
         1GUdesABTwPA7oek7B+0634zusFNxQ3s/wQSZIEH6Qr9/02M0StD+zebSb+Nea9D0I
         UrYxnHUGJE+MtMUy6055xY7a7SBqI/MwwwxjQ0cA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rami Rosen <ramirose@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <sashal@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 38/68] dmaengine: ioat: fix prototype of ioat_enumerate_channels
Date:   Tue, 12 Nov 2019 20:59:02 -0500
Message-Id: <20191113015932.12655-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015932.12655-1-sashal@kernel.org>
References: <20191113015932.12655-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Rami Rosen <ramirose@gmail.com>

[ Upstream commit f4d34aa8c887a8a2d23ef546da0efa10e3f77241 ]

Signed-off-by: Rami Rosen <ramirose@gmail.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ioat/init.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index d139706f01fe8..9d936584d3310 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -129,7 +129,7 @@ static void
 ioat_init_channel(struct ioatdma_device *ioat_dma,
 		  struct ioatdma_chan *ioat_chan, int idx);
 static void ioat_intr_quirk(struct ioatdma_device *ioat_dma);
-static int ioat_enumerate_channels(struct ioatdma_device *ioat_dma);
+static void ioat_enumerate_channels(struct ioatdma_device *ioat_dma);
 static int ioat3_dma_self_test(struct ioatdma_device *ioat_dma);
 
 static int ioat_dca_enabled = 1;
@@ -573,7 +573,7 @@ static void ioat_dma_remove(struct ioatdma_device *ioat_dma)
  * ioat_enumerate_channels - find and initialize the device's channels
  * @ioat_dma: the ioat dma device to be enumerated
  */
-static int ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
+static void ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
 {
 	struct ioatdma_chan *ioat_chan;
 	struct device *dev = &ioat_dma->pdev->dev;
@@ -592,7 +592,7 @@ static int ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
 	xfercap_log = readb(ioat_dma->reg_base + IOAT_XFERCAP_OFFSET);
 	xfercap_log &= 0x1f; /* bits [4:0] valid */
 	if (xfercap_log == 0)
-		return 0;
+		return;
 	dev_dbg(dev, "%s: xfercap = %d\n", __func__, 1 << xfercap_log);
 
 	for (i = 0; i < dma->chancnt; i++) {
@@ -609,7 +609,6 @@ static int ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
 		}
 	}
 	dma->chancnt = i;
-	return i;
 }
 
 /**
-- 
2.20.1

