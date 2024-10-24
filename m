Return-Path: <dmaengine+bounces-3486-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22E9AED20
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F9A283538
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 17:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAFF1FAEF4;
	Thu, 24 Oct 2024 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUEdgnUn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6891F9EDE;
	Thu, 24 Oct 2024 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789672; cv=none; b=HqfEzdNIASC0pr7Vm0f93mAfuV6OwSTAKpgEick+v+QcniAI2RjmpQHVXkHYF1RzOEMm5g+TnUJ//fCLKaZmiZxIv5TxmsDU6YBBfHWFFhU/kqNYlYWUmrYLGAkINfNRYIppUZ/kN0dLv9pMt40QQgdL+Oc+LY2ReydrfhuF+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789672; c=relaxed/simple;
	bh=wRR1+SsfuQg03dCSafmMEZ8+Tf+vTRsuGcUvfSNBJuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMmyEH0vCnAsyM/g1BoRKO+bAkpOHGkvokSjD0j/JRs0TmZHxLxALZ8/8014SUoefP/M8HuggnMoRGPbiSprMNMw83SXFGVxUy9jCS6EP4xqaT+MSQc754phC22lhc6xYHyQRfDMHgpq1V1hzALd4OvmMmSzWMsmUDJSFos+POU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUEdgnUn; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f72c913aso1543967e87.1;
        Thu, 24 Oct 2024 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729789668; x=1730394468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4zqWpgJymZz2GSVXCHfh3D8JgL8gK/HJOJAl8/d83M=;
        b=nUEdgnUne667825X+OmNdHDETk80Nbo9fxB/dCYEE/xDAd/ZU23Fyb43A1UOAUb6+h
         8SZsL0yn5Tt3oEX0v2rT5LxsOIxyF5HbjQiySA/iI8CKFcEWZZkYHg9/Vy6D25FEoIlH
         tw/rq3tL+VG/tlW0PLCf9SbiuJ7o1oVpePpNvLdL5mJXGRh6uaJXmxHpVitlmzv87gXS
         1CAqTZMgFPoRe5+IEQ3HdUQDYwleNsCVzGjnqHiQrUCG7CAx27xQWT8WAlQ25P8JVtNn
         tmq5dxaDPn20ILV/w4ZZIW210jpn1jf6jYNvyW1Hmrc7hxk6omO08/mqn1MlG5pTPfXQ
         QmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729789668; x=1730394468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4zqWpgJymZz2GSVXCHfh3D8JgL8gK/HJOJAl8/d83M=;
        b=G7JKM5u3Qq37zR2DJPySPG7S3tkcsNcpLWIzciqXntDNhIyDrnhtfeTMu3V66JmNCh
         57SCylkfeMlvBr265B6OrQUSnw5xkpD3LJDAjiI9oJIN0km+6qwYBtM7KsiKS9erCXw4
         CKVA5ZCRu+wQ3OlkDjM5mFKDkUt3hb0EAo6Yv+SWaqMFJUn3tiPa24JeN80VsmfXsThQ
         AUsM3IiGDcD4x1qY8RZKQpMJ/DdnP514xZcCf74KEVcWO2Z0ZIccPfey9uIJRhQHtFjg
         FBxZ+YDhdNAnwHjikR/LbFgsbr4d1YJDRuE+EcrNi46UJSS3eFV1ivqepAocYXGxVKhr
         tCYg==
X-Forwarded-Encrypted: i=1; AJvYcCUNMLbJ0EPb+HAs/K9qUlHtCPKlHiGlWUGh+0y4xSzIRNVVPQoo6AyCYIM9OGjc5h53yCOPhnfhvIw59/8=@vger.kernel.org, AJvYcCUfYGxsG240HcMW3/ox2/3qyAgdaWd2b+jy3XkxksGGNEC4M0/l9BtgEog8DVwf3by9bo5QkAUqzr6w4Xk=@vger.kernel.org, AJvYcCV+7H6PqeRhSIc4tH08XNhNSogVgXEJ8afpaEFq8xMhkHj+jn2mUBE3jXZGAFXydK/+AryrGccXkeTn@vger.kernel.org, AJvYcCVogiEA7xXZWxjOXlVKQoENY2IVwsUfccVIsh3hOO1PEEzM5Y3snePcQDRctavKq05Omya2m0bs@vger.kernel.org, AJvYcCVraQRXjxrZww8ABUMrXl+Da7AWBfK7Gi6QErk7P/hzt0gBOA7F35FThpVze1SKKMwdDgvC//thT/k=@vger.kernel.org, AJvYcCWZvedpmu2iV3MTWNmtabhyW8uYCaGDP5MDP4J8u2tuP0b/R9zKSJylniboBrOAg9KGzZiNZca1nAXLf5Y=@vger.kernel.org, AJvYcCX4hHHu5THQi9ELJ4y6LQsn9LoFl6LT3HdkeUcSv0UgBSU0qgivB85p+t30JAPBweTDYCIyPW7QgRjY5w==@vger.kernel.org, AJvYcCX8g6iNQ0Q22dqwL1K2uKBQNDbiskaXowNo9OL3tQP/x23v+W8Cmj2P+BqD3ebQBn8wog74T/7QeHJ5GZCiAoPi5OE=@vger.kernel.org, AJvYcCXERdBY4LGFH6FeBaMpRdnXqoKUTXPCZ3MIIguGqRBZx43Fov/yocfNWiq1CfW002E9uH5IXduGK4op@vger.kernel.org, AJvYcCXHUfgEyBOUVmTpu32Kr2en
 7pA/ZuMGJsmAzgbYyAbypBaLJefHZt5qC0qVXacHMWcr/Id5SIlAMHzFsg==@vger.kernel.org, AJvYcCXazG8Epe26vaGiZg19XiHnGe3k+UHu6ZwD2Vto/sGHEGbOl9zquzKUv+1VZH4V/DhEBbxrrkwqc749dQ==@vger.kernel.org, AJvYcCXtdIdn7XNmZJ5X0PivQscrsOG6g/VuHtPkpFnLy0gL6FUig5T/yQ2bogfdt7XlpkhNiuhYnTPNM8L3@vger.kernel.org
X-Gm-Message-State: AOJu0YzG7KfFWD7hYLJ0Yxcu9hy9weJelI2gazF88BpZWqYsFSAq0fAB
	zbvZnWuhhpXtxsvE5Wqh3Hpq6BaeXlfy1E2hpzWesJ0BiSdIQwoO
X-Google-Smtp-Source: AGHT+IFz4e5V/ZhUT+FzKXu68/7/HX9Chj/TG/YiHuqSFphTBJiVCK9htk4MUJh3OJ5HcvAjn4kgpw==
X-Received: by 2002:a05:6512:1054:b0:539:efdb:4324 with SMTP id 2adb3069b0e04-53b23debc01mr2073012e87.21.1729789668288;
        Thu, 24 Oct 2024 10:07:48 -0700 (PDT)
Received: from seven-swords.. ([2a03:d000:2:9006:4eed:fbff:fe72:e806])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b1f30c189sm447396e87.51.2024.10.24.10.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:07:47 -0700 (PDT)
From: Ivan Epifanov <isage.dna@gmail.com>
To: andriy.shevchenko@intel.com
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
	isage.dna@gmail.com,
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
	torvalds@linux-foundation.org,
	torvic9@mailbox.org,
	tsbogend@alpha.franken.de,
	v.georgiev@metrotek.ru,
	wangyuli@uniontech.com,
	wsa+renesas@sang-engineering.com,
	xeb@mail.ru
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various compliance requirements."
Date: Thu, 24 Oct 2024 20:07:42 +0300
Message-ID: <20241024170743.241144-1-isage.dna@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <Zxpqnf1M8rPTB4DN@black.fi.intel.com>
References: <Zxpqnf1M8rPTB4DN@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Proved that you don't care about users of your product either? Sure

> $ git log --author="andriy.shevchenko@intel.com"
> $ 

Look who's talking

