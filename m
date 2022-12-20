Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F60651A92
	for <lists+dmaengine@lfdr.de>; Tue, 20 Dec 2022 07:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiLTGSD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Dec 2022 01:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiLTGSC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Dec 2022 01:18:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71031BF62;
        Mon, 19 Dec 2022 22:18:01 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so15484524pjp.1;
        Mon, 19 Dec 2022 22:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sV3GdJRgw7ANtPiQXbnToVWO7ur10T1KkZZv0V5kzic=;
        b=ETUoe0DUHMPzx8IcF3aR9TtpmS3nzPbdSIGGDg6iWm8vTQ4ERpEfDr5bEUV13UZtOa
         loiZsYnSfgi/EihBYGcBeR4Jra9efQwnUcgGc0ak7ERPCJbR2JjA1s2wpfj9ypsgToOL
         aX3yRUmvBneXCEfuMawM7lBNpy2vvqWbVuW7BnbMHmiypvjcuXHJMo7ZxV1cQf3ZPLEX
         wb2ZwiNxkRuydjJxDva7NgsdZTrDpruAcaCY9jwWXbPf6+oBh80+vJ76iHJ6Z8mYfwG+
         TGlTh0QNLNXegahIJUZZjfIV2wfPfFqS88PCZiGxIdGLhq8NKAyZorf3QPrxXZKU6kg7
         QsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sV3GdJRgw7ANtPiQXbnToVWO7ur10T1KkZZv0V5kzic=;
        b=6jbuyH6v2XSe8+cmiYLPnYu/qX3+z1QVfNDHQnXMrRx5ehnONYnrvMhW7pWPtguJwE
         y69+cN73fMP0GXccbSsJAkGV90FrdI0fCY0iBSUsnziQY3QE0Ntkhv9qhXK4HCW/6uuS
         7YfBDgpJ8zuJ0EFGSuu0P14kcvm8oEbpth1QMchYM17Cx6D8UanaPxJ8V6SburKw9+vV
         Cr09ZMTxOEjWJiCMG//35vgl4rFiTlQdQ9KpyX3vbDhYJBFYl4+COE+PwMAnSvaqu3L7
         0whEWDr55UKai0hcTPl5h4BdmuO1v060PxBCfnb0EXhJV8sqz/Wn5EoD8zr2DEvGJb9z
         ry+A==
X-Gm-Message-State: AFqh2kpo0RPQsUiv+SJuB+Sl7JB1og/BFtu7RiMN7OdgqqNjjcdlwhuW
        jaXVH9T6j2fwvdP1NvJPE70=
X-Google-Smtp-Source: AMrXdXtd+0jy1nZvXObO4KWAlTvHzUuXn1E2PMZdsW5JDTMsQ/ZC9T2O6LWe2QxEFW5fIQgNowL3Hg==
X-Received: by 2002:a17:902:dccc:b0:190:f82e:8a21 with SMTP id t12-20020a170902dccc00b00190f82e8a21mr18065245pll.4.1671517080949;
        Mon, 19 Dec 2022 22:18:00 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id n10-20020a170902e54a00b0018b025d9a40sm8326021plf.256.2022.12.19.22.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 22:18:00 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Carpenter <error27@gmail.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] dmaengine: plx_dma: Fix potential double free in plx_dma_create
Date:   Tue, 20 Dec 2022 10:17:51 +0400
Message-Id: <20221220061752.1120381-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When all references are dropped, callback function plx_dma_release()
for put_device() will call kfree(plxdev) to release memory.
Fix the error path to fix the possible double free.

Fixes: 07503e6aefe4 ("dmaengine: plx_dma: add a missing put_device() on error path")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Please correct me if I make mistakes, thanks for your review.
---
 drivers/dma/plx_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
index 12725fa1655f..bce724ff4e16 100644
--- a/drivers/dma/plx_dma.c
+++ b/drivers/dma/plx_dma.c
@@ -546,8 +546,9 @@ static int plx_dma_create(struct pci_dev *pdev)
 	return 0;
 
 put_device:
-	put_device(&pdev->dev);
 	free_irq(pci_irq_vector(pdev, 0),  plxdev);
+	put_device(&pdev->dev);
+	return rc;
 free_plx:
 	kfree(plxdev);
 
-- 
2.25.1

