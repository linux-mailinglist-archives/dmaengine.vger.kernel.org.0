Return-Path: <dmaengine+bounces-3532-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC3C9AF196
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAB528664B
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE8921D2D6;
	Thu, 24 Oct 2024 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5fEW+YM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59821D2D3;
	Thu, 24 Oct 2024 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796919; cv=none; b=SOuGX1Xgs7EP12WlqHJ1IR59I9SMydzW8h95ZrZnYzuBHw1EhOIrXSjbAGIPE+30xY8uxItxGmzVGyFM0PPmKJUjUjQIahXfrhqbgcPnKiCJcUAGrhQAb+ymqW73IrDkBCkX6z8hh3pS7wONTx29zdbeYrMaO8gHUicH1yoARz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796919; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0lCK60J7+rDDpuHO6SZ2ku6JGeqzbvN5+Aa102IYt/wFWgGiObwewAvY/8X7Fsf/FHguIsFzBNVPBADAqvuQGPaYxrqL4zJ42JAHopeqG818lp6TxQcgxgsTEQHmZ8IHcsQUftQ44FcWPI/qGLX1FTmx8j3NOxRHMAklSIpGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5fEW+YM; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-539f53973fdso1061279e87.1;
        Thu, 24 Oct 2024 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796915; x=1730401715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=c5fEW+YMvJ/lFF9xQUuajQhZz7JAgIRit+pclncFRsGGZ9mQMLIVcVf3sh9Vtppqut
         JvsixTlYnT5ETm5QSm9Hk/VfviFC08nhjUOUUMXdbkL2pxOdtVQlBMp6Kfs9nRgPAe5f
         DtHBom2Cmq6gy5wAXd/x9oVmIasqCmPpjySsAxLMvemNlakIwTNDXQjH4Ui1riWWVxex
         PxapFrfFDUkK+lnT9tQRf2FGkXrJ3f/jeaISAgEOzx8iG2pKhJmleEmSQ/6hYbjLVCq7
         Hh35hcTMUGfiVSeLtWtiTyw+kB5D2UAQy9xXI5KunGCfOxB4/5vFhdPk8dq6Zf5PSvuM
         PlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796915; x=1730401715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=tb4q6YwiimBNI2Kxbrw3chKgMEgn2JrMtUgGG1BKawqfeqh7OGguZ2BMIh/0CbplYH
         AjAc7a27OOn3kpfliumD2qoDJgKrzFeDt82LI0BjG6pGmkAhrhWiQ+1DjX4hfvZk58Bu
         LuAoyFzKNmoSw0dlWFQuIbik1uQZ1eA4woWsf6G4YbbfHvvxX/qB2u18jPXq97TtaOt+
         dKfo+G58p+lHN6kXC2QtuqtB3wHXXt6fkyhQvLyr9WzqCIE5VcGb8xDbhD4TuEswkBLI
         CoajQCDcOsoxNu7xuGXSjWNaDupYOmw+EJt2+ygvTf68uLBhobEltgGH9wgr435Drx49
         tKkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUybL6GNGduM6y4Y2JjfkbxKpSjiOWkCNigzbrk6mVYOWQLrMlqAtG5uhNnj/HHw28Mbf3CDHKN6TnzxQ==@vger.kernel.org, AJvYcCV/gxOcLiHLI5+DTc2+yA+82VfOj1ynLapP4R8EH877/Obr4FZxCLknH2bnI59a0LekGJSPA+x/OLJOTWw=@vger.kernel.org, AJvYcCV8ITCy1RnT89QhPoTEqoL0P6zD6x7/SpsVbD4TGTBy3SCsfTSjW7uuSSpNoVgjMY5H8HTH2jx4H31EQsg=@vger.kernel.org, AJvYcCVX4MjJ/4vurL78kNDa0Cp7BBMAcYQwyQoTXxx9ZvoHhTYm/VJGJAnLuyrNlSup4H4oMb+xULCLHI8=@vger.kernel.org, AJvYcCVfuoADaWq/hl5NiAIjmA7uhpLN5bv+9432cd8D6bVgt+mXyGLfHEeI2YjW4UKpyhaiox5jSK0U7x+/1Q==@vger.kernel.org, AJvYcCVjN20T0SzPcvl4urchwH2HaIEQD8SEvo/DzhoINSTMFxKX5riJaY3M5vvxdrqA08sR/7ZH1XQcusDKtIk=@vger.kernel.org, AJvYcCVkf7PFqbWadt7cTKjeIDVcQvNfTf6EGc7T7i/3FSL6n3ICC5QNpuMk85eEh5yp2UkdzK410VLrFk/5@vger.kernel.org, AJvYcCW4r0aUtjdu67vsrnZClb+q8wCb7gOXdcNhZbzYUMDxzftxEwRh87PUZVQIAZ8dbQM2K0ZZ3eU60QWlFA==@vger.kernel.org, AJvYcCW72ZzzntVcWLCI9KH/3PSHcj/mdDkEFEhV0wCv11u60K85Fbih/au+tD3XSE4t8h+2flcGsqRcpjnVIEr1wG4Z0aA=@vger.kernel.org, AJvYcCW7Mg3E88CK
 W8v8aucDPHlbtg23Wvba8eHaoFJ9NUP+mhcOqPigKVNdxSYygUyEi16UqwFwU8wdgZGG@vger.kernel.org, AJvYcCXAn4ZPVR8hPJdONDUpFprWaMeCLsItexBLEpK8mY/JeVBXvnmx1Bm4v2I4FZAbxBL/NnYplYzTEWe3@vger.kernel.org, AJvYcCXdvGby4ualTxxbkF3kc4ptjSVM/NebxR9G0swPuhFGOR2UvcQUpe4iakQjm3rLYN9LJ7AZa9ze@vger.kernel.org
X-Gm-Message-State: AOJu0YwDRtXBKCe/O140uAfjn0hxgZO8mwaAFoJC9GvqmfRze2palGMi
	njKYZBUjO8VnAvv4opKVr4Osb0vaUIbXhrYNkrM9SGZiFc2Ewafl
X-Google-Smtp-Source: AGHT+IERm0PmmLk4eHwkUAHfxAEUXoU0vu8Xk6w0ooGl83AXgXFTUsAnxOid6IX9fHwSP5y81S3RJQ==
X-Received: by 2002:a05:6512:3d09:b0:539:93e8:7ed8 with SMTP id 2adb3069b0e04-53b2370d752mr1084607e87.15.1729796914897;
        Thu, 24 Oct 2024 12:08:34 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223efe99sm1442544e87.104.2024.10.24.12.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:08:33 -0700 (PDT)
From: Russian Troll Factory No280911976419696751013153320826047285019318295994323692916566562245381307728983236971281311209893230077630560163463230127673 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:08:30 +0300
Message-ID: <20241024190830.14618-1-vladimirputin693389@gmail.com>
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




