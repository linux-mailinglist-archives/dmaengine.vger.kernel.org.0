Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413503377A7
	for <lists+dmaengine@lfdr.de>; Thu, 11 Mar 2021 16:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhCKP2L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Mar 2021 10:28:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34335 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbhCKP1u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Mar 2021 10:27:50 -0500
Received: from mail-lj1-f200.google.com ([209.85.208.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lKNE5-0005lU-8F
        for dmaengine@vger.kernel.org; Thu, 11 Mar 2021 15:27:49 +0000
Received: by mail-lj1-f200.google.com with SMTP id 6so8658940ljr.11
        for <dmaengine@vger.kernel.org>; Thu, 11 Mar 2021 07:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xL1edBPIXb5EtPx7dtqi4BTArR+ixt/89Ez9ALjb7AY=;
        b=dunwiUZtmzPm6/dX3lyhxrB4qLOq3ENi44VuTYInOe1nUZC/Fv48xM1RCCdTuu/ITh
         Qby+a1+igs6VM2wstf6t28qOf/YsoUAuPOdnLQoZWFuEa4eRI6jQefZZaAXyuCA+Unv0
         I6v+OhULGmlGxFxng38TUU67jBGTJuFWDwrqBYx2TXlPcdBsztVo4VhQYZjYQ7XIwmh1
         4rfOY2bb09QlI7iUrS1/+KGDeANTxRuujv5DybEg/5nRBFun4Tl/xEsihYm73nOpdZph
         m5RpIffGe1fOl/4C0CCaAx1wLzSjQth38Da2Yt2HOaxupRCR7yyEKUVoQTetGImYzoNK
         wcPg==
X-Gm-Message-State: AOAM532t3iu6uR5xLSVEdVvIYT3Up5xHUbjzVGP2W7DtAXIyZFEpmbFX
        8NC6OCdZEDlyL3TfSDwplFMhypaKHfDZuS+ZzdOHOIsljdm12r8GmuP2Om0AVAtr30Bxy9V4uF/
        K1/KzyVRIN10Bohx5c+tKAfAtbOh9ZQ0JWO3OGA==
X-Received: by 2002:a05:6402:10c8:: with SMTP id p8mr8958375edu.144.1615476457310;
        Thu, 11 Mar 2021 07:27:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwym688lccoWS0vQKon5fsVW74N9HWG5xLsZvi1pg+uqrC83DObGrD7/MK6ibsjBN6gGqRDFQ==
X-Received: by 2002:a05:6402:10c8:: with SMTP id p8mr8958352edu.144.1615476457175;
        Thu, 11 Mar 2021 07:27:37 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id eo22sm1528960ejc.0.2021.03.11.07.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:27:36 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v3 12/15] fpga: altera: use ARCH_INTEL_SOCFPGA also for 32-bit ARM SoCs
Date:   Thu, 11 Mar 2021 16:27:35 +0100
Message-Id: <20210311152735.1318487-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311152545.1317581-1-krzysztof.kozlowski@canonical.com>
References: <20210311152545.1317581-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ARCH_SOCFPGA is being renamed to ARCH_INTEL_SOCFPGA so adjust the
32-bit ARM drivers to rely on new symbol.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/fpga/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index fd325e9c5ce6..b1026c6fb119 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -14,13 +14,13 @@ if FPGA
 
 config FPGA_MGR_SOCFPGA
 	tristate "Altera SOCFPGA FPGA Manager"
-	depends on ARCH_SOCFPGA || COMPILE_TEST
+	depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
 	help
 	  FPGA manager driver support for Altera SOCFPGA.
 
 config FPGA_MGR_SOCFPGA_A10
 	tristate "Altera SoCFPGA Arria10"
-	depends on ARCH_SOCFPGA || COMPILE_TEST
+	depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
 	select REGMAP_MMIO
 	help
 	  FPGA manager driver support for Altera Arria10 SoCFPGA.
@@ -99,7 +99,7 @@ config FPGA_BRIDGE
 
 config SOCFPGA_FPGA_BRIDGE
 	tristate "Altera SoCFPGA FPGA Bridges"
-	depends on ARCH_SOCFPGA && FPGA_BRIDGE
+	depends on ARCH_INTEL_SOCFPGA && FPGA_BRIDGE
 	help
 	  Say Y to enable drivers for FPGA bridges for Altera SOCFPGA
 	  devices.
-- 
2.25.1

