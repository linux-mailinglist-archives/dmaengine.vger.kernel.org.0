Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892F04CF146
	for <lists+dmaengine@lfdr.de>; Mon,  7 Mar 2022 06:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbiCGFp1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Mar 2022 00:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbiCGFp0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Mar 2022 00:45:26 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9597D4A930
        for <dmaengine@vger.kernel.org>; Sun,  6 Mar 2022 21:44:32 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id p8so12792368pfh.8
        for <dmaengine@vger.kernel.org>; Sun, 06 Mar 2022 21:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YWajgjcCCrnsZSF3IfZMfbxzzFZcQpbBns1alayx99E=;
        b=cGSKTJZ3Kh0Ek+WCmI4HffDYMUe79KY/em0iV2NUNCazJjGDuknQdSzpMZoSaLZmTW
         MWFW28V2UbmFQKm/k3VUesxpUIBWzAjLzi2WcDEab8uTZuIAd1MQjyvECjNRKr9+ruFH
         FNTKNGnEfcD1KYvDQ9idr3ukmIYhMRFgqGmexUFgyYHjJYbadhBDKkIE0L7DsSnD3Zjv
         HykdLhbEQaupRwNLgPP4ZSdjV/Qo0IALd4wiaDRaNm9bd7ahZWuGrIGpL+yhLbnJXgSS
         x0PUdKL3Kbe0fk3XC/83eJgP6jMQ0WpG489XH/88h9sIiLD0iO4AXz0cNoq3fnbBgbeT
         s7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YWajgjcCCrnsZSF3IfZMfbxzzFZcQpbBns1alayx99E=;
        b=lJrEiZW3vtsA52jzvEEY1Z6++7hD1aDU8mc1jcKIKN5mKJHIsoaC5fhFiFt0c90ydm
         noI2MssNY7x3vaX+5KJTtKfxcA1mW9l8CVI5zyrkRED/es3TQvhrZeIkzuH2eHhhLegb
         3FmxSKOTRsMFJj/I+CwiqD8pyxBZLQ3kQld9b9cbec7zhh8A5NuTUR7o2/YP5mTQjJ+C
         CZleOeHpePaWUIlPceqbtJExiH9e28mman02JV9BctlFrRjA5Bd7JUuuL6vMc4iC/MnU
         qbHkPv2nSAUTla3Qkou4UplY2Yayla6xa5CdcK84XPYVZbyHxfdBiODtCyi1lrjWOp8O
         Xlxw==
X-Gm-Message-State: AOAM533+zFkFUFPy/s0xVRJZAQemNS2hKpKuCFFN6MhwzgJ+AQ+HE0VV
        UiZXTW9zAiP5PzYWRnLuAI02wQ==
X-Google-Smtp-Source: ABdhPJwnA3KEBp7KJP4Dkadosl1pu/fl5hoM+iRWl2JxYsBzf8nK0VH8nGH8sx7PD9Mes5im6f4iZg==
X-Received: by 2002:a05:6a00:1a09:b0:4e1:67a7:2c87 with SMTP id g9-20020a056a001a0900b004e167a72c87mr11135766pfv.37.1646631872090;
        Sun, 06 Mar 2022 21:44:32 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id k1-20020a056a00168100b004e0e45a39c6sm14447385pfc.181.2022.03.06.21.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 21:44:31 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v7 0/3] Determine the number of DMA channels by 'dma-channels' property
Date:   Mon,  7 Mar 2022 13:44:23 +0800
Message-Id: <cover.1646631717.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Zong Li (3):
  dt-bindings: dma-engine: sifive,fu540: Add dma-channels property and
    modify compatible
  riscv: dts: Add dma-channels property and modify compatible
  dmaengine: sf-pdma: Get number of channel by device tree

 .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++--
 .../boot/dts/microchip/microchip-mpfs.dtsi    |  3 ++-
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  3 ++-
 drivers/dma/sf-pdma/sf-pdma.c                 | 24 ++++++++++++-------
 drivers/dma/sf-pdma/sf-pdma.h                 |  8 ++-----
 5 files changed, 39 insertions(+), 18 deletions(-)

-- 
2.31.1

