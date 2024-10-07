Return-Path: <dmaengine+bounces-3286-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DDC9930BD
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 17:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B58B20FA3
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6741D89E6;
	Mon,  7 Oct 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWdiOLYR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD61D86EF;
	Mon,  7 Oct 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313741; cv=none; b=eLA0d7fzJKId1wSe6vITq2G70cSxUl5dYMpJSR7t2+VdNJVii5THikcfcv9gaV3VOxBEhItN7/w+v2f8BWVCfmHYPV769RLs0vdkgjEP4v+6pw2zWulIGNSqgWeJFTtRYPKBBUtcp8FMWHg+HZnDyVYqABULv28Iv9Pn5Z3qPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313741; c=relaxed/simple;
	bh=8p/BU2lvNpakkUwkPeXAni5nQsRzqwM702NTHzKfScY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYvaswh5OzzIg2PQeOxmtY5WQLSkiQY2BbAI5sqTKExc3EXPHD7S544Mt8QD3JWz7RxaUZDmDpGqBm2n/zLMGvY2SfoQfqQnjIcfWjnT1lmIvjWXt4eM9wuizSWq4opmYAjmCkji/UCKvjSFeChJjMWNf0M9otFn6Vf10x9IB/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWdiOLYR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728313740; x=1759849740;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8p/BU2lvNpakkUwkPeXAni5nQsRzqwM702NTHzKfScY=;
  b=SWdiOLYRa60pFITTl8mG1rStE2rKex8jfimrNqkYkte2XdzvcbSSnB+4
   DF9FSxY/rdA4Dqy+hz3pKiRouFQjknY1enwJdT8JziEBqn7u0IQB5YzCs
   0I+l3k02R3QD/h5wZ2/b/gx1TFeS7NqEO5XByITacUB9ZI5ggMo/GvQOa
   TUzVHvK+41wJ8LPzMEA+9z5w6dVEi6YccJrjeEmmDc67nYxfNR4tMV59m
   lMjgRRuK4bZNDoADlXLoBxwpCmD6+mlcbb08wdNGQpMeosohtBxXep8E0
   eScZIWV+wYUDiO4aGG+QrGHhjib5OrondX4+HVDuq9o8vw5VNxXHSpgri
   Q==;
X-CSE-ConnectionGUID: +vgW3OnnSDOIJqHP5ZiGag==
X-CSE-MsgGUID: 539S8zxdSY6j3gDsQ96nWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="52870233"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="52870233"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 08:08:58 -0700
X-CSE-ConnectionGUID: LbOfZus1QZ+kpNo7fIlOmA==
X-CSE-MsgGUID: KGgzbCjfRUaK36Jw6mJWLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80477330"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 07 Oct 2024 08:08:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AF9CA301; Mon, 07 Oct 2024 18:08:53 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 0/4] dmaengine: dma_request_chan*() amendments
Date: Mon,  7 Oct 2024 18:06:44 +0300
Message-ID: <20241007150852.2183722-1-andriy.shevchenko@linux.intel.com>
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


