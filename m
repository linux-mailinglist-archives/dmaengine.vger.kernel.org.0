Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3EF2B9ECD
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 00:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgKSX41 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Nov 2020 18:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgKSX4Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Nov 2020 18:56:25 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C194C0613CF;
        Thu, 19 Nov 2020 15:56:24 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id q16so7680650edv.10;
        Thu, 19 Nov 2020 15:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gL8uFPPVpKtnByzpi+zs85SIoQDHZ+WohxV8JQYlXWw=;
        b=J3/Yt5GodddJ820SKE1n+Hz741TFBv3kjyZ+nsiN15RiUFNrCaNH9FsI+M6LIn0qrc
         SEPZT0N8cB5i/vQ7D1O92BUc25Sa2H5bmQGii9R+iXpjWTGsckrAD8xZjkHxk4EDD5uX
         UesF3evaZEPRHt3CreuiqNDBkBMusmNobojpPhzPzP8OIFPjmk09SztmxcLrn0MbxPhw
         43BMjlq7fN4SYPWecJyKyTvKiTtSiDkTK6BRJC/RdwLE7Ja3hhpq0NMiMbhWByfBPeo7
         lB8ZSDCue5QCck5l44YzForEfG0LO1I4fXq2LHcP6ipz5nmNiRvh4O9LLeQ+nxOm6dxo
         D/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gL8uFPPVpKtnByzpi+zs85SIoQDHZ+WohxV8JQYlXWw=;
        b=DRNNFGFwzvOFQPMRGQajC2clnlEypS83eQmdwMOZXCDHe8NYve4YANrgbMvTQfEqWA
         NJMtc52BYJYUyYAi26GG/xNuda0zc33wUpUYXj+3a3N+Dm1GzdwZHAEo9HwU4IEDkZbs
         kTm1T3RcqR4vlYDKlTiPpgio+yraHG/kut9do7u0hyR7qChanWuWafDzSoBWtERwKklt
         fsX1NiYKaqEViZNuDCgnsk3idknlnunCtf93acjSI7l4kl9KJSmPD4aSCx+QEmLCU1Ol
         U0ljilIZG4JbjgX5bchVCh1AZFs0hygDQfhYhemTwRrA7AOvSLIATs2zy06mWpmAuTBr
         FBHA==
X-Gm-Message-State: AOAM530vBv4Ruwi+GedkOYbCADkEOTr7vABhaOg9luwsBR9BV9E7nWSs
        potIX7jNnkfRuexBUwbGBg8=
X-Google-Smtp-Source: ABdhPJxHZ8XMVUw5LSRwc08+zrd2JNUs+G3g9Y10qnP3VzNZODOzE2U3n14gkgcHxpiUNfHF7A3rpg==
X-Received: by 2002:a05:6402:1a58:: with SMTP id bf24mr31802024edb.191.1605830183309;
        Thu, 19 Nov 2020 15:56:23 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id i3sm452987ejh.80.2020.11.19.15.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:56:22 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/18] arm: dts: owl-s500: Add DMA controller
Date:   Fri, 20 Nov 2020 01:56:00 +0200
Message-Id: <543eadc1e3005ecdca780266ef148518b5091377.1605823502.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DMA controller node for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
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
2.29.2

