Return-Path: <dmaengine+bounces-10018-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFlIDA9h32k0SQAAu9opvQ
	(envelope-from <dmaengine+bounces-10018-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 11:57:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8C1402FA2
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 11:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CBB6300914B
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 09:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93792C21D9;
	Wed, 15 Apr 2026 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yls1HZOS"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB93233F4
	for <dmaengine@vger.kernel.org>; Wed, 15 Apr 2026 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246641; cv=none; b=oJPJPbP0V+J2vU0zCFIEalH8K3vnE5jBDew+JIR5aD3feOyNoPiklRt+QfOH0XoAfQUg0vN8SvTQ6qqBwjHFc4XnYy1WoxZJe26dnRuHlXxNaM5H9QzeGG4o46nE2ueYFK4lQAZwJToxkYPamVWvEGuNhlKi/N+7pYimQcdy1YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246641; c=relaxed/simple;
	bh=Na3ynCYv05nuk4wg7pwsJ2ux5izRFSMzOdJJ3jiP7UE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k661YyvQoLvfpVm8yZeTVstRLfnXiJvjeXxXefhCzpLEiE86BMNXVEGdVbdZkw37KYbWlzELVY5Zli82HyJwxTxwZH65if9kQLtChIDTehXhU2LNGBlQxuRvW4VMbCba7gv7VSO3/bZg3Q6Efd5eTS17LfG/T08i6rVT7HLSva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yls1HZOS; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776246635; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OlI6MOChUhyVGR/3erRzPfG1tIlWmX7mMb855eECKVw=;
	b=yls1HZOSP7PEUNq2S4HotCf6DfbkbF21u+5ZHeMZBX1zHyrYuqPlZHZXMHEhmj51/bnEqYDiXdTfEo017Q0991Pp8h/UTc8Y07s3r8YjYny0FYf1YQ7q+MpS2hYGZ5xE/T7wWs1ksDRhyr2y0M51+IjmUlDFKl3X3iWGQPUDjvU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X14IUcA_1776246630;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X14IUcA_1776246630 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Apr 2026 17:50:35 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v2] dmaengine: idxd: Fix use-after-free of idxd_wq
Date: Wed, 15 Apr 2026 17:50:30 +0800
Message-Id: <20260415095030.42183-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10018-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kanie@linux.alibaba.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C8C1402FA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We found an idxd_wq use-after-free issue with kasan
when remove the idxd PCI device:

BUG: KASAN: slab-use-after-free in idxd_device_drv_remove+0x1f8/0x240 [idxd]
Call Trace:
  <TASK>
  dump_stack_lvl+0x32/0x50
  print_address_description.constprop.0+0x2c/0x390
  ? idxd_device_drv_remove+0x1f8/0x240 [idxd]
  print_report+0xba/0x280
  ? kasan_addr_to_slab+0x9/0xa0
  ? idxd_device_drv_remove+0x1f8/0x240 [idxd]
  kasan_report+0xab/0xe0
  ? idxd_device_drv_remove+0x1f8/0x240 [idxd]
  idxd_device_drv_remove+0x1f8/0x240 [idxd]
  device_release_driver_internal+0x391/0x560
  bus_remove_device+0x1f5/0x3f0
  device_del+0x392/0x990
  ? __pfx_device_del+0x10/0x10
  ? kobject_cleanup+0x117/0x360
  ? idxd_unregister_devices+0x229/0x320 [idxd]
  device_unregister+0x13/0xa0
  idxd_remove+0x4f/0x1b0 [idxd]
  pci_device_remove+0xa7/0x1d0
  device_release_driver_internal+0x391/0x560
  ? pci_pme_active+0x1e/0x450
  pci_stop_bus_device+0x10a/0x150
  pci_stop_and_remove_bus_device_locked+0x16/0x30
  remove_store+0xcf/0xe0

Freed by task 15535:
  kasan_save_stack+0x1c/0x40
  kasan_set_track+0x21/0x30
  kasan_save_free_info+0x27/0x40
  ____kasan_slab_free+0x171/0x240
  slab_free_freelist_hook+0xde/0x190
  __kmem_cache_free+0x19e/0x310
  device_release+0x98/0x210
  kobject_cleanup+0x102/0x360
  idxd_unregister_devices+0xb3/0x320 [idxd]
  dxd_remove+0x3f/0x1b0 [idxd]
  pci_device_remove+0xa7/0x1d0
  device_release_driver_internal+0x391/0x560
  pci_stop_bus_device+0x10a/0x150
  pci_stop_and_remove_bus_device_locked+0x16/0x30
  remove_store+0xcf/0xe0

In the idxd_remove() flow, when execution reaches
idxd_unregister_devices(), all idxd_wq instances have already been
freed. Subsequently, when device_unregister(idxd_confdev(idxd)) is
executed, it calls into idxd_device_drv_remove() which accesses the
already-freed idxd_wq. This fix resolves the issue by calling
device_release_driver() before idxd_unregister_devices().

Fixes: 98da0106aac0d ("dmanegine: idxd: fix resource free ordering on driver removal")
Co-developed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
v1 -> v2:
  1. Call device_release_driver() in advance instead of swapping the order of
     device_unregister() and idxd_unregister_devices().
  2. Add Co-developed-by: Shuai Xue <xueshuai@linux.alibaba.com>.
 drivers/dma/idxd/init.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index f1cfc7790d95..3b0a0363ca65 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1293,13 +1293,30 @@ static void idxd_remove(struct pci_dev *pdev)
 {
 	struct idxd_device *idxd = pci_get_drvdata(pdev);
 
+	/*
+	 * The idxd sub-driver's remove callback (idxd_device_drv_remove())
+	 * iterates idxd->wqs[] and accesses wq objects. We must unbind the
+	 * sub-driver before idxd_unregister_devices() frees these objects,
+	 * otherwise a use-after-free occurs.
+	 *
+	 * We cannot simply reorder device_unregister(idxd_confdev) before
+	 * idxd_unregister_devices() because device_del() -> kobject_del()
+	 * recursively removes the parent's sysfs directory, which destroys
+	 * children's sysfs entries. Subsequent device_unregister() on the
+	 * children then fails with "sysfs group 'power' not found".
+	 *
+	 * Use device_release_driver() to only unbind the driver (triggering
+	 * idxd_device_drv_remove()) without touching sysfs. Then safely
+	 * unregister children before the parent.
+	 */
+	device_release_driver(idxd_confdev(idxd));
 	idxd_unregister_devices(idxd);
+
 	/*
-	 * When ->release() is called for the idxd->conf_dev, it frees all the memory related
-	 * to the idxd context. The driver still needs those bits in order to do the rest of
-	 * the cleanup. However, we do need to unbound the idxd sub-driver. So take a ref
-	 * on the device here to hold off the freeing while allowing the idxd sub-driver
-	 * to unbind.
+	 * When ->release() is called for the idxd->conf_dev, it frees all the
+	 * memory related to the idxd context. The driver still needs those bits
+	 * in order to do the rest of the cleanup. So take a ref on the device
+	 * here to hold off the freeing.
 	 */
 	get_device(idxd_confdev(idxd));
 	device_unregister(idxd_confdev(idxd));
-- 
2.32.0.3.g01195cf9f


