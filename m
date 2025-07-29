Return-Path: <dmaengine+bounces-5884-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B8EB14FEB
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jul 2025 17:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DAF77A40FD
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jul 2025 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBCD1EF397;
	Tue, 29 Jul 2025 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWGR4HPV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533D1D63F2;
	Tue, 29 Jul 2025 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801438; cv=none; b=DKGRFlzsPAOZvGKTkz14mUmD9WXLWpniJ03i/u6LlfcY/EKOf5iO6F6ZPrekJrB0fWEzDDzSXoocgOJgUeM4RyiiK/yx0Z0rcKJVkKR+RsniwCco5u7lPbnrj37tAxyFkWT2qANp5hDygwm++1dUfuSV8jMefDUYx63M6O61FWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801438; c=relaxed/simple;
	bh=By4rNMkkWQ13R8Lapcpa6Ff0HaJjIHQmS9wNJ6zpWfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7mOn48qKHUedMm6zk9yXRzITrSNlUXm70nkkLCqP39ZGBNuiixnS1fX9L6CH1LfcFSWtE+lGCmO8i8LcGXUdQZGe3eHaO42Dse+2pXsGcmjyfdUpPtGQ4MEFpgp6i0b5W9ossb0T6gS9MQ02shNGnK2L8PzRtHuQQ9q4PyDqos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWGR4HPV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753801437; x=1785337437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=By4rNMkkWQ13R8Lapcpa6Ff0HaJjIHQmS9wNJ6zpWfg=;
  b=UWGR4HPVOqxHhPYOOETEHzzI/09WhiJMnl8KWqzISIV2sskmyYQ4nnn6
   ZwLSx+Kbc4s1/s2lSe3QBraqOOfoRSuRIEmOPWHbhCzkuGRDV8vcL6FIZ
   p0W6R7gAsC2g7N/WnMjJ8yO/sL6lY1+qmsPLSxaXo5cM298NxZW0dEq1s
   388GUFwtaYc/Y/jORqxCIYi4kNH81x/TE2L5EQfqFIMD87ihea4B864Vf
   jCrsjAbTehixmwf2epmPFZwxo+2ewcCAb7EDabtwPoTP3/RQsRcN+kgvW
   nHTm68d7/oDZHVCGi9ryP5wCDsZwfl4vSEpDot6AoBAWO13J1EcH4R3F0
   w==;
X-CSE-ConnectionGUID: 3ckQ2po/QQCNTCgFRde/FA==
X-CSE-MsgGUID: vLLz7PfkQhKggIogKQyB5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="66643474"
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="66643474"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 08:03:56 -0700
X-CSE-ConnectionGUID: 6o7Fu/s6SymJG4yVuSVyFw==
X-CSE-MsgGUID: 5coi9X4YRN2uO2j1fKGQoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="163069751"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by fmviesa009.fm.intel.com with ESMTP; 29 Jul 2025 08:03:54 -0700
From: Yi Sun <yi.sun@intel.com>
To: vinicius.gomes@intel.com,
	vkoul@kernel.org,
	dave.jiang@intel.com,
	fenghuay@nvidia.com,
	xueshuai@linux.alibaba.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.sun@intel.com,
	gordon.jin@intel.com
Subject: [PATCH v3 RESEND 1/2] dmaengine: idxd: Remove improper idxd_free
Date: Tue, 29 Jul 2025 23:03:12 +0800
Message-ID: <20250729150313.1934101-2-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729150313.1934101-1-yi.sun@intel.com>
References: <20250729150313.1934101-1-yi.sun@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The call to idxd_free() introduces a duplicate put_device() leading to a
reference count underflow:
refcount_t: underflow; use-after-free.
WARNING: CPU: 15 PID: 4428 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110
...
Call Trace:
 <TASK>
  idxd_remove+0xe4/0x120 [idxd]
  pci_device_remove+0x3f/0xb0
  device_release_driver_internal+0x197/0x200
  driver_detach+0x48/0x90
  bus_remove_driver+0x74/0xf0
  pci_unregister_driver+0x2e/0xb0
  idxd_exit_module+0x34/0x7a0 [idxd]
  __do_sys_delete_module.constprop.0+0x183/0x280
  do_syscall_64+0x54/0xd70
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

The idxd_unregister_devices() which is invoked at the very beginning of
idxd_remove(), already takes care of the necessary put_device() through the
following call path:
idxd_unregister_devices() -> device_unregister() -> put_device()

In addition, when CONFIG_DEBUG_KOBJECT_RELEASE is enabled, put_device() may
trigger asynchronous cleanup via schedule_delayed_work(). If idxd_free() is
called immediately after, it can result in a use-after-free.

Remove the improper idxd_free() to avoid both the refcount underflow and
potential memory corruption during module unload.

Fixes: d5449ff1b04d ("dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove call")
Signed-off-by: Yi Sun <yi.sun@intel.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 80355d03004d..40cc9c070081 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1295,7 +1295,6 @@ static void idxd_remove(struct pci_dev *pdev)
 	idxd_cleanup(idxd);
 	pci_iounmap(pdev, idxd->reg_base);
 	put_device(idxd_confdev(idxd));
-	idxd_free(idxd);
 	pci_disable_device(pdev);
 }
 
-- 
2.43.0


