Return-Path: <dmaengine+bounces-11236-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y7fwLntkI2qOsQEAu9opvQ
	(envelope-from <dmaengine+bounces-11236-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:06:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FF864BEFD
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:06:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=DCvjReyY;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11236-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11236-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22967303EF41
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88209261B9B;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F4323A564;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704143; cv=none; b=Uy7EvSLupLOnTU5SL5ZaCG3PHXpiFOPAvVT+c/DeRVA2MlOX31IDOz/robiU+1O+sRcLQL2nMHEOI6N8OrYkRYwXLAQvff0CEP8qjdRklUzGoqSSXaCacI/FC5JC7nDXZQaod+6exBwqx/dPrymM3nwgg+ucfPTufejYdjkDGDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704143; c=relaxed/simple;
	bh=ztZGiysJV/gPfTV1Ym4VhCsPMKgV5j+h5TarXurHmQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fhkM2WkI1DWf5B00OhVqca+BA/TlgyhoeBpLyHnePPE05tS7KsbTNFUWZ3wewrMuUM3VNqRHDyA3BY490hBRNr3wHrx3usexPBqmEtIJQKV/hcAlph9b1fN43PK9MqcvBLk+7J6dSPG5bIDVPngTDh9N6qJgBXn9q4FkdOMtuDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCvjReyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36B66C2BCC6;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704143;
	bh=ztZGiysJV/gPfTV1Ym4VhCsPMKgV5j+h5TarXurHmQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DCvjReyYaJpZTWPpHaDhyira77BdrJfFE7Ly5P0qlXJKS+1eaG5tAxwn8QGPlCT9W
	 hOD5ajDS7++gXj9BKUWKMQG6qc5ZcQNSNQVf3a2i0XcivwllHV7jjsXjwvvSiUOIHM
	 GrI8VR5IZnn1QzPaqvujol6h17rMsCUG2Fw3VOaZLjxyUKOUHQhGcyMvAA8YvHkdDv
	 LjUlA99mNG8Vz8EGg/LGu6ABwkEozW4Q82dMj6LHge84wb962ektOk/VptXqMFuAjU
	 F5i4NvzytVdDchcpFqR/U52sg8h4eYj69aaT9SiklraJWpeJoM/fxeKwyeiXm2fMOB
	 1qgQVYQjpMqkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC9BCD8C89;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:17 -0500
Subject: [PATCH v3 14/23] dmaengine: sdxi: Attach descriptor ring state to
 contexts
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-14-4d38ca2bdffe@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=2755;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=mVoy7jpXsiISK+5ennlQ+W8GV1ph1JWCYcEBJFYCu4k=;
 b=q6WmAOAvMFzetozaGdduNSq0LeWlJtfWi7PPGqLypSju4M00aSmm1VhwARCvDfjrKa7Jy4jg8
 aUPFS1HhBe0B+XE0m+sSF3jWavwdQibCDNrledoQbc0Mj0SMbc8MmCN
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
	TAGGED_FROM(0.00)[bounces-11236-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
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
X-Rspamd-Queue-Id: 48FF864BEFD

From: Nathan Lynch <nathan.lynch@amd.com>

Attach an instance of struct sdxi_ring_state to each context upon
allocation. Each ring state has the same lifetime has its context and
is freed upon context release.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/context.c | 14 ++++++++++++++
 drivers/dma/sdxi/context.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index 2f9a29df5d9c..907547ac450f 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -23,6 +23,7 @@
 
 #include "context.h"
 #include "hw.h"
+#include "ring.h"
 #include "sdxi.h"
 
 #define DEFAULT_DESC_RING_ENTRIES 1024
@@ -63,6 +64,7 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
 		dma_free_coherent(sdxi->dev, sq->ring_size,
 				  sq->desc_ring, sq->ring_dma);
 	kfree(cxt->sq);
+	kfree(cxt->ring_state);
 	kfree(cxt);
 }
 
@@ -80,6 +82,10 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
 
 	cxt->sdxi = sdxi;
 
+	cxt->ring_state = kzalloc_obj(*cxt->ring_state, GFP_KERNEL);
+	if (!cxt->ring_state)
+		return NULL;
+
 	cxt->sq = kzalloc_obj(*cxt->sq, GFP_KERNEL);
 	if (!cxt->sq)
 		return NULL;
@@ -314,6 +320,8 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 	sq->cxt_sts->state = FIELD_PREP(SDXI_CXT_STS_STATE, CXTV_RUN);
 	cxt->id = SDXI_ADMIN_CXT_ID;
 	cxt->db = sdxi->dbs + cxt->id * sdxi->db_stride;
+	sdxi_ring_state_init(cxt->ring_state, &sq->cxt_sts->read_index,
+			     sq->write_index, sq->ring_entries, sq->desc_ring);
 
 	err = sdxi_publish_cxt(cxt);
 	if (err)
@@ -380,6 +388,8 @@ static void sdxi_cxt_id_assign(struct sdxi_cxt *cxt, struct sdxi_cxt_id *cxt_id)
  */
 struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
 {
+	struct sdxi_sq *sq;
+
 	/*
 	 * Ensure an ID is available before allocating memory for the
 	 * context and its control structures.
@@ -396,6 +406,10 @@ struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
 
 	cxt->db = sdxi->dbs + cxt->id * sdxi->db_stride;
 
+	sq = cxt->sq;
+	sdxi_ring_state_init(cxt->ring_state, &sq->cxt_sts->read_index,
+			     sq->write_index, sq->ring_entries, sq->desc_ring);
+
 	if (sdxi_publish_cxt(cxt))
 		return NULL;
 
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index 42e377bb2446..0aebcba3dc1e 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -55,6 +55,8 @@ struct sdxi_cxt {
 	dma_addr_t akey_table_dma;
 
 	struct sdxi_sq *sq;
+
+	struct sdxi_ring_state *ring_state;
 };
 
 int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);

-- 
2.54.0



