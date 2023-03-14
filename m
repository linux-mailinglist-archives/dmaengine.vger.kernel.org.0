Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE9D6B8855
	for <lists+dmaengine@lfdr.de>; Tue, 14 Mar 2023 03:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCNCUJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 22:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCNCUF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 22:20:05 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54061F5F7;
        Mon, 13 Mar 2023 19:20:03 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 32E249if072544;
        Tue, 14 Mar 2023 10:04:09 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from Chiawei-PC03.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 14 Mar
 2023 10:18:19 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <pmenzel@molgen.mpg.de>,
        <ilpo.jarvinen@linux.intel.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Subject: [PATCH v2 0/5] arm: aspeed: Add UART DMA support
Date:   Tue, 14 Mar 2023 10:18:12 +0800
Message-ID: <20230314021817.30446-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 32E249if072544
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch serias adds the 8250 driver with DMA support for AST26xx UART devices

v2 change:
 - re-write UDMA driver based on the DMAEngine framework
 - re-write 8250_aspeed driver with DMA support based on the 8250_dma implementation
 - remove virtual UART part as there is already a 8250_aspeed_vuart driver

Chia-Wei Wang (5):
  dt-bindings: serial: 8250: Add aspeed,ast2600-uart
  dt-bindings: dmaengine: Add AST2600 UDMA bindings
  dmaengine: aspeed: Add AST2600 UART DMA driver
  serial: 8250: Add AST2600 UART driver
  ARM: dts: aspeed-g6: Add UDMA node

 .../bindings/dma/aspeed,ast2600-udma.yaml     |  56 ++
 .../devicetree/bindings/serial/8250.yaml      |   1 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |   9 +
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/ast2600-udma.c                    | 528 ++++++++++++++++++
 drivers/tty/serial/8250/8250_aspeed.c         | 224 ++++++++
 drivers/tty/serial/8250/Kconfig               |   8 +
 drivers/tty/serial/8250/Makefile              |   1 +
 include/dt-bindings/dma/ast2600-udma.h        |  40 ++
 10 files changed, 877 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
 create mode 100644 drivers/dma/ast2600-udma.c
 create mode 100644 drivers/tty/serial/8250/8250_aspeed.c
 create mode 100644 include/dt-bindings/dma/ast2600-udma.h

-- 
2.25.1

