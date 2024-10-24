Return-Path: <dmaengine+bounces-3545-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41E09AF243
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A4A1C2482F
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2939A3DAC09;
	Thu, 24 Oct 2024 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsFvuXT8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87356217313;
	Thu, 24 Oct 2024 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796981; cv=none; b=urTfHEEy62Y7bNdrbI99UlIdO+PDJ+eld7azbmzgrNaxymy6rOb/Azg6NoTLjNwawohjnlJlAGDO7r69Hp91GVgKkRDesSqPyScXbmWXG6TfJyEFw1vNbZxSJV6GNbbyDjkKyzyNwLygYoaADgyVCkOs0eVWPBFziXipnGv/f1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796981; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQwKObg24rrFvgY9D1+z4siQbWdoNSHPMVPiQdTRv9BDLNPArxrWyNkjqOFiMo6Bx4tEUicKzrrBJVmjX3faPQ7ls4bMW/ppI16veJeCsswSXhszTTi7NUiSyRqbrqqRG0WnawZTJQMYzh0z6HqD03WtaxPLaNKTdWOmP0HCBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsFvuXT8; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso10529421fa.1;
        Thu, 24 Oct 2024 12:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796977; x=1730401777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=fsFvuXT80NI6PPukVBR3fQbAIw2PWJnmswQjIENQ9xj97yJ2cjhWj+5MJg1I8QPrrj
         EMHmk/OW08D9j7tn2tBB/OgTu1MrSJZiME9Mv8Pj5HdDeR+pXnZ35e2mQagXlXvuXPbp
         HpkOnNfQ7mB/kae7Zh10/bglbZMs3dnKJUgAyzlrD5UBd+2YMOopp5nABHKXPwlnySBa
         ARcBbdgYg1n03rLOVjp2PpKEwYLNPGGXACCHQ1ivKlzMPU0p2KDw7ENvA2ToI4tUCxfD
         nSBZEiaddozMr+kXX5/1NZoqXkDfn5K3EUZ1sT49Oj9XKRQIIDE9X2XPIIn+p/UPhUx4
         71Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796977; x=1730401777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=QSpp2qBkgoh8gH68tjQ2dnyn72YaZ51rERoAGxFFCwbVOB6BrWFwQ7XKxxjQiDzP29
         /65UIp+0dx9iOy2qVtht3KeKn9W8A2bBFWfr+zPviGChj/mZZn8Hy/kLRLTljWcOgmn/
         Ttal64s/MoeIAMjVF6gw7B0aY6x2y07U6xCiVCejp2YiXhqaOMoQncaUm11OT7F0St/F
         qRebbHL/a+Vc7wD8tmpfnUhqoAo6LAyKPhIRmQn4dQQGbvhE/HvbucG7Hwbk2FLIhtje
         UD5rf762Y7lKTUcoajs/qw5WxHLDcVB5gYjEULX5HEJYqlmEPgqo8ACLUilduKnyUZ+2
         d0ug==
X-Forwarded-Encrypted: i=1; AJvYcCUQG4QwwPr/RUySIlwogIF390xif4LcjkD6ErL1yGgVYUhoRA3BcBgZdz4bHUcCU0TznEe9KU3fxxQDew==@vger.kernel.org, AJvYcCUVQqGy9IOj4gnZd9c/hPw3DtCi5T+Hj+tULTVLK2MKGcXgCubRg1N4oCfAG5OFQJQuzGuBGzaD3prd73E=@vger.kernel.org, AJvYcCUwwPotPBbtV2FBeMuY91alRamNQAWNUa7fBeOm+QUzWlz/KzLj5hAwzB8br4hnJQ0JK0NlFjDXLnGUQ8k=@vger.kernel.org, AJvYcCV33YSfP9Q6ICGTFw2O5WJ3LFdbJt8y/YE2H3MlN8dPD2DUhl/SO5CYlUbnoFlzVfmeP/geKReguvdXHX0C7bSayTo=@vger.kernel.org, AJvYcCV95+eB+JhF016OxrheTs3J2w/hzxyiVg4uPcMmETBcWdW9U8no/aQ3ZKUz7dHqIbi4B+suE/zt@vger.kernel.org, AJvYcCVRb1ovrXl6q75n64iwigq+xQN+pEAts+M2v5XVImLNEYucRoE99pXpif/fbZZtER5GAvudKS/gYvRhVg==@vger.kernel.org, AJvYcCVhkhmtos193sDP/jnQWOIZu2FoNGvkz2EysfFArs56eCkiQYjqbTxyxOuittOwqxl32oATWL9OSInUtWs=@vger.kernel.org, AJvYcCW5AnB5HqNOgqdIw+NkS1gsgU4BpJ4SKZOMbidHIPTobBSzXnu692m44hIsxWpQd9wF+ZI8Lf/Jz1Df@vger.kernel.org, AJvYcCWBT0ZW0CGJ5uOLEVzCYwewT9hXYveJTneHP4YvIBLUnECMzZhX1izQAEQR/x1Xgzyi//1EbcIIT3Ph@vger.kernel.org, AJvYcCWE3c+YrnHoGnp/h0qs
 pS9TuJsswFc52iiwA2qdnoZST8Q1UgJ/o5MW5P3Uu7qn0fpWRaz5phKoXPI=@vger.kernel.org, AJvYcCWTxwL1Rp/xVQSGBtv6GGRPsd2Qba3F2KAlz1M67sOldCaGcQqxHdCJSAAFiTKFByv5n7zQLuoEP6Zn@vger.kernel.org, AJvYcCWfTV4Ot7FQ1HxhS9nUw1BPyGXZCx5f/66fFYsEInzWDdPHu3Dn0T8n/7Kf9i3M+haFY5LsKOavEoN9hA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3I1D4d044fyyI6uqMIQPtZSa00hSCVI/8fmlz/n8X3kelqPqD
	becRCnue8cDgHl6c4j1y1ZzhXlFpdhT0RevmUuQZaBWdHDI0MTjr
X-Google-Smtp-Source: AGHT+IGDZSxlCbsTRRDrlADY9xf/FeuikVNO0XKyrbvhvT68OG6hcNp/RMPI6u9Uj4MeELBy7mQJQQ==
X-Received: by 2002:a2e:d09:0:b0:2fb:44ca:801c with SMTP id 38308e7fff4ca-2fc9d5e335cmr33424471fa.35.1729796976493;
        Thu, 24 Oct 2024 12:09:36 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ae12072sm14875321fa.110.2024.10.24.12.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:09:35 -0700 (PDT)
From: Russian Troll Factory No271241182262529470158368334307958208204522924631681408115158110636801578517908140749826211402494881312487421951176430536853 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:09:31 +0300
Message-ID: <20241024190931.14805-1-vladimirputin693389@gmail.com>
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




