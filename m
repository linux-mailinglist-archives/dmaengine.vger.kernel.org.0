Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB4457206E
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jul 2022 18:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiGLQLh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jul 2022 12:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbiGLQLf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jul 2022 12:11:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6603059275
        for <dmaengine@vger.kernel.org>; Tue, 12 Jul 2022 09:11:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id os14so15197561ejb.4
        for <dmaengine@vger.kernel.org>; Tue, 12 Jul 2022 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NvLw5KU+55jz8ItVCImcVo81PfvmbTqj67db51rQx28=;
        b=qvnGgeO99cNBndr+zz3vZPBPjheS4AqDg5tJYJa9iR5ARJ8GPd50mYESF4pgF6HdFl
         m0VBCK+91GngOqkbtm49sDlQL4Jd82szEHwB5HnSf+wox0J90LlQarAzbvJqQQ2q+UtN
         iAWTSxgnzZ/RHK5tZkYBxrLflMZvalt6vu7lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NvLw5KU+55jz8ItVCImcVo81PfvmbTqj67db51rQx28=;
        b=0wSPSG6zgB/lb//bIoqOahog+ORcGMhy15AcSBRgoQjc8CIJLc/BUrjQdkUcEh3hjO
         M76beF2Q+8RkQHn8CB2KCRZ5Bovvm1MJs/5IqbekCqNr+CCUXZx4zf6txkKGDkSKr2GQ
         QYKilIJ5kNDINprmEi8L/uGttI5sbCz95MBxTxdG2OFPTHFSHRhkpxN6oMagMnqi9r6S
         Ek980E+6LcdErpD6SpUB5eE2MFegu2LNdZcegTpfFhykGNw0CJp8hrnFd3ICmVsSXaEp
         Ahk+aW9vEi+G1USiEKCCeYLuUsbJFzrEdNQlAIupV1HPmH8HqnMnRhUIxxZm8mCYnGc4
         d0Dw==
X-Gm-Message-State: AJIora9TUE2DkAwOxXIlOhTuyMN/I/FAw6CIflfDP1Bgw/h7FRDQR8CP
        w08y5C61k9AnPcEZgqxp3qo1EA==
X-Google-Smtp-Source: AGRyM1vzGSUHcJzBp/hgiaDv/invRmw4l+YZl3HEKr2i8km6/o0VBKy7xDflf7yWj8fy9tbhieIS9w==
X-Received: by 2002:a17:907:6e05:b0:72a:a141:962 with SMTP id sd5-20020a1709076e0500b0072aa1410962mr24563519ejc.545.1657642293037;
        Tue, 12 Jul 2022 09:11:33 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.retail.telecomitalia.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id h4-20020a1709066d8400b00722ea7a7febsm3911498ejt.194.2022.07.12.09.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:11:32 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        stable@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 2/2] dmaengine: mxs: fix section mismatch
Date:   Tue, 12 Jul 2022 18:09:08 +0200
Message-Id: <20220712160909.2054141-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220712160909.2054141-1-dario.binacchi@amarulasolutions.com>
References: <20220712160909.2054141-1-dario.binacchi@amarulasolutions.com>
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

