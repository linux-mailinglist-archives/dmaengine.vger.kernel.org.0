Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D38055ACDB
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jun 2022 00:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiFYWNp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 25 Jun 2022 18:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiFYWNp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 25 Jun 2022 18:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9710412D05
        for <dmaengine@vger.kernel.org>; Sat, 25 Jun 2022 15:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656195222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EbUPVrACrb5JazdoYAtaL55Q+DwnisM87pnjpaJYU4A=;
        b=JWinoNgyWoTrkp6muxkuUwxSV+33DcQ+GBZVzwq8hwsUD29LNvBKvukzi499Egw8S7ukqz
        v5pqSXORnUkui260iNkrLorTbtyzBLHDRoZS/rCCctmYoNhChfhTqrtv//FH3QN8qRhmtH
        U1m3mFfIKTLWjvALt9hcjCzoy2gK+dM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-J8IwCBHWONOMi9ZOj-iueQ-1; Sat, 25 Jun 2022 18:13:37 -0400
X-MC-Unique: J8IwCBHWONOMi9ZOj-iueQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76CD3811E75;
        Sat, 25 Jun 2022 22:13:37 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B93731121314;
        Sat, 25 Jun 2022 22:13:36 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] dmaengine: idxd: Only call idxd_enable_system_pasid if succeeded in enabling SVA feature
Date:   Sat, 25 Jun 2022 15:13:33 -0700
Message-Id: <20220625221333.214589-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

iommu_sva_bind_device requires that iommu_dev_enable_feature has been
previously called with IOMMU_DEV_FEAT_SVA, and succeeded. Without this
it is possible to run into a situation where you will dereference a
null pointer if the intel_iommu driver is not enabled.

Note: checkpatch didn't like the suggested addition of braces for the
      first arm of the "if (idxd_enable_system_pasid)" block.

Fixes: 42a1b73852c4 ("dmaengine: idxd: Separate user and kernel pasid enabling")
Cc: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/dma/idxd/init.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 355fb3ef4cbf..5b49fd5c1e25 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -514,13 +514,14 @@ static int idxd_probe(struct idxd_device *idxd)
 	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
 		if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA))
 			dev_warn(dev, "Unable to turn on user SVA feature.\n");
-		else
+		else {
 			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
 
-		if (idxd_enable_system_pasid(idxd))
-			dev_warn(dev, "No in-kernel DMA with PASID.\n");
-		else
-			set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
+			if (idxd_enable_system_pasid(idxd))
+				dev_warn(dev, "No in-kernel DMA with PASID.\n");
+			else
+				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
+		}
 	} else if (!sva) {
 		dev_warn(dev, "User forced SVA off via module param.\n");
 	}
-- 
2.36.1

