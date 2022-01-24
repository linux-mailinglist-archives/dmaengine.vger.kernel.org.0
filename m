Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AB7498488
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jan 2022 17:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbiAXQVG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jan 2022 11:21:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:30860 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232730AbiAXQVG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Jan 2022 11:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643041266; x=1674577266;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gep+uUFDT7psqiwxAXGOj6iEmqWnmlgvdLpZd0p1b2w=;
  b=dr23f9kwBDVnqOpHsrCMnJLvBhhO3UogOKBo9Gea/BdT0cOeCefMOr/u
   4piKe5mdWWW3eL1zPk9EoGRx3HSpzlJXp+E+DICItFYNJFDcIkgMXdWul
   Wxruywws/CGDGrPW4Outb36j6+D6lsv3e13xCBC3dGcScTLWxLnF2M6t0
   ZFEWPBmPoPjI7fdT2faWZMJRB1S+etZbRQ99c61mICAf67Nq8L1/Gr9Tg
   FwiaHJtEIVFW9CnPjqVc/Mo+6W4gXPYQorFgi/2A39YG3jEP6Z0+7gK4d
   TgWPG4sllbbG/E/N0s591iDIhu/YF+roouiE/EMRZ+hAD98JTHccvgrjC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="244916540"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="244916540"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 08:20:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="617284620"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 08:20:34 -0800
Subject: [PATCH] dmaengine: idxd: restore traffic class defaults after wq
 reset
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Binuraj Ravindran <binuraj.ravindran@intel.com>,
        dmaengine@vger.kernel.org
Date:   Mon, 24 Jan 2022 09:20:33 -0700
Message-ID: <164304123369.824298.6952463420266592087.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When clearing the group configurations, the driver fails to restore the
default setting for DSA 1.x based devices. Add defaults in
idxd_groups_clear_state() for traffic class configuration.

Fixes: ade8a86b512c ("dmaengine: idxd: Set defaults for GRPCFG traffic class")
Reported-by: Binuraj Ravindran <binuraj.ravindran@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 573ad8b86804..3061fe857d69 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -681,8 +681,13 @@ static void idxd_groups_clear_state(struct idxd_device *idxd)
 		group->use_rdbuf_limit = false;
 		group->rdbufs_allowed = 0;
 		group->rdbufs_reserved = 0;
-		group->tc_a = -1;
-		group->tc_b = -1;
+		if (idxd->hw.version < DEVICE_VERSION_2 && !tc_override) {
+			group->tc_a = 1;
+			group->tc_b = 1;
+		} else {
+			group->tc_a = -1;
+			group->tc_b = -1;
+		}
 	}
 }
 


