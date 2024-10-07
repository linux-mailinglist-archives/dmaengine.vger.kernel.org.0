Return-Path: <dmaengine+bounces-3285-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2BF9930BB
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 17:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9737D1C22E96
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 15:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B811D86DF;
	Mon,  7 Oct 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecCXvmiC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7416D1D7E3E;
	Mon,  7 Oct 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313739; cv=none; b=FJjE9M7pnNDc1kg6Q63y5Z0/VEsiNBNfKjueN8S78PnQha+BPK4h1dXCKkxmwk9lrDQXdjOxC9lFh9rykirsZ2hiNtEyvOHvNmMEdHt8hFeKXXMSHEPUDbe/0Tqcpwu7g8MBXSlNOxNTkK9RT7VDi2Ln+ePDzYqpumQ8VjPgUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313739; c=relaxed/simple;
	bh=qGhUu9mdJXXubW4rlkY8zXABwAVgp9j7AomaOvWbYPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmlMQp7e2ivMnMN91ol+fffzDIPKT+TdjRsD/ojmhVQwckE73sbHc9aw0pIcye3LiYxI+2iHGx2bFltg1a9yrj4nWov6b8BxPZuhvIGhnpTzQD0wXntSJRzZVaz3MarpySg8EnrhYecSdbIGKsi9Lx6GK1UIG2b/R3/KrQRTL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecCXvmiC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728313739; x=1759849739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qGhUu9mdJXXubW4rlkY8zXABwAVgp9j7AomaOvWbYPc=;
  b=ecCXvmiCkaoVySO+EwNAmA4IQPI8IY/byrrCVTIGp6nSLsZo8sBOCRL4
   nobNQG/AV8zIlSydRRrcDIq4/2/NJZIgzXKXSWYNPK8A1E3AJ0KA11uDL
   q+5Rggq0ldPPtYKZ4aPw1mlm3yfBxXnUFgLcjoYIi5RkOd7NJwVtUENRE
   DjSIYNyvwS1u/IYJ+AMesFVWnffPmkKgvnZ0rW+FZVDL2RUrJxrw/QemW
   ItqAfdICPWgiGuMMMlkbFaAvz8nJh81Llt4D1XZkoW0ssMz0gtKYNlROx
   jQlZ7SoZK7MFQLQmLYjnJO8Tst21oQeknvOXZk7ukEE6f4fpVy5kit2/J
   A==;
X-CSE-ConnectionGUID: 2k0zfLNwTOq22ty3htPmOw==
X-CSE-MsgGUID: PBafyer4SLGjiwSgLvlsGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="52870242"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="52870242"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 08:08:58 -0700
X-CSE-ConnectionGUID: pm590HrVQSGvXKUrqLQhkA==
X-CSE-MsgGUID: vHncrqsZQFCU65LpdBLbvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80477332"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 07 Oct 2024 08:08:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DCC564FB; Mon, 07 Oct 2024 18:08:53 +0300 (EEST)
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
Subject: [PATCH v1 3/4] dmaengine: Add a comment on why it's okay when kasprintf() fails
Date: Mon,  7 Oct 2024 18:06:47 +0300
Message-ID: <20241007150852.2183722-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241007150852.2183722-1-andriy.shevchenko@linux.intel.com>
References: <20241007150852.2183722-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In dma_request_chan() one of the kasprintf() call is not checked
against NULL. This is completely fine right now, but make others
aware of this aspect by adding a comment.

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


