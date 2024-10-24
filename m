Return-Path: <dmaengine+bounces-3523-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833129AF11B
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129621F21772
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EC0217903;
	Thu, 24 Oct 2024 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTPICS87"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3742621B424;
	Thu, 24 Oct 2024 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796880; cv=none; b=NVACHYit12kz3q9aQ6MQaN80ONPvmACB74C+2tDnlRDlTu8/So+SW5ls1dBvtbbTHyRfgvKbMjL6NMsj6X15THr3msz+R+UALYkwDvUpGi9d6ZdYx/t+VIRkFhNs7fwEZDhvIV0n45oyOxqHtdh/nCsEEN/3xBMGreo8710hzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796880; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCCTwML6QUIwSqawRdlKVsH3X/+UQ+JHkrjwjrBGG66fAfhOEw9oJ2H96dCQH2gOubvbMJao6/w6FAoBGD/5Vkioy9T1ANZRcsI3ytv/QH7x4IXlcGlRG2wUk1bP96WMnmgCIPF9DVM0L3ci90e//1D7DmRlonnNmYajkeExbgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTPICS87; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so12781561fa.3;
        Thu, 24 Oct 2024 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796876; x=1730401676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=mTPICS87xFwLDavqTZlDqzKwjfHnIA1sOCWDvS8LRS3PGtmCTjV/CrYkN+2zHrsSMG
         Ou5qYHoSSUOXbvaRlW3Yv62Mcf5+Ahm1cyV9W2GSM+4IEOOHyiwLlCh1IKBBAtWoWspe
         6bSSpzXnO8cts/S7zGBJeeqJf3fc0EO4gNyMkQA/i4z4WvRZFuC9mvdw6522R1lmyP59
         O5xtkKYckOWkfTlV1Gzc0Qhk+9k9j0x+DToLP1Rn2WEb3CDkbPZQZTDkL5jaOxAHjEss
         Cm0Q7Xhdt8BeEzBRwm6+cdVFqRlU7HT1v3z3ldo6byOiX9HpuXwsTuRoUvNZO3rUHMQz
         weFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796876; x=1730401676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=Enq4rB85z12PUEWEsDtX6mAcYNRg30NCv03ZBar3moF5VVi1dh8KZc9QKTYRptbQEz
         D8m0ApCeX8Mm8OTgbx7FvO2wmC8K0CyhdsOuycAnn8GF5vRgcauifvckD6fYPveDtEBr
         hwDmeoWKTDlQ28pMAvPCKXpOS/nfxqjcg7Rq/202YUK1wxJ9fA6MOAmrYpoDP7LZYGo2
         GUVbqjOhiG73Pdi/Mzou4d6gUnQ53aesuiX32Lz4Uoy3PIho9kWB3TkXXzpLVf4ef1Oj
         lkrW8jM1162tZ4OI5snK+N5ZhtSeT3NZJxgny6+4gKtNfXTYB4o++f8BvbpBR93so0ym
         zzKg==
X-Forwarded-Encrypted: i=1; AJvYcCUaWRScrD52Yw30iI+MgjuquTXtUCGRWhbqKDod3b061fF+DJ5d41Nw1lOpReM5THtuYDPRYJpz+/MT@vger.kernel.org, AJvYcCV9HmQIcpBlWihLFPuKEobyqwZObU3FCqng53y69RpOx6M2t66/ohiGmTEsybUXPskdMqZfnDas8aQ3Sw==@vger.kernel.org, AJvYcCVPjRD3iHlT9r5W1gBE4ITz4p9ZyjkcH1bBMy2OnZEbM09QZ32cw7sThJ9XfD7WOzPbucfV0hXAlpGL@vger.kernel.org, AJvYcCVYVdmF/giyQYGicg2H/OQnqMQHe0LrgOSHC+PKIPKoqbh6AzQLG7y0IlKima7LTTF2xAzqbw3rzt+sJKn8OrCwtXM=@vger.kernel.org, AJvYcCVi8KhoI8+a7FPIgjnu3TsmvI1VZOllZhfDflLACn7FGAKlKpYdj22MWinS/DG1/KP8PlZk7lx7OTvZ@vger.kernel.org, AJvYcCVpFYJWp2jrQp8n8PcrzyQniFAmd60R/X1LNFN3JSYBIRnAmqpqaN74jCv+tWWlKZoP/wCEYgXtY+N70lk=@vger.kernel.org, AJvYcCVpL1vktkM0A3gQgCS6S3cznCrMNpX2DMtLDLb9OPzO9smTla3RsIJOs1eG+J3wTRibfupozsTsOUNGK7c=@vger.kernel.org, AJvYcCWEfFhPWBRIw/tR3ZzofbCnfsl03aHZyu5l7z9U2jA9Rgp4khHOvf9feKohCDyDZxtbFBEjeF8l@vger.kernel.org, AJvYcCWbNcF3hRy8UU10ZhIxXcnOGmcH1zfDBpP9DXzhYIIFfPf1e6Zyef0UZi9JaQzJT8rZBctaJRlxU2w=@vger.kernel.org, AJvYcCXGtQ+d50sPa8QckzGJ1wBx8p8X
 kxpWh8Q3hYn9aLeglKhF5J2lNp1cY7/8PqCnULS05w98GernfCwCLw==@vger.kernel.org, AJvYcCXLrJnXR8U/Lnv40UI8FbkGPokokCsNkFnALf6UnuzB62Zn/hoywpBDx7CpEesOsNFmOTLILciRCRBDAg==@vger.kernel.org, AJvYcCXddSK89FfW8hBPSYU2hMjeblqS9CHFaeMPiOASDZnrTVH81sLThXqGFAttkMzD7Y4a8wH+C/qgRhFYXa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5OoJ+MJIxdNR40U7cSpcOf/9CLEaYzu6Xm8TEZCl6qIkbl5g
	vTP6LUyka14jTghGKo7RkEwrCYXtMjE0Di5hU9Of9yCvbtPW7waD
X-Google-Smtp-Source: AGHT+IG2Sp06K2mKAyenAsJpShCOOH/ph5/Qb/PGBRPM/RfFUKMaEZPrmzSf6911n/+GmihgJcNHsA==
X-Received: by 2002:a05:6512:3e25:b0:539:f8da:b466 with SMTP id 2adb3069b0e04-53b23dcc442mr2105655e87.11.1729796876146;
        Thu, 24 Oct 2024 12:07:56 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b137a2c9bsm898373e87.101.2024.10.24.12.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:54 -0700 (PDT)
From: Russian Troll Factory No3251214663148522521522520115442277024236842294791806428259808821013261332189610550118606398324732819928675167321449493331773629199 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:07:50 +0300
Message-ID: <20241024190750.14497-1-vladimirputin693389@gmail.com>
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




