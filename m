Return-Path: <dmaengine+bounces-1322-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC93876C25
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 22:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1769E283782
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 21:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4794F5FB8A;
	Fri,  8 Mar 2024 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LM8CdNqT"
X-Original-To: dmaengine@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C15FB9B
	for <dmaengine@vger.kernel.org>; Fri,  8 Mar 2024 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931648; cv=none; b=pWdzrQPpwgYXKj87MVyP0GujPpZ6L1PTkkasGgLm+/Jq5bEowG7P8a8MjmuQkidCuQ9elpfpLKy/Vayzh5fZ6F5bIyfsd9KqCkhnyBtMDygtANpaCo9XZBnhukehAc9L7ew4WXKGWgxnXNHWQ6qxLSOsxTZpFy5z9VHwcQyp0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931648; c=relaxed/simple;
	bh=PfOtw4OihwZuOwZcHtxjLP/RlXrLSDvq77dCrKgYKKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bdJ8ghT0hREqggb1zHaN3/m4PgPmmqmcEhIEdErw9fAH3PWfXnWvDODBY2Y+5F0pvCyExax4zBZsSj0SBaEONqfRUtD4IK/wgt9ku//gXrJmUDG2jP2YNvIwAEeOmxHPbrh+Kx8JHqtTSCvjr5Qc5BSvlcxvD74hjvb7uw9LS2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LM8CdNqT; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709931644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TBItYHtNpx6y+be/gmPb27c0lB7KPRGke/Atz5DFWA=;
	b=LM8CdNqT0MBTgf9TwPay3IyWuxlOK352de/uQ2LfvOQ3j0wQXrJxi6XmPm08hhqA1uqcXP
	o+r16RKkbia3KozpbmnzKugqodpFmc7a3+mgAuXVKMtSv1LFI32Vm09Omv+pWAL0MJPPEH
	T071LojHi+2P2g3dsvDAjfrKbdfkfb4=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 3/3] dma: Add lockdep asserts to virt-dma
Date: Fri,  8 Mar 2024 16:00:34 -0500
Message-Id: <20240308210034.3634938-4-sean.anderson@linux.dev>
In-Reply-To: <20240308210034.3634938-1-sean.anderson@linux.dev>
References: <20240308210034.3634938-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add lockdep asserts to all functions with "vc.lock must be held by
caller" in their documentation. This will help catch cases where these
assumptions do not hold.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/dma/virt-dma.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

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
2.35.1.1320.gc452695387.dirty


