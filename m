Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EFA38D156
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 00:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhEUWX1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 18:23:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:43390 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhEUWX0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 May 2021 18:23:26 -0400
IronPort-SDR: CI2PMcFtXDiN3YUTYSXOa7bYm5SE3Vp4rd1podqduORt8yeCxStJl9sNFjqXZTr3NJS7LGqrSz
 ClVdV+A9+Arw==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="199645395"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="199645395"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:22:03 -0700
IronPort-SDR: utpHqtY+2qEqZnqY4s7PijDSgDfyh/UM7g2h8YOo277CqC54SOpwtrD1erOBpfNWdbSqk+VGw0
 Ge1md4Ws0uJQ==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="474719168"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:22:02 -0700
Subject: [PATCH 07/18] dmaengine: idxd: remove bus shutdown
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        jgg@nvidia.com, ramesh.thomas@intel.com
Date:   Fri, 21 May 2021 15:22:02 -0700
Message-ID: <162163572237.260470.13447287868886621724.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
References: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove ->shutdown() function for the dsa bus as it does not do anything and
is not necessary.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/sysfs.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index ac0997b4c72a..65be789b7446 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -138,17 +138,11 @@ static int idxd_config_bus_remove(struct device *dev)
 	return 0;
 }
 
-static void idxd_config_bus_shutdown(struct device *dev)
-{
-	dev_dbg(dev, "%s called\n", __func__);
-}
-
 struct bus_type dsa_bus_type = {
 	.name = "dsa",
 	.match = idxd_config_bus_match,
 	.probe = idxd_config_bus_probe,
 	.remove = idxd_config_bus_remove,
-	.shutdown = idxd_config_bus_shutdown,
 };
 
 static struct idxd_device_driver dsa_drv = {


