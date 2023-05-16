Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76A87059D8
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 23:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjEPVuk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 17:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjEPVu1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 17:50:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97C47ED6;
        Tue, 16 May 2023 14:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684273821; x=1715809821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHOF6DrEvuRACHmnKROaRDudHiYk2POqQye99IoY3vM=;
  b=DLb/TldM6CCyNkdqcDD3XSBct+S8os0uDtSKzKwRpoj+ZPUQC+UiNMu9
   ERmWchyRetRRGtiqwvoe0VzKUGhlK7zEuzl88D8f7rgkXSWQ9hjX2ePEc
   l4Ni4L97byHaHLWY79ACI9Np28m9PS7M8gOrmM6dOADwWjL+mvy1e3Zar
   lC1esuLy9KIxiLXscDyfSI8jr61aki/p162kDDxSbz1u56J/H2RsJESar
   VYv8AHn3+cyVtbo+e0nY91MxiScXXXeEnGNYUv+n38TLwCei0q0UVDsT1
   ZV3FSOiTSI6r6CWzPCMIS6lxNyTFflUFrnFY+3ptaIiNkNFNYBFHOA+cD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="331961659"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="331961659"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 14:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="704564853"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="704564853"
Received: from fmunozug-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.83.116])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 14:50:20 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v5 04/15] dmaengine: idxd: Export descriptor management functions
Date:   Tue, 16 May 2023 16:49:58 -0500
Message-Id: <20230516215009.51794-5-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516215009.51794-1-tom.zanussi@linux.intel.com>
References: <20230516215009.51794-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

To allow idxd sub-drivers to access the descriptor management
functions, export them.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/submit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index c01db23e3333..5e651e216094 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -61,6 +61,7 @@ struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype)
 
 	return __get_desc(wq, idx, cpu);
 }
+EXPORT_SYMBOL_NS_GPL(idxd_alloc_desc, IDXD);
 
 void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 {
@@ -69,6 +70,7 @@ void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	desc->cpu = -1;
 	sbitmap_queue_clear(&wq->sbq, desc->id, cpu);
 }
+EXPORT_SYMBOL_NS_GPL(idxd_free_desc, IDXD);
 
 static struct idxd_desc *list_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
 					 struct idxd_desc *desc)
@@ -215,3 +217,4 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	percpu_ref_put(&wq->wq_active);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(idxd_submit_desc, IDXD);
-- 
2.34.1

