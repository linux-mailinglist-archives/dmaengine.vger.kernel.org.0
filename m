Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858D47D6849
	for <lists+dmaengine@lfdr.de>; Wed, 25 Oct 2023 12:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbjJYKWj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Oct 2023 06:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjJYKWi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Oct 2023 06:22:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F20123;
        Wed, 25 Oct 2023 03:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698229355; x=1729765355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ub36EsnDsZ4Pe9+1Jc9C5yZxVaCIMgDzhRw3P0KEHx8=;
  b=aZFaagPGLdt/hjnoy1S3UXvM3PwTq6+OW6DFmKPHN9Nk2OVVMMvP/Guh
   pd1YsQf8aC4JXHPDXARnJD1H8uODP6vL1QoRpoU9XNxmqeL9X6EDCqJ3T
   xtsKUyFDoZk9X6CkhUdRH8KinB6/kf84P9SKOjglZfvrPXPhO+lnVmtPE
   ryraka04PoBJAsLNgtWhYiUGE2uTMfbTMhSGrz7Gu0xN+iNqtPyhxmUXc
   MXSdIJeVjA13wlIhO2upGddo4WZlsvCKk2FNa0w+CtQNZtapov4lNrL9v
   WnzQU/5xwi8XufGcKUviO7CknD1815oz0zgOzqZ4K7OGZYaXPbw+bNUC2
   Q==;
X-CSE-ConnectionGUID: /1Fh5rPuRU6c46pvXDlHLA==
X-CSE-MsgGUID: /6oeDPW+RKiaEqgYvVPuFg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="177735248"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2023 03:22:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 25 Oct 2023 03:22:14 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 25 Oct 2023 03:22:09 -0700
From:   shravan chippa <shravan.chippa@microchip.com>
To:     <green.wan@sifive.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasuresh.relli@microchip.com>, <praveen.kumar@microchip.com>,
        <shravan.chippa@microchip.com>
Subject: [PATCH v3 4/4] riscv: dts: microchip: add specific compatible for mpfs' pdma
Date:   Wed, 25 Oct 2023 15:52:51 +0530
Message-ID: <20231025102251.3369472-5-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025102251.3369472-1-shravan.chippa@microchip.com>
References: <20231025102251.3369472-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Add specific compatible for PolarFire SoC for The SiFive PDMA driver

Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 104504352e99..f43486e9a090 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -221,7 +221,7 @@ plic: interrupt-controller@c000000 {
 		};
 
 		pdma: dma-controller@3000000 {
-			compatible = "sifive,fu540-c000-pdma", "sifive,pdma0";
+			compatible = "microchip,mpfs-pdma", "sifive,pdma0";
 			reg = <0x0 0x3000000 0x0 0x8000>;
 			interrupt-parent = <&plic>;
 			interrupts = <5 6>, <7 8>, <9 10>, <11 12>;
-- 
2.34.1

