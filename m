Return-Path: <dmaengine+bounces-3533-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D04F9AF1A2
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10D71F223C8
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3262621D633;
	Thu, 24 Oct 2024 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUHlmahl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BFA2185A1;
	Thu, 24 Oct 2024 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796924; cv=none; b=cqop8Clbq+yVPR1plw86NOhiOdU9CW9EozW2fnaC0ckIwwi3g5tqSiyw2K/DIj7UqIY4UNUhsuqS5orXGLVZNnFKmwpZG30/R6hxesacmyDEc7jbEFwioHXIkJKn1XUI4MsoiRwfCTbj9lBUb/mAiHbRrU2N3DH66m8yl4ETOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796924; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U15hnI/zUNmFbqake3aL6uR9687OLnG2SfkRPNa4TANvPQYFUlsiISMkD/vd08EgkfOoaKp4+n+KLr7KO0lj+igfnlgztMymgoaM4KRtzVrp+ZBbk9oINuLW4ZfhEMOCShJImraATh3hYAPqQ4ATNNXh1DMChFdP7AWD1SAMlTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUHlmahl; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2fb587d0436so13993441fa.2;
        Thu, 24 Oct 2024 12:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796920; x=1730401720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=HUHlmahlcspzHzA0YicNfXTvDzP/cMkhZ7V0OC91f4SwgBBwVPLyUX1mSqvAzs8wYN
         FIgAkC8cQ0MwA0z3QZgUC9Ok/w3Ck7ZX9eyraKH290MR5teVxKAOJ6IaOb2vuSxK08P3
         TahXgtQvWFbbYTwE105+4lxU7MogDzpgfrH0Zt6gtFp9Zm4zjKPtzF0xv6UQTdP5rLWi
         rkLrCjWNdAd3nyM1yC6mi7VA2Qs99eBZCoW+I8Z9XX+C62qLfHdiX8SynDiC9ibtGq3f
         S2LqT9PYNAA0XBp+to6cVrrw4EFWEOUNrqBhzFl5QRY60Qfaeb6o58SnHFuQPtQMimja
         leLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796920; x=1730401720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=fYOY32HTA5YZSt0LYyjnnQ05HJ+44UesCfNs5yJq1cWefuHafLnVVkaEEy+mFkkQb9
         LXDWdufp+RcCLFpT2CeB+VMFOG/2OWseq1yIF8ZPV4AJMOy209T5GpsEo1d9R4AtISBt
         eNFjOhzpc6hQu+rKn/Yv9TnoVDPpgcxLTGAj2H2/zyc5i1BLDsJ/iD916VMHFWDfyrfB
         zUiTzfz15Igf/okCReLvrFIUH9PwjO5JaQbPJggmXor336LkbujZEX3SIkz04EBzlLKO
         TGMk7TH+YdO34XLUhHQFK1zL45PG/WuWgDO882gZKpjyGzszq9snTVNQnf3aEkzsy6uA
         uWcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5oqVZ5NrBtp2xnSQgOqGOiwfLimpDy6/LXPbhq5UwmWxPvKBWnEBOCpBQNu1f7ka7Cn0YoWoDxyBCA==@vger.kernel.org, AJvYcCUT3wJwzfPc1fnpDgqnSHsEojJIOnYbh7K7H7XKLVaz5S/WeYtUHbV1eHl3dZ+AO63mLFui0uwkUX0=@vger.kernel.org, AJvYcCV/8wxlW9fextIuHg8G7tCnIZ/qkquU5rPKX1+v7pelKRyG2MJUpb5gzI/bO3If7zOf9skQVk7PLewhi1c=@vger.kernel.org, AJvYcCVPCvzfE4aN+p0TU6W4qNXD59wsWzjxwmA94yUpJUu7JGSrXbjlQwu8uiPYvOzhtu5985r8g9Zs@vger.kernel.org, AJvYcCVTGu2yh8GtIeio+kszD1KZHnMM27MTbx3PWjXqU+vb154fYLLQ0ukiryrsY8BzHB1OO3vM9H/KhmIQ@vger.kernel.org, AJvYcCVUfBoJuKnUu2PIP6Hy4KooDVI7aacRAGwaiRAKop3klFkPwNLm35V8SUeeJHbBSsKvypoKoNBusKVf@vger.kernel.org, AJvYcCVjwvprez/47wZ1AvDoIn4rpUqTExaIM0MYNEoqKRYbac/FNCOPcdDLeKienwEjrcgRx+Zfd5Mg4yG6MnM=@vger.kernel.org, AJvYcCWLa0yq+KgfXaiVQhJwncogC89PVNoZqUW7HMtgKh1i4rB5hBLYOW8JdELk3xNOyOURmSLyt3LtLhtLag==@vger.kernel.org, AJvYcCWzgDgJwifGawoeUXFFoo68Xb0l9qBmdQ4NWQSSKE4sqPNULc1QMVVCk94AvxlfEEHrTtYu5SKBIT24Xpw=@vger.kernel.org, AJvYcCXFilOS4Y9AcvxqkRgKxIlAJVvrycP+
 6D/0XqtqTSxE5p4UV8sjIo+SfIdxl2IOpziDD0aiyhHlDlQXZg==@vger.kernel.org, AJvYcCXQzp1KEmO+SX4XQKbh3dWzZZhvP9LlnEHN7MGqdYv1UmCIFXzOnmEOPgDUN/DFCR+15hv0xJI8WRlQDtSrz7554Xo=@vger.kernel.org, AJvYcCXe3M/r3wB6tb7quufLW5mV0b9EKl8orzxJuIXJKMyApWINOZ6m1SkfU+8Ls/p9iMNVL8CSD6Qwp2Ql@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk6gig9Lzj3USJZHzMkAw439d4pfKLWfwDY9xJUDS2aNOJrGcw
	Rtnc0j77XKrBf8HzS10kfwh/3PUp0JcNJPhsYiudo47LStXp14Dz
X-Google-Smtp-Source: AGHT+IH8bezB03w0PK2viRhNxPElxvq8X7G0EZ6wvvjESZTUV3GuWz29aohqdva0QSqQJkEoQxp/SQ==
X-Received: by 2002:a2e:8242:0:b0:2fa:d7bf:6f43 with SMTP id 38308e7fff4ca-2fc9d375eb5mr35740921fa.27.1729796919530;
        Thu, 24 Oct 2024 12:08:39 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad4b697sm14546081fa.12.2024.10.24.12.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:08:37 -0700 (PDT)
From: Russian Troll Factory No224144578241966920156064188199102753442345511660015209216651919775173258737401357233015740549927918214791708113432289353039 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:08:33 +0300
Message-ID: <20241024190833.14629-1-vladimirputin693389@gmail.com>
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




