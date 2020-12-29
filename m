Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00ECC2E742C
	for <lists+dmaengine@lfdr.de>; Tue, 29 Dec 2020 22:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgL2VSx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Dec 2020 16:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgL2VSx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 29 Dec 2020 16:18:53 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22604C06179B;
        Tue, 29 Dec 2020 13:17:42 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c7so13738897edv.6;
        Tue, 29 Dec 2020 13:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f6l7DxBCgboZNEz8Pa6j0XooI5/nBgnHNFY+r3WPfkk=;
        b=ZCv2cVlCPymrZD6LHqXF3C3rnzY17dBbyg/phLi6ypeOdUoADJoLqSDI5Q63ouvdOv
         V/VxAHzyicfy90UW9qOPeCzRFrRaAOk0QUDe13izJdDxb7yXB16HB3izehp0oYO5oBn0
         90Nhr1OJp2LQ2GkdZmcF1nRnD5+ZsDIPmG7VSgI3j18hhO3wiqMCVme9lptH/cFVRv17
         8IWqAQ5QZUnWUZa7VypcNe02fEPsdPaueQRUq8E5G/d3oEti7R1Bl0GGpGAY2gr82LPK
         ZNgozJQ1bugwGpApDNVkjevAd1qhXDg53TlXQfK0LJpUwBRd2MNTndP8UqslTlSF7u05
         1YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f6l7DxBCgboZNEz8Pa6j0XooI5/nBgnHNFY+r3WPfkk=;
        b=BydE0CzDZrII46BZrdRlfkfN3r3lhJSBwYu7JLMVziFAFFOhspBSr04WSFAjOS3RgV
         A0Tvr0OtVAncWBmlDGUIYx1dxW5hgtFnpc6LYPwPkg2ui7krE9O7ikMIvffWUkKHfqE2
         h2S5QH9typzBW5cW61USKH0ryk3qiJkM26sD/jNuNLVm90b1KC6am3SzSDjjODoJ0yja
         /mzinBuMvvLmYypbFEnL0ReNTDIP2yiYIfXi9yN4b35sJvQ6WRPZYWTqv4jjUo2FPp31
         LzJ5bphEYRyUwwReLQn38B4vsBjZoVCLejiXCzrwByfCyTaax+EVhOvVzQeEycjSXdyE
         jbWg==
X-Gm-Message-State: AOAM5319YO/hvaqKZkWzdXJDeQIvDX5XvUywfFw9ndPa+cvWPvve+Puf
        /OoMfVn74WYupHeUNINc6i+J34D95mInqA==
X-Google-Smtp-Source: ABdhPJzOO0x2c9l2tgejMQlmX5kFao+fLwmePbrqGJehvoCHvk59hFLA3OIcNh3Pev4U/ebOb9butw==
X-Received: by 2002:a50:d5c1:: with SMTP id g1mr49530638edj.299.1609276660866;
        Tue, 29 Dec 2020 13:17:40 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id u9sm37354553edd.54.2020.12.29.13.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 13:17:40 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/13] arm: dts: owl-s500: Add DMA controller
Date:   Tue, 29 Dec 2020 23:17:21 +0200
Message-Id: <bc58fc172efc0ac5d60bd5e4282a22688272ce55.1609263738.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DMA controller node for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
 - Added Reviewed-by from Mani

 arch/arm/boot/dts/owl-s500.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index a57ce7d6d745..449e9807c4ec 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -207,5 +207,19 @@ sps: power-controller@b01b0100 {
 			reg = <0xb01b0100 0x100>;
 			#power-domain-cells = <1>;
 		};
+
+		dma: dma-controller@b0260000 {
+			compatible = "actions,s500-dma";
+			reg = <0xb0260000 0xd00>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			dma-channels = <12>;
+			dma-requests = <46>;
+			clocks = <&cmu CLK_DMAC>;
+			power-domains = <&sps S500_PD_DMA>;
+		};
 	};
 };
-- 
2.30.0

