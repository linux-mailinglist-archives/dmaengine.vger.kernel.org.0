Return-Path: <dmaengine+bounces-3522-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661839AF10F
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25605282D28
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E81D21A706;
	Thu, 24 Oct 2024 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZO+GaI0I"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C1C2178F2;
	Thu, 24 Oct 2024 19:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796876; cv=none; b=WMvmU5dLzG+HG1ZoMTqgRMOe3vBpxVZ+SEFGFceht5PjulKzBln9HY9s64oeQKRf+4cZ2pyOuENLJbS+MIi31asXMOn1bsefwb8knElCmOfgkms2pHpmyYcgmDEmZxT0HQxRs0QhY3Aw1I78Ugg/JlNh5DBw3x+o66TBx3zRZgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796876; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpNdzZm42jar/bSLhq7RrloT9Sriv4SW4AgRYOSDB0RhX2AF1Dt1Y33HG4r6DbWPrCia2gYaorm61At92DNQNPLZcdT2q9nAUvlrUrgl/0+YZ2m/kwRBDbDDyTAQsHOGYlzhm4cnqx4pX1KDL4ORPuQd9ZwSFJDZNc5pWKSRk1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZO+GaI0I; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-539d9fffea1so1193354e87.2;
        Thu, 24 Oct 2024 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796872; x=1730401672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=ZO+GaI0Igh56FyYNj8Vq2KFhIfFWxfdbfL098V9hH851wkjHoWFbQcPPAxGvr6tXxL
         T7CQ2jN2mapJuWyp8xo+alOQmByHow1GtHsAUy2/Ne6y+XnVKqK/rnk7bLw0QoSG0dgV
         vrJXrdMt29Mg8qF1xi2gutZ6kOZpCsZVzp1h/7UPw3elhbtX+Uh5Zwyt2av/PQOVc41n
         geB1+HD4Fs5MgSvV2Pb1x99s2QWw/UEDt1m2U2syGM1zlqfoUNFmvlW4BhSdXIpU2ore
         E2tt/0bIX2GsBiNjE015EnJcAfN1Z6YJeUgdBpwtME1NgnjdYva6xRiswBXFopA1jIuG
         DNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796872; x=1730401672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=LFGLcanXsy5mCfDbbYm9xZ70EF+Coz6p3HMCT883eSdWMRL1EZvw63jwAfbC7yzaC2
         1sKUz7Y4A9Qn0+ocyE+RZ5UhzHhiHPIHCzcR89uyZvu/Mi4rr4L47qncOhrMSRy2wI6f
         MLgp99MLTTWHoyy6zScktMr10erD+K+BCcP048h+YbhrG+grVcMx+umSclz7ud58ooes
         QPtl1Z90PAPVbVQc0teFHunAnJPvxnE5nWfYtsvLMbXhq3tLf6DMkehjYR7v/xxiiNWg
         9RKVckFaovxGUYGHi2NffEjxCp9VsY3Vh3snvMq99VW9gy4ZMTPjQACw1thExgDsKzz8
         SfTA==
X-Forwarded-Encrypted: i=1; AJvYcCUBONNoKTj4/RJ8r2tcaHSUdQJPVyk0M3XEhRjfOhaoJQ4yg7hhL4J3BAO1D0m00udITITdIWSjyVhcKbk=@vger.kernel.org, AJvYcCUNdE5Lp5egtyct66iok8W5in0W1XxURDf2Su78lZGB10xz1NiTxTAPWTSmxAfk9eWei5kk0xYjT6E=@vger.kernel.org, AJvYcCUiwUMOHoSi1zR9/LujxaHIrnvmjieyCYO5XCKDoXanRhZ57W/lAndghOwvmS8PN/7jY6uHzLqupLNL@vger.kernel.org, AJvYcCUtMXP5SznqGWK5p/ys1YyJm/UbIPwSJ0Xnp3BvnCttbTu0+ZAsrnhln69169YDHIlIj3dz1rKahkTuwWU=@vger.kernel.org, AJvYcCVK2hhDtQ3cQ1w1cCCF0TPUiHHJCm7SS3aV/CUNOVAnkQb7oYLqqGVyrLjgnGzErUt5VMxP16MHqG4GWQ==@vger.kernel.org, AJvYcCVYCy4zi6NGqZ0Le7toWpDegtBidE0/SB/5rAGS2fdo1xG0gA0Fi2/UAAye7Xj/bonqXfx6SDcO@vger.kernel.org, AJvYcCWA4aTiTLE3wQTagGj9m3RiETo6VgnQvwdJ6yOCbt7g5WR/M7VJ4AdqsNrmKDOFKZtnvD4x9te4jjxM0fI=@vger.kernel.org, AJvYcCX5guDXI3+gx2Hc19GlhPm+pE3/8PQKmI557BfztPIbJjBQ5KJW488USN4cabZhfartzx2OBH6kMnUda4hKlDQOHeg=@vger.kernel.org, AJvYcCXXFOH96kxYRhAUfX1qn4eOU21N/3sMd7y5rCg1uUllxmbF7H8GJ11JfqzqqG8FONZ3VkzctymTckvC@vger.kernel.org, AJvYcCXYHsjh2R59NMEe/CG8etcN
 0dD4FOVXNFpJcpxbqDPCK0ItvjS+4QKBmw3iLHiNO+XLA8CgPJWR1IzTLQ==@vger.kernel.org, AJvYcCXYXX+ToLPBkKZ1/Slt04sjB9BMN9wf+Wh1hvkPrkhPZfCFk6/XrOl98EP8IduFHGsFbIKGKthmk+c0@vger.kernel.org, AJvYcCXapgKrUCgPcd08bCfpLRAMGu2mDiw/uGU63Do5ia/nZGiZ5YybecBbfF1RpGk1jYsWiCuTO3z9zxT9Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0H+UEpUDt16R4pENfNYveG3HJ6XXP99+uuQGgZLNc3pjQMuFk
	Nvg3Ccbp3BhoB209gAyPJcB+hFSDKh28hnlCQzPVI4POcw19ywSH
X-Google-Smtp-Source: AGHT+IHjKk+UN3M8XE+ZR3doJUVJrXX+ehtkxgY9Dru+lcfi++/p9yTG3cAHkgz7LYXHhXAo5N0+Rw==
X-Received: by 2002:a05:6512:224e:b0:539:f4a6:ef4b with SMTP id 2adb3069b0e04-53b23e9d776mr2242645e87.55.1729796871781;
        Thu, 24 Oct 2024 12:07:51 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e5874sm1463103e87.43.2024.10.24.12.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:50 -0700 (PDT)
From: Russian Troll Factory No6049212961557023367288726997179212728420815175652006210532816246372233429930783910156192832738213244323722258626768190012801429625 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:07:45 +0300
Message-ID: <20241024190745.14486-1-vladimirputin693389@gmail.com>
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




