Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78054337795
	for <lists+dmaengine@lfdr.de>; Thu, 11 Mar 2021 16:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhCKP2I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Mar 2021 10:28:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34296 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbhCKP1p (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Mar 2021 10:27:45 -0500
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lKNE0-0005hl-Kb
        for dmaengine@vger.kernel.org; Thu, 11 Mar 2021 15:27:44 +0000
Received: by mail-ed1-f71.google.com with SMTP id o15so10077997edv.7
        for <dmaengine@vger.kernel.org>; Thu, 11 Mar 2021 07:27:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UjkBHzEIXy3Qt0KfyB8W+UTqTimKf+/Z4F2P3MBYO1k=;
        b=ctICyg91EhnI99M8m43CRT2y8orc4T2kXHrohXQwRn8MSp6FPhu959Pa8wLHuz+cTS
         JBajeatlsoqXNBQhUSa7akQzv4lLkNmhlQgjJbDxv8dSX38tBeERlhB3/L/RRFnRZE80
         haJRLaRbFNNIrHCd6sk2x+Ftrb1jXwqzcCWghzdZ7NuoyfBOUKqMn/EW4c+VUbkSvdDU
         mnh/uR7ewMk0nSEBfhe2v/Z1y/H42rklKG0h/JGnDJuLk3yN/a81CN8w3FG8Nw4Ho8Ft
         wsHYljouWKxcfdmROHxcm5Tf9A1cZZMz2KWyHsWfa4YZq+z1WT3h4a9GLfD/5pZ9He84
         W3ow==
X-Gm-Message-State: AOAM532tFGeMy7ma+8+LxNMLdrlm7wSP4bH795clzNlOQT8JvIt+OQWF
        723P+S7FkkTkO5vw1qYvZ1k3NCu06Ma3rPWKagTBTZU/mZUJhJhSmjsrmUQ3jsSxcsfXQDwCYQ4
        IgFO4tqIJtKoA7faYSkUS1iwQGlQOkccDtWR04w==
X-Received: by 2002:a05:6402:149:: with SMTP id s9mr9105084edu.247.1615476453450;
        Thu, 11 Mar 2021 07:27:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9JEFJOCs9xlVCDjG2l3JIb1sIqxzKP3KekIDHOJltUt18JZjWfClKITi/qC3i9sP0ViNxqQ==
X-Received: by 2002:a05:6402:149:: with SMTP id s9mr9105059edu.247.1615476453282;
        Thu, 11 Mar 2021 07:27:33 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id t15sm1552389edw.84.2021.03.11.07.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:27:32 -0800 (PST)
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
Subject: [PATCH v3 11/15] dmaengine: socfpga: use ARCH_INTEL_SOCFPGA also for 32-bit ARM SoCs
Date:   Thu, 11 Mar 2021 16:27:31 +0100
Message-Id: <20210311152731.1318428-1-krzysztof.kozlowski@canonical.com>
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
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 0c2827fd8c19..a0836ffc22e0 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -100,7 +100,7 @@ config AT_XDMAC
 
 config AXI_DMAC
 	tristate "Analog Devices AXI-DMAC DMA support"
-	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_SOCFPGA || COMPILE_TEST
+	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	select REGMAP_MMIO
-- 
2.25.1

