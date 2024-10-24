Return-Path: <dmaengine+bounces-3539-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAC39AF1EF
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13D81C23DC1
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8545322910A;
	Thu, 24 Oct 2024 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLZ5xIBF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F367E218D92;
	Thu, 24 Oct 2024 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796957; cv=none; b=cQn0/ePhFizPQvz0Jv30M4PLgPuPlwMAF/YHqYrtRWmv0Mtxi6pbgGciErvK99SOnAq/+2QQwRP/oolImCrMBnhZQp2iHXntYWeJvqyfUsEc/Xwwv+doxHTs9gLEztr6Glt6Dq3YfGTRME6JWz8xoLOtdpNbCmpQeowgBdaz7mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796957; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fG1wzhjZ84GXSJeL7AEEIIihxhOelMaDzoxWKRocCLYtxWoIab1QXv3xvz3MEKSpBrNemqql8X31Y2abHaJfIXOZXUgNJp+j//4x5kKqAWdptbW3i058QtXY7xIzZ19+tyjJ2AfQkJW2K5XzQe7Yi2aMtwCaU+rOXH6t+h8RRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLZ5xIBF; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2fb518014b9so10873431fa.3;
        Thu, 24 Oct 2024 12:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796953; x=1730401753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=fLZ5xIBF/yQXepJH426K6Hy5Y85QeUG2JmT24DLu+ipAciOeZS/992bQDq/FeY39Op
         9EjWuhVZgB94qc4T4wW6hjHFp82IALWu84460c+OhXpSXNoUArTYkO9Cc+XOBzFA5rPY
         Tcng77eAcaQW/2buMw/iuVtp8Zk25CDt8LYIxQyU6LCmb0h/cyyBRWvoFW7e3v9irffc
         qTSBVUbcV42FkvZpG+Qadj/0dK/opOJNaP7QyNFPC4COBd+srij7tICmJVpGc4ZEdLzi
         j2hneiXaraUGd7nSHyx/QStAACOVxkm4tTTzerhsExxifo9vvVXRc4M2L3w8g8F3DiuC
         UeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796953; x=1730401753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=oJWMczRC8LRgy71BvdCk1faor6lvniThe0vcfPstIFboNpXsDMIpYPjX8xzf/unNr2
         UWFPHRkAFmmiaXw2UfgBKWzMj2jV+N1ySbwj0abNW6/PEwownvAaIR47JMUTvwru+kZe
         Uu64MJmrE2nLjv4Rhh5JniTknooiWf42F1l1G5RjMNpi3t/r9XR+2EXj+hjE5HYsXqnS
         dmggpRwh6LWlBKV0+yM8++IsQ8x/hXjV7obwE8NjvS/dg/VccEjcOlTyk0RUodOiENGL
         YO6X7mEueXh8rgM7rS6srp0iTgoZ+tz9NKscIXs/SPLebPsN2+g/a/l8P0+9bmglsIK8
         jRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU08nW7zf0j6CMqd8+XpJiwsPshIjhGKxHPh9FYonnYLnI3hRlo5iPFfHsicsWpygJBxSZ+jqPf@vger.kernel.org, AJvYcCURJ1lnPVzqU1TuLO385dmHU0DBrfoGgnmBERz1rE5T5x7by/qT5GcA08UwTTTYr5H3QSOC6h+9j2VjzA0=@vger.kernel.org, AJvYcCUT6SKLradwfLuew37MHA2MvID2OECr+jvwO+jH3tvMos8axGfySZl1T0PDBNB5Q29hg5HhiKl2PtrptQ==@vger.kernel.org, AJvYcCV2kAUitkSK9QM0DeXiawDMTwsUCIjb1g4hsWlRL12lxCUACWnGD1V5D1ffND4pBQg1I5/KHkWZc9Dt@vger.kernel.org, AJvYcCV8qQfN40BS7nj7xntvRYhT5nRD3R5ZUGmwlLgHyKcqzBdGTrPyH+qiRTSTioECkj4uX93CYH7gBoPs@vger.kernel.org, AJvYcCVJ6Mmn8cTBnwFXWWrMfs/qpAnCuSEtdKFDDHhBKTrfBWN0uSQWKCuwNSXCZr5UI2MHNmM6RUra+elJ3g==@vger.kernel.org, AJvYcCW1hKOpcf8ho1FnMCbHStZquxyUgEfVkxWjNE0LMr4KkL8LV7BHaFKv+Go2Ojnh1giyKN++uq/ryZU=@vger.kernel.org, AJvYcCWQ2Gr9Bjz7b89JHkEad8WwV8xyzSrRAPbyxf0hq9kK+CTdnWNewsACRfZDkcgAOMDFHhKSr5WKPHQGnDc=@vger.kernel.org, AJvYcCWVbEK8J2CVfCF7tAfOzVrcIncpfSbWmMKRkvHIUyv+QmuDlDc8s277ORucSAtCoK7dK+zO5aZxm4Ofz0E=@vger.kernel.org, AJvYcCWxfYo/sTJz19vPEo4IW+E+bYWmqh1z
 OXZpa3GdRVU7q9L39XNB/jW/zYbcmUlPqw0jCilrNuCU0fSQpyP/ft30WLw=@vger.kernel.org, AJvYcCX+yhdAN2Sc8m4pceMDFERGaQYuAkDqgDjoh9OUCkHXKp7m3ZWulXm6EbTUtADi5S6gzzBrst6piRsz@vger.kernel.org, AJvYcCXhkOJHCi8hMkSuF6hJkEDZP7lFVefsRMTf80tsMD0vFcC4pcP4NTWrosb+9cMCCw4fkACb5qIjU1rbaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLT7bJbD2G3usxOkIOZJW/u0u6UrwThbh7HNnfjZRKLy49gdt2
	y8hBMlAk77B38roPhjiWdOVO6STDPkJmAYDMqxG6r1Rud7nb+Q7g
X-Google-Smtp-Source: AGHT+IGWMqP/3q7pBD38OxLdYM5MKcBCWcIRq2EaMPV6hpvi/ZwznCbAsvAtbZfUQzpq1enPtL6YtA==
X-Received: by 2002:a05:651c:2110:b0:2fb:5d8a:4cd3 with SMTP id 38308e7fff4ca-2fca80a72e1mr19996831fa.0.1729796952965;
        Thu, 24 Oct 2024 12:09:12 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9adf84besm14458691fa.86.2024.10.24.12.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:09:11 -0700 (PDT)
From: Russian Troll Factory No41163039818827240705513532026497164262436828500263341650943622628122712578929855268467945401149926696447018832276161779832264 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:09:07 +0300
Message-ID: <20241024190907.14728-1-vladimirputin693389@gmail.com>
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




