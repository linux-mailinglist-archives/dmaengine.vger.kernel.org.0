Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E86D896071
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2019 15:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfHTNlE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Aug 2019 09:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729836AbfHTNlD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Aug 2019 09:41:03 -0400
Received: from sasha-vm.mshome.net (unknown [12.236.144.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 424812087E;
        Tue, 20 Aug 2019 13:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308462;
        bh=2Tss3GvNiTsZtp+/2r6pA+FChtCCESdrNDU+8ig+4rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AuHRZgWKNCpwlNPl+3yHLK12YDU5Lq1bVpPF6dy0ddyr6vLvdklBsdwXGhTpkcjpn
         +tm9rVNY6Sg6tm2Zdk0V/M4Nw+h5oDWMroaNqenWepRuh+uvGShfKQvO/rYVlugyCb
         6lGiXa1DkhlgAQAnWaHjqQytAfEvLBX6Tvvw0iZs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 25/44] omap-dma/omap_vout_vrfb: fix off-by-one fi value
Date:   Tue, 20 Aug 2019 09:40:09 -0400
Message-Id: <20190820134028.10829-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820134028.10829-1-sashal@kernel.org>
References: <20190820134028.10829-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Hans Verkuil <hverkuil@xs4all.nl>

[ Upstream commit d555c34338cae844b207564c482e5a3fb089d25e ]

The OMAP 4 TRM specifies that when using double-index addressing
the address increases by the ES plus the EI value minus 1 within
a frame. When a full frame is transferred, the address increases
by the ES plus the frame index (FI) value minus 1.

The omap-dma code didn't account for the 'minus 1' in the FI register.
To get correct addressing, add 1 to the src_icg value.

This was found when testing a hacked version of the media m2m-deinterlace.c
driver on a Pandaboard.

The only other source that uses this feature is omap_vout_vrfb.c,
and that adds a + 1 when setting the dst_icg. This is a workaround
for the broken omap-dma.c behavior. So remove the workaround at the
same time that we fix omap-dma.c.

I tested the omap_vout driver with a Beagle XM board to check that
the '+ 1' in omap_vout_vrfb.c was indeed a workaround for the omap-dma
bug.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Link: https://lore.kernel.org/r/952e7f51-f208-9333-6f58-b7ed20d2ea0b@xs4all.nl
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ti/omap-dma.c                    | 4 ++--
 drivers/media/platform/omap/omap_vout_vrfb.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index ba2489d4ea246..ba27802efcd0a 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1234,7 +1234,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_interleaved(
 	if (src_icg) {
 		d->ccr |= CCR_SRC_AMODE_DBLIDX;
 		d->ei = 1;
-		d->fi = src_icg;
+		d->fi = src_icg + 1;
 	} else if (xt->src_inc) {
 		d->ccr |= CCR_SRC_AMODE_POSTINC;
 		d->fi = 0;
@@ -1249,7 +1249,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_interleaved(
 	if (dst_icg) {
 		d->ccr |= CCR_DST_AMODE_DBLIDX;
 		sg->ei = 1;
-		sg->fi = dst_icg;
+		sg->fi = dst_icg + 1;
 	} else if (xt->dst_inc) {
 		d->ccr |= CCR_DST_AMODE_POSTINC;
 		sg->fi = 0;
diff --git a/drivers/media/platform/omap/omap_vout_vrfb.c b/drivers/media/platform/omap/omap_vout_vrfb.c
index 29e3f5da59c1f..11ec048929e80 100644
--- a/drivers/media/platform/omap/omap_vout_vrfb.c
+++ b/drivers/media/platform/omap/omap_vout_vrfb.c
@@ -253,8 +253,7 @@ int omap_vout_prepare_vrfb(struct omap_vout_device *vout,
 	 */
 
 	pixsize = vout->bpp * vout->vrfb_bpp;
-	dst_icg = ((MAX_PIXELS_PER_LINE * pixsize) -
-		  (vout->pix.width * vout->bpp)) + 1;
+	dst_icg = MAX_PIXELS_PER_LINE * pixsize - vout->pix.width * vout->bpp;
 
 	xt->src_start = vout->buf_phy_addr[vb->i];
 	xt->dst_start = vout->vrfb_context[vb->i].paddr[0];
-- 
2.20.1

