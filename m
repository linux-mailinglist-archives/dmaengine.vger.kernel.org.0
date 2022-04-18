Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7309505F62
	for <lists+dmaengine@lfdr.de>; Mon, 18 Apr 2022 23:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiDRVgC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Apr 2022 17:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiDRVgC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Apr 2022 17:36:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AFE2D1C5
        for <dmaengine@vger.kernel.org>; Mon, 18 Apr 2022 14:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650317602; x=1681853602;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hGvF5V2W4+Hlau81kRm0GGiso/dOyKHlMQRV1ixJ8gU=;
  b=I8MYEpVGGc+QolFbYws9G40o28aMwz9s/UoVzHNelAcATQ6Nba7uxKW0
   jrIVSpIz2w5eCx9JYijMlPMm/KGsRZD4p/Q9MyyX5Or/zNUMCnWohYHBE
   SQF4zIYs+bam2A2iuAPRG8I6eKuv1XZ4DclJ80gVg8cYuli+fOp+pqXYP
   udz6Sztkse4KXxtjZaazNOg8Ael+2Zqn2DN968pzvUGmgWFYSWi7+gQIq
   iz3knn/fz0m9300MvxTKW3u8HBhTXsolV9Sl4pV4yKcpBsU4UAWzJBaGF
   xWH5O8Vfh8qZmOUNSoHgMdifS/jrPSQIF6npV1DdHziWlcIyjf+Q5LS4S
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="350064630"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="350064630"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 14:33:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="665535403"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 14:33:21 -0700
Subject: [PATCH] dmaengine: idxd: fix retry value to be constant for duration
 of function call
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>, dmaengine@vger.kernel.org
Date:   Mon, 18 Apr 2022 14:33:21 -0700
Message-ID: <165031760154.3658664.1983547716619266558.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When retries is compared to wq->enqcmds_retries each loop of idxd_enqcmds(),
wq->enqcmds_retries can potentially changed by user. Assign the value
of retries to wq->enqcmds_retries during initialization so it is the
original value set when entering the function.

Fixes: 7930d8553575 ("dmaengine: idxd: add knob for enqcmds retries")
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/submit.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 554b0602d2e9..c01db23e3333 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -150,7 +150,7 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
  */
 int idxd_enqcmds(struct idxd_wq *wq, void __iomem *portal, const void *desc)
 {
-	unsigned int retries = 0;
+	unsigned int retries = wq->enqcmds_retries;
 	int rc;
 
 	do {
@@ -158,7 +158,7 @@ int idxd_enqcmds(struct idxd_wq *wq, void __iomem *portal, const void *desc)
 		if (rc == 0)
 			break;
 		cpu_relax();
-	} while (retries++ < wq->enqcmds_retries);
+	} while (retries--);
 
 	return rc;
 }


