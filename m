Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410B06F0561
	for <lists+dmaengine@lfdr.de>; Thu, 27 Apr 2023 14:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243796AbjD0MKR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Apr 2023 08:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243798AbjD0MKN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Apr 2023 08:10:13 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FFA5BAC
        for <dmaengine@vger.kernel.org>; Thu, 27 Apr 2023 05:10:09 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2a8baeac4d1so84158601fa.1
        for <dmaengine@vger.kernel.org>; Thu, 27 Apr 2023 05:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682597407; x=1685189407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQ8qe1BB0G+HYjEpOfPBNu0NP3ENE9SOB00+nySsnF0=;
        b=EFjdq6kmO3IwygYJjSnuPpG6tNJw3gUimlSwdstfajLcMooVt+zwCL1bDjZdgYGHTf
         Q682KOpEDxp4ye/cWuCO2P8ylg+7WdkE3xiiO7tNruzmgkdt0HUjjWa/o48ro3GLAmPh
         m0woCLrad3IJ5sEFZi9ZYKSr0idyDCJ20a+fXOOv4U4SWlgP063t4hd14lCHSWRuDeoh
         BI5ey7exdfdMtAtYeQ/NKgjmMXdQlfIDliPzF91hD9ErrkPlzfFfjYsbdIPqvc9FvV2J
         sPThNVpr3BtSxwpHhELKHSG0BkZSzruUtu6QearonKlGqi1mxHGEnTVSykvSAxZA0Agk
         Rp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682597407; x=1685189407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQ8qe1BB0G+HYjEpOfPBNu0NP3ENE9SOB00+nySsnF0=;
        b=GiiZDgX1bb/9x7NHcyzUXDigTpD7TYcI6jZRlrjI1TUOXPBryOo/AOylyYWXTvnCaj
         bqbucpmEd8jmI9AgNUxznyFjN+a863wXTD8m/H4F27WPknTTF1K1GvSNpupsD//vPCDF
         OGsY2KIU4o2ZF/Hu1/8diP7QcGBdwv85dPGOCG7bqxiVXijNj/cmqrdNftjoYqtTixkC
         4mKb9XbXrhJr3+Uda+dZBd2eyz4FSeqFcklbQ5a3/DrWoTuMWDG+j0Ss0bXhWCYz8mB+
         Jt60T28A656BmnLpejWWNLTaoFu8SkRvDsVLxOwfkL2ZKj1fXE+PRL2vYqhKz3ibseQz
         ix2Q==
X-Gm-Message-State: AC+VfDy8C5YWOtYiYU0R1BODRJAcaXIrSZXpYCmIZp28wrnR3ANPJeZ8
        l7nt0dfZbv7o68gkUkXafXGVFw==
X-Google-Smtp-Source: ACHHUZ4uN2zzJ7cgkfoU0GrY/fzKjhLGeZLuKhL0GulOyKqNusZ4umA087qyuSEAS1QpgYGYIzCOsg==
X-Received: by 2002:ac2:5549:0:b0:4ea:e0e7:d12d with SMTP id l9-20020ac25549000000b004eae0e7d12dmr472076lfk.1.1682597407485;
        Thu, 27 Apr 2023 05:10:07 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id e7-20020ac25467000000b004d4d7fb0e07sm2892044lfn.216.2023.04.27.05.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 05:10:06 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Apr 2023 14:10:03 +0200
Subject: [PATCH v2 8/8] ARM: dts: ux500: Add eSRAM nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v2-8-cdaa68a4b863@linaro.org>
References: <20230417-ux500-dma40-cleanup-v2-0-cdaa68a4b863@linaro.org>
In-Reply-To: <20230417-ux500-dma40-cleanup-v2-0-cdaa68a4b863@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The U8500 has 640 KB of eSRAM, split into 5 banks of 128 KB
each. Add this to the device tree, with ESRAM 0, 1+2 and 3+4
as separate devices, since these have different power domains.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 73 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index fead7afd5517..c34ccde04600 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -110,6 +110,74 @@ soc {
 		interrupt-parent = <&intc>;
 		ranges;
 
+		/*
+		 * 640KB ESRAM (embedded static random access memory), divided
+		 * into 5 banks of 128 KB each. This is a fast memory usually
+		 * used by different accelerators. We group these according to
+		 * their power domains: ESRAM0 (always on) ESRAM 1+2 and
+		 * ESRAM 3+4.
+		 */
+		sram@40000000 {
+			/* The first (always on) ESRAM 0, 128 KB */
+			compatible = "mmio-sram";
+			reg = <0x40000000 0x20000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x40000000 0x20000>;
+
+			sram@0 {
+				compatible = "stericsson,u8500-esram";
+				reg = <0x0 0x10000>;
+				pool;
+			};
+			lcpa: sram@10000 {
+				/*
+				 * This eSRAM is used by the DMA40 DMA controller
+				 * for Logical Channel Paramers (LCP), the address
+				 * where these parameters are stored is called "LCPA".
+				 * This is addressed directly by the driver so no
+				 * pool is used.
+				 */
+				compatible = "stericsson,u8500-esram";
+				label = "DMA40-LCPA";
+				reg = <0x10000 0x800>;
+			};
+			sram@10800 {
+				compatible = "stericsson,u8500-esram";
+				reg = <0x10800 0xf800>;
+				pool;
+			};
+		};
+		sram@40020000 {
+			/* ESRAM 1+2, 256 KB */
+			compatible = "mmio-sram";
+			reg = <0x40020000 0x40000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x40020000 0x40000>;
+		};
+		sram@40060000 {
+			/* ESRAM 3+4, 256 KB */
+			compatible = "mmio-sram";
+			reg = <0x40060000 0x40000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x40060000 0x40000>;
+
+			lcla: sram@20000 {
+				/*
+				 * This eSRAM is used by the DMA40 DMA controller
+				 * for Logical Channel Logical Addresses (LCLA), the address
+				 * where these parameters are stored is called "LCLA".
+				 * This is addressed directly by the driver so no
+				 * pool is used.
+				 */
+				compatible = "stericsson,u8500-esram";
+				label = "DMA40-LCLA";
+				reg = <0x20000 0x2000>;
+			};
+		};
+
 		ptm@801ae000 {
 			compatible = "arm,coresight-etm3x", "arm,primecell";
 			reg = <0x801ae000 0x1000>;
@@ -536,9 +604,10 @@ usb_per5@a03e0000 {
 
 		dma: dma-controller@801C0000 {
 			compatible = "stericsson,db8500-dma40", "stericsson,dma40";
-			reg = <0x801C0000 0x1000 0x40010000 0x800>;
-			reg-names = "base", "lcpa";
+			reg = <0x801C0000 0x1000>;
+			reg-names = "base";
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			sram = <&lcpa>, <&lcla>;
 
 			#dma-cells = <3>;
 			memcpy-channels = <56 57 58 59 60>;

-- 
2.40.0

