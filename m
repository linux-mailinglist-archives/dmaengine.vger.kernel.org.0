Return-Path: <dmaengine+bounces-5438-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78356AD8AF5
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 13:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8F13BD4C1
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 11:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8532E762F;
	Fri, 13 Jun 2025 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="YNHl7knK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB852E6D32
	for <dmaengine@vger.kernel.org>; Fri, 13 Jun 2025 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814937; cv=none; b=oLfmmm/wvKO9AI5MteKFfc1gMAMvb50Zhb6NNfVQsTX6IoqK8zbW9TrQyreMMAVrMATkLgu4HsPWoM3Wk4V1xdpRMPtFobZnWtAKw8h4q/zfytq73hnUK7+ljW2OQ8ixJxwd1wF77me7Vczqg8qL8Y3kNT2UulHn/llAuDZKYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814937; c=relaxed/simple;
	bh=9oxZLiMqxg04N22sji4gyuqoa02gKr5691CGYVnCg7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/rMpO0SNDSwMXOVaCcZ3vlV63fmpzBtWDrOJmIGsiV/UIYM3s//nccKzklBfPvDoJglmyDB+sv8an6IowyQjyHI4DAsMdVNPHMZaWa9/b6YG9tAWesXTTSHW0cXoOyPUQJG6AZKGXROvV9NiREi3ka6MI+7mlEhTjfVh36l2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=YNHl7knK; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6facf4d8ea8so21960396d6.0
        for <dmaengine@vger.kernel.org>; Fri, 13 Jun 2025 04:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1749814935; x=1750419735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FOxOys3zo2Dw07T/mQvOuXgGCEKYh0s2Uiw4mKVmQs=;
        b=YNHl7knKNDVKvypJcJhcGlGu8DrU5PyO+LN2J08UyFVzU+7XAZzimNTzhNeyR93302
         XJ2LMdkOO9R9gmdzW4xyjI6FTXvDlg8705pU5im7roRIDXChZYjgtdxTkBuIUAGCYyHF
         ZbIdAVJvz9EM2HpsG6FFia8QAVyoGD2TVmrlHDAjvnyST/jNSkF5eNqv8V491uqwnZyo
         Y0TN4hgljgTL6kYYObEddKdoAV8ixSTl1imVfV3yCIhUrsVizO3P0xsW5HEwWlWJh2GF
         o7ohjQ470K0gVZ/EUPROnnF9f9fdL+9J34FgR6gZ43GJt2vvpweBo1JzK0ocdiitTB06
         sNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814935; x=1750419735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FOxOys3zo2Dw07T/mQvOuXgGCEKYh0s2Uiw4mKVmQs=;
        b=ei/1oWPZcF+sWQeGBAJPMfczzIRq/UqTiMS5sRo2A1wWNKySR6ayvLVi8PPP50aeZy
         ofYBWoNeCpJ6ksABuSLOEqvHixPdiJrlhb/q7h3VV/Jo0bw3e+rPH2Mejjv0idPfekcO
         OaRubnkaA5DlYzCUrtvySgIVsqu2ReFPfqS6krEC+/lSOx1Zz+6tJ5vs6cTYjSXzWDwe
         zZK/7h+0Y2cUMO3HjwncNmBC5AodbG6ci+IthcDZ95fEXVs6Ku/UwRZ8YI9GXaOAnHbV
         zLCzVe0cEmSX71H+A09LKRcKQ9NVWNatIpXUD5OyfmoWNWxpWHwzZAxzFFVMMYnMK3x5
         afMA==
X-Forwarded-Encrypted: i=1; AJvYcCXIj7TGKJsd2iT9UQr+ib4XmM34mcysnPJaFuj+LwW9VEChkMedmRu7Il40DYPervF9iTpOqnqeNpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxMcbksbei6wD74+GWJEyNNjgnucvFE4RdhyapRAZLye6D7g2f
	EIWbSyd0+a5FqiLru2vKBncuZp8uIpSZzy/QhXAZR2SVbPtKKPHopSb66/tPKBHaeyM=
X-Gm-Gg: ASbGncuGOkQsgYr97/PDvXch8iDupwLZQnlyFE+zPWVA/T52uuMSTLxyJ4SpQHlB7H7
	grKqK1/SxLwTZuxmUqRAn9m4Zz3mPJkAPLMRpl+zeSaqcD1vlA7m8sQSv8BD5++PS+hkKN7ZGqx
	mX4jrNYjukt748MuecXAlQ8mJuj2RYVixMPdipKWptyC/4KxW3oHKVBF2zsuAS30TvZ9ZDJjcFn
	53/pr/WwWmNso8oxh03llCQehCvikQ34qbVAcBkSimA13/9osFwPP3UDzfL+83h9b5ao5Qc+i5s
	CDyIxiBjOHy/emAStOci46HA0Xrku/A9d7T5M2OYPYWjp/Y4g4nBOw+Jma8LuDlXcnv6IYz6WHt
	hL/lvt8eEgAywpjr4Sr5J8g==
X-Google-Smtp-Source: AGHT+IHILIH9TTHUNXKE2SXsO/39QmE4PBt4ZlHa7MSBEM/sfhXbd9DkCQeEuqozVECdWauUoscyHw==
X-Received: by 2002:a05:6214:29c1:b0:6fa:f94e:6e79 with SMTP id 6a1803df08f44-6fb3e59a197mr39514346d6.9.1749814935402;
        Fri, 13 Jun 2025 04:42:15 -0700 (PDT)
Received: from fedora.. (cpe-109-60-82-18.zg3.cable.xnet.hr. [109.60.82.18])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6fb35b3058fsm20558206d6.37.2025.06.13.04.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:42:14 -0700 (PDT)
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
Subject: [PATCH v7 6/6] crypto: atmel-aes: make it selectable for ARCH_LAN969X
Date: Fri, 13 Jun 2025 13:39:41 +0200
Message-ID: <20250613114148.1943267-7-robert.marko@sartura.hr>
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

LAN969x uses the same crypto engine, make it selectable for ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 9f8a3a5bed7e..b82881e345b3 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -426,7 +426,7 @@ config CRYPTO_DEV_ATMEL_AUTHENC
 
 config CRYPTO_DEV_ATMEL_AES
 	tristate "Support for Atmel AES hw accelerator"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_AT91 || ARCH_LAN969X || COMPILE_TEST
 	select CRYPTO_AES
 	select CRYPTO_AEAD
 	select CRYPTO_SKCIPHER
-- 
2.49.0


