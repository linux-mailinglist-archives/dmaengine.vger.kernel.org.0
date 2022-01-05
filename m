Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FBF484D21
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jan 2022 05:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiAEEir (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jan 2022 23:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237365AbiAEEio (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Jan 2022 23:38:44 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83186C061761
        for <dmaengine@vger.kernel.org>; Tue,  4 Jan 2022 20:38:44 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id h6so24647140plf.6
        for <dmaengine@vger.kernel.org>; Tue, 04 Jan 2022 20:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9aN3MVYr/eRiJOMan2AXOKnS6rXengbNHdl8ukrLg8Q=;
        b=chEtXgMW/jgHH/5DCnTuHZPiW24an6y7pTIn6Bri/8i5+OkXl0tqt2S7a+d0oSw1E6
         xbtlp37n8UM20bQ01v5rnPHEouHragXKMDHapP4i0yTDa+XcMQaX/775+tWkZuJJI2vg
         swNdxC+/1am+Oc0aKKQ6fJH875639pDBDRp92+yxyLkiv0rW4npI1pkt202WC9wp0Lcr
         8VrobxfB0h/zJnmtsKeD3YTpoCd363/I0tWhPdJfS1S6EOaAa8nwZCPWe8bUy41ieWZ4
         zOX+8hBZbqSuZDRqgy5XTrDIJHounAjhDqXV2sWFyFTtp+1DbOlGl4QA0C7oRZm0Kj45
         N8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9aN3MVYr/eRiJOMan2AXOKnS6rXengbNHdl8ukrLg8Q=;
        b=w0rHI2Fh134vC5o7EOjX8chCcq7NhVbtw/+oOolrqfRmn6TtowBm9uiWhSc7XMs5FV
         cCNkGEXXEtebZ7tRJMWdvZxjNdxoI2hP1FCu/DKHygiCOrgGmaTVuksw4bqcXPSvVJer
         iqvxksynJjxBNsgOuz3lrKmcLpaSCzP828AbOJMsdYDYflq2NZuqQN996cLc/uW6rgop
         fG3mgNnv1w8G6EoKPWFNZYvLIsVuflVpatY8vVAAPpnDV/g4yLoomGAPVDu5QwQ8RXDg
         05gWNXVsLy3jbK3znxN4I5T35cq3gDM+8vG6Ui5HKiUsiRe9lvxGxhR8QyCkUDoTzuPW
         moXQ==
X-Gm-Message-State: AOAM530jKBGU8gVaDlW9iw1Q2ic9aA7WIXWHiA5qhPn/nkO/NiPiPEGv
        Rw4qDW6DuYeZc4VxZt1wJqIqJg==
X-Google-Smtp-Source: ABdhPJzFZp6NmebEnmYEZa1fqT6Z51iGeMByHFmL64WhfozHkp665fRhYI8myvlJR41cr27d3/HV2w==
X-Received: by 2002:a17:903:11cd:b0:149:bf70:2031 with SMTP id q13-20020a17090311cd00b00149bf702031mr10495508plh.40.1641357522727;
        Tue, 04 Jan 2022 20:38:42 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id j8sm36172812pgf.21.2022.01.04.20.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 20:38:42 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/3] Determine number of DMA channels by 'dma-channels' property
Date:   Wed,  5 Jan 2022 12:38:36 +0800
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

