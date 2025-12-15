Return-Path: <dmaengine+bounces-7619-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F16DCBEF84
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 17:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D641D3061A4D
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 16:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA2E3314BB;
	Mon, 15 Dec 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="YnPx5LAD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D03031329B
	for <dmaengine@vger.kernel.org>; Mon, 15 Dec 2025 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816716; cv=none; b=ZsrN2lfdsqx3vaA1J/IoY/kCbNz5qoA4IPBVCjz9PxaFYtn/FQ+G8Pm6iDnpipNhcjV7hnwHK8fkAJEE1gwKhPYyora1THZ5WjyKXbpdOKtoXdsEB72EeWRRcLewDfxULzD08zzdZ4FfTHPMvujGojT4uQoV4vy/H/4VCqQd37Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816716; c=relaxed/simple;
	bh=YtDrhz214maGpV2hZoz5P9MBOOxn5+fyXOlqcl1OMZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmflpMKV2XNHjnM43vou15RdWaIZzmTf9zwY567U7jFx7XEWOKRBPGq4eIS9C0IL0C8/hUtz9jvlN96mP9Gt3uzAmSyt2X9QNU1s3qDRWpnZ7B8SxkfPMbaTct7k+k91CX/d+KRp1MacGpKZaEz9Q+nkzTpAAMNXUAnyD8SXeP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=YnPx5LAD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so38774665e9.3
        for <dmaengine@vger.kernel.org>; Mon, 15 Dec 2025 08:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816712; x=1766421512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOr56XFFvJYItbaYZCF01MB/OVR35Ya4WEl16UdXyiE=;
        b=YnPx5LADHooQfHmE6ykE1da16k0NjskImATy7uqlFvTBNvCCQH2WAT0l49qLplLOaM
         J5jbVuV6MDQ031Uof1vE++YZQMfRdffMXKYB7YxOXfCSj/7Zpt1IEwEXOCiP0+l466k9
         6tqcY4fC35uQYdlAPDqfgt7jC0COjonwLDwDZFVdSd90XPWey6Zo9NopDkBerGdhosG6
         kx2v/uqWGu83kPNLUOU0SpJrR3qAYVzyPcOeMvhOC0uXq7QnT8DWUXDtyBcYsVyLeERS
         z+x/pwLGeLLxUQ0rzWmjr33izxdxv4JS7tBIlFSFFJR+i+zwfU3ab00QiVnqoWHy4iSe
         iZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816712; x=1766421512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XOr56XFFvJYItbaYZCF01MB/OVR35Ya4WEl16UdXyiE=;
        b=XB9sphN53ma2Jnu87cC6oUlgyLj/auUoaF+Taj4Pik3TYRrEKV8qSOHKYxMxRfbrnP
         em2xUG1/4kIUhJkSTTfocWBPGwM0oPb2JovxC2G0mY5Y261tllEuA73hQK5CagHyoHq5
         n+V+jQqf6M6sLKiPMLJ4XzKwmTTfinc8OsWZWxHg4qOSnXjFXgr5KgUDldumfH6+DSzu
         xpOkZ4mN1Yt8U/H93N5eMPuhR8itVRrNK7KkMDjUav3iHCJ6a7QF9Xn5b7RiQlw5O6EJ
         nFmRSVrOGq5ER93G6Ikao1o/CRzkCJC9vnE7oYrm7lml+MqZOvyPosJgCDlNugc3cr6z
         fYhg==
X-Forwarded-Encrypted: i=1; AJvYcCXAFLMzmxb6EvV5XdgT/O5GAv4Wd9eJ7qD9GUxq6QUJcLDlEsw9dSwJ5xQ31WvUHzHHhEnmIC2jPT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0j5p8X4KmiTdQUoXdxarVXuGSCCrw57fwup00brMS3I6RGEQt
	bG70TofIkpk9xixE4W7rPz/i33YP2ZYB0UgCsK2HBrrywjwEvn+vakrfVISs4vxynP0=
X-Gm-Gg: AY/fxX4KJhHcRfJPp5k/jDw8nDvCTI5gwxRCXSYyzPTOrcNeHldk4p/TTut5EHdMp6g
	Oc8Kz97s8o/pqKaoVaJNaB3mGFB8OeVNBswZbge3mJcmGIzJp2mxs9qVEj5wtc1+xtRuaLDbV3z
	cX3BctlqN9rfd57ao53g+h+l2Za1vIP+2T7O5KuS1+k/w2kDNqUNgf1YD0wbJcOJFUw+grKHqMe
	HgsyndLLZlcJU7AgTnlzY/A9gPxgug43NpFkcXOGqtJ81FCn39Zgb9l9WNPcN2RfhsCyWHWXQaV
	jlgpVeuofSzjaoeL7jM0sqqhtnJ9m20eXjJYg9V/90ba/1kJJX5J0gNZSfVH6AhaGuXPfkorwcE
	lKfUQvsVUNzLlmihJSg7Q4y1RoRKj8+JtFpmZfBoLp5bZ6BenxjRBW0ykGn6gYF/QB1CLMdQl+7
	fwCfkN1zR6yoCMvT9ykFWz812DBLojjUCIN6Yk8aAFZbIntOam11oZNbw=
X-Google-Smtp-Source: AGHT+IFeCHS7YG9Ek+7zJu3i6olxUvaN+c10eLM1oMJBARdN2+vi1MoaN/SefG9EfAqWjo+NykYUoQ==
X-Received: by 2002:a05:600c:4f86:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-47a8f9057fdmr118534745e9.24.1765816711687;
        Mon, 15 Dec 2025 08:38:31 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:38:31 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	richardcochran@gmail.com,
	wsa+renesas@sang-engineering.com,
	romain.sioen@microchip.com,
	Ryan.Wanner@microchip.com,
	lars.povlsen@microchip.com,
	tudor.ambarus@linaro.org,
	charan.pedumuru@microchip.com,
	kavyasree.kotagiri@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org,
	mwalle@kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 02/19] dt-bindings: usb: Add Microchip LAN969x support
Date: Mon, 15 Dec 2025 17:35:19 +0100
Message-ID: <20251215163820.1584926-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215163820.1584926-1-robert.marko@sartura.hr>
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Microchip LAN969x has DWC3 compatible controller, though limited to 2.0(HS)
speed, so document it.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Fix example indentation

 .../bindings/usb/microchip,lan9691-dwc3.yaml  | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml b/Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml
new file mode 100644
index 000000000000..6b49ef0a6bdd
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/microchip,lan9691-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN969x SuperSpeed DWC3 USB SoC controller
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - microchip,lan9691-dwc3
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - microchip,lan9691-dwc3
+      - const: snps,dwc3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Gated USB DRD clock
+      - description: Controller reference clock
+
+  clock-names:
+    items:
+      - const: bus_early
+      - const: ref
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: snps,dwc3.yaml#
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/microchip,lan9691.h>
+
+    usb@300000 {
+        compatible = "microchip,lan9691-dwc3", "snps,dwc3";
+        reg = <0x300000 0x80000>;
+        interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks GCK_GATE_USB_DRD>,
+                 <&clks GCK_ID_USB_REFCLK>;
+        clock-names = "bus_early", "ref";
+    };
-- 
2.52.0


