Return-Path: <dmaengine+bounces-3001-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05EC963636
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 01:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4791C240B0
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 23:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7040B1B0118;
	Wed, 28 Aug 2024 23:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUeXvfgc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E741AE056;
	Wed, 28 Aug 2024 23:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888028; cv=none; b=aroIpisLarxHGQ4ZkElRA4I4jvMpVTzRHoMenZ+JrQsNCunoGqYMxGgT0T14W0dbpJtgvvhA1wdvJUH3MR4hTlEvylj42gf4Tp6BrguMqBx5M8h0J/Uhg39Ddfy7t5TkNz76PuabZ7l//fqfvv+FehySFS1Lmh52yvsulbMcju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888028; c=relaxed/simple;
	bh=FIso5A4X6oAjpUbezUd92QNK+kb2dtKmlh+gpd1WYKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dM1MqKYLvTL8JQrbypts4oUOTah+Sb54v+YDjjKaTx5LZlU/HLCyfFS2XLwGNWoqPWmhfcu1D2BFkZXmG2t8mBg1n2aC8j9VTDzXXGQrGTyXfiVnBJvAF9Uu26h4YKzJlFvLMs4TvTA7wAlKnWnqMkBGrPq4t3YsQfzMFgBK/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUeXvfgc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724888027; x=1756424027;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FIso5A4X6oAjpUbezUd92QNK+kb2dtKmlh+gpd1WYKU=;
  b=nUeXvfgcHUghRmkq8X25kKpAhBVfK5CCKcxw6JwOWtkJFEs2pgMQEAW4
   3mx65+33FyGBipSNRbZuxDOugL2V0yVPbNoy1g6+yHJpUTcW0NWF7yAvK
   Vcv3VyojWJbuiWcDsQa3vuFrdRF/lieI4e3wCs6O9zXMv92ZsS4hNJi8e
   BYCvi1cL6nHS3h0bhS86fWCP9JLQpmaPJu6F2pI/mn+pBTOhmww/y3spW
   7pupg4XL5lR+ovhOPXWeguOQbiSKYuyk/vwyc376dMYBpgeHSJ88bCUoF
   NjGTXSyBouGbdZQl1/aucQXsVM75IY9vuEHcFcSEv74O9vcMCyTAj5oon
   A==;
X-CSE-ConnectionGUID: tWkjGn44Sc6Euk6L2exTxA==
X-CSE-MsgGUID: Gg1So/BZQOCx3n369A8Rug==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="27327248"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="27327248"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 16:33:46 -0700
X-CSE-ConnectionGUID: mBOosFNFSWWGTafvmxnJIw==
X-CSE-MsgGUID: v/Vxa1k6TsCGmGiQ3hl4eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68162724"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa003.jf.intel.com with ESMTP; 28 Aug 2024 16:33:45 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 0/2] Add a few new DSA/IAA device IDs
Date: Wed, 28 Aug 2024 16:33:59 -0700
Message-Id: <20240828233401.186007-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to a potential security issue, it's not safe to assign legacy
DSA/IAA devices to virtual machines. This issue has been addressed
by adding the legacy DSA/IAA device IDs to the VFIO denylist[1].

With the security issue fixed in newer DSA/IAA devices, which have
new device IDs, these devices can be safely assigned to virtual
machines without needing to add their IDs to the VFIOI denylist.
Additionally, the new device IDs may be useful to identify any other
potential issues with specific device as well in the future.

[1] commit 95feb3160eef ("VFIO: Add the SPR_DSA and SPR_IAX devices to
    the denylist")

Fenghua Yu (2):
  dmaengine: idxd: Add a new DSA device ID for Granite Rapids-D platform
  dmaengine: idxd: Add new DSA and IAA device IDs for Diamond Rapids
    platform

 drivers/dma/idxd/init.c | 6 ++++++
 include/linux/pci_ids.h | 3 +++
 2 files changed, 9 insertions(+)

-- 
2.37.1


