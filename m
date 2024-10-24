Return-Path: <dmaengine+bounces-3516-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9299AF0C6
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943D91C22174
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DA0218D72;
	Thu, 24 Oct 2024 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcKBF2c6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7A2141CB;
	Thu, 24 Oct 2024 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796852; cv=none; b=up/nZJkQMrE8WUBoCKEjlQVMGSgPGVVGW62DtBwd6vwkj5gwNzlDMOXpB5g2bL0EIfRjqxo/RrASQQTN/kZmfrcxW5+tmPolJnMmf4Ob8LAb87OkCWPSBxNnUpaH0mNUcz1rsCuEZD190OZPZgYG7WzNws7w7AfT8MBhGVGS8yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796852; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHkKBtrR3uIlyonoLIUpzSpG6wmjRDKM+7QtWUr071W0KLNJiyzCZGYwgkbMQv2Bw5MXprTSDW9elUGeEAeU1NOWiZrif8uo5zjSISJaBQmXPl0ToQxCZjGzrSFOZK43AvU8FqxTzogI1YFuvCgZTulTHYZlmA6vX1WalLRgf1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcKBF2c6; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so1806213e87.0;
        Thu, 24 Oct 2024 12:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796848; x=1730401648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=lcKBF2c6M0ZB62I2+HF0QLo3Iobx0YamVJm5i2kjhaljYWdGGqW1EScK2sf7QbC0ik
         UDKC4iNodThw0h8T18NiQYCiG28hhp2BpYONI8yXBINRImCvrtQt1KZeLdlIn+cNKcMi
         P3sxuywgoXPp4gH/Otz8weS7+7UCUtqSsTNlvgaose+l7pY4XCq4mw7PFf3MDDuTqAzX
         lJiClUrwuj+WxASScQLZlN/xNakW43n7AbgQ6AYd+aFTDzRQU4K/8pyZg4cH9GltMXWp
         UioVm8WgufFdrbne5olMpykEp1Gxm4ms9KKBGnsyEY1iZeQR0zxY9yWCsXIbSNpZwbUH
         uw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796848; x=1730401648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=i7IYAyRo8jtslIroYQ2NWMWKiywMaF+J7xUXzee4IaAjoysuTXzPjReOl9rPD9xmCo
         4GabUg0pBGFR++WlC0J95m0ZedV4XYhnn+NT5qdDlvIUAuGngd4e+D6+3zR33UKTfV6U
         iUscM0N2m0KrTe184TcpKqxZtVzV9rf+mnP614X8MA8PhEmtrqojPrTz55HSMeXIecUO
         YxNKKsaUlmx9h9T8/bNLqmngzlXzI3J8E3pbs+beCGIj6v0g1zHimugDLVkXRpYZGP3w
         5wFws3RgSXh45ETNmCPPqli2TXDa8q6d5dbUbgo+75vFlatel3kp+g612vcW+fBjKFFl
         2MSg==
X-Forwarded-Encrypted: i=1; AJvYcCU/boNagOAy13Mimf/va6/1RMOfPQCo/Lw/BxKbZZcYq4w7Cz6TsyzYq9lJAPwf4Lee0F5wKL7dYm4=@vger.kernel.org, AJvYcCVEm7jZx7pCOrHYk4l/dG1h0V84Mj1c++CvlIEQpnVZgUdP4uWlRbTluteouRUmcnAdDViobOi4LRD3zQ==@vger.kernel.org, AJvYcCVTkd7HqdkIuNL6zoRzrlYvZNQDatIsQg+eJ/YrEhXcqev3nl20gOt4JjCU6u1Kzh7QRWoPOqHz@vger.kernel.org, AJvYcCVbwIqyF17L76DwtU/8FjHcNOd6rXRxi1pX18U4LAlunY3LOxCvPJTIadxeYe0QwHqMqu2S+s89BrQ1Cgh6tbqv0jM=@vger.kernel.org, AJvYcCVrvtdm7hp6NEaOtnaWKUvl2bFGn76WJYsxMgN3TNRxCFZh5Prb9KZXv2C8HO3T1VsOeyHbcvRLt6hg@vger.kernel.org, AJvYcCW+cOaijd6ANTsa573wFhPbMzqOikrd62VXoNqh2knfl9kbjZTIa0i/Q32xzM4xLlD4DZmLAlgyefBmljQ=@vger.kernel.org, AJvYcCWoKbbmy+A4Uuk+GB2Mrs2I6WEw7vgc+SyHdR6QqTrzuxc2iRpPGP0lT7zWmPs4BBYCjNqIDRBPNkOK@vger.kernel.org, AJvYcCWqJ8k2gj719JmBNRgL4fL87rPWiUnKuh2aeYlvWK93cBhq5wO13w9FSJNDIXSZBspWmdbRcbEGMwxAyDA=@vger.kernel.org, AJvYcCX/AvZcDPjF3ODZ97hbh2gZriIEUrjPEl8eAwG5RlTw+0WOiWPE3HPGW9tuKmDtACU/V7166qhcVim3yVI=@vger.kernel.org, AJvYcCX8zrJMDACOMP9QiLoYK6pR
 frGstB9apUItfbeo/hcpVJ5v0CvVpvTyD6IajAoRCbZKCQLijf2HqH5eWg==@vger.kernel.org, AJvYcCXKZ33Rnhr6tQPK5MldToN561B06cikWBvQyBpryv5MihNguzVeJiuabHm7Zz0ZQAGccer/wSb9dFAv@vger.kernel.org, AJvYcCXLhDTxV89ufoQ4onqZpZo0FkPqOnI4R1/klwITOGP1uKSo77sKdI0lzCTdloPE3a17TRlLuoMAbVMVPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQO0FLDSfukFHas1MqX0EpH3rtTt7/UK8uiSeWcztFkaXsyX8
	yJYT381muOxpqlZShw8kYQd/wOyhSiF+fkjHF8Z8bVs7CXqHzyqA
X-Google-Smtp-Source: AGHT+IG4iXjuNSjsQItvSP0ABV4SJhaMoBSa5wS7n932bopKGmrPWSXkvIw71l0A4Y8x60yszdy+uQ==
X-Received: by 2002:a05:6512:3d1f:b0:539:fed8:321 with SMTP id 2adb3069b0e04-53b23e8acd1mr2047368e87.51.1729796847506;
        Thu, 24 Oct 2024 12:07:27 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22420301sm1431529e87.154.2024.10.24.12.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:25 -0700 (PDT)
From: Russian Troll Factory No815620860248991615389861340054351180625809278551764113110229532173024199158632461416948561818543245642959930231834417238229929252 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:07:21 +0300
Message-ID: <20241024190721.14420-1-vladimirputin693389@gmail.com>
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




