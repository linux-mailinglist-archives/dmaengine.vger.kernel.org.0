Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D81456867C
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 13:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiGFLNj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 07:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiGFLNh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 07:13:37 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F127B10
        for <dmaengine@vger.kernel.org>; Wed,  6 Jul 2022 04:13:36 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id b5so7216527vkp.4
        for <dmaengine@vger.kernel.org>; Wed, 06 Jul 2022 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sn6sI+0kScuiPGogiv47ctlORF5lu4dbA1RLsvEvQDM=;
        b=B0O5fEeDymFA/Ff9nGLdnWsYOrRm9HZNH7N3IDHbWOQJpU4iWp+K5puWvETKXKVIWq
         o4MqKNyF2H5nt2hEJfKmG8pZkOfQhgCcz4gLeB4c0Lcch+C3VN9XhPNz3xORsxQ3ApoE
         WTb8iqOR+jvtg7n95nTYjRUIemYVPZKg0AiHZauY3KxdGGKdRJwxvRBqLHyMyPnvbIix
         MmOLQGAOJf8qYdo0GuG/WrtbRZqx5e/N+ka5+DMTgBr8it5fmnkflknBFkf+Wt8fFS78
         /tM1LAboOH4mI31v0gyQ2icodRSrfzRMBY1INMzW73Uy7uk9j6fjSHSdgaWDah12Vxfg
         gj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sn6sI+0kScuiPGogiv47ctlORF5lu4dbA1RLsvEvQDM=;
        b=kKZA3qeRpElCS0L4cWCv8w5Acnd1ZlDlNbdZYo2+GkXS0FIf9y3mp8Cb0WR/I/U+Qq
         UWHP45ldqB0Ry5TOYsu7V6ioK7Z1Wzmf7XPZVuioCFolKmaEoIcWUMYk9ewf7YPelsyd
         Pnu/gGi46mKgnB+tkFi3DqztvmGEW91y0WAHa+hiz0h7X2dSZ+ETygGfpFMM+YatELoe
         pjqrKrRJsrg55yJ0AWHQznlQra6LnzdhvMH2jzXKeoB4Z//DIhabB7XVje5ROAt/+s0c
         VMf3DhLSgGwyHpjrECE0wl7cswV+uZXQ6pKnttyusH/3yQeAiKshpqbKF0QHnTyfIjUQ
         804w==
X-Gm-Message-State: AJIora+OWpBrBS8n1Bjy60h3fZyx1WuULV49V/WuuFphtyohhWzTQluo
        qkquBhQT6job5bLqd4z2+5h+k8wzUa10tQ==
X-Google-Smtp-Source: AGRyM1tOU9K3boQB8ZBg7aNVQnTWPlBcv+NwmG+HI+oURMABj0iVLk3pRuLKVcQEVX1MWIHQ93SlLw==
X-Received: by 2002:a1f:38cb:0:b0:374:1ce7:5fe with SMTP id f194-20020a1f38cb000000b003741ce705femr3793598vka.34.1657106015712;
        Wed, 06 Jul 2022 04:13:35 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:485:4b69:43e8:395e:576b:2b96])
        by smtp.gmail.com with ESMTPSA id f185-20020a1f51c2000000b0036c691b1ea8sm8414945vkb.33.2022.07.06.04.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 04:13:35 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] dmaengine: imx-dma: Cast of_device_get_match_data() with (uintptr_t)
Date:   Wed,  6 Jul 2022 08:13:27 -0300
Message-Id: <20220706111327.940764-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Change the of_device_get_match_data() cast to (uintptr_t)
to silence the following clang warning:

drivers/dma/imx-dma.c:1048:20: warning: cast to smaller integer type 'enum imx_dma_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 0ab785c894e6 ("dmaengine: imx-dma: Remove unused .id_table")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Improve the Subject to describe the change and not the effect of
the change. (Vinod)

 drivers/dma/imx-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 3bffe3ecbd1b..65c6094ce063 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -1047,7 +1047,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	imxdma->dev = &pdev->dev;
-	imxdma->devtype = (enum imx_dma_type)of_device_get_match_data(&pdev->dev);
+	imxdma->devtype = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	imxdma->base = devm_ioremap_resource(&pdev->dev, res);
-- 
2.25.1

