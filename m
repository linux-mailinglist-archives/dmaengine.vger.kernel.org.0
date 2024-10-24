Return-Path: <dmaengine+bounces-3531-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F909AF187
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A6F1C22789
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A6321D2BC;
	Thu, 24 Oct 2024 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCu1tw4m"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9663F218585;
	Thu, 24 Oct 2024 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796916; cv=none; b=gdLtwE1ABJgsXFdWKvmnDAykdHEBANy70bXPw9G+ReH9Upscf72zY5oOrmanfEMVtKV2Ya7KB41xHU7T+bgYKh1v5mrBPSiG01CEuAqmUTTbpUxj1Y3WR92LsXOGqQbuAYaFk1SWC97VCj6EoCCREWmSxU2aBTxBHD0e7aoSGMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796916; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAyMLLgYnltqf8B0i2PD9yn3XTJytrOWlzDlVZp7AqJsxqcWlcJFva9NThdz5RaTeU5FuBUiwCGXjSRQT5tq40q3UZQAlsBzNw7SAuT4QdXuyaJ841uEnEdQAAtNfoYo0yhAUkbV4ExtOGqHr9ElKsLxYlgszhz0gEQsk4Ury00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCu1tw4m; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso14699001fa.0;
        Thu, 24 Oct 2024 12:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796911; x=1730401711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=LCu1tw4mNSUmy3Evhf2pWiT0ujaKyY2YKn1H0fCxf4Q67b8fVH3TYsVkqofbA5JLjC
         mI7xYHWTcvotgxH5CDLuWMF9gogCo9B6wg8X1OCXPlF+7PLMGPHj7L+iplJQMeH9vP5a
         3P4VfziV19nF/bdLk7uYG4hRy9uau6IGtmk/DDcUduOeyrxwmZ4B0yZMV6u3OC/HRAwS
         sdZN9Vtuy9gJNGHmS/oNOQ+r8/0VGcxsOJ0x3F1XRyRstqRhVqDLZS4dKeEW8QLSCclb
         iSeVmbi4lR47r3FMaVJDVKGrz7aKPH1USKb5JGDPiC8r5mDqwg66zu83wXU6keAaCAXj
         /m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796911; x=1730401711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=k3bSDRymJqGBRKFWxssMKhd/NxBn8uKGAVdXXgreP8xpU/GxokXv50JlHaERAETkUK
         bvwxlsyPwYNOOZ8fm6bsUcI+0dzzbxzjjHyk44r7zMmYnpvDqSmqsFUsyt5TJIw52Lbg
         iV2m4vgrit56sZG0A2Dc/MLQnpgDO6eNAcusUIBz7ZSfxzYad8bWrICrQdkDOyP16jTY
         At6ySWC58b8oX2GxUTVRxI33vTzdiM7slt8Iw+iBIOp5vzjN0/CEro0w88fHHIvCjv2L
         qCgoEo0qEKk2IxClL+RAAjBYhFjuZTZ71Xui6q1NYWdc9+ydR6kk+V1U+xgsGdT33AbE
         D9QQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/yYq2G05skHCwdpXK4wzT293QGEHPAbzud81jIlSkxJ+8ruQaChaVYRDj08GmB2CNQeeAD1y8ssN3ZA==@vger.kernel.org, AJvYcCUEZfgIWLtv2EBip6XQ5GmCa11yH66jDqTVwS1qveZEcCNMOckc//ZMDRjn48gDCRLi7bG76T3ybi0=@vger.kernel.org, AJvYcCUS/iuxoD1TqYgtUTBvlRxwBFyysi6bYgrHt4vKLP3ocAL1nTTePR6l2N7yUT2M4x9+GLyJn8lPUjyemQ==@vger.kernel.org, AJvYcCUtDOWu6kWzweC7EHs9T4Pt0Ph6WHSYrYvRUjbrULxVtMNSB/lf9rKpDY6MpUOcmj+uKG2z/aDpmi7f@vger.kernel.org, AJvYcCVRD6qbmr//oZyFQroVnhsL+vC1Bte1QGspB01L2Kjj7GoL4Gltd2Tky85qvNYonwYlE67Apigisjlnew==@vger.kernel.org, AJvYcCVjjSO9nmRHhTrk+og3uLstIjemjjkwGPh/zHBgHHXF9onr+DldKODBCODg1Ah2gd1//GPGZ+YTVmTq@vger.kernel.org, AJvYcCVzIyzwN0OIw3GKylXwkjm20Snd6f5hAgRrJ99F4OLGuC+VX3h4Zh31CsCQJ97zWzoOloIlobdjj4BMdC8=@vger.kernel.org, AJvYcCWFJN8Sl8H7i22aTVfADD2LDG99jYAYMp7GoP+suQtPrIkqnwLU7OGB2V+H/I1mh2X0ODWUtz2Jpszm@vger.kernel.org, AJvYcCWFZqNYSEvVMXLAOSctyz3+2lRg+d803DYOmy1RS+4QFp7adCLAm3iiFXnJJL9q6PBIvRmLJgbJNMdJanI=@vger.kernel.org, AJvYcCWORMSp9ldK5kS4DsQ+roHrUZgc
 ylDQgqo/MGgXkvHh8ElJ5DSLq+W68VQI1B9fZvIZ43corI0s@vger.kernel.org, AJvYcCXGWV3bgLYJlNofOxnCS6hAUnHdGv0iGAzxphkCrO5IJR9+RG1yQoHjPxNo1bEpSy0rhKm7Ajfn3CV+ZfI=@vger.kernel.org, AJvYcCXbfl0tWdtctSG0pe7jVghzCD42iJBAXpy19LWbRZvLU05bY2IgMDrRk92Sql+UmqLAaAN1BTtf72JsLR69wj9KnZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySVEFe3LF4ghONXebGWOO2gFuD3RiUU2NXYZErheHLdmZxMY8h
	TIUMZGgNiQEXo5NRRnRqHUpeHmfcx4lve7EvxelDPgEqw1mIfZNa
X-Google-Smtp-Source: AGHT+IEQ4DdtwjJveEnS4vtmFArfFxOdK6kUJ/O00luNnrHnmDtcLpoFjRj3pJz2Zv3DI17aokTdqQ==
X-Received: by 2002:a2e:a98b:0:b0:2fb:5dcb:6689 with SMTP id 38308e7fff4ca-2fca8312611mr12598041fa.6.1729796911411;
        Thu, 24 Oct 2024 12:08:31 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad60629sm14757841fa.37.2024.10.24.12.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:08:29 -0700 (PDT)
From: Russian Troll Factory No30173278224503208632368615297312671257826248300782790835761136815941206154804196863873443244623300734517418251325039324193377 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:08:26 +0300
Message-ID: <20241024190826.14607-1-vladimirputin693389@gmail.com>
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




