Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244B2377988
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 02:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhEJAja (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 May 2021 20:39:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:36661 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229853AbhEJAja (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 9 May 2021 20:39:30 -0400
IronPort-SDR: cZ8RMWtyEW6bZX+U3VTy8qkhWqNNvOElGCzDp1YjM62ltA31hCshQHGhiRRKGSXFkYPlTpfvCJ
 Y5VJrVf0KsWA==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="263014919"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="263014919"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2021 17:38:26 -0700
IronPort-SDR: YEHWQ26AuzAekwnrQmYLh/EheY8CUQaowgvQ5DXQAQ52rhZqNCMBKLglrPfrmGyV26tq0XyPqb
 rhKkuOEZMU5g==
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="467854890"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2021 17:38:25 -0700
Subject: [PATCH] dmaengine: idxd: remove devm allocation for idxd->int_handles
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Sun, 09 May 2021 17:38:25 -0700
Message-ID: <162060710518.130816.11349798049329202863.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <YJZJ2Z5CEqQC5s+1@mwanda>
References: <YJZJ2Z5CEqQC5s+1@mwanda>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Allocation of idxd->int_handles was merged incorrectly for the 5.13 merge
window. The devm_kcalloc should've been regular kcalloc due to devm_*
removal series for the driver.

Fixes: eb15e7154fbf ("dmaengine: idxd: add interrupt handle request and release support")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2a926bef87f2..21d3dcb1c0e3 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -311,7 +311,8 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 	init_waitqueue_head(&idxd->cmd_waitq);
 
 	if (idxd->hw.cmd_cap & BIT(IDXD_CMD_REQUEST_INT_HANDLE)) {
-		idxd->int_handles = devm_kcalloc(dev, idxd->max_wqs, sizeof(int), GFP_KERNEL);
+		idxd->int_handles = kcalloc_node(idxd->max_wqs, sizeof(int), GFP_KERNEL,
+						 dev_to_node(dev));
 		if (!idxd->int_handles)
 			return -ENOMEM;
 	}


