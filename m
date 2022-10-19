Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE576039EA
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 08:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJSGkX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 02:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiJSGj5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 02:39:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43F62CDDA;
        Tue, 18 Oct 2022 23:39:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id 13so37515228ejn.3;
        Tue, 18 Oct 2022 23:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NkyW/luDE9b6kzwWThKyVIldspUZkmZ4I/VfofKXTto=;
        b=CJ3MZR3RVhHU4IETb7djPjp+RuFBzdc0ey7qnlsHdrSVHf/my6t8xZMmfEZAmR4Dpo
         Df8MLSxNOPTtBCINYnJgnrhMMlySwjTXDuE+impyOb22waxsWPuEOkBTTnxg1mg7Uc++
         l/IbJppYMzxAObqpFje5V4RQrCnzAumyxHe98RPQQwCzkCunoKnlNwttcgne9xYJtihc
         FOo1uqFU2PRTuxgLTNrBLSgMJOrpF73RaNKPfHPrGCRZLPHMXmEhx7lWSpaYwhuDxejh
         dC30tWUMm798mKXCh/b8Wh34m0fS+QDkS9CNV/37q/SDR+IwzSgafluiohyYzojBGzc7
         GImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkyW/luDE9b6kzwWThKyVIldspUZkmZ4I/VfofKXTto=;
        b=o5QYCvjx2bX29NBcoeyLlRliPDHhdbJIeM54DvEXBWwoWOoz0RV7dfwmUnqIHUY5Vd
         s54HbqaIcbJa1RmDqdqrHJ/hojd1SecIWEWW7V4FHl6LNDsgOK5wh5KJ3OvoBa7RLrP6
         K2WNRXFz35whu+1pulGVJRPH/wdGqKjo1vAywISf1i6VnHBM4DwkElEN6RJDCQgnT0jB
         QKXiqnJw+rltWO2q2vc3j3Xsf15kzsuP/btyPyWLsMR+/Af3CQkRFeNO6akjnMH9bOZ2
         vYvgll3sLETUElgrI1GB0A2+0vLowdKUUqXyWWTYWGbWiVlU1ER7MsqLKp1LesCtbbiL
         sahA==
X-Gm-Message-State: ACrzQf2kCUR9VEz639Zq3VwhWNIgnG5C3WFeBi8qFflTBDfnLfTFE7hO
        ZH3YQeW2JSkFYZr+IEXUZxY=
X-Google-Smtp-Source: AMsMyM4WZK563CNuIm80wbG26ULXMBUSM7BkuvVu6zQFFU8vG0kYk1w7M5SsjjhURrXVwV5KYWBqIQ==
X-Received: by 2002:a17:907:8a09:b0:78d:b81e:f92f with SMTP id sc9-20020a1709078a0900b0078db81ef92fmr5640412ejc.620.1666161581866;
        Tue, 18 Oct 2022 23:39:41 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-4-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.4.39])
        by smtp.gmail.com with ESMTPSA id fy19-20020a170906b7d300b00781dbdb292asm8467168ejb.155.2022.10.18.23.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 23:39:41 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 0/2] Add Ingenic JZ4755 DMA support
Date:   Wed, 19 Oct 2022 09:39:32 +0300
Message-Id: <20221019063934.3278444-1-lis8215@gmail.com>
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

Diffs from 3-rd patchset:
 - add missed tag reviewed-by

Diffs from 2-nd patchset:
 - tested JZ_SOC_DATA_BREAK_LINKS flag
 - fixed commit msg in the first patch

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

