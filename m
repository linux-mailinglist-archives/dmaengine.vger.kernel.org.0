Return-Path: <dmaengine+bounces-3519-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EEA9AF0E8
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317CF282D28
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D03219C8A;
	Thu, 24 Oct 2024 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAed7ZfB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E22194BC;
	Thu, 24 Oct 2024 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796864; cv=none; b=Ju9zg6MePTmN+24x4Db7neiLLCpz3E+cyJKIuzkqpUa5k/mkI2qsbjmtFG1bjnguUjwZKUhyXmKlbv5fQ0z9nV/I9Waw68UygAs44UDBUbYmgtm7ZPSNJwrYUPMsrLl1kxUvZ9EAePRMiTrduWHp46ZJNKn6y44sEwA2TWqmnNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796864; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8uEPlvm/ZENOS/iEfL1gGER0VhhSt6Wdqkm/A8KvFrU060vDfDsVcyAj/Yo3UPh8xelhGjsUwuoGRIFiKMfHcJj5Prdt/yPvWjOh50twjFRdvH5SjfnjP8YKbJ+sGx2J0jLwqOJfiuPRf2+bJ225/s7uarHM61JW1jhZtgzjS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAed7ZfB; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so14347091fa.3;
        Thu, 24 Oct 2024 12:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796860; x=1730401660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=EAed7ZfBCqekbrwrVKFF0GeL8JfvX+v4hwJDNgq9SfKTN+3R/3ChCjCYaRCnYQZlKk
         xMXrH1REvy1/hh6a8z8R40L89/Vtr7lckBUeJ4rGcsVRVbPWj3NphPTMS9/bydJrFgBr
         DOBd5wB6jehk7s3gXjwAZTYEsReXl6j1cBCK6R8ISzeVvpGpvpPOWQt/urL4lkpr0CiT
         rC8ZHnjCXOCaPd7zfNTEYSGtSg9UKpzK8t0MeQokZ3ingGFsNp3+QHOgfSgtafiIsktV
         OlGDs2p0DYnQeKYiAMfZAzwFh+wdV0j6A4iGrb4Aw4v9LEKBVogEU/7cUJk4qaj+IuXF
         C+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796860; x=1730401660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=RoSOfWJZK4xwRhzbFJwo56qgVV/MRuDq/DEnDSb3aDZlfqyy76AIXg0KXUzJ7TdZwQ
         Gc7s2kZoD4RwjezIeIPZZBavMU+/oBPhtmzQ9Y1H4M0NmNMBokozj2um8BWmNjkMvC8I
         WgbbA8YPFEOSN72iPIiDT21muSbPLeYu4fhVs/5+pf+27UI4M41M+AG8kysmT6PI9fx2
         f9hpMkzIUK1aF5eda0h6v9IxplFO4JpPvz1f3d5sd3R6wJ5hFT0z/hrM4J6HSLQpX19X
         b6AkJM2hMspvFWEhnkdW+1XOWwCn32tyoA0LLOooLZQsRYjm9/u7lnHvqBtVSwTmHKZc
         4NyA==
X-Forwarded-Encrypted: i=1; AJvYcCUfrH3gZggI9JqtpDuDgyozsVKoP+r2r/TFQEqfVWcuvAdYl5+pF3dyJRoM0eLc68Q4GZNpPEQzAY50/C8=@vger.kernel.org, AJvYcCVaC+GIZlYPo1fj77tiIgTOWe7m3GnlPYHBnV9SoJvebWLdP55bCNl4XvJnV7y22ODf9jXo9qiXuddSYg==@vger.kernel.org, AJvYcCW4UkMVI/DX0919rgU35cqLrN1mOn0xj10+ThEUdAwgarRuSIxRbV194mBDOPVSgP1wVmFw5LNTGfqNoRqOSMhyYX4=@vger.kernel.org, AJvYcCWDOn1T62qWCAuYUgz8XhKoBfk0MhRca5Lf8B885LYl2eus2KRjyjJm11mE7c9cU3O4/HNpaYx/Tn53wqc=@vger.kernel.org, AJvYcCWJAPnyxr+wnsQFx1LXvzujkkNr6AoAxZpglc1C19+fwbYBILiUAr5CEAeJoPvIZBYlBXfkusPhSvU=@vger.kernel.org, AJvYcCWPKY7XztBS+Mwn1+cSjSBWsLf0SRL/x98LbxBATOA1pZggnmXeemr1otsGLkMHKJNMVoaAl18tr5KS+g==@vger.kernel.org, AJvYcCWc7HvXWqRbW2gnzN4lai97tRILOxUePY+lutrboa9t8rv8fiI2iAsz+nxrew7/+HGvfmxdKnxh+y4R@vger.kernel.org, AJvYcCWj9wYeqnXKC1iAK1IWnjcD0bKkotlmAIqBcEH16682u1ma03XsgI7up/IzL0W3sHBerf4I6Mr1@vger.kernel.org, AJvYcCXVyRp3ORlL0By53RFzjPdxkWHnZzkjviwcoVXDXXBobJwSkq0R6mG5B5Uy1u4fexy3mgjUYZYfi2dHaQ==@vger.kernel.org, AJvYcCXVzR9WMPT1QMRX1bqa
 OKcuecjo8WHUnTObHRfSDfIqU5w3OHwFGQ+pyYhQzDdC0LC8RVslDjlxB5Qm@vger.kernel.org, AJvYcCXuv/BAAvrWqv2ZIYRYYpw90Xn3qpfaTZiiVl5JThkbcsreGYhyzx4+FVHyNr70D+hNhMeP14aXMQIGLGA=@vger.kernel.org, AJvYcCXx5gP86Pxtgt0gvzNY7PmHSUNzMumkoXG8Wsn/39eQTELppwkZVXZohf9X2BuB/wKRHrLvMGImWDcK@vger.kernel.org
X-Gm-Message-State: AOJu0YwnuL1HMScrS1COxILN5Xb5UghtewXF/LUgky7Uj17Ca6IiJ9yL
	BblT+aPx/m82I6haN3+gw+9JYbQo+RKOz1fx/iCKCt/we//bwtkF
X-Google-Smtp-Source: AGHT+IH1dYShmg3VURhuaGr8WaSbo6ZEFZNEbAO/yV55rO/9BO/MX7uGFNaY7Xd4KHKg3FxRTOQbIg==
X-Received: by 2002:a2e:4c0a:0:b0:2f6:4f17:aeaf with SMTP id 38308e7fff4ca-2fc9d586fc6mr25952711fa.45.1729796859625;
        Thu, 24 Oct 2024 12:07:39 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad4b773sm14576961fa.15.2024.10.24.12.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:37 -0700 (PDT)
From: Russian Troll Factory No287721318910032309081113513943682726499271761791820951281951436454832220155122863228825355525167129912573205532461224992759424873 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:07:34 +0300
Message-ID: <20241024190734.14453-1-vladimirputin693389@gmail.com>
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




