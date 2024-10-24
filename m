Return-Path: <dmaengine+bounces-3529-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688149AF16C
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255DA285A65
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EBF21D173;
	Thu, 24 Oct 2024 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGGs/eZj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D0821C161;
	Thu, 24 Oct 2024 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796906; cv=none; b=kBy/43/oVaKHg6gugADIlg4cEyYXeS6oosNymCrWzSV2lWErXNYdtOY2gKiXt43piPFbv9OsrHkYutSUdH7TE4x1d15C0rLmiM3j0vvjGYXH3FSxwmu2p4jDWL9diQ+LiPlqh1nZtvaWqpdHx6pS3SiRLitR+ZNpD7p5NcHqEw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796906; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9T730rYV9AHo1wHnKmJ2DYJLk2HjRpwsUnPyWYdflOxMXJB+YFgQ42kTh4dryMsXHwP5+w70/r4Xt7cDdghIuzJaAgaDOZxeOF6Lf/QUtFLbVzAWRuXzsNraNHeyz3dDzgTc+gEBO77iWwNN2ft3AhVo8oBNJaqA8beWfOi1iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGGs/eZj; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2fb518014b9so10864761fa.3;
        Thu, 24 Oct 2024 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796902; x=1730401702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=eGGs/eZjG8W5AQih68Yvgv+vpsXPQ5rsuHEdhTRe2ARefJBFi9onxjoY8KxDJ1EQjB
         4n5vKXku3sDWu2iudqN+mHWvQPORIoln/z9IHxVun6W+YtlcvbihIBDovg8LT6RfXBFD
         A3nXckmSssElsfzaeUKdrPI6mWuzjXjNxMOPol7tEKez8U6+2dTs1S/sGIQaK0z26nSz
         r5Yak+I+cDqhbL6TqoH269U9C82sWt//4xwE5VijvSYaUK9AxdS+IqV9zkCw0fmLxaWp
         r+woXGfnCgT2GAtsYiL0kefO4F+4jPX8/ZTm9DA778sTB19l8kQJlpzL56u7/kWdvnA/
         uFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796902; x=1730401702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=EdPYNa1xiofh9fHRbh2X9PIA7c8xu/RNzYjc41BsXxKyaDjwVqDKlxiIsSuAG4h70h
         vi+fCZGI0ysPt1ZTipmOdlMPYe50OSaOfWDWZF60NtoYLpwan8iDHId7j9h9tyejnV1S
         do3kmLI0KthMI3aeYO9lKeFGplI3n4kS5iuOGsC1oWNuqzc5VolgrPH/ff+G3mgpJcs5
         WYOh4MaWZ5lysRVKJRkgVB5qmrZrzYDuifJT/dZMN+l89ex2W3sTnEnLiVC4QHbLOSFP
         O2Qlp2gU4e6DhjWTTp0pNY9opRTiu9ck1wJitKfb9+NjLLuEAeKWC0jM81085C1A9J97
         jiNg==
X-Forwarded-Encrypted: i=1; AJvYcCU2FeZR9ws6ChMhEzuKY34IAwsY5/K6Ab+Yu3UEUzqcj0zyea/mmqS1KQpAdXe0IPrFRyv9PlStG10L@vger.kernel.org, AJvYcCUO7xtobBuLAYFJq1mAkkM161EPFVjGfUEyh/tHSL/6Ryf8j2qn4kTrXuk4S6PNBQ1YhP+5OWp54ooj@vger.kernel.org, AJvYcCUx6JtcKNNzXjpaGT7wxW5aOtf21O1BvJCh/uayU1vScSQZunWeBXnAvdtpAxA2KjPa/L+nAYJrbhMZFA==@vger.kernel.org, AJvYcCV8upzloImB1ouWCtOf6JPF6XI3Z99pr89VEq0x4fCGHyxluJVvdx10RcVEIZ9Xj7DU2mLtVA1XhmGMUJg=@vger.kernel.org, AJvYcCVEQu78QUXnTd6842nfk2gsBW2+ZFd8sl7Nn45QnLVJ5BBykni5cL8Wh5BjuZaCWPI96FBiaqorucCG@vger.kernel.org, AJvYcCVdMXI52jmUsJJsrCgko5YPsbYM/Bzp6DRRChqevfvV5QFPX8gaaDru340dfL8wKgzjkJStJEkzYvI=@vger.kernel.org, AJvYcCWNqjnh8TplSkP4PHGlEi5cTdIcIFQ304dScE6a/3x1Ltw1JzMKLYl4CrakVMa7GUMPGt+taMT2tbTrd6gWPqA/MeE=@vger.kernel.org, AJvYcCWdcoXJR/Der9uSN3WShUXpjQurEjx2ZhZCBmX39PkQv1tbgxes+nYd9ASMQSD1tktOWTZmGnHjGPrOsSY=@vger.kernel.org, AJvYcCX3L9dDNY28nSH6Alk64FpKIPIoBtLCOV8eG/ClotzKFzUS7ET/bt+ooQYQIZJY78sHRWD19vZEsc2hOeU=@vger.kernel.org, AJvYcCXAXihVIhUKUx0bN9fX
 JhBs4vzHEEtx3SJNH+vsoHwTlYoADWGwvlvMyPI3x/9cB1JrlugAogI1QKQIYg==@vger.kernel.org, AJvYcCXZCJQWyMd8BfckMsw16kLIGjo8M5E6tlE1W/4uGZ1SPIfcW4Hgy310uCGtsnQhC7PsFg3VxXbs@vger.kernel.org, AJvYcCXZn56mpJCsamanufUrZdg1R4RRYSKiEo9wiGesy57Jq9IxN3nGG2UbiEKEhJ0Z/GHHL3SeT4bm6/+lYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMwGH74Qb5HqRK1GgjbO2RdXf5MoV8d3wFx0uSqIIxT4iqad3E
	uO6zU98PX3daBGN8YusvLnSaSK51LHQJSywLQtkB4fII50dWuqR4
X-Google-Smtp-Source: AGHT+IFmDZ2JhcZ3tha6HvlLLHh7BbRawMQnzNCphMWrpPiBO9mRwld++lU/zgFixT6NRrmJ0kqlaw==
X-Received: by 2002:a2e:701:0:b0:2fb:607b:4cde with SMTP id 38308e7fff4ca-2fca8277985mr15204801fa.39.1729796901668;
        Thu, 24 Oct 2024 12:08:21 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9adf845esm14300871fa.85.2024.10.24.12.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:08:19 -0700 (PDT)
From: Russian Troll Factory No1072927230971227864746261252257929144161832119427680493412026249156751791411748303808449140682386715963223892737228046176911838 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:08:15 +0300
Message-ID: <20241024190815.14574-1-vladimirputin693389@gmail.com>
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




