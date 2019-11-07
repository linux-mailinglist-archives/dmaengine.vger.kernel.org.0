Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A30C5F2D67
	for <lists+dmaengine@lfdr.de>; Thu,  7 Nov 2019 12:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733142AbfKGL1g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Nov 2019 06:27:36 -0500
Received: from mail-m975.mail.163.com ([123.126.97.5]:47592 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKGL1g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Nov 2019 06:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=VxXuxyye1MqjU+hDjg
        02qbrKx1jLX10dIV/GDARuXpU=; b=b6XWFLM1DY02QNi+PAd31aRrO6jgY1b51z
        UiunWg4MGfA6LGfW9dtQeS44ggK81ISAo3d/cBoRqO0KR+B3yIph2aZ2OiKLRr6m
        jW65MQHNHjtcxF2DbkDaCdId16uGV6fd4mXFuA7MkaGAJM3laVsNWXn9IEIsIXYJ
        IiVR1ElHI=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp5 (Coremail) with SMTP id HdxpCgCXTueP_8Nd8iYXAA--.227S3;
        Thu, 07 Nov 2019 19:27:17 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] dmaengine: sun6i: Fix use after free
Date:   Thu,  7 Nov 2019 19:26:53 +0800
Message-Id: <1573126013-17609-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: HdxpCgCXTueP_8Nd8iYXAA--.227S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr17Kr15JFy3XrWfGryfZwb_yoW8KF1kpF
        43Ja4rur45tF1aga13Z348uF13KF4fJFyUCay5Gwn0vr9xXr1kGa17Aa4Fkr98JFn8CrWf
        Xrs0gF1ruF4UGwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UypBhUUUUU=
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBzxVmclaD5QFnNAAAss
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The members in the LLI list is released in an incorrect way. Read and
store the next member before releasing it to avoid accessing the freed
memory.

Fixes: a90e173f3faf ("dmaengine: sun6i: Add cyclic capability")

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/dma/sun6i-dma.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 06cd7f867f7c..096aad7e75bb 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -687,7 +687,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 	struct sun6i_dma_dev *sdev = to_sun6i_dma_dev(chan->device);
 	struct sun6i_vchan *vchan = to_sun6i_vchan(chan);
 	struct dma_slave_config *sconfig = &vchan->cfg;
-	struct sun6i_dma_lli *v_lli, *prev = NULL;
+	struct sun6i_dma_lli *v_lli, *next, *prev = NULL;
 	struct sun6i_desc *txd;
 	struct scatterlist *sg;
 	dma_addr_t p_lli;
@@ -752,8 +752,12 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
 
 err_lli_free:
-	for (prev = txd->v_lli; prev; prev = prev->v_lli_next)
-		dma_pool_free(sdev->pool, prev, virt_to_phys(prev));
+	v_lli = txd->v_lli;
+	while (v_lli) {
+		next = v_lli->v_lli_next;
+		dma_pool_free(sdev->pool, v_lli, virt_to_phys(v_lli));
+		v_lli = next;
+	}
 	kfree(txd);
 	return NULL;
 }
@@ -769,7 +773,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
 	struct sun6i_dma_dev *sdev = to_sun6i_dma_dev(chan->device);
 	struct sun6i_vchan *vchan = to_sun6i_vchan(chan);
 	struct dma_slave_config *sconfig = &vchan->cfg;
-	struct sun6i_dma_lli *v_lli, *prev = NULL;
+	struct sun6i_dma_lli *v_lli, *next, *prev = NULL;
 	struct sun6i_desc *txd;
 	dma_addr_t p_lli;
 	u32 lli_cfg;
@@ -820,8 +824,12 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
 	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
 
 err_lli_free:
-	for (prev = txd->v_lli; prev; prev = prev->v_lli_next)
-		dma_pool_free(sdev->pool, prev, virt_to_phys(prev));
+	v_lli = txd->v_lli;
+	while (v_lli) {
+		next = v_lli->v_lli_next;
+		dma_pool_free(sdev->pool, v_lli, virt_to_phys(v_lli));
+		v_lli = next;
+	}
 	kfree(txd);
 	return NULL;
 }
-- 
2.7.4

