Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25EB5244CB
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 07:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbiELFS0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 01:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242790AbiELFSY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 01:18:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ED318C06D;
        Wed, 11 May 2022 22:18:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so3900079pjq.2;
        Wed, 11 May 2022 22:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1AQXk6YcsqGT6AZ+v5JCyurVPXvqkymIH55yTG/A3eU=;
        b=c4XbLJExL24lVduVaKZbo3JXp16pMcuqHtm+S6s8epmqQBy+6+ronYZOvOHbS4+/ds
         JUJmUFC1sZ0Az/UXjgllV9wcwhlAeXGx/4hBd6pbOtgn2veRZBDG2gGCteKtnveYn4Tp
         OPlp6hSkcnWR5KwF/OGocWc4HckoPwcBdE88RACKV62nbbGbL+AeGLNJZ7+kdAE/D4WG
         n+F3Hzztytq3MsZG6tDaXTq6nslw6FW+Bo5ODoSRj2Z3idf/9xv/S5XwUnq4W96k3Dch
         G8tnCyRtoCSa1MIATCXZlRmimMbHzr4qrdfpb87sHbnSnY62bJseaLdiB1QTn9bN3+VF
         d3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1AQXk6YcsqGT6AZ+v5JCyurVPXvqkymIH55yTG/A3eU=;
        b=4burRoblwZqTM7TYNbGGIMMIL1nAUVEyE5RK1qBwNh6ZIpSwOR5OdmwMIq+muZ0+RU
         6y9/GIoF8o6XVRPPR7A3m8E3+JRh4EYabNWtzVpzp0un88oeU+9MwRlRCNLC9GB03pOf
         z0k15L6LeJJKi5ujWVyGP44Z1exyhRXhdEbadBeiQ6d/cdn95BWKZhYxE7dR2b4WHdH0
         igQiecRJ8i0Wzvt8o2r3OsXMEGbRhYgUPH2wrwa3f9iOPAZiySZ98tGISG8qBAcpU32h
         XFoZ73RWfdw+H3XUO1CQdyzfIu4jSdNlGCMvhtXnGrpfOPdiFTR5V+w40xXXBkmaV4Xl
         qlcg==
X-Gm-Message-State: AOAM533Z8/VnL6JbDN1V2m5+T6zr45vw9AWNsIzwUsAKnrbO8NbKOqu4
        H63QK0NzQ+wcB03d5DFuULVKGiJg4BhEsfisp4s=
X-Google-Smtp-Source: ABdhPJy8usYAOKkyscc+PdxY19NHkSQ7NQZnqgW7jH9hOw/0P1A8c6rItZ0zRup4bEnRj2R/IPAjiw==
X-Received: by 2002:a17:902:c14a:b0:15b:9c29:935a with SMTP id 10-20020a170902c14a00b0015b9c29935amr28603418plj.2.1652332702851;
        Wed, 11 May 2022 22:18:22 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id c17-20020aa78811000000b0050dc7628135sm2786675pfo.15.2022.05.11.22.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 22:18:22 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] dmaengine: ti: Fix refcount leak in ti_dra7_xbar_route_allocate
Date:   Thu, 12 May 2022 09:18:15 +0400
Message-Id: <20220512051815.11946-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

1. of_find_device_by_node() takes reference, we should use put_device()
to release it when not need anymore.
2. of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not needed anymore.

Add put_device() and of_node_put() in some error paths to fix.

Fixes: ec9bfa1e1a79 ("dmaengine: ti-dma-crossbar: dra7: Use bitops instead of idr")
Fixes: a074ae38f859 ("dmaengine: Add driver for TI DMA crossbar on DRA7x")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/dma/ti/dma-crossbar.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
index 71d24fc07c00..f744ddbbbad7 100644
--- a/drivers/dma/ti/dma-crossbar.c
+++ b/drivers/dma/ti/dma-crossbar.c
@@ -245,6 +245,7 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 	if (dma_spec->args[0] >= xbar->xbar_requests) {
 		dev_err(&pdev->dev, "Invalid XBAR request number: %d\n",
 			dma_spec->args[0]);
+		put_device(&pdev->dev);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -252,12 +253,14 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
 	if (!dma_spec->np) {
 		dev_err(&pdev->dev, "Can't get DMA master\n");
+		put_device(&pdev->dev);
 		return ERR_PTR(-EINVAL);
 	}
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
 	if (!map) {
 		of_node_put(dma_spec->np);
+		put_device(&pdev->dev);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -268,6 +271,8 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 		mutex_unlock(&xbar->mutex);
 		dev_err(&pdev->dev, "Run out of free DMA requests\n");
 		kfree(map);
+		of_node_put(dma_spec->np);
+		put_device(&pdev->dev);
 		return ERR_PTR(-ENOMEM);
 	}
 	set_bit(map->xbar_out, xbar->dma_inuse);
-- 
2.25.1

