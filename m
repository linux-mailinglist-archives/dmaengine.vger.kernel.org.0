Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FDC8FB6A
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2019 08:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfHPGvF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Aug 2019 02:51:05 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37304 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPGvF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Aug 2019 02:51:05 -0400
Received: by mail-yb1-f194.google.com with SMTP id t5so1652368ybt.4;
        Thu, 15 Aug 2019 23:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kdbxFDHYGClUoNsZGKKPkP7v5sij1u1AQCARlCPuJqQ=;
        b=hyQfmnfVwg1btynZjNH8cbTaSw3bKRt13llq3+cZZlBUTlOhFW3DJGevhd7+o5Qeht
         NOXR+kr4PGIy1PuKAcHt61MWlX2k4jlOfuCqdErnd8F8jLg/ZqhMeLURuIFiB4oVIipJ
         HxPwp84MumH8uBoS75WDXxxv1xnRc7c6WWIoVdIng7aJcRQsvkVkCAtg/Rfq2F5kyuCC
         bmg1qYmdJBW0J7/cxdHCk0WW9zrRV2Q2oaTG3GcV82Fwpi+02yu90txjfx33FCHsBTsY
         iMYBNQHnJ5rgUUlbTJEnDD8u3v/KTcMTKuYmtnKRM/TJb21ImTLzQo5OKeTWKIZ9PgIs
         y9VQ==
X-Gm-Message-State: APjAAAX+sLns0dLUw3QiNCoCIOdSsBaVt369dpN2PaGaVp/PaY9GKNK5
        /xsqcvgGz13B+ixXsjY2kZA=
X-Google-Smtp-Source: APXvYqx7qv6sNlMv8Ng7PJwVPWgN80hMgpiZHYaquRvGJ0xUK4JDSFJEEj6Uvd8HKLWw3DJO1LQ/Og==
X-Received: by 2002:a25:2403:: with SMTP id k3mr6038461ybk.377.1565938264224;
        Thu, 15 Aug 2019 23:51:04 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id w65sm1102771ywa.57.2019.08.15.23.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 23:51:03 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE
        SUBSYSTEM), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] dmaengine: ti: dma-crossbar: Fix a memory leak bug
Date:   Fri, 16 Aug 2019 01:48:55 -0500
Message-Id: <1565938136-7249-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In ti_dra7_xbar_probe(), 'rsv_events' is allocated through kcalloc(). Then
of_property_read_u32_array() is invoked to search for the property.
However, if this process fails, 'rsv_events' is not deallocated, leading to
a memory leak bug. To fix this issue, free 'rsv_events' before returning
the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/dma/ti/dma-crossbar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
index ad2f0a4..f255056 100644
--- a/drivers/dma/ti/dma-crossbar.c
+++ b/drivers/dma/ti/dma-crossbar.c
@@ -391,8 +391,10 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
 
 		ret = of_property_read_u32_array(node, pname, (u32 *)rsv_events,
 						 nelm * 2);
-		if (ret)
+		if (ret) {
+			kfree(rsv_events);
 			return ret;
+		}
 
 		for (i = 0; i < nelm; i++) {
 			ti_dra7_xbar_reserve(rsv_events[i][0], rsv_events[i][1],
-- 
2.7.4

