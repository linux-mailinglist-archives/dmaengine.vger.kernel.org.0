Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C863D6DCE
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 05:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfJODcO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 23:32:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45940 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfJODcO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Oct 2019 23:32:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so11513686pfb.12;
        Mon, 14 Oct 2019 20:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+n6SYP1y3Gl4oNZCdETIrsDvZcr1Jcs/52PQeqnTpQ=;
        b=i0j+RorGwjYF00HhMDDdMzJD4wJPIawh8uJIXtck7+HDBrtIgTSAIPZ2k7OCs1l7Ca
         XR4X4slM62tSzT55z/a1MXa66o/iUa47SwrqyMocd+WE9SmS7OHPuWkLTeD/Ky9O4LTh
         56flFVup7XfAv3TULikK8E0OmmyAjw/NOyXpneP8iecE8Oj7pPzri4vMETp+3qTNFUMY
         qcTog9s/YfswtDpDMjYFh5Vd4h5hBOYDiHuY6sOV+ydvBAy5RZw0dqUvFEj4S15kmQzZ
         dB4XeCBJ2LheSBTeXYkuyFHsO2luVku3qaeSQ1SFtDaHeetNlkr/5OEcwm2je13vUte1
         GRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+n6SYP1y3Gl4oNZCdETIrsDvZcr1Jcs/52PQeqnTpQ=;
        b=CZqD9emU8+12V9pOhilEctN9/NGTtd4y+F+rl0861g3ofHmNiGdvh46uiS6PoFSha+
         MB0jMSaapYyqSNBxoWJO+dPfRtpCHBDnGP9Vka1fUwdmM010m8sOEkQ7wUdWevIy8mRV
         3/qwebgdVU25w4FghxVPCkfocNwszVJFTMUrSf6Qft8enGAxvsEwtTuifvYjQyxflwcK
         0P/TlSxZZvezJj8XskFX74O4Cclboi9rNQSPX9XdaXlH1MKClfS4pSZ5FH5LlqogZEB9
         RpZbJ27sIklDIUT3DSxh6uKMy7hCxKj/6CIwxWAljLJwURJQKoyIWUdFaIKenEesjX0S
         Y89Q==
X-Gm-Message-State: APjAAAUYekgi972/DVe67mkDAvTzEeWH5AU+TOm57VZf1huBNGVLcsEn
        BcbAgHx+7LMXyz+sZkq4rxK24THF
X-Google-Smtp-Source: APXvYqzZBlJqSVW4IsN4mEY7vzjRVF65gTVbSFmfeAb/uMxpQPxb4nt7rR4XZk7bZ002I78IOS+9zg==
X-Received: by 2002:a63:1f25:: with SMTP id f37mr35995697pgf.50.1571110333012;
        Mon, 14 Oct 2019 20:32:13 -0700 (PDT)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id y28sm20204857pfq.48.2019.10.14.20.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 20:32:12 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     vkoul@kernel.org, masami.hiramatsu@linaro.org,
        orito.takao@socionext.com, Jassi Brar <jaswinder.singh@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: milbeaut-m10v-xdmac: Add Socionext Milbeaut XDMAC bindings
Date:   Mon, 14 Oct 2019 22:31:57 -0500
Message-Id: <20191015033157.14656-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191015033116.14580-1-jassisinghbrar@gmail.com>
References: <20191015033116.14580-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Document the devicetree bindings for Socionext Milbeaut XDMAC
controller. Controller only supports Mem->Mem transfers. Number
of physical channels are determined by the number of irqs registered.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 .../bindings/dma/milbeaut-m10v-xdmac.txt      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-xdmac.txt

diff --git a/Documentation/devicetree/bindings/dma/milbeaut-m10v-xdmac.txt b/Documentation/devicetree/bindings/dma/milbeaut-m10v-xdmac.txt
new file mode 100644
index 000000000000..305791804062
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/milbeaut-m10v-xdmac.txt
@@ -0,0 +1,24 @@
+* Milbeaut AXI DMA Controller
+
+Milbeaut AXI DMA controller has only memory to memory transfer capability.
+
+* DMA controller
+
+Required property:
+- compatible: 	Should be  "socionext,milbeaut-m10v-xdmac"
+- reg:		Should contain DMA registers location and length.
+- interrupts: 	Should contain all of the per-channel DMA interrupts.
+                Number of channels is configurable - 2, 4 or 8, so
+                the number of interrupts specified should be {2,4,8}.
+- #dma-cells: 	Should be 1.
+
+Example:
+	xdmac0: dma-controller@1c250000 {
+		compatible = "socionext,milbeaut-m10v-xdmac";
+		reg = <0x1c250000 0x1000>;
+		interrupts = <0 17 0x4>,
+			     <0 18 0x4>,
+			     <0 19 0x4>,
+			     <0 20 0x4>;
+		#dma-cells = <1>;
+	};
-- 
2.20.1

