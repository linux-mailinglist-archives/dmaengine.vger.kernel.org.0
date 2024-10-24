Return-Path: <dmaengine+bounces-3542-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28259AF21B
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72211C24228
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43512194A3;
	Thu, 24 Oct 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yh+4hrDu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C9E20CCF9;
	Thu, 24 Oct 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796972; cv=none; b=Za0KkNV3BDCEazzJ6mQLON0siopBPqU6TCCJGwSgJ2qf/XnXQWENBE7N8NGJ4WQ1mbg5Mcu7f/63fuAjjRAIha29rs+pYA6rIeR0NzNrQyL0LCvWT+YxNp1J/9gb/C8VbsOUBvVS3dS9jGu7fBD2eypAO3rB69vgxkUjP6I7gW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796972; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SD9S8wZ328Tr72gH/h2LZf7kAmM3cwl9dq7wlnVA1OgLZEzaaWpbknWRF9Q/g/+ryXqpj3Lo0vETRqpvnK1NI1b212n30se3/Bmff49Zgg0fLn0sj0G2vuwsj3+sFAEKzntLIk7cyE7ydhcppDCr3kTu8t193ZNRL7TfQmOzb3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yh+4hrDu; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so1680093e87.0;
        Thu, 24 Oct 2024 12:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796968; x=1730401768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=Yh+4hrDuIVtaXP1jwYDrMAm+YPkCO0ZDsr2EayoAuz6DPWOtiN2vlBw93oxw3WQ3Tv
         PugG3ZVkAdKX3LPD2Co/WZ03ZOft+tosc6PCyj1tkq5Wcbmcw6ocUIzjnpKwuJJka2vm
         ot8mBPiFJ7Dk+HhCmdKZ6IO49LeRdN2wErbIH+2+k3V93iw+cfZPv2fj7EQlYw8yzsrB
         WqoVApvcKzZ+muxn5yTRq+b+aaDgfkrgw90FIen1FQ1XAD79N2pytOtdVDNY3zX9UcvX
         0MggO3MsumqZYt2ENw6bIXky2u2bYzBMhyVsw5HKppbn1I+1R9U2k8DiUU2KVxFtomFC
         2fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796968; x=1730401768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=freLyeBp4CsXs4IYXOQT2MDOTUvcBKivjwauTBLXpgrQ94enHD4XLq9wScoJq2/KKb
         YOkIQb8HAxcgWVjCoiwRzNCANJKqbAI6piqaDhAU7P9Nh4wHnR07lB2vT9D6uhqRjGMf
         OcuDuVHpGPJbKKtQzAbNLBlVMwkz9r9VFrm05YxXNRl43CCeotcYkqP0wXe23riOZyo9
         ZrC+r/+m5aEjDMlE5Bgln4XE99CQkJWDxbaOSr40RojZ8IcW+CB+WV/Mm6/ge0W5LMua
         6rC2MrQ/TXKAUy6guhuM4zVgwiOt6aqtsqWFioaaubeyx4eiq32oIcoAYmm6C/lfKIC0
         jopQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnEV3MzDT6hSHOLpR1XJpwHvtYcKUHr4o55xD2lxGWHh010C+AwTBWs2PQc3rnCEDKlmAMGJVHTCw=@vger.kernel.org, AJvYcCW2n077MQwZujBQL0JStaa5FqFgy27SZ6aICaJ30nAkD3zIK+k0Fmtrl7WBtKHdkcH7QRudFFJ5XB5JKBo=@vger.kernel.org, AJvYcCWJa0IEY26SnJxxGBEP2AFo7NhPrw6YgqyFDIKVlj0IUPjDpm2fP8BHMAoTTVqpyYxRM6A+GKN5aOttYw==@vger.kernel.org, AJvYcCWiGcsUi12BwJBaMb6DMaKZSBerkcl850+Fxy48X9sxZx+FQOMfzWjTjszYETspQ4MgWBOnnEgDvJM7ChwmQY4nFHs=@vger.kernel.org, AJvYcCWv16+/wp39/hNItKeeB21g6VJjeTCxEMd+57LlY1Z8EVQ5MtKDjj+edpq5F1CAWRLnmkH+nRGcd0JC2TI=@vger.kernel.org, AJvYcCX2RFdV0SI26GkZbtdTvTVy6N801sAgqZm7H2yuhcdtgkgD0D7lSUxzEepWSu7fyRJS0M42/XJuSEwgVw==@vger.kernel.org, AJvYcCXBy4q3OQELPHXvYtSZFtOKa0xYwONTOejxCHv3xgt3i/fVqnZWhh5VombbjuBHWiAISiQiv5Hr@vger.kernel.org, AJvYcCXU4lZDgcQ+hAjGjJuJSt7HPU2P3GHrGe34koo2snfHZ95zuo0OBBnSM7xN7DJcWWRpwZfoa72AZoS0pA==@vger.kernel.org, AJvYcCXVIog77RwYnnH/OQTHMlTBtkyYeBEzoO7me96FzvXDCuxvmnN8xktakVBwnTOItQnOqVYxCaghjsJNWhs=@vger.kernel.org, AJvYcCXjWrfun6O2+/y7
 adDmxV2rtpccbhJgVT1xwJLAwfDh+1zX9aAX7wpEvc8gYyfNasRtHnqedkexgXI1@vger.kernel.org, AJvYcCXlC4Qm9LnUcFZ1u/DLjFtFnJe+UsTIa27LvJykyQ8BHBJLZof4yxQCCgzI5A5JQMNkzvbQAdXY6y54@vger.kernel.org, AJvYcCXyAngYXYUbTDEXAqyitpDGb2b3MsOOCIodA1BTaA3ey5TfukswO+QJuOl/OHNH9oBTiIy1BZQy61Ig@vger.kernel.org
X-Gm-Message-State: AOJu0YxDXCgTUIgInTbeEMI+jbDLir1/kibIXYHS4RGSdj7pgrqIbHkr
	iRz14fyianH92MSvg4fkXW8rdQdB2lpWLTIRp7X3buk7Y87UCALY
X-Google-Smtp-Source: AGHT+IHk4xbavCS3EfemP+lJ2QGH0w0jy4c0JZ9THabnQKU6Ww+UTM40vaHU+B2brHnuaZ0MGbNj/A==
X-Received: by 2002:a05:6512:234d:b0:530:ae4a:58d0 with SMTP id 2adb3069b0e04-53b1a30c304mr3882974e87.8.1729796967934;
        Thu, 24 Oct 2024 12:09:27 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2241ffc6sm1443883e87.179.2024.10.24.12.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:09:26 -0700 (PDT)
From: Russian Troll Factory No29127292801656230002288881190516189900529711444515686669436139362508727712154442096525563677160452319632001321783263785273714 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:09:22 +0300
Message-ID: <20241024190922.14772-1-vladimirputin693389@gmail.com>
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




