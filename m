Return-Path: <dmaengine+bounces-3505-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F69AF02E
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA70280B98
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 18:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9551CCEE7;
	Thu, 24 Oct 2024 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDMrTvJX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF532141D0;
	Thu, 24 Oct 2024 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796111; cv=none; b=HauNO/ghM3MtSud5d6xrmjrs++DauUsF1UgqV04Ja0JYXiIXZEJ7BtMNywLG9aXCQCLdyRdJmO6UEBmLrPEnIHzCa+m8xFsLFxxV9hMBhB14vEaRDTETUOWQF2v39t2B4WA9TAtTazYd4VFTwIm2ghZoZ/IuFtBS2i+MPFW3mgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796111; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sogdo7miY+LWeX/I9huvhNpcJLX4zFCKLfkVh3zbXvfm8D7BpiFlt1I+lQ48PLb25A4o/nAChF0NYZPuVPC1KSt4CjHKFmngVFfzwa9xefPsgRw4B7A+Qva16NbChJJ7d5eCHHDIJQsVhPosDrhtUIw4WSrf1SI/nITvp5arrcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDMrTvJX; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso12589721fa.0;
        Thu, 24 Oct 2024 11:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796107; x=1730400907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=HDMrTvJXs8ummu6R7spjzvdxgAwL5vHQ5EfAEbSOZ4Q7xCTos5p7hz2vS2kAA9UYmP
         XYr+RR34G7DbT4P80ACuJWlozfhX234PONTKPceoiUmaWlvAg9+4EtKqCoreovvSXvcy
         OtYPOBQYRyL2DKJD+qhWILdmKVeYy2kLBs4iDQ5fhgE+QpDMxHY/XDABuwwrK4ig1PMc
         k73Ikw6VgSKY5swgrGYyQPXccoerJOTjoLsW5MQUNNtiCzn1OC4/+Tay9WfPPZn1QP+v
         /uEYBwYmov8LeM8hXBtbTngIHq4534i91xca3sM7r9SjFwM7MQ5sDx7ebm0foxJXW+U3
         bIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796107; x=1730400907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=cDkWAzA8mnBTa2jmSR0NXL1+yngJs6gp3vGP74vsGnYbzs+HK6+mbLCHwhBZ+f5cG8
         eaLOqrskcYBApYpNyHS9vWa8oB8S01S1ru05mhmD4UaGYEpJb2/ecyiim1d5Dh5ootx5
         FtsH0t/6jWt6WXTquC/vO8LikteXm1PsiMjRWkl/lGA+08U1CyQNZY2ATtBE/S77c1TD
         Rgc/pz34hSiKRozXExulYLPi2hFZPvTZ0oQIcUHN6+K6cAwIPwqkDowIccD52lmuZHA+
         1wn7LWdlbzBTBOxWuSLQsfVlva/R02o5fhUOzTWUBRtVPglPmZuLKDnqmJmN5kT58KmF
         LDUg==
X-Forwarded-Encrypted: i=1; AJvYcCU+XGHLkhxI7eTk7hu85lmnuCcakaPaIFHDsJCZfkpVAQm06YRq3SpSWVV9QRXDaJ77o98pHaRFdspBzPc=@vger.kernel.org, AJvYcCU8ItEQ05Wkv0GLaVDhP+aB4AqmAFxHttj1Qxh6D4ZF04ycUaHhHaqtt1Jx9iRKgpY3qXbyjR7F3FnOgQ==@vger.kernel.org, AJvYcCUhLH6e+uAuMaoU/C5Y/YAQlDsUVUxE/u9qbzPXscaCIWfzt0ADCmvvTL4vxlOrFD1SnjTl9ZXEjHe+xs5pV+7cU0g=@vger.kernel.org, AJvYcCVL0dur3uSxK7MEpcL8MqxpSLTfpqmN+E61c1XthnEVvUOdyOffZkTiuC5BkHt1lgZonbaAk8fMlX2y8Xw=@vger.kernel.org, AJvYcCWHbz+tTRKT+O+QNKIErziKg+AMkVresVOvwus3QsoyI9KWRWBLQ6LJst1MFTpNxA+Vtn9ibTujsVn5Hw==@vger.kernel.org, AJvYcCWYCxGWuKcNt4SgOv3RENH6vrguRWp09WykXhG5mA272i6gQl+lkwVfMzUGSqijlRpY5NkcIsmb3sfg@vger.kernel.org, AJvYcCWZFJ7MvJ6KD0pz6n9iZJCVIC6jrqBGoXGSHMMTipHDsye2RGgTn69JIA76rMFxd7tox8Zuq4zK9suE@vger.kernel.org, AJvYcCXKWb9ARwbhqrj7zZLhZ3mjzJUh2YH/l718tZjhQJb7ba+VlHEacYrsaT3u2y7Wu4feAuqdibv3v2/R@vger.kernel.org, AJvYcCXLd+FTEY1sj+EX/ejBdC4/AvWKNSK3RpiuyObVhhb1zNwop5Cujzzix4wkXapxwVKjP1L9JFP3ZCA=@vger.kernel.org, AJvYcCXYzcRKm8lo8YLRvrrr
 U0uc0s8nr4VHpJEtmu7ystHmVxj21b+5n7AIxK1zByiIPYf9q1mzQo7y@vger.kernel.org, AJvYcCXnJKDSOPyRgC7oC97/F+KhluNyFRMYalwGPKRczL3hEd9ifrnzZY0WP9ubNoyzz7yf5L/iCuUCSY973hE=@vger.kernel.org, AJvYcCXw0CSOiFyg8WqF0I0mzm+NkoIpqxUOBQy1JpvNw1hvD9SvDhWbK4X3NRaIooN8wneBAHcGgdLAP5Wk4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/BcQ2e59iGJmxzHvKfij52hdLpKO/HTym4vU+wLqG3Eut1c60
	OL9knBpDV82nU6xbMdazGF3lhBaezS68aADN8ikbxMeWVwhh3ODC
X-Google-Smtp-Source: AGHT+IH3sVnaUDe4QuLXHTU5wSGnb8N72jSsxzL/X7evi+AQIxiCJRQu0S2fyxoS2n9uka6/2RZJew==
X-Received: by 2002:a2e:b88b:0:b0:2fa:d354:1435 with SMTP id 38308e7fff4ca-2fc9d1dbb59mr37897321fa.0.1729796106402;
        Thu, 24 Oct 2024 11:55:06 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad608efsm14547021fa.34.2024.10.24.11.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:55:06 -0700 (PDT)
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
Subject: [THE TRUTH] LINUS TORVALDS IS A DICK
Date: Thu, 24 Oct 2024 21:55:02 +0300
Message-ID: <20241024185502.14308-1-vladimirputin693389@gmail.com>
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




