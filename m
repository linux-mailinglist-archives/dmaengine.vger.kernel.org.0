Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDF55EAF9D
	for <lists+dmaengine@lfdr.de>; Mon, 26 Sep 2022 20:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiIZSWe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 14:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIZSWR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 14:22:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973A86DAD7
        for <dmaengine@vger.kernel.org>; Mon, 26 Sep 2022 11:18:51 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x1so6991778plv.5
        for <dmaengine@vger.kernel.org>; Mon, 26 Sep 2022 11:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=rIz+YVCWQEzDHQRlSVGwiOtQbNrDXFyRyCGAYlDeXiE=;
        b=JxTKMC9ecZ6Lsd8C2v33eWyE4w1t7rpwcAJRAdIsjLMvwlzuxTRHgkfkKE9eNLT4js
         ycINImcLg+dVTF4zZPzorndtoxBcKzq77PMCaPsa09sNWRC9ghS8qilPj1mZgPKSBYrC
         oJ0NxCVtvJH+5XY8zaYLUPbMYTJxnCTPvYwEYq7PkPuk2vWrD+9UCXVorLVboWvZB7/7
         XuMoqPZcKBQqXGU0L956kzHuFLTO3cUaqOHjKQyU6uGNzAjcm1vNf+azAjztU11SGNFv
         F/X/8Gqdt4UjRNE2nRRKiqqgDBsG512XIxF8ZE13RuaeBDP+7ZSvUmMakn1d/sV/YJYu
         rdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=rIz+YVCWQEzDHQRlSVGwiOtQbNrDXFyRyCGAYlDeXiE=;
        b=QmMaH2hybOFLZvm6S3138D8mKtVZtNoTvRLP/2auQFvKoL+WoV4aE1yM1E36xgWmnt
         Z/jg2J9hLJ0+edGemMPwDBu57Zh+mB3VCrq9M1litGWz0I7A+4l/H+lb9Pn0gpPjoAId
         zpaU91SR4qi4rmquCbTmigf6KKag5TKSlrlod4YRUKlYUnF52zJnssXAnzUjToL6xpoX
         qdGXgBQE6/Uq0CzTgIlTULVhnOwS87Ade7BPD0uZUk6q3/0yvHv2yzjXq83cBHcbkdaS
         twILjCqT3zg0QQrBU+GNtLtd1skjeb7ouYxSJVzT5ECRDM8ByjyLBFr17ZmN4kmroQo+
         trSw==
X-Gm-Message-State: ACrzQf1mbM84T98nvsLoRqKgn/Z+Cdu6hvM1EdyvNsQeW3vh85hN1L70
        KqIRnoypBQVaB30rO1tCamCs/NLutofkiGxzjeo=
X-Google-Smtp-Source: AMsMyM5Lv6dmRrTn5a6riTia7xG2Zbj1vdm5Gq7FU2UkiZf/hv+9i8FeM4YJVZwXyJVppwt1ju9dcA==
X-Received: by 2002:a17:90b:1b51:b0:203:25f0:c25e with SMTP id nv17-20020a17090b1b5100b0020325f0c25emr26086pjb.65.1664216329994;
        Mon, 26 Sep 2022 11:18:49 -0700 (PDT)
Received: from localhost ([76.146.1.42])
        by smtp.gmail.com with ESMTPSA id g189-20020a6252c6000000b0053e47dcfa32sm12506252pfb.155.2022.09.26.11.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:18:49 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: [PATCH 0/3] dma/ti: enable udma and psil to be built as modules
Date:   Mon, 26 Sep 2022 11:18:45 -0700
Message-Id: <20220926181848.2917639-1-khilman@baylibre.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Enable the UDMA driver & glue and PSIL maps to be built & loaded as modules.

The defauilt Kconfig settings are not changed, so default upstream is
still to be built in.  This series just enables the option to build as
modules.

Kevin Hilman (3):
  of/irq: export of_msi_get_domain
  dma/ti: convert k3-udma to module
  dma/ti: convert PSIL to be buildable as module

 drivers/dma/ti/Kconfig          |  7 +++---
 drivers/dma/ti/k3-psil-am62.c   |  4 ++++
 drivers/dma/ti/k3-psil-am64.c   |  4 ++++
 drivers/dma/ti/k3-psil-am654.c  |  4 ++++
 drivers/dma/ti/k3-psil-j7200.c  |  4 ++++
 drivers/dma/ti/k3-psil-j721e.c  |  4 ++++
 drivers/dma/ti/k3-psil-j721s2.c |  4 ++++
 drivers/dma/ti/k3-psil.c        |  2 ++
 drivers/dma/ti/k3-udma-glue.c   |  5 ++++-
 drivers/dma/ti/k3-udma.c        | 40 +++++----------------------------
 drivers/of/irq.c                |  1 +
 11 files changed, 40 insertions(+), 39 deletions(-)

-- 
2.34.0

