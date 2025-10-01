Return-Path: <dmaengine+bounces-6735-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6F1BAEF20
	for <lists+dmaengine@lfdr.de>; Wed, 01 Oct 2025 03:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0A03AA921
	for <lists+dmaengine@lfdr.de>; Wed,  1 Oct 2025 01:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBC01E5B88;
	Wed,  1 Oct 2025 01:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MN1r5omD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DCE6BFCE;
	Wed,  1 Oct 2025 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759281734; cv=none; b=U6R/9OvW2Q0hmuqmYt99RStw6ZdTPhI4hodo7g6IXoeMgSBNG5/xH6COd/t1v4lqdiPVtA+DWYOflGA9YCHoz4XbZq6tNjb26GO9ugiUGyaF1KTYD4OPOT36VsCdz80H1lFWUQyLMq/7fTWs0EXTPmH01tPTohjtUEJ8WG/CFgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759281734; c=relaxed/simple;
	bh=OyNjSbgCqVsBK4Ng0rOYgBV4mISzj8PYKPHxDBfBgUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYvKeke3v6QNxVCIkKUWjvjgan3QnOgpPg98sUSKmYCaOuuY9dOF3ToXia+gPd42kHd/1Lp5xvPGJ7Stq68CKGBBzI2vbYBOa2m8Z4mdK9hl3nlUS2RZVqE2yuqMpQzrD8oOMXy55AGW7azMsrbDPaPFOYOvDh+iNX88xdWUFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MN1r5omD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759281730; x=1790817730;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OyNjSbgCqVsBK4Ng0rOYgBV4mISzj8PYKPHxDBfBgUQ=;
  b=MN1r5omDBUBiin+4vfgqCuAv4TS35iTYYXX/rGGlFdcssYzVc9rTRVlT
   BQ9oCYaqMquYY9UKCO+e7hRbxQhI2MDAlpm0FFC0xSz0xbHUduT/8zqgB
   zoiou+bqs5xAQ+GukarXaJh6nZa/0yIoWbIHEztDhMAc4KeGOzDYNvVBm
   U+lzN6xVMTHNkfiGK1xtsAWoCohPX+CKrBTr6BDH9niy3ZuXBdTg5tSd2
   azvzJ7k0QMlKSPTG5G/aZLKvxi3LuK2GM0rATd3lUScsIpvWIBh9qllip
   OW6svj/CkTTyy6qPEF2jb3gBjO/6JIZ7ArkXHBzYYb9Y+66La8ttQR0OI
   g==;
X-CSE-ConnectionGUID: VceX6HK+TY+0RgjQqBMMPw==
X-CSE-MsgGUID: 3rk1SkXcTU+kDQfjt0XZpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61465160"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61465160"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 18:22:09 -0700
X-CSE-ConnectionGUID: piTOZ66gQvSIrrWX4+y8oQ==
X-CSE-MsgGUID: p4QtadcVS/+rUn5IkfnDiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="183853801"
Received: from vcostago-desk1.jf.intel.com ([10.88.27.140])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 18:22:08 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: dmaengine@vger.kernel.org
Cc: dave.jiang@intel.com,
	vkoul@kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v1] dmaengine: idxd: drain ATS translations when disabling WQ
Date: Tue, 30 Sep 2025 18:22:26 -0700
Message-ID: <20251001012226.1664994-1-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikhil Rao <nikhil.rao@intel.com>

There's an errata[1], for the Disable WQ command that it
does not guaranteee that address translations are drained. If WQ
configuration is updated, pending address translations can use an
updated WQ configuration, resulting an invalid translation response
that is cached in the device translation cache.

Replace the Disable WQ command with a Drain WQ command followed by a
Reset WQ command, this guarantees that all ATS translations are
drained from the device before changing WQ configuration.

[1] https://cdrdv2.intel.com/v1/dl/getcontent/843306 ("Intel DSA May
Cause Invalid Translation Caching")

Signed-off-by: Nikhil Rao <nikhil.rao@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/device.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5cf419fe6b46..c2cdf41b6e57 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -16,6 +16,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 			  u32 *status);
 static void idxd_device_wqs_clear_state(struct idxd_device *idxd);
 static void idxd_wq_disable_cleanup(struct idxd_wq *wq);
+static int idxd_wq_config_write(struct idxd_wq *wq);
 
 /* Interrupt control bits */
 void idxd_unmask_error_interrupts(struct idxd_device *idxd)
@@ -215,14 +216,28 @@ int idxd_wq_disable(struct idxd_wq *wq, bool reset_config)
 		return 0;
 	}
 
+	/*
+	 * Disable WQ does not drain address translations, if WQ attributes are
+	 * changed before translations are drained, pending translations can
+	 * be issued using updated WQ attibutes, resulting in invalid
+	 * translations being cached in the device translation cache.
+	 *
+	 * To make sure pending translations are drained before WQ
+	 * attributes are changed, we use a WQ Drain followed by WQ Reset and
+	 * then restore the WQ configuration.
+	 */
+	idxd_wq_drain(wq);
+
 	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
-	idxd_cmd_exec(idxd, IDXD_CMD_DISABLE_WQ, operand, &status);
+	idxd_cmd_exec(idxd, IDXD_CMD_RESET_WQ, operand, &status);
 
 	if (status != IDXD_CMDSTS_SUCCESS) {
-		dev_dbg(dev, "WQ disable failed: %#x\n", status);
+		dev_dbg(dev, "WQ reset failed: %#x\n", status);
 		return -ENXIO;
 	}
 
+	idxd_wq_config_write(wq);
+
 	if (reset_config)
 		idxd_wq_disable_cleanup(wq);
 	clear_bit(wq->id, idxd->wq_enable_map);
-- 
2.51.0


