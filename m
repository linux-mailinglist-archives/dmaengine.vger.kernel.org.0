Return-Path: <dmaengine+bounces-7928-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58104CDA84E
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 21:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61CBA3020CC9
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 20:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFFA3570DE;
	Tue, 23 Dec 2025 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="vAEdXO3r"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7392FA0D3
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521291; cv=none; b=uRz8hqy+dTc1c63p5hzZDVq0nWJhOZUNB+q+Lc/JtJKSRm92CxCVWh745OTXZe3wW4QuwJuHPc34/6myrv0/I7WgbeGy2R0VR0c4i/APlZu0xbvllDSky7LchQon1UirgwmF/ePUeEWgssNUpP+dG3ie79nMC3rACcHpCswxs5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521291; c=relaxed/simple;
	bh=Q1obzpbb74AZt0ukfBT7/Xcte4bERP/uv0lOi/h0us8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEv5u2YKU/3E/BI7uRX7074HZlfgF+daPhvOSv0NbDNhfX4H9UZzBeBnQwyqeBEpvQ+oRYQPvpSygT/dtIMl3qeZri5JOwG7Dq3U4EX7RRtIrLUl1e0IHrVq9xzZWWgSe8Cahr41IYwLKDnXyZKb5KudElOdhIo7H9b6+K0M03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=vAEdXO3r; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso5383277b3a.3
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 12:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521286; x=1767126086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fD3TOo20gfVbUTTrRVEjhVDMuAvx6I5y/UndE2JGgIM=;
        b=vAEdXO3ra/1bm20X8T+iXv1DGUZqKx6guXdgGYlEe09deRwfl5bXIa86Eb9PSV+d1g
         89yhFC4l5+p3HDHL9B4t3HraCiFP2Abre+g5OOymalREUL4ViCVjaMatLcQOi73KgoaO
         su9Z87NmLUKhMW1Z4N3LrDbyJ/2M/2Y3Ff4tCAv8WODcWixujph097B2TZm09bAiaL+z
         5RusNCbtacBZhsJzqltsEvBQ/ROehlt9LNDXxG8a0iqZnYUEOZo/smkMaGNsonZqVIvW
         oB5htBh9H/x4y6/cNqzQFEF9xiV9o1T5FsZ+snE4miTlvCzGO78Af/4SYd4c74sDMOq0
         AwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521286; x=1767126086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fD3TOo20gfVbUTTrRVEjhVDMuAvx6I5y/UndE2JGgIM=;
        b=oc+x6f5XeQ/OsASsr1CjFdnlKX6fQecwEOVXYdu97Pf7v0nfhF0F0+dgZCU4f2lVkf
         ZymqyYkh7FfYh14PDf2zBmt7d9+xit6m2vL0FaEexC+FbdsFGf20Sv+PTOz5HpL51p/2
         YDi6p1Pyh71ZABPPb7bFJtHYeM9FoxHYOLbDIbC4Q9xRSAXwzOXl8jQWXhD9Vcc9Ye82
         J+EMzrQDNaJPvnT3dLqqGpfjj1zMuf0jAlurIH0YerBFNgrrPA4pMSa5A2eHOQlqWJ5z
         0VdKdFUDL6c978eFSagXDTSfU2Y49at/KbD4x5GvuR8Fac1UfIG/tlbgslH7wIYj9QIY
         jiow==
X-Forwarded-Encrypted: i=1; AJvYcCVAzDYFlTWuCiRE9TpWtVKBmsljfzOyf1sOfvmH6FLb4biLYyxkfi5FvhviubMBU/8zRtwvdQwVe9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+1r5A8pupN27VfiFsoUCcLKRPhGFOALNgeQK93tBLudmfH1yo
	07gtzTEHIpQnU1o612+/tH5S7phn0xeghpihwjNclnL6wvZiM9ACcu9Ez2wsHp4Io04=
X-Gm-Gg: AY/fxX4K8rZqWYNJmn8t763kVkudNj3PCPwl7McuFHmkCpG7pVdI2fOkFoB/HT0w2MJ
	Fgy8bF6VFzuB5LyPoqBPlfPFZFCaxhJk6T+taE3xj/U1SM6j0WZ7JCp7LUMeKLDn7JLILaLHD97
	npZLNpvMtmLBdYAcvBMyRdZ/pGFQ6gfDgxxvlGGxWbgqYRBEPiksZQQVhn7JSSbeQkIZSU8BPTP
	aGJMu51ZP9eGVJbcK/jsIJE5BB88M+eLl6FsDkm/IEgwzjZ9dNhyK47miXw5Qc5R/yR3zNlCk0S
	TPbO1BL6cJzI6VHy2g8ECdED3Q9SzT00NjDTka8154wusDGViFqqIQsN+tzGPAEYbqlCStuldZm
	so0SGsgpOexp6Lt8eV+fI+o+U/egYxhYKlYNoBOIiK/L/bkYbXoZguvDgzeL4OM8RNx0UWk5ctg
	fHR8SHZqQ6dPPWQnZXh5G59tKHwf//EYLjdmwfyxYO7j93otAP0tjcE3Rlavp+ebLII0weWJiab
	eRLf9Y4EplcnVdhW2I=
X-Google-Smtp-Source: AGHT+IGKTAqrl4PGe4SFW7qu0192lJdQVYEzpdtaZXHZbcUYB4ioIiqnmVp7I/qce4lXwOMNJA61Eg==
X-Received: by 2002:a05:6a20:e293:b0:341:d5f3:f1ac with SMTP id adf61e73a8af0-376a9de5b1fmr15092285637.41.1766521286558;
        Tue, 23 Dec 2025 12:21:26 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:21:26 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	broonie@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 12/15] dt-bindings: pinctrl: pinctrl-microchip-sgpio: add LAN969x
Date: Tue, 23 Dec 2025 21:16:23 +0100
Message-ID: <20251223201921.1332786-13-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223201921.1332786-1-robert.marko@sartura.hr>
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document LAN969x compatibles for SGPIO.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

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


