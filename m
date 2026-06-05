Return-Path: <dmaengine+bounces-11181-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S6iEJmWAImocZAEAu9opvQ
	(envelope-from <dmaengine+bounces-11181-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 09:53:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9683264627E
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 09:53:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=h8wRxlvE;
	dkim=pass header.d=redhat.com header.s=google header.b=Y9xeLsaJ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11181-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11181-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57CA13007A75
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 07:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F3243D4E6;
	Fri,  5 Jun 2026 07:40:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BAB3988E0
	for <dmaengine@vger.kernel.org>; Fri,  5 Jun 2026 07:39:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645200; cv=none; b=DwuoBtsjsyeeauqfJOVsGMxnP9uCSiFsUf/y4Kn/d0w6d3SZ16z6JV6ercFdfkJsM/mTt4IaHr5YgmrE0HRNL9Z6ihXc5I+5ZEWsZ+6ILR4oJyr/+VLJVdewRgLG/v9fQoXNCQq41h1URa+5sgfzvHdEbOyCbOWQ3NOOz98u+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645200; c=relaxed/simple;
	bh=fGD7ZReAn6EGcDZWqmIBint3OhA0UM9aSPqb5RH4Pg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rWnCg+OKMYN5pet02JIs6LihgnYCM3oOtZ0KH0Z0B9ajeHNV3xMCIiK4OgITl7/vRP5g9+JoTDHqADKqc+JbMg2FmKLqo/DjCgwG1kOj3cY+emjLvQjG6x0ZXnNM5fv2duIFGaEgCm19K1vcjZReM7F1Kae0UXpb7gqcI/AgzKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8wRxlvE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9xeLsaJ; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780645197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yxLY9EqpF77hSPOoFBzsiCl9/0u0FyX67Jy/NSMRVXo=;
	b=h8wRxlvE/2OQ8/JXYePEhI8PEpxurmt37b6X8elP18SXoYw7lZhhg9Lh2BmMT76QfWVPPr
	jKdVdY12myuLDSUwn8cM8to2tTY/yOXejqkDFCebAn/srZYkhxkxLTOov3pGu2XM4MgAyZ
	zikfMMEbVh+dIzOJ3kdsxGeF6th3Vcg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-f7tOem49MXeAiMa2Cd9caA-1; Fri, 05 Jun 2026 03:39:56 -0400
X-MC-Unique: f7tOem49MXeAiMa2Cd9caA-1
X-Mimecast-MFC-AGG-ID: f7tOem49MXeAiMa2Cd9caA_1780645195
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45f3d008865so1135024f8f.0
        for <dmaengine@vger.kernel.org>; Fri, 05 Jun 2026 00:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780645195; x=1781249995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yxLY9EqpF77hSPOoFBzsiCl9/0u0FyX67Jy/NSMRVXo=;
        b=Y9xeLsaJjHD7anxFSUKMsmw0kGcs8f5uc4pIXGajizMXBmN4nsv07dueeRatBmhZ0C
         DDJFBZ52y6I/pBcZUQfI2c9MT2J+6r9Zha4ZLAwUYn2RO69FhaJvn0lI7yVW5rcH7mwp
         diZRuuYu8D+eXIMyi8W1YPX3ccPxdQVkxDx7oDxzBMgIvxv0H7HOjM+JoEgogAAhfDlK
         kSIiwwcPhADBIHroI0MhNMPYwY/ok942+QqgcMU78LPxWSkk1qtCti9BL0JaA4AD7ESh
         MYlCM3MqlA7NidOuamgetoEww/S+ewJl6ythPOQEB+aEjNW1LW7lQRhAHQEdUL7ux982
         /m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780645195; x=1781249995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxLY9EqpF77hSPOoFBzsiCl9/0u0FyX67Jy/NSMRVXo=;
        b=UlyyliP6sLRE+huO4xMl6mphykrl820oeloyfhBFLUQhWbkbHld5SCukGc6mbRa7E3
         C21ACGVdTzzPlWV5BN80BygqZEjnsm1BJ5O8jRUUDmrTI2XUE4YOYPJisAQyUFzkpdYE
         IkVpkHUwG6gQlh5/SussLxyOV0hNQNWGTfCIstkOM46/lruwSw0CffUo+kLsWZ0ZwFlA
         p1kDZ5KGZ8h7coU+JK3TjUJ8gcZ7wfmGT1ldfCOWd59O468Tk9qrJ0a9DqzWLviXr2pM
         ZexmiWBJ9cMXfwGw6jdnxDmHiMjoNodKTB+iudlMSy5hRaZk6XqJu+DEtjl7I+mfKNTl
         kWmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8cdk89k0HZNJMmBTnH7x6xVNM0xeWoX2S7hRwVWDZC1+lPwxgB4F7WpB2G1sLZ9z7peDpTpl9O678=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhBiA0KZpUy5zTrLdT9XddAVyAFCMeGVI19YWTNsBJM7CAj4Fc
	e3kqIx2u3M2M3Tn54U7U2BDzg2tc5ylAlQjQBDXRAOrdXkOj3hD1sZXca1PjhUnMavijltnzDGJ
	imGsSccu184Cyz30wPcYj60Lrn73ZoBW+t4VYergCApNLM5H4ZfwImzeN1DKJpw==
X-Gm-Gg: Acq92OFzJVXa5LxBF7Xv89h4DmBCb8ct5DHkl86BuPuOtB6TYKCnfrgmv353i5vgn5T
	nCpNPiwXjLqz8MrNqOV1iRCrlRCAo/0Zm4vKgAW/UddhRdZQ3nng2RzjN7jzw93hXyVaZYquXxe
	vpJLbRDDvdwW0N2ipvByxD4nOOLcUtjMUrCusOHaezhnSgurRFifbWXDvKdyk28b5EKxgdLYIQ1
	a+jeqlV3T2aeeHv/40FsQ5BUgmTki4zmjnZ0ZHsYlrxkzLkBzd1hDUro4q7o5CTRX7pB2CthCjN
	j3Y9sgqp/wuE1stpVOCW5hpsyVLE80xksaAtN5DUwRIT/Vf9iHnhLSfJmKDGKRWwPjO2udgUxJe
	HEZxt7Jxdr5YmU36OriFByUBVPSCzgHefqEuxvRh1/Si9qiev
X-Received: by 2002:a05:6000:2083:b0:460:1378:7b0 with SMTP id ffacd0b85a97d-46032b6124bmr1884756f8f.5.1780645194734;
        Fri, 05 Jun 2026 00:39:54 -0700 (PDT)
X-Received: by 2002:a05:6000:2083:b0:460:1378:7b0 with SMTP id ffacd0b85a97d-46032b6124bmr1884713f8f.5.1780645194323;
        Fri, 05 Jun 2026 00:39:54 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm38799287f8f.27.2026.06.05.00.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 00:39:53 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: vkoul@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank.Li@kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v1] include: Remove unused dma-iop32x.h
Date: Fri,  5 Jun 2026 10:39:46 +0300
Message-ID: <20260605073952.840988-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11181-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:linux-kernel@vger.kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[costa.shul@redhat.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[costa.shul@redhat.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9683264627E

The IOP32X platform was removed in commit b91a69d162aa
("ARM: iop32x: remove the platform") and its DMA driver in
commit cd0ab43ec91a ("dmaengine: remove iop-adma driver").
No file includes this header.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
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
2.53.0


