Return-Path: <dmaengine+bounces-3541-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3279A9AF207
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D5028843F
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ACC2296D6;
	Thu, 24 Oct 2024 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgL4HROv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3D92170B1;
	Thu, 24 Oct 2024 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796967; cv=none; b=oxqQBd119gCHggWdd//rN+hnZOlPJRzh9zrrJ+12XppwX6Vhxro9YWN+ztpQhq+ipuhb1NUBOjFSdZDjLBkcuNESwDkwoRBv4l0nLvl0xasHdIjU7CjixgZabllOWxVlLeZYc5guqenUjhfcqt5W7LJ0w0xXQF9a+vIFQ5lVg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796967; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTACIsNYjh0JpryZsspHEYdQxGWrQxDicBb35lNnszn/wDWBNcjk58w+LdprmOcWwHFtcaE5vKLZziJEYjS6gJ5atxFZW0LpiLUc5Fy3pxUVBkDGfTXgHmArOc/xNWSsSd/6xCz8ogh7ybaBcfGVXTZFYx0xojnLl+bxmJsZ/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgL4HROv; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-2fb51f39394so14053821fa.2;
        Thu, 24 Oct 2024 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796964; x=1730401764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=hgL4HROvQVcvR2Km27au2orSbpv19s7U3z4O/FCV6k9+XaRJo6tDS1SlKg/2cWTEvV
         1KnAzhTip1/LKMvI6Tyb/QLCOyl01Bl947Uru1dthIxrDbGrCNRv23bQm3iBCYO0omCD
         lLyDfIWKlraqvFTuCryOm2wv/8aaVSfFM0GR/FzlT5ttLXTa8swHs1XYnwKDU0/P5VZQ
         A5ue8KsALNtjbBNNUBz3Im4pqhIoG7+kDAM4mArH3SJRq9Q51EUG+1fpEWHFC8pLe+dt
         RYjysRBIgQoUeCCMe20TX+xAEH7uDXT+9+xIxludjsBypC35VRW7MsdezxUxb3P5vCNF
         fu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796964; x=1730401764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=qpHKXQSMb7HjQXcsRp4EqGVKTLBk5aJCqLaGshzaYj7Qg3hqat0K7M2u2LTOYSPRUb
         xCihUwTZ8EvA2u2uxufzadHUYPh67flY/gq2dEMYjx+OcUPU2/6zHfL5WqzsXP1a/Tqt
         LURw6ZTzoIxYn7a3Bds45u2fF7k8iqz96vwbLkXMrV2sTQ9E2rOb9CP/7zX8M8XWXC70
         QvzYf6zHpaojIPOsKchUb19rD6Kp14tz66ed1C3+k7A46q+0VgRrC7VTdh9ge7pZLX88
         9zAAQ59tcczXeeya03fhSQfnFIQECnUffCvc/AXAIjNvFg9cr21jZ5upL5lURlrBnlRq
         W50Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/jQqJ77S1XYiTBoozzNIux6MBngUU28IvGWPp9dL97GPb1gcPu/I+JLu8DaTpjQJjBABv/LfAQVY/cw==@vger.kernel.org, AJvYcCU6GLiZCHJ9vq6MM1d0yjAlzR4Sb8fkSk4fRqNnIlriD6415vbnklwEz3YjkAel21fM2g8Am8biJ8HH@vger.kernel.org, AJvYcCUCWnUruokK7H5NoUlXcerUGMD+EeINpKfccLe9UVFIzHgMD53UeJpb0iJRdSmVwf0emaGtao0lWZ9xWJE=@vger.kernel.org, AJvYcCUHsoypxu4mTsm4/JXevFhYFVmLUj4wM2aCoGnLkaookUwr0/Ltc9ffL7M864QBFTocM7XPtJuEY9euGgk=@vger.kernel.org, AJvYcCUIO4RcUSV4hDx/1Fzi/GGfmEmpmjvF03It1E5isAcAuTGSXP5g6yeLQenH0Uyvz2BG6upvTkl4XlqNl4/Tydf/2/o=@vger.kernel.org, AJvYcCUdzbGtSjXKHwGGICS693YaM9jm0V8D6uc7HSbJTIwcBp2Ux/HBLfsDuyGtYAfAzyul2gNPpOv/@vger.kernel.org, AJvYcCUjR4F9cSjmr4VRVDTjZ+DQ4ep9M3ElkjTHP1eCvgWFZijVxpXSTV3QWArCGmO8npk2SnOOJjYAVPYqsg==@vger.kernel.org, AJvYcCW26HKEvanKdzRCL+m2YfI2Egy/RFUgMB1X1P28PXbals35a+9lWa6EL04Oxz/wnUYdY07R76T9GunE@vger.kernel.org, AJvYcCWFzzvqgM4C8XSKJyGGx/SNdb2BXsv5OMc1jjFvFknnTYK3QDt5FbHbKnHyvYnczoQoGayRF9CypLE=@vger.kernel.org, AJvYcCWanrkIzmEe81I8c+jMXTbv
 bJhv9cCfe+chOxW9zkHc5dWC4DEW6g3Ft+U9naVxHv8Rvk5chbaVsSQ9GH8=@vger.kernel.org, AJvYcCXipwEdkjZVoqmT+mS46MSlR35QLyXmcF9/aF2TIYocuse2qLUbc655IE9RNvzUhyMZ5VrMb0jvjvd0@vger.kernel.org, AJvYcCXn08TaLAZwQrCEwiq/5tpHPpD1Q8lZfRnJO41cHBvAgFRVdoRWmOE8L7g2UDlADyO3Bc3HAU6YXXN9rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9lSLC8GG7ur5CF9j9uSTED2xthusmdmmWJX3Q+2hPuVBr4E33
	ZVCm9KnLDupV1VhbuRdD9aIg9xBDR+g0X+JuJZgtPSElq44gs/AM
X-Google-Smtp-Source: AGHT+IHZT+qt/QT29Ym0Z4uA41LC1KVPEhTJldHSsZiZ029LsQkU8Bv7JOCtIrGtgDkkjSc8rXJvaQ==
X-Received: by 2002:a05:651c:19a3:b0:2fb:7e65:cb27 with SMTP id 38308e7fff4ca-2fca81c2159mr21637821fa.6.1729796963407;
        Thu, 24 Oct 2024 12:09:23 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad4b804sm14785331fa.1.2024.10.24.12.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:09:21 -0700 (PDT)
From: Russian Troll Factory No124102107614936132237169106192194306572797123221588731441134731292530075318731846332329166771387842821482716761931624377595610961 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:09:17 +0300
Message-ID: <20241024190917.14761-1-vladimirputin693389@gmail.com>
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




