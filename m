Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B98750B57
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 16:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGLOrK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 10:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjGLOrI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 10:47:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A58CBB
        for <dmaengine@vger.kernel.org>; Wed, 12 Jul 2023 07:47:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so5533255e9.0
        for <dmaengine@vger.kernel.org>; Wed, 12 Jul 2023 07:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689173226; x=1691765226;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yV/gZ8PkZTDK+TeGTSKSheUF1R06abOhAYcKVHgpjFw=;
        b=kNa0ISz2se2cNAfjolxWl7Np8PCJnq/wU0V5oIxAIPARXlIsng80vAa7rrJl7/GSwC
         PUOWU+dQYX//f/ebVPHZ0r3Ttply+/uZplgOjiCJP6wS4ZnrAJr6oNYU48eCU/HY4x8q
         BvCBfGj6Tw5mWlYikqVJ/sZLLNkl9T+Z4nGFeyTuJSrnulkWA5ZUnwFfRcBIHC8/anPI
         EUEV4w3O7dSn4tLTMZn32lMzcXpKgFR2UFCgAHT0D/YeRM5O1rcsY9/kRtnG+3EMWyxV
         Cp2lHrxyGVzLKKeWCa24vmXlKPGXBWgr7GBw8pwNTMiGpJ5nJ2I0H3JmF2TcS+N9t24E
         x7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173226; x=1691765226;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yV/gZ8PkZTDK+TeGTSKSheUF1R06abOhAYcKVHgpjFw=;
        b=UAQwqSOk/H2YQ9QwRxqYnRZlVFBghll+55Q9I0w2lYP8K2V0+pFdlZmpgrIAmn0e/I
         /kIeFZnMX8HpsZJOevDdQ/cMJ+QhwjzkTYYeXrOZq8k2REMZB6rz0y6zpDFrbP3rT/Al
         yUQNZgi/FL4drEjhx7iKerccWHHK6rNya5aiWshfmunab2SBmSkYyi5yY5bcvd5/tdVF
         CRZq+17KydMAJsm/ryCzZpZOnF1x4VNZ7YVyrALWIzdzh4ipL5NNos2iQZLcpIvj2y6l
         iaVrI2mzBoNkbxOsXQsuo0Th9EyqfJqjEuhAvjQah0HffaWzeMDcCYMu5HQq8tj0yGhX
         IpTQ==
X-Gm-Message-State: ABy/qLY1Z4CHDmhiDb6C0SOE1BRDkqpVeQUTwre/DKqJQD+89gZoJQkd
        tAGRJykknFWDBx7Fqh5WIsXOSOY2Pw7M0B822io=
X-Google-Smtp-Source: APBJJlEHVm+4g24LW148qlh1utlCjqusJOItHaBsML/q4Beb5lHtWmjc7E/VgieABeXGes9VhRtXIg==
X-Received: by 2002:a05:600c:1c8a:b0:3fa:88b4:bff3 with SMTP id k10-20020a05600c1c8a00b003fa88b4bff3mr1925337wms.11.1689173225755;
        Wed, 12 Jul 2023 07:47:05 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o18-20020adfe812000000b00314417f5272sm5273173wrm.64.2023.07.12.07.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 07:47:04 -0700 (PDT)
Date:   Wed, 12 Jul 2023 17:47:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     peter.ujfalusi@ti.com
Cc:     dmaengine@vger.kernel.org
Subject: [bug report] ARM/dmaengine: edma: Merge the two drivers under
 drivers/dma/
Message-ID: <d946e56f-f1e9-4af1-8b81-a6de973feaac@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Peter Ujfalusi,

The patch 2b6b3b742019: "ARM/dmaengine: edma: Merge the two drivers
under drivers/dma/" from Oct 14, 2015, leads to the following Smatch
static checker warning:

    drivers/dma/ti/edma.c:2405 edma_probe()
    warn: irq_of_parse_and_map() returns zero on failure

    drivers/dma/ti/edma.c:2421 edma_probe()
    warn: irq_of_parse_and_map() returns zero on failure

drivers/dma/ti/edma.c
    2397                 if (!test_bit(i, ecc->slot_inuse))
    2398                         edma_write_slot(ecc, i, &dummy_paramset);
    2399         }
    2400 
    2401         irq = platform_get_irq_byname(pdev, "edma3_ccint");
    2402         if (irq < 0 && node)
    2403                 irq = irq_of_parse_and_map(node, 0);
    2404 
--> 2405         if (irq >= 0) {

The platform_get_irq_byname() function returns negatives on error but
irq_of_parse_and_map() returns zero on error.  These IRQ functions are
a left over legacy mess.

    2406                 irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
    2407                                           dev_name(dev));
    2408                 ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
    2409                                        ecc);
    2410                 if (ret) {
    2411                         dev_err(dev, "CCINT (%d) failed --> %d\n", irq, ret);
    2412                         goto err_disable_pm;
    2413                 }
    2414                 ecc->ccint = irq;
    2415         }
    2416 
    2417         irq = platform_get_irq_byname(pdev, "edma3_ccerrint");
    2418         if (irq < 0 && node)
    2419                 irq = irq_of_parse_and_map(node, 2);
    2420 
    2421         if (irq >= 0) {

Same.

    2422                 irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
    2423                                           dev_name(dev));
    2424                 ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
    2425                                        ecc);
    2426                 if (ret) {
    2427                         dev_err(dev, "CCERRINT (%d) failed --> %d\n", irq, ret);
    2428                         goto err_disable_pm;
    2429                 }
    2430                 ecc->ccerrint = irq;
    2431         }
    2432 
    2433         ecc->dummy_slot = edma_alloc_slot(ecc, EDMA_SLOT_ANY);
    2434         if (ecc->dummy_slot < 0) {
    2435                 dev_err(dev, "Can't allocate PaRAM dummy slot\n");

regards,
dan carpenter
