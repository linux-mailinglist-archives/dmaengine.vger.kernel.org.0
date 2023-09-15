Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15A17A1F64
	for <lists+dmaengine@lfdr.de>; Fri, 15 Sep 2023 15:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjIONAK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Sep 2023 09:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjIONAJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Sep 2023 09:00:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92403E7
        for <dmaengine@vger.kernel.org>; Fri, 15 Sep 2023 06:00:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31f6ddb3047so1952026f8f.1
        for <dmaengine@vger.kernel.org>; Fri, 15 Sep 2023 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694782803; x=1695387603; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q2vzfiw2ZNco/+K3UhfhRVgvKgLkbjldFT59MMHDNvc=;
        b=VCMGsiIZG6xXiuOT7MLaNg1xZAcMN3gkcWaWG8CqyZqqNl20tADON7ysbxOVVwixi4
         8IbEG/54Eg4O++y1zCSUTqQ5ZPxN6dBreQQY4p8mnxjEIUAKPai+sBT5EkrdJXEmAdYp
         REKgAJ48pua5OybVh+MHSHt1m2o6OSQx7NZGnWKIuqZ/bG5yYfd4kRirEbLMN/w2kB+n
         2xUu7Rt4Facy+6Ak9EoQ0xWT/D8SRmAIn/ZfPwwWQKgd3i2j7OlOtYpGepHwcjsv7pX0
         FzwDdJdgX8IMRn5TYr4RFOI4mY9SG43r2nYr9HJriO5nZRckWF+AR43hh6p8m+82daff
         NXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694782803; x=1695387603;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2vzfiw2ZNco/+K3UhfhRVgvKgLkbjldFT59MMHDNvc=;
        b=scJAJmfusmJ2MeJ9MHFB/VdMBkFYuuePdha25isriUV1SoXd7Jh7ubbYq+6lWBBNeb
         6W0HFm0lk1oU+Z3Kd0nU2GvWa28ACqlCz3UJe5KrTvJ9NHr79dmK4eVgDD9AuLgVHJJx
         Y03vkMclaHYQCrqlTsbNhw4aSHG/oMS3EOjJBTdovnumlVjjxQZuGcomqtNkiNF8x13e
         H7DyJqqtmWBvE60BVvKJsg68wpu4D9z/uHCOFSAF08cWzfP4ZZarM665obROxCrRA4p9
         QMylcTo8K1gpcRmTWB7yu4zNakTRvtC6xbxyVExuWchlLk2nNof++Dylt7xwggkBXZtA
         P7jA==
X-Gm-Message-State: AOJu0YxGTpCjsCMbPY+sRw4iXx9nDMKjJPO5FzDnZMP0CDdUrfdF5RJk
        xQmkLHi1LwqCJz49D0MPQGD8fw==
X-Google-Smtp-Source: AGHT+IFrvK4b5JrWiUggbSdGEe7g/FVTOL5O3WOCeaHefX37IgkzRGQ+NkeYxcGVlolQQRxauEAKmA==
X-Received: by 2002:a5d:568a:0:b0:317:5d1c:9719 with SMTP id f10-20020a5d568a000000b003175d1c9719mr1361131wrv.9.1694782803078;
        Fri, 15 Sep 2023 06:00:03 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n7-20020adffe07000000b003140f47224csm4358363wrr.15.2023.09.15.06.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 06:00:02 -0700 (PDT)
Date:   Fri, 15 Sep 2023 15:59:59 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Tony Lindgren <tony@atomide.com>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: ti: edma: handle irq_of_parse_and_map() errors
Message-ID: <f15cb6a7-8449-4f79-98b6-34072f04edbc@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Zero is not a valid IRQ for in-kernel code and the irq_of_parse_and_map()
function returns zero on error.  So this check for valid IRQs should only
accept values > 0.

Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dma/ti/edma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index aa8e2e8ac260..33d6d931b33b 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2401,7 +2401,7 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq < 0 && node)
 		irq = irq_of_parse_and_map(node, 0);
 
-	if (irq >= 0) {
+	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
 					  dev_name(dev));
 		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
@@ -2417,7 +2417,7 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq < 0 && node)
 		irq = irq_of_parse_and_map(node, 2);
 
-	if (irq >= 0) {
+	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
 					  dev_name(dev));
 		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
-- 
2.39.2

