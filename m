Return-Path: <dmaengine+bounces-5718-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C858BAF618B
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 20:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE37F4E232D
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 18:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA982BE654;
	Wed,  2 Jul 2025 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="lNxRuD3y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530002BE645
	for <dmaengine@vger.kernel.org>; Wed,  2 Jul 2025 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481582; cv=none; b=X39AmatHnI68ShTTTFdhNSpWRDRCoNG6F7hVaHW9nVA/Em86DkzmPW1F4eWXzRe1R7zxNliBYce0+p1QGl/3LCnsbS9qc5hRB7tFp8zjWWXe5HuzZLcxm81dP4vtTfOMptYh4ZXJdAQgPxWxh2zusqjrBcJDGnFT5Ws2K7ogpQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481582; c=relaxed/simple;
	bh=oaGmzUZUXJWd6raW4UkBJCtJB/M94OwXRkxkbmWDquM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILuqYyUNwr1iuqFMV/Ge9+fzn5myHFwihDG5b0P7Y2G8a6+IS2JF2mOB6QYpfkebTeCwmZ9RBijXBt628Tk8RL7uC6uNj9CrqB0yebvZ8DsDlTK0NjzQVtirRMMBH1VKfe4d4Ir7/LRS0D2R5BXecrmVBZsFnlP9ST47bmf1UUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=lNxRuD3y; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234f17910d8so70718645ad.3
        for <dmaengine@vger.kernel.org>; Wed, 02 Jul 2025 11:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481579; x=1752086379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKtbK/2WRQ+wXXbB4rZi2px+YsVtXfxGP3mE8Odmzx4=;
        b=lNxRuD3yBHUYnLAht+u0unHI3QeT9wuRbR6j22Z8+QsYiDExKq3z+lSq5Sacv9xjj0
         M5G46it8COb7NHT+BFekYkiDIHKl8tcROIpLQsM94Mxn8fQw/TLrBAq+Bk3oISHBke/r
         Yjmm0pbmdND0bIZietxF7HbBc/JxpuaUQRQhGE17lnhXMpnVTtXt6dl7w8QZoXjE0Dnu
         FmAOGCGf7A8nGM7qP1G0NU6d7Fimf8yF+7cGj8WML10aVvtWsjvzAAFkvl1DQnLClmkP
         ApL/n7WMvqOuRgBCTaAQmpYUgHGfGRBf6lAszdtVSK5X7x3OZUdRCiGXvg6gwkQefyoT
         x3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481579; x=1752086379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKtbK/2WRQ+wXXbB4rZi2px+YsVtXfxGP3mE8Odmzx4=;
        b=Y7Mdh7wsLsdmBVJzomoVMuHxifK65G7g+aN47ibvR3wieo0QGbAK9QljZbutBJFVP0
         1u1h7UxaZAZCjW2jj02xUDewMtpsOowzjan9N7LUKZxZMDkmyDR3KFz+stO8mOC+AYdt
         YNAqLRq3ZUKtcfINxQbtNQ4YSPaSLJQcETP1rd3KAzwzagbCaKGvokyRmGXxWM3rIOYn
         1JUOk3qnfXnl9e5LH5zq9YczqqjB4VFBKqc+IWP78N0hUi4XQwQtiw78YqkZW6yrRhCJ
         Ug4lOw1jVPpeQxzTFUpeS0b0MyQmsBb20cCpg76Xg8Hxs7BiY1SDXuczxHDAsGBnjp1E
         gJJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGjx4b2uE9NmYFqWmZwzvwoez4YpuvG1yfPXE2NLi/pJtxeEQVafZRMk9nNT3Gf77G+Fm/7DmyEPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsPSwtmYcFkv6RKoro+FonJlRE8YygrnmbSzBVK2ogtntG90Vk
	8WP6fXyBs5q1osw1cKpqTVwCGmJIe2NIwfqU6MIB6XendgI6kb1dXB6t9KIrb/AbmrI=
X-Gm-Gg: ASbGncuUNtnI8NQimLoNRXpxOfnGcQX9kGRtj88o8UMw3DAGNY+Q9tsL7zwrTcd9/T6
	5EcjViVHqZxtwzFcdwls+T7DY6czAjnzv5r1iJ/ZMmb8U/eBOwEETr5aW3xsbmZ+hWT5YMzVzMY
	/tQvUxgLZqPTsxjcngdxlSOLBfnGHyBflnIcXxEq7adCXYn0NIVOOhBZjSYRkEZMASJDak8ORq6
	C57Rm4vis6HBYztr7F59Gk3AgAY7AxyYNAJVu58MKk1THk9Bz6KXFCrh4dEG0eTELcXqKVAPdPC
	CmcMhwQVfE2V94aUfH4/HjkZ3GIqzoZOLvW4+gqpNpytnIj2D6FdiN7EpHVr4plpop7u2VO+eVw
	WH11heOCbu+2Y3TBWP+9NEJA1yNPwXmP3Lw==
X-Google-Smtp-Source: AGHT+IFMiw5zVlKSlo142PqqKAhtgqF1TVkOxw4N8sD11BQn40MJ5BTx7e9G7Jb+TWyMfU9vkgJvWA==
X-Received: by 2002:a17:902:e5c1:b0:235:91a:31 with SMTP id d9443c01a7336-23c796a1c47mr5430865ad.8.1751481579607;
        Wed, 02 Jul 2025 11:39:39 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:39 -0700 (PDT)
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
Subject: [PATCH v8 04/10] mfd: at91-usart: Make it selectable for ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:02 +0200
Message-ID: <20250702183856.1727275-5-robert.marko@sartura.hr>
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

LAN969x uses the Atmel USART, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6fb3768e3d71..0ea3a97bb93d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -138,7 +138,7 @@ config MFD_AAT2870_CORE
 config MFD_AT91_USART
 	tristate "AT91 USART Driver"
 	select MFD_CORE
-	depends on ARCH_AT91 || ARCH_LAN969X || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	help
 	  Select this to get support for AT91 USART IP. This is a wrapper
 	  over at91-usart-serial driver and usart-spi-driver. Only one function
-- 
2.50.0


