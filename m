Return-Path: <dmaengine+bounces-3513-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E9A9AF09D
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7175283393
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D0A21832D;
	Thu, 24 Oct 2024 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ1JQvvg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A29421831C;
	Thu, 24 Oct 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796842; cv=none; b=VGTCSkI+pZ29d2l+IqLT8oBJkmYoOF9r+BcHJ6LpYqCcSNELOnjBUrNyqH4V4h57KBb5au7L5SkNtxDSsYD8HKBcB+Gw7osM5dX7tuTlgs+Uyn3jFgJUXLpa8Q+PIyROPbkPqL7OKSF6dBBsVsV3dlRM6dDqjcFBaD3qE3T52sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796842; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hm6F13ouYdihacFXDNhiV3kGQ3ThNb6FJONjAPv4QIVfHVZSJmvKZZFJTSCnnWzLDUHDNlvfiyGLs86yOc9JB4vYyvcs9awpLFR5Ej7DZzDXEeHIEikN0Gj9WqiZZFYTlsTmXjJpYJFNkGcYrln4ZUkvDufMR8aSmuJS1SA3yWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ1JQvvg; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so12773901fa.3;
        Thu, 24 Oct 2024 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796837; x=1730401637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=EJ1JQvvgb0RdD4k0McpKoAPFb6bxOVaMuZ6qLiD4iI97N74oFyR5gX3Weg/Ndhd2Bq
         9q0JZ7PExhbnLjpiy86FUse0KPU5NClFTbQReWStTDxCNixyMrgqktKgJpB7CqXGVhFZ
         DpofqG+HMGg/mNX8sBbwQ54nZsqVYmGDvOSzW5Z4Ea1iutWb/MbEt/8BHe/N5/iM03VQ
         Ej+BUpo3w9xGVksxseDvszpNaHLDeloNmXfxIA8uxR9m34kdlDPSQf49laEkwR8nKmfc
         1a+xVg8fJhOA5jMFu1evMH940THgYbtIVCzQGlWLFj4w4L0LWHyXPZNrJlHBFX+VTx/q
         qOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796837; x=1730401637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=Y3Py/TJWcZK0TFWLy9H197MS009CywNs2gfKXQK8fGd+dKAfahyXAh1D8X68k7aK7s
         zTSwora+PAQyM81ohfEfPQDD5TyPjB7eVx8MAd5cvpEj6ODjNMtjNxjusY4WEnY0gUh6
         /dTphqQMWVjgOvAYOvTLLx/2x/hnSgo+0wPMuGid+6AgaS8kuk8rgxNTkKWqIT0GWLZk
         9Rdbfabc0OboKlTgnc3FNyI+rP7llH2WwPiGZp5UZeRHHMq9lCiJRPCiH0vvs0GLpQd4
         UYQnDFKdl+V03HiOJJUAZfRQKaHVOSG03lZsWtoH50uu1pr1H0q9Dwg83MjNm+FlJVGU
         o+OA==
X-Forwarded-Encrypted: i=1; AJvYcCUPxalNh6q1TNYQ+ATZbj2dW0wAgrcbCWm1vHSpe6pAPq94hj3NNxtB7cWc83IvsvBZ4+jqAZoGGsw=@vger.kernel.org, AJvYcCUsPU6RPa3hz5Z7yHvU1DL1ddERyFMX1VF9/JGzxBvDcacKnGwKQODsCATGCOlTLVw0PbH2SziMY3m9@vger.kernel.org, AJvYcCUtbTrlE5xYpCPiqKnRSujjYsiSM6XykrSm3YNIPOTFHr4JJnas2y7RbelLQqwTk0pqJ0kxfP12b/QZ@vger.kernel.org, AJvYcCUz56MqBeSbdQYbismthRKannzghYRcLTBWfwbiHoGiCI3PjgNNf8J9BQ/1L4W2G0T5pgLXLtsBgJGFfQ==@vger.kernel.org, AJvYcCV8Ir/wT/GO6u4n29Zmvwm/R+eYrqvtXfIDnoG+k3eG2vKVTad287DzpxL4X5Oz3IuyrR2iAbR678RqIOIiFIx+okQ=@vger.kernel.org, AJvYcCVY+WlDpiJv0j+MzafuKMO0epiYXV5uFxkw0VIXbirSr4CodCQPz00mU04Igo+s9X6KLaFu8uG50DRCxoQ=@vger.kernel.org, AJvYcCWTgy1eq4WUCLCD3TX88IqMNyZx5ueeVZ74aaHnpRTRDwSSiHBBu4wKxNeHtYVVk9ojg4B/0yG7/XuAdQ==@vger.kernel.org, AJvYcCWlqM/fbRFDzEqSt9FhNkVZK26OZ8DbGXZ78Qzjl5SmDJRULolIHt4CRYQREroy0cJLdWtgKvuXlPIj@vger.kernel.org, AJvYcCWsFb9emHkbZVdXxa3VGQUPnejmn1caKxhmp/zAvm5bdX7keIhMymc9TVIFp+O7SKw56UiVqf9B27mAYpE=@vger.kernel.org, AJvYcCXJPa+0BjViPaotEkLq
 B42wOE4yZZAbX7PCGyKDQDwrb5z2LJbsfRmg6kZJPjvizSDHJ+SWySjqinYgPA==@vger.kernel.org, AJvYcCXehiNN+8zItOCXiCb5gS/Y8o8km9ZiQPSHub3KRpL15qqDgYhpBhDAYSOG+1hBeLBrgnFK1MtX@vger.kernel.org, AJvYcCXue04BarjsFk81npYgTa6B462SJ2NAi6zxorFG7/X+WyyEYiJpVREaG5qiM8WralWr1x9ovQtTfftprHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBwFkD+fOMLUrUoEaSgmKdr4JxU25O8W1ZuLGhgyViEyng0kI
	qv52Enk1LPxz7FMXVP9Lmq2tBGSI2rCaGzLM3XQmC2I+32eieNkO
X-Google-Smtp-Source: AGHT+IEOYPwAOLmcHmjkNxLJKgdGHNeR+u5FYb50yFNn1Wg/ZE9/LX0VdGyw2nJ+F9qKU/++jQ/5Yg==
X-Received: by 2002:a2e:a9a0:0:b0:2f5:2e2:eadf with SMTP id 38308e7fff4ca-2fca81d6eeamr20034111fa.10.1729796837291;
        Thu, 24 Oct 2024 12:07:17 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad608e2sm15017631fa.32.2024.10.24.12.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:16 -0700 (PDT)
From: Russian Troll Factory No15934244494020120642396510575290130910162782353616833177811891830603103514006166792191719531181158225091057727110305002264216876 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:07:13 +0300
Message-ID: <20241024190713.14387-1-vladimirputin693389@gmail.com>
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




