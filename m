Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402033F874F
	for <lists+dmaengine@lfdr.de>; Thu, 26 Aug 2021 14:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbhHZMZt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Aug 2021 08:25:49 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:39816
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240725AbhHZMZt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Aug 2021 08:25:49 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D43033F051;
        Thu, 26 Aug 2021 12:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629980700;
        bh=s+hrSkGmeiLA9/GhpGpUgimq/yCOJD7q2NZj6bIs8Go=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=em2kgWn3xT3trjNWtti14jeqDNC1cJ5v1/l14oomj6FMht9ct/DSe7AyP880XB8V5
         MawUkYO+Fe9zVq8ixNxTHlwCeAXhmU/LAEp59SA6M2PQyyuhA8ShAaBa060ydnE8FA
         rkFoQAWyu2IW/L/XJ5mMOLUIOTJBkCfy66sPLC/HVnvjjUGDNIqbdLLyCUzD51T1Ji
         BYsWF/AujgPSHq7vAXqUqRyktm25hvM/jiks+Iez0K80JqZtpnjQcbxYYNPmhX3ng4
         DzPCr2ZIGYh8QdApHuAz2xfS2rP6ZMEDN/pVGwTCXrR/ELwTn6OfU+nm2AAlWgKEuT
         VZKWWtFlTXBJQ==
From:   Colin King <colin.king@canonical.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Baokun Li <libaokun1@huawei.com>, dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: fsl-dpaa2-qdma: Fix spelling mistake "faile" -> "failed"
Date:   Thu, 26 Aug 2021 13:25:00 +0100
Message-Id: <20210826122500.13743-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
index a0358f2c5cbb..8dd40d00a672 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -701,7 +701,7 @@ static int dpaa2_qdma_probe(struct fsl_mc_device *dpdmai_dev)
 	/* DPDMAI enable */
 	err = dpdmai_enable(priv->mc_io, 0, dpdmai_dev->mc_handle);
 	if (err) {
-		dev_err(dev, "dpdmai_enable() faile\n");
+		dev_err(dev, "dpdmai_enable() failed\n");
 		goto err_enable;
 	}
 
-- 
2.32.0

