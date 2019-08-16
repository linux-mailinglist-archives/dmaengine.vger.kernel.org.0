Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C0F8FADB
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2019 08:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfHPGXn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Aug 2019 02:23:43 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44236 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHPGXm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Aug 2019 02:23:42 -0400
Received: by mail-yw1-f65.google.com with SMTP id l79so1459063ywe.11;
        Thu, 15 Aug 2019 23:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kdbxFDHYGClUoNsZGKKPkP7v5sij1u1AQCARlCPuJqQ=;
        b=LbEPwmQELKI6lVvU5HXRMNCTD97aRYptdnIL5tWhGaFE3Ty4MljhgarlTjiqenA6R6
         j6blhWUa1VCtHpucFvdTcEvufym5+sKQIMfvCixRhIFrfApj79DcdK6z0OvV1jsye/Sq
         mB0vDXPM/3oqIb9eSAxHULytAtTktZkKPCUE6v4Ye8cjCwcJcAYWRhvNfyER1CUx1A81
         XWkdG7o/m+1/TwDF8r/nb4FVmwODbq1x8f0w/uxGMjQn8vGNAgWoC3r6+ENm0Kz0lR1i
         +KGSIgyDlGb+2IIsrcSlVTHw8D+VGSP4rbhDDmzwQN7aHpmsLcAQxPTyjm0TQgDGJI4D
         gdtQ==
X-Gm-Message-State: APjAAAXGauqwHA6ih05oQ+yA+jamOYb2eTfwD3YSzsAV51hg7pmpyTIX
        OQU8iuT8ukueVlgz/Xv/cZo=
X-Google-Smtp-Source: APXvYqywBfTJYmI15P2I8UPLwdkI1BGOYxCsoYU9qhLcPwi06K1nVH0hF6HjVX1PHxtVX678sm798w==
X-Received: by 2002:a81:4bc5:: with SMTP id y188mr5444262ywa.177.1565936621994;
        Thu, 15 Aug 2019 23:23:41 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id g68sm1102026ywb.87.2019.08.15.23.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 23:23:40 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE
        SUBSYSTEM), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dmaengine: ti: Fix a memory leak bug
Date:   Fri, 16 Aug 2019 01:23:21 -0500
Message-Id: <1565936603-7046-1-git-send-email-wenwen@cs.uga.edu>
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

