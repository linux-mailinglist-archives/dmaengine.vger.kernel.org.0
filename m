Return-Path: <dmaengine+bounces-8578-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CnvCj49e2mNCgIAu9opvQ
	(envelope-from <dmaengine+bounces-8578-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 11:58:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA2DAF461
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 11:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA592308F062
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 10:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE5C385531;
	Thu, 29 Jan 2026 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kP5IHyrq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC26385521;
	Thu, 29 Jan 2026 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683762; cv=none; b=gWRns+qKRvSCRL1s0RhTHQQWvS+9g4y68fXAIzmHn9M2I5ZWZq4mZTP7ciS41uymtZ6aWZcMEbsy4Z/MkQeb9CwYYJgHD30yQBMD1D0rmIrqfNUxEp2XfGmLL6XzD5y6X3UmQI2c92n4nAlKaRcnL97RHL2O5lJ/RBZZwKJFwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683762; c=relaxed/simple;
	bh=W2G8UDK9YifFzf5jX1CIMXKYpNTnFwslmgeokA509Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzz09U88ZOdD/+LsIo+l5hDsTQW3qnRni3kL0uJdTPDIUv+PGQMV2PXD7tX/w6xSCUazihSnJaddAud0Jwm//euIBSKQXmb7cw37B/tHnBOulcobQUwZ6kpYC0tFI0IT67td/b3kyiBIVNOUCkD1mkUKLlgsD4uz8dr6Tyio7CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kP5IHyrq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769683761; x=1801219761;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W2G8UDK9YifFzf5jX1CIMXKYpNTnFwslmgeokA509Fg=;
  b=kP5IHyrqpxWNATWA8HmBVdRz4zyb6AcD+UkIVIftj/zf/iF3dcMqhRPQ
   /IOlV39R8tZqviFQyqKRiBOmir18RX1h6XUj4yCgy1+K0QB7qkWVNllRK
   +v+T0SYt7STVkV8dQwXCa3qD5kbn6zoS4vmHVJP+D5FOM+qCKVSnfL+Zy
   VSeuiQUBIfA66OUeQQA1SntyS+Y1KI4TwjNe+Y22pUEhj7huCUAmsx43j
   M/4lgM0a4FLBxMUWozat+NQJv3OaSzN3V8lhN+qZxzfP0rrLStcR9iodb
   G0xQ/DykAXPklHeutw07D/9Ceq+y+YGWhDG9+Crh7QQ7BRbhRZC9jn2fW
   g==;
X-CSE-ConnectionGUID: vf5FTiRhQbi3xSTfJBp6sA==
X-CSE-MsgGUID: eEsL/dwbTIKvrtQ9xeFfHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="58499940"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="58499940"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 02:49:20 -0800
X-CSE-ConnectionGUID: fG8JNJEaSMyeTqel81mF9g==
X-CSE-MsgGUID: hS/aUBjbQ1WY4xqrWg2jAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="239278090"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 29 Jan 2026 02:49:19 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id BD1A798; Thu, 29 Jan 2026 11:49:17 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 1/1] dmaengine: idma64: switch to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Thu, 29 Jan 2026 11:49:16 +0100
Message-ID: <20260129104916.200484-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8578-lists,dmaengine=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 9FA2DAF461
X-Rspamd-Action: no action

SET_*_PM_OPS() are deprecated, replace it with DEFINE_SIMPLE_DEV_PM_OPS()
and use pm_sleep_ptr() for setting the driver's PM routines. We can now
remove the __maybe_unused qualifier in the suspend and resume functions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/idma64.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index d147353d47ab..d1197d68df94 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -671,7 +671,7 @@ static void idma64_platform_remove(struct platform_device *pdev)
 	idma64_remove(chip);
 }
 
-static int __maybe_unused idma64_pm_suspend(struct device *dev)
+static int idma64_pm_suspend(struct device *dev)
 {
 	struct idma64_chip *chip = dev_get_drvdata(dev);
 
@@ -679,7 +679,7 @@ static int __maybe_unused idma64_pm_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused idma64_pm_resume(struct device *dev)
+static int idma64_pm_resume(struct device *dev)
 {
 	struct idma64_chip *chip = dev_get_drvdata(dev);
 
@@ -687,16 +687,14 @@ static int __maybe_unused idma64_pm_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops idma64_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(idma64_pm_suspend, idma64_pm_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(idma64_pm_suspend, idma64_pm_resume);
 
 static struct platform_driver idma64_platform_driver = {
 	.probe		= idma64_platform_probe,
 	.remove		= idma64_platform_remove,
 	.driver = {
 		.name	= LPSS_IDMA64_DRIVER_NAME,
-		.pm	= &idma64_dev_pm_ops,
+		.pm	= pm_sleep_ptr(&idma64_dev_pm_ops),
 	},
 };
 
-- 
2.50.1


