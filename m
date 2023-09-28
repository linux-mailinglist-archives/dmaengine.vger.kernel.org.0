Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BF57B1C0B
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 14:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjI1MUP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 08:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjI1MUO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 08:20:14 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F28A19C;
        Thu, 28 Sep 2023 05:20:13 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690d2441b95so9843033b3a.1;
        Thu, 28 Sep 2023 05:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695903612; x=1696508412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g1pjsCLdQyTOGga6KmFwQldd7AdXkYw/Qb2m0NHdZcs=;
        b=jJ+FB9zP/zUQnALZ5meNM1NyBC+9jHngO6OhUhTBtg1GZvdJI2Kvp7ZPuT+lN58XuB
         EPV7lbHgMzVWj8SfMvsIdElQPmNQAFapp5orqUU+vrTIbl0Q5mC2UALTQ3EYDq0irDk3
         L29jbo+CuQGgpixfuzhkruUEMrm/edRub3Inc9lFCyaR1EZ07WaQKD1DnqU6vSTHS0zu
         ifXHwHKc06EWP53osU1lxxha4ehvanmUT37jiDOiBM3lUEcxAemNF6rsRfaQpufIE0FX
         pdXCQvq9ub/3RE6UC1rQ8b4VfvqHeuxKQPXXN6sZyMWKeKv/1v+XRhzNZBye+E/Eripy
         JrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695903612; x=1696508412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1pjsCLdQyTOGga6KmFwQldd7AdXkYw/Qb2m0NHdZcs=;
        b=pcnm2Nl1Vd7JXILfnlHtJNNzSZwqSR5Heu7+HZctDRk/clFa+aFoHEhKeCe1OM5tLF
         A9n9ptg2ltA6jEQBIZzcQYjIwohlZYveBMRgotQz2ZGmlnnpZSD295HLZLqloRKeCPTA
         z5yUTu/tYs2ngs/ulAzkHOM2oVPiVSt7XYDb8edZtGdKP3R+tOkDOlcMNXvQ0QLl86AK
         BkB7IGSaQbPX636KKm1SSpikHoxz3OZ2Z08iyoF8J6vdkehDsGQYhpP/zWsGTSO4K9O8
         hCzDwJxc/WmNzyVrgisgrJiMZRbhidLsyhdBgomkaqkEAos9TCRg5nhDIY5oFBnUc+m/
         CtWA==
X-Gm-Message-State: AOJu0YwRKXF2lnv6TWVMVqdEDu2Jl0u6BsgHo1PXXGFSwrzi3TTrGC3x
        z/x+/XAdwkezmPG6GF/ouGZo300sd9/djA==
X-Google-Smtp-Source: AGHT+IGcG8ick4hM88UeHp0k1vJOsBsFkssnDTZkBiowtzYErHpHB48oNSISMSQzJLX9Ww1Hi7dg7A==
X-Received: by 2002:a05:6a20:9188:b0:125:3445:8af0 with SMTP id v8-20020a056a20918800b0012534458af0mr1765357pzd.7.1695903612452;
        Thu, 28 Sep 2023 05:20:12 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id r20-20020aa78b94000000b006933f85bc29sm2183219pfd.111.2023.09.28.05.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:20:12 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v5 0/2] Add Loongson1 dmaengine driver
Date:   Thu, 28 Sep 2023 20:19:51 +0800
Message-Id: <20230928121953.524608-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DMA driver and dt-binding document for Loongson1 SoCs.

Changelog
V4 -> V5:
   Add the dt-binding document
   Add DT support
   Use DT information instead of platform data
   Use chan_id of struct dma_chan instead of own id
   Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
   Update the author information to my official name
V3 -> V4:
   Use dma_slave_map to find the proper channel.
   Explicitly call devm_request_irq() and tasklet_kill().
   Fix namespace issue.
   Some minor fixes and cleanups.
V2 -> V3:
   Rename ls1x_dma_filter_fn to ls1x_dma_filter.
V1 -> V2:
   Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
   and rearrange it in alphabetical order in Kconfig and Makefile.
   Fix comment style.

Keguang Zhang (2):
  dt-bindings: dma: Add Loongson-1 DMA
  dmaengine: Loongson1: Add Loongson1 dmaengine driver

 .../bindings/dma/loongson,ls1x-dma.yaml       |  64 +++
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/loongson1-dma.c                   | 492 ++++++++++++++++++
 4 files changed, 566 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
 create mode 100644 drivers/dma/loongson1-dma.c


base-commit: 719136e5c24768ebdf80b9daa53facebbdd377c3
-- 
2.39.2

