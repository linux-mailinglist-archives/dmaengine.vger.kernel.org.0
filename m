Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768AC3059CB
	for <lists+dmaengine@lfdr.de>; Wed, 27 Jan 2021 12:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhA0Lb6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Jan 2021 06:31:58 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:35838 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236717AbhA0L3s (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Jan 2021 06:29:48 -0500
X-UUID: 7dff87075e6c444089ec717bc6c2c005-20210127
X-UUID: 7dff87075e6c444089ec717bc6c2c005-20210127
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 137809370; Wed, 27 Jan 2021 19:28:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Jan 2021 19:28:50 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Jan 2021 19:28:50 +0800
From:   EastL Lee <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <cc.hwang@mediatek.com>,
        <joane.wang@mediatek.com>, <adrian-cj.hung@mediatek.com>,
        EastL Lee <EastL.Lee@mediatek.com>
Subject: [PATCH v1 2/3] arm64: dts: mt6779: add emi node
Date:   Wed, 27 Jan 2021 19:28:43 +0800
Message-ID: <1611746924-12287-3-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1611746924-12287-1-git-send-email-EastL.Lee@mediatek.com>
References: <1611746924-12287-1-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C8BF7FB8F1D466F43B7C63376E1CD6C4A3A421856A34155B634B138D7946A9032000:8
X-MTK:  N
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

add emicen & emichn & emimpu node

Signed-off-by: EastL Lee <EastL.Lee@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt6779.dtsi | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
index 370f309..bb34537 100644
--- a/arch/arm64/boot/dts/mediatek/mt6779.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
@@ -267,5 +267,39 @@
 			#clock-cells = <1>;
 		};
 
+		emichn: emichn@10235000 {
+			compatible = "mediatek,mt6779-emichn",
+				"mediatek,common-emichn";
+			reg = <0 0x10235000 0 0x1000>,
+				<0 0x10245000 0 0x1000>;
+		};
+
+		emicen: emicen@10219000 {
+			compatible = "mediatek,mt6779-emicen",
+				"mediatek,common-emicen";
+			reg = <0 0x10219000 0 0x1000>;
+			mediatek,emi-reg = <&emichn>;
+		};
+
+		emimpu:emimpu@10226000 {
+			compatible = "mediatek,mt6779-emimpu",
+				"mediatek,common-emimpu";
+			reg = <0 0x10226000 0 0x1000>;
+			mediatek,emi-reg = <&emicen>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH 0>;
+			region_cnt = <32>;
+			domain_cnt = <16>;
+			addr_align = <16>;
+			ap_region = <31>;
+			ap_apc = <0 5 5 5 0 0 6 5>,
+				<0 0 5 0 0 1 5 5>;
+			dump = <0x1f0 0x1f8 0x1fc>;
+			clear = <0x160 0xffffffff 16>,
+				<0x200 0x00000003 16>,
+				<0x1f0 0x80000000 1>;
+			clear_md = <0x1fc 0x80000000 1>;
+			ctrl_intf = <1>;
+			slverr = <0>;
+		};
 	};
 };
-- 
1.9.1

