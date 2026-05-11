Return-Path: <dmaengine+bounces-10316-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB6OL48rAmp0ogEAu9opvQ
	(envelope-from <dmaengine+bounces-10316-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:18:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A870514FE9
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A08F305A8AA
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982F44D90AA;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2+29k2y"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E34D8DAE;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526998; cv=none; b=hxKaz1zYDsTLaaVal1/KzoP6kh9QsoSUNGDOQI/Fu/EWlXmbFNOciG10w29ayJ9u0T3AUdaDHdhfZfSHzS6hDhjO+eeNkdXQFy8zs3JDlyoqQsFo/frQHUp65lBcyQDcT5MOi9MRJqxuGLIagzadZRsTAsTN65gZGXOKmvT/k8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526998; c=relaxed/simple;
	bh=f8ZP4NoQDgLiqWZCpA/POoF2UqoIoEE9M1xIWepDbl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BXGMMr2EOP3aND61hHFeVsbVsIflDh2liX7dwnid8H/qFZpd3MYTmBoV+Xk0D/lvUMRS8+fW8DQneqtuO2QjpAmGLPs5rt9pdXoX2nPo0zXqA0VUZOUmkcm3cjZs+alzssQ9wPKEJ8Qkx65h3VwH2Cg4GD6ycy994Ohe62xkDYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2+29k2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31C05C2BD00;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526998;
	bh=f8ZP4NoQDgLiqWZCpA/POoF2UqoIoEE9M1xIWepDbl8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z2+29k2yXGUiBzeKgxqTfmAOFa7kImKJ3b3XuJg1gN+rjNKelbVBWgVCa8n12wB1Q
	 0fqO6n6PUzMQkMMyGwdpXFNdWmWlKt7CYeINAgTJFlilnfa/FJdN/LliCuwYMahYeS
	 Tjsw0afLPIP4HUUTUarfDF2GajVuNNY9/KKAz5T918n4IM/hRn2rEWgFau3Qocam1d
	 xWQUrUeRTu6XNYcjbKbfAkfHXYvN8gKcP8dpOmWuXnSYd2aKtW78AXJgJpXYWogAC1
	 eN3RfA2n7UwAJoQInLt7+fw2uknrmeoUNBbrypLUfZHZKdM0cbb1FTBtTNeAotaewq
	 xVKTT3xsQG1Mw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A9ECD4851;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Mon, 11 May 2026 14:16:27 -0500
Subject: [PATCH v2 15/23] dmaengine: sdxi: Per-context access key (AKey)
 table entry allocator
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-sdxi-base-v2-15-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
In-Reply-To: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Wei Huang <wei.huang2@amd.com>, 
 Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778526994; l=4028;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=ywbLFP7hWI8FtbxVwSucYJFidpzLrlODHvRMRLWe5kg=;
 b=FPKrS9xlYOsYd0wF/4HzQAS1sa6RrLpLOZRFIsv8dkGgug2lKEYPsNbQWQhSc3HjX7fGqFyLy
 en6V6rMzlZyDWWw9bQO+8T8yK7E6y4YN8nltEml6/usA01tj/h2pW99
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Queue-Id: 3A870514FE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10316-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:replyto]
X-Rspamd-Action: no action

From: Nathan Lynch <nathan.lynch@amd.com>

Each SDXI context has a table of access keys (AKeys). SDXI descriptors
submitted to a context may refer to an AKey associated with that
context by its index in the table. AKeys describe properties of the
access that the descriptor is to perform, such as PASID or a target
SDXI function, or an interrupt to trigger.

Use a per-context IDA to keep track of used entries in the table.
Provide sdxi_alloc_akey(), which claims an AKey table entry for the
caller to program directly; sdxi_akey_index(), which returns the
entry's index for programming into descriptors the caller intends to
submit; and sdxi_free_akey(), which clears the entry and makes it
available again.

The DMA engine provider is currently the only user and allocates a
single entry that encodes the access properties for copy operations
and a completion interrupt. More complex use patterns are possible
when user space gains access to SDXI contexts (not in this series).

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/context.c |  4 ++++
 drivers/dma/sdxi/context.h | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index a9c68227cc32..56e21aa08857 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/errno.h>
+#include <linux/idr.h>
 #include <linux/iommu.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -64,6 +65,7 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
 		dma_free_coherent(sdxi->dev, sq->ring_size,
 				  sq->desc_ring, sq->ring_dma);
 	kfree(cxt->sq);
+	ida_destroy(&cxt->akey_ida);
 	kfree(cxt->ring_state);
 	kfree(cxt);
 }
@@ -322,6 +324,7 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 	cxt->db = sdxi->dbs + cxt->id * sdxi->db_stride;
 	sdxi_ring_state_init(cxt->ring_state, &sq->cxt_sts->read_index,
 			     sq->write_index, sq->ring_entries, sq->desc_ring);
+	ida_init(&cxt->akey_ida);
 
 	err = sdxi_publish_cxt(cxt);
 	if (err)
@@ -409,6 +412,7 @@ struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
 	sq = cxt->sq;
 	sdxi_ring_state_init(cxt->ring_state, &sq->cxt_sts->read_index,
 			     sq->write_index, sq->ring_entries, sq->desc_ring);
+	ida_init(&cxt->akey_ida);
 
 	if (sdxi_publish_cxt(cxt))
 		return NULL;
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index 377e40c61401..329cafe94fe2 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -6,8 +6,11 @@
 #ifndef DMA_SDXI_CONTEXT_H
 #define DMA_SDXI_CONTEXT_H
 
+#include <linux/array_size.h>
 #include <linux/dma-mapping.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/idr.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
 #include "hw.h"
@@ -51,6 +54,7 @@ struct sdxi_cxt {
 	struct sdxi_cxt_ctl *cxt_ctl;
 	dma_addr_t cxt_ctl_dma;
 
+	struct ida akey_ida;
 	struct sdxi_akey_table *akey_table;
 	dma_addr_t akey_table_dma;
 
@@ -79,4 +83,24 @@ static inline void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 index)
 	iowrite64(index, cxt->db);
 }
 
+static inline struct sdxi_akey_ent *sdxi_alloc_akey(struct sdxi_cxt *cxt)
+{
+	unsigned int max = ARRAY_SIZE(cxt->akey_table->entry) - 1;
+	int idx = ida_alloc_max(&cxt->akey_ida, max, GFP_KERNEL);
+
+	return idx < 0 ? NULL : &cxt->akey_table->entry[idx];
+}
+
+static inline unsigned int sdxi_akey_index(const struct sdxi_cxt *cxt,
+					   const struct sdxi_akey_ent *akey)
+{
+	return akey - &cxt->akey_table->entry[0];
+}
+
+static inline void sdxi_free_akey(struct sdxi_cxt *cxt, struct sdxi_akey_ent *akey)
+{
+	memset(akey, 0, sizeof(*akey));
+	ida_free(&cxt->akey_ida, sdxi_akey_index(cxt, akey));
+}
+
 #endif /* DMA_SDXI_CONTEXT_H */

-- 
2.54.0



