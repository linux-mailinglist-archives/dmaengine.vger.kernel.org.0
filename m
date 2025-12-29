Return-Path: <dmaengine+bounces-7969-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F69CE7DFF
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 19:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7079230552E6
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 18:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF5133ADA1;
	Mon, 29 Dec 2025 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="u+C/t36R"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651333A6FE
	for <dmaengine@vger.kernel.org>; Mon, 29 Dec 2025 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033633; cv=none; b=lhk5nQklYCoXrXLA1F4mxB0ooapwouWDNi8tOfavLQzoyWC5jEHir1u154AIiM4RXGTsaq8h4tuxvNPb3su20ZdhBBeA1CVwrwyd4oKjpBkiYw0Qo2ycDyvEnqnADa9+uXCpdXgpx2+DFi/4TJt5/4f4bQtKVFxvSTo10yCEfiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033633; c=relaxed/simple;
	bh=7hKH5EzmH1tw2QTQXNXPEJl0sVHK/le/PcpUxmqe6fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAimOsZI/zpShQcLrtU8p3keq8jzpAg0Ur0ca52pJpzbrYSF6XiKZIY7vF3BRJrEotfk+6NCOKGVchjBbRK/LGcyJkPBcUnoFgbbsI98S5EoOFM74Hh/r0f1r/QtaRYYDAx/v9WAIdSqBlpqgZu9su7t94VbaOy11OPW7rChQlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=u+C/t36R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso96172135e9.0
        for <dmaengine@vger.kernel.org>; Mon, 29 Dec 2025 10:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033628; x=1767638428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MElNA+evLW3q9gh9PLqoqAuYhUoiUgxuy1qDVWGw3Ao=;
        b=u+C/t36RxL2h1deDF2NgdB+V/8PFIJNoVWYqFiBvqPNfeDhDg8nP4BHIkKa+gcW6Kz
         oZyl4BCY1ZY0UlTWbp3WqvUDh1jCR0nluG0nE8iXrs7pjzmjBbQHIbIPL+8dTif2iApy
         49ONVh5e7r1p1beaG0DMCImekdmaXwxCCIx94h6Iy5ESduLUfRYjQji8QXQDkAohfmk4
         FFH7obpel1rzxwvDQjHUy+5M6GtE/DPaAt1uTJE0l+zC7cPSxPsPuUtaftvHqc0L54Uw
         F9IFWNLp3CuSTGSt/Oey3Exa3OKO39cdnJXeJo/5uJiqKIWjp4l6/JJxmT9Pm8bsytkv
         193w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033628; x=1767638428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MElNA+evLW3q9gh9PLqoqAuYhUoiUgxuy1qDVWGw3Ao=;
        b=H6h2wrg0v3J+1/UccFArUKleZjpIiopjOjSmM1RSCunXrsflmVEDAJJuTIL6jZNuvs
         AQjsDnxIj8q6QMFFGVCV7nzBNLnkKS8aotRGklkpCZte0EB6uSEwJt6M7+dqptZKcb27
         J8DpAcOwYZcZoegrdM9XUqyKLnvRp0ou7mnkgyjU3oZGmZgAoisX0zlbkt0HXpewBJNu
         fZN4qgdbR2YTd+n5mniqbKqfm3gBSzDItvoPP9LdmDabJfgQAqvzSC3B/Q9Ftx/eFicD
         doHiFOtgzZwemRSd1r6ax9zQD8nId57HBv7M9AmayS04im/NU7Z+4Z0anEm+YILwiiYl
         Z3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUAy0AAmLeRoe83a77fR7gHizYMizKJViWc8P5ZuYaduV3BUCAlnhJi/h5VibUjwfHmZf6y5Iv9lpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaY3Od99mESVVuXDj5zzp9Z/XnfafvtlZcO+CjvX8ehEOIH86R
	yWG1sVOJKKGUCJeeKS4sR2xb2dvFExxObM2SWBFiub463lSnrgqIFJDiGsRzMMp0wC0=
X-Gm-Gg: AY/fxX5pEPV5fs28cFizJyEwfJPezdsv6g2JK8PqUfZEjt17PlggGP1tY7KBskNWIxx
	gOTIraGg61kYAh36/ea4epu5MqHDVi17J8gjLm6/V/QTqK0ayDrMHr1nMtawmzQUrtfAQfYSq3t
	CUQIPgGAgbE/b3T7VEXIbMV/T6Baa1rCodvnsFoyyy2EHNTCjdmvTAZAZv/0ewkVJf6xBLRXXZD
	lKkLv1DiPyk2U6J5i4kx1VjlkKxHxJ6l71KRk/GIACARa7wbuOTfvaXEhsYVVPHSrHSqTfjvc+u
	s6X/sM9fqY+QL1voM6/47S7JzSw5IufLrgnP6n2jHmSMc3zOVKdKisg/FlNmF36hAG8y7vVJMQx
	fC/esUVLwUjs4jkMEzJiKv1JS5LApMJofCnu0MY92H0mrVSY6LU9smq1xTQOJx/8TCLFJ4iQyaK
	a6u4DW1DtZqWtLBxv0n20HxfrAMeKsO8XbFBWwwU+j6IfEEWqPJsjtCXDFlz+jXk4RBoVZCDdWD
	OryBlbk04fvG7gjx4QQzcKkxz/4
X-Google-Smtp-Source: AGHT+IFilbmrX7qgCmCad3pYK4YkE2820iFvJcnWl298VhAC/QPnRoMoqJ3XAnKO9WPGPH+NwyaEYQ==
X-Received: by 2002:a05:600c:468b:b0:477:b734:8c52 with SMTP id 5b1f17b1804b1-47d195670b9mr338260535e9.14.1767033628587;
        Mon, 29 Dec 2025 10:40:28 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:28 -0800 (PST)
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
Subject: [PATCH v4 08/15] dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
Date: Mon, 29 Dec 2025 19:37:49 +0100
Message-ID: <20251229184004.571837-9-robert.marko@sartura.hr>
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

Document Microchip LAN969x SHA compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 .../devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
index 39e076b275b3..16704ff0dd7f 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
@@ -16,6 +16,7 @@ properties:
       - const: atmel,at91sam9g46-sha
       - items:
           - enum:
+              - microchip,lan9691-sha
               - microchip,sam9x7-sha
               - microchip,sama7d65-sha
           - const: atmel,at91sam9g46-sha
-- 
2.52.0


