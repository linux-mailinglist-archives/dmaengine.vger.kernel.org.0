Return-Path: <dmaengine+bounces-11238-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZRAGHZNkI2qdsQEAu9opvQ
	(envelope-from <dmaengine+bounces-11238-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:06:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC5564BF0A
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:06:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=mTrCklDb;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11238-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11238-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B8F630470EB
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3002750ED;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93C25B663;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704143; cv=none; b=Wig7CMJt3shsse8yyU1KBaib9IpoeKiE+ENL19zBRj4OfBKrpMRaRgsLxc2pYMdkMewrZrYfacZSX4H6DviDhMkKhZX6M5ALusLX5yl48nFq/K9VkSlePxmuTwdLpMjqorZZ3Jt9g9Jtyv93L9J5V0HWoOMCdIrjB6beDV3Keb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704143; c=relaxed/simple;
	bh=TjBCq5GLV8eCRt3FN/z/334I1d54C9qgPI+LkaioXY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gHY5aenGjtZXZ292puJTziS3QHydnNkFXYBAV/iH0R4u5WwZ9A5GpRkEYN2aiTAmqRh/8GRs0pjXhtEgoVBEU2CoOUNxB0aPzkI4v0N9tuH4hmY1QNNRiyEnbaLaXhm/sBT1Ou/BMGZXdz5jbzaVY2dSVM6zU3CPEk+stkEJebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTrCklDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F8D3C2BCF4;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704143;
	bh=TjBCq5GLV8eCRt3FN/z/334I1d54C9qgPI+LkaioXY4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mTrCklDbYb92Z585VHJRUrGMbb4oyg1EGe1yEYVY18nSGlhi5Ztcjg8naBGrsNPJo
	 jHw6fmeDj5IW90bCSl66cZNGel+JMv6NbwYGNWOR2p2QdTSD7+WW7RJ478xI8XX/le
	 x2+WfZ6WWlm4ay2/x0XLjYsakiimqt6LDRamlIsPRdrNbysgcpydDRGJvOXmktpgGv
	 Uh3I219NzLKwcDRPiDayKzOSJpZWD9Ps7qe9sg7dELJnT7Onk0tj204hl9ZzE/WcoN
	 q9T18/cGvsJYAe3UC4p+Zplukd5WLPRcDKN2KkJeSxIq7Ni+9LvOehzUhPrfl+h6YI
	 exGzIsJXirvPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56596CD8C89;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:19 -0500
Subject: [PATCH v3 16/23] dmaengine: sdxi: Generic descriptor manipulation
 helpers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-16-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
In-Reply-To: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=4032;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=PSNXHSdeArEDKZ9yKGee2hJgxz3zpaB64VSQbAyMa80=;
 b=A7K3jW3eyiHO6Xb1je4yWHjHKaAcz6xIsfjtCbJ5ngPhbib8zuYvlg9ceSe6fDp2qjbPaJkNX
 27LrEax5WUJAijzEqmtYpSzoMp/Js7m142WrqfJlG7vz9dicHpLYDaF
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11238-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:bhelgaas@google.com,m:rientjes@google.com,m:John.Kariuki@amd.com,m:jic23@kernel.org,m:kinseyho@google.com,m:mario.limonciello@amd.com,m:PradeepVineshReddy.Kodamati@amd.com,m:shivankg@amd.com,m:Stephen.Bates@amd.com,m:tycho@kernel.org,m:wei.huang2@amd.com,m:weixugc@google.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:Frank.Li@nxp.com,m:nathan.lynch@amd.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,vger.kernel.org:from_smtp,amd.com:mid,amd.com:email,amd.com:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFC5564BF0A

From: Nathan Lynch <nathan.lynch@amd.com>

Introduce small helper functions for manipulating certain common
properties of descriptors after their operation-specific encoding has
been performed but before they are submitted.

sdxi_desc_set_csb() associates an optional completion status block
with a descriptor.

sdxi_desc_set_fence() forces retirement of any prior descriptors in
the ring before the target descriptor is executed. This is useful for
interrupt descriptors that signal the completion of an operation.

sdxi_desc_set_sequential() ensures that all writes from prior
descriptor operations in the same context are made globally visible
prior to making writes from the target descriptor globally visible.

sdxi_desc_make_valid() sets the descriptor validity bit, transferring
ownership of the descriptor from software to the SDXI
implementation. (The implementation is allowed to execute the
descriptor at this point, but the caller is still obligated to push
the doorbell to ensure execution occurs.)

Each of the preceding functions will warn if invoked on a descriptor
that has already been released to the SDXI implementation (i.e. had
its validity bit set).

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/descriptor.h | 64 +++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/hw.h         |  9 ++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
new file mode 100644
index 000000000000..c0f01b1be726
--- /dev/null
+++ b/drivers/dma/sdxi/descriptor.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef DMA_SDXI_DESCRIPTOR_H
+#define DMA_SDXI_DESCRIPTOR_H
+
+/*
+ * Facilities for encoding SDXI descriptors.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/ratelimit.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+#include "hw.h"
+
+static inline void sdxi_desc_vl_expect(const struct sdxi_desc *desc, bool expected)
+{
+	u8 vl = FIELD_GET(SDXI_DSC_VL, le32_to_cpu(desc->opcode));
+
+	WARN_RATELIMIT(vl != expected, "expected vl=%u but got %u\n", expected, vl);
+}
+
+static inline void sdxi_desc_set_csb(struct sdxi_desc *desc, dma_addr_t addr)
+{
+	sdxi_desc_vl_expect(desc, 0);
+	desc->csb_ptr = cpu_to_le64(FIELD_PREP(SDXI_DSC_CSB_PTR, addr >> 5));
+}
+
+static inline void sdxi_desc_make_valid(struct sdxi_desc *desc)
+{
+	u32 opcode = le32_to_cpu(desc->opcode);
+
+	sdxi_desc_vl_expect(desc, 0);
+	FIELD_MODIFY(SDXI_DSC_VL, &opcode, 1);
+	/*
+	 * Once vl is set, no more modifications to the descriptor
+	 * payload are allowed. Ensure the vl update is ordered after
+	 * all other initialization of the descriptor.
+	 */
+	dma_wmb();
+	WRITE_ONCE(desc->opcode, cpu_to_le32(opcode));
+}
+
+static inline void sdxi_desc_set_fence(struct sdxi_desc *desc)
+{
+	u32 opcode = le32_to_cpu(desc->opcode);
+
+	sdxi_desc_vl_expect(desc, 0);
+	FIELD_MODIFY(SDXI_DSC_FE, &opcode, 1);
+	desc->opcode = cpu_to_le32(opcode);
+}
+
+static inline void sdxi_desc_set_sequential(struct sdxi_desc *desc)
+{
+	u32 opcode = le32_to_cpu(desc->opcode);
+
+	sdxi_desc_vl_expect(desc, 0);
+	FIELD_MODIFY(SDXI_DSC_SE, &opcode, 1);
+	desc->opcode = cpu_to_le32(opcode);
+}
+
+#endif /* DMA_SDXI_DESCRIPTOR_H */
diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
index 4b65337a5975..29aa6c7e6c23 100644
--- a/drivers/dma/sdxi/hw.h
+++ b/drivers/dma/sdxi/hw.h
@@ -140,6 +140,15 @@ struct sdxi_desc {
 			__u8 operation[52];
 			__le64 csb_ptr;
 		);
+
+/* For opcode field */
+#define SDXI_DSC_VL  BIT(0)
+#define SDXI_DSC_SE  BIT(1)
+#define SDXI_DSC_FE  BIT(2)
+
+/* For csb_ptr field */
+#define SDXI_DSC_CSB_PTR GENMASK_ULL(63, 5)
+
 	};
 } __packed __aligned(64);
 static_assert(sizeof(struct sdxi_desc) == 64);

-- 
2.54.0



