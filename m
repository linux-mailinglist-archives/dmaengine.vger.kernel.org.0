Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31E8219151
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2020 22:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgGHUTW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Jul 2020 16:19:22 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41738 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgGHUTV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Jul 2020 16:19:21 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 88390B23;
        Wed,  8 Jul 2020 22:19:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594239557;
        bh=qTOd0sh2284zibSUBDii1Qw5qeyXUcvnlZlk/n51ZCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BSHVPXEkk1VUSWrT4X9zM5/8t98Te3398Gwi/CNLU0+6mUfSbz3xMIYgcIEh3xs5r
         0i23JhjhbKqnBzxV2RSR+vTyeimCYOonS/cOQTOKJDqso/mIgzG0A22LYJ4C4dGjbE
         5G/GSi1OkFwkU6y1h5IDsv7cr9goqa3bJSa8iBtg=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v6 2/6] dmaengine: virt-dma: Use lockdep to check locking requirements
Date:   Wed,  8 Jul 2020 23:19:02 +0300
Message-Id: <20200708201906.4546-3-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
References: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

A few virt-dma functions are documented as requiring the vc.lock to be
held by the caller. Check this with lockdep.

The vchan_vdesc_fini() and vchan_find_desc() functions gain a lockdep
check as well, because, even though they are not documented with this
requirement (and not documented at all for the latter), they touch
fields documented as protected by vc.lock. All callers have been
manually inspected to verify they call the functions with the lock held.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/dma/virt-dma.c |  2 ++
 drivers/dma/virt-dma.h | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index 23e33a85f033..1cb36ab3d9c1 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -68,6 +68,8 @@ struct virt_dma_desc *vchan_find_desc(struct virt_dma_chan *vc,
 {
 	struct virt_dma_desc *vd;
 
+	lockdep_assert_held(&vc->lock);
+
 	list_for_each_entry(vd, &vc->desc_issued, node)
 		if (vd->tx.cookie == cookie)
 			return vd;
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index e9f5250fbe4d..59d9eabc8b67 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -81,6 +81,8 @@ static inline struct dma_async_tx_descriptor *vchan_tx_prep(struct virt_dma_chan
  */
 static inline bool vchan_issue_pending(struct virt_dma_chan *vc)
 {
+	lockdep_assert_held(&vc->lock);
+
 	list_splice_tail_init(&vc->desc_submitted, &vc->desc_issued);
 	return !list_empty(&vc->desc_issued);
 }
@@ -96,6 +98,8 @@ static inline void vchan_cookie_complete(struct virt_dma_desc *vd)
 	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
 	dma_cookie_t cookie;
 
+	lockdep_assert_held(&vc->lock);
+
 	cookie = vd->tx.cookie;
 	dma_cookie_complete(&vd->tx);
 	dev_vdbg(vc->chan.device->dev, "txd %p[%x]: marked complete\n",
@@ -146,6 +150,8 @@ static inline void vchan_terminate_vdesc(struct virt_dma_desc *vd)
 {
 	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
 
+	lockdep_assert_held(&vc->lock);
+
 	list_add_tail(&vd->node, &vc->desc_terminated);
 
 	if (vc->cyclic == vd)
@@ -160,6 +166,8 @@ static inline void vchan_terminate_vdesc(struct virt_dma_desc *vd)
  */
 static inline struct virt_dma_desc *vchan_next_desc(struct virt_dma_chan *vc)
 {
+	lockdep_assert_held(&vc->lock);
+
 	return list_first_entry_or_null(&vc->desc_issued,
 					struct virt_dma_desc, node);
 }
@@ -177,6 +185,8 @@ static inline struct virt_dma_desc *vchan_next_desc(struct virt_dma_chan *vc)
 static inline void vchan_get_all_descriptors(struct virt_dma_chan *vc,
 	struct list_head *head)
 {
+	lockdep_assert_held(&vc->lock);
+
 	list_splice_tail_init(&vc->desc_allocated, head);
 	list_splice_tail_init(&vc->desc_submitted, head);
 	list_splice_tail_init(&vc->desc_issued, head);
-- 
Regards,

Laurent Pinchart

