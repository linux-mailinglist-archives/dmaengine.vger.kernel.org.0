Return-Path: <dmaengine+bounces-3520-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E5E9AF0F6
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 599EDB2298F
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773492178E4;
	Thu, 24 Oct 2024 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5n6anpp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABE6219CA1;
	Thu, 24 Oct 2024 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796868; cv=none; b=lydqxKnClVHICHbNlIE2IUHs9Fz2N3jpNNAHdCPDDTu7Ks9SuYQxPXAUEQcjltxlY/8O6R99FcxMTr5A9/MxSb9k11GvI0yYspFk8O7qdpZd/ywxeSIns1MurnbFiGVueRG7WaMHxhw8NTvDado6AWF3FSPIevq2EhhjrnDG6PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796868; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZ8p8uw1spkun78JpYCobgyPjQo/DEjBuj9D6Le51l9Ll6XSw/72UQdFibRMGLKbBHGFWtquy0DqT6iboXFkqf9XZ7L+ydWHAYbE81v3aMrqDg8dWWS0d5MILsVp4/1J5yDPREJEui8OxA/EO/l1laOaDfKFqxKObzqoifQgB/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5n6anpp; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so1644293e87.1;
        Thu, 24 Oct 2024 12:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796864; x=1730401664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=T5n6anppe1qRzM6zgxioX1oaEVPG811blDfe86TZfE5BnyX25k4N2mMeakKCRKcwVV
         HyPLfCuk1q0sHVKJ5UvLaCiYXr8xdCHtyQOJD12uz+5hVhrroofTz16dlUo9SAfvGyPm
         Exwfi76aBorXKa6Ao9tcTnmUOkD/GZuqqK7WmNXx9GwwzGCSuaH+VKskoPr4z/ZRjO3X
         yB0YZFcXjlI5jQiTSh2OKdGo41yvxJNjCtaOGZtramvON8AOYbjoNxyZqCbqyJl/9hVK
         XqHV9YKkRdC6OWFzR4Gdt1/3xWBRqm2WmwZfmQNDAr0TEAT6c3R8MDFoCIQbpUXRFwSG
         Qrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796864; x=1730401664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=b3kjr2ccMelwG5szYAlPVxRV+0nYGCdHFVJLuCtY22B59oRLqoq7WmDpPvRKJPdM7z
         Dzrsh/oXChQfOPp9Gsnqr3rw8Xne5YWZoxBg45fQ+W4kmMn6kH3g5VoDSoS688r9pR1J
         7BB4bITRqyygrAVaQHW8DcHTlWl3viYV7GgXPVPXXlau1/5gks2JjC9l9FCUbDaI+xwG
         NcN2ubJcZtowKGXWpUrsxFA9/yPPgJ96TRMF3XR6YbDXzB2I5/wArO7U0EQguvO/erMI
         zYnidRcKLTiPcZoqTFuN6OfiCR8qRG0M4ad1zh6WBD+b6rJQIviLswas/TI4OAW7ewkZ
         puXg==
X-Forwarded-Encrypted: i=1; AJvYcCUKZrwNJ1Joi6s0DaMGA7SZmVSf/vwbKYMrXE19qe5CC6REUPIfKX5F8HSYjBwDWyYgqISb6k7tLmI=@vger.kernel.org, AJvYcCUZV5x75D2abwp8KByy6qTQ+PmJX1foonETVMPFTkR5LN5rpN5LuLEIbYuGQ1rPfTH5sABHR+iJF6Tc//nrzWB6qwM=@vger.kernel.org, AJvYcCUi5rNv9ns8Ebinep/C3jW+3i4Djd4uXj1gRZTJN8bAzhoLjrdoTIVQJKvJ/x0PjKrpNTh3nw1ee2vjXA==@vger.kernel.org, AJvYcCVsq1f+dKUce6eqkCC75GxYPQYgCwY//Xs9eBFNWqlFKluuqL5VB1gklHsVJRwBMd/cAR4qCHmwIppMYak=@vger.kernel.org, AJvYcCW0MPz/etUxcgGvYzvzQ/6oRv2x0Xhlhjjum4khe7YF2fnVPl0yzHPAvZXuI88WcttnddpFSxgBN+Pj3Yc=@vger.kernel.org, AJvYcCWJi4OTFAcXJ8r6KJ7iRh+926qa3u/XIlshlkGEfO1e6YRu4UbYGDx5Cq+W2PFIbFanbq6+ZeYlewnD@vger.kernel.org, AJvYcCWbhRY7JBPSLhVi1462xdzG/G+N2lzoqwH9+z5TIr8Co8RSfVI/RRQx+e8R5Rlm5piZnz4p0q1w+rSZ@vger.kernel.org, AJvYcCWgLyUWJvPakKv/uWOx2PjM72klWD+uxJjAEFrELdo71EFKxfVQ9S/PZUwzoDcojhE6kkdo1tER@vger.kernel.org, AJvYcCWrQ9Nz5nBMiY/LdFQ0k1ibRadi5pTUlOHaZleXu41VAfJCdR6SJQTCvlR6hcLtpaMlcrCjnHMuSaTsMA==@vger.kernel.org, AJvYcCX9Qf0Ybw7+8FTBgSe14E/f
 59kgqJ/Ksyo1v+HNd6PXiKw3e3sDTfn2Tzecb6mtiD3oZZabAmyr6GYy2dM=@vger.kernel.org, AJvYcCXuKSCerkkI8HiId46+FyOdOIwjJD1FB5V0MrjKH9A6tWs79vxHma9B7vU69nepMA+F1SxrVBelbpcJ5A==@vger.kernel.org, AJvYcCXxX43MUn2loxqdOrQvW35wFduNyJ7LwmbFu92sxW5RvH7GzxyFjMMa7GIe4MTFi+2BJQ5HaanQzzNQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzUiZ9XGyP75RXy9ToykBLfbL5S+73OCEzCvUfIT7A4kM9KGraG
	eM9fzQke/gII50jUyj+ZhoBwOz2r4PMPBbE9NSk7CFlEF0KvbcAi
X-Google-Smtp-Source: AGHT+IHxOSaOyEEIncvwgtooYjQL+YzSfertve5cZWRUaM8tmn9arp/WMamQ6qtbhKKtv7O1oHhIcA==
X-Received: by 2002:a05:6512:334d:b0:53b:27ba:2d11 with SMTP id 2adb3069b0e04-53b27ba2eb0mr1135024e87.16.1729796863870;
        Thu, 24 Oct 2024 12:07:43 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2244043bsm1433052e87.264.2024.10.24.12.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:42 -0700 (PDT)
From: Russian Troll Factory No17826218401105021817842129545381128121753081730610171471353027717322491121330093113273059749101093118488354821189169813209831860 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:07:38 +0300
Message-ID: <20241024190738.14464-1-vladimirputin693389@gmail.com>
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




