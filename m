Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29A84843CE
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jan 2022 15:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiADOwW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jan 2022 09:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiADOwT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Jan 2022 09:52:19 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8C1C061761
        for <dmaengine@vger.kernel.org>; Tue,  4 Jan 2022 06:52:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v6so14979695wra.8
        for <dmaengine@vger.kernel.org>; Tue, 04 Jan 2022 06:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CE9wC1I8Y3S4XjOVWKsIkWX1PPAYp2L1AtPQgtpQePQ=;
        b=Glp0dKp29nU4yXeghEDQr2iDSZMAXFTnQ7bOgIkaML2Vu/d/mB7XCDQ8EH3AUcW7m+
         rozyVDSuCz5Cyi5gj1cjC0iWsRsviHskHscxURkh0dx30nDv2D9m0hdI/o6EeODcuD7C
         okbaoGoqznvIobpoboDqgMgilMW/V+rb3Dwlumy/68SMTjtiLFWEAVs+tfHLqvHr5h4k
         1A6uqnXZ80wywuKduleS4/ORhbgE9nrepvolcMv7jsMPSV3SsX6EMO1mA3y3dcINKjTN
         98liTF6YFZQdvqJShmRYS78VuywWMYHI41Kg2syoTamNpn+CpqrIsvVh3oinMATHGwaV
         qwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CE9wC1I8Y3S4XjOVWKsIkWX1PPAYp2L1AtPQgtpQePQ=;
        b=Yqc8LOzXs74vE/Ce04xRaytFPr8oEd7Xc8eZKaN6GjR9UoIUdpDfeodI1IGW8l61Fw
         EslBoChSoLOduo+dmogRKXf61xVGJ+XNpHa5z/he62OrB2MUk3x7ZzSrPozWVE7h/HM9
         7phZ4XBFsdDSWs+UCQXYnAAxRdt6oWiQZVPqiCaGrsxYNCWQ+A6mpHtNQTDminAmea/P
         YAh//aDAH++66PQNV7rGjN2zXOEaIk9JnWXIbQWOAqSS6SicEh2kHzh5WvpeKtPQiXwT
         cMKMvvA7CpkK03ioSFpiiOWBNfLaEls5RBLal50o10wNAW7h35haaCkLavGVOzi/oIlK
         45LQ==
X-Gm-Message-State: AOAM533KGTdr/6sRPSMapnCszFefHCMm4fTjgeqSmFSfw1qqxD6fzFq1
        1HRAaIgvSUizqI9MY1aWL3wWKA==
X-Google-Smtp-Source: ABdhPJzoD9KCrAW7cQc3I5OWzupEwE2HWlQZKpJqoxpt5YQyfqDhSf1gYObZVM419BaAFM/vInqSqA==
X-Received: by 2002:a5d:488a:: with SMTP id g10mr29191706wrq.653.1641307937870;
        Tue, 04 Jan 2022 06:52:17 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:f6da:6ac:481:1df0])
        by smtp.gmail.com with ESMTPSA id s8sm44631911wra.9.2022.01.04.06.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:52:17 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     vkoul@kernel.org
Cc:     linux-oxnas@groups.io, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/4] ARM: dts: ox810se: Add DMA Support
Date:   Tue,  4 Jan 2022 15:52:06 +0100
Message-Id: <20220104145206.135524-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104145206.135524-1-narmstrong@baylibre.com>
References: <20220104145206.135524-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This adds the DMA engine node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/ox810se-wd-mbwe.dts |  4 ++++
 arch/arm/boot/dts/ox810se.dtsi        | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/ox810se-wd-mbwe.dts b/arch/arm/boot/dts/ox810se-wd-mbwe.dts
index 7e2fcb220aea..19e5d510e425 100644
--- a/arch/arm/boot/dts/ox810se-wd-mbwe.dts
+++ b/arch/arm/boot/dts/ox810se-wd-mbwe.dts
@@ -103,6 +103,10 @@ rtc0: rtc@48 {
 	};
 };
 
+&dma {
+	status = "okay";
+};
+
 &uart1 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/ox810se.dtsi b/arch/arm/boot/dts/ox810se.dtsi
index 0755e5864c4a..79b2b49dcfbb 100644
--- a/arch/arm/boot/dts/ox810se.dtsi
+++ b/arch/arm/boot/dts/ox810se.dtsi
@@ -334,6 +334,27 @@ timer0: timer@200 {
 					interrupts = <4 5>;
 				};
 			};
+
+			dma: dma-controller@600000 {
+				compatible = "oxsemi,ox810se-dma";
+				reg = <0x600000 0x100000>,
+				      <0xc00000 0x100000>;
+				reg-names = "dma", "sgdma";
+				interrupts = <13>, <14>, <15>, <16>, <20>;
+				clocks = <&stdclk 1>;
+				resets = <&reset 8>, <&reset 24>;
+				reset-names = "dma", "sgdma";
+
+				/* Encodes the authorized memory types */
+				oxsemi,targets-types =
+					<0x45900000 0x45a00000 0>,  /* SATA */
+					<0x42000000 0x43000000 0>,  /* SATA DATA */
+					<0x48000000 0x58000000 15>, /* DDR */
+					<0x58000000 0x58020000 15>; /* SRAM */
+
+				#dma-cells = <1>;
+				dma-channels = <5>;
+			};
 		};
 	};
 };
-- 
2.25.1

