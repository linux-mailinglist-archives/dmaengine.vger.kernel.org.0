Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB4E5F0187
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 01:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiI2XsZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 19:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiI2XsY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 19:48:24 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F431FBC9A
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 16:48:22 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v4so2750209pgi.10
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 16:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ohn4yoCs7BJg6ILVegslZbTsXPzwa5AtNwUThWtPO0o=;
        b=3wVsqamolyxKOyY/q2GE+SvWAQKPPnu3prm4dXG4cKk7PnW+C2gCDHV5qh4brDX5lX
         hxQXQXV5FHMVUR7PHS9DNYzNjcDPwxDVzlHIOD7Wm7OTxn+y8LCgxtP96Z1OUyv3zbW6
         ZN+YLLPqSUGuZj6cz55ZMdGrFcvFSaFynPtEVuLDznsT6VRe9LTVUkXh+/9qM3igfbR1
         Yp6d2oXTYa1KRvrvBq21dAUjH2GWv/MVtH1NS1RrxM+Q3KupajJqkUqP48p+FelP1bl4
         t8+9y3nXZrlvufMgJ3gm0M7ImaKDqffTjTINAvQ17HpL2Myw4eqzykjNgmfnETfVefYR
         +2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ohn4yoCs7BJg6ILVegslZbTsXPzwa5AtNwUThWtPO0o=;
        b=mazfgQ4rBfducMJ+ST8KplsXSukulmtNr4oSP479BH/f331Zv8pF/cZwlTPEsuSZRL
         C3DuExLvuqG1TtbFC7WRa/DsyRqFRDmudpPiTBJFeUfwFSneOY46ttPuS1cPGh7ALS32
         sqgOdXfOCZNCGZWZHrssI8dtPLqugK/YkN5lS+/xweBj1g239cSaAG40rEAv9sZtHcVZ
         gR/VeycKRbuCQtz2omPC0c3zbJUDB15DDhhL/OQGuzClgzRtNzyUvFLU8DCcM3wTRQb2
         i0lJhxL2Dw8aMWVO9v0BAIb6L9vQbsDKBFfBsbgjHOMZB2A3RdFzw5mknbIn81MOALC9
         s2GA==
X-Gm-Message-State: ACrzQf13iw+JZh4l7Kjnwu3ZyJxEK9bHvp/WX/ZIDA0NSr8camfGTThk
        QWFTKgb9Tp4X8sFCUi/gnIx5y0IRIylc0A==
X-Google-Smtp-Source: AMsMyM6H5eQN/DXpCktUWjoht0v5g5aqeVlGdWY+dz6xQlBEO6PMiMVrxfEnNzQ6YpAce4QYUB14Lg==
X-Received: by 2002:a05:6a00:150c:b0:545:cdc2:94e5 with SMTP id q12-20020a056a00150c00b00545cdc294e5mr6059479pfu.37.1664495302353;
        Thu, 29 Sep 2022 16:48:22 -0700 (PDT)
Received: from localhost ([75.172.140.17])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902d48600b00178143a728esm426656plg.275.2022.09.29.16.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:48:21 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: [PATCH v3 0/3] dma/ti: enable udma and psil to be built as modules 
Date:   Thu, 29 Sep 2022 16:48:17 -0700
Message-Id: <20220929234820.940048-1-khilman@baylibre.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Enable the UDMA driver & glue and PSIL lib to be built & loaded as modules.                                                                                                   
                                                                                                                                                                               
The defauilt Kconfig settings are not changed, so default upstream is                                                                                                          
still to be built in.  This series just enables the option to build as                                                                                                         
modules.      

v2-v3:
- change dma/ prefix to dmaengine:
- rework Makefile order for PSIL lib

v1->v2:
- rework PSIL lib into a single .ko

Kevin Hilman (3):
  of/irq: export of_msi_get_domain
  dma/ti: convert k3-udma to module
  dma/ti: convert PSIL to be buildable as module

 drivers/dma/ti/Kconfig        |  7 +++---
 drivers/dma/ti/Makefile       | 15 +++++++------
 drivers/dma/ti/k3-psil.c      |  2 ++
 drivers/dma/ti/k3-udma-glue.c |  5 ++++-
 drivers/dma/ti/k3-udma.c      | 40 +++++------------------------------
 drivers/of/irq.c              |  1 +
 6 files changed, 24 insertions(+), 46 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.34.0

