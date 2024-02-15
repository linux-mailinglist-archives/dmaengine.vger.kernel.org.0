Return-Path: <dmaengine+bounces-1016-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BE28558FD
	for <lists+dmaengine@lfdr.de>; Thu, 15 Feb 2024 03:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506DA1F24AE1
	for <lists+dmaengine@lfdr.de>; Thu, 15 Feb 2024 02:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95921864;
	Thu, 15 Feb 2024 02:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIwq6ksP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3853317C8;
	Thu, 15 Feb 2024 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707965408; cv=none; b=JbsmKQLtOP/5SQ1FEHMNe6kE2vkGKd0/VSDTql7dZG3HMdiiCtsUsfBSMaECN5Y8s14yEYskdsx9KS+6Of66EZYaBN5sd/h9FBl8zizwUCZVtExIn8eexXjFSu8Eyco6C0CH+65haY6R0BvzJ8AfaaYt9ku+n0wBPaiaUmh/NLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707965408; c=relaxed/simple;
	bh=fxOG2hwLQS9vVV1tfX/vi+Hg5sEDWSbTQsqcU+i0MTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RWkQSx/ZnHab+Vp2ijqXXIXbKv/maOSssPF/cGXmEcwRxgCdd8oEMd+s9TnmnhbX3wd0k8PEbDmKt29l4BW0sF7Xsa74V0fKPAqXFen+X0W3qUMAZBgQ1D1q3tN1Kr+9Hd3lbTkWc/WsxwzB5ePH/VojT9HQvwTx7j9apELCkps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIwq6ksP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707965406; x=1739501406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fxOG2hwLQS9vVV1tfX/vi+Hg5sEDWSbTQsqcU+i0MTM=;
  b=YIwq6ksPqqW2PNoYXFZtxa53X32LoE6vp+jgBLAkjMhg8P9fNgWyrG5G
   H8veL5iuKiwwxiO0dMl/cqGF2T0SkEEYgsLwQsyvr4n6t+3kEFfNMG/z0
   nmTdV2jpwBXhdiApYTKr7EJya3DR7CMVG/hGt0haImswwtDd4wLJTaPlf
   BYXBJtsa3EjMFAusWxQmdrMpX/AYkSBANYzvoWSlxtiiF2q+1Gjyifnm1
   Qyrdr61f0AC/ABqmYJs6rGPD80vTIUbF++AXZt8sErsM1xIj9wsfHyy5y
   nLdeeT+e+LnySwsNak9OK5YxF8eJRmOrx7fWHqHpRjaUky5kL3R+XC905
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13432548"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="13432548"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 18:50:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3331964"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmviesa007.fm.intel.com with ESMTP; 14 Feb 2024 18:50:05 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2] dmaengine: idxd: Remove shadow Event Log head stored in idxd
Date: Wed, 14 Feb 2024 18:49:31 -0800
Message-Id: <20240215024931.1739621-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

head is defined in idxd->evl as a shadow of head in the EVLSTATUS register.
There are two issues related to the shadow head:

1. Mismatch between the shadow head and the state of the EVLSTATUS
   register:
   If Event Log is supported, upon completion of the Enable Device command,
   the Event Log head in the variable idxd->evl->head should be cleared to
   match the state of the EVLSTATUS register. But the variable is not reset
   currently, leading mismatch between the variable and the register state.
   The mismatch causes incorrect processing of Event Log entries.

2. Unnecessary shadow head definition:
   The shadow head is unnecessary as head can be read directly from the
   EVLSTATUS register. Reading head from the register incurs no additional
   cost because event log head and tail are always read together and
   tail is already read directly from the register as required by hardware.

Remove the shadow Event Log head stored in idxd->evl to address the
mentioned issues.

Fixes: 244da66cda35 ("dmaengine: idxd: setup event log configuration")
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
Change Log:
- A previous patch tries to fix this issue in a different way:
https://lore.kernel.org/lkml/20240209191851.1050501-1-fenghua.yu@intel.com/
  After discussion with Dave Jiang, removing shadow head might be
  a right fix.

 drivers/dma/idxd/cdev.c    | 2 +-
 drivers/dma/idxd/debugfs.c | 2 +-
 drivers/dma/idxd/idxd.h    | 1 -
 drivers/dma/idxd/irq.c     | 3 +--
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 77f8885cf407..e5a94a93a3cc 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -345,7 +345,7 @@ static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid)
 	spin_lock(&evl->lock);
 	status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
 	t = status.tail;
-	h = evl->head;
+	h = status.head;
 	size = evl->size;
 
 	while (h != t) {
diff --git a/drivers/dma/idxd/debugfs.c b/drivers/dma/idxd/debugfs.c
index 9cfbd9b14c4c..f3f25ee676f3 100644
--- a/drivers/dma/idxd/debugfs.c
+++ b/drivers/dma/idxd/debugfs.c
@@ -68,9 +68,9 @@ static int debugfs_evl_show(struct seq_file *s, void *d)
 
 	spin_lock(&evl->lock);
 
-	h = evl->head;
 	evl_status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
 	t = evl_status.tail;
+	h = evl_status.head;
 	evl_size = evl->size;
 
 	seq_printf(s, "Event Log head %u tail %u interrupt pending %u\n\n",
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 47de3f93ff1e..d0f5db6cf1ed 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -300,7 +300,6 @@ struct idxd_evl {
 	unsigned int log_size;
 	/* The number of entries in the event log. */
 	u16 size;
-	u16 head;
 	unsigned long *bmap;
 	bool batch_fail[IDXD_MAX_BATCH_IDENT];
 };
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index c8a0aa874b11..348aa21389a9 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -367,9 +367,9 @@ static void process_evl_entries(struct idxd_device *idxd)
 	/* Clear interrupt pending bit */
 	iowrite32(evl_status.bits_upper32,
 		  idxd->reg_base + IDXD_EVLSTATUS_OFFSET + sizeof(u32));
-	h = evl->head;
 	evl_status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
 	t = evl_status.tail;
+	h = evl_status.head;
 	size = idxd->evl->size;
 
 	while (h != t) {
@@ -378,7 +378,6 @@ static void process_evl_entries(struct idxd_device *idxd)
 		h = (h + 1) % size;
 	}
 
-	evl->head = h;
 	evl_status.head = h;
 	iowrite32(evl_status.bits_lower32, idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
 	spin_unlock(&evl->lock);
-- 
2.37.1


