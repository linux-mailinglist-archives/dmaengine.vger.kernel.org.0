Return-Path: <dmaengine+bounces-3514-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7A49AF0AD
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2561C22548
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087B3218584;
	Thu, 24 Oct 2024 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/C+OLqb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863F82170B1;
	Thu, 24 Oct 2024 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796843; cv=none; b=crqCtpr5zk03HV4vKITfw2X6oZv0fm0/RlLZtVwbv3xdAEmxJILcgGDag/uQ+CZ/STqclyQk75ROyq484b84VLJHm3mF56/AH96xKkN4fQPvmBKEQGgHaJL9DM3RkIPaMRkdC7oerP9Z7fOCnYore/COdvR/EdRH/uFS5cwLdn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796843; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9bLinLkggI1l0gPDR9HWgVLZA8ym2qg6MHtV1YG7Jb+N060yvHsaiFy/E4ZhxUH7ZmsUp8+wMjBNTauSqYQwGrkQbh1vmxYSpM7I3dblNN6yTV9yAqbSt6QhNBw4RhaQDYtxM3fOJzeNrv9+QlEjRjI006qEDiItlqlH0X6m4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/C+OLqb; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-539ee1acb86so1484793e87.0;
        Thu, 24 Oct 2024 12:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796840; x=1730401640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=i/C+OLqbH1gJ0C779dgZBp2kDlOTB4Q68e7avhBHmISL7jzr0QKY85YlWQwyK0QK2k
         GH1Oe1MqmFvBOeNZuuAyXuIst8BXeMXbSXfMxDmzksikVeIslqVqD4c2hq/Os7rB77uj
         42b/EhUeKwyYMdKzReMpTY8wZgOQZ7ugYEjqMZl+d7YRy025tOyZb1bCt+pKwyeT3o9c
         h/JqjWKzR6NfIF+FZsBzK2QGKAj2gy9NJpFYl2BhplenMBjYyaW+VXZ2J7+O5LLlnIdA
         yzqtvjOYnWZV7S6kwJwCa8zVOfK6Ti38Ku35QdRn37m3ij3+y69dEXphAPjAHVPLLoga
         8aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796840; x=1730401640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=VzvzNLPcnSpZa+UxVEdjG+hw0AghjfqCSTVCLvT9fjQO0JMiUVP18WDBUq4mxkR34D
         Mtwv7UinfBa2NaEItyECdBZLFvR+NxZUFpQbyY2PyXXyDynoOLAIxhnsYUMTDK1B9eBc
         9k3j7O3/TkbNcg7V8auXw29ebRDfNREIQRRbsYJ103r5Ig6mSJswUaKJeFFLPptj+GEt
         0J/bb9lktnY0MNr8q5JNRahQvkDA5fZwUHfUQjgIYQOtl1yakjLJe0mdS6xUepdJ9BOi
         PaG9xyXTn69H7GU10qtVzL408ZE8wUnYwGCWB5jMljA0cdjcVmNipS8NU83VGfcMKoCa
         POxw==
X-Forwarded-Encrypted: i=1; AJvYcCUPfyKi5mHeY1g3ZItvnYBpsx54H/cw7VFTaqGR0QnARhAPqPMGXUXY7oi38tkgPgQpHPSpSAwyt2WTdg==@vger.kernel.org, AJvYcCVAXyED0TOLH78mn+TI4HNc/EGbYch+N3vr1yRqPA13VnPx9qyKirpEkeGlKthMwpW2iKI5soEprt4L@vger.kernel.org, AJvYcCVHn30H6KqD2A3DhydudJhuGEKlQjW4MAqTS8xxcleejei+7aXFnjKP66qw3AU4y9BCz0gmkalXDplDpg==@vger.kernel.org, AJvYcCVfhLRumbEXzS5TW3Nv8UHsCzdlR856Snsy7CF6Bz7l8hhXJEh+lwf1GbMFMH9IW4IXzNSv9CHwvRGUGIyI5sVN2Ig=@vger.kernel.org, AJvYcCW9IvkMIkByf4ZIihtTWgvT1WiBLb0nSvhEQ1vQq44BnlQ0iNTkA6k/jxCWoO14BmtI1nda27CnLMruGg==@vger.kernel.org, AJvYcCWKMSki88e14zC2JomG064NlmN5JRDsxKT1QPoOG58xgbBXle5gyPIRrHQ4Jjf79bV6NYB6vrRqxhVj7Es=@vger.kernel.org, AJvYcCWMdZgHncQGMIBgMBb0oDOb05UkK/TlyX2zOfdzvF9vWYy3gWRuBPB9f8WL4JNF2g/qnzUUdlTajBlS@vger.kernel.org, AJvYcCWQBNEbcbPrqyzcFXTmP/aFHCCBUc0HDD/xqOVoRX3mGw3q+PICrPqRWyi7jftLdq8LGzNjNlkhM4r0OX4=@vger.kernel.org, AJvYcCWcQNVG6LKswMWERUvFIvUSH+ZblkT5fnmmYtux75hALLDxuo4164ZznCOoGtIdn7EuqWHV2z1g@vger.kernel.org, AJvYcCXEwwp858UytXD5V0xS
 eSFnbyeSAkPq7NQwCQAaLYDiH2aiU5rgSKkfIVScPM5Im5aOh1VaumgE3vc=@vger.kernel.org, AJvYcCXKEaZyEIpaxHFI8yaBd8lesS5i9AT92OLJjozbmWm+zCukOHrHSwVL/SeNRUlo8tQ0Jb46BkWSX+r0bhg=@vger.kernel.org, AJvYcCXdXwOJewGKdtFtcFc9O5J25/VtK634LSHYJs82f+tZZFyx1NvfsWuskz/UihFpUzbPa+a/SN1vGOPB@vger.kernel.org
X-Gm-Message-State: AOJu0YxQnFjqADU0dciPOBqbsakK8hrhQWpLNr1A2okDvsOCtYS9KTkP
	NUI0urfzSTOfbMWbvuALgxyklb2lYExw8vPG6s5lLhjuxhuw90WN
X-Google-Smtp-Source: AGHT+IGzTxfxO1UpJtpiv67CHG+BS57XCc3LpK7At1xrBeIVEYFJtg5U9TmWvqeoSuiNC9YctO/7qw==
X-Received: by 2002:a05:6512:3b0f:b0:533:d3e:16f5 with SMTP id 2adb3069b0e04-53b1a3699c5mr4437168e87.38.1729796839666;
        Thu, 24 Oct 2024 12:07:19 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223efbabsm1447223e87.103.2024.10.24.12.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:19 -0700 (PDT)
From: Russian Troll Factory No1134522873327151948221826694232951069642232359833514323664229350247553198027171543126898136796110301802891631367252341110218926 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:07:15 +0300
Message-ID: <20241024190715.14398-1-vladimirputin693389@gmail.com>
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




