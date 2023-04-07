Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74A06DB53A
	for <lists+dmaengine@lfdr.de>; Fri,  7 Apr 2023 22:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjDGUbb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Apr 2023 16:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjDGUb3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Apr 2023 16:31:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A9C7AB8;
        Fri,  7 Apr 2023 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680899488; x=1712435488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QT1vreoVemUkwW7yToEkmPxq01YzU9/6DFQ+0GKEUkk=;
  b=AG3+A+uQ5qalIrT6KI3qx92ZANJltrSJMJ/HHzuCq9h7NSHtb2GK0qTU
   t+Bib0+opIXQtqSpLOGZOr2r/r80dGqX0CCiv+rAKRi/oERWfZ9AvoNP+
   0RMUSOfcY5rBhoIOmulMS2QjlxgOqaFort0rrtyysazQZlRAOIdFH2zkF
   g/zzL+SMHNCrez5Rp7wW6mwjek4Yk/8FzUiCXLTyP/CSAY5sHF6nJiwD7
   Z9o7NHaldwSYT0LZGjTwr5cJdEoJQH0fqgPQ8zJAQ6YzvXCbjPbTTq6KC
   8KmzKk+Xc3iMANFvKaEEJFby4EnfEEYps92ktokKJ4rUPKA+SdjXOJ1m4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="408196856"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="408196856"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 13:31:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681125873"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681125873"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2023 13:31:26 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 04/16] dmaengine: idxd: add interrupt handling for event log
Date:   Fri,  7 Apr 2023 13:31:31 -0700
Message-Id: <20230407203143.2189681-5-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230407203143.2189681-1-fenghua.yu@intel.com>
References: <20230407203143.2189681-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 96b552614ee7..1b33834336ab 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -168,6 +168,7 @@ enum iax_completion_status {
 
 #define DSA_COMP_STATUS_MASK		0x7f
 #define DSA_COMP_STATUS_WRITE		0x80
+#define DSA_COMP_STATUS(status)		((status) & DSA_COMP_STATUS_MASK)
 
 struct dsa_hw_desc {
 	uint32_t	pasid:20;
-- 
2.37.1

