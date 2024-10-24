Return-Path: <dmaengine+bounces-3534-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710499AF1AD
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319E1286EA4
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A017E21E3A5;
	Thu, 24 Oct 2024 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQ2c0/ml"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085102185B2;
	Thu, 24 Oct 2024 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796930; cv=none; b=ZqtiMBcaiMfu+R8bQDLYT0ih3VAG9WWbNE5B/hR/S/IQ8WbXMdt0Q/2x3QlLgSAjW/jEBp9QgsKqHyOx7Fv3qOLzSlL6smGdRsfIUrmu0gZOCcSU/wAZn12NSOwciTBZFhtV1zUY5DFnlcI0ebyJaTB9KT/meBlaNO5Aw/C1Kxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796930; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9FliIiz29hBlPcNID8DMsGPko8ApnybMwgK0Rr83V+nwjJZVfAgqgQMKcPm8cB0PrFf8/H6HmBUoK7BH9qt5zYEhcxX7s/YMAZtfsJYLw+BYbCWoqG5FntFA2Z+WM6ThDDysLAY/lZJHmtgvv2qgPwain8kYEpOvzGU6VM6VVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQ2c0/ml; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-539e4b7409fso1397725e87.0;
        Thu, 24 Oct 2024 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796926; x=1730401726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=MQ2c0/mluy4UotZMWxOnwsek19ixROmoKPEBuiAb8JuTwm4cf4AGRR1wPQH7zcfi/J
         AEplBAKI6+EyxthQMdt9vFqlwu6piG9xlUMSv9GtK85fNM8Df6TDBW7YsyYXGuAY9YlR
         HwyJ+3p0O5Ys9sn1wX12vvSUgqt2SRtZ5xg5R9+Q8DeXM01/zbAozzLS0Bsas7OIYQzy
         HFmmNFS1otwmnTV24LSUp5nU9stmj86VmnQoQuwJ7Oa4ojGnqRZzZasptYnm7Ho8CHu/
         L1OIXTBbgyFKK3fgtw62mz04hOkTCukuEZFDDmKAFXbHnOnwsDDTbB/zdR6zBWRrkLaH
         iTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796926; x=1730401726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=Ls3gBGqg1QDNqYM8R1bYAnSwGUs0wBxXg+A7yvPng4fAa5VGa3hCLbkvW9ULYTG2qi
         ylG0Mxy7iea8rUgbGZ/9EaN58eiAJQiayIl3US8CrYSZSOK2wvLbiiwbIoqipJ2JlIB+
         n4ujw8PQnICWTjVNq4aeRZyguJqoSAaIVGRtDNkipROUEnN8la7FA1EPLugOEJvTk8Q3
         OCpgslkyEioXoLIZFjnxHhKs/9hXzEjtFcKV8qrWaf6NcTA9ZJ05BL6JjwNPEySkYvp/
         osSEUoB4ykFPgVxvkpHSTYIoiKByora/IzE/V4hDGHAUFoWzbrpI2dFCy78+qaIBjmmo
         +2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUY3Pm9ux3tuGVU6fxb+I4PLggXqDmGrch5nTRyGNwV5gSi8mIteLUnADjDEwdlXApAfPB9ogOK@vger.kernel.org, AJvYcCUmn1xqcABnBDx5ldg4rwl2DZsHc9H4ZsMbIRUEQB1Yxr7OM7dWoG7kICybB4fyrLttS6gVhsNuPRALx2U=@vger.kernel.org, AJvYcCVUrCx9ffRhddIs0c2el9190QaJ2kwb41RS8rE099TsNSlkUxqb3uKxJ2IEyq5Zaq2q9coKZnMi6eOE1A==@vger.kernel.org, AJvYcCVsBD7Dc996sjKz8t9Z5s/P2NlUlXtVfeptbZwMwZMPmfU7vig4HVXYdF1uv1Uz7KR5YLPQIIxneuDV5Q==@vger.kernel.org, AJvYcCVyW3V0rEXdDjZ3dMRdx7hUQMRkE185KANZZX6U+5BuBgeWIX7P4r7K65WPpD/ViPoLejmoMrURL1B08hE=@vger.kernel.org, AJvYcCWKlh68+79kMhq2mTDUmf7GDC01DZIHfM5KvoseGNx5rvcvncUzd/vCrPKobbWa3um/YA8jX3BwsQ5dJcdL1ST5Unk=@vger.kernel.org, AJvYcCWeHYdaAvwvofbpZNDdoJNZFoxnH/HD/ZDWPZtZGUGcbPr+hxa4di9Px1ttoeOtMoxyXOwcMNW3VgE=@vger.kernel.org, AJvYcCWh/qeiRtFgu6BdoHWemIMuhMz+7Ld8p+nzBuxJYHQAQ//C5r5GhKQUduMh9g+CCQSU+mAfDod4AaSk@vger.kernel.org, AJvYcCWmVG8aTfvJEfrlIxUwPKzuqDF2OWOb43bDKjg134/RyG2vAmTYdvzkNIIgrwoq2EnBdoKLa33Yz6tp@vger.kernel.org, AJvYcCWmouCI7uS2shc2+N5GMuuT
 NjuMZky0y9WQmmPf+Fg+5k2r7m04jEjto4xLKxR7jR/tgG2q7pypyGQ1@vger.kernel.org, AJvYcCXZjWRJxVMf6Ea6XsquD9EvZBg7RidMCd26ch4+GVlHNzkhWWvVGhodXadZAmPNQVNF1EfSxOMSg5cMggk=@vger.kernel.org, AJvYcCXefC3cIXi2p7nW5nBiOzlOIR1BUih6uCTeQXo4PZ0yg8xRotP/nghTbBrOoeKQgVWm7YKhgqM1dU+QXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyT3wZPAZvhGgUvbLBNQGcFxo79/FZK20b8Fuj/A4mROibH632z
	5bmb3j89F+xyLmk8c5L8GNiRHwNK4AQuGBX0qvVz57UcrtqZSPGD
X-Google-Smtp-Source: AGHT+IFtn0qsoHdJ7quZW/MdaoBgilt9XKdHn2TBLJE4RrSFZgppgeIUNZkTKATos0ClSz3RX5vNCQ==
X-Received: by 2002:a05:6512:3352:b0:533:415e:cd9a with SMTP id 2adb3069b0e04-53b2374cff5mr870302e87.23.1729796925991;
        Thu, 24 Oct 2024 12:08:45 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2243eeb4sm1439340e87.283.2024.10.24.12.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:08:45 -0700 (PDT)
From: Russian Troll Factory No785711924750158342620131827108520175222218412130628841180683210094684889142972473031440492009629643309731963256622731026967 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:08:41 +0300
Message-ID: <20241024190841.14662-1-vladimirputin693389@gmail.com>
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




