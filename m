Return-Path: <dmaengine+bounces-4901-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DF9A8AE4D
	for <lists+dmaengine@lfdr.de>; Wed, 16 Apr 2025 04:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 222467ACD82
	for <lists+dmaengine@lfdr.de>; Wed, 16 Apr 2025 02:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9AD20FA94;
	Wed, 16 Apr 2025 02:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idCG+kx8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98D2046B1;
	Wed, 16 Apr 2025 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744771936; cv=none; b=qpU+DJqNJNQYRemeaEaj0uC0eUGuUjFJpzpM9phpcD2TVquY1Ypo5bbibwoHYBXqMleQbLWWQnOxPp/M01rTYLLhL0nbg8QRULic4+A7axohrFjcQABOraAYEvuRYAndf6E25yKyB9NbN8ts9P1mdupdJUa7KhEi85d3qcagaGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744771936; c=relaxed/simple;
	bh=relbUb49jt5uEZzotCsgKbhE14fX6Q/pI6KYq1UncfY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EZZvKC5dLucFnb6HY14HASY/PDe1jovCWIBqFIPECpXYWpn0S3JWE1Ddanbv5BBLOB1EeQPi+iBwLJmCkxF9V3UVb5o6t/qOt+jfEMDGjY06wrhkLCnt4XLj4nHaP07+Iaqxb07bYIL4zSdb3Oxjhv5Fp+gYu+0NIE6QTswWYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idCG+kx8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744771934; x=1776307934;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=relbUb49jt5uEZzotCsgKbhE14fX6Q/pI6KYq1UncfY=;
  b=idCG+kx8oKmf234NbVhmUIdiVi4BmaXTbJ/JhdVZGai2jF625BAaYzVJ
   OKkZGTU+nLq2G9wAxzzOGbMWp2bajgV2s9Ygfl9JhrZJKP18GCSJLZ5vu
   47Ivv1oAal2hVQtlxuIxuNFwLRWqJllQ64eV7lHqOBXG9N3iCopXE2MdM
   Zek2pTA9VZipu6YFczTTDK1ueKlYVFmff1MgJUidR3kUmED7CzQHT2tfR
   AB5k4Rl3N6WtxtU0emwn5DMWDmbPJIPORpob1qKLiO90ZatICfmhVY9JF
   XeXKmD9O4ygnAQcLVKeXbKiPu8PPEbujFPn3wxqsoeVLasXcDOCEcFg0g
   A==;
X-CSE-ConnectionGUID: Y1cH10hWQ0qgnaSq6MAv+g==
X-CSE-MsgGUID: omISyx4oQPan0mAsyD8odw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="56479150"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="56479150"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 19:52:14 -0700
X-CSE-ConnectionGUID: Cp+aiACvTZ23WT6Ql81mDg==
X-CSE-MsgGUID: JaxDajJkS5y2/bkkEWvkPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="161342167"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO vcostago-mobl3.lan) ([10.124.222.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 19:52:13 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Nikhil Rao <nikhil.rao@intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dmaengine: idxd: Fix allowing write() from different address spaces
Date: Tue, 15 Apr 2025 19:52:01 -0700
Message-ID: <20250416025201.15753-1-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if the process submitting the descriptor belongs to the same
address space as the one that opened the file, reject otherwise.

Fixes: 6827738dc684 ("dmaengine: idxd: add a write() method for applications to submit work")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/cdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index ff94ee892339..373c622fcddc 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -473,6 +473,9 @@ static ssize_t idxd_cdev_write(struct file *filp, const char __user *buf, size_t
 	ssize_t written = 0;
 	int i;
 
+	if (current->mm != ctx->mm)
+		return -EPERM;
+
 	for (i = 0; i < len/sizeof(struct dsa_hw_desc); i++) {
 		int rc = idxd_submit_user_descriptor(ctx, udesc + i);
 
-- 
2.49.0


