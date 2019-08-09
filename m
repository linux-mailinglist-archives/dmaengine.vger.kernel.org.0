Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B853287423
	for <lists+dmaengine@lfdr.de>; Fri,  9 Aug 2019 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405826AbfHIIcz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Aug 2019 04:32:55 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:55857 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbfHIIcy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Aug 2019 04:32:54 -0400
Received: from [IPv6:2001:983:e9a7:1:a042:9da:6cf5:9cb5] ([IPv6:2001:983:e9a7:1:a042:9da:6cf5:9cb5])
        by smtp-cloud8.xs4all.net with ESMTPA
        id w0KGhZ768qTdhw0KHhUIPC; Fri, 09 Aug 2019 10:32:52 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCHv2] omap-dma/omap_vout_vrfb: fix off-by-one fi value
Message-ID: <952e7f51-f208-9333-6f58-b7ed20d2ea0b@xs4all.nl>
Date:   Fri, 9 Aug 2019 10:32:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGBHksXKv+i7JHE9cu112c8cGY7ctVJUw0pW0Bt3iAVUUkdCDjMSRv3o+ys1hJAB9v2cbfIWCaU3yBEIRuQ5AqQbu3lHdi4PCQplnlLwdL4++vFJOu8n
 UDlH1nHvh8em4OIHRDM927TN7mcd0KiMS2RGDCgcfsID62xn9OBqlD849zSgelMMl+1Xz5eKSVbPrj572sLvxyqiMWtbBCzYqI9Mp4WzHHr2j2jNeiUAPmXL
 Xx6Fvh3rzFfQw15XEzNddY8MZcYXGF2pj2BU8iyB/psd/r2QoeSgjG6P/mC9NwjSYS5KV0f3qwkrbhhzC1Gt+kyrqTFQqLa+bMk8ld5sSvi00Lfodm5CiBEK
 hgjJzwJguYcNF48Sy8hErtLqRsrhQbbC2RK3tcMoD8c3dNO6fUUnCQ6+FHfiXrAk8x9+aJF3qvuAzd3/0p1+EkyrDMLgoA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

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
---
Changes since v1: removed unnecessary parenthesis in omap_vout_vrfb.c
as suggested by Laurent.

It makes sense that this patch goes in through the dmaengine subsystem
(Mauro, can you Ack this patch?), but if preferred it can also go in
through the media subsystem if we get an Ack from Vinod.
---
 drivers/dma/ti/omap-dma.c                    | 4 ++--
 drivers/media/platform/omap/omap_vout_vrfb.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index ba2489d4ea24..ba27802efcd0 100644
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
index 29e3f5da59c1..11ec048929e8 100644
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

