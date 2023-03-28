Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BB86CC685
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 17:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjC1Pf6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 11:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjC1Pfz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 11:35:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC754C2;
        Tue, 28 Mar 2023 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680017749; x=1711553749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OtM3rn2qVNEodUF6b7WwLHWyrC+y34N0YmCPeW0BQzE=;
  b=MX/iuQ7dPJ5EHFlQZhQqyE3ANrFpwUra10CdAmTzjTeYlbOAgf9dLuPH
   zDb2OgZvwyMYgnpP/mKyC2tvFqhXO/n6fNI3o+wJrmzxJ2u3sVyExB0AW
   paqcUBj/s8KVZHS+HDv6gEbBuXP7lkeHoBc3Z5vQomBI4Dqtf8pnEzag4
   haEpTQZsB2D8llrpn3e7hAThjnMd4MehSc/bgu5dk+t4xvPS+raKfd0M+
   XINEI8w05zKC2OCzXKcOLlbZvE4285kLH4W3tf+wAcutvSOeXxI6Of3+G
   s+cr2lQUEdDM952aeC2QzoHoQB+93UjbErZdI//CUuNROMBLkcCjmSp3c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="342192048"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="342192048"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:35:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="683948300"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="683948300"
Received: from sdwarak1-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.127.200])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:35:46 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v2 03/15] dmaengine: idxd: Export drv_enable/disable and related functions
Date:   Tue, 28 Mar 2023 10:35:23 -0500
Message-Id: <20230328153535.126223-4-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328153535.126223-1-tom.zanussi@linux.intel.com>
References: <20230328153535.126223-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

To allow idxd sub-drivers to enable and disable wqs, export them.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/dma/idxd/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5f321f3b4242..af1aa88a66c1 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1406,6 +1406,7 @@ int drv_enable_wq(struct idxd_wq *wq)
 err:
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(drv_enable_wq, IDXD);
 
 void drv_disable_wq(struct idxd_wq *wq)
 {
@@ -1427,6 +1428,7 @@ void drv_disable_wq(struct idxd_wq *wq)
 	wq->type = IDXD_WQT_NONE;
 	wq->client_count = 0;
 }
+EXPORT_SYMBOL_NS_GPL(drv_disable_wq, IDXD);
 
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 {
-- 
2.34.1

