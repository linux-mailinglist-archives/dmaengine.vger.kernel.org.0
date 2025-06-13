Return-Path: <dmaengine+bounces-5436-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C127EAD8AE0
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 13:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0151F189F829
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 11:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16822D8784;
	Fri, 13 Jun 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="rS089sCC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A592E1747
	for <dmaengine@vger.kernel.org>; Fri, 13 Jun 2025 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814934; cv=none; b=QEKjkp6sbdKGUC7e5KEjE7erdU7tzd4n3XEoo0uqH4UuQY5Exq2BR3snH2APBHEGrkMsCp3h6N50BRlXoG07Zj7alhdmIAFUz8W4x7XOjnpquQSwuy+p/TsZN0+ZeyamtdTQ3oMe5sCneYM1HdTTdZYgalkIkm5sMPymMBXEDTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814934; c=relaxed/simple;
	bh=NeAtc85pNHGt2Bai6eksDz8QG2jTguYaO2Sb/fwRluw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ytue+XD4pU3Zp00435y53Mj4uRY/E8T+V7zsG4dgzvqjVH5MHQycQC6gXSj2iBOTnTkDTh0ewiXbjty16CQ4ZdAduCsBlf4y8jQEDMB1rI7BkMHcSQWl5AKO1zgkrg7VEzXqX4XmGR0Kb6QzrEwfogPJGHl5vYnFtHNWxj36208=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=rS089sCC; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a58ba6c945so38482261cf.2
        for <dmaengine@vger.kernel.org>; Fri, 13 Jun 2025 04:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1749814932; x=1750419732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP34e2q5Xb/n9epu9K3/GerhfTkPidCRzY+znM8yDWs=;
        b=rS089sCCi7q9xklN7ra53x1njs+9nCw8pf1r+Zu0GXeLIgkFtWC3a32IswDYXj7DAT
         bjiBjlsBhREhb/0VbNe6x+uC0vDQn+5bd/Wyc9f0THQTkUm2Y+ZmhfOGrWdqsuOiQKph
         cH22pL4cCUVl/90jYWSp+rrtB+QdqE3BzvXPIVs7c8xIWKygA63uV99M9CE1xntGRMOG
         9daASeLc4cH4AyAUofnGXi2EQRObXsITNqeK+gDSsYCpFLJcHzZ5wR0ET3fPqZ7EjaA3
         HFwkL/N39MH45MD8+KUoCQ1YgAi+tMjdrv+hhVBJsOV0GZElAyOp0Q0GGfcmvVebm3vG
         JojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814932; x=1750419732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hP34e2q5Xb/n9epu9K3/GerhfTkPidCRzY+znM8yDWs=;
        b=OhxLu3C5wLVPGJ8Te//qvKNhcYOmhhHO9t61qwwQt2EI7t8b5QAdXhrkhuL/430Nrr
         AdsbZs9Oj9WUJwVK9jtadEpjDIDdjkydOkrWjDOz7Iu51FhFqpvQ7db4RqBFUpq5TgEJ
         mhTwEXGiGpnNmmsgCbmZgVnIsi7z8bI7F14IgYQxGz34e+n3dHHcZX0wrgODCDbLOFfu
         VPFQmjC2vPj48ZBQXfF98k0AyaHX0nqUvqd9oKuUw2YCUAL+494RghMqdx4BVcUudHeA
         UegugQVfSnJrltxP9JsJdMkzKv3Lfv1MUIFIfEDvGg8F5013QL0osXkN6MY0VaAHd3US
         8Wlg==
X-Forwarded-Encrypted: i=1; AJvYcCVFsxE1KJh8T1/+d6O7gJqfz2rdsZGw9UrHwaFKxcu2lueN3zw7akRCDcNMfrkvFxYfDLEycnW/89Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLgbl/YqWsro8w56kH6b82DRNPpav4Raoj3kscr1PL2UnDRRjY
	TolZ5kRgAUcLA2ZBx/zPnmPatbpVM3dnPy4efmCOCHOjygw0qoOQ+V/vNtNmqr8k+QQ=
X-Gm-Gg: ASbGncswJcnevt+phG3hWukTeCKUHnezfS81vlsF5vbQZhrA4If3yfGh0edXtKBTQSi
	xhKkFzjpWvgNjKyHXXXDIsA6S6WpokbqlOLIx+a4K5gH2+5pa2anbdgbOaJegBTaAzYCPMUehdd
	4x0pzTWjk0FL6XjSMQPMdsLFzXnb+9TOpU4l9fJKUG6xDcFaA2rnfPcUBhAQFoVGaBxAiqy/+pL
	9zZ6LvPzJFaRWQDntZPKxgEVLYqNf/W4YiycTzOCx0y6PwbO9FAGTDiJZN/UUvceThyuV9cRGLI
	MXMwhGrpOz53aGiblEDMJKP9AkjlexPHn5BPtw02UJIgrhzpOs75R/k7KvkFzyPxexZmShrOm64
	JB36TSFNda8ALUEDI717cOA==
X-Google-Smtp-Source: AGHT+IEvwSeOVrcJVMZPPA8Mgajhh3j4DaXHPn6mHw+5/rNyArLRJaLGgxD9f3JE53WDOm92ws1YcA==
X-Received: by 2002:a05:622a:4807:b0:494:a447:5bbb with SMTP id d75a77b69052e-4a72fec2119mr49140131cf.16.1749814931845;
        Fri, 13 Jun 2025 04:42:11 -0700 (PDT)
Received: from fedora.. (cpe-109-60-82-18.zg3.cable.xnet.hr. [109.60.82.18])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6fb35b3058fsm20558206d6.37.2025.06.13.04.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:42:11 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	ore@pengutronix.de,
	luka.perkov@sartura.hr,
	arnd@arndb.de,
	daniel.machon@microchip.com
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v7 5/6] char: hw_random: atmel: make it selectable for ARCH_LAN969X
Date: Fri, 13 Jun 2025 13:39:40 +0200
Message-ID: <20250613114148.1943267-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613114148.1943267-1-robert.marko@sartura.hr>
References: <20250613114148.1943267-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses Atmel HWRNG driver, so make it selectable for ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/char/hw_random/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index c85827843447..8e1b4c515956 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -77,7 +77,7 @@ config HW_RANDOM_AIROHA
 
 config HW_RANDOM_ATMEL
 	tristate "Atmel Random Number Generator support"
-	depends on (ARCH_AT91 || COMPILE_TEST)
+	depends on (ARCH_AT91 || ARCH_LAN969X ||COMPILE_TEST)
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
-- 
2.49.0


