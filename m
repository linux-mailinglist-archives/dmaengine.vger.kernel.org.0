Return-Path: <dmaengine+bounces-10311-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +eAVLVgrAmq/ogEAu9opvQ
	(envelope-from <dmaengine+bounces-10311-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4424B514F4F
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF0663047435
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265114D8D8A;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9MGn62E"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB304D2EF1;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526998; cv=none; b=uwbnmdiNKMoZXx3Yg2CHoIGpZ1VgXY0eMJLSYh8NAf3gfLNBEEvwmUZ8CRDyGve67ndyYBuLmbFPFuwbpyj4aymwbO9t5+CjiEGdr0fesyUqsvdmCtOOls/VzqbRk8HhjwOPSU5hKVs3FCGGeesQxuUyeeCaF6fn6yESAPCKREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526998; c=relaxed/simple;
	bh=XZT21x7UgdGHHXRsKzDYwODjJBvme12XqCGxlgh3+fI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oWHn4zwk0/jBeQSPsztAeCVYOdUYPoz7zOn5RGGM884snAIo87MaUloEIuxW/QSI67tYbn6+1cTGsS6Ve24gOOvuCWp4wRmQbrYf0es/n2/nlK8CC5fYoiSHlAIpRhXbSdUrzqhZBOtz5ijBscaVTkFi5nNJeoMe4Kjj49fvM1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9MGn62E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAC32C2BCFA;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526997;
	bh=XZT21x7UgdGHHXRsKzDYwODjJBvme12XqCGxlgh3+fI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=U9MGn62EOmsF/L4X7vqzJbhnaMRKGwwEzuHi6BON7fgF2YgEzuBRHaD1GVIIKxZi1
	 YGIRUWBMUDWguDq1xRKs5imSI326F88Ip3Qz+J+E/l7ObZy4WZrYW35WRrvKmoe/+u
	 B+a7Jdp5c9i2tIADFXPndALIwZT7ie2SIPi460yFPDH8K7mdP1+MN1hGGDPWqro2zj
	 Hu6AMRFE4Vjo0dd6giNWfWTEne819HMMz2Vm4VAuQDBqlrZOG1cxVXaoAi5qximkdf
	 g+0Iz67RCIqUkKA1gKw7bwlHOS5u1WriQlRwhrJQ2gOxhcaH1zVQogIe81/nyyOHDs
	 cBOCWlWoqENjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37B8CD4851;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Mon, 11 May 2026 14:16:22 -0500
Subject: [PATCH v2 10/23] dmaengine: sdxi: Complete administrative context
 jump start
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-sdxi-base-v2-10-889cfed17e3f@amd.com>
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
 Jonathan Cameron <jic23@kernel.org>, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778526994; l=2061;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=qZNHCbrTwVMWVauKeGKxVay61YI1RSEUJLtl5aJfQj8=;
 b=7TVXYXsPfHvgr1ReZZ0PJAF7bkOEu4IJ/XJL0fLrlKosSSb1Sh3cZuQOwKN7Gzbx+6Ji1xcpl
 7LNGttcAAm2B+bdM/45+xEMBsHosj48kzrz7K2YU7wsbax1KvLYuNx/
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Queue-Id: 4424B514F4F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10311-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:replyto]
X-Rspamd-Action: no action

From: Nathan Lynch <nathan.lynch@amd.com>

Now that the SDXI function has been placed in active state, the admin
context can finally be started by writing its doorbell. Introduce
a sdxi_cxt_push_doorbell() helper to simplify this for callers; it
will be used in all descriptor submission paths.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/context.h |  6 ++++++
 drivers/dma/sdxi/device.c  | 15 ++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index 65b773446ba3..8dd6beb7a642 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -7,6 +7,7 @@
 #define DMA_SDXI_CONTEXT_H
 
 #include <linux/dma-mapping.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/types.h>
 
 #include "hw.h"
@@ -58,4 +59,9 @@ struct sdxi_cxt {
 
 int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
 
+static inline void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 index)
+{
+	iowrite64(index, cxt->db);
+}
+
 #endif /* DMA_SDXI_CONTEXT_H */
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 204841afa5b7..8e621875b10b 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -262,7 +262,20 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	 * SDXI 1.0 4.1.8.9: Set MMIO_CTL0.fn_gsr to GSRV_ACTIVE and
 	 * wait for MMIO_STS0.fn_gsv to reach GSV_ACTIVE or GSV_ERROR.
 	 */
-	return sdxi_dev_start(sdxi);
+	err = sdxi_dev_start(sdxi);
+	if (err)
+		return err;
+
+	/*
+	 * SDXI 1.0 4.1.8.10.b: Start the admin context using method
+	 * #3 ("Jump Start 1") from 4.3.4 Starting A Context and
+	 * Context Signaling. We haven't queued any descriptors to the
+	 * admin context at this point, so the appropriate value for
+	 * the doorbell is 0.
+	 */
+	sdxi_cxt_push_doorbell(sdxi->admin_cxt, 0);
+
+	return 0;
 }
 
 static int sdxi_device_init(struct sdxi_dev *sdxi)

-- 
2.54.0



