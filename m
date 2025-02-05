Return-Path: <dmaengine+bounces-4307-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1DCA292F7
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 16:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2147316D615
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE2E1FAC5C;
	Wed,  5 Feb 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJCZmW8c"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909F18CBFB;
	Wed,  5 Feb 2025 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767487; cv=none; b=OgH6zHHKdLa+E4TuMYsCyRnx+mK7RE2pffsNzuAJwDdZpMm2a0ZE8S9X9ltsHHsV8fiq0BfXPojcKlCeGJh//a1CblMaVC71+zKDcbmgrrR4HKAwLnQfK7LhlbkiyOXkZTzeru48QRRYR4Wwkc9vPfjNZqdwCCtkBukBeNTmvbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767487; c=relaxed/simple;
	bh=M41KJpPTgtZC1kvfB0ok8XtGl6qr+rtNSYSFho5CTIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uE85Ww/CuDLGTvoN181s9ZQpnuw9Etz/GA3os2COpTOm9NvNlu3fNyYUf+HFTzbT2X+s07C2IPlNrkA6RueLKqllShlKhBsNS5hTjTy2MQ+wnPS4K7d9Qk6TUiZywNRjeOXzXVtR3EokT5B0qMI3O9XjWQPwpk4OAUmY+z+JcOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJCZmW8c; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738767487; x=1770303487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M41KJpPTgtZC1kvfB0ok8XtGl6qr+rtNSYSFho5CTIc=;
  b=SJCZmW8c4/crNZmYDauA01NMD2Oc8jhgBZVjIP+JC9YP85FD3UgGXiuw
   HS72OUEfy+s74SZjYn4zUkZHzjDz3EjyrxMcrIHBTOMRd3uWgKb1WGX0C
   NukW9ES5ilgfRJSRvunmWWN6lqMGEHUBtTSXPM+0BxpKG09lYa2pBKc82
   gu7k8Ym5a8mn53KSDKGUxNlj1PNs3dSEwwgX+yANWZfIynZbbuVrc4OhD
   mToG6xDeiy5r87xCZKHCMt3/tJnNINpsR6EDe14QTdIn9ejaZ3/c4gayH
   H9vHqmY2MF8I5e2nzgK7pfcghFR3ZHdY1rxBXb8H9/jcketw7J3v7D5Bf
   A==;
X-CSE-ConnectionGUID: psi4DFEATBS46/F7Gixd8A==
X-CSE-MsgGUID: Ke2N1bDcR8SFIaO8NFXT2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39232354"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39232354"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 06:58:04 -0800
X-CSE-ConnectionGUID: +/C1jtaVQV+6by6EwWF+9w==
X-CSE-MsgGUID: hG1snVx5SUO/cR2QZ8CmNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111806975"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 05 Feb 2025 06:58:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C7EE5164; Wed, 05 Feb 2025 16:57:58 +0200 (EET)
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
Subject: [PATCH v3 3/4] dmaengine: Add a comment on why it's okay when kasprintf() fails
Date: Wed,  5 Feb 2025 16:57:11 +0200
Message-ID: <20250205145757.889247-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20250205145757.889247-1-andriy.shevchenko@linux.intel.com>
References: <20250205145757.889247-1-andriy.shevchenko@linux.intel.com>
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


