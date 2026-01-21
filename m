Return-Path: <dmaengine+bounces-8449-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBQMFO8tcWmcfAAAu9opvQ
	(envelope-from <dmaengine+bounces-8449-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 20:50:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BF45C8A0
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 20:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 758F9802D74
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 18:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1BB3ED119;
	Wed, 21 Jan 2026 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="io9CtvBG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E03ED10F;
	Wed, 21 Jan 2026 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020507; cv=none; b=YAsuWwgyv/Ccmsl4Fq9ZLmf8fmSjNviDCbpkeLT+2w9yo0zkMcB4MO1N7FIHgPUeCvf/f2K4Cvkx0uSTowpT+zdza9D6I3Dvn/TSH9gAy4xAwxV4fJOxHbWpEJTL2Rkx82GeGALyXpklQZ3iP8FaMcgW1RP4LI9GRGa/UQAam/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020507; c=relaxed/simple;
	bh=RxNM18srddSP28EYbn1kqrE9vIrJUCYN5TX9llVtj+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7OO7w56QxepyM3Q7sh2fo/xgp16St/WVwXCXgrCPwMLHZYp+DVXWcZIdoIAHIy440yEUMTYGv17aiwEYVOt9/iFSAaxxR5LUhX8onzjde+Qml19593KXXyCZ1bArUei5X/grHUjEyX96ZlhzeoF0asY7kdx3inw8/3XNc3cAX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=io9CtvBG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769020506; x=1800556506;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RxNM18srddSP28EYbn1kqrE9vIrJUCYN5TX9llVtj+g=;
  b=io9CtvBGQJIL8OiwE0g6KmiYVk/140/mti/K6HsKlF6Z6IgkMbAyqBMs
   QARC7H8FRFrb3UO+tNV10THSQt9EYhF3pOh9J9vEDanToAqTybH3txDTP
   1hFM0Z+FwUNP1PQhE6dkvW10PV9/epsGjIgjbo8fhQjLoKBWVOxodIlqC
   lcdlx6FuSOGXF1aIdwUJeF2BDXuM9xT5iFuB1uFPz5K2C16lu8YAKwfvj
   bM1R+9rfklJCw+0/yrhoSDW8CIMMuxZYlDfC4bQsWO9xPcjC5JW4jFGDl
   MCzxK7anDVeo7MZvCNqrGKu92MHr9HzAIdNR5y7mhwXnT7p6UdnAdiv/+
   g==;
X-CSE-ConnectionGUID: 9L9CTKtMT/qjSOe8XVH4bQ==
X-CSE-MsgGUID: +zgPfHhqT8W9JrxeXcEspA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70349912"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="70349912"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:34:56 -0800
X-CSE-ConnectionGUID: m2zDAQFSSFWWVLr7nSr2fg==
X-CSE-MsgGUID: sbYUW35tTjOj9BCSKvixEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="210678479"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:34:54 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 21 Jan 2026 10:34:35 -0800
Subject: [PATCH v3 09/10] dmaengine: idxd: Fix freeing the allocated ida
 too late
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-9-7ed70658a9d1@intel.com>
References: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-0-7ed70658a9d1@intel.com>
In-Reply-To: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-0-7ed70658a9d1@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769020494; l=1533;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=RxNM18srddSP28EYbn1kqrE9vIrJUCYN5TX9llVtj+g=;
 b=C3YbDT8SGcWhBZ2paEeX8ogJ3KK8AUWK/v895QEfCTMejlyDwTrUf0+0b0car7hUEZ/NF9sJj
 hkBTe4POj83BtARLcgDEt5lWNH6j4sIeyNNa5n+O918yrZBt+FjSale
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8449-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 33BF45C8A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It can happen that when the cdev .release() is called, the driver
already called ida_destroy(). Move ida_free() to the _del() path.

We see with DEBUG_KOBJECT_RELEASE enabled and forcing an early PCI
unbind.

Fixes: 04922b7445a1 ("dmaengine: idxd: fix cdev setup and free device lifetime issues")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/cdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 7e4715f92773..4105688cf3f0 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -158,11 +158,7 @@ static const struct device_type idxd_cdev_file_type = {
 static void idxd_cdev_dev_release(struct device *dev)
 {
 	struct idxd_cdev *idxd_cdev = dev_to_cdev(dev);
-	struct idxd_cdev_context *cdev_ctx;
-	struct idxd_wq *wq = idxd_cdev->wq;
 
-	cdev_ctx = &ictx[wq->idxd->data->type];
-	ida_free(&cdev_ctx->minor_ida, idxd_cdev->minor);
 	kfree(idxd_cdev);
 }
 
@@ -582,11 +578,15 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
 
 void idxd_wq_del_cdev(struct idxd_wq *wq)
 {
+	struct idxd_cdev_context *cdev_ctx;
 	struct idxd_cdev *idxd_cdev;
 
 	idxd_cdev = wq->idxd_cdev;
 	wq->idxd_cdev = NULL;
 	cdev_device_del(&idxd_cdev->cdev, cdev_dev(idxd_cdev));
+
+	cdev_ctx = &ictx[wq->idxd->data->type];
+	ida_free(&cdev_ctx->minor_ida, idxd_cdev->minor);
 	put_device(cdev_dev(idxd_cdev));
 }
 

-- 
2.52.0


