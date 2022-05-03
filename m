Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5850517DE1
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 08:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiECG6a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 02:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiECG6M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 02:58:12 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2BD18E2E
        for <dmaengine@vger.kernel.org>; Mon,  2 May 2022 23:54:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z99so18827048ede.5
        for <dmaengine@vger.kernel.org>; Mon, 02 May 2022 23:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Om7E3tZCgwxeaQekqleJAaOkpjdc9uO+KkphkJXZIw=;
        b=A5vc+vTpsI6Dz+CvfDMeY1y0K9VrnUu4BmfVN+yowooh0lh7bhFU36TXpJpn8s0khO
         /1u4E6S4WRv5qnTOf0jYVIczlKGwzwuCym9vysqhYZC5c+MIM1XKTmvwJvBOJdIoYtn4
         W2NcUjn6L4SDNhLl5mL75j3wYzZgzOD4xg3Ia8nKZfyehozs4ylZM4VoBtJhyQG5FLB3
         o8rA3+UzsrKxUtBL6qF/nYXmIku+g6RoRv4TcWl2WUTgXM0AKXpvCoZxcTbXaoaARisa
         SMVC7s3EgM9x6k0cpFNrVhp/I33PsdX+wQS9Bc/ktaxfavt0YRprTAJR11ro3I5p0J0U
         f2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Om7E3tZCgwxeaQekqleJAaOkpjdc9uO+KkphkJXZIw=;
        b=5QwE0CF7hNwrBCX8VucltMI3NxtuJtIxQ/EEkkg0beLGep5nrK+zLJGRDoGBpIXMaU
         cg09msSbC9hogHTegjX8yzwkRtYsG/z1eiY+b26VRS+FkBffKrlE0Ed+6vtPQrNLTDZ6
         CA2vh9Dz4JSegiR1WIafp+Pf/o+6pgWRw8uvmXAP011jHHFhblYdBpQzM+0zHyglHYFk
         RuPT9qNdc+nekEVmFBZIra+MkwcT2ahvk66A0eJlU9ghMjHvxSDgqon3sLfVjK2SGsnI
         LCtygSwJHgUchgZBnWz7VNesrPXMHuFLb9QYexoX3Unphyb8/Uarb4li2621T/Tq1Qej
         SFsw==
X-Gm-Message-State: AOAM532HxzSJbz/LnHxXAfFWqhDQlt1YxGy0t+FCg6UgcEr5Y8lfHB1L
        +DlINr2JKu7AOAM+1/tVmUJ7xg==
X-Google-Smtp-Source: ABdhPJy/soHkx3KrZDjY+Xw2pSTuOspk0j5nJMh8MXun24XmQC02uczGjygli3btUhMvuX7AmFGX1A==
X-Received: by 2002:a50:954b:0:b0:41a:c9cb:8778 with SMTP id v11-20020a50954b000000b0041ac9cb8778mr16638414eda.165.1651560855140;
        Mon, 02 May 2022 23:54:15 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l23-20020aa7c3d7000000b0042617ba6396sm7565326edr.32.2022.05.02.23.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 23:54:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/4] ARM: dts: pxa: use new 'dma-channels/requests' properties
Date:   Tue,  3 May 2022 08:54:07 +0200
Message-Id: <20220503065407.52188-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503065407.52188-1-krzysztof.kozlowski@linaro.org>
References: <20220503065407.52188-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The '#dma-channels' and '#dma-requests' properties were deprecated in
favor of these defined by generic dma-common DT bindings.  Add new
properties while keeping old ones for backwards compatibility.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/mmp2.dtsi   | 2 ++
 arch/arm/boot/dts/pxa25x.dtsi | 5 ++++-
 arch/arm/boot/dts/pxa27x.dtsi | 5 ++++-
 arch/arm/boot/dts/pxa3xx.dtsi | 5 ++++-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 46984d4c5224..987d792f67ea 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -275,7 +275,9 @@ dma-controller@d4000000 {
 				compatible = "marvell,pdma-1.0";
 				reg = <0xd4000000 0x10000>;
 				interrupts = <48>;
+				/* For backwards compatibility: */
 				#dma-channels = <16>;
+				dma-channels = <16>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
index a248bf038033..5f8300e356ad 100644
--- a/arch/arm/boot/dts/pxa25x.dtsi
+++ b/arch/arm/boot/dts/pxa25x.dtsi
@@ -38,9 +38,12 @@ pdma: dma-controller@40000000 {
 			compatible = "marvell,pdma-1.0";
 			reg = <0x40000000 0x10000>;
 			interrupts = <25>;
-			#dma-channels = <16>;
 			#dma-cells = <2>;
+			/* For backwards compatibility: */
+			#dma-channels = <16>;
+			dma-channels = <16>;
 			#dma-requests = <40>;
+			dma-requests = <40>;
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index ccbecad9c5c7..a2cbfb3be609 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -12,9 +12,12 @@ pdma: dma-controller@40000000 {
 			compatible = "marvell,pdma-1.0";
 			reg = <0x40000000 0x10000>;
 			interrupts = <25>;
-			#dma-channels = <32>;
 			#dma-cells = <2>;
+			/* For backwards compatibility: */
+			#dma-channels = <32>;
+			dma-channels = <32>;
 			#dma-requests = <75>;
+			dma-requests = <75>;
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index d19674812cd2..f9c216f91865 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -122,9 +122,12 @@ pdma: dma-controller@40000000 {
 			compatible = "marvell,pdma-1.0";
 			reg = <0x40000000 0x10000>;
 			interrupts = <25>;
-			#dma-channels = <32>;
 			#dma-cells = <2>;
+			/* For backwards compatibility: */
+			#dma-channels = <32>;
+			dma-channels = <32>;
 			#dma-requests = <100>;
+			dma-requests = <100>;
 			status = "okay";
 		};
 
-- 
2.32.0

