Return-Path: <dmaengine+bounces-7624-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A40CFCBF098
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 17:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1C3F30B0A5A
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828C23376BA;
	Mon, 15 Dec 2025 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="ZR2hFQ8E"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EFB3358D1
	for <dmaengine@vger.kernel.org>; Mon, 15 Dec 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816731; cv=none; b=ZO38UKuhySCLkDUMNKuqxAJ6UuMayKdvZ77CdoNA2Aaj9tolpqBRToI/+T25A0jCaLyFOhnpSlu6UY7aYDNif0G5iHu/ZKIC9ySK7Mcj7GcKnLrov++cWToWniFzQRLKgCFB+B85R3yoLATAKf01Kmg/NGpc69aZI48xUsBfgQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816731; c=relaxed/simple;
	bh=71vt4iyiLZEhN77G8cDPBZ3tS+ZW0JysnwtVg4Nk/+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlLBsYeJP8Yomt9CGmLgEuNhWq7UFbkGoNF9ehwiS57xKDWwWr3q0c9nMnKelXyi1GsBUnudOWYFwQ0C8CwJ+em++a+dHqUJFI4mFrkVKIgIoUg4XQZJfqic217xRMf9IAm5VjEhIQA3DVnow2/78LlK2uXeyG1LZuKIwnesQNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=ZR2hFQ8E; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779a637712so24955965e9.1
        for <dmaengine@vger.kernel.org>; Mon, 15 Dec 2025 08:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816724; x=1766421524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhZHb+UU/3uI1zhxQGkYOMy2iOjOd7yGE5qR+fmsO/o=;
        b=ZR2hFQ8EE14oGueyiW9ZKeCNVEf16QNkEo5WkatjheEPmXvl7ymhA8dsYlgoCoUFpO
         G0JBjD0my2hDkyDD1bKay7O2yESjV1Ycb4Oc9qR9az/UnPJtLuRIB3wvRkQNuarmafk/
         tmN9uxP/RDWnozUp9hseevemJsQHJnP8zSx9/LQM+LbL4ykX9dNQb2JgkWzSpf2CK6GA
         IKsPY0AxDee9H96Zz3+irzWfjg2suiTW4kRMPje2G2zRXF4+w9VDHE03DKZ4Lisf01Ct
         Pq3uyZeglNn8Ik3WHr/M0J+96bkPqLIcuMNMeP2ilD8gzxiDkxXUUxKDZbsIPMzS6smC
         OSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816724; x=1766421524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhZHb+UU/3uI1zhxQGkYOMy2iOjOd7yGE5qR+fmsO/o=;
        b=lfCSdfVdJjnf4yfklEXTpSD0k6sG8YjRHkFB3mzb2LCkUmqPI4/rx7PSEYQ2iMSHJ2
         G2LOVXRgnGi7UYuyj2KhJu5FUtXYlEbHSsk9xh+YVTTk98RLacvi0q9WEJXWzRM0NEtk
         nWP137OgbDTAgzNX52OSH1Gwqgk6XgxQQ5jN69NByga7j2jpVjQC7HbZN+TaK5ui7/c1
         H1t5ftZvaIBKp0XuFHhrir4XNfStKfSL+1br09okVLBa1n11F2doaeHfcHMmCxwuRDDz
         iS7Ks6Vu19vXtgYV+Kueozs6kLCY2Shvv7DuaiVvLvMh9/RlWmhE2Y+veVE1XjWpDKtT
         mdBA==
X-Forwarded-Encrypted: i=1; AJvYcCU4L+g9KEe2lYfHQuN/hCfVn5HAycHiJlOy4YKeglXJ4ALXWGP7FmtCCUsTbV//ZGFTVMCltNqXMjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoKDv6aN4C2uQhErQoWdXXj5Wcn9mih0Ubaw23zOPgNwxoAir
	4etpivP2jLiUiuVNBJjJiHrVEGaNGbuoY2DK+oJN9rxQGogSo4ob6XZsAXkZQv0bIoI=
X-Gm-Gg: AY/fxX7MkDgmAtEV89vtKlsqEPnAK4o4Lb4r4oVYo4QYRlVIrT1+j9zFjflBmpfjH9L
	vKMl0w9GOfVdnVQ9CGWhee1Tm+nhL2ZZC6mLNtcpR1nbR4jYXqO5dDbae6r/Isf7szsbkd+p+nU
	UnYYIg02SrGkIPR8+FtCekZtRdMTKlgYIX63bm9/OKG1sbKNb0xysk91UMv9bvtr25EDq99Nvj4
	T5k34CKCB73fPkTL7repm31RR7U7LYNM04mtPL2oQ6klu3LqdFehPTdyEg0ZVocyrchkbO6G9q3
	cyaS7Tatp+pB5FtqSkl1u6E1ocYV9ye3bgTMMhScCccnZiNr9ID5ZWeLGjupBudP+jSADK064Ye
	gPmnsnOcV+RbWIIj173D13qwP5OvPyXBGNNO3tfnuCifWYHIyTJ1j0GAhQVF3Fg7o2dgjLSNYlN
	rpEdcbC/1L2wcLDGUw/KWM7AWpDs0LZTF40FD331TdK9v2
X-Google-Smtp-Source: AGHT+IHtktJVK1XDeqQwSAII8bPqSZeOj9G+2EJJX5Ej20zke2p/ReS6z8A85crs/C2GxQTMQp3S7g==
X-Received: by 2002:a05:600c:46cb:b0:477:7a78:3016 with SMTP id 5b1f17b1804b1-47a8f8a7f0fmr122138175e9.8.1765816723603;
        Mon, 15 Dec 2025 08:38:43 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:38:43 -0800 (PST)
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
Subject: [PATCH v2 07/19] dt-bindings: serial: atmel,at91-usart: add microchip,lan9691-usart
Date: Mon, 15 Dec 2025 17:35:24 +0100
Message-ID: <20251215163820.1584926-7-robert.marko@sartura.hr>
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

Document Microchip LAN969x USART compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index 087a8926f8b4..375cd50bc5cc 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -24,6 +24,7 @@ properties:
           - const: atmel,at91sam9260-usart
       - items:
           - enum:
+              - microchip,lan9691-usart
               - microchip,sam9x60-usart
               - microchip,sam9x7-usart
               - microchip,sama7d65-usart
-- 
2.52.0


