Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF5D968281
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jul 2019 05:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfGODRb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 14 Jul 2019 23:17:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34395 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfGODRb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 14 Jul 2019 23:17:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so777160pgc.1;
        Sun, 14 Jul 2019 20:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aF4g/95JsdU94BtU3dUNZxklmtVOywGbbXwlWkP3bEw=;
        b=AIwQPJeW8q5cgrnpiKU3/rcJC4cWM0mD0TRh2AhbAKuuTHK9Ky05V+G9OjRBhm1bq7
         P3lG5WmWAhujTpKwkyqQFPRA5cKkN06Mp3lvBVABIxOtNSKkc+X3C8ctbtdtvx+OUUnS
         2yACjj2pmoqqeCn+r29ZJFswPGymFo8fx/k6WJ9rQzWHs3eZL0+18gPPgvHF7LLhKMgX
         LpvmGzMqzdQSdggMynJ0hg5dEiYNwHc1fOfRs9N94OcXgkLPDOUNlNhrzQF/39rOIJN6
         IwtGgeIMToWtMQTUb1HOrswIdbJzlwoe0nSY21deOuTdERhc8SmPnjPI4YgHXT2a5pmt
         Q3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aF4g/95JsdU94BtU3dUNZxklmtVOywGbbXwlWkP3bEw=;
        b=Q26A6V0Q31RWXoyikPQtKFxQMrqBaFLSt26V8LSUkxky9ZsQELpN4myKbbTyP5ykrK
         aiCPQwizvLilhd3puT6mkPyo5CKR4sRxgRoQ0/hsWl3jVlmoIZ4lGuF9pF0N/1AW/sSr
         KyDZ/7AnIKifXnsC44pr6KRWAkRBlh4tnAM6TOI7Y5+qIAlP2fkZ7ApRsGH+uEv88rd7
         InOTHUgzEj6TsfsFC7L/k0/SqTYCjf5qMbE0NvmbpYQrTO6RHO6l1fv640i/D/uk/yGZ
         momayGsG5jUmksiITJzVCOyVfsWJmrYig6FXCEEFHUUJHHuUDUJCN+omxhvNnCdB3RDm
         Sz+A==
X-Gm-Message-State: APjAAAW3XeEVLCJNwxSMqvXQGV3m0WWEb52x84bttIsM4b18S0EGBd7E
        YhOvC17tU4rBJzdZOcnfpkM=
X-Google-Smtp-Source: APXvYqyOe7zFXYz7ZSjmhhIOJzZrjismG1PRArYqe4qOQOu3/AyhmMPK2wwt0AqYDUsIUDfb78ZzRA==
X-Received: by 2002:a65:4103:: with SMTP id w3mr13523619pgp.1.1563160650409;
        Sun, 14 Jul 2019 20:17:30 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id u3sm13720277pjn.5.2019.07.14.20.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:17:30 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 04/24] dmaengine: qcom_hidma: Remove call to memset after dmam_alloc_coherent
Date:   Mon, 15 Jul 2019 11:17:23 +0800
Message-Id: <20190715031723.6375-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/dma/qcom/hidma_ll.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 5bf8b145c427..bb4471e84e48 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -749,7 +749,6 @@ struct hidma_lldev *hidma_ll_init(struct device *dev, u32 nr_tres,
 	if (!lldev->tre_ring)
 		return NULL;
 
-	memset(lldev->tre_ring, 0, (HIDMA_TRE_SIZE + 1) * nr_tres);
 	lldev->tre_ring_size = HIDMA_TRE_SIZE * nr_tres;
 	lldev->nr_tres = nr_tres;
 
@@ -769,7 +768,6 @@ struct hidma_lldev *hidma_ll_init(struct device *dev, u32 nr_tres,
 	if (!lldev->evre_ring)
 		return NULL;
 
-	memset(lldev->evre_ring, 0, (HIDMA_EVRE_SIZE + 1) * nr_tres);
 	lldev->evre_ring_size = HIDMA_EVRE_SIZE * nr_tres;
 
 	/* the EVRE ring has to be EVRE_SIZE aligned */
-- 
2.11.0

