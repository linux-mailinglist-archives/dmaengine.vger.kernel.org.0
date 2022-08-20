Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5F059ACB2
	for <lists+dmaengine@lfdr.de>; Sat, 20 Aug 2022 10:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344733AbiHTIpJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 20 Aug 2022 04:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344621AbiHTIpH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 20 Aug 2022 04:45:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE318B994
        for <dmaengine@vger.kernel.org>; Sat, 20 Aug 2022 01:45:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gb36so12647247ejc.10
        for <dmaengine@vger.kernel.org>; Sat, 20 Aug 2022 01:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NvLw5KU+55jz8ItVCImcVo81PfvmbTqj67db51rQx28=;
        b=PFBUJaVjPkRQdOOwLzx7iIz20v9iOaOvAdqgW4jBePTLYIdeSyUvJ2zwu3Q3o4Cq6i
         5B6mfTVTYUGtqzw1bRS79u25XlaALcHR8OpDENAuIFtrJVVth3UIcTe44Y6AhfObiNld
         JnuKWXZtlJiWWDwpgd8DawXuhDAoPFtD+hz04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NvLw5KU+55jz8ItVCImcVo81PfvmbTqj67db51rQx28=;
        b=xH0eRkhArvSOzOOLZHrvj9I0W1hhjlpT8yzXr6E1xEUS894ZF79WdKSVpfPxufVUh0
         e3anViV0Lg/npr97SsR39dUv5BdsnGItgwBxYfqZNHfRhHQxNIsPkoNAxkjkJXsZfSg+
         xAJzE8+gweobMruDvLdVv4671rr6XEcjCmcp2LN2BePZ5IffiK9/SHFvQxmA17qsiuvw
         tSiN3MjmILGcbfNiryL+RsZ7IjxgwyDeHhNg4+JbQpYgGEgmRyxvp+MHmpIcBPYVbxK9
         IJITMJAxTvmUlqnuQcDz29vve42fZiW1z6WlO+p1VCryddLQaGq0s+ow1vfH/pce09wx
         YdOA==
X-Gm-Message-State: ACgBeo1RK+w9aKN+XVhrMqNihuhpSPk//wha9fW/9RPjvZEoDEAti2Qv
        G+POTt6yn89EcIn2KuKMa3sz9A==
X-Google-Smtp-Source: AA6agR4umMH3H1BID5s9V1QzSQGwW8W5gM3JJE865WFSKxRHPCoGBTtY/6LUkZ+1dSAQuAbDAJBgcg==
X-Received: by 2002:a17:907:7617:b0:730:e317:d0e9 with SMTP id jx23-20020a170907761700b00730e317d0e9mr7257826ejc.736.1660985105254;
        Sat, 20 Aug 2022 01:45:05 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-31-31-9.retail.telecomitalia.it. [79.31.31.9])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090632c800b0073cd7cc2c81sm2170821ejk.181.2022.08.20.01.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 01:45:04 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        stable@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v5 2/2] dmaengine: mxs: fix section mismatch
Date:   Sat, 20 Aug 2022 10:45:00 +0200
Message-Id: <20220820084500.689445-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220820084500.689445-1-dario.binacchi@amarulasolutions.com>
References: <20220820084500.689445-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The patch was suggested by the following modpost warning:

WARNING: modpost: vmlinux.o(.data+0xa3900): Section mismatch in reference from the variable mxs_dma_driver to the function .init.text:mxs_dma_probe()
The variable mxs_dma_driver references
the function __init mxs_dma_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: stable@vger.kernel.org
---

(no changes since v1)

 drivers/dma/mxs-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 18f8154b859b..a01953e06048 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -834,7 +834,7 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver mxs_dma_driver = {
+static struct platform_driver mxs_dma_driver __initdata = {
 	.driver		= {
 		.name	= "mxs-dma",
 		.of_match_table = mxs_dma_dt_ids,
-- 
2.32.0

