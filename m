Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45F84E91F8
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 11:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbiC1JyV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 05:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbiC1JyV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 05:54:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C91354BD7
        for <dmaengine@vger.kernel.org>; Mon, 28 Mar 2022 02:52:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so14939014pjf.1
        for <dmaengine@vger.kernel.org>; Mon, 28 Mar 2022 02:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bwZ4ntGN7f8A8nsIcId+rUmkc/uVaZ9W2h2a+0CTy+I=;
        b=IO1wRJ5JootJiOYi8EyMw7W414vNT7NAHx9rKQTYR0fx2t1ukxQU6t8S0ZcMXI+Qq+
         /q3SDCiAwcSY0QOAO+YRlqTqqWbMrXikfSBCt/qUcdY0KrKYixn0g46dYlA9pBnldg79
         zustXyExPGLSga3BfHWFywEdwpPF+quB+lj0f0xNKDvm9Dq9eiT2F9oX4F2t1ry1jcAc
         RQkJjH6g/2VoKdJ5bC9jmZ2mwUf5bQdok9n/dgc5ZGezYVWQ7fnzc36XoNXlM1eTwqWT
         RXPyJ15qRLLoCqmksuBVSr5yOV/nwOiRjvNQMl6YN4w2FP+FfZRXTDhETJTseOaVIzSW
         oBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bwZ4ntGN7f8A8nsIcId+rUmkc/uVaZ9W2h2a+0CTy+I=;
        b=56P1zOgqsjbw7WBdoT1A7FNPPRl7If6shNt7YQH/dpsD93/4RghPZM7cr0BNCPAlWh
         o2MFnhMdBOQgCdd1xsTjHx+QSCuQdoqXSOiRk5T2K8qCaGVLHPObut10A/FRtLM3FPDw
         chKeGi08lR1udjlZleb359XvVCt0DFpAovto7+s7w0BKe5iS3ilkJozGwJLwyMZKBc4j
         qFXYcpBTgpeCTVMwS+2tG4a3kWCfjmLeAYZh0MdM3+oejtkxYH4o943ptP+ZNu1US0qj
         xh0XT/QRSjXKpUBzvARqmpK7BHDlubFMPQsqWRl9vPbqvNVLzb+oyZ3vkWBOyM8SmLU2
         XurQ==
X-Gm-Message-State: AOAM533iYCyPzxTsel7U2hyfYk70woluaMTNpCAyFbZegm2FLK2Mgsa5
        CZZ3575eO4LLd8yxu88ltl1g2Q==
X-Google-Smtp-Source: ABdhPJyPFyUzbmqGInFSDy/EYxHjhBm+UfFDGTJClCd8Ky24rcAtEAcDFYKO1z1/CDOTCnKHWHtL+Q==
X-Received: by 2002:a17:902:6bc3:b0:156:e4f:b014 with SMTP id m3-20020a1709026bc300b001560e4fb014mr4737654plt.17.1648461160156;
        Mon, 28 Mar 2022 02:52:40 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id g4-20020a633744000000b00381efba48b0sm12255117pgn.44.2022.03.28.02.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 02:52:39 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v8 2/4] riscv: dts: Add dma-channels property and modify compatible
Date:   Mon, 28 Mar 2022 17:52:23 +0800
Message-Id: <d19daa503fb242eef00d79082931199cb3e48021.1648461096.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648461096.git.zong.li@sifive.com>
References: <cover.1648461096.git.zong.li@sifive.com>
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

Add dma-channels property, then we can determine how many channels there
by device tree, in addition, we add the pdma versioning scheme for
compatible.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 3eef52b1a59b..6a3011180846 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -168,11 +168,12 @@ uart0: serial@10010000 {
 			status = "disabled";
 		};
 		dma: dma@3000000 {
-			compatible = "sifive,fu540-c000-pdma";
+			compatible = "sifive,fu540-c000-pdma", "sifive,pdma0";
 			reg = <0x0 0x3000000 0x0 0x8000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <23>, <24>, <25>, <26>, <27>, <28>, <29>,
 				     <30>;
+			dma-channels = <4>;
 			#dma-cells = <1>;
 		};
 		uart1: serial@10011000 {
-- 
2.35.1

