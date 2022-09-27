Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CDE5ED0B6
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 01:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiI0XII (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 19:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiI0XIH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 19:08:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E7C10CA47
        for <dmaengine@vger.kernel.org>; Tue, 27 Sep 2022 16:08:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d10so9861044pfh.6
        for <dmaengine@vger.kernel.org>; Tue, 27 Sep 2022 16:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=nd4m0j2Ff4yr1SI153AzWT37h3dHh1P48RrPCZDi4ac=;
        b=RgWXxFKo+UIx+9E3zmCcy1+XK43OEGkLyLS/BxuVp2xemzSRFZoZEeC5k5p0hmKrdS
         9y23DR1FQxB24n/5Do5DplXtLgXzDgvVv7shWnMv0CxM0F9rAxzhAr69GHy4NENJzX1l
         oW5DAQh6tG8xbWl2eyHwE8kJVvi1P+VcoP9wicZJUDf9WttMrp7PvxwawxlumHtREiKb
         B1iA6feagfCpTrU4ONzM3XsDyYxgFyv5/l5qB5G7hhfvuzrpf8xBy8rpuKZeGpIlH8YO
         vZQv5Hz/XmWC0P7U2Dwb2SnwUcQft1JryBS474RZX0agJm0GUq1L7b/SbGd6cgi8kDHT
         ojnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=nd4m0j2Ff4yr1SI153AzWT37h3dHh1P48RrPCZDi4ac=;
        b=G5koO1jHUp1yszoF5C7mnNyeTyMcV03a9JBg1+4yIkV4I+mW6s7PN7J9Xdl7SQsVT2
         X0hg7lR//Ome0YnJazVgMGUU5Hbx6NZ6Ay8uPWkpYXVdrXX7bYkJrwgGPmXkKbxmKOoF
         CiQU3+UghHDHju9MK18bzJoTZ6ijqq1XHBQTDzeVXoAPABmXeU/tDq0DwUrGig8BxAgA
         A2WwOXBjAVAzgQdlZTg2eZI31liAaZcrrg7HJ3CpdfXEl3rYteqNTSCcW8SS8qB1nRY+
         GXQoYEf6yVITi7OuFyFbbApFOcD9w16IC1tkfhluAhm5Z8hQ5nPC4xb1ypmQkt7bJKpI
         EN/A==
X-Gm-Message-State: ACrzQf3dgSNqIwQLb4Tr50O44f1dUCnSMITU36yA7/fY1HkCQMMPD+Ba
        B+1jEY/t3IMGc/ZniEOAbcsNgV5Ebo60fwR1
X-Google-Smtp-Source: AMsMyM5C+Shf0TZRjlFvSJFPI2e6VNH3r4FQKeSMLtoBRayYHfSd4f6/1KYR2ZjvIG7zSTR7yoY7sg==
X-Received: by 2002:a05:6a00:1911:b0:545:cdf0:a61f with SMTP id y17-20020a056a00191100b00545cdf0a61fmr30634434pfi.32.1664320086141;
        Tue, 27 Sep 2022 16:08:06 -0700 (PDT)
Received: from localhost ([76.146.1.42])
        by smtp.gmail.com with ESMTPSA id v24-20020a634818000000b0042b2311f749sm2085928pga.19.2022.09.27.16.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 16:08:04 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: [PATCH v2 0/3] dma/ti: enable udma and psil to be built as modules 
Date:   Tue, 27 Sep 2022 16:08:01 -0700
Message-Id: <20220927230804.4085579-1-khilman@baylibre.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Enable the UDMA driver & glue and PSIL lib to be built & loaded as modules.                                                                                                   
                                                                                                                                                                               
The defauilt Kconfig settings are not changed, so default upstream is                                                                                                          
still to be built in.  This series just enables the option to build as                                                                                                         
modules.      

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

