Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C0F42AB71
	for <lists+dmaengine@lfdr.de>; Tue, 12 Oct 2021 20:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhJLSE2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Oct 2021 14:04:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:41540 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233376AbhJLSEU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Oct 2021 14:04:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="224657245"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="224657245"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 11:01:59 -0700
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="524323335"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 11:01:59 -0700
Subject: [PATCH] dmaengine: idxd: check GENCAP config support for gencfg
 register
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 12 Oct 2021 11:01:59 -0700
Message-ID: <163406171896.1303830.11217958011385656998.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DSA spec 1.2 has moved the GENCFG register under the GENCAP configuration
support with respect to writability. Add check in driver before writing to
GENCFG register.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 419b206f8a42..1e153725432e 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -793,7 +793,7 @@ static int idxd_groups_config_write(struct idxd_device *idxd)
 	struct device *dev = &idxd->pdev->dev;
 
 	/* Setup bandwidth token limit */
-	if (idxd->token_limit) {
+	if (idxd->hw.gen_cap.config_en && idxd->token_limit) {
 		reg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
 		reg.token_limit = idxd->token_limit;
 		iowrite32(reg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);


