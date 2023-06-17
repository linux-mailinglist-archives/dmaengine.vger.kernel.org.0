Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF3C73414D
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jun 2023 15:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbjFQNhK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jun 2023 09:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjFQNhI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Jun 2023 09:37:08 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B270AE72;
        Sat, 17 Jun 2023 06:37:06 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MCsLo-1qJHWx2N3Q-008rdh; Sat, 17 Jun 2023 15:36:39 +0200
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
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 0/7] ARM: dts: bcm283x: Improve device-trees and bindings
Date:   Sat, 17 Jun 2023 15:36:13 +0200
Message-Id: <20230617133620.53129-1-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YcK/WR3T6hRaLw1AnRYEOWbBdCZO9EhCjZdqdqs73nVdKHWNmCZ
 20NQGWbCY/hqlHi3SeaUojIUqSFa4Zp6DkL7MTtmuyaro5Z0MGjEd2SOK7KkLRSUl+pJQVo
 vhKkfgNjXl56DrXFxTBMKAF0aaqicxN8CLwL/u+Afz89D8nChAO6OTEK1sMlQEs/Tbiz6IV
 HfyVn1YxUq8qCgMf71InA==
UI-OutboundReport: notjunk:1;M01:P0:WRpEgt448HQ=;Jrx4hK3B7Q3em0TSzh5wtA+CGrh
 x5IVkZUABea9X6Ymu3965wxvZwVk6bzg5CJC3GpRtVdZs0yAJvJJuRmLQgb6RdBgY7u9yftA3
 JadzRKSiEIcXX7DZGHN8YbxhU2tWn+k6vugMS+kRF9Y2M1wVdd68wT4igPjydHir0pDkT3FgR
 FnimddScYqvul10fN05NYrjQuNbZ+Izd5Z7pSjX3nPlWpi+a1PdLu+piSUXMXu4+8qMfcPXIm
 PvkmsEkhM48Nef7MObzLGcKVzAtgdy3dwqu+1uGiz/5guJM5zY6Ju6XDNat2EjGwW45vKjp/7
 lm2yMqXiedbMX38XwhfRcJqyfuAoGmE1PwyJDeZE8migVNlC4Iv0ZFay86jd+oyZ+gQo26Rjy
 rCwKbjat3YcvZlfX1AYjK5IlPPpk+JOvuZeAerP7K5VyLprj3J7wj1Uym+SyImJZ9/809uv1G
 UCnTWrgqHUN3deThwTuR1t1rh+qkwBtkLjrhDKdF41TpHvyWePcZzGOgcxan+SOczFDZ+DtOG
 u27BWXSESaUJdxvGSTw0Hh41bJwqvxVY986XgzkVTIRal2SV1cTOPcd9oCR+RoVUD0xpuDflt
 eDUkzlY3f8W1qdkMwO22qRZlBcGewAeeum+ryOFpy0vtYdssiHWNsYsCdm0i0QLwssiVscG4W
 u0CfwhSWbkgnmfwXUKcpxJKUodnNmNriu5vxZ1X1eA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series fix some dtbs_check warning for the Raspberry Pi boards
and convert 4 txt DT bindings for BCM2835 to YAML.

Changes in V2:
- drop already applied patches (bcm2835-sdhost, bcm2835-thermal)
- drop patch "dmaengine: bcm2835: also support generic dma-channel-mask"
- keep brcm,bcm2835-dma for ABI compatibility which also resolve
  dependency between patch 2 and 3
- drop quotes in patch 2 as noted by Rob Herring
- add interrupt description as suggested by Rob
- add Rob's and Uwe's Reviewed-by


Stefan Wahren (7):
  ARM: dts: bcm283x: Fix pinctrl groups
  dt-bindings: dma: convert bcm2835-dma bindings to YAML
  ARM: dts: bcm2835: adjust DMA node names
  dt-bindings: pwm: convert pwm-bcm2835 bindings to YAML
  ARM: dts: bcm283x: Increase pwm-cells
  dt-bindings: mailbox: convert bcm2835-mbox bindings to YAML
  dt-bindings: timer: convert bcm2835-system-timer bindings to YAML

 .../bindings/dma/brcm,bcm2835-dma.txt         |  83 --------------
 .../bindings/dma/brcm,bcm2835-dma.yaml        | 102 ++++++++++++++++++
 .../bindings/mailbox/brcm,bcm2835-mbox.txt    |  26 -----
 .../bindings/mailbox/brcm,bcm2835-mbox.yaml   |  40 +++++++
 .../devicetree/bindings/pwm/pwm-bcm2835.txt   |  30 ------
 .../devicetree/bindings/pwm/pwm-bcm2835.yaml  |  43 ++++++++
 .../timer/brcm,bcm2835-system-timer.txt       |  22 ----
 .../timer/brcm,bcm2835-system-timer.yaml      |  48 +++++++++
 arch/arm/boot/dts/bcm2711.dtsi                |   4 +-
 arch/arm/boot/dts/bcm2835-common.dtsi         |   2 +-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts      |   1 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts           |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts      |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts      |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts           |   1 +
 arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts     |   1 +
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts      |   2 +
 arch/arm/boot/dts/bcm2835-rpi-zero.dts        |   1 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi            |   2 -
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts         |   1 +
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts     |   1 +
 arch/arm/boot/dts/bcm2837-rpi-zero-2-w.dts    |   2 +
 arch/arm/boot/dts/bcm283x.dtsi                |   2 +-
 23 files changed, 250 insertions(+), 167 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-bcm2835.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.yaml

-- 
2.34.1

