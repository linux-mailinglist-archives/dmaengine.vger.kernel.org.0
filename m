Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972D52E053E
	for <lists+dmaengine@lfdr.de>; Tue, 22 Dec 2020 05:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgLVEH3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Dec 2020 23:07:29 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:43949 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLVEH3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Dec 2020 23:07:29 -0500
Received: by mail-ot1-f54.google.com with SMTP id q25so10817311otn.10;
        Mon, 21 Dec 2020 20:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q3IkBlOmHE3mDRbIb8lAHBUkpZJ3o80cNN5b/4sEG/I=;
        b=j9Gg0OUtHoOw0PM6uk5aBZAoKIVgAS+aQ/cg8ESWVxBFUUcJCTksWdSqHAMGBt55fv
         Vfb6BCyeailaRQuRWQ8D05fc6ZGU9A5Z8oUEejYbnk1qhSS0Hu8RKjGkT1pG0CZZ4dA2
         6YqoJU23VuXfb3Y+2H/2HGSBhU83OkUXJjXLNLf6JEZKZQ6KXy1qoxb8t03WOq1SCq2k
         Jb55mcpYVaI5g/IhPXLK+zlOsKL3M6a9QBaPCfzYITXKVwLyXcmPUYsSoSNBfDDEs1wM
         dsWRThy1+w6lxVOHPECoUZh3vobeM/DOe5E/lK/rlTH2W8Q6Yi6OehcLTQqL5jjyIqyB
         3eJQ==
X-Gm-Message-State: AOAM530FcQ/nwrpMoEyDhW5Rr+rcNz/2DxelojGsrWkOqwR9qVv7ODHW
        7qc7Tq7zPxkvZT/TwSdHYJ26sthN0g==
X-Google-Smtp-Source: ABdhPJzc2AcXawDMexyhwX9kljUmHJGpp3yp74aSZqBghugGE4ma17w5UwkOCA62mhIs+ne0II6TKw==
X-Received: by 2002:a05:6830:1189:: with SMTP id u9mr14233531otq.70.1608610007879;
        Mon, 21 Dec 2020 20:06:47 -0800 (PST)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id m22sm4261765otr.79.2020.12.21.20.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 20:06:47 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
Subject: [PATCH] dt-bindings: Drop redundant maxItems/items
Date:   Mon, 21 Dec 2020 21:06:45 -0700
Message-Id: <20201222040645.1323611-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

'maxItems' equal to the 'items' list length is redundant. 'maxItems' is
preferred for a single entry while greater than 1 should have an 'items'
list.

A meta-schema check for this is pending once these existing cases are
fixed.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Cc: dmaengine@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Cc: linux-usb@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml    | 1 -
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml   | 1 -
 Documentation/devicetree/bindings/mailbox/arm,mhu.yaml         | 1 -
 .../devicetree/bindings/sound/nvidia,tegra30-hda.yaml          | 2 --
 Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml    | 1 -
 Documentation/devicetree/bindings/usb/renesas,usbhs.yaml       | 3 ---
 6 files changed, 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
index 7b9d468c3e52..403d57977ee7 100644
--- a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
+++ b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
@@ -98,7 +98,6 @@ properties:
     maxItems: 1
 
   dmas:
-    maxItems: 4
     items:
       - description: Video layer, plane 0 (RGB or luma)
       - description: Video layer, plane 1 (U/V or U)
diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
index b548e4723936..c07eb6f2fc8d 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
@@ -73,7 +73,6 @@ properties:
     maxItems: 1
 
   clock-names:
-    maxItems: 1
     items:
       - const: fck
 
diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
index d43791a2dde7..d07eb00b97c8 100644
--- a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
@@ -61,7 +61,6 @@ properties:
       - description: low-priority non-secure
       - description: high-priority non-secure
       - description: Secure
-    maxItems: 3
 
   clocks:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
index e543a6123792..b55775e21de6 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
@@ -44,7 +44,6 @@ properties:
     maxItems: 3
 
   clock-names:
-    maxItems: 3
     items:
       - const: hda
       - const: hda2hdmi
@@ -54,7 +53,6 @@ properties:
     maxItems: 3
 
   reset-names:
-    maxItems: 3
     items:
       - const: hda
       - const: hda2hdmi
diff --git a/Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml b/Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml
index 0f078bd0a3e5..22603256ddf8 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml
@@ -51,7 +51,6 @@ properties:
     maxItems: 1
 
   phy-names:
-    maxItems: 1
     items:
       - const: usb
 
diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
index 737c1f47b7de..54c361d4a7af 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
@@ -74,11 +74,8 @@ properties:
 
   phys:
     maxItems: 1
-    items:
-      - description: phandle + phy specifier pair.
 
   phy-names:
-    maxItems: 1
     items:
       - const: usb
 
-- 
2.27.0

