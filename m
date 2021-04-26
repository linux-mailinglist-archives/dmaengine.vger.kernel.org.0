Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBC936BBF4
	for <lists+dmaengine@lfdr.de>; Tue, 27 Apr 2021 01:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhDZXKF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Apr 2021 19:10:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:57711 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232022AbhDZXKE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 26 Apr 2021 19:10:04 -0400
IronPort-SDR: Hjn+jOZD+gJA7K6v3NdQcMgHiNg8JE3DRd9g0w97N38z6cj7zp6LiYxNawkeAeC4laFYoNMVL4
 iHhLKnjycwbA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="260372048"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="260372048"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 16:09:21 -0700
IronPort-SDR: 4047PtU6e5RZi9r25xnSH05MxczOeej1devUcE9UmjbfmZDLr7ng7GktpBlSc5T99GwR7+9c7T
 zvcwFkum8oNg==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="536378525"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 16:09:20 -0700
Subject: [PATCH] dmaengine: idxd: add engine 'struct device' missing bus type
 assignment
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Mon, 26 Apr 2021 16:09:19 -0700
Message-ID: <161947841562.984844.17505646725993659651.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

engine 'struct device' setup is missing assigning the bus type. Add it to
dsa_bus_type.

Fixes: 75b911309060 ("dmaengine: idxd: fix engine conf_dev lifetime")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

Hi Vinod, this line got dropped after all my rebasing when it has always
been there. We should include it with the 5.13 merge window pull request.
Thanks!

 drivers/dma/idxd/init.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2a926bef87f2..ec7305f86bf7 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -242,6 +242,7 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 		engine->idxd = idxd;
 		device_initialize(&engine->conf_dev);
 		engine->conf_dev.parent = &idxd->conf_dev;
+		engine->conf_dev.bus = &dsa_bus_type;
 		engine->conf_dev.type = &idxd_engine_device_type;
 		rc = dev_set_name(&engine->conf_dev, "engine%d.%d", idxd->id, engine->id);
 		if (rc < 0) {


