Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF37435022
	for <lists+dmaengine@lfdr.de>; Wed, 20 Oct 2021 18:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhJTQ3n (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Oct 2021 12:29:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:38827 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230089AbhJTQ3l (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Oct 2021 12:29:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="289671388"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="289671388"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:27:26 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="527136261"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:27:25 -0700
Subject: [PATCH] dmaengine: idxd: remove kernel wq type set when load
 configuration
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Wed, 20 Oct 2021 09:27:25 -0700
Message-ID: <163474724511.2607444.1876715711451990426.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove setting of wq type on guest kernel during configuration load on RO
device config. The user will set the kernel wq type and this setting based
on config is not necessary.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index d9fae447b8bb..fab412349f7f 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1040,8 +1040,6 @@ static int idxd_wq_load_config(struct idxd_wq *wq)
 
 	wq->size = wq->wqcfg->wq_size;
 	wq->threshold = wq->wqcfg->wq_thresh;
-	if (wq->wqcfg->priv)
-		wq->type = IDXD_WQT_KERNEL;
 
 	/* The driver does not support shared WQ mode in read-only config yet */
 	if (wq->wqcfg->mode == 0 || wq->wqcfg->pasid_en)


