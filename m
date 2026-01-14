Return-Path: <dmaengine+bounces-8244-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DCDD1C8F4
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 06:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D82C3038288
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 05:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942C634EEE7;
	Wed, 14 Jan 2026 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="Nzkb9Akz";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="Nzkb9Akz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A715A33509B
	for <dmaengine@vger.kernel.org>; Wed, 14 Jan 2026 05:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768367744; cv=none; b=AqHUfjcnjLwQTgo/73A7QC1EHaSBFv8eKKHt5Ewyesi8Vwj+oKumS7oEVgmVuWJexWmlvMCPKqrBws8jqTyk8RYhFlYVWEKUXjSlyXXGg8mlftntc45SqIzDEosWfJ8dF9EQisTXTP/TWhhfOvTNgg33OouRZO6hycNolG4LuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768367744; c=relaxed/simple;
	bh=JWtyRdM+P6tjlZl/Fi7+mI2HKpt62sZAbA5v+QE1ZTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gzqLHcIQsX65cUhM98pZS29v3FevQK3gWUZdUZTKZIhMuyjextXT4gwWGoahmK2kUW2jNZlObftD/celwUg11cXzkmWTBB4fRMjlIN/8tD8WUwV+prcpe4shHXaR43ecpECLX5EcmFCqPC1CgKajR7mkdhEscL5edax/52B1DhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=Nzkb9Akz; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=Nzkb9Akz; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768367725; bh=JWtyRdM+P6tjlZl/Fi7+mI2HKpt62sZAbA5v+QE1ZTY=;
	h=From:To:Cc:Subject:Date:From;
	b=Nzkb9AkztrrBUgW2G58ZUWxQ/L1uLbAF58+7XtReHjwaiqMMuf7XEki1rjxx3STZo
	 SxflWxzL6wpz60h4/qNThmCEqNVfUMgTEgV44sKEwFWELJdxfqOHlg/IpdehWmBK1V
	 X0U54QNwUobdmmmhe7HonN++7ZzdaR2kY6cfmMFqZsvo+rUgaafMf/qGYVBpeWIzin
	 B4TpbqElMW3NNrWEOMKTmxV6+Vhw4Sn/PmO9VVUEd0EV7zQbgCzHVOIpAjcWnANWko
	 ysTIVL86wY9LKW7txjYGhvJ6DPDevG0kTsU3orCWuxRISIs4GAk2vGpp9iFAvhLE8p
	 62+XWcgM9GCpw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id C68123EC67A;
	Wed, 14 Jan 2026 05:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768367725; bh=JWtyRdM+P6tjlZl/Fi7+mI2HKpt62sZAbA5v+QE1ZTY=;
	h=From:To:Cc:Subject:Date:From;
	b=Nzkb9AkztrrBUgW2G58ZUWxQ/L1uLbAF58+7XtReHjwaiqMMuf7XEki1rjxx3STZo
	 SxflWxzL6wpz60h4/qNThmCEqNVfUMgTEgV44sKEwFWELJdxfqOHlg/IpdehWmBK1V
	 X0U54QNwUobdmmmhe7HonN++7ZzdaR2kY6cfmMFqZsvo+rUgaafMf/qGYVBpeWIzin
	 B4TpbqElMW3NNrWEOMKTmxV6+Vhw4Sn/PmO9VVUEd0EV7zQbgCzHVOIpAjcWnANWko
	 ysTIVL86wY9LKW7txjYGhvJ6DPDevG0kTsU3orCWuxRISIs4GAk2vGpp9iFAvhLE8p
	 62+XWcgM9GCpw==
Received: from mail.mleia.com (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id 63B083EC06A;
	Wed, 14 Jan 2026 05:15:25 +0000 (UTC)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Vinod Koul <vkoul@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org
Subject: [PATCH] dma: iop32x-adma: Remove a leftover header file
Date: Wed, 14 Jan 2026 07:14:58 +0200
Message-ID: <20260114051508.3908807-1-vz@mleia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260114_051525_831279_E0BE60B8 
X-CRM114-Status: GOOD (  13.68  )

The Intel IOPx3xx platform was completely removed in commit b91a69d162aa
("ARM: iop32x: remove the platform"), and it'd be safe to remove an unused
and leftover platform data specific header file dma-iop32x.h also.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 include/linux/platform_data/dma-iop32x.h | 110 -----------------------
 1 file changed, 110 deletions(-)
 delete mode 100644 include/linux/platform_data/dma-iop32x.h

diff --git a/include/linux/platform_data/dma-iop32x.h b/include/linux/platform_data/dma-iop32x.h
deleted file mode 100644
index ac83cff89549..000000000000
--- a/include/linux/platform_data/dma-iop32x.h
+++ /dev/null
@@ -1,110 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright © 2006, Intel Corporation.
- */
-#ifndef IOP_ADMA_H
-#define IOP_ADMA_H
-#include <linux/types.h>
-#include <linux/dmaengine.h>
-#include <linux/interrupt.h>
-
-#define IOP_ADMA_SLOT_SIZE 32
-#define IOP_ADMA_THRESHOLD 4
-#ifdef DEBUG
-#define IOP_PARANOIA 1
-#else
-#define IOP_PARANOIA 0
-#endif
-#define iop_paranoia(x) BUG_ON(IOP_PARANOIA && (x))
-
-#define DMA0_ID 0
-#define DMA1_ID 1
-#define AAU_ID 2
-
-/**
- * struct iop_adma_device - internal representation of an ADMA device
- * @pdev: Platform device
- * @id: HW ADMA Device selector
- * @dma_desc_pool: base of DMA descriptor region (DMA address)
- * @dma_desc_pool_virt: base of DMA descriptor region (CPU address)
- * @common: embedded struct dma_device
- */
-struct iop_adma_device {
-	struct platform_device *pdev;
-	int id;
-	dma_addr_t dma_desc_pool;
-	void *dma_desc_pool_virt;
-	struct dma_device common;
-};
-
-/**
- * struct iop_adma_chan - internal representation of an ADMA device
- * @pending: allows batching of hardware operations
- * @lock: serializes enqueue/dequeue operations to the slot pool
- * @mmr_base: memory mapped register base
- * @chain: device chain view of the descriptors
- * @device: parent device
- * @common: common dmaengine channel object members
- * @last_used: place holder for allocation to continue from where it left off
- * @all_slots: complete domain of slots usable by the channel
- * @slots_allocated: records the actual size of the descriptor slot pool
- * @irq_tasklet: bottom half where iop_adma_slot_cleanup runs
- */
-struct iop_adma_chan {
-	int pending;
-	spinlock_t lock; /* protects the descriptor slot pool */
-	void __iomem *mmr_base;
-	struct list_head chain;
-	struct iop_adma_device *device;
-	struct dma_chan common;
-	struct iop_adma_desc_slot *last_used;
-	struct list_head all_slots;
-	int slots_allocated;
-	struct tasklet_struct irq_tasklet;
-};
-
-/**
- * struct iop_adma_desc_slot - IOP-ADMA software descriptor
- * @slot_node: node on the iop_adma_chan.all_slots list
- * @chain_node: node on the op_adma_chan.chain list
- * @hw_desc: virtual address of the hardware descriptor chain
- * @phys: hardware address of the hardware descriptor chain
- * @group_head: first operation in a transaction
- * @slot_cnt: total slots used in an transaction (group of operations)
- * @slots_per_op: number of slots per operation
- * @idx: pool index
- * @tx_list: list of descriptors that are associated with one operation
- * @async_tx: support for the async_tx api
- * @group_list: list of slots that make up a multi-descriptor transaction
- *	for example transfer lengths larger than the supported hw max
- * @xor_check_result: result of zero sum
- * @crc32_result: result crc calculation
- */
-struct iop_adma_desc_slot {
-	struct list_head slot_node;
-	struct list_head chain_node;
-	void *hw_desc;
-	struct iop_adma_desc_slot *group_head;
-	u16 slot_cnt;
-	u16 slots_per_op;
-	u16 idx;
-	struct list_head tx_list;
-	struct dma_async_tx_descriptor async_tx;
-	union {
-		u32 *xor_check_result;
-		u32 *crc32_result;
-		u32 *pq_check_result;
-	};
-};
-
-struct iop_adma_platform_data {
-	int hw_id;
-	dma_cap_mask_t cap_mask;
-	size_t pool_size;
-};
-
-#define to_iop_sw_desc(addr_hw_desc) \
-	container_of(addr_hw_desc, struct iop_adma_desc_slot, hw_desc)
-#define iop_hw_desc_slot_idx(hw_desc, idx) \
-	( (void *) (((unsigned long) hw_desc) + ((idx) << 5)) )
-#endif
-- 
2.51.0


