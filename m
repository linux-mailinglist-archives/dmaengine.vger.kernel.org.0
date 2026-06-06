Return-Path: <dmaengine+bounces-11231-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t9h5M01kI2pjsQEAu9opvQ
	(envelope-from <dmaengine+bounces-11231-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:05:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 396AB64BEBB
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:05:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=bICP3Kqw;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11231-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11231-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 283CA3034DE2
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4255322157B;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052B1A6834;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704143; cv=none; b=cCKIMOAo+dZ3HFoH/jvj6tEVvl5P5G/9XcyRaD9Xpr3HarX/8ecVNjlYI7MnfK7lTELzZwOVDZj5lbE+TbiFtNuFY0GMl9uKxoMBZMHJpyDn3HjsuqMlMAnbcLNzhXBk140+bAF0hanmD+UBGoFKNC6VcCysBF/u4YXtu3TYK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704143; c=relaxed/simple;
	bh=WVxHfEur6o3vH7LAeyswUujG5b0/scfR0gbsdP/aH7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jbafhpNk8dxv38atLFg5jAH+NipOieA89uRAqhApZDZbygu5EPYyqfAgpwMVo3qfCED5I8Yo6XC0KXh6e7sWjOb0ghSvem3QVSVv9vYrDK/Witdt9J9Ry3k1RVq7hmgQnAsOQ1bkqVkJW/Ci0Lg5EKK1nx44Y5HFyFSK9GFZDSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bICP3Kqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E22A9C2BCC6;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704142;
	bh=WVxHfEur6o3vH7LAeyswUujG5b0/scfR0gbsdP/aH7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bICP3KqwGb+Rcr9+VjQmoUUeAD+RWUNy+LQHEdfX1g711PdLkO43QMwCRgDF6xbCl
	 8NvOfr1b+FAngpUesshyVUxAvD7knLra8fAXD5Otb40IxXL20Ag2WuF8eIyHj2e/Gx
	 0KHeECaFq46x+cYauQWipXs1v4LcZXOtkN2rUF9Q86+0gATHUnz7Prq0PQCZsZaJZM
	 /PmJxZsJWuAQT3e5y63xc+hF+O7tFw632DlVkLpCf3QH2U0mdkUsh6Rcw5xz6y6bhU
	 TNQ+i98EW6kUh5I55+Z389OfQfGF0itEcNyPK12Nl1Wu5b741EtG6HEqZH5VGduCTN
	 9TEVODDYJewqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94A0CD8C87;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:13 -0500
Subject: [PATCH v3 10/23] dmaengine: sdxi: Complete administrative context
 jump start
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-10-4d38ca2bdffe@amd.com>
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
 linux-pci@vger.kernel.org, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=2039;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=Xz7O1bmLJ7W3hisyPklvsix3wrpdn8nowta4bg4ztKU=;
 b=bBfy3bckto5YkTDFV48vvpTAsuE3lLh6h4IVtlPaE2wYbyYBuxemg+UbGB3UxB2untV4Sgd1L
 fdFf5AdtBQ4DF7SVjqKz/EQTEII7Yo38JBMUDxDtd0235zYQVuVOQYb
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11231-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:bhelgaas@google.com,m:rientjes@google.com,m:John.Kariuki@amd.com,m:jic23@kernel.org,m:kinseyho@google.com,m:mario.limonciello@amd.com,m:PradeepVineshReddy.Kodamati@amd.com,m:shivankg@amd.com,m:Stephen.Bates@amd.com,m:tycho@kernel.org,m:wei.huang2@amd.com,m:weixugc@google.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nathan.lynch@amd.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:email,amd.com:replyto,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 396AB64BEBB

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
index 65b773446ba3..d89e026a7736 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -7,6 +7,7 @@
 #define DMA_SDXI_CONTEXT_H
 
 #include <linux/dma-mapping.h>
+#include <linux/io.h>
 #include <linux/types.h>
 
 #include "hw.h"
@@ -58,4 +59,9 @@ struct sdxi_cxt {
 
 int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
 
+static inline void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 index)
+{
+	writeq(index, cxt->db);
+}
+
 #endif /* DMA_SDXI_CONTEXT_H */
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index e8f087f758fd..b875d8cdb58a 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -269,7 +269,20 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
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



