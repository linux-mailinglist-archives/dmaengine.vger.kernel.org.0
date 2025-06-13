Return-Path: <dmaengine+bounces-5437-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904ACAD8AE4
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 13:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78FC1E2EF5
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579AC2E6D1A;
	Fri, 13 Jun 2025 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="y6ceaVp2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD92E62DD
	for <dmaengine@vger.kernel.org>; Fri, 13 Jun 2025 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814935; cv=none; b=YOT8Ze6+IFHJzYUk2hH4Z1boogKTqUIWFDtSobUu32KXtEx4B5quksuC3w8FKEF3L40NSC+kGNFwdIjhrsf7PtukKh9uk2aseJE7iN1cYB+g09wm0d2w1iZROrVK9vrwMTbChcEzFYWoPGrB5Xh0hDJKeq3qsVyVTeqWBOIZHP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814935; c=relaxed/simple;
	bh=Nl0M0mtMMwH3HQiDa6E6C3fv9pPm34SWpTCcbO9Pcds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3BDeCkWBEziVtHzt1eBIFBu7S9rDyLQqR9Ysnmv4Ho2Y8OSOk4FtwBNJImRNFCDqU+JvthzNuxgcgxzOgn3Ubl5DY1flfWiXQRvslUXVenCRxv+E5vROYvHmSgrmzuYzao2avKkBLm7ycWqk/p0jRRebAIMEBBvEY081ZCX5Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=y6ceaVp2; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-610dfa45fa2so1151363eaf.2
        for <dmaengine@vger.kernel.org>; Fri, 13 Jun 2025 04:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1749814932; x=1750419732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PE5/rsY41g/vAp/0hcg6OhOgOrChXE3RFe9mIYZZ5WM=;
        b=y6ceaVp2CQcBou9Cp4Y5oNH0xtPtDgIeDv9QAP0Sn/WJFUywu4fOWBXjGxAIl2nvcg
         QktQReL8/JROek6VZ1O7cDxCPThbPChtqnvE3xoJ+eF4DM5rI4NYWczLBafDWsl2UVWp
         Ugr/oqG+VpiO6NA4GwSlMBAajYAN5g1O1/vSAGnfCMoBieaCfpCTDhWEBLJU9jsUJVpe
         /xQfBdY3ol5KNbnfB0kgis6qGHrtePEuePTjrVKg9uNXvzQ2aMcRzFaVYYF2fMBuvtyP
         /dZ2TCswCfssYbQ34tClHs4/tRVpE8R+7APjPZu/7RzqX9oAzPPx0my9Q9Unrv+Lp627
         AFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814932; x=1750419732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PE5/rsY41g/vAp/0hcg6OhOgOrChXE3RFe9mIYZZ5WM=;
        b=mbl11YaAVU4V0WIYqUw/WLXS7g8ablqbiA0An6WritALVaOgsnZusX6UuRwHdfZBJJ
         P7BosExSevpztq0tL7ygbaxoxdwV45z9twtbG6WwpZwQSxDk1m5HNzQh4UyxQuw2eAch
         5rl2KdMSqoNNK6yy1Dg8css4Xf1+/Ynk15w82SB9eVzEJvMzFTQ1lPYVyqUvRmsliYfm
         FoAG8NV6jhvdDTNz4fqMr7OzqoN978XHFfhq4IQ9+m5iR396ynEZaHwdDCmF/bnJW6zS
         P1Q/lvT9u2gDodFIMkaDp6AA2ZtLYts23uYc9u/Yn34sSErQgpuN+uUttw7NapaIRZZ/
         401Q==
X-Forwarded-Encrypted: i=1; AJvYcCXE2jFmQWoUyR5l85RA7/gJ0EQU5fCXs5F+vBobas6d75NVKJ763sDRhnSnfgzYj7kAMBFaQbioJ4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz5AETDoD3aB1hp5VlplH1IpgjmwTqLE15ur82QFst9qODP38+
	uzVPyZjxMMzdWRU6R2KuuMUThY7WnCPzWszne4ixadbVcYx3th8UR7uI+upiyuGCiUugPzB6CE8
	Rd3xJ
X-Gm-Gg: ASbGnct2EzjMysKkWMybHo9YUhy+TnUKnzuLwvLgdpGRltzMvIjig6d+mtkkl+b9Hdi
	AUbMVi0YJkZx3AxyySKTz9Pgg7Skq0xJXp9YY69DVxDZivKMnKQrIx1wXma7uHjEPp/NmWXCe+O
	nZHvoYxRAQBhNjqK69GQUHZJMxpi4+GqPGOjKaMGib7+lizypbwPTXmGJ3t0b7MGAkfkL+xdosv
	PxQhDGTueNDWkuYqQvNfrQ1L6MAN9uDZisqVA6qjs55KdbesJyYDaF/ADYmD1cfI+Nlu/ydN7lA
	gbZ/tBwRf7+A8XIsqkVEnv3Pe9XOuKuA+wBMOCN6XYyZ7Mb1ubh1g4wdYzt9U47Po0UC8HIRQ5X
	CDGNXKRD//n+YdSKlC95FdA==
X-Google-Smtp-Source: AGHT+IF3wVYZI/s3wM1PNe5izmwye5C2dxIzh460VAl75DrcM6tXXLw5OFqnGApeHtjQqkaMBAsXNA==
X-Received: by 2002:ad4:5ce1:0:b0:6fa:eaf9:89f1 with SMTP id 6a1803df08f44-6fb3e685f23mr33483696d6.44.1749814921454;
        Fri, 13 Jun 2025 04:42:01 -0700 (PDT)
Received: from fedora.. (cpe-109-60-82-18.zg3.cable.xnet.hr. [109.60.82.18])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6fb35b3058fsm20558206d6.37.2025.06.13.04.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:42:01 -0700 (PDT)
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
Subject: [PATCH v7 2/6] spi: atmel: make it selectable for ARCH_LAN969X
Date: Fri, 13 Jun 2025 13:39:37 +0200
Message-ID: <20250613114148.1943267-3-robert.marko@sartura.hr>
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

LAN969x uses the Atmel SPI, so make it selectable for ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 60eb65c927b1..3b0ee0f6cb6a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -145,7 +145,7 @@ config SPI_ASPEED_SMC
 
 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_AT91 || ARCH_LAN969X || COMPILE_TEST
 	depends on OF
 	help
 	  This selects a driver for the Atmel SPI Controller, present on
-- 
2.49.0


