Return-Path: <dmaengine+bounces-7069-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFC3C38DB4
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 03:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C7E3B9317
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 02:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF31923ABBD;
	Thu,  6 Nov 2025 02:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4DmK8zL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EFE224234
	for <dmaengine@vger.kernel.org>; Thu,  6 Nov 2025 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395869; cv=none; b=R1EwLKwWAY8vsTqnnn7uxw+Xo5EGZNX5d3ZKQnYHpQ0tqNU73Wybs1Ufrrd+LyZpmwVyBOgUhtZ10j0c2/x6PdnFUsQdevB7N7juO1/pY/LbJ1adMX9pSnXEWE3zJa9plKs/M5cWJlKawRlI93IkfPsTpz9Uw+HoCQlOaZWF1LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395869; c=relaxed/simple;
	bh=7Q4xu4827zczeLEnSnPu22t5cmWiRzgvOmRy7BlrbzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDG506rtHamyC/UHt613Za1xmeHK3VzqwKuC1FhDpayXMMrfhlL5+zUwi2ueeFOxVwkRRWBhIaZrrFPA0cLPnj+i2gBwdz/aDjm9QH0UVHhO/DI5c2eQuXQImv6a9HBKQZLhSdSI5ztbTo++KYIQrYOCOsTynEsgddM15NahHjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4DmK8zL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2952048eb88so6187185ad.0
        for <dmaengine@vger.kernel.org>; Wed, 05 Nov 2025 18:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762395866; x=1763000666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RgHKuGRcojJQByTkzvT+fYL9rE8yH/+/URCufT9VuM=;
        b=T4DmK8zLLmGvSUAKOd/8op+0tgVbqgswcCeDgJmHidAy1aiJ7smp0yDcZFUbcH8x0S
         3yxOkEDAv/0w+nENKGq8jQDzErzBOlEIoqXwY+zMUiDrAeJ+xFuErVJXPB0S2FNdKsFu
         jWRVFb61Oc0PWb2uSvj6PJ8JuJhO3AJHxp0K7iXahimN2MgfFP4XQRKH9M2Ndm1XOMSz
         WEOdfoQ3iq0tdW6D5C3n5w4U/B8DUM2aSN/+C+TftZnEMaB7RRva753KvdNXf87iG3T/
         fIWuoSqxBMiC5qjcdodCUPqkP8ENUrtsfQ5xZpOQ4FTK+4tfSzGymygHt7ZVvpNTZDwY
         GZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762395866; x=1763000666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RgHKuGRcojJQByTkzvT+fYL9rE8yH/+/URCufT9VuM=;
        b=NeTsbFP0HzItSmxwRiKncl/d+RP7hx88OdZuyQtnBB/oxQYeqGKbd22pnz4Mt7Ltxm
         P/sdlkXHBJGk71BfGGa/rSsJ2905wd/+XIzv7lW7MOCF4PLXvEXjbtVwDpiuBpIFRPgf
         /evZJ4VTOZZFBQ039YSV+LNkIUZILavSNHiwsJCMTxVeSBIHOyYjazSuOrEKJVFKxsO4
         j40X3aV1dV7VhWqoLs55lBe/2VKNTuK6fumnYagYu/gwBfcmlKPZjY7Mlr/3p/9sjzWK
         eodlU2YH97IlRzz34fOuHETN6YRMFpGOoAQizfAke7HxfJk1Qwx7ZPyoP6nmFIgExtoz
         v7jA==
X-Gm-Message-State: AOJu0YzNxmptegxilqCYFr3/aSXe6/3M1kVOSyt8FCuB69Ppi1cFwblp
	YV/pQaEj4iHQlKtUbAm+7XXtjkT9hT6ANHo/DYXoAvVkpTKUjNz/5AfRI9ayuQ==
X-Gm-Gg: ASbGncsr2KXQiDSI6LlpfxGaNRqodPjuE3JVeMRmyUkOBhu1jztYoXxspPEmOY+oQJB
	pqAhwlWggkjf873R9+OW75KaeeAFhiTUTE4O/iLFpMDJkZ61Zlefp7qPN+JdBwnZll9h4ScSaHG
	XW4d56UeYYqtYm6F/zpAkOsI+cv2qEG/ekng3pa6VNOiMv14PZJab5+NZZBEsS40M7/LmgvBhP3
	KDIhbkw8zjPRkhs3Tfrm4MzVfOBy4N/mwuFPx3KE/a7moYaioNKcWw0L8xIL1OBeHNAc0NgRbKS
	HblEDs3Y9YNOrg/wBnvF4a3VKD8A0ExFSlxf0f32ghR/EJbWfOGyAUN9/697vvJg7ZCXG5LMALW
	+z61KciN3h4TJ/mMxDIIvYm0kXPVggQpX84tbjU376WvRXtU=
X-Google-Smtp-Source: AGHT+IFlTglLO6YbNUiSxiWM9LuEL1TE1korjNRnwjDSZonG3AWINPzmqjPU+srD6U6HHADF+p+Fdg==
X-Received: by 2002:a17:902:ce90:b0:296:4e0c:8031 with SMTP id d9443c01a7336-2964e0c8139mr28182925ad.17.1762395865886;
        Wed, 05 Nov 2025 18:24:25 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5fdb5sm9399935ad.44.2025.11.05.18.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 18:24:25 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP AT91 DMA DRIVERS)
Subject: [PATCH dmaengine 2/2] dmaengine: at_hdmac: add COMPILE_TEST support
Date: Wed,  5 Nov 2025 18:24:05 -0800
Message-ID: <20251106022405.85604-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106022405.85604-1-rosenp@gmail.com>
References: <20251106022405.85604-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows the buildbot to detect potential issues with the code on various
platforms.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 8cb36305be6d..243d3959ba79 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -102,7 +102,7 @@ config ARM_DMA350
 
 config AT_HDMAC
 	tristate "Atmel AHB DMA support"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.51.2


