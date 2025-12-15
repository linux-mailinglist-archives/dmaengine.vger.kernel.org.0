Return-Path: <dmaengine+bounces-7635-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E80CBF24F
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 18:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B2E8304B38C
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 17:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E7B33C52A;
	Mon, 15 Dec 2025 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Ak7lyKPT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4638033B977
	for <dmaengine@vger.kernel.org>; Mon, 15 Dec 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816762; cv=none; b=QDv535ExThOHFZKd+Z+K/ViKyC68QS0wsqcXzMpBJhKMYPMR+N7sSCsa1vuQBfZrqJXZSEsVZs88BVUpoJ6G5oe0a9sE7yVRi4uo2eQU5AoH39vMgVuBgNpkfGTVP2N8guo0dIiks7cZ6oRvD2z/eoOK6cErtalO0YF1SRlFeU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816762; c=relaxed/simple;
	bh=MatarePl5a5XyouzXF+9ZryyErb8D312+5WkUP2SbUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrMMMX4wGQ/cvheSxp9wrM1jjTg+SmvBEY+GmfOTmSDo+96ymBujP6rmqO5Q5QeQMzBTTKM9BQseUsZaAXmcj93dTehwwe0nzPYofP5WQRfkJKHTE+1CSBCbb+0RbOAMa15HvVe6+YWcli2mPgLi5I2gRq6jsXv40oy155gT9p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Ak7lyKPT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47789cd2083so19222895e9.2
        for <dmaengine@vger.kernel.org>; Mon, 15 Dec 2025 08:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816750; x=1766421550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8YcHY5v5BL8p7Cq7PHlLyAS2e/CqidtOgzAnVomKxs=;
        b=Ak7lyKPTdvJT/5Yv+iN/8LSGRVf5YK/mE3nJ40Yv8v5WMEygg6FZqSllz4L9oiC6g6
         cVzdeYT+IXU2lNR1S9VuWsHsONOsbxwjqKUQUGF/bXURX2ZECo9CEKUcMdm4FbZocUdm
         2i0wVhkFw8JWyji/ASYx2hz40xV5ycXhF77Uo11OdNHF5/+f9r/2mQtbTpjB3TSfXh6L
         YYQkoLq5+xTuie5xaF48zIMd1GQKQg+73FbhoRQhJifJZ1gSqMtPxYHCa6AzJ9AD1/ab
         oD2K8HRM/EnxuEWq/plNpjMA2kCTVieijCNKzQpUH7KbXIx93gk1euQD6vOPM5SzUX1o
         gsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816750; x=1766421550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8YcHY5v5BL8p7Cq7PHlLyAS2e/CqidtOgzAnVomKxs=;
        b=gpaoLnL1rUrJjvyd5UGSeusN2RWGDEwdBzJmaJt/S2IuswUIDOutLyHVZ344aqxaX6
         rdpi/7IOB0fb6WtJ3MlC5jdriOk1+X/YgE8LZvuoqmRnGQqL24BDpg5ZOxM4F3qZqgDa
         Pd7a9vYsHEABmGMfYBw7DkwAal9UcTD5uI88X+OyK7z8gkhWCWuekjTrIF14xsgz6N/3
         rD+TC9YIgGvm1jrjJnEsQPnRck7Hgifqy0DrdSc7D40d0IDmeZeNh7gGZ7oPCXCM9ZDz
         QKrnoxvMuqRqEDgXYBL+i9Hdjb0N1OJNllEMw7yZK/bSD/Rzh+TDmjINtHxQYXkfDjuf
         Vmmg==
X-Forwarded-Encrypted: i=1; AJvYcCWCYTrkGQaFU4Wej2B9DDXEEUQVK21avTIVOGbF9kdUVWlOsP0wZ/NKIY5JRAdvMlVimhznxsCavTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqyCA1n/luX14rOlIS3TBEjvZ14SD54lid7P9JQoAH/XhxYpgH
	Dx7XNrYlaDb+nYX/7J8qI3dmPPPdrYQf5oQ2Dv+X6LDgURgMWoTgVyYz5Upd6Rf010I=
X-Gm-Gg: AY/fxX6m9mTcOtVESomy7XiJHpKbtmOxk+gwldNUWwID5PWi2682LTLWv4avl41gEsK
	PecpBPBZMBGDm0QRAjDu6Z7kq5P+25QyJ7k08dYjABUuit2/+vM7NF9/PUXzRHZACk8U6RfPIed
	iXJV0/2Z9zZC5yxjBJnhbfXyP30g0sYqd82WUbHw6xCzkB6PUzHTHOhr5xPUpuCsr1nA7TCvz0l
	ZGUVSZTS6lAZTFZDwUUoVCaFx0tn3Fmh+uESMkS3qx3E9ByREehZbIAd9DP+E4XG92FHXj1zTc1
	HSsvwl5QGYPWPB2H0/EDX8dzJn1b/gq+Rp67A3iR0394v8TxWoKwLOwoU0qippJbmBGsSGpeLEa
	rEfeho1gLlT6+obhI/p+IPj/T7i3a4yfk88uaJwRYRsTGh2p8KmmCPJSNr10DWxOiHU3vANoK/g
	Ifo3su+R/lTzAblzIzcK8I5WmQr+FEf3V7FeZ+wQQtER/+
X-Google-Smtp-Source: AGHT+IH7LP1zL48BN4L4uNrnTgDczVYK0VmpeljjcZUIjxNDtnXInUvDJihsME7YWq6t8mes39E9Hg==
X-Received: by 2002:a05:600c:4f86:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-47a8f9057fdmr118557835e9.24.1765816749513;
        Mon, 15 Dec 2025 08:39:09 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:39:09 -0800 (PST)
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
Subject: [PATCH v2 18/19] dt-bindings: arm: microchip: document EV23X71A board
Date: Mon, 15 Dec 2025 17:35:35 +0100
Message-ID: <20251215163820.1584926-18-robert.marko@sartura.hr>
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

Microchip EV23X71A board is an LAN9696 based evaluation board.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/arm/microchip.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/microchip.yaml b/Documentation/devicetree/bindings/arm/microchip.yaml
index 910ecc11d5d7..b20441edaac7 100644
--- a/Documentation/devicetree/bindings/arm/microchip.yaml
+++ b/Documentation/devicetree/bindings/arm/microchip.yaml
@@ -239,6 +239,14 @@ properties:
           - const: microchip,lan9668
           - const: microchip,lan966
 
+      - description: The LAN969x EVB (EV23X71A) is a 24x 1G + 4x 10G
+          Ethernet development system board.
+      - items:
+          - enum:
+              - microchip,ev23x71a
+              - microchip,lan9696
+          - const: microchip,lan9691
+
       - description: The Sparx5 pcb125 board is a modular board,
           which has both spi-nor and eMMC storage. The modular design
           allows for connection of different network ports.
-- 
2.52.0


