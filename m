Return-Path: <dmaengine+bounces-1113-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB07686700A
	for <lists+dmaengine@lfdr.de>; Mon, 26 Feb 2024 11:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4031F23C28
	for <lists+dmaengine@lfdr.de>; Mon, 26 Feb 2024 10:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512C0626D5;
	Mon, 26 Feb 2024 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCIAnz+N"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A577626A9
	for <dmaengine@vger.kernel.org>; Mon, 26 Feb 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940847; cv=none; b=B0H2tBMY0Zmr7toWQkfNFD7gq6l4y5GGVBE2lV9Uxds3tCjRYX8Z8WCZy+kjj/PnEgUV5NqLJ6UYYCvSaguh1u0fz7MxwjyVnKpFY/Z8CVEnEWUyaXml9xtzQJNsjIPvcZH+m7DQ3YMOh0HpRqqgKxaqCb/XorR1LreWkC6A3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940847; c=relaxed/simple;
	bh=5y4i93VXcmdUtjt5FWPiQmq6UMktsTYsPI8vX1bZ2V0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t22kIGvaYWiH3aQDNnHNuYpeinW18yLMqNSMNBTreGsdCD1eLqD9CWrGwaLNpXmSy5Q6eiAkNVAyKn1oxWQbKcVPHffMefCuwjRa5f2KwGVCMh6Q/KsCeHIvOMnVLvRmVQfY4QTNXO8LHIIQmUbdviToRTgplkTNtFnAIdrMeCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jCIAnz+N; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3d484a58f6so392596666b.3
        for <dmaengine@vger.kernel.org>; Mon, 26 Feb 2024 01:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708940844; x=1709545644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+kfst+zj9dofH6G00UFxAViFXDa4ima2oZcEsc7TvoI=;
        b=jCIAnz+N5ERMQPLCkv3r2lzMtEAaIdrhT52qDheMnwGT0iMo76wNkDCuC05bfmFUwV
         67X14nziP4HwEAsVxINAuKPg2nC1lgniSh8k5+QcPqSgwW+WmrKdIKkfAI+UsTkRM3fR
         lC01oB+0CCDn1NbXTjFAR3xaXlMRiNZlicv5hF3SUHK/lrpqBqy8KsXwlGIPGaGxFA0U
         b0/npQjkdf/CpcFTa2RqB4NWZ+ETyHWXWUDulr/MqfHUzSGTG4iu6HXXXvEVuWxifPwR
         8eLDFKxUMhLkj1eqGiLD7dI541smWd0An4kA+mhWn1RGC/7rrxrubBoDvF8Ts1lGWj2O
         ULPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940844; x=1709545644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kfst+zj9dofH6G00UFxAViFXDa4ima2oZcEsc7TvoI=;
        b=RCg6QyE6fHq4djmXQ59CvscCwIc2X4iZ6q6RenlBEA96aXTht6jzWTQ3qCLS2MRC/c
         4St+KVUPO0pNv0GXHrQYzXO0JieWlXEw4GcpiSA1QI+glxdbbOcmYb+ZnZiR2K25dicY
         ZwFDewk3CWc5Q6vzz0WWM1W2YTWoOUQRWzx9CQsMV0Rnb+wMyVCk/eWT0jDD/iXNOdbc
         Kt7d6hoSTBNdPOw407d6CPpWm2IzGl/9usfxxk6n3RjtRnAKhZPFMWT5F0FgVDBUUKMv
         hW+x+T2114Dkg+zEBGaHvYWlpH/auBawjeADFeZU59ar+6TSJmIGb9PSjTXI1zxs81Gj
         V2cw==
X-Gm-Message-State: AOJu0YybANetrSXqwJnJIYDjYfEh63SgTcwoYKtof8VwaVSXV+/AfcnW
	y9pXIaIQOziYpqvxHJ15TTDsozHClG+8Cit8lPAqsg22Ec+2vi7hio9WuPrYaeAzmBUWW9jqf9V
	K
X-Google-Smtp-Source: AGHT+IGW59FF6b6lp9BjaeHYg+U4YXucBm/Jzr8k7kcUpWM0NeiTzSJQ7Sq41VK2A4CK9lgJaY8FKQ==
X-Received: by 2002:a17:906:eb4d:b0:a43:80e2:98dc with SMTP id mc13-20020a170906eb4d00b00a4380e298dcmr334127ejb.32.1708940843746;
        Mon, 26 Feb 2024 01:47:23 -0800 (PST)
Received: from 1.. ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id p21-20020a05640210d500b0055c60ba9640sm2175929edu.77.2024.02.26.01.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:47:23 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: claudiu.beznea@tuxon.dev,
	nicolas.ferre@microchip.com
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mtd@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] MAINTAINERS: Remove T Ambarus from few mchp entries
Date: Mon, 26 Feb 2024 11:47:18 +0200
Message-Id: <20240226094718.29104-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; i=tudor.ambarus@linaro.org; h=from:subject; bh=5y4i93VXcmdUtjt5FWPiQmq6UMktsTYsPI8vX1bZ2V0=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBl3F4mst9gVFdNv2yXt+50Sj0Jqcm35hTr5ZQHr 2TSTHg0A9eJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZdxeJgAKCRBLVU9HpY0U 6UTVB/4oCBi2DI+DNUG0IVjWM7GO66JVMUP0o4q1lySZo/elMeU/p4t2PCXCr6nD/CVYEtbAwun 19/+ip+Bb6WoDXewNyqj3/SOL0g3XaZMxMakw9A+sfN3w9DDFRaAZaMYuWsXYVy08JJ6bPy96PK l5A6zNH9yqCwhOtrdgSuL5REWQB32lSj5SKz6+gBLLfrw0L10RPn3Q3zixzA97+fqW0H30Dwsxv KcWfu9FzTvqMyqVqZxTeUBTmyJ0zPS1I2EZ78qjRYG60l+Uwu8eIabM/Mb34ePdVepycAV17caX eCY8HGcqKPu5jCh9GYuMnUaOeYZy9/zB9NEMuu6Pv3YSSyzK
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit

I have been no longer at Microchip for more than a year and I'm no
longer interested in maintaining these drivers. Let other mchp people
step up, thus remove myself. Thanks for the nice collaboration everyone!

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Shall be queued through the at91 tree.

 MAINTAINERS | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e1475ca38ff2..fd4d4e58fead 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14350,7 +14350,6 @@ F:	drivers/misc/xilinx_tmr_manager.c
 
 MICROCHIP AT91 DMA DRIVERS
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	dmaengine@vger.kernel.org
 S:	Supported
@@ -14398,12 +14397,6 @@ S:	Supported
 F:	Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
 F:	drivers/media/platform/microchip/microchip-csi2dc.c
 
-MICROCHIP ECC DRIVER
-M:	Tudor Ambarus <tudor.ambarus@linaro.org>
-L:	linux-crypto@vger.kernel.org
-S:	Maintained
-F:	drivers/crypto/atmel-ecc.*
-
 MICROCHIP EIC DRIVER
 M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -14505,13 +14498,6 @@ M:	Aubin Constans <aubin.constans@microchip.com>
 S:	Maintained
 F:	drivers/mmc/host/atmel-mci.c
 
-MICROCHIP NAND DRIVER
-M:	Tudor Ambarus <tudor.ambarus@linaro.org>
-L:	linux-mtd@lists.infradead.org
-S:	Supported
-F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
-F:	drivers/mtd/nand/raw/atmel/*
-
 MICROCHIP OTPC DRIVER
 M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.34.1


