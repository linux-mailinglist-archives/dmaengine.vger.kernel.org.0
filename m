Return-Path: <dmaengine+bounces-4305-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB31A29304
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 16:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673EC3ABE0D
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 15:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F191DD88B;
	Wed,  5 Feb 2025 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwuMfgpi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113C618CC1C;
	Wed,  5 Feb 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767485; cv=none; b=k4omknKkoK0X7S3xs3SHatc18ud8tN63cl1LBs5M9tTwWaSBxA9oL26PnIFkU6k+6AqLMTiJ2ns+9h8b2YWDuvFoxxeWYcev/qRt9dOdx7lwF55nvhs3VfXgV+t3ALMqEYjC0ovt+WCfzkr3Sy59x4ZY7sWS7in2sqYk1Kz+1OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767485; c=relaxed/simple;
	bh=7H2ugvXbJPmCuRopy+9t0WK9d/y8xYbHP4xu7MXLSn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6D+0iSXUidNl18850uospMLFofoEGwPwjql4ZC96wPahCT0lfC62uYGqE7O5OaZNsrd1bhATJCqiZL1IksVY9k+oNHvrRF6Kve5cHv3lsDlwXldE2ABD5RrDn24XzLn9Z/VuCspxvE/Os04Zj3GWM32hHj0NVfSWjL00jQQl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwuMfgpi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738767484; x=1770303484;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7H2ugvXbJPmCuRopy+9t0WK9d/y8xYbHP4xu7MXLSn4=;
  b=kwuMfgpi1d/7LnEkKAcknGsvYMgpkTubgu9E6Wmo7Zj0hGi00BM6BQ1T
   jQw774xW1KjGdcg3G4t7i3i9JxApyoYyO1e8RigcgzIT+qQZQTNx4Eb/7
   cLryrVBrNQulgqGcTPSCQCf6qSGKfnGB/8FQb9RkuaiA/jMSiqgtyBILi
   YUwMVbgdrwurfimvKW8d1x9w0DLKDCMqXNnUF1Rqcw4dMWURY7EZ19d7H
   4v3p+dOwuf1IyC4zHk/QpuJPO3JMYfsiWcYI0WeRETpTnvYPbtS4QVoBW
   OxJ/AA23z+7kx0Ezs/poP6j6fslmNSRruEpKair9x6cGB3IFtz9XOhpg6
   A==;
X-CSE-ConnectionGUID: fU0ONZa7Soe1vgfn2/EGdA==
X-CSE-MsgGUID: P3lBJH9kS2KtBDmOpU4dWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39232333"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39232333"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 06:58:04 -0800
X-CSE-ConnectionGUID: NAfUT5uvTf2GQBabAJrOmg==
X-CSE-MsgGUID: vZjT9jKDTv+KWp5c2VKFQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111806974"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 05 Feb 2025 06:58:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9983710D; Wed, 05 Feb 2025 16:57:58 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	Frank Li <Frank.Li@nxp.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/4] dmaengine: dma_request_chan*() amendments
Date: Wed,  5 Feb 2025 16:57:08 +0200
Message-ID: <20250205145757.889247-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Reduce the scope of the use of some rarely used DMA request channel APIs
in order to make the step of their removal or making static in the
future. No functional changes intended.

In v3:
- rebased on top of v6.14-rc1

In v2:
- updated the commit messages (Frank)

Andy Shevchenko (4):
  dmaengine: Replace dma_request_slave_channel() by dma_request_chan()
  dmaengine: Use dma_request_channel() instead of
    __dma_request_channel()
  dmaengine: Add a comment on why it's okay when kasprintf() fails
  dmaengine: Unify checks in dma_request_chan()

 drivers/dma/dmaengine.c   | 16 ++++++++--------
 drivers/dma/imx-sdma.c    |  5 ++---
 include/linux/dmaengine.h |  6 +++---
 3 files changed, 13 insertions(+), 14 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


