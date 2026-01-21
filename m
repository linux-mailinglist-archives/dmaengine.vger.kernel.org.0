Return-Path: <dmaengine+bounces-8445-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPOGG/wvcWmcfAAAu9opvQ
	(envelope-from <dmaengine+bounces-8445-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 20:58:52 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 355F15CB35
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 20:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F18586BD54
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C553E9F73;
	Wed, 21 Jan 2026 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jS17zQP4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018A3DAC13;
	Wed, 21 Jan 2026 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020503; cv=none; b=JttOVpFV/WQYPrCNGJtEFKlHOE/qPbbMEyiHeM6bmFZp+KOc0/JQaSmeb3TTw/Ilz35mSs+RpxmDtRzBQOGSsd3YGy1oWuqgOHPGGHzRBvnjyoeNVBpxCN51d26ZP9I7+XuWK4V9d/6quKISoOaYvefEdaGw+UG0i4Xk8SVdh24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020503; c=relaxed/simple;
	bh=xB8N5q8I7kbV6Ztld4qJHNyrVrvAmYmEBJ5LDbjmrww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ROvQPczgbEhAJgEruHubMWAVbDdSu8I23NXfdZPYeSX+GS4JVa61z8yUb20oegz2PO7uUmQeb6fcBYCOlcBhpr/Gi+f+jhy5eXFKKIwpANIqI3vUyzIh5qxXQ338kZkMA6I/efzP3gt2pDobiNOQECCXI5hjjoAMQM2zbdNWqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jS17zQP4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769020501; x=1800556501;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xB8N5q8I7kbV6Ztld4qJHNyrVrvAmYmEBJ5LDbjmrww=;
  b=jS17zQP4m4GwzzuOPelkAXQoEqaNBvw+bGE8PKMgA9U5iOIP0d59HHch
   CGW4GHDW7pn0+ItGFg8OIaBkut40eMOTZcZyLqzhS7C+tNd3KQ+LQJlvt
   l+pGWRAvI9xFGpToAEuTXdeXtj9FQjLT7Xl8rJdCoMDXijE5J97PtjCaE
   ZYHBfGlMFWrgzGffSgtoHOwh+f0kSaEDlwkM9cRryHe58FSPijDxD4OCy
   A/JQRG36MKxwm7bzo8HrH+/YnEDbON4sEhJJUChmiSBLGg8ENAEBtKlLa
   NkqKt1IGFS0xo4rDbtfNFJxtB0cJQEIVhcZochE0mEkSCEBm0NkXtUmSl
   Q==;
X-CSE-ConnectionGUID: I+9ppen+TjWxJfBEaR8//A==
X-CSE-MsgGUID: 0AztEto4S9SwWiHBpgoJQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70349903"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="70349903"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:34:56 -0800
X-CSE-ConnectionGUID: ZwFd0iIdQvO6QBU6T/iG4Q==
X-CSE-MsgGUID: 0Fc/F5WaSbiF99utDK/wog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="210678470"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:34:54 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 21 Jan 2026 10:34:32 -0800
Subject: [PATCH v3 06/10] dmaengine: idxd: Wait for submitted operations on
 .device_synchronize()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-6-7ed70658a9d1@intel.com>
References: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-0-7ed70658a9d1@intel.com>
In-Reply-To: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-0-7ed70658a9d1@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769020494; l=1243;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=xB8N5q8I7kbV6Ztld4qJHNyrVrvAmYmEBJ5LDbjmrww=;
 b=9817eWM1ojIb1MBqzdUfPKQcCcmymfDf+Xl79WIG3tg354lYv2HRVxQMyBqT/jtvVz3AcqnC8
 rU6gAEuDfR2AhuGzuzyo0mMWEZy+eW4WVe0Nnfs1CPhet4Z4Va7sLu0
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8445-lists,dmaengine=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 355F15CB35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the dmaengine "core" asks the driver to synchronize, send a Drain
operation to the device workqueue, which will wait for the already
submitted operations to finish.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/dma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index e4f9788aa635..9937b671f637 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -203,6 +203,13 @@ static int idxd_dma_terminate_all(struct dma_chan *c)
 	return 0;
 }
 
+static void idxd_dma_synchronize(struct dma_chan *c)
+{
+	struct idxd_wq *wq = to_idxd_wq(c);
+
+	idxd_wq_drain(wq);
+}
+
 int idxd_register_dma_device(struct idxd_device *idxd)
 {
 	struct idxd_dma_dev *idxd_dma;
@@ -234,6 +241,7 @@ int idxd_register_dma_device(struct idxd_device *idxd)
 	dma->device_alloc_chan_resources = idxd_dma_alloc_chan_resources;
 	dma->device_free_chan_resources = idxd_dma_free_chan_resources;
 	dma->device_terminate_all = idxd_dma_terminate_all;
+	dma->device_synchronize = idxd_dma_synchronize;
 
 	rc = dma_async_device_register(dma);
 	if (rc < 0) {

-- 
2.52.0


