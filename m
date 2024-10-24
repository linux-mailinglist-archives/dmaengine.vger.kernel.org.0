Return-Path: <dmaengine+bounces-3509-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3B29AF06B
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997B52830A8
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96710217312;
	Thu, 24 Oct 2024 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4kFpdnn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD76216A2A;
	Thu, 24 Oct 2024 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796832; cv=none; b=IdoxICqGuN1EzoMREDD5bolfS6pSFZTCjQhtpZ8lie2uMtaglXMYbr6GSZ3o8EwMxglR76BYCPrvV/PI2NcgE32hmSE7DkFQyHg4BclXSoOJz7E0iYePl3nOfE0RUTz2T46F0apr74uOBr63DQLMNqzSxBZkCqrYemYPqC+Xk9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796832; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wk5G4aHjf+ij6SclMsIr7SImzVztHsBAAKF1qN9sWQ7AeZUY/KgWiamb1SPFlEAtkBpXReDWNzmHzZnd0clM3N4IXAmzqW249QquXSNWyHi+Pu/mSis8+GnOuMQAjRwcAqZkmxYx4KmlsGEY8X3C5yr6pqtF+jzBwH8a+3IFQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4kFpdnn; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so12843621fa.3;
        Thu, 24 Oct 2024 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796828; x=1730401628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=S4kFpdnnaP1N3oUWt5oY2HJ+s4UQtfbTrJfylV7kNkoP9lLfAtXJLaP6hk3X7O7xFl
         Nz4Nfw6FBX1oEEJdkRK0sHgPH0nB4cCqwbsl7ZSuHNNXFEobaj8J3W1rDSgZKH3Nvy2e
         +FpJb7D/BdkojaEAfIfSIycqIp8nPhegue+nswgdte6bL7Kyt9iWVF6hWkFExnpcwuCQ
         eRk1awuTCYCtDvbmOSpuME1rGV6kdyDGC3eYwqwJegk8mNkBKpeb00RyOjSZkrYKN0MZ
         gLPsNUWSvQPg658aDI+9uHQjXAOM109QP5Ccus+9YbWx3ibEu5mkRltO1eMnLhKIaRmb
         eP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796828; x=1730401628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=SeXLIgohjmylGADLFGqSzXt8YcH6nQeAYpaTCeNUz2N+JpotQs63X1RPITyX6U+0yu
         JJUYaXVRqxgbRMESos0A+rWhqCZ1+WvZwANsckS0W058X3OkrxluQFiaXz1u/EF9AihY
         OIkVkJdJMGy5XwjvCSmo+Q++sevlsW4IHx1jS6jeparz7fcKL13PScQwbcd9+3hwBoq/
         45pQcH/3OtoL0uBrkMngsFJjfgnzV8KHd3G2I7kRuPwdhZ4oQ//0AacJXrpROrQe4vul
         p1ZewTN4yoVpkMuBRP9H+sUpAIpbF3P4mKZKzIACPEPwKPZ4ACUn4PXlXP/iN6e9x2E6
         83Ow==
X-Forwarded-Encrypted: i=1; AJvYcCU8N1du4Vj0vPUYE+FewWl0cfSwZ5EJQy7b4flqgoH7XPp388MoxhWtrx71iN/+J89n/naozfXjztlDdA==@vger.kernel.org, AJvYcCVDg5hTD5CSyaPNcsxfhmaBPy5a7UdTA9I/GNSasvrnSBJgwtRuQ4uUQqDevlTsc2Z7/YVLZiJVfcpnrC8g6aVNU0U=@vger.kernel.org, AJvYcCVZ34OciKSsba5rgRt+BCHIwYL/2JdiaqvXEV8kGoV4hBgzjRNCZerN6Cv2Ki9EsMFtELSkUYyKJXsorps=@vger.kernel.org, AJvYcCVdxKA45MVfpja2tD/MvWF56D1v2TkAtppPFsDkFbpXc84xWGjATkkp/yOKqDH3h1jpiAieQyZx8IvE@vger.kernel.org, AJvYcCVtcDEa7Q5dGO0WVsnkNsVxvk8g3K7t9EgMw7OEgOzODFKYfZ8lYMCsoLOS+fNZfd0EzS5UmAMqOSwrSV8=@vger.kernel.org, AJvYcCVy38h703A+yAW1ZQ6Q26aJcStVkRtJIOn8ZfgwKFLO7J5P2lOLKn4i/r9LrINoxyVQ7Twhn553+DwF@vger.kernel.org, AJvYcCXAYnMHPrpiE0uES8sAjbd/2Vue2Lq+orBgqrzJH0SbR3vLPHctXH2SpXq5hFNpc3v5sjtRCTReoQiUq8A=@vger.kernel.org, AJvYcCXWd7U8Ch3bhwsGqLvw4YY60Ao7L1MaRHM+qs2iHOrtYJt/LGciA5rNUaYAv+4tHDiJDE5yysO+hinX@vger.kernel.org, AJvYcCXkJpAnnV9uVvh5PjSV9AHSyUUiWIVEJlFH2Kr/R1IGv2XnkuCSLIdxiFlOAgPmN+vRAj8Wj9hgGQk=@vger.kernel.org, AJvYcCXm0ppujyzPNNBJBJNj
 P2LtcYj7vPSIin/KrvZZ5YpAxJcxOssJRfUxkL3slYz/yr8NTolcjKD5DcVYzw==@vger.kernel.org, AJvYcCXpo+tmnuj6FZ612xx9ay9Kx5KXN/2s6NGv7HlYy58KsMITVvh95bMnMLqj6HV0QHtTiLEOBPhzN5s/uQ==@vger.kernel.org, AJvYcCXptB6FranFaFm7SfRE/sjgLKc2kz+4clq3rjTm7UsQPne1k5+9ruarEF2k21nvGX2PpVFDxfUH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp06UoNK1ZfVjcuEHCJKuzYAFsKs69jj/cjovlNo2zKuPeGe5W
	BtVN40WkaD7KSxVp/j5xfbyip6BKrB2KgK9yI1ZltOqBoEY873gm
X-Google-Smtp-Source: AGHT+IFhzDj0Gb0JOib4PTeWJFMLwJiLpuf7p9kv+zs48dvawMvHA1HbTeBCmslolaoM4vgeec6MIw==
X-Received: by 2002:a05:651c:2209:b0:2fb:519e:b784 with SMTP id 38308e7fff4ca-2fca81c1cccmr19415601fa.3.1729796827938;
        Thu, 24 Oct 2024 12:07:07 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9adf8286sm14208021fa.92.2024.10.24.12.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:07 -0700 (PDT)
From: Russian Troll Factory No6219308334036166534455211471731614489664454072434926844222899273128481508994108304892285631274729335234168233171701621827481 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:07:03 +0300
Message-ID: <20241024190703.14343-1-vladimirputin693389@gmail.com>
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




