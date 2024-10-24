Return-Path: <dmaengine+bounces-3535-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3979AF1B8
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5241C1C2308E
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AFF227362;
	Thu, 24 Oct 2024 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR0FT9Xi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E143218D60;
	Thu, 24 Oct 2024 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796933; cv=none; b=PDcsrrMam+Bq88zS1l1y8me1xCN3sAG5ckoWsojKzVRePLCvhC2nsYQJFTUeLanj8dPte2pz5F7qmx4r8quqEhzKqN+BZj5ZEypptD+7z31HHD5u2vt6Y/Tacns9rxm7FrMlLC9angIPqXbvxeJNdmLNOT+mKWDAAJlDZnWRPHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796933; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVQ4PRECqw2hNfX96SNO4NDV0VHEpYAY7IqUJvhHoI61m77sg8nq4qnBBrxUdP5hsOsWJ6OERHBomjWo+rGwe8jj/iw0bo/tr8uAIH2nIqbsjvdeH7YB4jFF8POEFEQhDVLQvOMjDXWTSAca8hjJK+SOQesiSko1HoH7KHZIgz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR0FT9Xi; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-539ee1acb86so1486516e87.0;
        Thu, 24 Oct 2024 12:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796929; x=1730401729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=lR0FT9Xikj+QsnpK4AaZ6MLAgVm1ipv3Sc1D0dvIiXgbxM24vdzBtl2Pn1yCm9OiqF
         on0MDLqa3PU113C853/J+vhYZq9EhC64l/86TBDT/qWrFDP6wfZVbqsx/bxFi3GCLSrO
         hYULUFSvM5vbA0mBvQ5/m5bYaKszinTjx0dmWl0T8ZQOMVXzSJEHbzXNPDYxjwCUaqKB
         LggKypTDdwZswoK4bppxfAwyeQk8ePoRTfy7PEH0FRdHmg9BbfWp08FxP8aVUUpq7IA4
         fdBwQEfX99SNqH2G5jG4FmRRzumSgFtjB86S18jSBUothb8ZFKSrLDWwiwYAUWZsQUQj
         E3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796929; x=1730401729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=dwPT1pjq2IZgMAkG8jWtULVRiA2LL5eJce/PnO9a+hrC3EbSWCfagvrMJQZSzhPGjl
         ong2AiNJ7EjSt06PqzUgw0Cb9GbbdrAyhN6S+oiXOzxdu5r8WjA6U6hbUnJvDon/JSgX
         O04Mw0HsCHH6uKgiDL85UHt0mEMFiFC8NKq4KW48zbhk7810YEERw76jhNjR5W8Ggo4j
         lfBfWLw6cari/xnPWmegDTsleV5qNaEIYeR8tlm3ycl9/gEASiF4e7sjO7UpMlGTcUb+
         p48khWV82q8HKzZsMxF7NaOzn92IoLRbRRtzF0/issJZHqwhPXthKHPfyhg3/z6T0l3Z
         6M+w==
X-Forwarded-Encrypted: i=1; AJvYcCULOZkZSPEknxWBvXbOMXxhQk/Y9ulukkMOywuT1Dd/TjNyK/r6EHa77LrFJv6+CAFNj4L5/BrU@vger.kernel.org, AJvYcCUqN3yNCQlHY2AQ9lCD0hQnnosbi5q8k4wK+WuzUJVBopYcJT3h90D0Zs7joXxGs8cc+9Z190vKoQ3VhSw=@vger.kernel.org, AJvYcCVvG1tEE7uxYDIxMdgMJr/F7pgxm48MkB4uRXCpdeLSl4YXEpLvNpHu8hzS0DacD1CEcWPpSEvAUpAJDs4=@vger.kernel.org, AJvYcCVzEwM6gPjAdTLvPo+t3uecRclbXYJwtG8SS1hZ5YNjcWB7+7fQ7cvYJdvpjwRJCTu41wo4X4QwjkwxqSJDU0JIx8Y=@vger.kernel.org, AJvYcCW8irpkw23Mq3W43POjZ7++P9AQyeTAsI1AEyCiW/HLWawSaYHG+U66EgnzSh1qP2nVDEsNJ0DuGBpwR2Y=@vger.kernel.org, AJvYcCWGujSYbIzqPhvSyPEMx34wjARt/u+q+muzcm1CNJcSfkbnrqYbsaLesx7NxSdB+mDyfGP4fFlixTs=@vger.kernel.org, AJvYcCWa1Pir1lvUU6V1QTzwO5P7vwxEw7v1wXywha5kfHeA/NDS+u6ux3//AQSvKNpJdqIYVToNiW8r66cl@vger.kernel.org, AJvYcCWp5k0ZDqUWjIsnKsDw7cpW87ejkFmbNJazFCET5IIQJFsT1TCbaGuZ1ao0OXaKpWyFxGGMJuIOx/i7@vger.kernel.org, AJvYcCX05uqPftUYCydhxmKXJ0OP6T8bwQsGOw7GiEIGnUvfodbtbuODtDa46sEo5lDNFA7pGiVSKdji9oR1zQ==@vger.kernel.org, AJvYcCX6SyKVsu0jc6uNejwK1YgQ
 1qdg4bx7cpKelBhNtf6aJfpJU/jUhVEaHi+ytERhe7Wcfop96hoxVGQS+w==@vger.kernel.org, AJvYcCXO0EKNBPGO185uukr5Rg7OcfAt1mVWILkc7ovhiaWFUF0VP/ZvAtuUKp5uTrOIWcFpUd42uiwL4Sf/og==@vger.kernel.org, AJvYcCXXeuXfFH5KNRKUFoQfi1zlZLyPoY7n4jB7Vmgriwia8jsBex7ctwncxDndJ+6WsGW/aAF0DkBfgIzV@vger.kernel.org
X-Gm-Message-State: AOJu0YyaV4ymnT0lyo5filDDWKcZk1seOLXU9SId6lExljHSGcCUaBM8
	hRDzM/ck7mWhI9koIxWeGrfIsQui/55EZK31rpAA+c0OfZCs8HQR
X-Google-Smtp-Source: AGHT+IEMz9jtbC6+viMlmY/Ggljr2ej6XpVNeGcqNNgqxCAKyBZW8ov2pI7PbnexGkwwYFZ1Dcd1yA==
X-Received: by 2002:a05:6512:304d:b0:539:8fcd:51f with SMTP id 2adb3069b0e04-53b1a311362mr4110708e87.30.1729796929262;
        Thu, 24 Oct 2024 12:08:49 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22420160sm1445248e87.128.2024.10.24.12.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:08:47 -0700 (PDT)
From: Russian Troll Factory No263382801613128241581220920799267751828717445239952613442103093227910004286843140521447116461243919301298201212910162126670027636 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:08:44 +0300
Message-ID: <20241024190844.14673-1-vladimirputin693389@gmail.com>
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




