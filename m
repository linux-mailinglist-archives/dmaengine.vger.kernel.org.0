Return-Path: <dmaengine+bounces-5723-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EB6AF61AA
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 20:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C9F1C2821C
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 18:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD0E31552D;
	Wed,  2 Jul 2025 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Va0YdXqd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A38A315513
	for <dmaengine@vger.kernel.org>; Wed,  2 Jul 2025 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481616; cv=none; b=XKeKXHvvrejBonOYQAafi6css9VeoCMnxpAXcGshJvICwVfJVeRnoytuP5mtVwgEV3C1hit7d2l/FSxsqvh+4MRtfudMfJps2ziRMFNhSJpEIwH8HUW0Pl7YK699OGu9wV3uXBlyhH4Ub2SarFqI7n4Sd4gEy3cLtZEMo/sX6UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481616; c=relaxed/simple;
	bh=Cz63RwNeleL0UIjH6azz0oQ3j2RQxKtigND+2Rg8ZE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q094ZxduOmv3I19mHXhWJ0zfWp23VsmuE9GODZQ/Ezj+oAgioacp3Z/kuCTRBiCTO+rGDF4JBqYW9Nd+Ltre6jb75B2JcV/Zrt4hDt5HJ/wsZOzac0PUHvlyq1vZF1NugXd+G7lQOE+vUMfCn9TNRLUj/G8I1/de4Pwy70HK3dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Va0YdXqd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2363616a1a6so43396675ad.3
        for <dmaengine@vger.kernel.org>; Wed, 02 Jul 2025 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481613; x=1752086413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLgkgM2dsMzuH/fyTk3FJbcZgyqMvTqyvvSzdaeBl9c=;
        b=Va0YdXqd7Ix0e8Et2+b4uQKK8bYPewjZFS9B4xkIe/yC8TrKnqu64lE9zRKXq5IS+j
         MJC9Kre+ADc/I1UNLxUxqIwZMYx3ky0BYiQLgzPLxUrxyA1CbSmU0yEgNbjdv8HEYKiA
         UbxcgRny46t1PVx3PhdNzHQOqgLrJLdopipxzgEIadB/AjlHEa1WnOB+JUVLqldlnBnv
         b+eipirIyAbEFfkLAW1iBk75Se+7NHLsHcoXNMupYN8qzDyaMcZxuHJyxX38rmt6ozDl
         8qQFlURzt3vua6+NZNRFnI1WSMw4vAHFtVJI2ZPrUbG+v3+tzT43DxO0j8Kojtir5STe
         VtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481613; x=1752086413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLgkgM2dsMzuH/fyTk3FJbcZgyqMvTqyvvSzdaeBl9c=;
        b=b6joT6K9X5zYKzbZ1aqSxcWZr71HXx7gAjVJzP5eorZcVbbj1F5TWHUl3jgrxilb1a
         aF557DSGhGrcLaKTSvdfNAfFhwXZtZmAoBrNzTDzArp+7Sq0YjmxJI9FEO7PcGjuxsTb
         REGzMXGb3DZ0AilV2cRXqAC5gzJ+cKByQL5G2rvtMqqmgcxh1Dn4L4E1t8ANeLT0NA8t
         TGWVVxU2l3xFjQwDR9ZnKCam/AUwpEMacOa9HU/9UCVffdDxwj80/sTHkHkyCTJHHF3k
         zuRxBtI1yhei1IHsygr3C4Lin2+Bu/lWHa9Vi2pgCrEnYRtBzT8xmDvblSxacFSz+3/k
         SmBw==
X-Forwarded-Encrypted: i=1; AJvYcCXrEnWzIRJNBMibX/yFuOyzR2/GE3BjT2hyJPLHcII64eiiIQB9sKcVLkqrvGdmIRZqvVSf0u6dKuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRpU8ahQoHxgqJq/rZsc3uChYahyBlGiD+HtALF+n5soxqxRfw
	Nvo+fBw60F7DjrrDhxBYxifFR7okMQqMSctKalX0vMpnS4bOzBGPsH2T/6k+r7Gd8sk=
X-Gm-Gg: ASbGncu6KS5GrBqaKk3FwSnt4wRfaf0PbMKHJ8oad23misXLdIp0GynB1fHT/3Up03V
	rtKvjb0kAF2KgpULY+dxFfTtrIL/m9NO+AOWlV+9RNd51ETKHiSb9FYlC2FbiJZZxGmkmKUNYBB
	ozxS8v7TD2LTRymOwMZCrK9j1g/ySHxctcq2N/huRxAKT5EJd3pOYcp8O33IRSbdnB/wj1SdVWd
	dOKwFnvk4MXPStZMw5eR8a36q17CJArvHhR1kr8DphnXWZvPwrf/sGW3Qt/rUGOZ6aVTDkad0Ro
	7qvW9CoFRVPSQqxRAIGe+CjksT/umH7lJ0UEAiTzSOEF50owoOo1uRU8hp9pFU6YDwzx1snedRn
	qCbI+1sMvPeJF5GDGxCbbHdM=
X-Google-Smtp-Source: AGHT+IGIKE9F8Co83/dHlUj/BJjldce2wZ+yTKPm0xGwC9EdJvNItuAvUNQ8nezHwuOa2fWnkwRauw==
X-Received: by 2002:a17:902:da88:b0:235:880:cf8a with SMTP id d9443c01a7336-23c6e4ac48emr57113295ad.15.1751481613470;
        Wed, 02 Jul 2025 11:40:13 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:40:12 -0700 (PDT)
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
Subject: [PATCH v8 09/10] char: hw_random: atmel: make it selectable for ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:07 +0200
Message-ID: <20250702183856.1727275-10-robert.marko@sartura.hr>
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

LAN969x uses the Atmel HWRNG, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/char/hw_random/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index c85827843447..e316cbc5baa9 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -77,7 +77,7 @@ config HW_RANDOM_AIROHA
 
 config HW_RANDOM_ATMEL
 	tristate "Atmel Random Number Generator support"
-	depends on (ARCH_AT91 || COMPILE_TEST)
+	depends on (ARCH_MICROCHIP || COMPILE_TEST)
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
-- 
2.50.0


