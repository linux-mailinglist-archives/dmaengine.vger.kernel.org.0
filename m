Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF224FC79B
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 00:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiDKWYb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 18:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350447AbiDKWYa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 18:24:30 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DB9120A3;
        Mon, 11 Apr 2022 15:22:12 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1649715729; bh=sR9jg0Nj8kxrQYQajwJteIktp3fl61AL5qcwFk2K7tQ=;
        h=From:To:Cc:Subject:Date;
        b=rfz1tOmqvJUjm/Lfm236pr7x7gGSSBZSCXgcaPqw+CVMwE1/LWH+RoXnIleotR9M4
         tY2VOPzM9c4s5LnF46W3ppwsnmcvhwKxZ17ObKZ+7AFufi9z2J6M+W4YtBLxfKoZCm
         OYTWjJaxFA2l4FixJCjlLnKs45nXaZU7NwMXpI8I=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH v2 0/2] Apple ADMAC driver
Date:   Tue, 12 Apr 2022 00:22:02 +0200
Message-Id: <20220411222204.96860-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi all,

I am submitting v2 of driver for Audio DMA Controller on recent Apple SoCs.

Changes since v1:
(link: https://lore.kernel.org/dmaengine/20220330164458.93055-1-povik+lin@cutebit.org/ )
 - in binding, drop 'apple,internal-irq-destination' in favor of
   prepending entries to 'interrupts'
 - drop admac_peek/poke helpers
 - use special versions of dev_err/WARN_ON where desirable, fix %pad
   formatter invocation
 - bring implementation of terminate_all up to dmaengine spec, add
   device_synchronize
 - minor fixes (comments, formatting)

Thanks,
Martin

Martin Povišer (2):
  dt-bindings: dma: Add Apple ADMAC
  dmaengine: apple-admac: Add Apple ADMAC driver

 .../devicetree/bindings/dma/apple,admac.yaml  |  68 ++
 MAINTAINERS                                   |   2 +
 drivers/dma/Kconfig                           |   8 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/apple-admac.c                     | 818 ++++++++++++++++++
 5 files changed, 897 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/apple,admac.yaml
 create mode 100644 drivers/dma/apple-admac.c

-- 
2.33.0

