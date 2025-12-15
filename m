Return-Path: <dmaengine+bounces-7633-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED736CBF2BB
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 18:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BB973061341
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 17:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B05033C509;
	Mon, 15 Dec 2025 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="rn33ZXnX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C53370EC
	for <dmaengine@vger.kernel.org>; Mon, 15 Dec 2025 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816757; cv=none; b=mMBF6B5u9GQjdA6ngw7p0Q4Ie+3djribqynQHv5WZrRpb+YayKpAs0G2ISon8iEdThLVWyVTWIKu/hy9phF6SnQyg1AwwYHOZ/EJx781ZaU4daLC3ZnmhGHudlQvDJwbhl6cdKzKaCfbmQXyl+KR+NbYRxXM8y7fd3uC0Fw8qRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816757; c=relaxed/simple;
	bh=gV+TkM5zsztCPBhE1oQ2+V8DbMXqPzezIUs2nyTxXhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhlzJMJKZFHJsk7x+F9n/zq/Ro+Cl+Iyzt0eJph9IQ0yKQquL/6mIpCx4tZBt79qTYnD5R28u2g1S7TpEWppUan9i2HKZDc4OZWVL04qq3JQCwUT0QpxDG6kzFJ3dVjbfMfhpFxAoiCrUsFUg1dPwO3VghZD7pXuraDVKSVIYwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=rn33ZXnX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so38781685e9.3
        for <dmaengine@vger.kernel.org>; Mon, 15 Dec 2025 08:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816745; x=1766421545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tTqTgQ3RTUpDiEW13WMdCLExMtis8Qsfy3jipvKGlU=;
        b=rn33ZXnXrEUhiqrS7JriKukKQKWUMch19+hIe4N4Bv/WJEHSMLxXGFcTjjHxxtmm/Q
         246+I+MVHCghoIhSeZLgpd31ii9B9rbx2NkrrIVLIavwg8qn7hRok7xp0Kkx9vGNyB+m
         vUAfWPLSBxo/J1Wp0eTFbpJBrl0UpvL3gyb3WY4pOZldzUJz1lw7+1N323Vxy/3/nmAX
         rwzoS0btRzMXb+kaIj/HWNEIbWiPMmqWwNGUKI/OxB/4j7lYS/idkTrn6dL2GGjhNd2a
         SP5w6YQMVX1eRB39CoflRlo5pciO8xJd3/gzTce96rknAtQH+YfUNADQXy8Z+3gnXXRE
         pGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816745; x=1766421545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1tTqTgQ3RTUpDiEW13WMdCLExMtis8Qsfy3jipvKGlU=;
        b=CPuTLjUWB1AUxPNWV1ip9lchG6VbZ4PDi+smYxMFcPz9INTGQ78HcmA0G7pfmLQsjX
         +4R7COVcqRJasJGmKLF7c3I93BJqOy+w/kuAMZql+uZUQcTRCFf86iaFR30DnH2Fombi
         2ANtI48vSJXriApIesMOti4bmNYRk0ZUdKyVRwh/Mok0ZkpnOPLKyiWUbojCSfyCiRwW
         BjqTdzsDC/8LobWuYyelQOBDrAT8yOkVDmygxWdlILV/U6TGfz7RNK4KYU1b8hutuclv
         aHOpbzpiZCCTcWFh7g3uz2BM+bGYmYjaHnyq3LVJbOvBM1xKsABGl3CyPuVe9UfVEj40
         I+LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiyQhgkpn/xTuS/RFM0oGCY7e3dJRB8TBZAeD0+08/G0sRw+HNB4XfReCQkdk0IvigyyuYCs+pNHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3N9lWLldFvjNmnQQOhZXb2IFaAz9WHl98ZwuEhDK0pMtUSjC2
	52m/3TsS30dSwTd0T3ebPyNd4YGFmyTWyGZeg0TxGX0S9DNyMN4feUC2XyT1ZavkDZw=
X-Gm-Gg: AY/fxX4X7aSCTp6PTcwBQg1aD6Yau+bxxEQpe9mobF93GUg1pH09r9HFvTyj5YX3LM7
	fpWBPRxKd5Vvw8Fq/YukwQ7OFx0EulS+DTuuGylSgks44/47vt9k4H4YolrXwmBuwG2SLDPyH3j
	lZMleVIiF9f/wDUlLC7a/t3WzKWs8+kslP2hfNLFTNeh/D5+RkmIhoDPMhprossXnFExZ8T6NHY
	C6/rY3uR18KfpZN5k1XDNDCFfgzz2l6dzqGJ4y07PD3Rnv2nIvpkYu+CZjTJ9yAhVEvBwRlWrH3
	byUlLWsx1o/+ZzTFZ8cU3aDXVS8DmZFCiObYnP9ru2bFE8RgB/RgzSvz7euultV62LTexZMIeMx
	8MhvbkXQUfJeZnduwyZ3uo/ggRrE6zJcbcEhae585vlBvn93qZV42PmrzYslcJt6i/lBZfzpQkq
	aChGoK8u+1oW6Z9ILI42uYtLlnE/7aWT8GThxS/6wNpoVb
X-Google-Smtp-Source: AGHT+IE6M+SXBjy46AfoFYCz7iRvtgEH/vJDLvmdk1N3q4CHw0hjvoykYQUZxdniQx5lw2yIA+Byqg==
X-Received: by 2002:a05:600c:4f86:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-47a8f9057fdmr118554685e9.24.1765816744763;
        Mon, 15 Dec 2025 08:39:04 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:39:04 -0800 (PST)
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
Subject: [PATCH v2 16/19] dt-bindings: pinctrl: pinctrl-microchip-sgpio: add LAN969x
Date: Mon, 15 Dec 2025 17:35:33 +0100
Message-ID: <20251215163820.1584926-16-robert.marko@sartura.hr>
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

Document LAN969x compatibles for SGPIO.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../pinctrl/microchip,sparx5-sgpio.yaml       | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml b/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
index fa47732d7cef..9fbbafcdc063 100644
--- a/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
@@ -21,10 +21,15 @@ properties:
     pattern: '^gpio@[0-9a-f]+$'
 
   compatible:
-    enum:
-      - microchip,sparx5-sgpio
-      - mscc,ocelot-sgpio
-      - mscc,luton-sgpio
+    oneOf:
+      - enum:
+          - microchip,sparx5-sgpio
+          - mscc,ocelot-sgpio
+          - mscc,luton-sgpio
+      - items:
+          - enum:
+              - microchip,lan9691-sgpio
+          - const: microchip,sparx5-sgpio
 
   '#address-cells':
     const: 1
@@ -80,7 +85,12 @@ patternProperties:
     type: object
     properties:
       compatible:
-        const: microchip,sparx5-sgpio-bank
+        oneOf:
+          - items:
+              - enum:
+                  - microchip,lan9691-sgpio-bank
+              - const: microchip,sparx5-sgpio-bank
+          - const: microchip,sparx5-sgpio-bank
 
       reg:
         description: |
-- 
2.52.0


