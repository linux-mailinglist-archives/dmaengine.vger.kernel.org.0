Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE306AC88C
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 17:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjCFQqB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 11:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCFQoY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 11:44:24 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB3837544;
        Mon,  6 Mar 2023 08:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678121042; x=1709657042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3IHWCX0EXLUJ13RD60A81ekSWW5wHvs86VNvAujHKq8=;
  b=fCWfc8uBjM+gd6NNvlJVxSYKDNXaT4PdjVVHGlqwkwbQytQhjS2EYCPa
   vsQh2dTFyNyNkaSF0M7x7phM8sEhEULFI0FCHgUgqQOi8xpKsEFrDfxcJ
   qGTbB0KOehEChfFO79xWGdA3V8VGdu4gwohkDcXwVqXFZ0FYRRb+eV009
   saAtjl6TVXnr/6nHRc6pVI94bP19Tw36AtQK3MAUQqEP5WmP07R12Yiqr
   R5J/co8MfvOPrgWPFKGSGzeB0gNvQ/8+ZzStrZYwVIVQiNREWLfcCa2nU
   i6Yu5s1twGAL+r3t2IAKg17TBJMuH9xUL1vmFZaAA8jw4829opOyOFs6G
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398181148"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398181148"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 08:31:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669504506"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669504506"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 08:31:55 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 04/16] dmaengine: idxd: add interrupt handling for event log
Date:   Mon,  6 Mar 2023 08:31:26 -0800
Message-Id: <20230306163138.587484-5-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230306163138.587484-1-fenghua.yu@intel.com>
References: <20230306163138.587484-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

An event log interrupt is raised in the misc interrupt INTCAUSE register
when an event is written by the hardware. Add basic event log processing
support to the interrupt handler. The event log is a ring where the
hardware owns the tail and the software owns the head. The hardware will
advance the tail index when an additional event has been pushed to memory.
The software will process the log entry and then advances the head. The
log is full when (tail + 1) % log_size = head. The hardware will stop
writing when the log is full. The user is expected to create a log size
large enough to handle all the expected events.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/irq.c       | 48 ++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/registers.h | 19 ++++++++++++++
 include/uapi/linux/idxd.h    |  1 +
 3 files changed, 68 insertions(+)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 0d639303b515..52b8b7d9db22 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -217,6 +217,49 @@ static void idxd_int_handle_revoke(struct work_struct *work)
 	kfree(revoke);
 }
 
+static void process_evl_entry(struct idxd_device *idxd, struct __evl_entry *entry_head)
+{
+	struct device *dev = &idxd->pdev->dev;
+	u8 status;
+
+	status = DSA_COMP_STATUS(entry_head->error);
+	dev_warn_ratelimited(dev, "Device error %#x operation: %#x fault addr: %#llx\n",
+			     status, entry_head->operation, entry_head->fault_addr);
+}
+
+static void process_evl_entries(struct idxd_device *idxd)
+{
+	union evl_status_reg evl_status;
+	unsigned int h, t;
+	struct idxd_evl *evl = idxd->evl;
+	struct __evl_entry *entry_head;
+	unsigned int ent_size = evl_ent_size(idxd);
+	u32 size;
+
+	evl_status.bits = 0;
+	evl_status.int_pending = 1;
+
+	spin_lock(&evl->lock);
+	/* Clear interrupt pending bit */
+	iowrite32(evl_status.bits_upper32,
+		  idxd->reg_base + IDXD_EVLSTATUS_OFFSET + sizeof(u32));
+	h = evl->head;
+	evl_status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
+	t = evl_status.tail;
+	size = idxd->evl->size;
+
+	while (h != t) {
+		entry_head = (struct __evl_entry *)(evl->log + (h * ent_size));
+		process_evl_entry(idxd, entry_head);
+		h = (h + 1) % size;
+	}
+
+	evl->head = h;
+	evl_status.head = h;
+	iowrite32(evl_status.bits_lower32, idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
+	spin_unlock(&evl->lock);
+}
+
 irqreturn_t idxd_misc_thread(int vec, void *data)
 {
 	struct idxd_irq_entry *irq_entry = data;
@@ -304,6 +347,11 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 		perfmon_counter_overflow(idxd);
 	}
 
+	if (cause & IDXD_INTC_EVL) {
+		val |= IDXD_INTC_EVL;
+		process_evl_entries(idxd);
+	}
+
 	val ^= cause;
 	if (val)
 		dev_warn_once(dev, "Unexpected interrupt cause bits set: %#x\n",
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 11bb97cf7481..148db94f9373 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -168,6 +168,7 @@ enum idxd_device_reset_type {
 #define IDXD_INTC_OCCUPY			0x04
 #define IDXD_INTC_PERFMON_OVFL		0x08
 #define IDXD_INTC_HALT_STATE		0x10
+#define IDXD_INTC_EVL			0x20
 #define IDXD_INTC_INT_HANDLE_REVOKED	0x80000000
 
 #define IDXD_CMD_OFFSET			0xa0
@@ -558,6 +559,24 @@ union filter_cfg {
 	u64 val;
 } __packed;
 
+#define IDXD_EVLSTATUS_OFFSET		0xf0
+
+union evl_status_reg {
+	struct {
+		u32 head:16;
+		u32 rsvd:16;
+		u32 tail:16;
+		u32 rsvd2:14;
+		u32 int_pending:1;
+		u32 rsvd3:1;
+	};
+	struct {
+		u32 bits_lower32;
+		u32 bits_upper32;
+	};
+	u64 bits;
+} __packed;
+
 struct __evl_entry {
 	u64 rsvd:2;
 	u64 desc_valid:1;
diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 5d05bf12f2bd..0bc8eea18586 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -170,6 +170,7 @@ enum iax_completion_status {
 
 #define DSA_COMP_STATUS_MASK		0x7f
 #define DSA_COMP_STATUS_WRITE		0x80
+#define DSA_COMP_STATUS(status)		((status) & DSA_COMP_STATUS_MASK)
 
 struct dsa_hw_desc {
 	uint32_t	pasid:20;
-- 
2.37.1

