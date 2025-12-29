Return-Path: <dmaengine+bounces-7961-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB516CE7FD4
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 20:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 426E43058472
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 19:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7528335575;
	Mon, 29 Dec 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Eg7mWVXD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B8246BC5
	for <dmaengine@vger.kernel.org>; Mon, 29 Dec 2025 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033617; cv=none; b=EOfqj+h6JfYYO4DskY1HGhGsstTbsNO7dz0VCOwm7a0zNuBhNmdarBRYCcgiYEqWhb1DlxJdyphXNr4YPp377uSpjEy/ThbM7EC2wz+ec2LBPQOkFb/ebXKFOov5WRDzYHKixjTYVGAL7PBBra/TkofgUgzlZMDIVY2Nw9JqlzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033617; c=relaxed/simple;
	bh=Z2AkBlH1TVCbTdGSk93dGvIgyGWQV34J6Mazauy8A20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LddbS0prpZebRdvR0RnxnHoxGVRfN4vQZWqH0bPxu5z+6mttkm4jJGjU5iWBqgqlB38CpnCAOQl6DCd9SwJLVT3yRt1lv6NrMIhKAxv5yPI9QzsXRSQJV3crhiZrodhu1QZAgDEskfZkmn0trmrR3FXeCoWJ3p4CHO3I7NvwkJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Eg7mWVXD; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47a8195e515so57683825e9.0
        for <dmaengine@vger.kernel.org>; Mon, 29 Dec 2025 10:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033613; x=1767638413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xMNev2+IL4W0rOk2+Sz1iWUW5i0ra4Z/24SBDIc4eIk=;
        b=Eg7mWVXDvdYJgNNjNjkgGCYqLOWaxsoVZaFc0g7FWoksidXXmUr5vG1VUv1IFVtPEd
         maJ95rcL3bwn8vXWDnxv2suPM415fWG9/khKeVESYJuEYkPhgWeYLXPlTlBL81EVNWNx
         UPq7EQQdI2JpoDmbcte9dq4zTwZ4v8FLpHCUKliikOSagV35Dofdtwyu8gvj4lD4mjHh
         TG9jxzHxlJaWGRfHWerg0qKSeTnIN6arcp0tIHKtQ1CM3Xg22+hbD79IW2Rk/nVySu2Z
         LOz0ijMEz/Y6C+qz5Ry0N3hEbGAwwvSn8G1YWSCLk6bpDep9T1WtkXMDhM1Okc3BrON+
         e3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033613; x=1767638413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMNev2+IL4W0rOk2+Sz1iWUW5i0ra4Z/24SBDIc4eIk=;
        b=SbR+qFuZw1VuYl6gXb5qTAs5rx0mYrYGs4Kf7CorSs1yLUtvzxA47vTWwU6FZGB3sp
         KeoKXX0E9cWQdZsUnBMg2kDt7a417tGprrlv5D+U8o7KiLUf76KloaYo0CJUBmwROt44
         bZJMpVelUBwmz48VoVlMzC7wxf3cKSiIPlm9xEtNWycqwGQOaVpTkelo7y+X538Cjfnj
         39ETpH4wsFFDHOXF/62wcyyVb3e3Q33uoHs573SjktIdzC+iC1QhBdcrxGh4a8/v7Lp6
         N5E+6BVtgMO4N8/PZ/aoS7rUR9IrxKAv0zSQSRIOzHc9f469Yd3aA5D1kLQdO9PiVNU9
         b8WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH+g/8y4JzDLo7AW0349oh8rTmwgTxGGHkADCsZV4OFjgjZ+AYT8cT4C0d8AwZODVZYcIZPc+SfaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHHx5BSi4TzGi6vXmpuEIVI6seTaVj2NZrJQWGChtrrlpCMVny
	HCc6wMybSXAOYANp+NpyGpYCGCCLZpu0zgyPBmlaTE8qtiDA7PercgAcXXbOhdWlbb4=
X-Gm-Gg: AY/fxX4brepNPOYgFPoVoiTzBX3VDw/1CV68c7Tp+MGB6zgLgzRxaEMRSc+Cmpld5va
	Mqi0x7A7Uq4zpdJIl14bps/qcRsi/uCw5UmgKK0fRwaaKwFvA3P939A6YuPxAkixIzGk0HaKlVJ
	gFWqB+qy7jTM6KahPhay2FsxeCP+7LnKfNuFLhKHlq1kl5Mdje2NLfDGButiQGzCo15nZYy+Tta
	vN6D5vg2r7GRYkgN9caDXj0SrqIAOqg4rl6qka3tNaZhaZ15TbnjRenhdZMJsCv8GRlv/EqpLHQ
	tP08/VBavgO3qC9ui5SqB/41OguxkfkCh/R21Ur5x3CArynsqgtijetIrcjrBHSgNXWpnFGWTbX
	G6wfFM+/L7OzH88CtzetNy+eY3O/V2hrw5NbdBRhRiKxicVx43rNNpgZJM+FSWQWO10jBxamX6r
	0DocaoruVTmmSswD8B1IO3ksuUKM6OdWLxcIjUI35inap1m6ZTHWcf2iLWhVQ0WQbZu7n7c6Xxj
	k0r/ScSbvbnmqC1PyHOuOh34rO+
X-Google-Smtp-Source: AGHT+IF5mVbnc4OdKlh0x4EYHuw7zUgN0QfqgRBI5YPkVwIvD+VFTU0drNG67nyewlPrP/fkHHcexg==
X-Received: by 2002:a05:600c:4ecd:b0:477:1bb6:17e5 with SMTP id 5b1f17b1804b1-47d19593e32mr383263515e9.30.1767033613155;
        Mon, 29 Dec 2025 10:40:13 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:12 -0800 (PST)
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
	linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v4 00/15] Add support for Microchip LAN969x
Date: Mon, 29 Dec 2025 19:37:41 +0100
Message-ID: <20251229184004.571837-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the Microchip LAN969x switch SoC family.

Series is a bit long since after discussions in previous versions, it was
recommended[1][2] to add SoC specific compatibles for device nodes so it
includes the required bindings updates.

[1] https://lore.kernel.org/all/20251203-splendor-cubbyhole-eda2d6982b46@spud/
[2] https://lore.kernel.org/all/173412c8-c2fb-4c38-8de7-5b1c2eebdbf9@microchip.com/
[3] https://lore.kernel.org/all/20251203-duly-leotard-86b83bd840c6@spud/
[4] https://lore.kernel.org/all/756ead5d-8c9b-480d-8ae5-71667575ab7c@kernel.org/

Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Changes in v4:
* Pick Acked-by from Andi for I2C bindings
* Move clock indexes from dt-bindings into a DTS header as suggested by
Krzysztof[4]

Changes in v3:
* Pick Acked-by from Conor
* Drop HWMON binding as it was picked into hwmon already
* Document EV23X71A into AT91 binding
* Drop SparX-5 and AT91 bindings merge
* Apply remark from Conor on DMA binding regarding merging cases

Changes in v2:
* Change LAN969x wildcards to LAN9691 in patches
* Split SoC DTSI and evaluation board patches
* Add the suggested binding changes required for SoC specific compatibles
* Merge SparX-5 and AT91 bindings as suggested[3]

Robert Marko (15):
  dt-bindings: usb: Add Microchip LAN969x support
  dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,lan9691-flexcom
  dt-bindings: serial: atmel,at91-usart: add microchip,lan9691-usart
  dt-bindings: spi: at91: add microchip,lan9691-spi
  dt-bindings: i2c: atmel,at91sam: add microchip,lan9691-i2c
  dt-bindings: rng: atmel,at91-trng: add microchip,lan9691-trng
  dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
  dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
  dt-bindings: dma: atmel: add microchip,lan9691-dma
  dt-bindings: net: mscc-miim: add microchip,lan9691-miim
  dt-bindings: pinctrl: pinctrl-microchip-sgpio: add LAN969x
  arm64: dts: microchip: add LAN969x clock header file
  arm64: dts: microchip: add LAN969x support
  dt-bindings: arm: AT91: document EV23X71A board
  arm64: dts: microchip: add EV23X71A board

 .../devicetree/bindings/arm/atmel-at91.yaml   |   6 +
 .../crypto/atmel,at91sam9g46-aes.yaml         |   1 +
 .../crypto/atmel,at91sam9g46-sha.yaml         |   1 +
 .../bindings/dma/atmel,sama5d4-dma.yaml       |   4 +-
 .../bindings/i2c/atmel,at91sam-i2c.yaml       |   1 +
 .../bindings/mfd/atmel,sama5d2-flexcom.yaml   |   1 +
 .../devicetree/bindings/net/mscc,miim.yaml    |  11 +-
 .../pinctrl/microchip,sparx5-sgpio.yaml       |  20 +-
 .../bindings/rng/atmel,at91-trng.yaml         |   1 +
 .../bindings/serial/atmel,at91-usart.yaml     |   1 +
 .../bindings/spi/atmel,at91rm9200-spi.yaml    |   1 +
 .../bindings/usb/microchip,lan9691-dwc3.yaml  |  66 ++
 arch/arm64/boot/dts/microchip/Makefile        |   1 +
 arch/arm64/boot/dts/microchip/clk-lan9691.h   |  24 +
 arch/arm64/boot/dts/microchip/lan9691.dtsi    | 488 +++++++++++
 .../boot/dts/microchip/lan9696-ev23x71a.dts   | 757 ++++++++++++++++++
 16 files changed, 1375 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml
 create mode 100644 arch/arm64/boot/dts/microchip/clk-lan9691.h
 create mode 100644 arch/arm64/boot/dts/microchip/lan9691.dtsi
 create mode 100644 arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts

-- 
2.52.0


