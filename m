Return-Path: <dmaengine+bounces-7103-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A82C45751
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 09:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952AA3B44A2
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 08:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293632E9EC7;
	Mon, 10 Nov 2025 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hrjwPMFU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755782F25F1;
	Mon, 10 Nov 2025 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764834; cv=none; b=OnvmKe9AUUHlppKrUbj4LPO3fPZfvaeMTDERtg9a2n9Yg/IUyY2+n3HJy76JRL0kBrtlWrCDKGclMqKJjW0EjpACNOOAK4i7wwRm3Tkh0sFnqzD3qBgZpNTppA+ZEvd2pXh5hl3Px83rx2WZkOHqL7mkAHQW9HE7o95aUP6hYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764834; c=relaxed/simple;
	bh=jlPhlQ/arUEIrfdbFemlVJUaoIjE9Osvf6PZWhDgZXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcO/ifW8Nt0CfhpokXNt7TSTEVmiaKEpHTlNMrSfcHIRGB2mUpew7cOrcLbA464/IuKzDJD6yvpMwMhUwxrT+UsIGMEJi/SGTcfDfFqP7H7JS30M8j/wGGx5NMp6oExP8HI9SNhtPn1Prtw/xkoVILMcKvAJ9A2NH35obozhIic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hrjwPMFU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762764833; x=1794300833;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jlPhlQ/arUEIrfdbFemlVJUaoIjE9Osvf6PZWhDgZXs=;
  b=hrjwPMFUMQgXbYQuURlqNlH80FvVKNyTouInwCEiWkLfvK2MtuFkfHNi
   +CFK0/a5G5JS3+zc3erTe4kZ4WDLZz6Rfw/fB0tqo7lx5Ih0Viyq1V+bM
   9irn3ZGAFCccmEWmXp/FKLbJRJuVowPE7LUGfvUMK8j2/T+R0HYW3qLDu
   Xkow2fAgfSIgruFy330ffj72TKJS/L/JEXvQQCYnBGt/IJYrFy9YvEycb
   9Q4nDvKyFGzkY1IAFPsONYtM5mTZZ2nFt2l8DBH8/8USOBfTBkpSXpNM7
   TTU+fz1MVRKp+IEukGwfafK2C9N8Q+jGGY7VkXpCrjYv5XJx1t+YIoLEQ
   g==;
X-CSE-ConnectionGUID: oRlVBN9JSrCmz6Arvs0hVg==
X-CSE-MsgGUID: Y4a8z3lyT3+iDGpbsEoS2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64738894"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64738894"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 00:53:52 -0800
X-CSE-ConnectionGUID: 4jD9BhJcTvGb1ljLEKMknw==
X-CSE-MsgGUID: r8XsQKH9ShqxEi0wswlPBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192877839"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 10 Nov 2025 00:53:51 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 20F6D95; Mon, 10 Nov 2025 09:53:50 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 0/3] dmaengine: A little cleanup and refactoring
Date: Mon, 10 Nov 2025 09:47:42 +0100
Message-ID: <20251110085349.3414507-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This just a set of small almost ad-hoc cleanups and refactoring.
Nothing special and nothing that changes behaviour.

Changelog v2:
- dropped not very good (and not compilable) change (LKP)

Andy Shevchenko (3):
  dmaengine: Refactor devm_dma_request_chan() for readability
  dmaengine: Use device_match_of_node() helper
  dmaengine: Sort headers alphabetically

 drivers/dma/dmaengine.c | 50 +++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

-- 
2.50.1


