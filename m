Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49F32F87F5
	for <lists+dmaengine@lfdr.de>; Fri, 15 Jan 2021 22:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbhAOVxf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Jan 2021 16:53:35 -0500
Received: from mga02.intel.com ([134.134.136.20]:40498 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbhAOVxe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 Jan 2021 16:53:34 -0500
IronPort-SDR: 8/FNHFUtx3Zjv9D/hISg4PEvtjnBVCSfbiVoUdUYSczAfuqGRrsjhLkzap/MTwyvSsCWkPC9ty
 JsONGENzizFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="165698456"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="165698456"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 13:52:53 -0800
IronPort-SDR: xbuY7RCtnvGRPRqls0B74Fvlket9VzLNhq5gaqpBHltfAkrRPaxPEqW0tqkT1NoZ84aESJ1hoC
 LfSzir2hXXZQ==
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="465711382"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 13:52:53 -0800
Subject: [PATCH] dmaengine: idxd: Fix list corruption in description
 completion
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        dmaengine@vger.kernel.org
Date:   Fri, 15 Jan 2021 14:52:52 -0700
Message-ID: <161074757267.2183951.17912830858060607266.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Sanjay reported the following kernel splat after running dmatest for stress
testing. The current code is giving up the spinlock in the middle of
a completion list walk, and that opens up opportunity for list corruption
if another thread touches the list at the same time. In order to make sure
the list is always protected, the hardware completed descriptors will be
put on a local list to be completed with callbacks from the outside of
the list lock.

kernel: general protection fault, probably for non-canonical address 0xdead000000000100: 0000 [#1] SMP NOPTI
kernel: CPU: 62 PID: 1814 Comm: irq/89-idxd-por Tainted: G        W         5.10.0-intel-next_10_16+ #1
kernel: Hardware name: Intel Corporation ArcherCity/ArcherCity, BIOS EGSDCRB1.SBT.4915.D02.2012070418 12/07/2020
kernel: RIP: 0010:irq_process_work_list+0xcd/0x170 [idxd]
kernel: Code: e8 18 65 5c d3 8b 45 d4 85 c0 75 b3 4c 89 f7 e8 b9 fe ff ff 84 c0 74 bf 4c 89 e7 e8 dd 6b 5c d3 49 8b 3f 49 8b 4f 08 48 89 c6 <48> 89 4f 08 48 89 39 4c 89 e7 48 b9 00 01 00 00 00 00 ad de 49 89
kernel: RSP: 0018:ff256768c4353df8 EFLAGS: 00010046
kernel: RAX: 0000000000000202 RBX: dead000000000100 RCX: dead000000000122
kernel: RDX: 0000000000000001 RSI: 0000000000000202 RDI: dead000000000100
kernel: RBP: ff256768c4353e40 R08: 0000000000000001 R09: 0000000000000000
kernel: R10: 0000000000000000 R11: 00000000ffffffff R12: ff1fdf9fd06b3e48
kernel: R13: 0000000000000005 R14: ff1fdf9fc4275980 R15: ff1fdf9fc4275a00
kernel: FS:  0000000000000000(0000) GS:ff1fdfa32f880000(0000) knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 00007f87f24012a0 CR3: 000000010f630004 CR4: 0000000003771ee0
kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kernel: DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
kernel: PKRU: 55555554
kernel: Call Trace:
kernel: ? irq_thread+0xa9/0x1b0
kernel: idxd_wq_thread+0x34/0x90 [idxd]
kernel: irq_thread_fn+0x24/0x60
kernel: irq_thread+0x10f/0x1b0
kernel: ? irq_forced_thread_fn+0x80/0x80
kernel: ? wake_threads_waitq+0x30/0x30
kernel: ? irq_thread_check_affinity+0xe0/0xe0
kernel: kthread+0x142/0x160
kernel: ? kthread_park+0x90/0x90
kernel: ret_from_fork+0x1f/0x30
kernel: Modules linked in: idxd_ktest dmatest intel_rapl_msr idxd_mdev iTCO_wdt vfio_pci vfio_virqfd iTCO_vendor_support intel_rapl_common i10nm_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper rapl msr pcspkr snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg ofpart snd_hda_codec snd_hda_core snd_hwdep cmdlinepart snd_seq snd_seq_device idxd snd_pcm intel_spi_pci intel_spi snd_timer spi_nor input_leds joydev snd i2c_i801 mtd soundcore i2c_smbus mei_me mei i2c_ismt ipmi_ssif acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler mac_hid sunrpc nls_iso8859_1 sch_fq_codel ip_tables x_tables xfs libcrc32c ast drm_vram_helper drm_ttm_helper ttm igc wmi pinctrl_sunrisepoint hid_generic usbmouse usbkbd usbhid hid
kernel: ---[ end trace cd5ca950ef0db25f ]---

Reported-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Fixes: e4f4d8cdeb9a ("dmaengine: idxd: Clean up descriptors with fault error")
---
 drivers/dma/idxd/irq.c |   86 +++++++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 5d48f9b1b3aa..a60ca11a5784 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -237,29 +237,27 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 	return IRQ_HANDLED;
 }
 
-static bool process_fault(struct idxd_desc *desc, u64 fault_addr)
+static inline bool match_fault(struct idxd_desc *desc, u64 fault_addr)
 {
 	/*
 	 * Completion address can be bad as well. Check fault address match for descriptor
 	 * and completion address.
 	 */
-	if ((u64)desc->hw == fault_addr ||
-	    (u64)desc->completion == fault_addr) {
-		idxd_dma_complete_txd(desc, IDXD_COMPLETE_DEV_FAIL);
+	if ((u64)desc->hw == fault_addr || (u64)desc->completion == fault_addr) {
+		struct idxd_device *idxd = desc->wq->idxd;
+		struct device *dev = &idxd->pdev->dev;
+
+		dev_warn(dev, "desc with fault address: %#llx\n", fault_addr);
 		return true;
 	}
 
 	return false;
 }
 
-static bool complete_desc(struct idxd_desc *desc)
+static inline void complete_desc(struct idxd_desc *desc, enum idxd_complete_type reason)
 {
-	if (desc->completion->status) {
-		idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL);
-		return true;
-	}
-
-	return false;
+	idxd_dma_complete_txd(desc, reason);
+	idxd_free_desc(desc->wq, desc);
 }
 
 static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
@@ -269,25 +267,25 @@ static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
 	struct idxd_desc *desc, *t;
 	struct llist_node *head;
 	int queued = 0;
-	bool completed = false;
 	unsigned long flags;
+	enum idxd_complete_type reason;
 
 	*processed = 0;
 	head = llist_del_all(&irq_entry->pending_llist);
 	if (!head)
 		goto out;
 
-	llist_for_each_entry_safe(desc, t, head, llnode) {
-		if (wtype == IRQ_WORK_NORMAL)
-			completed = complete_desc(desc);
-		else if (wtype == IRQ_WORK_PROCESS_FAULT)
-			completed = process_fault(desc, data);
+	if (wtype == IRQ_WORK_NORMAL)
+		reason = IDXD_COMPLETE_NORMAL;
+	else
+		reason = IDXD_COMPLETE_DEV_FAIL;
 
-		if (completed) {
-			idxd_free_desc(desc->wq, desc);
+	llist_for_each_entry_safe(desc, t, head, llnode) {
+		if (desc->completion->status) {
+			if ((desc->completion->status & DSA_COMP_STATUS_MASK) != DSA_COMP_SUCCESS)
+				match_fault(desc, data);
+			complete_desc(desc, reason);
 			(*processed)++;
-			if (wtype == IRQ_WORK_PROCESS_FAULT)
-				break;
 		} else {
 			spin_lock_irqsave(&irq_entry->list_lock, flags);
 			list_add_tail(&desc->list,
@@ -305,42 +303,46 @@ static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
 				 enum irq_work_type wtype,
 				 int *processed, u64 data)
 {
-	struct list_head *node, *next;
 	int queued = 0;
-	bool completed = false;
 	unsigned long flags;
+	LIST_HEAD(flist);
+	struct idxd_desc *desc, *n;
+	enum idxd_complete_type reason;
 
 	*processed = 0;
-	spin_lock_irqsave(&irq_entry->list_lock, flags);
-	if (list_empty(&irq_entry->work_list))
-		goto out;
-
-	list_for_each_safe(node, next, &irq_entry->work_list) {
-		struct idxd_desc *desc =
-			container_of(node, struct idxd_desc, list);
+	if (wtype == IRQ_WORK_NORMAL)
+		reason = IDXD_COMPLETE_NORMAL;
+	else
+		reason = IDXD_COMPLETE_DEV_FAIL;
 
+	/*
+	 * This lock protects list corruption from access of list outside of the irq handler
+	 * thread.
+	 */
+	spin_lock_irqsave(&irq_entry->list_lock, flags);
+	if (list_empty(&irq_entry->work_list)) {
 		spin_unlock_irqrestore(&irq_entry->list_lock, flags);
-		if (wtype == IRQ_WORK_NORMAL)
-			completed = complete_desc(desc);
-		else if (wtype == IRQ_WORK_PROCESS_FAULT)
-			completed = process_fault(desc, data);
+		return 0;
+	}
 
-		if (completed) {
-			spin_lock_irqsave(&irq_entry->list_lock, flags);
+	list_for_each_entry_safe(desc, n, &irq_entry->work_list, list) {
+		if (desc->completion->status) {
 			list_del(&desc->list);
-			spin_unlock_irqrestore(&irq_entry->list_lock, flags);
-			idxd_free_desc(desc->wq, desc);
 			(*processed)++;
-			if (wtype == IRQ_WORK_PROCESS_FAULT)
-				return queued;
+			list_add_tail(&desc->list, &flist);
 		} else {
 			queued++;
 		}
-		spin_lock_irqsave(&irq_entry->list_lock, flags);
 	}
 
- out:
 	spin_unlock_irqrestore(&irq_entry->list_lock, flags);
+
+	list_for_each_entry(desc, &flist, list) {
+		if ((desc->completion->status & DSA_COMP_STATUS_MASK) != DSA_COMP_SUCCESS)
+			match_fault(desc, data);
+		complete_desc(desc, reason);
+	}
+
 	return queued;
 }
 


