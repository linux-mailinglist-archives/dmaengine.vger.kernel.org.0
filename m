Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE175553C3
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 20:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377723AbiFVSx5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 14:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376945AbiFVSxr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 14:53:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FE9167E9;
        Wed, 22 Jun 2022 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655924026; x=1687460026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VlUd8xPPF+2RmdPfGjg1Rkn/e8F3oCkg6LjzT2/3Llk=;
  b=lAOCYAHSUuVBDa7N9oxyv41eqJ7xxePlpPRdcoK1f+kBa7OCjOwBE68L
   4rMf6hWv7QKU4sg6YJRrgYMeqOmdaL9ALdUKsZKlFW7cXRXo0p6IBHByB
   13RuYfCH77pMe48MGgTk0p+nL06diAsWYMw8Xg5CemZ60yi7Uz5Pp5bwi
   zdWDZ5yDdRrTpfZoQfxpXrGGvK+78+MHQfAKr38vIZu00vci4DziIN8Jr
   bHnAp5R8pAOCP4oJHrWzYXl8+YUJCg01BYz4XEu7ISi5gosJFJ81A3VaX
   tlk+Q2KaT5lwhkGWxWz0HQ8ki0xBwKYQ4V7OMh5iRx9s7hOKHl+Fi76Gq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260949227"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260949227"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 11:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="834264887"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2022 11:53:46 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        mporter@kernel.crashing.org
Subject: [PATCH v3 06/15] rapidio: Use dmaengine_async_is_tx_complete
Date:   Wed, 22 Jun 2022 11:53:42 -0700
Message-Id: <20220622185342.3043582-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Replace dma_async_is_tx_complete with dmaengine_async_is_tx_complete.
The previous API will be removed in favor of the new one.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 2cdc054e53a53..d4108ff2bb74c 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -597,8 +597,7 @@ static void dma_xfer_callback(void *param)
 	struct mport_dma_req *req = (struct mport_dma_req *)param;
 	struct mport_cdev_priv *priv = req->priv;
 
-	req->status = dma_async_is_tx_complete(priv->dmach, req->cookie,
-					       NULL, NULL);
+	req->status = dmaengine_async_is_tx_complete(priv->dmach, req->cookie);
 	complete(&req->req_comp);
 	kref_put(&req->refcount, dma_req_free);
 }
-- 
2.35.1

