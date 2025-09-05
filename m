Return-Path: <dmaengine+bounces-6413-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B76AB462A6
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 20:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D3A5E08FC
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC9727F4D5;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jejWE39U"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0980127A46F;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098131; cv=none; b=an+JLMFz/R79cwcz3n3RXS0DjSZf0UyYFeP7/uf/KWVwkl28Iklao7lqdOg0VKh2j92j/N44/HAEWGlJiuMAJip2HJvgz1PJTDq4hc1gEvwfCWAR/vYmdb98RrM1Jaa/2Z97h97+tJFputD+ajZOsSLGW/ybzG8XzYD2WztZFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098131; c=relaxed/simple;
	bh=wiKtrMUTBnbglWQdf3kSumEayhCZBoUGyUsbB4zNui0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ckGkdUg48tWjtLPZvbeUYY1jeat55KYrRf1LXBBnM5VYnBVPG7+etsl8rgC5H22PnwwPUQU9kRMKfeL+bkJ4sldAFfiUYcnxmlDk9sOYczg/fB9Uft3BcsRafLFQRkGRH5uciRazWcZvy7ph0Z3ro5wL8HogY9RbDictezt0otk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jejWE39U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9927C116B1;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098130;
	bh=wiKtrMUTBnbglWQdf3kSumEayhCZBoUGyUsbB4zNui0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jejWE39UFeayJLgnCIT97DVFruUITO5IRxYVJWdCwrX6AWJsC9MEaocKO0kn1RxBz
	 9gHr5IjTSzOjrK9WL1TwUzsXDSTs8lF6U4aQz3ucO0pzmXZhsCcqRR0aw77nR2LQYf
	 nHbvCN1+G+ueYKe2fYnsasFZ/vduP08owZOs6AmQrciThCRuMHzbuHo8tdu1xt+gDE
	 wwptPt0BlDwUMI0D7UoXOlQqbo5gLWhA4x4k70QcfgYqR2RjkmU6oh8wVd2pNTpAtD
	 5NXYOzDGZ8ORwecqB7J2DxaW/z/N1vDkjN2DV6GVcP4G+z6CNl1n1BqzcgVcBjUzTE
	 qUjwji3P897xg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE75DCA1016;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Sep 2025 13:48:30 -0500
Subject: [PATCH RFC 07/13] dmaengine: sdxi: Import descriptor enqueue code
 from spec
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sdxi-base-v1-7-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
In-Reply-To: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757098128; l=7380;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=V/0nM3VPtzsbRtFsPQeZdWfXoMPAZ0o1AE15Y38dm0o=;
 b=1pvAl0avFaxDykwFGf9Ax+fGUUnqKK5QmQiIabsFmkUCiMOieAGEKZrrlTAtQhwDGj6gJOF/m
 VRgUqSw0VKPD6Vi/5/uCIEluW3p6j2ogo8khUvU8QLWP2RXRroaEazw
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Import the example code from the "SDXI Descriptor Ring Operation"
chapter of the SDXI 1.0 spec[1], which demonstrates lockless
descriptor submission to the ring. Lightly alter the code
to (somewhat) comply with Linux coding style, and use byte order-aware
types as well as kernel atomic and barrier APIs.

Ultimately we may not really need a lockless submission path, and it
would be better for it to more closely integrate with the rest of the
driver.

[1] https://www.snia.org/sites/default/files/technical-work/sdxi/release/SNIA-SDXI-Specification-v1.0a.pdf

Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/enqueue.c | 136 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/enqueue.h |  16 ++++++
 2 files changed, 152 insertions(+)

diff --git a/drivers/dma/sdxi/enqueue.c b/drivers/dma/sdxi/enqueue.c
new file mode 100644
index 0000000000000000000000000000000000000000..822d9b890fa3538dcc09e99ef562a6d8419290f0
--- /dev/null
+++ b/drivers/dma/sdxi/enqueue.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ *
+ * Copyright (c) 2024, The Storage Networking Industry Association.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * * Redistributions of source code must retain the above copyright
+ * notice, this list of conditions and the following disclaimer.
+ *
+ * * Redistributions in binary form must reproduce the above copyright
+ * notice, this list of conditions and the following disclaimer in the
+ * documentation and/or other materials provided with the
+ * distribution.
+ *
+ * * Neither the name of The Storage Networking Industry Association
+ * (SNIA) nor the names of its contributors may be used to endorse or
+ * promote products derived from this software without specific prior
+ * written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
+ * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
+ * OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <asm/barrier.h>
+#include <asm/byteorder.h>
+#include <asm/rwonce.h>
+#include <linux/atomic.h>
+#include <linux/errno.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/processor.h>
+#include <linux/types.h>
+
+#include "enqueue.h"
+
+/*
+ * Code adapted from the "SDXI Descriptor Ring Operation" chapter of
+ * the SDXI spec, specifically the example code in "Enqueuing one or
+ * more Descriptors."
+ */
+
+#define SDXI_DESCR_SIZE 64
+#define SDXI_DS_NUM_QW (SDXI_DESCR_SIZE / sizeof(__le64))
+#define SDXI_MULTI_PRODUCER 1  /* Define to 0 if single-producer. */
+
+static int update_ring(const __le64 *enq_entries,   /* Ptr to entries to enqueue */
+		       u64 enq_num,                 /* Number of entries to enqueue */
+		       __le64 *ring_base,           /* Ptr to ring location */
+		       u64 ring_size,               /* (Ring Size in bytes)/64 */
+		       u64 index)                   /* Starting ring index to update */
+{
+	for (u64 i = 0; i < enq_num; i++) {
+		__le64 *ringp = ring_base + ((index + i) % ring_size) * SDXI_DS_NUM_QW;
+		const __le64 *entryp = enq_entries + (i * SDXI_DS_NUM_QW);
+
+		for (u64 j = 1; j < SDXI_DS_NUM_QW; j++)
+			*(ringp + j) = *(entryp + j);
+	}
+
+	/* Now write the first QW of the new entries to the ring. */
+	dma_wmb();
+	for (u64 i = 0; i < enq_num; i++) {
+		__le64 *ringp = ring_base + ((index + i) % ring_size) * SDXI_DS_NUM_QW;
+		const __le64 *entryp = enq_entries + (i * SDXI_DS_NUM_QW);
+
+		*ringp = *entryp;
+	}
+
+	return 0;
+}
+
+int sdxi_enqueue(const __le64 *enq_entries,                 /* Ptr to entries to enqueue */
+		 u64 enq_num,                               /* Number of entries to enqueue */
+		 __le64 *ring_base,                         /* Ptr to ring location */
+		 u64 ring_size,                             /* (Ring Size in bytes)/64 */
+		 __le64 const volatile * const Read_Index,  /* Ptr to Read_Index location */
+		 __le64 volatile * const Write_Index,       /* Ptr to Write_Index location */
+		 __le64 __iomem *Door_Bell)                 /* Ptr to Ring Doorbell location */
+{
+	u64 old_write_idx;
+	u64 new_idx;
+
+	while (true) {
+		u64 read_idx;
+
+		read_idx = le64_to_cpu(READ_ONCE(*Read_Index));
+		dma_rmb();  /* Get Read_Index before Write_Index to always get consistent values */
+		old_write_idx = le64_to_cpu(READ_ONCE(*Write_Index));
+
+		if (read_idx > old_write_idx) {
+			/* Only happens if Write_Index wraps or ring has bad setup */
+			return -EIO;
+		}
+
+		new_idx = old_write_idx + enq_num;
+		if (new_idx - read_idx > ring_size) {
+			cpu_relax();
+			continue;  /* Not enough free entries, try again */
+		}
+
+		if (SDXI_MULTI_PRODUCER) {
+			/* Try to atomically update Write_Index. */
+			bool success = cmpxchg(Write_Index,
+					       cpu_to_le64(old_write_idx),
+					       cpu_to_le64(new_idx)) == cpu_to_le64(old_write_idx);
+			if (success)
+				break;  /* Updated Write_Index, no need to try again. */
+		} else {
+			/* Single-Producer case */
+			WRITE_ONCE(*Write_Index, cpu_to_le64(new_idx));
+			dma_wmb();  /* Make the Write_Index update visible before the Door_Bell update. */
+			break;  /* Always successful for single-producer */
+		}
+		/* Couldn"t update Write_Index, try again. */
+	}
+
+	/* Write_Index is now advanced. Let's write out entries to the ring. */
+	update_ring(enq_entries, enq_num, ring_base, ring_size, old_write_idx);
+
+	/* Door_Bell write required; only needs ordering wrt update of Write_Index. */
+	iowrite64(new_idx, Door_Bell);
+
+	return 0;
+}
diff --git a/drivers/dma/sdxi/enqueue.h b/drivers/dma/sdxi/enqueue.h
new file mode 100644
index 0000000000000000000000000000000000000000..28c1493779db1119ff0d682fa6623b016998042a
--- /dev/null
+++ b/drivers/dma/sdxi/enqueue.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/* Copyright (c) 2024, The Storage Networking Industry Association. */
+#ifndef DMA_SDXI_ENQUEUE_H
+#define DMA_SDXI_ENQUEUE_H
+
+#include <linux/types.h>
+
+int sdxi_enqueue(const __le64 *enq_entries,  /* Ptr to entries to enqueue */
+		 u64 enq_num,  /* Number of entries to enqueue */
+		 __le64 *ring_base,  /* Ptr to ring location */
+		 u64 ring_size,  /* (Ring Size in bytes)/64 */
+		 __le64 const volatile * const Read_Index,  /* Ptr to Read_Index location */
+		 __le64 volatile * const Write_Index,  /* Ptr to Write_Index location */
+		 __le64 __iomem *Door_Bell);  /* Ptr to Ring Doorbell location */
+
+#endif /* DMA_SDXI_ENQUEUE_H */

-- 
2.39.5



