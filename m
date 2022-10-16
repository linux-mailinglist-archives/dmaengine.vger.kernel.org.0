Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7FB600074
	for <lists+dmaengine@lfdr.de>; Sun, 16 Oct 2022 17:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJPPNl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Oct 2022 11:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJPPNj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Oct 2022 11:13:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C2E2A97A;
        Sun, 16 Oct 2022 08:13:38 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id s30so12875619eds.1;
        Sun, 16 Oct 2022 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/C5lwk/nMs2ZM6+Ipbgdt5+++HkO09MsMac4cJsw0kY=;
        b=HgvQG2CcfeYc2FI8sWyMP94qrofK/LCeIcTNxe/UZ3IfZG+b6kuCWdKMWGdIk5ejJh
         UjZe9e7SMP/4c0N4YBcBwcwc+EuUSsnQEnkWrTtmE6f5dNeQrdoOp8UT8EWfsgasu3nT
         jRWiPgRT2pmDuM0vEUmigqQJKnyoXsQKMfYBLXzJnwAkW37UV4RKQGyOqejc1SDExEls
         2YTosA/BGOKsT35asDVE9Eh+t3K2VbUwZPn/tVIA7ZVON6G7d90Auj9R7MJ/gJSjAhbC
         iPA1omuP+puKpBLtCd00DBe7N/cJWDP3uD4DsUGweF368mvZi55W07pL5K/yuxxl5qll
         kN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/C5lwk/nMs2ZM6+Ipbgdt5+++HkO09MsMac4cJsw0kY=;
        b=hl3aCVGRCx+qO2Y/ndboOGhOyu8iDaYW/1FEgjJi4UzL59ri0XfJYGzpKM0bWJnG6x
         OGFnRMVgHCVD1yTv7gj0m7hZg5ypoDqAu4N05dBz+MCk1tmGszWuJvBfikUKvDddEUw3
         jOn/ufN1/qn6gZMd4d3rSFoWV6QCVOjf06BMGp2/GkiFvFHMkcnlA0Q7xn/JgOugQslG
         6CRLC5E9RbzkzHp1sDCIthB4Fr/yLIEbJqIMofEYBiAOShs/DIe7+qvjjBrcHdlZja9k
         eJ1bxnFt4Mav8dFURX8UKe0hQOFmy80dEs5xfttii47VY4UTQ3fxIYp1WTG8SsV51dHk
         BLJw==
X-Gm-Message-State: ACrzQf2OAb+uUXRCSPIzRS6Ot6/EEUPZAJTNaONPgkMY/OGS/k3SoaGV
        nftXEyDNzt6ykAYa+PzUQSY=
X-Google-Smtp-Source: AMsMyM4KVbqkL8u6VEhOb2AMIH24wsn3G/75t2Uq+V3U5os3+a7gJM3qsEQyIxetM82NiN10AByxuQ==
X-Received: by 2002:a50:ec84:0:b0:459:ae8:8025 with SMTP id e4-20020a50ec84000000b004590ae88025mr6410063edr.321.1665933217388;
        Sun, 16 Oct 2022 08:13:37 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-7-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.7.39])
        by smtp.gmail.com with ESMTPSA id i8-20020a1709061e4800b0078d4c72e2cesm4702735ejj.44.2022.10.16.08.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 08:13:36 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 0/2] Add Ingenic JZ4755 DMA support
Date:   Sun, 16 Oct 2022 18:12:54 +0300
Message-Id: <20221016151256.3021729-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch serie adds JZ4755 SoC DMA support.

Diffs from 1-st patchset:
 - DMA patches splitted into its own patchset
 - acks collected

Siarhei Volkau (2):
  dt-bindings: ingenic: Add support for the JZ4755 dmaengine
  dmaengine: JZ4780: Add support for the JZ4755.

 Documentation/devicetree/bindings/dma/ingenic,dma.yaml | 1 +
 drivers/dma/dma-jz4780.c                               | 8 ++++++++
 2 files changed, 9 insertions(+)

-- 
2.36.1

