Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FF8484DB7
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jan 2022 06:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbiAEFoJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jan 2022 00:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbiAEFoI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jan 2022 00:44:08 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B8CC061761
        for <dmaengine@vger.kernel.org>; Tue,  4 Jan 2022 21:44:08 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l16-20020a17090a409000b001b2e9628c9cso5358534pjg.4
        for <dmaengine@vger.kernel.org>; Tue, 04 Jan 2022 21:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9aN3MVYr/eRiJOMan2AXOKnS6rXengbNHdl8ukrLg8Q=;
        b=Lkmpsut52RVgiDO8dUHEr7vqhZTGrLl6xV2Kkv7ydfmDDuVZcySNeXmHyiUzMPRg/K
         om0x1PQNLhIQLAkS4r9I1OK/ihf1Nwng7WiHpe1BG4+AOgiavbr3GuL8Lcga04t8mVsh
         vzYODZ6exNtL0M/Jh8gcS6fJXULUPyaoue3UXBFUnVqOmari00YpM+vebHiFQcjJjqcL
         +yss+yyQuBKzYUKqRARcxyjFqkTZRpThrEfsxtDZMy4T029JfYtq5hNUgGOH2e/LjOfl
         2J6+sIkzsJe6aCfWeIhPR34Ndl7daqgjmrTBb/fNXpwnqcPGBQmSaGQgnIpOfmFic91O
         eGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9aN3MVYr/eRiJOMan2AXOKnS6rXengbNHdl8ukrLg8Q=;
        b=aAeoP8qj0C8BpDZ7PPXP4cyw9oXUCA795i7ZMDv8uKUbogsokQ2RJg3y40mIxTM1uY
         nLKFxRBkNQ1QTQ1270ZXnyUhy9t+g5ahUvVehQOYcMg9SWtKVnHKVIxDpZy/9YBKPGsq
         xKNMU1PWctX65iTRsnD2zo7vcR3qmrLaal4QSeIaVz7Pd057TBBE+xTe6NB+Oxvyg5Ta
         l1M2ldZqeSWtn6CYubWt12cybq49ZZGoG6SP6XfDlLt1NDU+1MjeZIc2yiTEKpWTqwep
         dThDzcnfRNN4iZN0EbdQD3kC5OjVA2RzbP9IBpQno2mfBsx4Xpw2IKqeRP/CLUPhRg/6
         FOvA==
X-Gm-Message-State: AOAM531TNM3v+w9bvgsPZ/Qgw+iSQIo28xCtAiUGV16JKuHCfd5Wwzkk
        eI8lzWXuWXsaRyms5CdkwB2xqQ==
X-Google-Smtp-Source: ABdhPJyjR5gEVjMyzPzdgCGtXpRNBEO5AKvueTEAzhFJ/eTPOk/TKJ8NA7Vd+aNVHglmeCevkEdWUA==
X-Received: by 2002:a17:90a:2f06:: with SMTP id s6mr2229426pjd.230.1641361447984;
        Tue, 04 Jan 2022 21:44:07 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id cu18sm1000574pjb.53.2022.01.04.21.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 21:44:07 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/3] Determine number of DMA channels by 'dma-channels' property
Date:   Wed,  5 Jan 2022 13:43:57 +0800
Message-Id: <cover.1641289490.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The PDMA driver currently assumes there are four channels by default, it
might cause the error if there is actually less than four channels.
Change that by getting number of channel dynamically from device tree.

This patch set contains the dts and dt-bindings change.

Zong Li (3):
  riscv: dts: Add dma-channels property in dma node
  dt-bindings: Add dma-channels for pdma device node
  dmaengine: sf-pdma: Get number of channel by device tree

 .../bindings/dma/sifive,fu540-c000-pdma.yaml      |  6 ++++++
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi |  1 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi        |  1 +
 drivers/dma/sf-pdma/sf-pdma.c                     | 15 +++++++++------
 drivers/dma/sf-pdma/sf-pdma.h                     |  8 ++------
 5 files changed, 19 insertions(+), 12 deletions(-)

-- 
2.31.1

