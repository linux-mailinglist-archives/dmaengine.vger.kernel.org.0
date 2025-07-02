Return-Path: <dmaengine+bounces-5719-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1176AF6191
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 20:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7941C28188
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 18:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA693196D7;
	Wed,  2 Jul 2025 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="g0arqI0K"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3962E7BA9
	for <dmaengine@vger.kernel.org>; Wed,  2 Jul 2025 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481588; cv=none; b=f3OqXvqNXidffXCsOAJpg3KDhUBESEfJFL7RPOvpZKuiexOo6FnT5C+Kc6Cg1s97D702NFaIEkNMRUlzhUmW2WlgxYFVSrrATl1B9BepPTmjBCeDaQ+WEdG+Hs6v8Siz3OTVYzRgDTXb5cexNLQ5u6yCO4sG9PgHnGsgeGYBIA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481588; c=relaxed/simple;
	bh=fqtQu82ipUIUs/6YYFaGB1bjUo7+49dZ1md5F4GSAkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZoPYPrLYnyjHe2lKNno5fs2MQ6baAEO3Fm2RlFaWPYMtv7I+xZGAg8i3LZyDT9YmnItKs5JaDnq15GUr7eg8y2yv1HtfszfrDAEtwCZ8yXh3tt8aF04tUeQbafk6O5e4mvdX7G5MCLLbucpVN7O+nPWJGHCJG6VIpi+cojnN4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=g0arqI0K; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2352400344aso68513505ad.2
        for <dmaengine@vger.kernel.org>; Wed, 02 Jul 2025 11:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481586; x=1752086386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuxtJxy63LOFr6I+EVcVxkshFZijc4sL8n+d8Zo9F1M=;
        b=g0arqI0K1V691fmhoa1EpltuXizcKRN1OyRP/KBM9ZRaX3YOBMI2zKAXJBhzFCzFhr
         WO5N0jssLXPmXbMOTIqqSK4UR86LOs9Lvpwr0TI7NuUmc0mOBXauNhtpN2ETK4CD1lu6
         vHCCYjQEx9t+yzl5HHHPaCw/mMOXwWTWyhZI27LmKtZbH+sB0EVm4ADZgkZAvowb6C7W
         heZ20gkCblgO9MVTm2qDDlEhTr5CrEjSfKv/2gM+HkDqKN6jGGtcJTU67nkCErRdbPtm
         BlJg7ocObuis82DQPPPxJPXOZRdhlMIQ1KHKE7UM983B+sJRelc9NPnF3/13ajETdV7n
         e+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481586; x=1752086386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TuxtJxy63LOFr6I+EVcVxkshFZijc4sL8n+d8Zo9F1M=;
        b=Mq/OMhF4QnYZY4JjUC7zwiGd95JmrQmtk1nqeU5a7GljXZ8xxorqgT8VNcpX4wrJtm
         7bq1PRFBlj4cPgKYhJ6oRhFyE5GPeKLupEmgZo2TofuiexsVU/Fd803HfNgWWY5bz3o6
         DQwBfzY+42w92XpCZwCKdKd9pSOwSIsVjNodNXQkbMLoJGpdjpikTy0j6fDMY5DS+Btt
         ToIfiJGCuW6VEPCJSgl/xYm0jNG51USNhPnnKZmsseayvQ2PE243cSCwv9Wb5je+YDo+
         gfjhHlBZLa7+3iP923nvjLUvMmolpT6bDTzuCkq+Nm4KSbExQMjzVYrPIXlMsoMUjNKN
         NEUw==
X-Forwarded-Encrypted: i=1; AJvYcCVxvztgWxyX0OVPC8Hjl8AmhU6r/Sh9UEP4PXxwvxIrnws2HNh7poDKlcHfsg/QRuFZA2fokTZ91uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sGIZMb/7EOrLWxtl+tL9FLhfm6wqJWmkorBcwCDZCuvyRQL9
	StVGOBeSAM7sswLtBm0RGCUbB5/uVkP0da5vmbAtF569qKkdNE0UOGnHzjPGH4DojhQ=
X-Gm-Gg: ASbGncv7k7tXMHBrrE2UKnYG+qML2uE9UPHXz/S6CrkFZe9d7kQsSmGCrx4Ag5JYB5+
	AZyQqh5Z/ya9KNfA2tnzFK6rbKXzQ5Ut5bc8t8ytDTqMJzOYWJNt0i+V9Ndv1H0avE7JREYw0SJ
	CA9pMBuMK5DSbvZUjFSEP9sidV5KhEiw3PO8cNcqwf2mUOBjSIl7E0m5C6In6vVXlKQbQposDaz
	I0uxsbdcAggUeMZdqbET5NPUbX9bUxGBU8odmtMLJWIdf6fI6C5FeANsDRIbl3kzftiojiTlLJf
	GlOkh0EHPXntUlw+NwMWCJxPQOQFy54v3WBK6QYMaHklVpzQS9MMKK7SxocFpppptIBnMMMfRSG
	5gLC0YoVAm1Xr2ZklsVmx/D0=
X-Google-Smtp-Source: AGHT+IFtjc9wQbx0mnTEIHCa/COpi03QJubyVPHdKqzZsjHI9di0hrmvji1zsNLaFfpKOtfqcICExA==
X-Received: by 2002:a17:903:40d1:b0:234:9375:e07c with SMTP id d9443c01a7336-23c6e558b2fmr47599345ad.46.1751481586359;
        Wed, 02 Jul 2025 11:39:46 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:45 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: linux@armlinux.org.uk,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v8 05/10] tty: serial: atmel: make it selectable for ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:03 +0200
Message-ID: <20250702183856.1727275-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702183856.1727275-1-robert.marko@sartura.hr>
References: <20250702183856.1727275-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the Atmel USART serial, so make it selectable for
ARCH_MICROCHIP to avoid needing to update depends in future if other
Microchip SoC-s use it as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 79a8186d3361..c33fc6f16d31 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -128,7 +128,7 @@ config SERIAL_SB1250_DUART_CONSOLE
 config SERIAL_ATMEL
 	bool "AT91 on-chip serial port support"
 	depends on COMMON_CLK
-	depends on ARCH_AT91 || ARCH_LAN969X || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 	select MFD_AT91_USART
-- 
2.50.0


