Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2B53D1675
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jul 2021 20:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhGURy3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Jul 2021 13:54:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:57502 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231230AbhGURy2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 21 Jul 2021 13:54:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="198765586"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="198765586"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 11:35:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="432969448"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 11:35:03 -0700
Subject: [PATCH] dmaengine: idxd: fix uninit var for alt_drv
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Wed, 21 Jul 2021 11:35:03 -0700
Message-ID: <162689250332.2114335.636367120454420852.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

0-day detected uninitialized alt_drv variable in the bind_store() function.
The branch can be taken when device is not idxd device or wq 'struct
device'. Init alt_drv to NULL.

Fixes: 6e7f3ee97bbe ("dmaengine: idxd: move dsa_drv support to compatible mode")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/compat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/compat.c b/drivers/dma/idxd/compat.c
index d67746ee0c1a..d7616c240dcd 100644
--- a/drivers/dma/idxd/compat.c
+++ b/drivers/dma/idxd/compat.c
@@ -34,7 +34,7 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t cou
 {
 	struct bus_type *bus = drv->bus;
 	struct device *dev;
-	struct device_driver *alt_drv;
+	struct device_driver *alt_drv = NULL;
 	int rc = -ENODEV;
 	struct idxd_dev *idxd_dev;
 


