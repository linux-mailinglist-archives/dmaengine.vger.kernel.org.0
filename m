Return-Path: <dmaengine+bounces-3510-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AD29AF072
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742C01F22209
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E57217339;
	Thu, 24 Oct 2024 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CshJeTIW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90049217306;
	Thu, 24 Oct 2024 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796835; cv=none; b=Ddc2wRsMu8YeTU0ewpQIb+PhsjhqlSE4DlL4uTJJomz15G4ku52aF8HkOZ5WhrdEnPNjchQkdGMUa8fpzcQImz0XXGc/Dxk58inTdW8E5clZDsDF52xq6/nqoMnrZm3cWRmPaTaSGMwG5wP+GYMsnUCeuwypEmYPPuVdP95Kmac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796835; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERUb9ZMrS4kIpQszn+PhGh3pLVoDRHfNK0kb9ANWWVkYVduuohpsgceE2RUNWHCFVVuGCbkBAxU6bGokkc3lEJ5EOSsEZULfipg6E3C47lwGM4C+q56SqU5EoEPGaoS+mPMmY87MlnhZZXJWWRo+a1XKQtaEOaHJtCuu6nO6UaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CshJeTIW; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so11927381fa.2;
        Thu, 24 Oct 2024 12:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796830; x=1730401630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=CshJeTIWUcc463PH6gEqUboTiBUHq9kDoOmYO6DdAClG/ZjUZa56FqOKpopv4MkOG7
         EnBDDEQ8uY2amZMAxxUXb9iOV20PVRirnmSXSm2K4Z/VF4ROSDOYnxd+w/Ok9ZOBWZEb
         QZLss+39N5uFHgdSn4wjT0VcKXw+gZNwQA/Dj0fMrQRAnlws6no/fVlHGO7V0OmnkB4c
         WgzHOiFHBQbfftC4r6NIPs0DBw0vPKodeq8bcDk6T9V3nUH5MGO9vd8oOV6eSi/ba09v
         1qMDLCv9DCClPia/6tx6tHYHbOb4BrZ/t3Mka1fU7X6NqiANF/fQ98isVBtSEmkaGppf
         2Grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796830; x=1730401630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=Db6zQnYka5CMFCAhuki6nB99SSNTXuFY9RapFF5RxdwM3DnHn/NDNF9CoVonvv1gv5
         AfGI/U7hbhyZYO2RJLztKoYQreRWaKOiYsF4Mf5J8TIUl/Qhzq4rxhfZNltWe1OCuoeJ
         88msO9v3wJLOqK0eIbFEyWSLziH5pd4IK1U4bBdHVXwm14vqbrM61IULAmUP2JWpmx50
         DPbavXOvY2gIcUyYhoQB61PSfDAW53rJpIEkFAHEAah7vDjugeuPevpK7ymlvfpQaW2H
         6t4FBLo67KGE9npYuwDDWhbT/dL8qlKGC8sOC8VchSNmNy1xRZfTIiVTKtjVqZq9U75L
         VJGg==
X-Forwarded-Encrypted: i=1; AJvYcCV+EZ3qw1DjIiW63Qnxg+0t4wjFdKEf7TS4IqbMxB2lTPhF1f5QsotFs9q4l8Stmgj6f6rzHNEy0EMyqQ==@vger.kernel.org, AJvYcCVT4qAoeEwNATYRhuF+thj2Dh/GEGP58/M11GQYsKTlpGjjZWsjX4iJ69ymwkqnlkasCClc+cJXtZQP@vger.kernel.org, AJvYcCW2AqCbwmw252mnBGDuldr3xdNv9g7mOUdb4FvP/3GcFQiew1bcpo3hpCE9Vxcc2xkXFL/7EErx@vger.kernel.org, AJvYcCWGGGaZZSOGWkUFRWiYO48IoHhUpNfzzTa4mePtd0KmdWxwAKunwv6Zycz60A08LsHD8X4SEAgEE8OV3rI=@vger.kernel.org, AJvYcCWQ6HyoLdK0zJIvM4z9UMsWRxnseJ0R00ADwf+RZfGEmclhu/4nYKc9CVcnTdqmSKQ7bWd7lxW8wR9++Q==@vger.kernel.org, AJvYcCWSACgwIMWztrhWaYUgl5X/y2eLSh8LgSbXb5TyJPlKZ9i0+zYk3IWB7bEbD2sB4QZU0xwDDyN6NpHpDg==@vger.kernel.org, AJvYcCWZx03iObPjNLTdjUhaWa5X9mIrnZG8vnaZdMwD4JeOQGumz5j5vUKpRLVBmXQhGWaoiQH3kBrdDmSJcHg=@vger.kernel.org, AJvYcCWj3YLWLaLiK9yyfWTLWZlad7ACUMFvV1NM2pDm9dBAas0gbELNboapoExKZuzExWsY3zakSewme6Wy+g0=@vger.kernel.org, AJvYcCXDCx9VDbIlBs5t11eN1krBN7Hye6OiYkeucQRYytqMOfVQQQ0LS8o113FF/yD96lnf5lJ0hlDdnqc=@vger.kernel.org, AJvYcCXFNdLk3fTra+cLxYhqWd4wExjD
 EAcmlzcpQZlYL8Wps622ZR4Mz5a4UPMQoYdWSuuhBMTnbl7wfBcN@vger.kernel.org, AJvYcCXwoKwmNv/V1sMrJumdrJVhYbmA4kghrAYgI8CXOprkezxk9AnsaHL/Ui168rYiymPD6UCTbXu3uX8H@vger.kernel.org, AJvYcCXy0fdnrOWGJaa3fNs2NbMzD/I09TVqMK5a8jXZ0Sl4RtKgyCLo0IX99ghS8RmN74Yjl/TDzKs17mCSV0V1AsUftbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbbiQ/7oZxGBKbyfB+u9YZDG7XgStwyTI6FW3TMJBdG35Q7n5d
	m9w37qpjGKQ/+Ui8a3WCn15NL/CxCKWfcJ3cVLr3aUi2iMRYvB79
X-Google-Smtp-Source: AGHT+IFP/7X7GTarqOL2XfPYx8WitPZe8cSmLZQXiQHgBauZXsG2RB5ayJItXR9bhrBFc+IraBvkbQ==
X-Received: by 2002:a2e:701:0:b0:2fb:607b:4cde with SMTP id 38308e7fff4ca-2fca8277985mr15191721fa.39.1729796830289;
        Thu, 24 Oct 2024 12:07:10 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9adf7bc2sm14801441fa.99.2024.10.24.12.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:09 -0700 (PDT)
From: Russian Troll Factory No1623111911887115334126552327810255156763100131913948076972599316269133292559116809224612844417367366531719173361944319700320516404 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:07:06 +0300
Message-ID: <20241024190706.14354-1-vladimirputin693389@gmail.com>
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




