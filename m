Return-Path: <dmaengine+bounces-7967-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FF0CE7DC0
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 19:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A73F5303434B
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 18:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD5F339B30;
	Mon, 29 Dec 2025 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="LxExKaDF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8CB3396F7
	for <dmaengine@vger.kernel.org>; Mon, 29 Dec 2025 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033629; cv=none; b=gxxKOFRJajClsnSxzjupd5VuCVTcYOw55nif5QTDugHjtwaEMogBhen9t5hH9LZarBL59Fn06MuLd4GxtREtc5I4XyWhW/hQXvbEAtAiduHvvemiD+GLqFpwocZYhh4s1/OgfsfnXdeYpedNlDtUoouYpipJLatzop2kl5n3ywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033629; c=relaxed/simple;
	bh=FesjP41xiT0Kda2nCLhQhKtJNrqGgysPl3yJ23vj64A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJlthnzxZjlGdI/jJkOuG27JbqAuYRrlqhRO8ZISCnl3yQEDU6zOaRZA+OBT0FcXb8DaH3nD4OnIrFkhg7muxSD0IM/pLVme3lE88J4wNbdUxhXuUCSiXKhsGVAo1V/86wzbSiIwkJCGZOCvMByOXGsIoCh5rlHAgDtRoGiZObg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=LxExKaDF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477770019e4so78728815e9.3
        for <dmaengine@vger.kernel.org>; Mon, 29 Dec 2025 10:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033625; x=1767638425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClyoGQdLbQ+NSakHU5SbIxGsiXAmeIUAvdUGZfMfHas=;
        b=LxExKaDFv6uraKbr+yups4L5dBCWndQ+BVeBeBthUnl/mH1kB4Ls9qNN/M3IYMPAeB
         7kliaa7Cr3EJ8W5qDWd9PWb+ZEaXk+HiIoJyIECYHKmRu34OFvZx/eQumReZG/4jfPVs
         ciQ8mZnqyCEXea8WhUxwJAkOL6ARc1YKP3d+MpkUSl8kuAd7McX033YEB5aETP95086G
         Smo1X2VH+HzwgbCOwr0Wqkyd2ETC2NVtxkCG7MV+59lO6D5d4cIjBoaYzPcHP1mfv2rL
         QRf6Wt9KFjJRrMVVPHbUmfwIZMAmyrBtexsip9mnS0FU/TNf8Mzcx4Zc67iLbTlJLTqE
         oS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033625; x=1767638425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ClyoGQdLbQ+NSakHU5SbIxGsiXAmeIUAvdUGZfMfHas=;
        b=lN+mWqQKe+K5131UHaN3Idi4QrkdIdecPX7Gt9+6GNMdwaVcc+WZftwEftnrG4QMlw
         lxKI19MiLZ+2OyKFiqNxo6M3SYwVQe8G6jN1jZ+cHr7W1BszBfu4rVGhjA/6aGWxNO2w
         q9EJ+OWHsxRDqOsq+6xDt9KRiVED5keeG7l0sgwpgXyRvE7X2XkpgkChqeMxI5iKG7OT
         ZdOP0S13VZz2xDtK93nqdEZjVS3DWESGQZbAzlt0dBt1QzjBcQIXnn42PxkPxdMjICWi
         cSoXKCwCI6186NO3YTStu3vvdw0jriTcMWf8QQEJSumzGCLzO4qwL2+4l35ijg9DpPmn
         +H3A==
X-Forwarded-Encrypted: i=1; AJvYcCX3KpZQBrBK0NeYG2QP3VZLAGp1bSEea9W0JpcETguB48ax7CDrehw+Jaj6uvNB2f9NjNG0Sztbi98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKQYzjw4LfbIBW+e0J4+yOGQup84cPcxBWuoI+5zDC1SA4i63p
	60jOirDuLHeFkb50ruc2eroK2A22mwGJQt9Qt7rK8sIOxbSPsAPJYhg1Fe1p1tsr4JE=
X-Gm-Gg: AY/fxX5iRQS4r2WIQYqCPZ6wgM1ujM4oyLTZePyDihC4gjAisL9zxTh4fRbnw5LPgxf
	b62ECXIHsyP+m+Ob6VU4CmYAaHa0NKu7MVDvQuQUwAlksfNtsvcls5CezRDYbUHAI9hAL8KgNtH
	qGY2hLgGEbgK6IfDfCwsxITuiXUh9zTEJGInhTlHrzeTIxrUvzesfU70CVB1o1LowhCZ4O3nRto
	AOd3b7oCA5/chxrWoA1ohHv7YSk+y+ZfzQwHJr6iDlZUuwaNHEVkmN5XKa0st7diWknfFeaOcdr
	JF/CSQD5lCOJ0msUjHrQAlSwMCGM3gyaUEmdOK+hdM1hZov7eGUXOXdGORjmwTsy6s07ci6DQjL
	6uNf8+ILOkkbVDyHDJ7ZQcMCI5LZno5IYAvCkH96IRUoA7mPjdNcgeZbmucot2IrD7MZepQKNst
	17TN8mIY8nN7rdM0zZDe7WMIa1i0zG5lNtMQDB5L4GAXH4EVOTCbtPpYAdh6D6CgNrCqph0qGmV
	weFefg1NlBvRKTiv9V7txTGqzkQs7DmUU/alvo=
X-Google-Smtp-Source: AGHT+IE/qB6NEHP1QqGV5PfcwRRofx95tVM5do9NhE19foMR/57boxHx8KStBk+G0GxCGRT1W9RoKA==
X-Received: by 2002:a05:600c:444b:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47d1953b77fmr317021115e9.5.1767033624761;
        Mon, 29 Dec 2025 10:40:24 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:24 -0800 (PST)
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
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 06/15] dt-bindings: rng: atmel,at91-trng: add microchip,lan9691-trng
Date: Mon, 29 Dec 2025 19:37:47 +0100
Message-ID: <20251229184004.571837-7-robert.marko@sartura.hr>
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

Document Microchip LAN9696X TRNG compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
index f78614100ea8..3628251b8c51 100644
--- a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
+++ b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
@@ -19,6 +19,7 @@ properties:
           - microchip,sam9x60-trng
       - items:
           - enum:
+              - microchip,lan9691-trng
               - microchip,sama7g5-trng
           - const: atmel,at91sam9g45-trng
       - items:
-- 
2.52.0


