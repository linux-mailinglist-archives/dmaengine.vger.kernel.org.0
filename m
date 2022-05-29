Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6085371E4
	for <lists+dmaengine@lfdr.de>; Sun, 29 May 2022 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiE2RZ7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 May 2022 13:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE2RZ6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 May 2022 13:25:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A2C8B0BB;
        Sun, 29 May 2022 10:25:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ck4so16915246ejb.8;
        Sun, 29 May 2022 10:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=c26ugHmy9ja09gODy1exjCAJZkRaLqeGGMgK0d4WQcg=;
        b=ZFJmfeQvAhPOCjatFFKnRUGMp8iCahLd6WSdmD5FUTjXGN7tkiFEZdcqVIA4GJUaqA
         jHfAbrr2UUw3Q+q2LOhcox4xgpmPmrJS7iuyZTXCCPu8QGto0dNbwV9Fm95owLLAWtsP
         UHuzSP30aaWhX189vTU9t885tQQ7GfnGCJmIqWuf4pfE9RXPjkYffkZL2FlZiunJHwri
         RGX2pEJGFy93CeumJNQ69bgJ8WtZgLv/C9JO2AXkSprPxPf/DqsBHrsUWyDPcql3KRyd
         v09P25eV7hIlfPUxFeSAyQVRNS/BL0Z5XM9Rs6yoy3Nc53mE7O4HTLQ+qZy4T4ghqXQu
         cQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=c26ugHmy9ja09gODy1exjCAJZkRaLqeGGMgK0d4WQcg=;
        b=DfH8BTAx4zy2tauYWkGnbxd4TngB1kEwWeWBJgbZQcOKOu7r/TFn+C+9lTmRVTbfGl
         5Q66QX8vIsgE8a+zOu7ueMyw/mjC5XT8LfL44EVMx8IFHz5XYH7NOsdLUTMQaryRw8wT
         RBYbD64MKtrmRYjPx9HbihmZIKhqY83HWcbZ1YiwF20udVYb5CL+gTIPq6L1+jXy/Y5C
         7++baOIlPXMDNzozoz5PIRf1O6o6YCRRlN0hwK4uEQk/deb3UEeLhOcnAvwADgpFem/n
         rY64VErTruzhxgkNyTpzUKrjU4eLSKZRDHhXCo6Vdsxw0QoYwWZiyV7ykYOUkTPbYBJ5
         iOuQ==
X-Gm-Message-State: AOAM53317fXKMIxX90KjxYV6gGjR9m1r+qquyzJ0Ki+GA+s+Sks6AlfF
        AFclQhUeLfr0lvPKXFEIHWn2ovYtZ+k=
X-Google-Smtp-Source: ABdhPJzfJaUCG0pdd92/vCJJjNTP1hoYXzeY00nShQGNz6yTDcl4DPVLmAW45Wwxv2UrpbYm9H7Yow==
X-Received: by 2002:a17:907:7d86:b0:6ff:1598:b049 with SMTP id oz6-20020a1709077d8600b006ff1598b049mr19001426ejc.637.1653845156089;
        Sun, 29 May 2022 10:25:56 -0700 (PDT)
Received: from nam-dell ([2a02:8109:afbf:ed88:435:610d:d1eb:dc05])
        by smtp.gmail.com with ESMTPSA id x12-20020a50d60c000000b0042bced44061sm5141339edi.10.2022.05.29.10.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 10:25:55 -0700 (PDT)
Date:   Sun, 29 May 2022 19:25:54 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     olivier.dautricourt@orolia.com, vkoul@kernel.org, sr@denx.de
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: altera-msgdma: correct mutex locking order
Message-ID: <20220529172554.GA22554@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The order of spin_unlock and spin_lock seems wrong. Correct it.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/dma/altera-msgdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 6f56dfd375e3..e35096c12abc 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -591,9 +591,9 @@ static void msgdma_chan_desc_cleanup(struct msgdma_device *mdev)
 
 		dmaengine_desc_get_callback(&desc->async_tx, &cb);
 		if (dmaengine_desc_callback_valid(&cb)) {
-			spin_unlock(&mdev->lock);
-			dmaengine_desc_callback_invoke(&cb, NULL);
 			spin_lock(&mdev->lock);
+			dmaengine_desc_callback_invoke(&cb, NULL);
+			spin_unlock(&mdev->lock);
 		}
 
 		/* Run any dependencies, then free the descriptor */
-- 
2.25.1

