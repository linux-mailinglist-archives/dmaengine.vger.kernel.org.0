Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5E55347B5
	for <lists+dmaengine@lfdr.de>; Thu, 26 May 2022 02:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244699AbiEZAyg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 May 2022 20:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238154AbiEZAyf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 May 2022 20:54:35 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0E3DFE4
        for <dmaengine@vger.kernel.org>; Wed, 25 May 2022 17:54:34 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-f16a3e0529so575296fac.2
        for <dmaengine@vger.kernel.org>; Wed, 25 May 2022 17:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=opm6FBfLkDZAgrNnJvYKE+wVNIsc9sZhKKnl1MD+KdQ=;
        b=KH13LPVGdr9OgBYz7NxONJ1VpCXrZDyUa9ppFpFLScIAZqkWRKf+DnNFFyYe4VqDeA
         IebLSIq4wLoU6GS/Zl6i6RnN7Guao6dIZMFJFOmwErxdKOHdOixsdPwgpi2TV9/tW81J
         vxxC/0gOP0A4OCIX+bfqP1njdRigQzME9AfmugPxQGzdWT6N3xJ+vRGl5DJHU3fHA/+r
         yX1fOV9+RXEvPveGw+BHv10jm8BrrNrHx3surSof1Mnqsa4FF+ezwpbdL8DMVtsGIggl
         0iH6ukyds8U4J+jQCw7JX85zOslRaTnk4CuiDUuD1uoSdTK+452K5JPXXfXRgS8XVAV0
         /l5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=opm6FBfLkDZAgrNnJvYKE+wVNIsc9sZhKKnl1MD+KdQ=;
        b=q56IGQWNbk8EHKc0Ws2EVVlFjLPw/hgt4pl9s4uINkD4mHNwG9sbq+xannRx9GB4y9
         4GFxRL15ROpw41/RsAfEx6cxUNaVMzyCC7yi8nV4B02R5CSuXKNwBlRwAlNrlf7VRaV9
         jzkmJUyNzP120M0MH/aEhHN7KouFdeLnAfPJQCUeUe+t3XXwQccMYN2zE8VoCxL2Y+Mn
         5/Hs+H9N2nN07u2tk/PEQaWV2lsQ/uLixn7Fr/JCdL7dzCbAF4P0YtLcCR/xEa6ZpGJk
         sJ8hCZJ6I0/OaZcIVCGCJY5/xasCfH6ykTOj1jJUWo6R4Jk8oA079q3y+GvoRO+hUQRW
         lMlA==
X-Gm-Message-State: AOAM532lxa+gPzSkfhXYsyAzTL5mWqDSt58PzUihDhZF4aL4cvmklobc
        SHE2g9Q4lq4DOLZXIbxvpsk=
X-Google-Smtp-Source: ABdhPJz76SxRMTjRWHN+s8ijD+DXduJoHXy6F/Ino3nA8oeq3q7WEUIB2iIKfodUb6etsT3ekOy8MA==
X-Received: by 2002:a05:6870:73c8:b0:f2:5b63:5b9d with SMTP id a8-20020a05687073c800b000f25b635b9dmr7678001oan.26.1653526473535;
        Wed, 25 May 2022 17:54:33 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:485:4b69:8e74:fc8e:b11f:9d42])
        by smtp.gmail.com with ESMTPSA id b3-20020a056820134300b0035eb4e5a6ccsm95652oow.34.2022.05.25.17.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 17:54:32 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     vkoul@kernel.org
Cc:     nathan@kernel.org, dmaengine@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] dmaengine: imx-dma: Silence a clang warning
Date:   Wed, 25 May 2022 21:54:22 -0300
Message-Id: <20220526005422.1162090-1-festevam@gmail.com>
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

Change the of_device_get_match_data() cast to (uintptr_t)
to silence the following clang warning:

drivers/dma/imx-dma.c:1048:20: warning: cast to smaller integer type 'enum imx_dma_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 0ab785c894e6 ("dmaengine: imx-dma: Remove unused .id_table")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
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

