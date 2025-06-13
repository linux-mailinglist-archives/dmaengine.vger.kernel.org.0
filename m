Return-Path: <dmaengine+bounces-5435-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 019A0AD8AEB
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 13:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B5A3BC9CA
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 11:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1552E62B5;
	Fri, 13 Jun 2025 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="plC9ULUn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E55B2E62A1
	for <dmaengine@vger.kernel.org>; Fri, 13 Jun 2025 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814932; cv=none; b=mOylx3t/VJX9XnXWxrEVz4GcmJqaB6W+Py6nKrYuU57mjqujimCyh54ooeMCkFqep+SzZXu+lt/uNZTZCQm13NxNnlWLTtYAItRyTBJTylaA8ILRlvR5ylSq0xhg+sTxGy2a9FhxU65ilSRC+LBjhRfBUicwy7lXNfow1Ury4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814932; c=relaxed/simple;
	bh=UjOVwgtEo33Ysf1DyH6d5ldmTFzYDqKUhAyLQVB9wK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bm48G+EjvZ84ZVVcLFWBeuQhofjM3dAnM6mbaHrowjcJO/x1V+IiSHJZKhZewfzOrmh2Bco7l0LXFI461WSmQL5wb+W64qKZHclV87s7MVOleV7nrMbskSczkGgyWl7QoFelIKanu3YdmA2QcelhExRBJhM7/UNaNtYHQSRyN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=plC9ULUn; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4772f48f516so32593331cf.1
        for <dmaengine@vger.kernel.org>; Fri, 13 Jun 2025 04:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1749814928; x=1750419728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WlKCQdBK9LWxBVakFnX+t2/73xtUBtXu9i2PrxiazI=;
        b=plC9ULUnylGNLltJ/YPUOz5o61tneqDQCbYUViWc8yRcJPbUutA6Wh91Nks0pGLaRf
         U4qg6GhJ7CdVGxJ61wwfrMgPl+Uim6usuvApWZXRXE7eIDHJfsnoRUIStFDxnv3bLLyH
         XE8XCoNTQ8G3ivf1V+3FwUh0Ru9V4giBSI2c/69kHiqgVwM2hNzL+8lEkRWWVEmZYKHr
         BuJDBHycreZiGgXiTAQMuO9ZOAWIofniBOkiLCZPn6c0C8USAc75ectbFb0iyNEREENB
         IZVZxKnNkiYbvyxMRcBnD0Igmgmkr4mjbCZia+NHjd381jTdr8OgVywYSAEvF7iD5hGD
         MZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814928; x=1750419728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WlKCQdBK9LWxBVakFnX+t2/73xtUBtXu9i2PrxiazI=;
        b=AxPdGTtwi8x5TvkRcRQCk1YgYguMm9JIau5b1N5GndJtPKDxK89PUnvYun3781TJiS
         AlB9IGOkWum/X7LRbo0eiDWW8hO4VXuOmnd7hZI9MAGKPQ9UHXi0F5LD3XaNYyW4Jlaz
         9Sjq23E1Fbbf38ADhbVVygaxl3PvVmG3JzLyyd/mvREfuzOeAzHZ4YaCPkiYSpow/ym9
         fcouome+uDX/jnA0VG5vYyu0ncplERby2w5XpVr76dH8cr13L/3MOz8PR8Ge6fkh1FQ+
         pjUHNdy7NZLb+G8TlYTF2WX9UQ2Xmy4YB56oO00vK8sqf5XL+cRmc5kLf8hdIXli5zKN
         M2PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrCErwRkIPwbxxshgxqnlW4CrFckyxl76K1s4J+k36u3BvUoHnq/BN06KsI9XCThF/P0Ere23VwxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxtmq5rP9PJgKHrleYT4gvCfauur5mZxmslfHkhWLkP9QzQ7MC
	9FK+G5HyduhxV4dhHL6yxAVsBbFqLlQ5bYnG1gyddTl6p3XK7h1OLRJp2pBBQsGLq9Q=
X-Gm-Gg: ASbGncuV3LlVKEr3NKOVzKmNy09wToZ5StS8aKEmnpTrckpDKflCUUDvwhxZfoLHpWR
	tARjZnzcxLTXWGlezCG47NUO3eqI65AaewQGzd8xNMFd8QBDZK5ogXfobA01LNLvpeowF0eIfpS
	JrwAP0/BR2ATJJdHkAW24YL7P94EYAwGcsYsKk3RPJHpA0NBefPsso+gpDHQiQRyby6sgVFUuLT
	eEBPoBFh90Qs3MnLEABtB3TF7PmUxloCOr+O7IC/Lmx5m+6nEoWH5dHq2py37KHnUo3BMvyQpGk
	Ue8mxm/t76N8pYNeIZcNqF3XXfhrzBIKDrIL974/ol04+nyi4qU+bPG+F9Yglab8oozNxS0lrRv
	9O7qre2cPlTbWxKk98JVvYA==
X-Google-Smtp-Source: AGHT+IGoxDxx9zyPnLwBJu/HgiS6b9JD+b3qfzp8/xdsORghv63P60xiRPkYDDUy+K9jds0kDneIzQ==
X-Received: by 2002:ac8:7dc2:0:b0:4a4:310b:7f0a with SMTP id d75a77b69052e-4a739328f1bmr4762501cf.10.1749814928381;
        Fri, 13 Jun 2025 04:42:08 -0700 (PDT)
Received: from fedora.. (cpe-109-60-82-18.zg3.cable.xnet.hr. [109.60.82.18])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6fb35b3058fsm20558206d6.37.2025.06.13.04.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:42:08 -0700 (PDT)
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
Subject: [PATCH v7 4/6] dma: xdmac: make it selectable for ARCH_LAN969X
Date: Fri, 13 Jun 2025 13:39:39 +0200
Message-ID: <20250613114148.1943267-5-robert.marko@sartura.hr>
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

LAN969x uses the Atmel XDMAC, so make it selectable for ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index db87dd2a07f7..0c3f14ab569f 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -111,7 +111,7 @@ config AT_HDMAC
 
 config AT_XDMAC
 	tristate "Atmel XDMA support"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || ARCH_LAN969X
 	select DMA_ENGINE
 	help
 	  Support the Atmel XDMA controller.
-- 
2.49.0


