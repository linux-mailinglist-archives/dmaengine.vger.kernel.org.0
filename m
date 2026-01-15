Return-Path: <dmaengine+bounces-8294-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E46D29196
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 23:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 784DD303E288
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 22:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412CB33120D;
	Thu, 15 Jan 2026 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBVado7d"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D63131AABA;
	Thu, 15 Jan 2026 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517271; cv=none; b=c13wFTYe8/ZW9VAvY5Ph57th2c5Ekn1gxVuqDRqi8leB9W93D25gX7ldn0O77vP+oM7uLIQLhiwhywjZoMCysRWz3rb8u2WmnBtaHN8BKNF79dsKoesvJrDsGv6gmRb077SpTShL1UYLkXWMMXR9SNZOrXS2d81CHYWk15LIkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517271; c=relaxed/simple;
	bh=TD0ye6q43JjiW1lwMlhZYqmGxxTrmbilxB5xlOIjE3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U04zY1iPLCPAxJJ9lXY5U2z/QsJBuqZqA96xX0RCZXC5L5vN/k3iYVbpUlC2ztrffXb3Zfm+fGMN65kVlrSCSRCsGHG4gDdRfLf8sjOPZ4NJGgxYu4ttLUnziMiyq4p0mnj9TAWAfwc0jrQuVVnOrUOhKcG7KM/0r7u4AycVT38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBVado7d; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768517269; x=1800053269;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TD0ye6q43JjiW1lwMlhZYqmGxxTrmbilxB5xlOIjE3Y=;
  b=CBVado7daAyCtqGv39DqHlzaz0pFUJTgd0uF+WFaUUdXThmvW4FJjWVz
   IUrhrImM/SmgL2QeMH5krsjddx2hckGJMb7f7G10VdAtJaI4NpA0pMFKJ
   FTVNGOFhtWtMZQXuKaBafaCzJacqMWip4GCRD802+3+o5LXsNLDALelH5
   KZt1hRYkVklt/0IogPGDxolCROPy8MSBxdDJcqrYaND1PJ61cKlZRQBNr
   eSQQa4D/OHZjKUGTXySq0ZN4ZGv7HDW9OFcaEWPCUnbkHVrNsrIa+WZip
   eu6sE077A6+wDTt25GH+B2ft+9xVxOIFrxF1vKqmwHRT2Y7CsSpSzUWy1
   Q==;
X-CSE-ConnectionGUID: mJXAOM0LS7SuDfTRdsF4Qw==
X-CSE-MsgGUID: /QU6yn8wRr6eS0/YH97mDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69744629"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69744629"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:47 -0800
X-CSE-ConnectionGUID: npJec2NxTHeKVKsAT9SiVw==
X-CSE-MsgGUID: KD6LvXUqT6KJI03lXgEHwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="204965435"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:47 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 15 Jan 2026 14:47:21 -0800
Subject: [PATCH RESEND v2 03/10] dmaengine: idxd: Fix possible invalid
 memory access after FLR
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-3-59e106115a3e@intel.com>
References: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
In-Reply-To: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768517265; l=957;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=TD0ye6q43JjiW1lwMlhZYqmGxxTrmbilxB5xlOIjE3Y=;
 b=st85q7OgJS7nKHr2pOlkPC8nKFIHN2KXb93KfsHeFVrs8k4NuhTefp1mvpTuwiA3crwfwo83x
 ZsD3XJAIiQTA0shRMEm0lwyZIB07DPpGplusft0xnZoPZ/cT7I7f3DG
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

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


