Return-Path: <dmaengine+bounces-3563-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A619AF7CF
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 05:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF731C21880
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 03:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E9F18B491;
	Fri, 25 Oct 2024 03:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLqQCNOz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F15175D56;
	Fri, 25 Oct 2024 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825272; cv=none; b=ct32Bu03ozxO2Odx+8e5XUGTCl3raBuj/eCanWS/2joIMYITIMu9LJ/9mP/oKKwkvLKIpu5NWI0SJ3gQ4ggWuM+teKU4il01xVLF5gLjZFnkFu7iVPchz1IMERD1ERGgCMSfFM9qPoyGc2Vu+DAEkxc4iFBg0e4zwTvZ6J0nNCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825272; c=relaxed/simple;
	bh=6MTJVFMqnnCJNbM2dONSU/ki5kij5KTFX4y1XsBSR7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEXtMH/7LHLY/4ml85GKi6EQY1OjLTXnSebhoo1LVBYT9vEGsxEbmpuF7hxtZKx7IiR/cCGOVQTLakazUIt3bTBSJk7RTuW4juNQtcsFH2AMVoGPmGkGswBauXR8Pqu3KpOJUoneW2eGla4bl9qH4O6oceCL5WmJqI7aah/YLos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLqQCNOz; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so1841873a12.0;
        Thu, 24 Oct 2024 20:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729825269; x=1730430069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MTJVFMqnnCJNbM2dONSU/ki5kij5KTFX4y1XsBSR7o=;
        b=FLqQCNOz+aLWAmnlIrQLVA5+tnfEUR8GbNAKiDnhdf6xqLZdvJnkQBxPUyt6WShLCr
         36AWJQlZz00vcnEyhruScAQfWZAJt7S57R7go5IgsOmcxFY1Xc0j6/1w9YKeDrBqgx7d
         dxTXzA+skRlOac6CZbc1JtO0bqtGmhhSrruUrb9VehPbx8BYSgnHWUQ1/jVsEAzaQMzq
         4GEaIy/mEQK9VP8HNjaZTTqViibCcRZOMn2LaskNcVRBdU1u+zfpuuEJx7+gs5EqJgVO
         hGrKIv522g/dicK18lph39oIgGsSk//D4+yQSv41PWO4/ofieiXQwN6UT1eujmmWH6ut
         oJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729825269; x=1730430069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MTJVFMqnnCJNbM2dONSU/ki5kij5KTFX4y1XsBSR7o=;
        b=f0GkccfI2Aw0zN/bufZ8NhsS/ppUh6T8p7MoNXjlftVS3GAHIYe4Fz6oXYAIkL2i/H
         LaQ68AcJKsshWVTlla+KAAfg0mP8dhOnFwzAHfDcPTNOVVvfQ6GPCSj4wYCBkIJaG+Xi
         FWpyMiC02d8lTL0DVzYqjV/AEQ/jKPhJRI34YZman5cyS9GyY80264B2QUPlkp6I/lxY
         CjAxIB4sgOJLLrZKhkuaVTC8UljwFVYeMf1vUiLQwfe5XvsjDht0r4mSuYVmETDqLwRf
         22zwU68HH4hgJmpm6ZepdPFS4coJEaStIaqceA5EZyvuXSPIizKks+MIp8MdHQzp5KHj
         SvDA==
X-Forwarded-Encrypted: i=1; AJvYcCU0jOCH3SlLcPZAjRQZt+TCOS/8hR3+RKSoA/cQLhEX58zMDHPDoL5FVfwOuUkAE7TVJEA70ZsFq945WIxA@vger.kernel.org, AJvYcCUAKSwyScRmcn9xhiPolxb+y3uSHKIa8cptD+eH3ydLZh0jmBKjx+jBlf/2whYfNQQ23Lp8ZqvHuIQE@vger.kernel.org, AJvYcCUJTXrjxqf1bb89eyVvM5fu67mwI3EYCF10fMkJYFJFi0bkVRCfibemlrAsEeAh6h2rihOhQk0RKt0=@vger.kernel.org, AJvYcCVSp7o67nV4UOdrAcWv5v3DOoX3e4vKfPwjqQT8qvn8Yr8uvgVdSqbhDIqFHlFTLorNV+26bvVDkfRsDmOl@vger.kernel.org, AJvYcCVYtuwumXyfAPBHzVFolQk/n1G8QyKzJCB3sy0Zt2KBVkFKI2HO4O98gOTYj2RucGVp8dAYXK00Baehc0M=@vger.kernel.org, AJvYcCWD0LeA1cNQt1b5F+EOiJbULTRIl3N/D+EzZJxrVAIi6XZk6mfYWwEKCvpxjCJRUbAZ76YG2zPDQ2Dv7A==@vger.kernel.org, AJvYcCWfijIDJjwXNa/2Dd2dekN5PVUz18TgF5o/xlG2CZUF6rtvHprkXEax0yP8ON/iYNpHxqFYtAEY@vger.kernel.org, AJvYcCWtBZcxkbMg8TfMEpFhEug7Vx0G5esnQgDHFcXf82z0NypItNF2oF4m5xJtBh7jMyKP7H95gZVI+yp99g==@vger.kernel.org, AJvYcCX33YEBa7R2BMs7QaocMaG67r8/assMY3M8lNa4gS/MoSYPMSj4j5AJPYWmQadrSobKurLPbo8iDZdf@vger.kernel.org, AJvYcCX656ZNZpEgwuyr8CJDuPwxP8SYyXM2
 i2J/mePhG+i6x24tOaWlCnW5U8+k3gi3Ovy52RGhYjDmQD+BSHZ1rFCXvI8=@vger.kernel.org, AJvYcCXFbxyndUwDrPTQk9svhLUFolnPnl1TOmjSUPnjFdA/rXQe6Q/UZbOd+VRU34TxplZvt5jk5VHttIJa@vger.kernel.org
X-Gm-Message-State: AOJu0YxXfZqHDaF0hwMs2T93sqG3XIzhK4XqiGix+h9WyV4G2YWmDDKV
	mFoJrzTJmy7QspGgD/6pjasQVo+qSRaD0fRTYnaQ3cn1O4W4VPvJ
X-Google-Smtp-Source: AGHT+IG9lTruoJuiWvD3/I0nGa0uNZQNR6Vtf4xab40cqpRDyyMRJml+6D/43J5oPu7AIVVa2dAxUA==
X-Received: by 2002:a05:6402:84a:b0:5cb:674f:b0a2 with SMTP id 4fb4d7f45d1cf-5cb8b1b1f0amr5688194a12.36.1729825268315;
        Thu, 24 Oct 2024 20:01:08 -0700 (PDT)
Received: from localhost.localdomain ([92.60.187.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb631b0bcsm121582a12.60.2024.10.24.20.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:01:06 -0700 (PDT)
From: Oleksiy Protas <elfy.ua@gmail.com>
To: d.milivojevic@gmail.com
Cc: ajhalaney@gmail.com,
	allenbh@gmail.com,
	andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	andy@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	broonie@kernel.org,
	cai.huoqing@linux.dev,
	dave.jiang@intel.com,
	davem@davemloft.net,
	dlemoal@kernel.org,
	dmaengine@vger.kernel.org,
	dushistov@mail.ru,
	elfy.ua@gmail.com,
	fancer.lancer@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	ink@jurassic.park.msu.ru,
	jdmason@kudzu.us,
	jiaxun.yang@flygoat.com,
	keguang.zhang@gmail.com,
	kory.maincent@bootlin.com,
	krzk@kernel.org,
	kuba@kernel.org,
	linux-edac@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux@armlinux.org.uk,
	linux@roeck-us.net,
	manivannan.sadhasivam@linaro.org,
	netdev@vger.kernel.org,
	nikita.shubin@maquefel.me,
	nikita@trvn.ru,
	ntb@lists.linux.dev,
	olteanv@gmail.com,
	pabeni@redhat.com,
	paulburton@kernel.org,
	robh@kernel.org,
	s.shtylyov@omp.ru,
	sergio.paracuellos@gmail.com,
	shc_work@mail.ru,
	siyanteng@loongson.cn,
	tsbogend@alpha.franken.de,
	xeb@mail.ru,
	yoshihiro.shimoda.uh@renesas.com
Subject: Re: linux: Goodbye from a Linux community volunteer
Date: Fri, 25 Oct 2024 06:01:02 +0300
Message-ID: <20241025030102.319485-1-elfy.ua@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CALtW_ahkg9W0wm09cxkJxiSQCH=42smeK=fqh5cQ9sRSNsjeXA@mail.gmail.com>
References: <CALtW_ahkg9W0wm09cxkJxiSQCH=42smeK=fqh5cQ9sRSNsjeXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Brate Dragane,

I was not aware of the fact that either Raytheon or Boeing are directly supplying the Russian invasion. That would be a concerning development indeed.

If you possess any information of that being the case, I urge you to contact GUR anonymously at their official whistleblowing email: gur_official@proton.me

Thank you for your diligence, only together we can stop the war.

Kind regards,
Olekiy

