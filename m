Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17841914E3
	for <lists+dmaengine@lfdr.de>; Sun, 18 Aug 2019 07:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfHRFW2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Aug 2019 01:22:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46035 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfHRFW2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Aug 2019 01:22:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so5018476pgp.12;
        Sat, 17 Aug 2019 22:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LnUMl6nKmNKEDv9sXm8dLw8sMDEUaepAQtfU3G1sTUw=;
        b=KxCB3m+eDBW1K1mdBHnA9HcoiC6utxfBDmUFeuWKBOmqged672qbWEtZ1FBXJvZr8H
         qKfIVROkp4whMJoWPsvoCCailgm3o/zPj0MoyRF3+4qp4MwjNu2ic1WNshJdPYmxQBQv
         +g+feWQHFpUIEWFl6NxLxfg5EOan4jc0PdGajmZSD7H1SYJvTY51915eRwglBgJPBJVA
         870kOud9Qy3rb/jY2c0kcnjcmvsTI/ERwYVNyIpyMUOG5cNCHVZniyro+HdnndjjTQwM
         iAl0CZLTAwtz2LVDE8UBljAogBQ+lOBPDq8ZuNAL48v/vcI32GBWFQetduFLtngYPaT9
         KmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LnUMl6nKmNKEDv9sXm8dLw8sMDEUaepAQtfU3G1sTUw=;
        b=m0UQ+KMrq8zn2/bXQc6WOSOvbjX2vG2FTkBWz2SvAiNMMlTIIVRiqTVaPjyWdROuA9
         KVdSPgp1W6WBJOal45J3y423PwpkX1ibYLcwCgX30B1yAPNizMg8rzMkhZ2327hAmrqe
         xgavl9UfvJ6huP8DFkxR4EOn+NRPmvGvNA0Cz+TG3ovklSstKpM2IDIhopwhuhDPZ906
         /USim+HIM8UZ+RJHIExIZfjDgLW/2f3SbRJem9OrgiF/Cabwp/PGo9+MCB7OabQB/YQj
         a0Pg8QBoNpzWSIlOWnPEcdkD3Rp3iAY5BWtD2xTf8BuWhNmpa6OdqaBGd1/VgNqPCbxC
         cEuA==
X-Gm-Message-State: APjAAAW8NLl5RgLXvLYPEt2MFKxjmxV6a9EEwHMpR3aB1tMUMuw28FiZ
        YnkcnbJxLSDRF7na6prOB1AV1glW
X-Google-Smtp-Source: APXvYqyXs9wmn+5j3Q7IgUBygovGSq2/0VEUYsJAA+Bs6057y3Og8y6VyLDt69cataJpu8zQBNgNEA==
X-Received: by 2002:a62:b411:: with SMTP id h17mr17569440pfn.99.1566105747249;
        Sat, 17 Aug 2019 22:22:27 -0700 (PDT)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id x9sm9257303pgp.75.2019.08.17.22.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 22:22:26 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH 1/2] dt-bindings: milbeaut-m10v-xdmac: Add Socionext Milbeaut XDMAC bindings
Date:   Sun, 18 Aug 2019 00:22:24 -0500
Message-Id: <20190818052224.17857-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818052154.17789-1-jassisinghbrar@gmail.com>
References: <20190818052154.17789-1-jassisinghbrar@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Document the devicetree bindings for Socionext Milbeaut XDMAC
controller. Controller only supports Mem->Mem transfers. Number
of physical channels are determined by the number of irqs registered.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 .../bindings/dma/milbeaut-m10v-xdmac.txt      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-xdmac.txt

diff --git a/Documentation/devicetree/bindings/dma/milbeaut-m10v-xdmac.txt b/Documentation/devicetree/bindings/dma/milbeaut-m10v-xdmac.txt
new file mode 100644
index 000000000000..1f15512e3f19
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
+                the number of interrupts specfied should be {2,4,8}.
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
2.17.1

