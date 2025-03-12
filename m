Return-Path: <dmaengine+bounces-4724-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0D4A5E713
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 23:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806573AB4EA
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 22:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93BC1D86F2;
	Wed, 12 Mar 2025 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVKIWOsN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421AB16FF37;
	Wed, 12 Mar 2025 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817728; cv=none; b=KeQTPjlgXceWpCOaypWZWDtGr4aw7JRaHXKrvYDpPFff0PWwmxszmgtUuajI8i+TkwYdx3YQDT3KpFPPLGyN9QngFvYFH8yBPjZbbZSaoMtlu89VpqmLnWO5RaX9qSdfm1/eA435JtYQXrZ97++RS8uRDaQZtujyn1vVrJ3PQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817728; c=relaxed/simple;
	bh=pTtH+5Aqyf/PqJuEzm8sFhVWE+FLVim+3sY/NLMT/3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nch7qavxIp45hkgML8zk8qMBloczubNweRdtoCNk5iY7/Jj1d2PpNgEJ7ClyJR35Xqdo7b1EP/rEwMYK4m8zioabQu49hSoG8WcXZPQBrnXe/fBhK7Q/hB+JF1VpP18GeTRROIVobuJZNueBG57gA+iLnyXdtagfgeNJKnAxgbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVKIWOsN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741817727; x=1773353727;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pTtH+5Aqyf/PqJuEzm8sFhVWE+FLVim+3sY/NLMT/3U=;
  b=VVKIWOsNeiDhrC2WPbhrndnI8+ch8tG5WdwjKVC0riRFqL22TDW1ACU2
   ysP8n6dAyizzf6HoR9AB6mNhFrP2+pzgeWzMe0ZX0Tpqr4GLUP7MS0ZXE
   L7sBEP4YgYIZ6WD9vLYd6AjlfMhG26NiIkCF+sF+bqAzvXNeeXyr7qV7L
   /H4zs+0ALOBFYOpY1osW5H4LhZ4RMoTmhYPoWC1hA3vVAGSwERFzXZ73K
   EB0KF6+1U/CzpyeayUsvMSXSR34p0ByHbXf2SOqMveIXCA9V8usxTRupm
   D5ouIKkzCDUXYvdHHsOu00KeBS2ushRW0WaTC/hKK3RY0Y0ohx9mwYZHz
   A==;
X-CSE-ConnectionGUID: YXPZy8m9TEOO4WKowQxtZw==
X-CSE-MsgGUID: NB6Crz1lQauwoWeC/PKGKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42172657"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42172657"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:15:26 -0700
X-CSE-ConnectionGUID: M9RsRGGoToecYoJLvvh+kA==
X-CSE-MsgGUID: 3cM+fVplTZC1Mozr4QCUlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="124931594"
Received: from unknown (HELO vcostago-mobl3.jf.intel.com) ([10.241.225.86])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:15:26 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [PATCH v1] dmaengine: idxd: Narrow the restriction on BATCH to ver. 1 only
Date: Wed, 12 Mar 2025 15:15:10 -0700
Message-ID: <20250312221511.277954-1-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow BATCH operations to be submitted and the capability to be
exposed for DSA version 2 (or later) devices.

DSA version 2 devices allow safe submission of BATCH operations.

Signed-off-by: Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/cdev.c  | 6 ++++--
 drivers/dma/idxd/sysfs.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index ff94ee892339..6a1dc15ee485 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -439,10 +439,12 @@ static int idxd_submit_user_descriptor(struct idxd_user_context *ctx,
 	 * DSA devices are capable of indirect ("batch") command submission.
 	 * On devices where direct user submissions are not safe, we cannot
 	 * allow this since there is no good way for us to verify these
-	 * indirect commands.
+	 * indirect commands. Narrow the restriction of operations with the
+	 * BATCH opcode to only DSA version 1 devices.
 	 */
 	if (is_dsa_dev(idxd_dev) && descriptor.opcode == DSA_OPCODE_BATCH &&
-		!wq->idxd->user_submission_safe)
+	    wq->idxd->hw.version == DEVICE_VERSION_1 &&
+	    !wq->idxd->user_submission_safe)
 		return -EINVAL;
 	/*
 	 * As per the programming specification, the completion address must be
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 6af493f6ba77..9f0701021af0 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1208,9 +1208,11 @@ static ssize_t op_cap_show_common(struct device *dev, char *buf, unsigned long *
 
 		/* On systems where direct user submissions are not safe, we need to clear out
 		 * the BATCH capability from the capability mask in sysfs since we cannot support
-		 * that command on such systems.
+		 * that command on such systems. Narrow the restriction of operations with the
+		 * BATCH opcode to only DSA version 1 devices.
 		 */
-		if (i == DSA_OPCODE_BATCH/64 && !confdev_to_idxd(dev)->user_submission_safe)
+		if (i == DSA_OPCODE_BATCH/64 && !confdev_to_idxd(dev)->user_submission_safe &&
+		    confdev_to_idxd(dev)->hw.version == DEVICE_VERSION_1)
 			clear_bit(DSA_OPCODE_BATCH % 64, &val);
 
 		pos += sysfs_emit_at(buf, pos, "%*pb", 64, &val);
-- 
2.48.1


