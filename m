Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A259F4473B
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2019 18:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfFMQ6J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jun 2019 12:58:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37441 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729911AbfFMAwm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jun 2019 20:52:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id 20so9876858pgr.4;
        Wed, 12 Jun 2019 17:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GJ8o+cBP4X+ha08iy7wHCSwd72glWWHxr08lI7M45nE=;
        b=lEizGQl1b5EgyAZNMMQ46629BYRAFhx9ttWnhZqIDKjfDw0ZTyIk/sUA0xQ804TUJb
         xvqMfKH8Ovd2cRJHxNV2fAfHq8FgIe9qAhUw6N+iEH4+SxYVXKOL+3iKdcqy+pcsrP2g
         D/Rnd/WVKPT0lF63GJCxK3RuLAHbihOdFpcKGuRorJVk4etgQe1I0pG3NTJNhe1Zmt2n
         7B8+i2Gwr/Guuu0OohtYr7qWit3mbGM5FhZV/3hDPCt+JP21xw33Qs8e7kL0knMOcA/l
         MWimb6FJOm9/J6pq+Ior4K1gEmfW7EeoMy0lydcRAi2kz8HIrTe8InKwt7maTsDzE5tD
         E0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GJ8o+cBP4X+ha08iy7wHCSwd72glWWHxr08lI7M45nE=;
        b=NY/dfFKObyyAKwYzii4jRd0gLigbE+O8HpnR52fBKVQ2CjpJYC7myC92N2inesk7Qq
         tlDPOsmPf9fF7XWyji0C2Ji2TTj/0cmYv9c12kj6eSTdgAs6GvH3zx0y2H1C+sPGoPHb
         a2WnY+C4vKaOxlAwpS+zTqV9vyN43eBihkqxS/GqUHxnI9KBSaDX9Obile7pNYdTYtw+
         qajxcPTbSGM7WN8X93aELJNVpnt7kLcpgtBZXVe2TKyg96xsmC71DNFvLuz0JASLCOLy
         1aYrgW5Q2Z2zCqdPZyz7xfXBy+OTKOeNyFqfB0QWC4IAN7U7h5rmvy0yyGvKjYLyusSc
         JJGQ==
X-Gm-Message-State: APjAAAWgaCWexoZCTQoJPgjiwBY4v/E0DZPZekK751MZ3aynHRlDX8nC
        eJkQYh9viWrakBDoOSNlzL5/Fzzo
X-Google-Smtp-Source: APXvYqxpAerfCpvhIrYL6ibZo8hWuFq5nU/ic2e6rfoz5nc8mWeoEo4j2U3bxvuYja91y58Jce7n7g==
X-Received: by 2002:a17:90a:a407:: with SMTP id y7mr1947345pjp.97.1560387161726;
        Wed, 12 Jun 2019 17:52:41 -0700 (PDT)
Received: from localhost.localdomain ([2604:3d09:b080:d00:7990:5eb3:9633:9569])
        by smtp.gmail.com with ESMTPSA id t13sm519015pjo.13.2019.06.12.17.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 17:52:41 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        orito.takao@socionext.com, masami.hiramatsu@linaro.org,
        kasai.kazuhiro@socionext.com,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH 1/2] dt-bindings: milbeaut-m10v-hdmac: Add Socionext Milbeaut HDMAC bindings
Date:   Wed, 12 Jun 2019 19:52:37 -0500
Message-Id: <20190613005237.1996-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613005109.1867-1-jassisinghbrar@gmail.com>
References: <20190613005109.1867-1-jassisinghbrar@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Document the devicetree bindings for Socionext Milbeaut HDMAC
controller. Controller has upto 8 floating channels, that need
a predefined slave-id to work from a set of slaves.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 .../bindings/dma/milbeaut-m10v-hdmac.txt           | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt

diff --git a/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
new file mode 100644
index 000000000000..a104fcb9e73d
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
@@ -0,0 +1,51 @@
+* Milbeaut AHB DMA Controller
+
+Milbeaut AHB DMA controller has transfer capability bellow.
+ - memory to memory transfer
+ - device to memory transfer
+ - memory to device transfer
+
+Required property:
+- compatible:       Should be  "socionext,milbeaut-m10v-hdmac"
+- reg:              Should contain DMA registers location and length.
+- interrupts:       Should contain all of the per-channel DMA interrupts.
+- #dma-cells:       Should be 1. Specify the ID of the slave.
+- clocks:           Phandle to the clock used by the HDMAC module.
+
+
+Example:
+
+	hdmac1: hdmac@1e110000 {
+		compatible = "socionext,milbeaut-m10v-hdmac";
+		reg = <0x1e110000 0x10000>;
+		interrupts = <0 132 4>,
+			     <0 133 4>,
+			     <0 134 4>,
+			     <0 135 4>,
+			     <0 136 4>,
+			     <0 137 4>,
+			     <0 138 4>,
+			     <0 139 4>;
+		#dma-cells = <1>;
+		clocks = <&dummy_clk>;
+	};
+
+* DMA client
+
+Clients have to specify the DMA requests with phandles in a list.
+
+Required properties:
+- dmas:             List of one or more DMA request specifiers. One DMA request specifier
+                    consists of a phandle to the DMA controller followed by the integer
+                    specifying the request line.
+- dma-names:        List of string identifiers for the DMA requests. For the correct
+                    names, have a look at the specific client driver.
+
+Example:
+
+	sni_spi1: spi@1e800100 {
+		...
+		dmas = <&hdmac1 22>, <&hdmac1 21>;
+		dma-names = "tx", "rx";
+		...
+	};
-- 
2.17.1

