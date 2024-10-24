Return-Path: <dmaengine+bounces-3540-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D26B99AF1FD
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925C62882CA
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54E821948A;
	Thu, 24 Oct 2024 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL9eNRR+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44669218D92;
	Thu, 24 Oct 2024 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796962; cv=none; b=jvmWNQtGIXc84ntp8cx2I2u9RDWOT+hxRYpV0vvIiI4yfDIcePzSWB7xbJEmoKxYW7ClJAMxOunYcXvEsxmIbdzYcsR2QHdQ7sGapPBmu9Y8GkemNeycguY7Ot9mM0EKucOWTZ/0TfbNVbMJXcl/kY8HRB+AqlRAZ+r1xHXN9N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796962; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ButzA6QMK15AsZ4ux1pSOLVXwdobBbPix6uGWO7brQ3kOnbhX1qlEpl6361fJ6w0aGsUk93u4SkXm2Ir3un7LA3bfBhXRrmxmlymQCXghLWqfJiqQH3UWbi9sT79uLq0bdkqUN51vDC0GAg/TztnCoxj2UJksX5tS8T0HQFLPyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL9eNRR+; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so21583791fa.1;
        Thu, 24 Oct 2024 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796957; x=1730401757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=HL9eNRR+GoXQFxT4aRqDlXaSjGA/ic1cqjBYLRcWbgYSjT3bsufP1BE8L/FZm+lo8T
         inbTujprBfGXlt1eY1re9LXlIkCk+qhG9sh8BDrzuzPC2HuHrpTQNFgcl6wN2zAzFu2y
         R+vW0uybagRtFSONX+YAFZPENZYaTl2A3uKT108/WYWR3hDCaT0sOedz4CMcN65n/vY1
         V+Kfvhdft7AJSwN/sZITWQTeCcuidmc1ctD1PSHT+WZDWgN3RIfbDh4jfjBNS2ZwuaVv
         NUUcYmzHZMYr+sL7NOkZVXPt8aUaxZ6dtb3S8V7pQC8Zhaq4TlFQs9RbbO7w5dkc12mL
         qPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796957; x=1730401757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=sSNjDJvCKIgzWfpym23L/Fb7qHAHoks5HNeesqJWPFgoHUzIJ4ux88ZM61jjTA9/Xx
         /ukV+GmH29NOkDaWA6riM7KDpOFLVEgs+vOAsqOx9dgcWIIhKURtNc+z1qF0vC0Fp4rr
         qNxR7ROsof5mV56/Zroo+abN/2d6g0uianvEvDrqY8gK5RrkMRfukh4n4tET9meVuC9C
         FHUEFv3I5KBEAvf2rioO9SqN6rgDH7gNhvDxlwpQU1HoLJ0sZH0/r6raUErOw9QM5F83
         GWfkIXpGWnhDz9FbQWuXUyToIqqCvuroQHBT1ZO1GEDRx+zLM6Jl8MYuEwYNwbKhNOmn
         4pUg==
X-Forwarded-Encrypted: i=1; AJvYcCU4K/su1hfMSJG9vMdhVmx+mqWAbko1f6SjDsjN5THUBkYm4uvIhLeAvGeiYoU+LN4s/cnd+HOhbadV@vger.kernel.org, AJvYcCUFKiJpwAptaTtvxEuTnBctaGt8P+kvnETroCikZjMC1tobvFwqYEwKowipgrIiDhEmmxHhBUmYRvETMDU=@vger.kernel.org, AJvYcCUGfGQ1uOdQZcX9oPTQ7H6C08IBzlyiT2X9Co5Gi8KRTB8KW9Un3QEscuenmzhMzLV/l0FJwlPDIq3sCiM=@vger.kernel.org, AJvYcCUWjJTlBNKhcXGJTZYmbbln/3M1jkv0xlVCDU87rRJAG5pkuXRJtGXsRpgm4KhlBkGHzTPBmvCNiJlS1Q==@vger.kernel.org, AJvYcCVGyvVQUrnm/3WQjYY5m3R4UNPs5OXE3yglMV98JVy8mdVH5RPHNsi7nr5TWgPn7wd/kyuLxqDoTkvFGQ==@vger.kernel.org, AJvYcCVlK6vHGuwWhKZ6MhRP80BlwGp2Vbfs8Q2S9J/O8pTf/dWH9HZY6S+Jwcbjck7M8YVaIWXVST7hI+Cq@vger.kernel.org, AJvYcCWj0786XFTlsy2iUPiX876PCmLGwZTcC+kCuzOVigs40L2qlqLlrawvapBMlRBu637uQXES2Z1GLWbiFTY=@vger.kernel.org, AJvYcCWkqg/WhWjT8AkoCf18CXWLxeYiaIpZ3fUbqvGV34fOrU8d/NRRa+KeEZ7O9YklvMywwf74wYVi4VKHOM2OrzmiyBE=@vger.kernel.org, AJvYcCWo6TxK6tZmrfTEi3Zmirib0VPTugBYf/k1rxTgLesYNh5TC17VcvrXL3jW7tpAlWg7BFWo0/8w@vger.kernel.org, AJvYcCWpqdwALyL1YjVJmAsZ
 mZCywxOIhXStFeGvZfhMhts1xBNqO2aL7Zz7hfnKTgpeIGNEALvwlEXdkzv7TA==@vger.kernel.org, AJvYcCX9QS0fNr8zI6U3UlNPV4voV65yBhbfzIL+LbnmFWKVDnpya2AevjUzfhm8WpAFtTqnOeZ25x7422dN@vger.kernel.org, AJvYcCXAFB1mXv6/a/0c17tDFazMXtTv0yc8gUoPKK3Wdh/mKPx9Y/65MO5u2FhSGDa6VSP7nqU3TyljlSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDX+iili6b1FalBI2gXsNviokRdxg56gbVI7+4Gp3d9DQqy1T4
	gEdX0EdZZu67vDllE+Zom0yR3Ma5v9LNfvc3Tzs5n+JU1lxTr6TnRxXFIzdPI7A=
X-Google-Smtp-Source: AGHT+IHIvORyoN6XU1l7elSbrDnjhwRR6z/Ojd3j4qtJQTUT7JoEUEPyy4VNvNp8R204wmdDHX2+Lw==
X-Received: by 2002:a05:651c:19a3:b0:2fb:5bd1:c293 with SMTP id 38308e7fff4ca-2fca8365ee0mr13762991fa.21.1729796957173;
        Thu, 24 Oct 2024 12:09:17 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9adf7bb6sm14733071fa.90.2024.10.24.12.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:09:15 -0700 (PDT)
From: Russian Troll Factory No1536239842895262931225811575185472591149412074612914204882687495714634103492751930559223641220723968220682072022693143133166911303 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:09:11 +0300
Message-ID: <20241024190911.14739-1-vladimirputin693389@gmail.com>
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




