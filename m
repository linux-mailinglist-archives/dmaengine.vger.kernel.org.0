Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB73D1AB7E8
	for <lists+dmaengine@lfdr.de>; Thu, 16 Apr 2020 08:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407923AbgDPGYB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Apr 2020 02:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407332AbgDPGX5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Apr 2020 02:23:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272AFC061A0C;
        Wed, 15 Apr 2020 23:23:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g2so999433plo.3;
        Wed, 15 Apr 2020 23:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k9LiR9gqBCcCZdNQq4/YQxuQV5mvCYKBntiHSmfOytk=;
        b=hmhHjntthZH7KFvuW/uCALSyrDaaZpjaURcbC1eWuZMaO/14HeEKZjksmWnkPw86qP
         RwhRYDHjFfELQ1N77QeliUg4AKNXsdgS1gJVGunUKpARc6C1g7NUEmFfYx2SQ2+tVL5V
         kX7pcDrYBDPxYNwfRtiKoi103cX8L991eZey7IoOSqCK9XbRvk+W9LgXEydGNzKNnICP
         3HGyw/F+BC+u87V2vXZYhHCRmW7iX4HOyjs7e/GCt0zU5Oha+YUHdOZaKN9atjXhv0Qd
         LjnIFYJ6Xo1yz0RT+XTkGJNVps8+WkaJux61hW/XAIBLY2sS+r09gagZE7MqhtDZAs/F
         g7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k9LiR9gqBCcCZdNQq4/YQxuQV5mvCYKBntiHSmfOytk=;
        b=hayXNpWYcuY/s+nhLCRNXI133AabRGf47tCF3UkOcKqUGFIqMs7v6Lpk83inZGPVeu
         Q8/8JpO8Dvy9NhAkRfi13e7IYvfr+KosVc42mPrjvbLwgc+VHIg0v72HCn/wo0qT6c1y
         xAaAe3EBRc7gfto3BpKXlmWXr/7YHq4Nt+4GE4keBgruT42LG7KOsrlCi6Z7t4hpLxsM
         n7PEw4zgsgAsojXIT/BqHQGI+YuVBvJ/ebpviZ+I9s9wEIOs85eUmLmdKf1CsK8Sn5Mc
         +SfPe3ZbVZ22iKi3mj+5pKLwvvUmU09mQAuXU5PxPODWt/YAedvy6SPTNqnxe+Bp/oGF
         /2YQ==
X-Gm-Message-State: AGi0PuY1ziIEVLIfAghJlyhzpzVlOP8pCqnyx0UUAHFpJvh3pM0OsYzx
        4Mvp99q429n2XNdU6c9b4g==
X-Google-Smtp-Source: APiQypKaVK5tHJIcKhm+h8B/y2dD4tsICDzX+exf1e1PqrpGq2QKMRt2sf3yVpSSWLw0bNTdtafcMQ==
X-Received: by 2002:a17:902:9f95:: with SMTP id g21mr8282218plq.66.1587018234586;
        Wed, 15 Apr 2020 23:23:54 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:13bf:b0b1:dcfd:f4e2:a41f:9129])
        by smtp.gmail.com with ESMTPSA id u13sm1501463pjb.45.2020.04.15.23.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 23:23:53 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrianov@ispras.ru, ldv-project@linuxtesting.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] drivers: dma: pch_dma.c: Avoid data race between probe and irq handler
Date:   Thu, 16 Apr 2020 11:53:35 +0530
Message-Id: <20200416062335.29223-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

pd->dma.dev is read in irq handler pd_irq().
However, it is set to pdev->dev after request_irq().
Therefore, set pd->dma.dev to pdev->dev before request_irq() to
avoid data race between pch_dma_probe() and pd_irq().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 drivers/dma/pch_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index 581e7a290d98..a3b0b4c56a19 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -865,6 +865,7 @@ static int pch_dma_probe(struct pci_dev *pdev,
 	}
 
 	pci_set_master(pdev);
+	pd->dma.dev = &pdev->dev;
 
 	err = request_irq(pdev->irq, pd_irq, IRQF_SHARED, DRV_NAME, pd);
 	if (err) {
@@ -880,7 +881,6 @@ static int pch_dma_probe(struct pci_dev *pdev,
 		goto err_free_irq;
 	}
 
-	pd->dma.dev = &pdev->dev;
 
 	INIT_LIST_HEAD(&pd->dma.channels);
 
-- 
2.17.1

