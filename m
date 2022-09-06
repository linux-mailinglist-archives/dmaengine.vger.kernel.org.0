Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF675ADC28
	for <lists+dmaengine@lfdr.de>; Tue,  6 Sep 2022 02:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiIFAHn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 20:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiIFAHn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 20:07:43 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3382067475
        for <dmaengine@vger.kernel.org>; Mon,  5 Sep 2022 17:07:36 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bh13so9173701pgb.4
        for <dmaengine@vger.kernel.org>; Mon, 05 Sep 2022 17:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ccOJio8OvVhKT9eRWLFa93p1CadNtYx//Tt6F1LDlyY=;
        b=VAuUUzX4L5paItKgWwiAmhZtw5rZDMEKCZZ/f8RY9HkMjK8G4xyvnDZow5EtwC0oc4
         E8Bi/cgpFtB5AKtIOjoCYZWuEgnC/24DNq5Qww6pIDWQ6NdGbC/q/dfbgREz3sIFbIWa
         TaigSDcbQPcp7MvoUhWkOdw6Hqtnv8yGux49g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ccOJio8OvVhKT9eRWLFa93p1CadNtYx//Tt6F1LDlyY=;
        b=tkklhC86mem5ZMG/wcyvbIxlBCRzG9dim3I31YAh9vyyBOWwcfRzs37MzdPQMG815r
         X4R1VvQDFmkMrGcupUNR9UFoKuQ/CcUn1hyIDhCJR3cX5hYSgSMlRTZ7LyJPS6E4ooVL
         GFgSopQv2KYTF4Rd5KO4xIJRxXN9inuXv7JDSVhaGZXrBLJdQ8y2J+umlqqZPzDjQWJL
         ULZ0vq+L4K9VejUk6c5FSDOQ2dP5IoO3hkpLuZhLadYH0tHrJoFDfbIuW23osvNPorbf
         qHfqnSEgYX+6euLQhmVgpklq2LrHL5mRvB9tLDcuJ2r3Tm4I7rzQRZwoWM2f2map5oRb
         8n+Q==
X-Gm-Message-State: ACgBeo2AtsB0C4kMK+iJI/Ss2mZq8ua8NvTkFsS6ZSxuu70OVKyJtpLg
        9e6wOVdYHd+xvUz0uU4AE022+g==
X-Google-Smtp-Source: AA6agR6dP+N069mNXwdxsq3HUnT7M0IZLsP6Iy12XKSHEYo5sfAf6ztqQiV4xezj3K00SmvXqbP9yQ==
X-Received: by 2002:a63:5702:0:b0:42a:b77b:85b3 with SMTP id l2-20020a635702000000b0042ab77b85b3mr42537847pgb.263.1662422855464;
        Mon, 05 Sep 2022 17:07:35 -0700 (PDT)
Received: from localhost.localdomain ([50.45.132.243])
        by smtp.gmail.com with ESMTPSA id ik12-20020a170902ab0c00b00176ca089a7csm607538plb.165.2022.09.05.17.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 17:07:34 -0700 (PDT)
From:   Doug Brown <doug@schmorgal.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH] dmaengine: pxa_dma: use platform_get_irq_optional
Date:   Mon,  5 Sep 2022 17:07:09 -0700
Message-Id: <20220906000709.52705-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.25.1
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

The first IRQ is required, but IRQs 1 through (nb_phy_chans - 1) are
optional, because on some platforms (e.g. PXA168) there is a single IRQ
shared between all channels.

This change inhibits a flood of "IRQ index # not found" messages at
startup. Tested on a PXA168-based device.

Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()"
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/dma/pxa_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index e7034f6f3994..22a392fe6d32 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1247,14 +1247,14 @@ static int pxad_init_phys(struct platform_device *op,
 		return -ENOMEM;
 
 	for (i = 0; i < nb_phy_chans; i++)
-		if (platform_get_irq(op, i) > 0)
+		if (platform_get_irq_optional(op, i) > 0)
 			nr_irq++;
 
 	for (i = 0; i < nb_phy_chans; i++) {
 		phy = &pdev->phys[i];
 		phy->base = pdev->base;
 		phy->idx = i;
-		irq = platform_get_irq(op, i);
+		irq = platform_get_irq_optional(op, i);
 		if ((nr_irq > 1) && (irq > 0))
 			ret = devm_request_irq(&op->dev, irq,
 					       pxad_chan_handler,
-- 
2.25.1

