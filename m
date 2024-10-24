Return-Path: <dmaengine+bounces-3538-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAD69AF1E0
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA08287B30
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0524B218582;
	Thu, 24 Oct 2024 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UujyJYZN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5012281E3;
	Thu, 24 Oct 2024 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796952; cv=none; b=jFfjVWIpuIKxpZbhJ4yGOWcHxP0JR0sqMfR+VPdC0b+lmAJG27YWah1M4ryvcaY2PsBIgw5P8M2QhfnzKuCipv+f8gQDkICiosFR+0uFDSO6rJqnLWbVgSHxcVVYTBGoOCKNfUubHqiqXda7VRpD/rouFqnjeetT6eCQPVM7iLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796952; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgKTrtKcAWUDFl7KDYvuWpntRf53oOZS6F7rfTDKupEfioYW0BMPOtrqJb4DKkZE7lgdsioKnDa0NaNfVsZV1lkGI9qNwyyrg/owjWwC3WsRbX9zu0gITfR3WYgOqvY6x2VMi8SxkS4smUew102N1kvfTyaFMwHwGRtkrJahuuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UujyJYZN; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-539f1292a9bso1675865e87.2;
        Thu, 24 Oct 2024 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796948; x=1730401748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=UujyJYZNn7lgLokm1byPoQEVtA/GSHRVSQ619ouNhNgJbJR7aULarI8fTARD9JHqU3
         tzQhH5zRRlf5aqrSw+NBtEfRMGcb8X+oS5dduQ7iD8DIAaUUntwkN1IHE0iuc+pNNor0
         o98pj9cHZsEB/EFUB4TXnIQwV2krRfwMkpDedUkHajSEZD/zvFCmtLymUE8LVv1aBd+e
         QamRhUsYjQlhXX5QX5fgeR37FSnJxzEjUo4BXBnUBDegL4EXD+Kq7R/mvlkj/UILjaFL
         ZFvH6JwS3fsGaF8b1Dd80B4/LFIk5GviPhs6kODxI8swysSgPiEpRxXI9OxCK0vPeWxP
         obMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796948; x=1730401748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=Qu/RsJS+9EHcHkPGhw5qy9YKgfkF7MNvrGUZKTGf9t7q8ceLM93JuvUWZMi9PsYjVb
         cj/E/gBEOqobGDamxrTuq1R2LA2+0+tv/YPD/v+YKHwnk+6unvy5+KYoZWvhYDDN4sQJ
         UwlTYfBMFpCC9rCreypFR6yQPCHqnHT3tC4/QA+AVLV7QI/nugNBtdaHCJMnDlt4HgTV
         dAwVgUqS3aKRUjjSBeCs0FTZoFK2mYAZDJKp6/c5l41wqFCm4zYyUqF0vqwdBJ54zn6o
         ubd9ux6rvCGk84asfzajcetz3PMJQoux6J3uK9FKpawi7yVtxHbzVcBbMvG9bFRu7YxE
         Cqlg==
X-Forwarded-Encrypted: i=1; AJvYcCU07+PQMlGfqi6feOMnGn/B5MrQdx2mGT98OJfOCIvth2QcJrnXND7slKi75LteZ6HbIG/kzDjg/qY=@vger.kernel.org, AJvYcCU7YJNaByEJok27zMr4hAne6ZP8qzXbIbBZoxNnPCLHuYS84afghdz4UpGH7LKaUb/VfYGDD2Ffl16fm48=@vger.kernel.org, AJvYcCUUzi4GpWSnR2zPOL2Qf/HeBiFpkxC9B8l2q2Hc1PG32csHFqIhc66OLOw1GAHKpT7SuRADqGrsxF0+rQ==@vger.kernel.org, AJvYcCV1399bAOzIrx4i40SYGkahqWtV8Lk3X/ElcJmKp5//vz9KkJIzSds7KTStHFpSvRrNGvSdBaJpPfiY@vger.kernel.org, AJvYcCVLt6Y+pEtHcJP7ReNnZoqgxO1yrdOCJAVuWGgSay7UDww6gkUooifgZm6E3bASiLNelFDJ8K1Bo8FsTJ8=@vger.kernel.org, AJvYcCVXUCdxI8IFLOH0hHr8m5grhehg10FQvqLwr4pTSwmkvcIhVJoohXNEVKITQCAz9ixdJ55mc+YW9FCI@vger.kernel.org, AJvYcCWM/J2u8qtWrES4OyvRmzz0WPpeBC5r41KCqwjF3hNBIoQVR5QP7hGYkHAJRn+TASV2SwyVLQ+V@vger.kernel.org, AJvYcCWamV1BZj3MGnVLfD0DExC6UHsrTX6DLs1FepgtCJruZQmgIqvtRn1cNfyeadxAtpwcIzaKU9GOz2qSNQ==@vger.kernel.org, AJvYcCWt0LYsOe0JkMnFynd6oMzzmTE11rn697KtxS4D2RnhLC4AXgIE34pFFDGu3cAJzI5B3RZpFHrqSKD4DWgGnOZe4II=@vger.kernel.org, AJvYcCX+Rtv9oRZDhFcO7xJYfZ9J
 rMupoChp9tZ7SUA1D1nuuhHksCVy7X8vDIpxXWZtimmWBE4gJIvZgNlLmg==@vger.kernel.org, AJvYcCXCyQ3uLSHuFeNDc3UwPqyaPDOJ4Svrg2sexLYnbJQNHjvrLpmxqmpP0h7duAyFySV0FPzrD1KB7vLK@vger.kernel.org, AJvYcCXwTXNxy3EFMn+qi0CX0SP6+3ctGL/x7aMcmk1jmiXsVQZO/vOPmAB9CJYiDqJkELpeeDNRhPd05VVpvFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPpeXldNeCY4GdyebVCx0lUkLbIyQDQ0sQ279f7MC9N3tI/4bF
	KymgOgZb8D6KkoebH/SQyHz1JF7RLHL3UunmdoyXJXUiFmPZDSj5
X-Google-Smtp-Source: AGHT+IETpXSqOnqkixZdD4A6HbhRy/2B5/97M3Soy9YGFrSd6mJYkxsRtBiWL84IDeqNQtjhI2zH4w==
X-Received: by 2002:a05:6512:a92:b0:535:6992:f2c3 with SMTP id 2adb3069b0e04-53b23e684e3mr1845022e87.41.1729796948354;
        Thu, 24 Oct 2024 12:09:08 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b1048b5cbsm1070967e87.191.2024.10.24.12.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:09:06 -0700 (PDT)
From: Russian Troll Factory No2459879441353210121129569357233712483264622714116913729475501589112132848621632956160261816310147828314142940631788203423925 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:09:03 +0300
Message-ID: <20241024190903.14717-1-vladimirputin693389@gmail.com>
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




