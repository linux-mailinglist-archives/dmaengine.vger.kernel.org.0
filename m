Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D6D750FE2
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 19:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGLRor (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 13:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjGLRoo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 13:44:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F7C1FE1;
        Wed, 12 Jul 2023 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689183882; x=1720719882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Hsd5zirctSI+8W68udbD0g6eNW2VbZCTcPq+MQAM9k=;
  b=RhpNfr2gnpiyjifZYDLAnKUzueAlKfMh8Q+wthS4hnBmmiEJaU2WkULr
   MrFlhQ88FSQV9wNCJ5D15bukUc5RGLkv4GKXz0cuK951FKvsyI5br0zjW
   OpZaBTyUzNQbFUl4IpbmQX5KX+wrKfuIixstjr5XAYojuGBv8xYyITeEG
   aCixd5qK98tf/mwJO1KfyFxXsPv7/ziQiNfywbcKDxr6XLIsUOpii9ygz
   zeE1IR7a9W4iGfQrG7KSlzc2rHSqYP5QZmQCqBm/vn/FmvvjZRsf4pQZU
   H4W+XtvCSUuVwurKycQ2jOiYc7i89C+xj7kT0b6sme3E4TCiuOhmJQcR7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="363828275"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="363828275"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 10:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="811671702"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="811671702"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jul 2023 10:44:40 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 2/2] dmaengine: idxd: Expose ATS disable knob only when WQ ATS is supported
Date:   Wed, 12 Jul 2023 10:44:36 -0700
Message-Id: <20230712174436.3435088-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230712174436.3435088-1-fenghua.yu@intel.com>
References: <20230712174436.3435088-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

WQ Advanced Translation Service (ATS) can be controlled only when
WQ ATS is supported. The sysfs ATS disable knob should be visible only
when the features is supported.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/sysfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 388fba7c85f8..7c317367226d 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1088,16 +1088,12 @@ static ssize_t wq_ats_disable_store(struct device *dev, struct device_attribute
 				    const char *buf, size_t count)
 {
 	struct idxd_wq *wq = confdev_to_wq(dev);
-	struct idxd_device *idxd = wq->idxd;
 	bool ats_dis;
 	int rc;
 
 	if (wq->state != IDXD_WQ_DISABLED)
 		return -EPERM;
 
-	if (!idxd->hw.wq_cap.wq_ats_support)
-		return -EOPNOTSUPP;
-
 	rc = kstrtobool(buf, &ats_dis);
 	if (rc < 0)
 		return rc;
@@ -1316,6 +1312,9 @@ static umode_t idxd_wq_attr_visible(struct kobject *kobj,
 	if (idxd_wq_attr_invisible(prs_disable, wq_prs_support, attr, idxd))
 		return 0;
 
+	if (idxd_wq_attr_invisible(ats_disable, wq_ats_support, attr, idxd))
+		return 0;
+
 	return attr->mode;
 }
 
-- 
2.37.1

