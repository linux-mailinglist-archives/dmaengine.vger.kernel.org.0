Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD775838AD
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jul 2022 08:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiG1GTK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jul 2022 02:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbiG1GTI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jul 2022 02:19:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CFB5D0EF
        for <dmaengine@vger.kernel.org>; Wed, 27 Jul 2022 23:19:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z18so890205edb.10
        for <dmaengine@vger.kernel.org>; Wed, 27 Jul 2022 23:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NvLw5KU+55jz8ItVCImcVo81PfvmbTqj67db51rQx28=;
        b=JxzV2oSfWwKritZ+fmuoWkOXRPsUIVzZhiFsuXbVagrOjYrHlMyQE3ykTSYSnDmW3u
         JUFSQpcMZYC+K91RrMsY4H6KlQ7vzRxdPTZjQ5f/toaKumjVjVAYVZXltUN9f2/Y2tni
         Fb4jE49zfjC8zyoV5FTPrQnoWkLwKoCPsILno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NvLw5KU+55jz8ItVCImcVo81PfvmbTqj67db51rQx28=;
        b=QDMOmHd/hIcRsQh7GxHICEGutooLg1leB6C4oiubm5yPMjW6dNCXUP438qlUvZYDgf
         DXpPpEuBVoVsFgWZoHRYX3SpkDa+uslyhKqkMzyKzMJWytOBYYdjpHvdQA/grOY/WSMk
         YuwgzGDyOcPk1o0kESCQnIbQfdMmpQV0gSOqDuVZz1p2TMS0fZ2/6QDwpzIDdPbtulj1
         9KmFhfpnnIzX/oJJp7dcYyqK081FQDIjaWku6twhv/hQrLEjPYPdfVCrxSCJEY4Ti2kv
         JVkgRQhPQRkBn6LDmQY7adbvLEzM3ZmECcDmtL50FT+5gNU5tiEqr2L3U7NshiQ/kFL/
         PqkQ==
X-Gm-Message-State: AJIora9vXtQOtXrME7EftvxyLsfUZ+2j+th8I95sIMEOwThbCwphNgnJ
        8379nKUnYdkPaHFb++m87gUH6Q==
X-Google-Smtp-Source: AGRyM1tz1tC6LEg2WNIzbzcbIY1B6VTZVLyNkR0LykMksjUXB9PQLJr/W73edAmaLaoCMJ3ovFMSSg==
X-Received: by 2002:a05:6402:484:b0:43b:6e02:71af with SMTP id k4-20020a056402048400b0043b6e0271afmr26664127edv.176.1658989146470;
        Wed, 27 Jul 2022 23:19:06 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-31-31-9.retail.telecomitalia.it. [79.31.31.9])
        by smtp.gmail.com with ESMTPSA id d6-20020aa7ce06000000b0043ba24a26casm105469edv.23.2022.07.27.23.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 23:19:05 -0700 (PDT)
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
Subject: [RESEND PATCH v5 2/2] dmaengine: mxs: fix section mismatch
Date:   Thu, 28 Jul 2022 08:18:52 +0200
Message-Id: <20220728061852.209938-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220728061852.209938-1-dario.binacchi@amarulasolutions.com>
References: <20220728061852.209938-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

