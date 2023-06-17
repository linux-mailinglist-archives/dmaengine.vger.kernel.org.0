Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9779073416A
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jun 2023 15:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345784AbjFQNm3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jun 2023 09:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbjFQNm1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Jun 2023 09:42:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262232120;
        Sat, 17 Jun 2023 06:42:23 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M42fA-1qAW6b2WIq-0001w1; Sat, 17 Jun 2023 15:36:41 +0200
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
Subject: [PATCH V2 3/7] ARM: dts: bcm2835: adjust DMA node names
Date:   Sat, 17 Jun 2023 15:36:16 +0200
Message-Id: <20230617133620.53129-4-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230617133620.53129-1-stefan.wahren@i2se.com>
References: <20230617133620.53129-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ct2vBejHpGEGdHWq2oaC2eYfFCkFI6GTVSpPBo78VNWnC4tGPu8
 IxLyyDIobwqnC488ZrvNjJxWx93U4lqZZ5gv/Hlty/Yfpgcdcr2E6R9u9qXX0KMXfNVUDCS
 0+I0eprUqEJnxgud62582/pX/S9dfV0Y01G9x4+8e1SswtQaldOhTY1KNFpZ2UIFtgdvWO0
 Jsd8sWLXbNnQyssP06jaw==
UI-OutboundReport: notjunk:1;M01:P0:FH94jq5umt8=;GO7QMgAUpFwd63iY3T32s3mv1Nh
 02BXvgrmy55DhZKOwlQgCjEpwoi1lA5XBvrADOyhcJKRprbUOxHDYUW7HkBIqQLbzA4mpc9oV
 jQM9mHKMd/FA9TDqDN5Zj9yQlpGiarhYX22BSaSMjCwAePPpLbh/H82iYumk3mCLnwe7nkOJr
 RSI2IqZI5jaM10hsDB5GtRkYd7fDm9bplaQhN2zBp86hlS9NjLxJQgoobotP3gmyfkUve6cPD
 Fkv305Ci4vnNG+ZouKozm70s1P1gZAN2W610RE5A3hhaX45dKBJ5KJK0M3rqnLzjxqd4lgi8y
 EYcc492aIptbpdR+fIpBOzlgCYWXOGxul7g1qKTRkNlf6VTXZODNLs2spCAgGUHidqBxksc/I
 bPbgf7I0xU+QVBFZXOCRP+oec0C4myy38kUxkHGKEyZ1khGBaWrG9N/IMuWe/ZUBI1pQCbbl5
 9+zSHg+INSWUHMguUzN9emNi+E64Fxzmpzbqel+0xxGhLpGD3spKcUM4Foh1YtxR74dj8L323
 EQ9aCsTENW19rcaY/gUn/ksaWNuAMSiem/ubIBA7BOgk0iK/CQs54/7tyXqZnmrPxzqAALgGR
 tPIeOBqUzZ/cCdF5AUMIhaH+8qLfGLNe0crR2VMAXkuVVlT1F6SUicyJ+jzi2+MEyrDwWE8SK
 nS7BwtEt+fFHRwYB8Uvr7Mbvmv1Uvqd7xfzMGhSJ8Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

After converting the bcm2835-dma DT binding to YAML, the DT schema
checks gave warnings like:

$nodename:0: 'dma@7e007000' does not match '^dma-controller(@.*)?$'

So fix them accordingly.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2711.dtsi        | 2 +-
 arch/arm/boot/dts/bcm2835-common.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 097e9f252235..d30c19311145 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -76,7 +76,7 @@ thermal: thermal {
 			};
 		};
 
-		dma: dma@7e007000 {
+		dma: dma-controller@7e007000 {
 			compatible = "brcm,bcm2835-dma";
 			reg = <0x7e007000 0xb00>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/bcm2835-common.dtsi b/arch/arm/boot/dts/bcm2835-common.dtsi
index bb7e8f7facaf..9261b67dbee1 100644
--- a/arch/arm/boot/dts/bcm2835-common.dtsi
+++ b/arch/arm/boot/dts/bcm2835-common.dtsi
@@ -8,7 +8,7 @@ / {
 	interrupt-parent = <&intc>;
 
 	soc {
-		dma: dma@7e007000 {
+		dma: dma-controller@7e007000 {
 			compatible = "brcm,bcm2835-dma";
 			reg = <0x7e007000 0xf00>;
 			interrupts = <1 16>,
-- 
2.34.1

