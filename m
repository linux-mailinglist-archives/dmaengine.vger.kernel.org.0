Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7A87A122
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jul 2019 08:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfG3GO3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jul 2019 02:14:29 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:39371 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbfG3GO2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Jul 2019 02:14:28 -0400
Received: from [IPv6:2001:983:e9a7:1:3159:f139:4aff:7185] ([IPv6:2001:983:e9a7:1:3159:f139:4aff:7185])
        by smtp-cloud8.xs4all.net with ESMTPA
        id sLOthABgJqTdhsLOuhkX2E; Tue, 30 Jul 2019 08:14:26 +0200
To:     dmaengine@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] omap-dma/omap_vout_vrfb: fix off-by-one fi value
Message-ID: <8f4e529f-9c20-b2e3-7e60-35e2d72d5242@xs4all.nl>
Date:   Tue, 30 Jul 2019 08:14:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBiehGZxUXRrX/9yQdHb8S0LSkiPKOIQDPydebvc6iTI0ybK3RlgDnJXm8SrgqPjSHwR6bhUhYIUev52CgoSI9ka4bNFH0spHCEmPfZrLkSm3YpFlptL
 74R3jvJmdpNxkAvFCXQfIXJVLYghYm64BCnarJQUUBf3rrG+tFt1O3HRO0c3ZvPigzhRBYaTat9GyAISDnxbfSoK6ILdz59euVvphINR80Z/3zpxQabcpWUX
 irCMwU2KyE2HhkUqJbuH3LdzG1GmGe0pjjfGI7cxeJ0lgqxxsxrkAV5OZNi2kSa2KP6m/foG/g0h7Ua1/+JtDidTjpPoTtDikJLHR63VXrICeuOIarKhu/TW
 VyrMa1wuuYMSTCUAEDl28/N7Z2iUq5C5wUX6PoZeeTV02Idy40rGdkaIpEp0rUzuv3/9MJgZj1qVuuk6aF4EisAWq9ZDLdGahVJZ7lUgJtQtIsQ8kHg=
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
---
It makes sense that this patch goes in through the dmaengine subsystem
(Mauro, can you Ack this patch?), but if preferred it can also go in
through the media subsystem if we get an Ack.

Regards,

	Hans
---
 drivers/dma/ti/omap-dma.c                    | 4 ++--
 drivers/media/platform/omap/omap_vout_vrfb.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

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
index 29e3f5da59c1..729b1bf9395f 100644
--- a/drivers/media/platform/omap/omap_vout_vrfb.c
+++ b/drivers/media/platform/omap/omap_vout_vrfb.c
@@ -254,7 +254,7 @@ int omap_vout_prepare_vrfb(struct omap_vout_device *vout,

 	pixsize = vout->bpp * vout->vrfb_bpp;
 	dst_icg = ((MAX_PIXELS_PER_LINE * pixsize) -
-		  (vout->pix.width * vout->bpp)) + 1;
+		  (vout->pix.width * vout->bpp));

 	xt->src_start = vout->buf_phy_addr[vb->i];
 	xt->dst_start = vout->vrfb_context[vb->i].paddr[0];
-- 
2.20.1

