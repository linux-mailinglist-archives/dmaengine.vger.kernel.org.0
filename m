Return-Path: <dmaengine+bounces-3504-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC55E9AF018
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08C51C21F45
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 18:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380AB2144AC;
	Thu, 24 Oct 2024 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUc+5JWq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A2B1F81AB;
	Thu, 24 Oct 2024 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796064; cv=none; b=YIp+ZvHtAsobMKNDCwLs5tqjRMNW0kbfqnjWRjbBBqqD9Jnmqyy6GIeM9Nsd6FApNFtdYwkgPzBNmYdSIBu6WsZo0X/aEyYbEmnqSEN5BurRryS4XIGn16AkTflFVVIT6dBlcfDlq7ic5TRH88xlqSHjr/7AJxo/k67a/RbyQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796064; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UItszZH7USE3H+RDSJ+yJhgQoF7/0uJXVdWHlB4axo2XA+Sabxdit2VBHs1pixmGzrE5GPHA/WuWSrP0hEAceyCIYpC5bC/e541gFsP1jHQB2h9qrG52z5AfpnD+mn13S0ALn+u87Iz6QJoza7xxswMRRjik50nOH+/7u4mmNEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUc+5JWq; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-539fb49c64aso2223238e87.0;
        Thu, 24 Oct 2024 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796060; x=1730400860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=kUc+5JWq6UFa+Db2BPK1k9ADOnUF8lfSfY7x9yTE5hPx5ytzBZGsl6LB5n+eYFurds
         hZLPpjM4pXVIMP1lSwDjwSQpg7jTYak4bWX83+ZssaFF/7EITm27B6pfsIuAY2XWReJJ
         MQVE7GFchganU26AHk5+kQH5OCB0t3th0wyvQs8Z79i/obgqu7qazL833PaxphGP2fo6
         xvhR0CrG8QPTfOVkE/CQ2kMXmzqhozQfXZTwTlFUoNRqM8u9qGbp/DRwRr35ip0bYjFg
         pzZkZXl9Hb42ms+8QQf8Ee3aJMYU7rckYmZk8S2R1lu//XVy7teaNmTXr6Jh0ZAC5zKO
         HMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796060; x=1730400860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=MvbM0h+HE9fC6DW4cnKBiTYMuXrC2ILZJq2bkYchkugU9FzGE20YwS5wplc4HrFtAg
         8AZPN5rIyvF7xTiTF0BVSw5+/6mp3VNmBEILCd+wd+OOtFk1Wrju6L1Mi//cxON30p9R
         pZF/e4+4jnv096QxHfDodNOw4BrVeqOMc0Q1l2WQ1/W/WF/YN5YegOuqB/0CelBpvKFg
         BKzf711/DqxAhfU9CBgBz19DroWyEVeErW3AVBo6cxo2XdIzIL5XnGlCRAg/Z2P5vnwN
         4jwa2MUxL5Ysv0h9sKg0zFIV1F4u0lgZIBgETz7NN0Mn5LT9ixsy2c8kCD/uad4djeCx
         yX0g==
X-Forwarded-Encrypted: i=1; AJvYcCUbvpj57qenXOd8EkaiTtIlgXbCxysyJcgKDpwr9lIwjNG0UYZegD3bufHpU0ImsOu3eCgBHXSDG+Vw6ws=@vger.kernel.org, AJvYcCUh2Ix+HHRwB3Bk2igjoS/sR62eka99AFTEhdsiQwbvIX07rqoPMPfJ9wRf2mNvZgNUL8544rbApQkiFg==@vger.kernel.org, AJvYcCVFzPmcdN//CIAALPi8L/SWDWCMctmUbZLm9XtzRcb2DO/K57bjRvqA+c3HUwDZm8vLqNpJHu7QF9bW@vger.kernel.org, AJvYcCVVm1ErBDb2Le47krjEysIrf1VFuXNO8VU/d/VkV1CxfIbXxAFVqMZ0jxHwcEBckrMp2muHoJu9wZO6@vger.kernel.org, AJvYcCVm0D7X/XV3mkfNM5ML53H+1Tjk3lTpFt5fgOAN1AgHrdUT2UhwWxrN12m9dJN9YyRsuiamhv3lhY+w/yhD/TKO6s8=@vger.kernel.org, AJvYcCVmGsTsx3qYTx+WVZ4sUcOiql7q6CiDkovxHHgD5FhlMGXDBFM3UlToVOKR1sfciz1h9RFDrTMBoheCIQ==@vger.kernel.org, AJvYcCW6BFXql038Mh5QGr7flrnk3kKBDOsWPPEBzpMen9OjYd5dRiIFrn4b52gd5SjdeZx6b0O7AGdac27jtf4=@vger.kernel.org, AJvYcCWiUXUlXdDtZs+Bez2ZxTQv+1HwNChH1n0X0LApd88StQ0ZeV/O6Tu0+kwItxWCEqg302DGAfch@vger.kernel.org, AJvYcCX7cwDhSf8WKa30K2eTdh0So0Zk5iTs1imwMLoSB5ISdn9B+f3wFZ31jYK4/i/UL3YWBiDH8NEYTn1T@vger.kernel.org, AJvYcCXAOBSck2RmNnm290HqNRrP
 KytPqmBB0pmlJRgcGONf9F30sWfUIZpY5E69rF+Lrz2z9hIYJglwJUMFRA==@vger.kernel.org, AJvYcCXZG/yBSPC+kkMDii3zO1fe6AMrr3zbjOGqnJBRmNpL2hG+zOaK53hIAJecRxEawLHhHIT/QJ396Go=@vger.kernel.org, AJvYcCXjt3Es2cwISZrjt6dhgfeBivvwp+IM/lnBFdV0yuA1MrvxYecBM7DvzR0pVMd2Qb8ovmS6SC2S6/8mwGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDquiMP4tZUpmke8BirAEcGaU8b02i/0vdihh/MGr5U8D6zlq
	KPyfHmnUC5HTK65SOLzUzBjZXZLsZGEge1K2vXAdNCTcIO3MmeTi
X-Google-Smtp-Source: AGHT+IFoiQBCZBcAcR5jU60pTi72NCLoItISNj31R7JvYaPYOBdPKWWzSsxj4HnvZHxkEA2DPuc4+g==
X-Received: by 2002:a05:6512:2826:b0:539:905c:15c5 with SMTP id 2adb3069b0e04-53b1a354f1cmr6553525e87.35.1729796059540;
        Thu, 24 Oct 2024 11:54:19 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a224421acsm1420361e87.295.2024.10.24.11.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:54:19 -0700 (PDT)
From: Russian Troll Factory No6317278921782522019217712476746185783101521654531817206662155213725266482115526833184451769719183127281553085321723121998284479653 <vladimirputin693389@gmail.com>
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
Subject: [NOTIFICATION] Linux Mailing List - New Messages
Date: Thu, 24 Oct 2024 21:54:15 +0300
Message-ID: <20241024185415.14296-1-vladimirputin693389@gmail.com>
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




