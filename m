Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3AF48FFFC
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jan 2022 02:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbiAQBfi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Jan 2022 20:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbiAQBfi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Jan 2022 20:35:38 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA613C06161C
        for <dmaengine@vger.kernel.org>; Sun, 16 Jan 2022 17:35:37 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id x83so8795433pfc.0
        for <dmaengine@vger.kernel.org>; Sun, 16 Jan 2022 17:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K49u+vw8xuJoyxVWZcA3NU+d4XvPmTqJkyhbFma1tEc=;
        b=fx5o8gOeg/Q4/nXN2S9EzfZaKH4Lq4w65YWm1MW939pyqPAJnVhF5MI32yLl+mMVxN
         xKQ7igoeXYDbaz1SoigpFPhD5N/f+iMD7inhwZsZNmOFYwjjReuHVKcXhsY45lqsdY4E
         kz1H/srdzXbpAR5oubHNCHf0Tpb5MqzWq+mzblEWnvoCf34LDYUqVJ9VtG3FzfDOi9/X
         RoSzDuzy+cciW0PSMaLlMA20kkL/Unv1fDDGbaEvJF3vCopP+dOQmXLN+rE6ZDUgH2Ha
         QIDZDJfD63Z2jxFwY/0RnfgMCantTV07P/6WECYOQlwH/e8NsNJIiH91WKb2Avw8Omdv
         A/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K49u+vw8xuJoyxVWZcA3NU+d4XvPmTqJkyhbFma1tEc=;
        b=G0cvKqLszyHvNWyoz1Se30mvHKrRnkCUvL8w61uaC9o3MZMPj1X0X+WwXuHrkzYIoc
         tm1ynX5JSxjsYJfW/u3RR4VbwZkk9mel95EV8u+mNOJHJssxgmIFUnutRZc4/BoSwL6G
         +gD3q1M58nKDxZooeg/+7C34jlP43fYyKgYZjHEVRM1XjZg0pgg+BBOzMMUVVe8SSszC
         J0+x7QYw/t0f4J7J9y0GYDfq5egoJPyHgHwrGX7k0QRgXSZ+vZ6nZtEyVQfn9P6CONAs
         +l375FZFsuLGUL6ZBPau6Ry4clvo+Mcoj4HgSkzw6Zb+XD4Ga3zpc2X9VeJ9CCWJDGth
         mcgw==
X-Gm-Message-State: AOAM533YoZoZ8PSe6e2h7Qx5ZWzx7YtR3Kn4JbuXjTNKaADAWKzYqDFU
        aFffJJhrs99r7toaEu2yFWp/nA==
X-Google-Smtp-Source: ABdhPJy3cCK6M6/ymBigZBfwJeQAU3nzgG2r0QdbcItZb2aPSm1DwimovkWfD1QGC4ROmx67vrk6Vw==
X-Received: by 2002:a63:5d0e:: with SMTP id r14mr930560pgb.110.1642383337389;
        Sun, 16 Jan 2022 17:35:37 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id l1sm10008335pgn.35.2022.01.16.17.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 17:35:36 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 1/3] riscv: dts: Add dma-channels property in dma node
Date:   Mon, 17 Jan 2022 09:35:26 +0800
Message-Id: <163a2cf11b2aceee2a1b8dc83251576d2371d4a6.1642383007.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642383007.git.zong.li@sifive.com>
References: <cover.1642383007.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add dma-channels property, then we can determine how many channels there
by device tree.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 1 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index c9f6d205d2ba..3c48f2d7a4a4 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -188,6 +188,7 @@ dma@3000000 {
 			reg = <0x0 0x3000000 0x0 0x8000>;
 			interrupt-parent = <&plic>;
 			interrupts = <23 24 25 26 27 28 29 30>;
+			dma-channels = <4>;
 			#dma-cells = <1>;
 		};
 
diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 0655b5c4201d..2bdfe7f06e4b 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -171,6 +171,7 @@ dma: dma@3000000 {
 			reg = <0x0 0x3000000 0x0 0x8000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <23 24 25 26 27 28 29 30>;
+			dma-channels = <4>;
 			#dma-cells = <1>;
 		};
 		uart1: serial@10011000 {
-- 
2.31.1

