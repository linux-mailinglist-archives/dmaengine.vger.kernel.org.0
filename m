Return-Path: <dmaengine+bounces-5721-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DE2AF619D
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 20:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D431C27898
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 18:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849712F6F8B;
	Wed,  2 Jul 2025 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="WgWn0EPl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659AF31551D
	for <dmaengine@vger.kernel.org>; Wed,  2 Jul 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481602; cv=none; b=mV1bvh8qqSuDO8s44jVvv2Fs1JipVg3C7buK3ebgqLKrendU5hBb16W8DB6X8DKzodDnsucNLKKZhW7VedYVQgLfMJMizo5h+Uft41ZOlZ1k+AAiWiij7/tSZqQc01rPVRSRGGjl5FE6eekv2qnq78Iq44eUGPF6Wexsu3GPjrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481602; c=relaxed/simple;
	bh=ufOVlqAt3uI1zr6bmRH+USzQKY4G3SQiQndGTVQ2HBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmHOnLCsALy8tPpN/9/JOh0rzEEpQc2DyWkE5AS4ZimpTH+zbjB/3qF2otFdIfnZPEUzg6VYMznquWQa/BvHz+28nM09+gl5k6D5uIIL1jsbnB27QKWiZdnEvi8mCcVVJGUWrY3wEdSV0NPcVse34iYjtqMZm87ItBW6+BbZby8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=WgWn0EPl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23636167b30so45081505ad.1
        for <dmaengine@vger.kernel.org>; Wed, 02 Jul 2025 11:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481600; x=1752086400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JBF3cwldevDNRr7SqXWBuHyX5mq5fUVy8++B9pNBuc=;
        b=WgWn0EPl4z9gSviEI9KEWNs4eztRqIE0YqYE8ajxkBtXvP3Wf0dGq6hnqL2G95//LY
         cpis32hI+BvVHFzMxWYvFqxhCvm90IA8ceAUBEEStj8fr0Qhoh5E2owuvpCeulrgCmAS
         zwsRsqtxi2kOVnTXmZgN53Tvei9GjOh6QYSOTjOK5pUOYU2jLGZujsXZBio26anN4Bhr
         1GwyzQwQ0vymmFyzaOD6AFnYJjpPd5iTduf6u68XBY8J1c8HJM55khjJ1ysW+AgV6bCk
         Jq9QFyMIeyC8mDdL2TgAzuq7Jb948wUtdxvyxN838xnWYYVx82Ru1LT4jHiJsYd1q0AZ
         zAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481600; x=1752086400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JBF3cwldevDNRr7SqXWBuHyX5mq5fUVy8++B9pNBuc=;
        b=trfBNgbB+kSM89K6ORHKgINJ0sm3JVPkmv46OQVD3mv3hBsuYyu8aAYwLoIHZICOfc
         1D8Rr4lvkDQnEOJwIHnJsAAftEPJoGMp6P6faJxK/bIF/tvsdba+wcCtCp3Nt0tgo4KT
         es/N1uKib02ggSqxmZ/sSIiD9mWjATtx9cjsgyJzQ+e2cxol7fduzJ/4BJa6UzMQ7/t7
         tZchZfXzT45go8RjtH7vYbGysrBBN5ZrDvq5+yw46Ozg7FPG9JWesvHTN2KEGkJwIoA8
         il+ayqD4VamnF0RHVMs7BmCgUchM21WIq+3B4vfUVSO6Shw2T+SyJczBg0uZJiFtJL8W
         udsg==
X-Forwarded-Encrypted: i=1; AJvYcCVx7EIGIUmcTEDCPIbCPhYyZ95sjuw/xFvU0gSsPlR+uVGp5F0LTPWnG/4XqEC+Om8by7O1qUZT04Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC67O50YyJG9OkLbBCHmD1qYV/sycUtrH63gMXdgJeY6iLpv18
	qelvEPXpMJeVh8EuUzbia6inu/8VnsiAeVnT1YK/jjcMh3YPtt14Iba/6ElhdXzj+DE=
X-Gm-Gg: ASbGncsmJ4rcYrdJxkLw5cmatUhyuqMfuBYjlbOzNq1J7miOg2EQHudXBIWf0/3mRB/
	aFNNe3syvS13G2Oy2FtOc/oClobLUOzvPFF2gUupur31fbGXhmN8Fq0277/DGUDFLET/JuVMvF3
	jc6MLoQxbPGz4rMBIl+tng6i6O9WAJnIJMwFSNeomB0h4e0osego0YEfPKSXanfhWV7y2m/pyOq
	FGxN3+AMTKL0b6kN/6CoZbZ/C0FTIgnE3lN2tQIOBZXUvHEK/Ud/8UMk4MAOO8fp3ZayzJ4agj0
	LEC/THP2rtdhOTUT4KcfKz93Jz2IBK7Vw+Mx8e7UkpPq+gB1LReacPX2y6Ng3agKP1Do2MzYhWa
	ZsTkVQJqBzmz406cx/FDEuXK5uQ5BjUTx8g==
X-Google-Smtp-Source: AGHT+IHb5I71nz8YJIIhY789TZ8DXVSueuTS+Cp9Lta7fg4qamQr3ZvWLBc2y6VdIoWci5wbIzzqcQ==
X-Received: by 2002:a17:903:3204:b0:235:c9a7:d5fb with SMTP id d9443c01a7336-23c7965da40mr5474425ad.16.1751481599876;
        Wed, 02 Jul 2025 11:39:59 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:59 -0700 (PDT)
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
Subject: [PATCH v8 07/10] i2c: at91: make it selectable for ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:05 +0200
Message-ID: <20250702183856.1727275-8-robert.marko@sartura.hr>
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

LAN969x uses the Atmel TWI I2C, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 0a4ecccd1851..0101529c80a9 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -414,7 +414,7 @@ config I2C_ASPEED
 
 config I2C_AT91
 	tristate "Atmel AT91 I2C Two-Wire interface (TWI)"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	help
 	  This supports the use of the I2C interface on Atmel AT91
 	  processors.
-- 
2.50.0


