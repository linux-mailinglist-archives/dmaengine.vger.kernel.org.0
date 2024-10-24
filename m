Return-Path: <dmaengine+bounces-3537-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ADE9AF1DB
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3A4BB2062F
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A461227BB4;
	Thu, 24 Oct 2024 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJFvxL1X"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C924C218D83;
	Thu, 24 Oct 2024 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796949; cv=none; b=e9I7dvJWPqKY2HXNPJfYfsKvj1nrJRzqiFc3ZlObaLOwPbgrOrL+E2OItU9pPnyAUNVW8RVqG5Etuq9EMG2hHWEVlRUI3G9rlOjvvM67YUAGHpyx2/kGfnN1FMAM1fCzBKmbiX3LithqlAicuDP9EwdWLpGGHInf7k/XgliYB54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796949; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFCmOEymxrZuIFl2qn78lkUdYfIMyY690TamIzgTyocb319S6MnlVW54LeSp4AieAheUMGZ9jJJraseB278YyWNWFX0IkwntcNrk6pIxABF68dMsWkSfMiyVEHUblMswi3Edll7Gk81k+r+jCIfNka/EHjkkEC6fC9Oh7xnc42g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJFvxL1X; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-2fb599aac99so13682071fa.1;
        Thu, 24 Oct 2024 12:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796945; x=1730401745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=SJFvxL1XnxTfK7Tcu1HPdQdRlPw3birH/wZ0jdtIneL74XwJImr6pKPCLTArfpFFh9
         0uu30BJn+MR1Vu954k6Hdw5NTbxQp14KyuztchnkJJGPf6zuHAmSzgvDQ3O255geF3R9
         82Ro365rGUIq6NSUWRMfmqiGmiu3XNqC4Zhkzv7KJPPWGtynYFIU+dmhteC6WHDCoqL6
         W+2QEfEfFNyez0bBK6bCmbOtCAf7hkyDW4AdnFiBXXAjOO+We7A8WQ3MMNdAKzKEIpO0
         qIgiqL/FnEitAwaJzhmCKqFehHc8bDvlExssxZlBtxv7T+RjW1SohF7U7yf5hLChf2Wt
         jPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796945; x=1730401745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=VYS0OF9BaNSN6RvAIS4w5tYDtQj28ENAqhax87TpzUVOuhLCVHHrF8KC5FHRT0FWGm
         EJgZ7kJi0hrHdd2/8AgT/982pyA2IHTFNpG5+YBEHHMPvmw3XRpPFNs6E4yxWGBVxdQO
         sNMXZMfwErCFlFGmd6OUgr/qbgR2hpfBf+sRTSumVBWOQK57L54WmTeQb5I5ms95L54C
         VUAOayXoC6tO0RK9I2ldzVEdzRPmeEHOUrch9jpF6kf4kRD98cehs2nEpme0j8Biokiv
         +Ry3v7Ge5Msm/GcZ1BA7wqhAvwWOxaFW1MrndCkMfeYSakYD3BawdkL55Z/p4lasdOfj
         8LgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU13wE9GznAqwHZfjtRLaun4aPYXPiYZVR5h+3FDOKgsEgna7+zrr/fWXc8uyjl9uESWllM3cyP/isDuVY=@vger.kernel.org, AJvYcCUg+mGiFE71fsgeNp5iQEyDjkQDQNMLFo/FD7u5CksJgkD3oNkc91GfPYJhZJKyg8AQEqAblpmX4Npkkn6pk+bFPCc=@vger.kernel.org, AJvYcCVJGufYm6mkvj7X7RGqtkE8X7T+UmkNd9SAIJEP2xs8UQ7UyUAsdqyIXVMojGDIzdCmtCYFTpVQ@vger.kernel.org, AJvYcCVnD+vgfBP53ujEN8YD8hze67o+H+usR/JsUnlOroOy8elPw5Y9CmxBxuUt0aTQWoyrx7xUuzMgAJk7gEo=@vger.kernel.org, AJvYcCWG1XQ2QQ/ou/Nfg+KiWwBPFME4YFzwH5Cg+LbkYy5UV69tFHwhN9nTQVJ/kppAXdq+fh3UUe2eRnO4Akk=@vger.kernel.org, AJvYcCWWiCjbMLqw7p/JIxOqWHr5LNLDVrdiUlMCWYQ1XRmEs1dV+ZSSqNlyluhwbs3gJ3863nwhEw79LvKsrg==@vger.kernel.org, AJvYcCWf2WuE9OzLALY+n5JkHIVoXeovlVahSYrdAxq+rm8bBq85+qWUw7GA16+70U/qkzEncUFcauZpD1rrZA==@vger.kernel.org, AJvYcCWhV4UqDF5Dy+y8fe7ikRtSceKFUHgXqdsPLA6DzPer7uZfTJzSIrCVjsw9rg54J2SiVFLCT1/g4mH4@vger.kernel.org, AJvYcCWkwh9jTpJVNspsyR3jOoM3SMLYmwuL+genL5WGRAkKCCmUAqnos3SUkaUQLOdax8Tav2PcJIDk/bzl1Q==@vger.kernel.org, AJvYcCWmH0NMmGJBSZaS
 Lh6RnFqKJ5ZbWUb915vv0c28yBzf01IKeP9ry0zmJGEvZCuhHZHARvisLObeGoyG@vger.kernel.org, AJvYcCX1iJhFIvaG2ykiEeDktgSx8MlGkLRc+Jdi0e+dBFFpLVvkLndsljjy1Xu4AcH33AP7Zdzbi2MF1Ol+@vger.kernel.org, AJvYcCXMeIs6sgJBNKyI7I4cUlGtfl856lRTgesrU1tAaTujc7nL5rN8k3m4BSsBDXRB1C/d2vn3sRh5waw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZAhzt4aMx8WXEsGHp0Ej81M4jj/Tzxlz6C8jHJLadI7tn0F/G
	sxltF2m6WIfxnka4ebylAgerj+b5XiZpY+hqH7QzCM/feLP0Krpj
X-Google-Smtp-Source: AGHT+IHStpr+I95wvQZmKqv83SykDQHqai4NJPljAQ9vPJefRDvmxbA7RdaPoFRmqliCgKhTIE1Whw==
X-Received: by 2002:a05:651c:1256:b0:2fb:5da7:47a7 with SMTP id 38308e7fff4ca-2fc9d375d15mr33958241fa.25.1729796944738;
        Thu, 24 Oct 2024 12:09:04 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9adfa19csm14878081fa.89.2024.10.24.12.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:09:03 -0700 (PDT)
From: Russian Troll Factory No891622132171136182871822154215668629584198453101825252952799015417288673125817024261462302707229403263072352343831698227498 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:08:58 +0300
Message-ID: <20241024190858.14706-1-vladimirputin693389@gmail.com>
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




