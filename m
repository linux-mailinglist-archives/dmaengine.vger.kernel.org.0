Return-Path: <dmaengine+bounces-3506-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1E79AF03A
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CEB1F22CD2
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 18:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4086215F44;
	Thu, 24 Oct 2024 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxCrK0oP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B6E1F81AB;
	Thu, 24 Oct 2024 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796152; cv=none; b=kNgUHx0iKAofMfC3EAqPqdaJnqhrfjbOanVJgC9NgEPPrCUgo9qvrG4EFSUqQlM0VzZBsjmYuduAJlD/F1yyaElEZxZ7Yd4ZIA7QnEIu7gUZVJZKUZrsUBhsq6zFdnP4E63K4w0VSaeHlfkxRGuf5klfYaGGvgpLOH6lRE0+MHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796152; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibxqD4JtkwNngMapTCluRu0JnBX1Mrx2B3/fkFw7nM9dpRyTLFaYzwvRHaRMYPC3HIC0gxVExi68zCukVEQbBKZEBCZWZ6bMCNyaljXYi95kspLYsjst59h06ONOh/rsNYf/o9cqXJGTnpRGimHjJdsH6W8ZIecGWHgYCpwn70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxCrK0oP; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so1629296e87.1;
        Thu, 24 Oct 2024 11:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796149; x=1730400949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=QxCrK0oPhyJOYUx+hjEG/6uJQmH9LrmqeWiWawWEo3RdnyeiYy4rABZUBpP8+mKEwS
         Eac3k6e0d+fDnFGpKof10S/Bjo11XsXUoYC6qdAfVvxW8n0a1VxiHmpHgYMACmAViCOa
         GOqotfsSGYj1+EhuBuJJtZ4vzU+o5AbpLHYthIVS2kfa40h9SF9o9fWVTphew2beBX3w
         zcU1kKIy/J9e8Ae+Wl6ngO4pBONkGFt/oWmXahiTUpYLx+8Ie4R2raFP/CTGicq2hvaE
         LZhuqZV/3BT4TR4L10ch6o75Iib0bn98ETlsKG+1Qj6YEVTdRMj+WH/MRsUfcu9IHoyD
         R7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796149; x=1730400949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=K5E4+qxMj2538YAa6zCgtEKOJRr8Ovv+9stFDJ1ZL7GtrhyiNyMKyEJottOVLu/Knc
         WXrx88MqgIIz1oJCV4vyuhGUPqSFg1qYhWmANqlbbtxlijkcVuaHKT9IC7WEm+q2DVJm
         csRo/dzmB8q/dKRB4L7bDzHhls1bC7Rw2X9C23vNMYfA3m/1OrVOol+d9y1l7BTnrSj6
         b15LT8k//lk7a5b0sldMMZYnZ60JE5hRdlNuYYqjLNp/UK8SVwjbZJuuyZc82JPShA+f
         IaSJJifO6s09jtE5iHYQyrPZOgEBv/O5WxaNt1lID1wc9n9Y8i2L23OmnwHrDm2S7Hk8
         JZ9A==
X-Forwarded-Encrypted: i=1; AJvYcCUDJZkqBiwWysI9rCwykGJDdhnGeI3BIWkZL/TOdKa1lp+FUj/YruTYLRda+gYJbc6VUQCbQbzwPvPgCQ==@vger.kernel.org, AJvYcCV5EvKCk1w/SkCluPPCMAUZiicbbmcQZi+N0E/3JhMJSV2KsOFCeb8LoIIKDSlCYb4qG0obLzV24fgi@vger.kernel.org, AJvYcCVSr67yjc34wEnSlEAgY80faqNH3BHS5wQbRL5LU5A1XCLcdGizzpE/NP0Fua12uRSI28hz21+ta8ztwXI=@vger.kernel.org, AJvYcCVhHwVLOQblyliiwomJM2aJPph/ERj18BLja3AJkQQraJ87Fx9tXgxrjVqXsp4qlw096zOcnAkvgzKtwro=@vger.kernel.org, AJvYcCW3bH3ULj0oYyu6bMWTbYS0yRBEeW+/aXp2ipR3HOjbVW9T44IzgV3ol0rh9MF93W2mR4Ib5S9ZHfliZy8JLSgkAWI=@vger.kernel.org, AJvYcCW6bhiLv8ek0Q1yyeXSx/UEdHhZIYSpZfF1SVBiM1fotZM4USGvq9JQ1o1kQcWqIQ3OgOrWC91u@vger.kernel.org, AJvYcCWpzenRAar10HccXPA0TOxf+/V38oHvBuaw43MoEO+sx5WPPzQiZcrA46/zVYgInMSsGQi+w2Tee9fB@vger.kernel.org, AJvYcCX6EPW3aF3O40OfOOoa1koOyiMt5cZD9MZaQh/lWg4cJHagQKtzz3M7Ysgj9JvzNncpkjGDZMevfSlJlQ==@vger.kernel.org, AJvYcCXHprgRQ0Sk9ECWnuPvskI9QqIA2y1WcR9nRPyyT8xdOXu/nIqTcvZsVSWWEQaXfM3SyAmPC1Sje3AFaXQ=@vger.kernel.org, AJvYcCXofDoWwQzEcYgT4sGb
 rQ/tDRpF6A74XnaSm0+BfEvmCwDWBZ+7PvucOln9Fkvcu2g4emH4dvYuDQo2@vger.kernel.org, AJvYcCXuGoKJFB2IMRaLmwOFz+lFUlC8Y1YJwaDN05MM4Vn0YGhGQ5eN3up1TJ5wiDf4YaljKtyzeqASwgxn6A==@vger.kernel.org, AJvYcCXv/fCsxkcVs5l2kh3w3eC9vqPZEAXwo1YJQiQ8gGul9sgqiWfe8Lvs0t5rhAxK1Tvr2Vcowo9Hk9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKR+HNhfNQjzBJG2hE+n6vNilyr13ANZtiCoAc+kPkhVzjHuon
	DMj+yhuVlvXBvVp+AZwnbVrC7Hk5vbRUWOtjPahUea0ZMEsk67ui
X-Google-Smtp-Source: AGHT+IGR+QirVVYaqAddfiyk/xzIe0+jezJpQ1HipVxMkgdpmx3Jezg1xraTiUzy6MRmpjznsvCW5w==
X-Received: by 2002:a05:6512:3b27:b0:539:edc9:e81b with SMTP id 2adb3069b0e04-53b1a32f443mr4577191e87.28.1729796148509;
        Thu, 24 Oct 2024 11:55:48 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22420278sm1436475e87.151.2024.10.24.11.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:55:47 -0700 (PDT)
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
Subject: Magisk patch for android nox devices
Date: Thu, 24 Oct 2024 21:55:44 +0300
Message-ID: <20241024185544.14320-1-vladimirputin693389@gmail.com>
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




