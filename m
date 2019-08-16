Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B01AC8FB93
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2019 08:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfHPG4Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Aug 2019 02:56:25 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39649 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfHPG4Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Aug 2019 02:56:25 -0400
Received: by mail-yb1-f194.google.com with SMTP id s142so1654571ybc.6;
        Thu, 15 Aug 2019 23:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4ztm7/zVpVkuXSHNsVBdpX0tZryq84sGebRCqDN6Oec=;
        b=hx6jhblNg9LydZ/U24XFVjMR70NOyb11+aLRqUxCEi03E6fDjEK+TV5PSm26Vq2rkG
         cozbT48eiJFf4/nyGKhi8Phd8Vi+nOC7yVyMfXPK6kiPZzAXrteoZslp7xOYF6K+PgGZ
         Lq60PTACwaRFhoU7phlh+bKLMKkT7cCrhYI6P62+Y2g6QK6xTzbfbSDoezs+TAifgHs6
         T2nOAK/tiLPHtdh0Xm4g1rI8SxVxd/rbmjTMLAzATZ7iivmQTQGtQqXLUcVV8pzQwdsU
         lvxBrNDx3/EWV4f1TkEXjTxXfQqUdy5oFys/J8jyHZoQa+vCisLUkn852/SWCLXOiWlz
         262w==
X-Gm-Message-State: APjAAAWXAeuLs9NNUmbbYqsEd/GTG20fQKqgkjfIlg9R8eyMLI9tZh1z
        hsHVbqjHHHoBRZAxOUN+Asc=
X-Google-Smtp-Source: APXvYqzqTXvd0kb83aAhFrkE+7i2v5nGMBvGmG5Qy7Gq01EuafDOOHKK7E2mK/UYebijbK/PpjXX8A==
X-Received: by 2002:a25:7057:: with SMTP id l84mr6026642ybc.340.1565938584444;
        Thu, 15 Aug 2019 23:56:24 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id v203sm1099740ywa.99.2019.08.15.23.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 23:56:23 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE
        SUBSYSTEM), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dmaengine: ti: omap-dma: Add cleanup in omap_dma_probe()
Date:   Fri, 16 Aug 2019 01:56:08 -0500
Message-Id: <1565938570-7528-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If devm_request_irq() fails to disable all interrupts, no cleanup is
performed before retuning the error. To fix this issue, invoke
omap_dma_free() to do the cleanup.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/dma/ti/omap-dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index ba2489d..5158b58 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1540,8 +1540,10 @@ static int omap_dma_probe(struct platform_device *pdev)
 
 		rc = devm_request_irq(&pdev->dev, irq, omap_dma_irq,
 				      IRQF_SHARED, "omap-dma-engine", od);
-		if (rc)
+		if (rc) {
+			omap_dma_free(od);
 			return rc;
+		}
 	}
 
 	if (omap_dma_glbl_read(od, CAPS_0) & CAPS_0_SUPPORT_LL123)
-- 
2.7.4

