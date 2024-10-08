Return-Path: <dmaengine+bounces-3305-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBC59955BA
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2024 19:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F04F1C24E7E
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2024 17:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851BF20ADC3;
	Tue,  8 Oct 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="As52Ct/y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55E20A5F5;
	Tue,  8 Oct 2024 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408864; cv=none; b=K3yOagwePX+eKsolU6MH0AoP0L/lDp/lmdRl5RYIY8J8Sw/Hr/hQWuEcwma2dMTcE63veqS6oy3PxVhST4/MG6Nlfj2JyBqBRo6yEH2JLt1rIpYJAT8+xM8H9PSm/LQSCHiNJwEAKaePuSmQi4CRWwXtFzbqOyi97r4Lbyf1qE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408864; c=relaxed/simple;
	bh=j53AEc77GiUPNvrDuZB6BAndEAIGD46chw/Su2ycRBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQxm84ItfA5PAg8uoiXCHl6icRS/LFMNC/jjo/nHZ1ydP9+RnzuVthF5CgPC6jz+435Q3FZ4HKCFsq2sp5YrhyH6YxWUQyG5MrSy3FWDxTm9h9nOGJfvrbPDoU74/GX/oJgB3DtoSoJ67h9XwrlcxAujG77FGHzl1LAR1DHYiSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=As52Ct/y; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728408861; x=1759944861;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j53AEc77GiUPNvrDuZB6BAndEAIGD46chw/Su2ycRBc=;
  b=As52Ct/yfi4IhptHUcofIAj49RHAgIlotAc3ytp1PC2FaSuAs2P8vzd0
   Gd6dZTANJFnE88c15W3lblaq+TIO953QSZBvkUGvnOnBD4THX0OVNwIf4
   f0mJ6IqfQ/406kPQCuB2t5J3lxgPneUHaor2Dy1cImQNSAZs1VNfpEYew
   Cmw+/uUSgMgVxCErN9n2It76rs4RrFVOxfyFJmTvV+9Je8VZ6nLjwFFtt
   ZV7eeunb6K8Ju8Ek1eusouxPnj0TLc912HdfJJxLK+Qiz80SNx2s3phpl
   cUHxMbqda4+UqtepoP1LCCpyJZ6BFGvHgxp9d4Pi/WON+Aal06PcDoXH6
   g==;
X-CSE-ConnectionGUID: NLlDsefTSu2ccbZFzfmAYw==
X-CSE-MsgGUID: K+uk7g4rTqma27GHQ7quxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27510089"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27510089"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 10:34:03 -0700
X-CSE-ConnectionGUID: WBcGo37IS5aJ/VNOFGegqA==
X-CSE-MsgGUID: WrbJv3PERcuTjWBDtvVFPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="106677461"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 10:34:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 280F326B; Tue, 08 Oct 2024 20:33:59 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/4] dmaengine: dma_request_chan*() amendments
Date: Tue,  8 Oct 2024 20:27:43 +0300
Message-ID: <20241008173351.2246796-1-andriy.shevchenko@linux.intel.com>
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


