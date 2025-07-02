Return-Path: <dmaengine+bounces-5724-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541D9AF61B1
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 20:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 214607AE1E3
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 18:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C3F2F7CF3;
	Wed,  2 Jul 2025 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="bpKlO2zr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06942F7CE5
	for <dmaengine@vger.kernel.org>; Wed,  2 Jul 2025 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481623; cv=none; b=bYhjwUHf+J0RcTO8GV4badkKjZ/pdNnInP9EwlmLkUg2j63ozqXv0CpQJhGcRsGtlmdDWDfInw4k/DAmu+XJG+EAqw53BsuYzG4rad2JccsXg+i+xqu0abXtABfXqpyi2Hr2hhYnREQI/KUaZMQ/60wcWdLWhbPERLSDcHV4aT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481623; c=relaxed/simple;
	bh=uR10k/MNsD2KTqxwxNLmNVi+dmMLfNBNQQvEqJsmDa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZccIBIugJ78L+Eew0XU81GKpj6AMcbFP/YRYeIwsspO/B0BTe/kPUop8VYTv343W6NOLMvmD1uJKtIWlnWhMKKpcQCZys1a65uKFsD3DVYImP9qBfXAgpnOEoSgPMVPWUGuRQld680HQjXznarvfZkKUx4vqoHXrLNsb/yJAFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=bpKlO2zr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74b54cead6cso665779b3a.1
        for <dmaengine@vger.kernel.org>; Wed, 02 Jul 2025 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481620; x=1752086420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbnTNMFdG2kGnp4zBFs5MgPMup5zL0Zfe8VUfuWUBv8=;
        b=bpKlO2zreZ4Dw49+XpbddUTu/s8vYAQrprCuWs4FMzPVmKsaPdOuGCsWR7P1CqUmbg
         aQXF8g30FFZD5HNZyapB4pHSUbOyYpShNABIOSJeF7xGeUWbj4AX/3ZV1HDR54SHW6Rb
         Z3I2jzQ9kzZ7gNPHpWswVYvPn+vp4X6sGWtxGhoDSfhtEvRs+TdGQdFYGEl399uTOuM9
         q4F0gD+M1bd1ywcOJgEP3AkYT573RvKvzsJjjUXed9oHnxqOHG3qpQ6WfelMU9UwhLBc
         5m0gvn/DJ+suKGPTJMvaf7teqS/TEBabuLP2Y/uTeE7cMjkuNPOo6sGA8HYDgDcceTdF
         kQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481620; x=1752086420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbnTNMFdG2kGnp4zBFs5MgPMup5zL0Zfe8VUfuWUBv8=;
        b=AKDW4zinGdZfCHSAwUZGqpMB/3R+7cyBWMTt84O+RnQ611yHrVo+FltUT+y7tfh7oT
         wke/azf9nMDRfC39/geB8fi2uDwHs4vYX46dCVeq6Qx1Q8gvVNOXYGk0NzVdKqrZ1u/p
         yR+ILcHi3NulZiBsECXN+V0aDBkXJwyZzlq/lR1tuSczexOgB3MrD/0HZatdvCcxXz6j
         BpcU8I6bshnTtbFI/ns4hkKd90/iAKYh5TxlvyaZP2iAJsf2mhKJblYR8kj0ewoM94cU
         +Zpng2Rzbp8VPZQ0K/X0J4vamz7JLQrntQqmoo33GpLYRRtF7vCEqu5g/iSpgCMQp6JI
         +E3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU92g6Vjv1sp8W85FXRGlTLICSTGkwTQWz7ioeJ8eojCOa1vEgdAyvGihvpV9mbNGNePrYIohD1uUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYQAmGbk5wl08kB1I7zEm0qmoyIbdxVbyARa0JDhWb2WLSSf7N
	xMp4FTHf5KhJScC7ENCqx1kqHtLz+yISMqdMATmZFFHF6RfwmiVl2sRRZz51nPGwYB4=
X-Gm-Gg: ASbGncs7dvqfhOH8M8455GgbS0vtoFQ9XfgiDavN0aFZ8rqW4tLybHDpTAlyr89ULT3
	IUYWeZnsrfynaW5UoKPM0S/KuCsEkOH6idv20Qe049Zd20yMOIbi2rS59xiHdlR29ZnhayVsjdr
	KKiupweWiMJidSS7hM25+MlSaZIViNlUCJ1KjCD5K296AnqGLX5Z9yhMMfl/6ujmKhxmwaobsVQ
	5tOTJmXptVTnXv6FRnAvMSYFvL0ogFkbwfJB18Ax9yLxTvSkeM7+lmJ40eJbtIcpH+H7L1iLlfv
	MJ9/Gp5/KZXCMvJgKIZXjISxfU2dnouCWGbkyqBdkgvgcnYtb6ewRWD3eS1OdEW3bYASxWiMumw
	65QiIbKC2P/5eag/JM9GwA0w=
X-Google-Smtp-Source: AGHT+IG4Ha6X6nXWuDRiiAtD/IybzMavhr6X2melJ3MACMJlG77wfbwOcD6VvpmvkGPoSxTpUxzwhg==
X-Received: by 2002:a17:902:e751:b0:235:2403:77c7 with SMTP id d9443c01a7336-23c797b92e4mr4443315ad.37.1751481620268;
        Wed, 02 Jul 2025 11:40:20 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:40:19 -0700 (PDT)
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
Subject: [PATCH v8 10/10] crypto: atmel-aes: make it selectable for ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:08 +0200
Message-ID: <20250702183856.1727275-11-robert.marko@sartura.hr>
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

LAN969x uses the Atmel crypto, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 04b4c43b6bae..7c1717c35b76 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -439,7 +439,7 @@ config CRYPTO_DEV_ATMEL_AUTHENC
 
 config CRYPTO_DEV_ATMEL_AES
 	tristate "Support for Atmel AES hw accelerator"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	select CRYPTO_AES
 	select CRYPTO_AEAD
 	select CRYPTO_SKCIPHER
-- 
2.50.0


