Return-Path: <dmaengine+bounces-8441-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHyHHwwncWmqewAAu9opvQ
	(envelope-from <dmaengine+bounces-8441-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 20:20:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D4C5C074
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 20:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E2939D0158
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF963DA7E5;
	Wed, 21 Jan 2026 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wz/x7wak"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496E13C1FC1;
	Wed, 21 Jan 2026 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020500; cv=none; b=ijKsEQunXsmo3t11Ml77BKjaQRVH8NabnpHtU7kF/TXcJTCnCBwjSuyaC9IuayXhh7LZQS9IS/AKK1iYBNQ8FmMBoqK0KM5c3Lva0sL5Pe/qq28sqdhnGLxBK52fC7L2iiR7cO3SqgpJX2D9xo/W8ipn6Xfu4UeSJivGLBhVr4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020500; c=relaxed/simple;
	bh=TD0ye6q43JjiW1lwMlhZYqmGxxTrmbilxB5xlOIjE3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JODzd4KQxr9WUTm/UStyjFXZTf0EhqGRk06mU92xD9Ew/EmQoQP9HR4b5QOwMRX8ycAR9PSSKbvKvzfJcwh5vx2PfAIcc3PifvnLutC9XEnv4eu9sflQmxAM/dP4ZDWdaSKrMkozgyP11kGEI/5DC7l9HVCFXuXVXD0NE6EHJ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wz/x7wak; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769020498; x=1800556498;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TD0ye6q43JjiW1lwMlhZYqmGxxTrmbilxB5xlOIjE3Y=;
  b=Wz/x7wakABc2KaAD714WhT8nHj73YR5QKwsdRFcq3CCJPw/fG3CruyQz
   ATxJ+dX2aWYdfctormcqeJmV1WsZTepv1TEP2nTorzX7KM0CkMKTDXjJn
   Sf1lf9sAUspPyRjRT1Z9n2uoVv6FUJUYHtZhnZC7ByRikL/0uUL2nLbqa
   Oe+i/5Vyd1Oyobtf8mKLZ+mgYpixzcBgQQDBvgZgVvsQBwpC5DE0D9C11
   Jom3F0Xq+8l8mG027GgoKlBH94xsXVafx3ksV4nNUv6yo2RDZ3H15vBW1
   By04e3cvubqnlFfMvjKyxtFDaM9d4bTASpA2ik/UB5z5EPRUwF/mXNEFf
   A==;
X-CSE-ConnectionGUID: w6Y/1Nd5S8WiDcUMPpgTpg==
X-CSE-MsgGUID: s42oRmHDQhue25fV0Ax4zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70349898"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="70349898"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:34:56 -0800
X-CSE-ConnectionGUID: T+AfmtA1RSy9eThTRyt67Q==
X-CSE-MsgGUID: 8owLhS8HTWGBdnnv8oVASg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="210678461"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:34:54 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 21 Jan 2026 10:34:29 -0800
Subject: [PATCH v3 03/10] dmaengine: idxd: Fix possible invalid memory
 access after FLR
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-3-7ed70658a9d1@intel.com>
References: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-0-7ed70658a9d1@intel.com>
In-Reply-To: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-0-7ed70658a9d1@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769020494; l=957;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=TD0ye6q43JjiW1lwMlhZYqmGxxTrmbilxB5xlOIjE3Y=;
 b=GzOyff6yvKnVy6gi9wmrZCSNO8hHXNFzPGFFfCGiQ7uqNHyVA9HuS4zlisukyM7mu3eZAD6HG
 hU41/iYQ2zsAf9vzNacoCMWRNl6/TPp4nRcCnx+rqkKzpElZ34ZAjfQ
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8441-lists,dmaengine=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: E2D4C5C074
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the case that the first Function Level Reset (FLR) concludes
correctly, but in the second FLR the scratch area for the saved
configuration cannot be allocated, it's possible for a invalid memory
access to happen.

Always set the deallocated scratch area to NULL after FLR completes.

Fixes: 98d187a98903 ("dmaengine: idxd: Enable Function Level Reset (FLR) for halt")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 1c3f9bc7364b..f1cfc7790d95 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1146,6 +1146,7 @@ static void idxd_reset_done(struct pci_dev *pdev)
 	}
 out:
 	kfree(idxd->idxd_saved);
+	idxd->idxd_saved = NULL;
 }
 
 static const struct pci_error_handlers idxd_error_handler = {

-- 
2.52.0


