Return-Path: <dmaengine+bounces-3549-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A414D9AF332
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 22:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FBC284592
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E578A22B64B;
	Thu, 24 Oct 2024 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKJe2Uvo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B043B7A2;
	Thu, 24 Oct 2024 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800110; cv=none; b=XXLELWQXtbbDWZoKXNJ2kt/F8Zfd0aNGYMqxetz/RuE+9oJ1Rh6Gd0Yr8qFobt+YvSk2bg1O2DumRLRzqZxmoRaSDeb3TH4j+n39jQ114T1T7Qmhk8jfevHxLyk+VJnWI2akHRcyrGNtJQlNByEozJiVnwROwXRxtCpSWG+XNOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800110; c=relaxed/simple;
	bh=eBIPSKxTj4L55q8JXEMDBFoYpoOyhZ0BDvxuOtJ2jWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cv5K4dejdNqNz3+mEJJzV9AQcI09aHZqBgUAJF8FAmWNQvE+sd37LKYCyWNka5csQTj5T0E4PQA8rYB3EAm+RpZus5GgcvYqHZjboe5+HcPonUWQ0t3JWj/bP097LWXDSEobSFZq9Jdlx0aIf6jmmCPXKTzK6uRfCRDiURKojck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKJe2Uvo; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2da8529e1so187872a91.1;
        Thu, 24 Oct 2024 13:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729800108; x=1730404908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YIraNitrENzrz97ijmN+xBP2tly+1JEciLY9B2SGV94=;
        b=CKJe2UvoD5WIAKDBqQuXHp/3b5oBD7ZlYnyPMx6D/cL237E3UXfMptRpGK85gVJnk6
         sGM1013RG1C4L4yEyorclFKFn1lCbVDmWYjYRixakbNBl3ERwtctwgw/a5VBJkljKCca
         fBNtLiaBtMfsuHEud9CJKzQps8wzFIliYkQ64mNIx0xMwdsUAeHidWpoP/aKhc0HvE/2
         /IdDyc5VyGSh4x599RyrCCoGETwQUUlzLsaDvMC+R9Pt1ZaEc3l5dmAh7IR9fcyL8IYQ
         /0mF5V/quy/l/fhD9Hmrqr8saCj4vSH+/99s5VgB5fpEy4pHbES5uewo/ZxQOgULxPbz
         6PQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729800108; x=1730404908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIraNitrENzrz97ijmN+xBP2tly+1JEciLY9B2SGV94=;
        b=AGw+7H3yG0rM+02G99WnvVyWz20kkv1Sv6s2Q5C7K1/cMhRqmlHutGLyuQk1u8K8Bj
         jpCIgMH4jkCgUVHGVkWB9lX7YQUhELlaUIFz6Zw5p7AWLHuca1jJZ6xgFfBwhXbE0+rC
         I0imEWF9mrSdGYIk5BBPd7NmDFCI+IHwcjLciNr0YKQCpMiMYz56P+PA0gSfvogW6QSo
         lbpR+Oh132E8WXhWtOyBusbfpZqUijNp+49J7FaokxmoSRFD5YWRgNdjJRGG6qZ/hL1z
         bAMVggMW99yDHWGENnwotnvT2knkfgyO0iwQt5nk4WdL7O7xrRex0wT+wyf3LHx6004Z
         P49Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhs3v9LLj3NG+G35DLDmg4nNJkv2S+LonVVGIHCAFTyR7v0oQ/PBV1G2qLwVHiMLXIGJbPaFH3sqpy/JWK@vger.kernel.org, AJvYcCUug8oofFdTxR/EIKfDNlN6BQcRtsLtQSYeHcJh+iVwNrxNqO+hgmvZCIJ3uSciP5M/0UaxuBzhyZLf@vger.kernel.org, AJvYcCV+bACuuxgKGtWejSFXDLvCquw1xLBX1fODpKR6SU1FuZ+19Iikfl7Se76Cz8JB1JhIYp3AKyjQN0XR31OtQfCJD0s=@vger.kernel.org, AJvYcCVQjfPdUCdX09j62SDj5Iez6PpktM4O2YzUn2Xg6pJ5p4NyVJjWXeiQAnVbyT2n4EnxlTQqRD8n@vger.kernel.org, AJvYcCVYLWLio1Mfuo6UaiURPaS4D8b6DBRNNDwMx7xXhGwH13jjx32xOQz3s15AxSe9nPgqlnvKl4/4ctkq@vger.kernel.org, AJvYcCVyHiETJICF/vCTUnDChbPMFXbmryV6v8QQpGs2uEC/xSpJWiMB7EF8hUTMx4QXhR+XmZKuk6k0VILuBILg@vger.kernel.org, AJvYcCWWyIbNLfejB66072EaXA7C1gZZv0F2W8zRM5XTNCO4Xdkl3Vp6Nr+jLHlbKDLP3Z8/HofO8tTv3sle@vger.kernel.org, AJvYcCWX3XQM7ZVoj5oP6WiSWXqI5Rp3ZiDTb6xtHVOsg2FNnXSpmNW/iVs4j71fOrFlTkPfGkEyNCi0/JWq8w==@vger.kernel.org, AJvYcCWYE44szBnI03siX30LKQDN9nxVni9eZ5LJre7kPd9GdY/AYrCsH96iDr8TslTBGH1Y9iFL+7HG0xyK2A==@vger.kernel.org, AJvYcCWpMk4bSEDhLWGhCEMiZBJU
 WLPj6rUcWU/dpS6tQ/BIiBbnmFreN2lCaC5V23yDnuN+chmYsLVU3DJA2/M=@vger.kernel.org, AJvYcCXtSWRNywFwXxT//IOyBQtoUg+ohqIx7ADpz/s8oZStPZI0pCGGs1C+Hj2wkOLVjfbuMOV2k3/xAu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKj2pMNYDAPHrH0Ede4G/EsyUYngj+DKJHH04CurO615FiIGep
	99H1PDVjnU7Z14lpl3YhWM2nJPvSh0opie08jD9Bx46XnA45XlviWadhFupK+v7tu0apIHRY4CG
	rywDqhd6r00wJRY0l1Xyb/fM0lNc=
X-Google-Smtp-Source: AGHT+IEnjgfg/aT6yQAgrTdR83/TW/L0fkHcUWiZIccgc7uZM+RpEvNTF7mOftbuDo5SWQyG+GHyEYQwLQJDF3dcyr8=
X-Received: by 2002:a17:90a:6286:b0:2e2:b20b:59de with SMTP id
 98e67ed59e1d1-2e76b5e039bmr3727816a91.3.1729800108009; Thu, 24 Oct 2024
 13:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024173504.GN3204734@mit.edu> <20241024181917.1119-1-cxwdyx620@gmail.com>
 <20241024193729.GP3204734@mit.edu>
In-Reply-To: <20241024193729.GP3204734@mit.edu>
From: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <d.milivojevic@gmail.com>
Date: Thu, 24 Oct 2024 22:01:36 +0200
Message-ID: <CALtW_aiicDv89h-m0h4dO-QKjoopittMc5ZvF3wd2dg8Wc_WVA@mail.gmail.com>
Subject: Re: linux: Goodbye from a Linux community volunteer
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Hantong Chen <cxwdyx620@gmail.com>, ajhalaney@gmail.com, allenbh@gmail.com, 
	andrew@lunn.ch, andriy.shevchenko@linux.intel.com, andy@kernel.org, 
	arnd@arndb.de, bhelgaas@google.com, bp@alien8.de, broonie@kernel.org, 
	cai.huoqing@linux.dev, dave.jiang@intel.com, davem@davemloft.net, 
	dlemoal@kernel.org, dmaengine@vger.kernel.org, dushistov@mail.ru, 
	fancer.lancer@gmail.com, geert@linux-m68k.org, gregkh@linuxfoundation.org, 
	ink@jurassic.park.msu.ru, james.bottomley@hansenpartnership.com, 
	jdmason@kudzu.us, jiaxun.yang@flygoat.com, keguang.zhang@gmail.com, 
	kory.maincent@bootlin.com, krzk@kernel.org, kuba@kernel.org, 
	linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux@armlinux.org.uk, linux@roeck-us.net, 
	manivannan.sadhasivam@linaro.org, netdev@vger.kernel.org, 
	nikita.shubin@maquefel.me, nikita@trvn.ru, ntb@lists.linux.dev, 
	olteanv@gmail.com, pabeni@redhat.com, paulburton@kernel.org, robh@kernel.org, 
	s.shtylyov@omp.ru, sergio.paracuellos@gmail.com, shc_work@mail.ru, 
	siyanteng@loongson.cn, tsbogend@alpha.franken.de, xeb@mail.ru, 
	yoshihiro.shimoda.uh@renesas.com
Content-Type: text/plain; charset="UTF-8"

> Hypothetically, if someone was a Russian Citizen, and there was a
> Russian Law forbidding them to provide technical assistance to US
> entities, then that person would be obliged to respect that law, and
> not send any patches to US-based open source projects.  Depending on
> how that law was worded, a Russian-based open source project might not
> be allowed to accept changes from US entities, and again, if you were
> a Russian open source project maintainer, you would be obliged to
> follow that law --- or maybe you would be thrown into a Russian jail.
> Whether you are a Russian patriot and are 100% behind the Russian law,
> or think that perhaps it's not the best policy, doesn't really matter;
> you are still obliged to follow the law one way or another.

But they are not, neither is China and I only see blatant approved racism on
the western side.

> In the ideal world, one country would't be invading another conutry,
> and we wouldn't have these sanctions regimes.  But they were not
> *caused* by the decisions of the LF and Linus.  The sanctions regimes
> were enacted by multiple countries' legal governmnts, and now the
> question is how can we best protect the Linux development comunity,
> the operators of web and git servers that are redistributing Linux
> kernel sources. etc.

In an ideal world the USA would not be a hegemon that invades, bombs
and overthrows foreign governments, threatens the security of other nuclear
powers, expands its hostile alliance and sanctions half of the world.

Anyway you fail to understand that is not the topic. The rage comes
from LF actions
and Linus words. All they had to do was to say: Thank you people for
your contribution
but we have no other choice, this is the law.

But they did quite the opposite and Linus showed his true ugly
white western supremacy face for all to see.
That is the cause of the rage.
The real danger is the split in the open source community and the
"software Iron Curtain" erected by the USA.

