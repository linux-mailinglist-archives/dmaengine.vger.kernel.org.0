Return-Path: <dmaengine+bounces-5514-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFFCADC830
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 12:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB773AC718
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 10:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45B12900BA;
	Tue, 17 Jun 2025 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aei5DmAf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD9288CA5;
	Tue, 17 Jun 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750156068; cv=none; b=UQxKf4m+VMXQp8X4Gn4p7U1NbvjaSc35DY7seH535d5SPtZij0aMMddZUKSqG1AW7mC1qXqNFYlFnSn7HUq1XnyJ9C75XzORKg0pbV7ZQA3fQENX7/s09ZxiexKSK26x4yBGHrO7tgZZUZfYTU9MHuOFbGsEcdrzdVz6q6xU7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750156068; c=relaxed/simple;
	bh=ZAhzd6vRIdEJDBu/+Y3tha+s7kzTjg40RZ1V/SDTreY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeIO/etHIeIhNZWYrXMMA65/yaZmNrPPJD6qnihVdHSSDXn5y3qEJX1OktJYMyxzAjjggP7APAKek3hV/6uI6Qo9V8m64+AEiwTilGRMEQ9Ovw8VYJ/m247ttJtsXkm9ql+dDL4Hee6ikol81cwMQNF4YxChlHPv07gv4k5hTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aei5DmAf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750156067; x=1781692067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZAhzd6vRIdEJDBu/+Y3tha+s7kzTjg40RZ1V/SDTreY=;
  b=Aei5DmAfGRHr9H5c3qE+ekyFotEToJFbYORmq6S1dCl4NAFACruMb4Ms
   D54Euab3AP8DUmvn5LOVwfd0SFVNgLSPblQ8F7AZGbQ0EsjhMyYOdAAbA
   2c3Dg2X3Zsk8uDwZcULBLwlSIEzFF9hg+0pY+dF5O557IoHmMSOIce3pH
   qgBWOwyoH6TCNeQV16brNhygJ+Zsb9ME7Cmk8QomGmHnM4KuT/nehAT/c
   Yqm3uUiJkp5oGYL+rqcKE88cjSNcu2jO9DZ23V051N6y4A4WiYNqTJzTv
   tg4yrXK3LCo+FHGiBRPTAp3tkoswD/0mZ2TgKb+sBWQrSZxmg5j9s96bO
   w==;
X-CSE-ConnectionGUID: 1/cJKVGATQ2x++flLS68xQ==
X-CSE-MsgGUID: h9lJhRFZSKmRWOmepcVfag==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52462091"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="52462091"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 03:27:47 -0700
X-CSE-ConnectionGUID: eZw9hAmURYi0bYo0NQe1CQ==
X-CSE-MsgGUID: rlLrsn3aQYCGq+FKW+JZUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="154033950"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by orviesa005.jf.intel.com with ESMTP; 17 Jun 2025 03:27:43 -0700
From: Yi Sun <yi.sun@intel.com>
To: vinicius.gomes@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: dave.jiang@intel.com,
	yi.sun@intel.com,
	gordon.jin@intel.com,
	fenghuay@nvidia.com
Subject: [PATCH v3 1/2] dmaengine: idxd: Remove improper idxd_free
Date: Tue, 17 Jun 2025 18:27:11 +0800
Message-ID: <20250617102712.727333-2-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617102712.727333-1-yi.sun@intel.com>
References: <20250617102712.727333-1-yi.sun@intel.com>
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


