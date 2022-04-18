Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E76505F5D
	for <lists+dmaengine@lfdr.de>; Mon, 18 Apr 2022 23:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiDRVdx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Apr 2022 17:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiDRVdw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Apr 2022 17:33:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFE42D1C5
        for <dmaengine@vger.kernel.org>; Mon, 18 Apr 2022 14:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650317471; x=1681853471;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g/bNU13k/KdPPdBPg237jgtCfUARK6F2wDFt0mtjqnw=;
  b=cY6cmdh5uIUYX5ushPto/BynzsUHOEv2e+4oyEtgrsnYrywKOMn/DnRy
   608NgMIkN8E8ANdiT4W6eFgfVJ48ovuBtjG+f2KtAnngttu3rtr6/4TLp
   1aCvO4D1EFDoYKBKlSmNh6uL/DV17+yzX2jw6RPA7Xju0PIMzaC9JxQdr
   3Vw0b4nkkCKwOOttt4z/ID/Cf5hzxcubExygpUfgw8yIFOJ5zH6FWUNXX
   BeKp1ENO2xkMr1VZBczQQfpZ5ZVsujaPKYZK2ElovmE5xfK0K+ckOlbso
   VPZw9kkEkkN8FxYj61bfWuewukQPvh1QU365g6VJ7HTOofjoDM5NKh0k9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="250917565"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="250917565"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 14:31:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="529772984"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 14:31:11 -0700
Subject: [PATCH] dmaengine: idxd: match type for retries var in idxd_enqcmds()
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Thiago Macieira <thiago.macieira@intel.com>,
        dmaengine@vger.kernel.org
Date:   Mon, 18 Apr 2022 14:31:10 -0700
Message-ID: <165031747059.3658198.6035308204505664375.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

wq->enqcmds_retries is defined as unsigned int. However, retries on the
stack is defined as int. Change retries to unsigned int to compare the same
type.

Fixes: 7930d8553575 ("dmaengine: idxd: add knob for enqcmds retries")
Suggested-by: Thiago Macieira <thiago.macieira@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/submit.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index e289fd48711a..554b0602d2e9 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -150,7 +150,8 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
  */
 int idxd_enqcmds(struct idxd_wq *wq, void __iomem *portal, const void *desc)
 {
-	int rc, retries = 0;
+	unsigned int retries = 0;
+	int rc;
 
 	do {
 		rc = enqcmds(portal, desc);


