Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0D72A57E
	for <lists+dmaengine@lfdr.de>; Sat, 25 May 2019 18:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfEYQif (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 25 May 2019 12:38:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34303 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfEYQie (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 25 May 2019 12:38:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id f8so12848478wrt.1;
        Sat, 25 May 2019 09:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=73BBHLN3/j83VURt6icEiGox4hUhqX1WgPxiVFKyQjI=;
        b=vLpCI5Rb7wk0UNTvHqKpOLJ0SKEkpk5xFNGML+8KdavMSTu09xDT5byhC9GoyvrN3T
         5vGnmVzQqNoV7dSf9bs2/Zjn7Yr11n8SiPVjuBVA+ijQ4y9IUVGPE8XCOBvlbC5A2Mkh
         M0TFp1LdG83CPxsAryD+m89YhWcWIBsOapMDX3v80ZuKWh9HMaqxq3FygWJdHJu5qJrI
         yo3szSJGfMh30CgOf32IIqERBO+BzOE8JBB2GbA0OpZccDWfTmtNbumeK9w7QBoKGYZR
         bj6Fbd5tC36iUMNO5LGk42eupFqcas0wTmfewk/1OAM1mlEHmGnLmBWc72yn8HdpLy1X
         yxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=73BBHLN3/j83VURt6icEiGox4hUhqX1WgPxiVFKyQjI=;
        b=WQ165RgDswWCfV5ibUeT1mydrsCqJElPKNUqCYZ5fe79dPFet6/7IDYu5KfEaTzSgb
         mrZFQEqTloAKOSHCOl2LrLV5avnYhMVJmkhqYNqT6mkWvvcJR7g2H2BMk+Kh1LxRfpz3
         m3R3cLdtVhegES+OltCX57RNlPDDL+ff13GS39S8TGMoKtJ2qFAC4oQ3adtQiBTjPCVs
         hzQMSvAuCxJZJSDAAJmNAGeWYaytdNlsELiz0ndd0qEY2pIah04TVJtX7K8lWwq1jEqm
         MMc9kzXFS1q7gVtyeQzsxqSVyQpWGSbTmZdIXRZQiDRsf6AkwSez06AOBqfuDmDVVBQX
         Ph7w==
X-Gm-Message-State: APjAAAUpsI2L7bukA7mYr+rWf+teGbB7zQ7hzkM+R/rZeUMRDsgttTe4
        4VYv4voVHwXaax9Ic1p5WWg=
X-Google-Smtp-Source: APXvYqxa/DYqpGnnVlydGMVGpTNtp535awxH6Lo5LUaXya51tnZ4J/740PQZktYur529FTu9DCya/g==
X-Received: by 2002:adf:dd43:: with SMTP id u3mr3656689wrm.313.1558802312232;
        Sat, 25 May 2019 09:38:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id f65sm9306498wmg.45.2019.05.25.09.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 09:38:31 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 6/7] arm64: dts: allwinner: h6: Add DMA node
Date:   Sat, 25 May 2019 18:38:18 +0200
Message-Id: <20190525163819.21055-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525163819.21055-1-peron.clem@gmail.com>
References: <20190525163819.21055-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 has DMA controller which supports 16 channels.

Add a node for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 16c5c3d0fd81..f4ea596c82ce 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -208,6 +208,18 @@
 			reg = <0x03006000 0x400>;
 		};
 
+		dma: dma-controller@3002000 {
+			compatible = "allwinner,sun50i-h6-dma";
+			reg = <0x03002000 0x1000>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMA>, <&ccu CLK_MBUS_DMA>;
+			clock-names = "bus", "mbus";
+			dma-channels = <16>;
+			dma-requests = <46>;
+			resets = <&ccu RST_BUS_DMA>;
+			#dma-cells = <1>;
+		};
+
 		pio: pinctrl@300b000 {
 			compatible = "allwinner,sun50i-h6-pinctrl";
 			reg = <0x0300b000 0x400>;
-- 
2.20.1

