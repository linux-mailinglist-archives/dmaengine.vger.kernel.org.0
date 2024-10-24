Return-Path: <dmaengine+bounces-3512-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A59389AF092
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EC41F23022
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E74218305;
	Thu, 24 Oct 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLA5O2Ob"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F6F2170B1;
	Thu, 24 Oct 2024 19:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796839; cv=none; b=VofYd3WLfq5PRK/47mDaWdoYATEgraUWan84itxIFLpkVEr5G5zbzxzVhVE707ThGx/Ps74L4FPh9Rm9nhFUJmMp4ZoY/ogZbIDOVRGU9Hy48xcy3vouo2jADhl8ioZpFFY2hiK/AiSVDb6+YpVBzq0ehgKzKQ5XsgWUCJ6yakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796839; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSwU57lmQBje191Q+OsTx/CIObqyWCVC20v/zqeTPAvi+KzRh38ag3taCmvBunIrfjJTJm9Z5ZcUHMBFL27mGrs3ovwVt/roihqMSgOB3fZ9MoxalPQCiMf13rELqH2QV9vQ/2On4rtu4nRpoKtIMyQumBJduRRdbxfBymU4vcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLA5O2Ob; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-53b1fbb8be5so1532214e87.1;
        Thu, 24 Oct 2024 12:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796835; x=1730401635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=nLA5O2Obk9L6vwNWMOtX/7o9gGWVMSpGEFsFguYFg4MTjgmHK09gJnAtyASQoElE1S
         yhUIxYh4z0johNvGflk+VU5QExIfVbgF8XvJXthe5A/sHBgYOgcG6bSdI14LrTc3oCOl
         i491fEUVKvKFtnHTkf9xDVNq1csXHt3r4zSFotklSlbWeyto93VAS2khgkeFParjMoFs
         Jggt9/FmbJTMgUrdyHXT/6QeqSZcgF8tzUDrKIqet5goYaEuxfYwPobau1z5eUPx3sT5
         q/+jJQkniLm1rsKUcUZ6Ku84S9YF/w166A5Mg9TdCCDiYoeXr4W1BwQhHOP39usyO0F5
         efLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796835; x=1730401635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=PVPVOIoW2VE9NkqxlhQ/sfPtxXZe4v/vDxCQHnJV6oBOL+e9xw2//Zx292vj7QrdE8
         xQj7tYwlqLmapuusQXRsSUYVPfJOsPn4y5d2qiTouRVz4J5zcPAUZzB/XnPJTar7zE2B
         lcd+6Osgc7vBsTq7eRAFaeck98N6c7Tjlf/vbBtOsmja7q2KYOrJkim4AAgQqqITeEXC
         EC8hVxi6hCfPbD0uX7usq5QJJQ+0sfprhRZjyT1hNtSspxG3FyG3VNefXfMd/GjtwjUW
         VrBSqpopUz9BhXv0CMc2eh/DlcpNpW+fZHnveJiD8PdsN0esaIWYf2qKo0N5sl+mLZja
         vWQA==
X-Forwarded-Encrypted: i=1; AJvYcCU0VawY7dbYuMD5PW+gkcTd/KXmF7Nr0Xcto2TJVN1iPhxQ02mLFTNtY4mXlCHKKcJqmLxBn/JFYweU@vger.kernel.org, AJvYcCV3w9jQr7KKrHQYD0QUQllf9YjfTjoIBgyAw7knGWkW77svOdLtjrQUr1j0ZfOfKq9W7FIMUXVo9OFOqg==@vger.kernel.org, AJvYcCVC7KtSjnpU/Wa+kCaSVnwpr3GrUMpjBTs+u9WRLSlEkS7ZXjp7W7vNng1LBW9lHZW/g7IPiuQxQD8=@vger.kernel.org, AJvYcCVF+vLqrxm5eyHWZmWPVMJppIHJSnyedde5Jr5d77V8kSaITUpcRfdIbgyhh/nYTv4RWYKUGkwDnwersDk=@vger.kernel.org, AJvYcCVFsFk6FVDwmnMfknnXtngT3p8s0W/iDPtMxkmMcIg1LHfRHSej6mZlnGnIP5MGB4v8Z73Mqtb4HTpf+Q==@vger.kernel.org, AJvYcCVVXOliXpIq7tCGyJcqYAgQvLUCDALM4LGCJiww39rmSLNlhtgMLLxa882NXK7lLXKPtqmyybbyzz8xmA==@vger.kernel.org, AJvYcCVrm05/SI/2JY7FjEJLcsBNQ3pPoeR53NFo6OQhSKz2FRSxg9M0b54rTkFBrv41rJmEpGio1C1DVDTPMsM=@vger.kernel.org, AJvYcCW+zeuG4dsmKLGaAFVZNXwlGEgiahOkDNlHzKCR4N9I955/mjTOLi3fWfp2FCEnaJW9QS+1LOGcl1eY@vger.kernel.org, AJvYcCWS2581Cv8VOsFhZiepDTUGekexKSz3Kx++tl/VuZ4M+pnZrwTNLPq6A2SPUqYVbE+2X716gmEX@vger.kernel.org, AJvYcCWZuhHwosR2HoYVnlb41DfmtciGlPbw
 03wKV2VnNYI2zvZNt36QyXknZrq1XBsGhhZb8yQaVxwpWT75B1w=@vger.kernel.org, AJvYcCXIKNDloDMz0aV/8Vb70NMHGxmcbG/UPpdO+Ah75qZHM6UC8SmN/SEVdOPq2SWJa6+uFSpkSO3ak18Ex8tn1EePn5I=@vger.kernel.org, AJvYcCXJHDzTczK2PEUGcBSphRmh+4gIIWLTOkGk2cytKjtUhEBZ/+tdpmtDDRqeXUpdJ5dcXdIYvNC8rI2N@vger.kernel.org
X-Gm-Message-State: AOJu0YwaoSBHJrBTocySUzSvUmlKD8X95JLMyGJAMYvD9aBdwiunaNOK
	YdUwMWv6y7U+1Vjz7Cf2khRRamqgIPb51uRJL45t+4mQKgCX5pgU
X-Google-Smtp-Source: AGHT+IHnONlmggNLc0bUF6nx6Bsmk5t8oY2MVGxK72DOSxfsS0v9tVTby0mkCtOw9R5G1wTa6i+CDg==
X-Received: by 2002:a05:6512:ea8:b0:53a:1d:e3bc with SMTP id 2adb3069b0e04-53b2375d07bmr1157857e87.26.1729796835032;
        Thu, 24 Oct 2024 12:07:15 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223f0067sm1453209e87.81.2024.10.24.12.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:14 -0700 (PDT)
From: Russian Troll Factory No30459682557228112105012516369384861630659931201419675109881871217488537219982036431405381624542283323525020322246374487 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:07:11 +0300
Message-ID: <20241024190711.14376-1-vladimirputin693389@gmail.com>
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




