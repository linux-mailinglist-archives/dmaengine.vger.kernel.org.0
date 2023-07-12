Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7599D7509E2
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 15:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjGLNpr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 09:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjGLNpq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 09:45:46 -0400
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 06:45:45 PDT
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D97E77;
        Wed, 12 Jul 2023 06:45:44 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1689169090; bh=9EOsQhAYQoUHrxxW1o4tOwQwmHnRQW2U6mF0UYSSSzM=;
        h=From:To:Cc:Subject:Date;
        b=eTM5xnnz3rQZ/KuptxBnqUJbtMSzL7q1JgVdE213d2Pyu+QPqJ+Ght27fhIg3OTJU
         N+aWLP/326GePEWx4LkSLz5n+DScz2WoA30A4TgxpNqAkYLVAF1R3JoFMx+Bt3/YoE
         L/itxbqcX0i1ICEXFEQ4Qt/tS1peqOrYvPb2yrag=
To:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     asahi@lists.linux.dev, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Apple SIO driver
Date:   Wed, 12 Jul 2023 15:38:04 +0200
Message-Id: <20230712133806.4450-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi all,

see attached a driver for the SIO coprocessor found on recent Apple
SoCs. This coprocessor provides general DMA services, it can feed
many peripherals but so far it seems it will only be useful for
audio output over HDMI/DisplayPort. So the driver here only supports
the DMA_CYCLIC mode of transactions with the focus being on audio.
There's a downstream prototype ALSA driver the DMA driver is being
tested against.

Some of the boilerplate code in implementing the dmaengine interface
was lifted from apple-admac.c. Among other things these two drivers
have in common that they implement the DMA_CYCLIC regime on top of
hardware/coprocessor layer supporting linear transactions only.

The binding schema saw two RFC rounds before and has a reviewed-by
from Rob.
https://lore.kernel.org/asahi/167693643966.613996.10372170526471864080.robh@kernel.org

Best regards,
Martin

Martin Povišer (2):
  dt-bindings: dma: apple,sio: Add schema
  dmaengine: apple-sio: Add Apple SIO driver

 .../devicetree/bindings/dma/apple,sio.yaml    | 111 ++
 MAINTAINERS                                   |   2 +
 drivers/dma/Kconfig                           |  10 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/apple-sio.c                       | 956 ++++++++++++++++++
 5 files changed, 1080 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/apple,sio.yaml
 create mode 100644 drivers/dma/apple-sio.c

-- 
2.38.3

