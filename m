Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E758704E43
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 14:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjEPM4P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 08:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjEPM4M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 08:56:12 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF6E6A6F
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 05:55:45 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ad1ba5dff7so123230311fa.3
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 05:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684241739; x=1686833739;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ySTH1isvoYm6bPo8CerpAG+A4TnY2jdotYQJPV96/VE=;
        b=mDQUgzDbNyQGULqtfTRmDwXdZI64hyc5FDwTI0sSdZXeaRAwrWWRr/wcseR+fM/GXf
         ZTHJQobW0izs6ISDcDyI4tJ2NwTh2pDbeDKYdPLuq5jyhwcEi70XNGPXkGyW3Evo1LPB
         QHn/H77zwX7K7aWBISAD1Xa1UloaZwHSJ1h8ip5HXg3V8DCxjJxqiJ3Ki90wUC9AvqH9
         9KVOyj7G7Muf0VR48pykZnti36NYwbSZKTQSJ7DKbnAtbsqCS2xMwKQnLY0lpGqGEWm5
         cdHpGGLGSmGrpRI9aWWpOI3N8vB3XYKB+bpj94NFvw11Hx/BNRZSyFCQCHXnidXdAYy1
         IKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241739; x=1686833739;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySTH1isvoYm6bPo8CerpAG+A4TnY2jdotYQJPV96/VE=;
        b=bl07z4oxVSgPHlLSdKvQBqysi0Pq06reQUvDTyoQhSC6DELPe/NgGICKafOk0ktAKb
         fjroj0xvOUnuZNGNQMw9Ml9bJSVdkE39HinAPGKr0DUH6J7JrxKf2H1ngPBA4164BXlB
         0pttrj/CS/61RHGKxNGw64zFiEvyBvFbBTWegrPl5Bu/5pHgArxEAYoiVXCe0EG0MA69
         tjmU9r5SuE2NqclCaSW70X2wkKl9g+4+rY2iX6zELx+p+tPp1Jz2mtl/zEk/Ja86pOB8
         f2P8CAs4nOkeBvp1Xn9wuJ5Sv5Qqv1PuQtRv/xyhNZvHjFuuT8/rmUWOZx29pLrE3kov
         HhEQ==
X-Gm-Message-State: AC+VfDypTO6rtEW8+plcQpmHhAUAKrHVWKRcpAKeKVYi3FlLUt3S5rvF
        0KikabUofuED/hhgORtd9T3mojKAd1kNNRuByb8=
X-Google-Smtp-Source: ACHHUZ6hUDE9Y4NbCWu1WSvCWcAoILmE+WZ2SbeKiA0SfB5vevizVoq/0xGHaW2oqQB7ybnXxlenvQ==
X-Received: by 2002:a2e:9dca:0:b0:2ad:7943:4c15 with SMTP id x10-20020a2e9dca000000b002ad79434c15mr8235405ljj.14.1684241738790;
        Tue, 16 May 2023 05:55:38 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id o23-20020a2e7317000000b002add1f4a92asm1647789ljc.113.2023.05.16.05.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:55:38 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 0/7] DMA40 SRAM refactoring and cleanup
Date:   Tue, 16 May 2023 14:55:30 +0200
Message-Id: <20230417-ux500-dma40-cleanup-v3-0-60bfa6785968@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEJ9Y2QC/42NzQ6DIBAGX8VwLg0i/vXU92h6WGBVEgsG1NgY3
 73grZemx9nNN7OTgN5gILdsJx5XE4yzEYpLRtQAtkdqdGTCGS+YyGu6bCVjVL9AMKpGBLtMtEP
 RNbqVeatKEpcSAlLpwaohbV8QZvTpMXnszHbmHs/Igwmz8++zvubp+ju05pRRyauCi7asUNT30
 Vjw7up8T5Jw5X9IeJQoDVA1IGRTFV+S4zg+9Me/uxUBAAA=
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I started out by augmenting the STE DMA40 driver to get
its LCPA SRAM memory from a proper SRAM handle in the
device tree instead of as a reg cell, and then I saw
that the driver was in a bit of sad state so I did a bit
of cleanups on top.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v3:
- Rebased on v6.4-rc1
- Fixed a cast for a complaining print in probe()
- Collected ACKs on the DT bindings.
- Link to v2: https://lore.kernel.org/r/20230417-ux500-dma40-cleanup-v2-0-cdaa68a4b863@linaro.org

Changes in v2:
- Amendments to the bindings after review.
- Link to v1: https://lore.kernel.org/r/20230417-ux500-dma40-cleanup-v1-0-b26324956e47@linaro.org

---
Linus Walleij (7):
      dt-bindings: dma: dma40: Prefer to pass sram through phandle
      dmaengine: ste_dma40: Get LCPA SRAM from SRAM node
      dmaengine: ste_dma40: Add dev helper variable
      dmaengine: ste_dma40: Remove platform data
      dmaengine: ste_dma40: Pass dev to OF function
      dmaengine: ste_dma40: Use managed resources
      dmaengine: ste_dma40: Return error codes properly

 .../devicetree/bindings/dma/stericsson,dma40.yaml  |  36 ++-
 drivers/dma/Kconfig                                |   1 +
 drivers/dma/ste_dma40.c                            | 336 +++++++++------------
 .../dma-ste-dma40.h => drivers/dma/ste_dma40.h     | 101 +------
 drivers/dma/ste_dma40_ll.c                         |   3 +-
 5 files changed, 183 insertions(+), 294 deletions(-)
---
base-commit: a2f15a1753d590f30c07d439a04ec7e839cd2305
change-id: 20230417-ux500-dma40-cleanup-fe4f8d9b19c5

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

