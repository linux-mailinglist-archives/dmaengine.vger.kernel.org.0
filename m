Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2B37230DA
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jun 2023 22:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjFEUQJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Jun 2023 16:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjFEUQF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Jun 2023 16:16:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EF7114;
        Mon,  5 Jun 2023 13:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685996163; x=1717532163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yPVyZBdMFSkLLY+neCVq3Ouyo7u0i8a/xzk2t6QMfsQ=;
  b=T0y7Ri0V+Q+486Rp2tqiscl8Eov5qVYRCQMo/imVrw5St9OQ5qO95D7V
   xO0tI68wFYp1duWuRg0kJ1g95jPOj9AH+JA41eD3VtzPv9N6DfmMpo0TC
   5ELlcu4aRzVpUIyYv4Sw260j1cBzJnVpIDAg5krt0Yvb/rERT2mrpD2qi
   6TWWluRmxbr9xhC12D+Z2yJ3ZsMDyHMaSdU2TEXN3C+cjPFejkBxJgnnG
   hV5t3kEHoNmjNI9YZEp2e/0L3U57oYU653t+8YC3tAJ8pVrcGVgHa5zh1
   3Zb8TE699Uo0iaL0F0dR+5v0xdHZvoDz9VgPE4KDlFvUkbfAkvWPTvm2z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="356480367"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="356480367"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:15:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="711934425"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="711934425"
Received: from rkbrewer-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.33.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:15:50 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v6 06/15] dmaengine: idxd: Add wq private data accessors
Date:   Mon,  5 Jun 2023 15:15:27 -0500
Message-Id: <20230605201536.738396-7-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201536.738396-1-tom.zanussi@linux.intel.com>
References: <20230605201536.738396-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the accessors idxd_wq_set_private() and idxd_wq_get_private()
allowing users to set and retrieve a private void * associated with an
idxd_wq.

The private data is stored in the idxd_dev.conf_dev associated with
each idxd_wq.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/dma/idxd/idxd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 276b5f9cf967..971daf323655 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -609,6 +609,16 @@ static inline int idxd_wq_refcount(struct idxd_wq *wq)
 	return wq->client_count;
 };
 
+static inline void idxd_wq_set_private(struct idxd_wq *wq, void *private)
+{
+	dev_set_drvdata(wq_confdev(wq), private);
+}
+
+static inline void *idxd_wq_get_private(struct idxd_wq *wq)
+{
+	return dev_get_drvdata(wq_confdev(wq));
+}
+
 /*
  * Intel IAA does not support batch processing.
  * The max batch size of device, max batch size of wq and
-- 
2.34.1

