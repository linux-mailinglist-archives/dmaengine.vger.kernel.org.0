Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF21357559
	for <lists+dmaengine@lfdr.de>; Wed,  7 Apr 2021 21:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355810AbhDGT76 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 15:59:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:42486 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349129AbhDGT75 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 15:59:57 -0400
IronPort-SDR: s5gAVV0ZBIJmj0eUDeB7NNMRbp/l+w+CW9lh1ioFuZTt5gG3EGzG0Vo9Gw77HHGb/VmCH5moJg
 abM3Zz5FI6Mg==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="191227546"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="191227546"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 12:59:48 -0700
IronPort-SDR: MGqYCnvGMEvsBBzPh7sRoAhrh2cGgCrc0gt972bnFZ5GuDIQ57xouzFJBARmk9JLxLycHPaKE9
 rVGyWoCdAE9A==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="448377155"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 12:59:47 -0700
Subject: [PATCH] dmaengine: idxd: fix wq size store permission state
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Wed, 07 Apr 2021 12:59:47 -0700
Message-ID: <161782558755.107710.18138252584838406025.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

WQ size can only be changed when the device is disabled. Current code
allows change when device is enabled but wq is disabled. Change the check
to detect device state.

Fixes: c52ca478233c ("dmaengine: idxd: add configuration component of driver")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index f08d45f4570e..581ce56ae4f5 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -889,7 +889,7 @@ static ssize_t wq_size_store(struct device *dev,
 	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
 		return -EPERM;
 
-	if (wq->state != IDXD_WQ_DISABLED)
+	if (idxd->state == IDXD_DEV_ENABLED)
 		return -EPERM;
 
 	if (size + total_claimed_wq_size(idxd) - wq->size > idxd->max_wq_size)


