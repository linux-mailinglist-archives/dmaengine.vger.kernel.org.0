Return-Path: <dmaengine+bounces-3525-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28A99AF139
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A931C22589
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69F721BAE8;
	Thu, 24 Oct 2024 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS/6WiQO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2712178E9;
	Thu, 24 Oct 2024 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796889; cv=none; b=N9uEhHf2OKAVJwaDIgKomQy9wMuQjvzqquHS4uoemwpSaxVoZPp/j4kwcSvaEa2ic0V/+PVNacsP/JpNAqKfa5Hg4r0d3rDArym/3t0MAUs5VNz0tur1QsNGcqJlO8pNGKPLiUhuGi/Nlsv9q3y0yOy+TjVqS1GkOVt1Eg3R4c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796889; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hu8Tr00WTLLd0v+QiMSUI9OQYDYsxoC0PfEj7K4gs3WU2Ur4jgpf3VJ2PcX3IOw4pavpaNgc6i8mzX/W6Z5WA0lr2T15VgBCeH8ljlC6SjvWgx3tDgepjp9UEeVy7t26aJsGtgAwEmRYWZbWrzYfs8elC/ssbg8bsC/qTBl0ziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS/6WiQO; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso13640441fa.0;
        Thu, 24 Oct 2024 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796885; x=1730401685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=IS/6WiQO6MmzolsdVYb6wKuBRgg+VEVNQjZb2DiK6xvzCORw/GvgfzuxuJ2fjoNp6k
         THFpN6dUnrE2yfRJt/P/iw7QoH4YCxiF0Faqi6jY/9G7K/Ltlhtz/a6iZpu91y7PjIXk
         2dymCVfqi+urAJpn93cYpnyfwSEAJ8nmaj3fuh93T3CisX34ny4kDzlP1Yinw6Cwo66C
         Ceep7DAIGex4sk3pZDa/lqJFPNlE/+gqd/tQIu3vQTGU4fDbsEmtefkH3zgDJ+wSeGVf
         tSatKNwnb/w3SVId552esJH3fGomZUrWZ2UVJuI6DAJlu5N2nydaJSCRu4aZbleIXB3p
         /hGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796885; x=1730401685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=DBFyAJtVU1gV946EeJRl0vutgVzXOLCzhhtSzzM66qRmx9cUHerL2VcZXz+AHpk+qn
         m2iMhQKxzZ+4u78inZTsubOk2Qqj/T5eUuCKnKV/lrK3SaEJUqt2FyLkjprB86EX7JP2
         BqF8EyPP2vHCX9WPk4SoWHG9WOV9ZXvsMO0NU78VlHGwP3a2aCL+E5Hb/v59G8dFi79r
         sqyRBk4CemxpvDnWXzoErMqd2s1X1Dsi00EMxz+ONBrhA8PQGIS2Xd2HubcyUEbtn9E0
         1XRQyQMYQ4loqyFwSm8bsHokbKsKZLDH145FAgCZogEKpkjhnB7iGm5YawsUBHCJ5nQp
         wTzw==
X-Forwarded-Encrypted: i=1; AJvYcCUAP9pTYPVOpdsimyzbL9utzVtMDOQcQ5r8fZQkFRjdB7acNBfmexnZtJ8zWBAT8P9fFYt/gLQxJ813EFA=@vger.kernel.org, AJvYcCUBq3LFFGLuXc+urvKA422MDZYFgLGmx4u6xNFKzYzjIGbLNpB8SqzRcYaj+zcukTqgxYOtbvOAFpNlIw==@vger.kernel.org, AJvYcCUjsY4nznveJvKxkixA1T8tL+hkUoMBfi55kDblrT6D9+mTMRCLE7M4+9oIPLAnkKTUfRcGVfm4b36z@vger.kernel.org, AJvYcCVCHgJlXsjpljCgvhPI1+oqjZn3kDCdXU26+vIoc+13L5O4w8sjdAAba+yGIVbxfMcTuFlGQ2zH7Fai@vger.kernel.org, AJvYcCVWZzxDhh1qPdKZVygR8cWuKeT9t+SWKLAHCrn3JWTZxuxk7iBQ0PVXBv11Wo2O9pMRplLlCSZCWDO5h48=@vger.kernel.org, AJvYcCWKI5/UoRtK22H0iwYKykqK7wJZu+M/LUMwXb52QCyO5wF9qqQctA0T15g6stDAeAgg0qN6uYOmPMs=@vger.kernel.org, AJvYcCWY0R1LE39NQfHDNwIDQwqE1sfsyOMiK8x6mk7eUijds6zxOCcDLMZsZBfewEHzLSPPec65onTXcKQdxZQ=@vger.kernel.org, AJvYcCWzChV6nHvzQvtB1uzZwbsQm3Gy0xtwZDRb22dk2rvN538d4Hl5K9IKqgCocTXoY1Zf/pLi/nlT@vger.kernel.org, AJvYcCXMmdRv0dCfqvucPgaAAXGh0B1HLUp3dVxBRC5X0EjNCp4TLDVzvKk7evgECfOToeHsYWC3mP4b0U4d3Q==@vger.kernel.org, AJvYcCXe8Urmp2/d0hEotoonkxy899sxZ6lj
 w83FAr5vX7lZSm3NRzgDBtehbIhvaYXs7IGrhoe4XSdoamz8Ag==@vger.kernel.org, AJvYcCXiJIAI6pszKh7ThT9jnANH5V773eWQC/ZpawPd8prqBDx93xGYMeB/0beha1lJUPMIJf1AL3bW6JD/llIcYtuRrXU=@vger.kernel.org, AJvYcCXuby4Wv+F/pA1M0z22e6W12/QHgddFFAZHbp+/TlgoFV7lHbJT5EKjYWEcamRTWFw56zkIafM9FpgG@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZLp3lZSi0FsuKRUjUZ/YUy114uTYhYJJnsxScPTrIJ+SSDz8
	aV1mdOvTpe9B12m2EeM3kv9GlMYtYkP5xNsw4/l0xCLmAFJpKKjW
X-Google-Smtp-Source: AGHT+IEIfkCNdnrdueKjTSB1H80OCcLbBEZmmHdPDimslf0LvePfusxnY1RIIPOiP0ZyAXH6636/5w==
X-Received: by 2002:ac2:4c47:0:b0:539:94aa:d512 with SMTP id 2adb3069b0e04-53b1a37555bmr3997062e87.53.1729796885265;
        Thu, 24 Oct 2024 12:08:05 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2243eb09sm1442286e87.245.2024.10.24.12.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:08:03 -0700 (PDT)
From: Russian Troll Factory No14618279572208551642101103740962120117370252952048311852188413910185679690829314191248641272410849196441385512151172242044520279 <vladimirputin693389@gmail.com>
To: torvalds@linux-foundation.org
Cc: aospan@netup.ru,
	conor.dooley@microchip.com,
	ddrokosov@sberdevices.ru,
	dmaengine@vger.kernel.org,
	dushistov@mail.ru,
	fancer.lancer@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	hoan@os.amperecomputing.com,
	ink@jurassic.park.msu.ru,
	jeffbai@aosc.io,
	kexybiscuit@aosc.io,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	mattst88@gmail.com,
	netdev@vger.kernel.org,
	nikita@trvn.ru,
	ntb@lists.linux.dev,
	patches@lists.linux.dev,
	richard.henderson@linaro.org,
	s.shtylyov@omp.ru,
	serjk@netup.ru,
	shc_work@mail.ru,
	torvic9@mailbox.org,
	tsbogend@alpha.franken.de,
	v.georgiev@metrotek.ru,
	wangyuli@uniontech.com,
	wsa+renesas@sang-engineering.com,
	xeb@mail.ru
Subject: Magisk patch for android nox devices
Date: Thu, 24 Oct 2024 22:07:58 +0300
Message-ID: <20241024190758.14519-1-vladimirputin693389@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
References: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi, the linux mailing list.
You have asked me for your opinion. I present my opinion to you:
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK




