Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2182AE20A
	for <lists+dmaengine@lfdr.de>; Tue, 10 Sep 2019 03:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfIJBpo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Sep 2019 21:45:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36003 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfIJBpo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Sep 2019 21:45:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id f19so7660239plr.3;
        Mon, 09 Sep 2019 18:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eOnVvIO4FCKMJgO7zPC90P+tXI8k206KA0DcXXcOb5Q=;
        b=vRz1pE/I40fyOuWrXOrSncPzxTKkxCioesSB4zhSpVL6tQsuYE+PLl0XpSXfyWVnWX
         4btHAtfU3OxArvdeidMkIPmyv5YxEGatwDyBVISA4Jd95+aDlgXYoVlVSu1PspWVT9bO
         oZTchNrw1h7IaKtds/gnte6gGRDarbhBQ10Lg9dZVpuIPZ2mk96ywSWawJnw65hQWuHI
         mY0pAhfE0WzlxuirJcaaI/0xsIhSQrysuh/MUmESPa3E3AgLUzpGJfi+woMQ6XFql2yP
         q8M7zzRuwEG8w1NHBbkMCixBcoxSDXgKri8wIyC/5PwOIJTe9p+HxBfv/+oddM16fR6F
         6IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eOnVvIO4FCKMJgO7zPC90P+tXI8k206KA0DcXXcOb5Q=;
        b=Qhiew2qXj5StAusziNYjXaRoZ2PdXqOiqiMhVggPfXamFuHQrQtr/A5SbXARFQCSDe
         qQOf0xydZpMl71IgnFDRcrjZfW4S89F06CcaIZWXoPW/WO1cn3HJZ/GO9VXoeuIhSyM5
         xFFDmUAYdY8/t5HwF9+evqb2g/2JQgfoL+P3q1+jEmLRCChGLQElNGZHADVdjDguf+ga
         xnQEBRm5Mi8e61YFNh4ghWj5qYCUPSY7dJAPuKluarD04SlJu7oofnLYdgFRA4mBIAxp
         4g9eAoIvyYvkj1dDJHGGQUuQgF85h/R988YYLhKdGSIchJnu+34VraLxrTwAF9DMKxwz
         7KDQ==
X-Gm-Message-State: APjAAAVJrxvQkq+5FxKwGXzDymezg99dAqJwsEYDcLhtVA4JFcjpuJ80
        QUJ3yrjV/xM8a5bVs8KGTYD72j01
X-Google-Smtp-Source: APXvYqysRFlxJ/CTTDI10r8Y0XHGD5W7OJngfWlrsETOA6xf8+zIVLbN75LICGliYiWdqIGwS2Mrqg==
X-Received: by 2002:a17:902:8b89:: with SMTP id ay9mr15588916plb.2.1568079943097;
        Mon, 09 Sep 2019 18:45:43 -0700 (PDT)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id s1sm798101pjs.31.2019.09.09.18.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 18:45:42 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org, masami.hiramatsu@linaro.org,
        orito.takao@socionext.com, Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: milbeaut-m10v-xdmac: Add Socionext Milbeaut XDMAC bindings
Date:   Mon,  9 Sep 2019 20:45:35 -0500
Message-Id: <20190910014535.5640-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910014306.5318-1-jassisinghbrar@gmail.com>
References: <20190910014306.5318-1-jassisinghbrar@gmail.com>
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
2.17.1

