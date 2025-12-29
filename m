Return-Path: <dmaengine+bounces-7975-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7603FCE7E7D
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 19:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7239303A18B
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 18:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3519B33CEA3;
	Mon, 29 Dec 2025 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="eDl6YqTI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80633D6EB
	for <dmaengine@vger.kernel.org>; Mon, 29 Dec 2025 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033644; cv=none; b=G9RvdzdIp895N8Xqr1T87xFxtHwY2x2HPI6coGIOa6eylNDUmhp4JiHG8uio7lzyrS2ot18vmR7TXgfL5a8s4Fba7Gs1VAqXL47u1dL5fzvMia/TlhwPRF4aJZyoSDOj6dLzx5oJwHxOes+iTLSbqMyFywGPkSbUUrzAwgDbPPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033644; c=relaxed/simple;
	bh=XoF0Eovrxm1txLTrLfP7MB7ayo4/Y25gdep/95xkk5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xc+je59WHqJArVhgNclpDFcpDCmGZY38mtLmUfGf2GQG9PXR0RRHHimqtPCZIazmtKmlYEiocKKBkD+Kf/PZk5vOa5RO2ptuDYtSJMzd1Z8yf216q81kjBw8FmxgXr1BSY1Wi/9ZDq8YRHPiHqKimFEznXvWJxuzQClM6BZKSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=eDl6YqTI; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so93002135e9.1
        for <dmaengine@vger.kernel.org>; Mon, 29 Dec 2025 10:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033640; x=1767638440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfMU7MT4/V4GUajmsYnn75DFErJTnupop06HbanZvHw=;
        b=eDl6YqTI35mE7mdIDYxmhJcA4HqpioN6T+TrIWpO7rhwFXtvwMqpaCt2rVWa5KOT3Y
         PzQmjNcD3ZrlKKrL+sLhAkAO1G+9JFeLQ6HfZ4RLRD+vGzqZ8nbHnAvPszy0K7JPB4H0
         5i9ecXb3tDLcQBOFCP5IF14KvLKRYmOOE1wWHk18pvjPph5g85omJIHxFYCFgCNgFzc5
         rRMoxkFKU+zAxax3cIGiVYf33wmRRaGswKq8m8cmtly5hnQJEOUTlktu8+2f62IgiqfW
         u/Neehn5EO2WPKUDyLjLyQBW3zkSTpdvIy0w+c2swIdgRBGSJSsWnY55ywc/rwY0oCsw
         nL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033640; x=1767638440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qfMU7MT4/V4GUajmsYnn75DFErJTnupop06HbanZvHw=;
        b=pPDYul94MJMxt8vAU7OV3N6xSIeoMF6Ak4hsnQjrLDDj0miLaPIWljtYA251nmVVrl
         jn+iPDDp9pgZ3pL2OR7ErgzDb3lQIHvBfzDr59ZPmfmVhvtYdfR6GaKd2BPrLEgrtVar
         YG8LcX1A6BFh8tCk+6d9d4EdQdISnyJ4290DOZmXkioavuK9g6W0J5gEAcjDyrUZK3KE
         EL6hRSl2Ur1fwxbrZkxAuJFY5wNzUpvxEoKnWr9c6l5mvsU9ea0Fdb0S/hYEUy1eSM/9
         TAYURJh8fwxhByN4ZZJh6y/5RtxvWzLYKo6VcPPFuGzI6eQ0gdqhEaCSrR3E3+CxL1Mr
         q6UA==
X-Forwarded-Encrypted: i=1; AJvYcCXS49E08aIS7I3/EjEhocb1cSDe+mRoYIZAQJsnTRvbkBbPExip1RXnX14+g6YGhbqaLbeNQmndIxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCwUiQLY8tB7cLQCXbbDZSs4UWOrbWqVt9uFPVa4Bjo0EyGLvI
	+2+FGFyWQ0SDHmEAB6Yj7meyOYRkV16uCcagc2BjWtlDQ92PMLEgluUadeo40Mijcd8=
X-Gm-Gg: AY/fxX5kLqSFwxymrmx6mOaoBdKVyRL75F6jjB977emPG87H1iLMyZd2WwhbeONx896
	A9sym7+6UBhLbamUTClS9/PgVzLF3GV6irEi+2YcQaVnSrFOYTJTDPmlty/eO9/6zrcfGUGE1X1
	jhh8ImBqXssuJpNcmSFvz2ZiIQJEBiDoAnl1ALWuIyFtCyOZwZpB0UOxr+qFSJ+qK3Y1VRwmSf4
	irLvNNP5KMfluHQaiL1iUoXlUqqg9x6ZiX3RAJPlX93r4+E4UiImOHIOqNqypId5ZzBnx5Q3yIu
	N2ZcCVXABetFrzIDfng12kEzobQBR145JGm0+Udjvl8gJadjSkRubLeC0Hn1fH2HusQeyysZ48U
	ysozXw3tPI3+ESNqAhdYlC1ebdiJDP2/ldxTdmMcg2k1Hxzc5ZhdNZE8fS+ckt1zLr3SnLXYikF
	bqCsl7h28oZjGc/S3PGEeJPiGHYPUJ88U2RhmCJZeklJqxqyePWJ17FQBkF/wLxV9smSIoNENKs
	nG5r9gGc/9+50OUSbXenBgzhR1a
X-Google-Smtp-Source: AGHT+IHW2rHrGjnHbMx7gSl8Rbl6YVS9e37XXYhb9JI7btIp7PDkapkLHawpn2EWrbvZF2/0cVQnBg==
X-Received: by 2002:a05:600c:8595:b0:47d:5d27:2a7f with SMTP id 5b1f17b1804b1-47d5d272cd4mr3349085e9.26.1767033640044;
        Mon, 29 Dec 2025 10:40:40 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:39 -0800 (PST)
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
Subject: [PATCH v4 14/15] dt-bindings: arm: AT91: document EV23X71A board
Date: Mon, 29 Dec 2025 19:37:55 +0100
Message-ID: <20251229184004.571837-15-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229184004.571837-1-robert.marko@sartura.hr>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
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
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 3a34b7a2e8d4..b0065e2f3713 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -241,6 +241,12 @@ properties:
           - const: microchip,lan9668
           - const: microchip,lan966
 
+      - description: Microchip LAN9696 EV23X71A Evaluation Board
+        items:
+          - const: microchip,ev23x71a
+          - const: microchip,lan9696
+          - const: microchip,lan9691
+
       - description: Kontron KSwitch D10 MMT series
         items:
           - enum:
-- 
2.52.0


