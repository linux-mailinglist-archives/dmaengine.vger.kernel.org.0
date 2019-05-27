Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D0E2BB51
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 22:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfE0UPi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 16:15:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41799 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfE0UPH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 May 2019 16:15:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so2681361wrm.8;
        Mon, 27 May 2019 13:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+kaEItJcaTQdesa5AwBphmDXJUwfK0zSJiZ3kKfuxsg=;
        b=JXe8zz3sl1yuae27IiFtSbZeyxhAAJTRhkrmZ/f4tYf1JC1c+uxbZLAuHisjkOGYaR
         UeoPqtq5oVtZ/C/baanmccZ1TzFKbny/vCa15s0OUzeErkKIbnNWd/WLmJKbDI8WnSFi
         MCszQVZTshu42YqX8VeiqkuJtr6jNDF0tLEpxbtFxjYwPjlUHao/IlADhM6ARtLHWcQi
         EQIrkUC/P+HscWo5dL5qdc4Q3SLa3W18szwpeVlAjCBy0ymGSj9DekS0APWWNEfZ1FyG
         F6hUN4BzCeB0OUKjzVALxlyJjN2koolDmebqIms600YxVFyu3x/4pFjmO7B4j+lnzvJf
         ninw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+kaEItJcaTQdesa5AwBphmDXJUwfK0zSJiZ3kKfuxsg=;
        b=QDehOMVSfWX7ZhwGSlH0aNTIKl5k9d7Y03MtOGCiibJoNBguXhHqkEgM49Z2juL51V
         /YS8JppOKNKmrtuV5Cv/UoyjppeC1bkiI5+CUTlqdRmmgRUFyftgWAG/xJDQFDkZ4j7o
         +CPGtZOUIFtiUHaR5s9TKK0M5qQrLjYDCupmDh1nsQdif38V8G4pFR22yiKuHTF8r3Pu
         psOeQQk1GLNSuEU0gaH+YaakgLMbe0UuALGwvRcYhOM87sPV07+JdFb1v7n2wAqQ6noy
         Pb0HK4VnD17r4DXC5kndu0QcpO1bcCYCqQbIV4OJCRR+BNrHRsYRLwGskikBBEubBLPN
         FysA==
X-Gm-Message-State: APjAAAVIV0pRe1qDTGCG0vDYZ+xKPYXkXcxXWAxn8IB58BD/wv7s3NGT
        KpkSc3Jy9VUobmC5bnwJRII=
X-Google-Smtp-Source: APXvYqwQlTompIncr5xZgCELaWSfz9GzE0EnVB1vPsrepQ3ROizoZhEoacm9GkGN2nRWzcjkOfN3HQ==
X-Received: by 2002:adf:e4c9:: with SMTP id v9mr3362538wrm.147.1558988106312;
        Mon, 27 May 2019 13:15:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id i27sm347146wmb.16.2019.05.27.13.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:15:05 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 1/7] dt-bindings: arm64: allwinner: h6: Add binding for DMA controller
Date:   Mon, 27 May 2019 22:14:53 +0200
Message-Id: <20190527201459.20130-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527201459.20130-1-peron.clem@gmail.com>
References: <20190527201459.20130-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

DMA in H6 is similar to other DMA controller, except it is first which
supports more than 32 request sources and has 16 channels. It also needs
additional clock to be enabled.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 Documentation/devicetree/bindings/dma/sun6i-dma.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
index 7fccc20d8331..cae31f4e77ba 100644
--- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
@@ -28,12 +28,17 @@ Example:
 	};
 
 ------------------------------------------------------------------------------
-For A64 DMA controller:
+For A64 and H6 DMA controller:
 
 Required properties:
-- compatible:	"allwinner,sun50i-a64-dma"
+- compatible:	Must be one of
+		  "allwinner,sun50i-a64-dma"
+		  "allwinner,sun50i-h6-dma"
 - dma-channels: Number of DMA channels supported by the controller.
 		Refer to Documentation/devicetree/bindings/dma/dma.txt
+- clocks:	In addition to parent AHB clock, it should also contain mbus
+		clock (H6 only)
+- clock-names:	Should contain "bus" and "mbus" (H6 only)
 - all properties above, i.e. reg, interrupts, clocks, resets and #dma-cells
 
 Optional properties:
-- 
2.20.1

