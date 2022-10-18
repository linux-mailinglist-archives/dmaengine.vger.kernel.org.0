Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5639603210
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 20:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJRSMm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Oct 2022 14:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJRSMl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Oct 2022 14:12:41 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940F272EFF;
        Tue, 18 Oct 2022 11:12:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a67so21684363edf.12;
        Tue, 18 Oct 2022 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0VMhEw6A+aSvGOO26gUnQiblD9gpJMmCJCEvdj8W2U=;
        b=cu+tVIsRIWSDpplKSwzcG6YzsQV6pgOoPb3lPUTIolJFAj1vFR6+JqITBkbQZxp1wZ
         UkzGhwfHc+CXk1HJrxmQQvHuWjkrd5ZZsJG0QRuHeMAnZRkQ6Kkb5Snxqzdz4CAAApY0
         Ss1ddMV/069i1zY+q9nzaUjLWbofAH2QnRihHCr92XHoiOVqenGEEoU/ky2kFdD7rjdg
         HLfxOXS09B7tRAvbrYn+4OomNRyqBVjJzbDldK6UeD1O3fTvXWgQ/b42sKfFxjRSqFCh
         0Zs1o9BxW1l4Sgy52eEmO0GLAdVDdLk4iCCWzO4AQ/3npJk0dwXC8y5vmcPNa5ejbkoO
         eVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0VMhEw6A+aSvGOO26gUnQiblD9gpJMmCJCEvdj8W2U=;
        b=cDN7xavJUtxG7mNSbKF1N7WQM8piTnNo5lwVexzWi2MUcWHRFBAG11X76MNHnRPcL/
         peZi7P9cHgbmSOlJIg7GeC0g1lmNy7f8kF4gayA2g1r4wL58xJjG9MEalmWLySzSmmR2
         rkCQRIQUDEDVqHAcXCjttDEl0E/Cmse+AMXW3ZnZhc04QwnVKVB9tPtrX4UQ0zpVegGL
         lY+GDfyO6tw8x/MyrdCcePqME6IHq9X2WikRpB1dBz2VM0waFZAq5zZ0WpyRpoh7j5zF
         dKp3ZqZqdcvJIDbTZY9gi23IExL5Tx7YpmYcBDJKvZOpWHq3JpJdyTDzPn4av3DAiN/y
         rZPg==
X-Gm-Message-State: ACrzQf0MXyo3fCL5wljv027S3GjrdBPErmusKfEsCNgnYrPn4zpVa6j3
        crcq4Qs6C2RYe0N7F9pwOqM=
X-Google-Smtp-Source: AMsMyM7WGImnEwWAwMvvvcJituHxZP4Q0GqvcmcaJRRBF12jZGvntSC0EPqSZ4HamN8M4Gx90aZiNw==
X-Received: by 2002:a05:6402:27c6:b0:45d:ba4d:c9cf with SMTP id c6-20020a05640227c600b0045dba4dc9cfmr3873897ede.17.1666116759046;
        Tue, 18 Oct 2022 11:12:39 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-1-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.1.39])
        by smtp.gmail.com with ESMTPSA id u22-20020a056402111600b00458dc7e8ecasm9253043edv.72.2022.10.18.11.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:12:38 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 0/2] Add Ingenic JZ4755 DMA support
Date:   Tue, 18 Oct 2022 21:12:17 +0300
Message-Id: <20221018181219.3251309-1-lis8215@gmail.com>
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

