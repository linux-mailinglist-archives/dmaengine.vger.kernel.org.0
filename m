Return-Path: <dmaengine+bounces-3307-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A7C9955C0
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2024 19:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD041C24F35
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2024 17:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5CE20B1F9;
	Tue,  8 Oct 2024 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khNb2y3/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8FA20ADC7;
	Tue,  8 Oct 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408889; cv=none; b=Vic0XDL7VLYU8PX8HMaL7W9M3cHHMb11Qj8AqPLnjSYLrnuFywSxgyrUl1cGd0pcU4pWekM/qljr3RgEISilH0VltMifK1er7/TTsU7BgoInyDOgyov3ybyE31PV8zpwRJMj0bROZ/lO1Uxay9xgA+h8IGrBvGENNR06rBYj+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408889; c=relaxed/simple;
	bh=M41KJpPTgtZC1kvfB0ok8XtGl6qr+rtNSYSFho5CTIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnFL5lhUqKiRAPPXydNVWt/HPTKBx71WfsWj8+PMGJErnwuuxc/9C7rWtyxRzyVWmRuwAtN1iM81NWmkt3BSqmzTcNhUD6rn/PDqfJZeSScObmv1deyzEyS7JD8EwimuvhrOSoiT4tV85I8SuZFKCJdRd1H7M41eM3A/BZgv8qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khNb2y3/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728408888; x=1759944888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M41KJpPTgtZC1kvfB0ok8XtGl6qr+rtNSYSFho5CTIc=;
  b=khNb2y3/3KFJhiMuR6U+sVg+JFoKAxjMDTVxrihTdYYoV9ShkNuCtINw
   OIoFjHW/BABbFX17v70xMeFo8FVxvUvAKaTgNSV2sFJ104di/Qfzo7ClU
   VF+Dss5yH72Bz6jwkafDuy5dxFzm5VDgp5cmajCNxfKFaOnPyCKpKWYAC
   oORWBf53h2/L90x0dhu3WJ0bV7qJoHS6qpWrtL4qcqGn7oolHCG5Kv+bK
   zOzIvRis2nw329urx89h1MQ2dCHuMnNHv3kFMjCn31Ld0gPoPr/on7ZUp
   /IJjWIoJiw8y/Q7BO6W8Quj5aSkFFiP9p4v8hNc3UahCMMmMuxHbCvfNz
   g==;
X-CSE-ConnectionGUID: etGNj3fmRpeUym9tyyO3pw==
X-CSE-MsgGUID: k7kRe0QYQKe07+rZe8guaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27510134"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27510134"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 10:34:11 -0700
X-CSE-ConnectionGUID: t8RFXAV7Sqyt6MzY8WQMWg==
X-CSE-MsgGUID: zeSFKaSOS52rpb6wYKZVXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="106677517"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 10:34:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AEE59347; Tue, 08 Oct 2024 20:34:06 +0300 (EEST)
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
Subject: [PATCH v2 3/4] dmaengine: Add a comment on why it's okay when kasprintf() fails
Date: Tue,  8 Oct 2024 20:27:46 +0300
Message-ID: <20241008173351.2246796-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241008173351.2246796-1-andriy.shevchenko@linux.intel.com>
References: <20241008173351.2246796-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a comment in dma_request_chan() to clarify kasprintf() missing return
value check and it is correct functionality.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmaengine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c1357d7f3dc6..dd4224d90f07 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -854,8 +854,8 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 
 found:
 #ifdef CONFIG_DEBUG_FS
-	chan->dbg_client_name = kasprintf(GFP_KERNEL, "%s:%s", dev_name(dev),
-					  name);
+	chan->dbg_client_name = kasprintf(GFP_KERNEL, "%s:%s", dev_name(dev), name);
+	/* No functional issue if it fails, users are supposed to test before use */
 #endif
 
 	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
-- 
2.43.0.rc1.1336.g36b5255a03ac


