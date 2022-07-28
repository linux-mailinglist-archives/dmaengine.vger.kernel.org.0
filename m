Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404E65838AF
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jul 2022 08:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiG1GTJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jul 2022 02:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbiG1GTH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jul 2022 02:19:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B465726E
        for <dmaengine@vger.kernel.org>; Wed, 27 Jul 2022 23:19:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bp15so1406957ejb.6
        for <dmaengine@vger.kernel.org>; Wed, 27 Jul 2022 23:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C3neU1AtxmqWdDSuYqkB7lF7A3shUmwSCsbgD00NRVo=;
        b=JbjP0JxIPi4T11YXcnH4HfzVt3B9IfnonC2lFIPLzS/wmOUb7lhpdzdYvT4RKIgN1s
         +fllYg1aF6mDvF+BzTc6y2eUkbdIIT+mir7T0+tHeml2NqWAzQ7NwFEWVxbKafGJdQYr
         QfcK0ns+1kHqIN7wPBPR+/tZaFEMkZuqLNs6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C3neU1AtxmqWdDSuYqkB7lF7A3shUmwSCsbgD00NRVo=;
        b=KDJ6qZLyLfb+CQQGLLWt0YV1GRJY2DYVQhiaNgg9erPytsb0OLn/sn8ieQpMlJb4WY
         sBVMyoLrvSHqNhvMH2TwflSyJPVKev+1zo4aqaKQnLOX4iOJygpTzO5FeJ4viKV3JaLU
         VdGZhYYRe9N9zwi8N1aADpR9WNPYpXGEg/8GduM31gVNiWJnrcs5fmE6o6cz5GEcGBGz
         QehBrClt+E+eaia5f/2hhQOF/EJ+53hFRC93bFAIa4wmnmX8sraFkh/syX6R/hM05Q1N
         dVztLxXghi4ZjHKOD3TLActc17WRk1ki18M0S3OL/tGH/X9FaiisGq0tXuNnfJamcu4q
         jDng==
X-Gm-Message-State: AJIora+xngbJMZjbPN/h9H65FXf9MFtVNnaFKFbSecpGM/uoIWsH2FT1
        KL3WVkL9/nXT0OgWMChrnmk5JA==
X-Google-Smtp-Source: AGRyM1vRSnP3N6GPEflp6ikLzS+9t4V10CZ7mlxxZuvGRyYifP+MCFcmCR166eNhGSGUlfm9VPhAfw==
X-Received: by 2002:a17:907:6818:b0:72b:5bac:c3a3 with SMTP id qz24-20020a170907681800b0072b5bacc3a3mr19390245ejc.139.1658989144713;
        Wed, 27 Jul 2022 23:19:04 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-31-31-9.retail.telecomitalia.it. [79.31.31.9])
        by smtp.gmail.com with ESMTPSA id d6-20020aa7ce06000000b0043ba24a26casm105469edv.23.2022.07.27.23.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 23:19:04 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        stable@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v5 1/2] dmaengine: mxs: use platform_driver_register
Date:   Thu, 28 Jul 2022 08:18:51 +0200
Message-Id: <20220728061852.209938-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Driver registration fails on SOC imx8mn as its supplier, the clock
control module, is probed later than subsys initcall level. This driver
uses platform_driver_probe which is not compatible with deferred probing
and won't be probed again later if probe function fails due to clock not
being available at that time.

This patch replaces the use of platform_driver_probe with
platform_driver_register which will allow probing the driver later again
when the clock control module will be available.

Fixes: a580b8c5429a ("dmaengine: mxs-dma: add dma support for i.MX23/28")
Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: stable@vger.kernel.org

---

Changes in v5:
- Update the commit message.
- Add the patch "dmaengine: mxs: fix section mismatch" to remove the
  warning raised by this patch.

Changes in v4:
- Restore __init in front of mxs_dma_probe() definition.
- Rename the mxs_dma_driver variable to mxs_dma_driver_probe.
- Update the commit message.
- Use builtin_platform_driver() instead of module_platform_driver().

Changes in v3:
- Restore __init in front of mxs_dma_init() definition.

Changes in v2:
- Add the tag "Cc: stable@vger.kernel.org" in the sign-off area.

 drivers/dma/mxs-dma.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 994fc4d2aca4..18f8154b859b 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -839,10 +839,6 @@ static struct platform_driver mxs_dma_driver = {
 		.name	= "mxs-dma",
 		.of_match_table = mxs_dma_dt_ids,
 	},
+	.probe = mxs_dma_probe,
 };
-
-static int __init mxs_dma_module_init(void)
-{
-	return platform_driver_probe(&mxs_dma_driver, mxs_dma_probe);
-}
-subsys_initcall(mxs_dma_module_init);
+builtin_platform_driver(mxs_dma_driver);
-- 
2.32.0

