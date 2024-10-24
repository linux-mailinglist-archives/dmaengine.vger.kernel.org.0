Return-Path: <dmaengine+bounces-3511-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6C69AF084
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2324B1F22E8A
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBA32178F5;
	Thu, 24 Oct 2024 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8Aiicxy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F79216A3B;
	Thu, 24 Oct 2024 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796837; cv=none; b=Y5kC5cwDMIhI09+aLEPwO/eDM7O6fimXPOm87uxscFACFP8G6xAc75pxRf/05T9zSUdZU0SFF8wuO31gUVM/1IL+rawykOwwClWy59IKuaxpufu8lVxrv1t8QIIYwTdU4W77YERr4K/4yMC8WSfljh9IUZcPikpVixQ10xnBUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796837; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1C7mQsaW7+AItFV7xW4sfvqxRDECXA/0k6PAbx15BlB276ooinatnYxPvfYl1VKKlayWMOxiFtaDf+vnJi30sFg3Ty7wBxgkDS/bl/daSFOo8lapZmfOzbSDgRsRJXbqqPwRAtSd80cOJy+ylYV8vJ9YDK6hvo6fpaaY7l7OBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8Aiicxy; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-539e3f35268so1619929e87.3;
        Thu, 24 Oct 2024 12:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796833; x=1730401633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=T8AiicxyqXHrQuxCRrKiLzudi6BnCRdD5kZB9/S0F15LUZPsgWzl4iKQbNDlMfj9UY
         1Kusida7d88NpyptO6dDjkdHIU59wd+VoeB7lrBWKJSCfoeCBlub7j5oK7cAHmAbW5Mb
         JNB5djFKSjly3Yv7G96piTJAziUWQOKGh0lt2avEWbOoW5a3tqCJbYhS5HpbUoytZdKJ
         l7GmPFkqAhkfHbpcqPc6XiaiD6mkA2tBDod8o5yiWff9i5EN0iLIxY1WpfnFOvBsTCVw
         rJpPM4Tc+Zxm6LkkmIEGliMQl2Uz8WImorbTbYkFtzscIYuPKtrL6D8aKaSa+Wzpygyl
         P8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796833; x=1730401633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=btZMpeRos97S9PAfimim5jnuYGgqYW8jgGFgGEprIg1G63x9rx7S7DMNtaxP7wNSiD
         U5jg3Dl8pY3wBw8ZFVQUDT3bXrd9lD4fvpQWaPlD2JMT/dThoiwOmL+JUHzs0t8pO9eL
         sQwdCbjuX0l2oi3K1X4CCKTR6jG9CvlTWDmYcC2EQGNEOVTsDkQ3DDVRYMRNDLy6mq00
         /eNPOm+VtuOdqahzwN3AvqYCW2BNlBuVoDcdWWPIx79B0EW1Yuf28/GYLsm1THdu1vKT
         8Tl7g4lm5te92RbkdNs3UOZpbnrR5nDkK8sCw6WK42Qp2I+ZYZ5XrWDVDof+yH/pPolH
         roJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKWlvjNTjIlnDFIYw0Wyg7HQDYxp3nSUklLkO/WK2R+zFUjNRK9hDuf1psOObEzxeON4Wi1mhwAwTX@vger.kernel.org, AJvYcCUUzUS+6TbI2EbsA24sl+QPVmKJhAKaWa7jIM0nb5X2UIwv3oNxg2DDgr5UCL8PjVSJY+iNJwkgcCxMdSw=@vger.kernel.org, AJvYcCV33Kl5Se6etENNuLvcHd0d1fUVoyEtQgt/aLBlAOy/76WajfTzpupA3mdF4lOy23XZOowxZW2og5bRxqU=@vger.kernel.org, AJvYcCVGMbwbClOZnPTneWLLtmtK2R+lj4/wISprSSzx5dr21gux397Q3ppeqwV1FRMPGIIepYOj1hP1redf5Q==@vger.kernel.org, AJvYcCVRqwQhLJTO8z4x9faXiTriWS4fJrh18N1XQ1ztMh9vPEy5wpbDqeFGFzConLL7o240/aSG8KqoLYt1SA==@vger.kernel.org, AJvYcCW02XxtlUTCa1AOCwiSytsMSnrXF8GXljUFJKz4/aBCM0usMZA8IKdHWjCG6DStqHSQCJBPLav9U0cfyWIQ19kOM/8=@vger.kernel.org, AJvYcCWPUvMJlQ8SX9ZeFx8K8z7qi1j5RHazRB/ssHLBPLX3rFfyUr9P2Cgu7ixqnGLxBpf9KBDd/zdMWNu3@vger.kernel.org, AJvYcCWb+dszFPJnNtgHmdRaSeZoxFQ0jWxcK6ZJKCKfum0qbZowAaX2FVgGxZb9gapLUyvojdwAtwO8n5ZY@vger.kernel.org, AJvYcCWb6wvniCtzBze1HBxiYHA9CyyLVVu0sFtHBa7lMeQEbA2rZcyOCNjU73DZ6l5Nqbniy+N5JFcF@vger.kernel.org, AJvYcCWeEJlU8qXVXjrNy7BphjBh
 /k9k5pgm3YB33pEVLbLguKMzspfnuED9MHMjurRAHI0r0FTmKBgvkN+0iw==@vger.kernel.org, AJvYcCXh6P/dKrigwatMmWNRRpGLNTyUWRCwsPtQJBOtH/zUWaxso4jXr0sLiIh3aGjokeD1ROK7sDKvWnNmQXs=@vger.kernel.org, AJvYcCXugfSiMOPFH+Lbwngfn1K97kqnWOGmkxl6SxarMHLs4SyNOjv8wunUIkIzp8pZJBsjcaOIpszJons=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWZEiIXWzXi0L4maee8MczQ6EJHor+DFj2PZ9U2LsGCWbXeQi
	j+7bmxgkcoF0BqZ1lRrCfMfIxLutoxxowKPVRNgLdLeZvDJ23NrV
X-Google-Smtp-Source: AGHT+IH3DIAvkCvGxm2l/IevfrSGrwo2RBmkWuR2xBCJq9kp9JGk+DjbxK5YegsLuJRE6Ksszo0oQg==
X-Received: by 2002:a05:6512:104a:b0:530:aa09:b6bf with SMTP id 2adb3069b0e04-53b1a303108mr4958405e87.24.1729796832700;
        Thu, 24 Oct 2024 12:07:12 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2243edb9sm1434067e87.274.2024.10.24.12.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:12 -0700 (PDT)
From: Russian Troll Factory No103439967473128505210232207132519962184561092430770196023271499821112313107315235535885823896315333202386343974220981522926002 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:07:08 +0300
Message-ID: <20241024190708.14365-1-vladimirputin693389@gmail.com>
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




