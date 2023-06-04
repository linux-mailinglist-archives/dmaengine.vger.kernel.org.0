Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282F97216BA
	for <lists+dmaengine@lfdr.de>; Sun,  4 Jun 2023 14:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjFDMNc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Jun 2023 08:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjFDMN1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Jun 2023 08:13:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FB0120;
        Sun,  4 Jun 2023 05:13:25 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N8X9L-1qATOr2RN3-014UNu; Sun, 04 Jun 2023 14:12:40 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 00/10] ARM: dts: bcm283x: Improve device-trees and bindings
Date:   Sun,  4 Jun 2023 14:12:13 +0200
Message-Id: <20230604121223.9625-1-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:InVEfdF7FbcX0KjLtcf4OB5k41Snq4cQeb8Dl3ZMTAcW/5Y7se2
 e8TraZ1VjDOR9ql4stiw/IB7ANuI+JBbtvUEdREnZZtwDBBgmUbsUl/aQXeBSzrv2yUqqiU
 cxf46dwxtPGaQvwFle7jdHAYJW+0oFK/zP6Hq5Dr1TC/Cca1XJ3fVG/NwBX6TQfB0i8GNPD
 3W4mEiGZbUjwAwZR7oQPg==
UI-OutboundReport: notjunk:1;M01:P0:CDQ8hyV3H/8=;un1GSPShwLUxKic0L6A8g8PZey8
 QD/mvQZb1L5BvhZvj95vPc3tHMQc2kisNg2gHaR0nTj4OREOjcfYSp+QBfnSqEDYsJhW9mb/p
 5MEjT/yATzTwnekOEc0Qw3AMzkCZE4+gV0FlpLp4dOvWAxpv8ugn9j2wNZsAhCNr8TM5Zut3E
 n96PWUdoNQpl8XhaGDUQhqzmn3tWWj0w2/uakrLwJNojpAaLdCNMH9OJGncgGal85ERbhJuXg
 SgWg9Zr/kSbqYqgnl+8/cbfBpETphM0uQrTGg2MSb1Bfi9AWhaWe4ph2R1AO1vLS2ijuGv7ks
 Wu3iY/gv1lbsL0867HHMdj5gHTPQapyEPtt28MHZ3pCGz7FwtND28d0HbsNhDiR2gSDtuegsW
 V+yrw4/XF5vjUs6y+iqV7Q1aQXfRiKtH9/EcYLu83tt0q7yHk08395jouKFLdScjpc4QXb1+5
 4RbV6xWXAQU2wACUMPVgMP8XK5O8vv1y7+RsZlrnFPgvuq67LL+sKytnuRvbjGXTO/+d2XWTj
 EZ0Zohats+ZLs+YbF6G6tZGmg1MaP+n06WyBTghAI/IbK1FaKzxowHXYaLHX6c8ixNXRDgRUP
 tyG7EN/8Q1r9H6BAyB+Ea9TxpGOvKCElf2YDYXVsYTRFpniikIwULiSzeWi+sDantZ8SZ03TF
 Mpkv2XtRlTAS8lQ4hS/S8SN5f7VURFnuUr1uLd8Sjg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series fix some dtbs_check warning for the Raspberry Pi boards
and convert 6 txt DT bindings for BCM2835 to YAML.

Please be aware that there is a functional dependency between patch 2
and 4. So just cherry-picking patch 4 would break boot of BCM2835.

Stefan Wahren (10):
  ARM: dts: bcm283x: Fix pinctrl groups
  dmaengine: bcm2835: also support generic dma-channel-mask
  dt-bindings: dma: convert bcm2835-dma bindings to YAML
  ARM: dts: bcm2835: adjust DMA nodes
  dt-bindings: pwm: convert pwm-bcm2835 bindings to YAML
  ARM: dts: bcm283x: Increase pwm-cells
  dt-bindings: mailbox: convert bcm2835-mbox bindings to YAML
  dt-bindings: mmc: convert bcm2835-sdhost bindings to YAML
  dt-bindings: thermal: convert bcm2835-thermal bindings to YAML
  dt-bindings: timer: convert bcm2835-system-timer bindings to YAML

 .../bindings/dma/brcm,bcm2835-dma.txt         | 83 ----------------
 .../bindings/dma/brcm,bcm2835-dma.yaml        | 98 +++++++++++++++++++
 .../bindings/mailbox/brcm,bcm2835-mbox.txt    | 26 -----
 .../bindings/mailbox/brcm,bcm2835-mbox.yaml   | 40 ++++++++
 .../bindings/mmc/brcm,bcm2835-sdhost.txt      | 23 -----
 .../bindings/mmc/brcm,bcm2835-sdhost.yaml     | 54 ++++++++++
 .../devicetree/bindings/pwm/pwm-bcm2835.txt   | 30 ------
 .../devicetree/bindings/pwm/pwm-bcm2835.yaml  | 43 ++++++++
 .../bindings/thermal/brcm,bcm2835-thermal.txt | 41 --------
 .../thermal/brcm,bcm2835-thermal.yaml         | 48 +++++++++
 .../timer/brcm,bcm2835-system-timer.txt       | 22 -----
 .../timer/brcm,bcm2835-system-timer.yaml      | 44 +++++++++
 arch/arm/boot/dts/bcm2711.dtsi                |  6 +-
 arch/arm/boot/dts/bcm2835-common.dtsi         |  4 +-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts      |  1 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts           |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts      |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts      |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts           |  1 +
 arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts     |  1 +
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts      |  2 +
 arch/arm/boot/dts/bcm2835-rpi-zero.dts        |  1 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi            |  2 -
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts         |  1 +
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts     |  1 +
 arch/arm/boot/dts/bcm2837-rpi-zero-2-w.dts    |  2 +
 arch/arm/boot/dts/bcm283x.dtsi                |  2 +-
 drivers/dma/bcm2835-dma.c                     | 18 ++--
 28 files changed, 358 insertions(+), 239 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-bcm2835.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.yaml

-- 
2.34.1

