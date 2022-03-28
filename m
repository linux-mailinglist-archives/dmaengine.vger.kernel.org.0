Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5205C4E91F5
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 11:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbiC1JyP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 05:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbiC1JyO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 05:54:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90528546A8
        for <dmaengine@vger.kernel.org>; Mon, 28 Mar 2022 02:52:33 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s8so12083235pfk.12
        for <dmaengine@vger.kernel.org>; Mon, 28 Mar 2022 02:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sGo4IXWrYvYFKPb6MuOn5Y1sxNV0CkrGIqSlou+M1J4=;
        b=OZBLlblazJg+EmvIrbImIhFMYRc17sRbB35Fpi9pwGw3zCANNiPPqEXPD9uVvr/YKJ
         CDNYqmhV02YMDkcjTqm5oo3fbexRXcHsrZyvLWFNmYwKrA+FWP67bM9qhOQjSTx0YvFf
         F0StCKSgSek98iYfrywdlDTmKSDQOt75rkK0cGzUAq+8LI65wQ+t10SW9Lpty0hOU6WW
         0DKPzpm+cEphwYjWDfxYKCPcl17jtcAT6clLXTgD4RyDdfs7N249dCkRpgrvbXtK0+mN
         qcN5+sTK2Q6x7ikn79RlM1X7pw6+Gz7w1KiRglEYr2QgpWWpqrdyP524z1fMTHjwozsS
         L0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sGo4IXWrYvYFKPb6MuOn5Y1sxNV0CkrGIqSlou+M1J4=;
        b=ueIXIXzkz8183cQCHwBUcA3CdasIwih8Dh2wzueqjMTvOV1HmxyFmfmsM8Qe4RkMq8
         zFlCxppKV41cPGMAgHrhowV8SpnaG5iyscN6thZQwqZ3bmtoHdeqPtb7febA/JDszJbK
         fbwvj8YZklptp5B5qW4ipXzGz/HsMksp//d+MrGoCCWHgcZ9DgsrrD/kHyyUUV98Duon
         d8TExrzIsPl4hzhkTuToH/tF1I6+McObTqd5wh0/1+ZpQvb8YM66/tAAkfQykgNEU4a8
         xkMmkzqQL+W/682LkGPW9CMil/yPdeHYeqKlzeiYJAT9EfSfq+5r0a/jfm9hMSBylOZt
         eGNg==
X-Gm-Message-State: AOAM5324LGyx1fkOORQCAKl50/hv4ph+YJgZzcB3NDEn8ut6N7PVneww
        MFxp0tp3nB0wGfLumhFthOO0FA==
X-Google-Smtp-Source: ABdhPJyEdL4vRhiN0Rzcr0Q3f75Ps/anTwmCSmRk/YAdIpVodv6Qix9JzmuNaAukmjuhbbiN2TfclQ==
X-Received: by 2002:a63:5ce:0:b0:382:1f05:c8b1 with SMTP id 197-20020a6305ce000000b003821f05c8b1mr9604717pgf.19.1648461152933;
        Mon, 28 Mar 2022 02:52:32 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id g4-20020a633744000000b00381efba48b0sm12255117pgn.44.2022.03.28.02.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 02:52:32 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v8 0/4] Determine the number of DMA channels by 'dma-channels' property
Date:   Mon, 28 Mar 2022 17:52:21 +0800
Message-Id: <cover.1648461096.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.35.1
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

The PDMA driver currently assumes there are four channels by default, it
might cause the error if there is actually less than four channels.
Change that by getting number of channel dynamically from device tree.
For backwards-compatible, it uses the default value (i.e. 4) when there
is no 'dma-channels' information in dts.

This patch set contains the dts and dt-bindings change.

Changed in v8:
 - Rebase on master
 - Remove modification of microchip-mpfs.dtsi
 - Rename DMA node name of fu540-c000.dtsi

Changed in v7:
 - Rebase on tag v5.17-rc7
 - Modify the subject of patch

Changed in v6:
 - Rebase on tag v5.17-rc6
 - Change sf_pdma.chans[] to a flexible array member.

Changed in v5:
 - Rebase on tag v5.17-rc3
 - Fix typo in dt-bindings and commit message
 - Add PDMA versioning scheme for compatible

Changed in v4:
 - Remove cflags of debug use reported-by: kernel test robot <lkp@intel.com>

Changed in v3:
 - Fix allocating wrong size
 - Return error if 'dma-channels' is larger than maximum

Changed in v2:
 - Rebase on tag v5.16
 - Use 4 as default value of dma-channels

Zong Li (4):
  dt-bindings: dma-engine: sifive,fu540: Add dma-channels property and
    modify compatible
  riscv: dts: Add dma-channels property and modify compatible
  riscv: dts: rename the node name of dma
  dmaengine: sf-pdma: Get number of channel by device tree

 .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++--
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  5 ++--
 drivers/dma/sf-pdma/sf-pdma.c                 | 24 ++++++++++++-------
 drivers/dma/sf-pdma/sf-pdma.h                 |  8 ++-----
 4 files changed, 38 insertions(+), 18 deletions(-)

-- 
2.35.1

