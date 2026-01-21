Return-Path: <dmaengine+bounces-8443-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMciG/sfcWmodQAAu9opvQ
	(envelope-from <dmaengine+bounces-8443-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 19:50:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D1E5B886
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 19:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B185B28BD2
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 18:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DCD3E959F;
	Wed, 21 Jan 2026 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GexNV5LH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8DF3DA7D3;
	Wed, 21 Jan 2026 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020502; cv=none; b=M2HrfGTarTwoFX/3LuQRn0wZEOiuN947Xj1KTPTDC8zqVWo5mfT5UAY8LcvHj7SHCBsaCT+py8MIOZWmZ+qsjixgWyHENXmxzFrBUCurflB7v3lVYCz1LTQW/PrH8oCXQt5IkuJU5gdjx/ITEBcsTv2ZcytLR42uWjrySILrnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020502; c=relaxed/simple;
	bh=njKeUhSH2tyS6rtMuzBKozakzz3C8aDQolCg7dB4/r0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z+s/KWf28O/BqvDXwjyQaso0y7VOKrvzHni/Lkc7LJBz+EFPBN0n3gc7lll8LszegiWmF7CSsdkEUrrcKnTDNv+NrkLhM5LucjFJuEHJmlybxXbBB+0h+l5oqO7OarumabKoG2XwRNGQmh4LfLbOGVwrPFDBbVsC/nPMewde6ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GexNV5LH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769020500; x=1800556500;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=njKeUhSH2tyS6rtMuzBKozakzz3C8aDQolCg7dB4/r0=;
  b=GexNV5LHG5nggU/KcyPmDEX0fF0VpAycKaXOxrlBJJNl/dchU9M+Ufdv
   GesbI+6oQj/suypDeSRC+pzM6Q+J5cyyIxakSGMdKVSW33/gFjn+7eDqK
   Aga00FbGCul9swxAvJP8E4sQIfjWqWUY30DZliLRB1hZ/nINg2DK36nlj
   R+Kc0evOsPUI8ty5Z8bIN2G0J/7P3ZZbPm2WXhdqSUSrRWnUUuk/5Ms7+
   E4hUdqMJQgE51TrJJxtd9gGOSGGnUMNHLCgFvBXJSgcRQzTwyPzn0OB9s
   ojMLHm38hHZ7fInIIEJ7ja3E/+F/2Der+A1/GrHSiA7Fbk/7aeP1prc4P
   A==;
X-CSE-ConnectionGUID: 2ebm2cSYTKKjYlSWY8TY9w==
X-CSE-MsgGUID: HuV8bfqNQVWe6RUeGtzLIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70349900"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="70349900"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:34:56 -0800
X-CSE-ConnectionGUID: /CuBAsVCRk2RvcMo6GuLVw==
X-CSE-MsgGUID: eno419LVSjSmcsJEhCI/Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="210678464"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:34:54 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 21 Jan 2026 10:34:30 -0800
Subject: [PATCH v3 04/10] dmaengine: idxd: Flush kernel workqueues on
 Function Level Reset
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-4-7ed70658a9d1@intel.com>
References: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-0-7ed70658a9d1@intel.com>
In-Reply-To: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-0-7ed70658a9d1@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769020494; l=3474;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=njKeUhSH2tyS6rtMuzBKozakzz3C8aDQolCg7dB4/r0=;
 b=vReA2dfA1EMxv0xJsiHQlQFfGoJDX7xrmqbSm6u1CEcXXobz8m7bkb0kYauxdD+lu5VnVo+Qx
 A3s2c5BqTIYARtMVfnnpyfzvj5JgmcD7O5XZGsnTWy2GsMMTYn59yz1
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8443-lists,dmaengine=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 02D1E5B886
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a Function Level Reset (FLR) happens, terminate the pending
descriptors that were issued by in-kernel users and disable the
interrupts associated with those. They will be re-enabled after FLR
finishes.

idxd_wq_flush_desc() is declared on idxd.h because it's going to be
used in by the DMA backend in a future patch.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/device.c | 22 ++++++++++++++++++++++
 drivers/dma/idxd/idxd.h   |  1 +
 drivers/dma/idxd/irq.c    | 16 ++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5265925f3076..5e890b6771cb 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1339,6 +1339,11 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
 
 	free_irq(ie->vector, ie);
 	idxd_flush_pending_descs(ie);
+
+	/* The interrupt might have been already released by FLR */
+	if (ie->int_handle == INVALID_INT_HANDLE)
+		return;
+
 	if (idxd->request_int_handles)
 		idxd_device_release_int_handle(idxd, ie->int_handle, IDXD_IRQ_MSIX);
 	idxd_device_clear_perm_entry(idxd, ie);
@@ -1347,6 +1352,23 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
 	ie->pasid = IOMMU_PASID_INVALID;
 }
 
+void idxd_wq_flush_descs(struct idxd_wq *wq)
+{
+	struct idxd_irq_entry *ie = &wq->ie;
+	struct idxd_device *idxd = wq->idxd;
+
+	guard(mutex)(&wq->wq_lock);
+
+	if (wq->state != IDXD_WQ_ENABLED || wq->type != IDXD_WQT_KERNEL)
+		return;
+
+	idxd_flush_pending_descs(ie);
+	if (idxd->request_int_handles)
+		idxd_device_release_int_handle(idxd, ie->int_handle, IDXD_IRQ_MSIX);
+	idxd_device_clear_perm_entry(idxd, ie);
+	ie->int_handle = INVALID_INT_HANDLE;
+}
+
 int idxd_wq_request_irq(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index ea8c4daed38d..ce78b9a7c641 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -803,6 +803,7 @@ void idxd_wq_quiesce(struct idxd_wq *wq);
 int idxd_wq_init_percpu_ref(struct idxd_wq *wq);
 void idxd_wq_free_irq(struct idxd_wq *wq);
 int idxd_wq_request_irq(struct idxd_wq *wq);
+void idxd_wq_flush_descs(struct idxd_wq *wq);
 
 /* submission */
 int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc);
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 1107db3ce0a3..8d0eaf5029fa 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -397,6 +397,17 @@ static void idxd_device_flr(struct work_struct *work)
 		dev_err(&idxd->pdev->dev, "FLR failed\n");
 }
 
+static void idxd_wqs_flush_descs(struct idxd_device *idxd)
+{
+	int i;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *wq = idxd->wqs[i];
+
+		idxd_wq_flush_descs(wq);
+	}
+}
+
 static irqreturn_t idxd_halt(struct idxd_device *idxd)
 {
 	union gensts_reg gensts;
@@ -415,6 +426,11 @@ static irqreturn_t idxd_halt(struct idxd_device *idxd)
 		} else if (gensts.reset_type == IDXD_DEVICE_RESET_FLR) {
 			idxd->state = IDXD_DEV_HALTED;
 			idxd_mask_error_interrupts(idxd);
+			/* Flush all pending descriptors, and disable
+			 * interrupts, they will be re-enabled when FLR
+			 * concludes.
+			 */
+			idxd_wqs_flush_descs(idxd);
 			dev_dbg(&idxd->pdev->dev,
 				"idxd halted, doing FLR. After FLR, configs are restored\n");
 			INIT_WORK(&idxd->work, idxd_device_flr);

-- 
2.52.0


