Return-Path: <dmaengine+bounces-3526-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3989AF147
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95780B20BF6
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ABE21BB03;
	Thu, 24 Oct 2024 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1qz2wN0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5FC21BB01;
	Thu, 24 Oct 2024 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796893; cv=none; b=Lc5pkbicU17HchwM071FRM6PeXFwjG3RyStlSFOPzY3sBUDwv314taq0az+7/0o9qf46hkSDkBNHbqoEsL4HBNnBwJfuKmolFh2TyVghaaMZenGSusAbRHr9IgQuIptBIMXQKFulyno7NCjypXhQpLjoxu7VGuKfoBuP+77sGho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796893; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEj4c3RSy4gTbcT+MVYlovKZDWexFrr25nAjlOsZJ7jcIkl5LtLiTA+3kr4Fgx12b4nZsEl+RYmNPXWHgFAN34WAgwt057ukFXlDFG19eCJg4Dwu70YBCWVNM7UChBpGYX3rN6uaWVcqmdaJtO+bKgepdu7AcEGFhVYo2Zv8xNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1qz2wN0; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-53a007743e7so1590582e87.1;
        Thu, 24 Oct 2024 12:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796890; x=1730401690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=E1qz2wN0Ttxc++qyCTxRy2RvVOBVgjwCBMtgeBLB5PkXoIiF+jaeWhmeft7oaN3EuQ
         jqzvfGm6NhX87cMBQlZBCJrPZvku2DvD3tDcg2pt2YPAhtXObsaSAoNthpb3vkmi8Nin
         s9oBrWfvEuWjCJnyLozgx/bDv4ZNn1boHOMYNOROcYStdtNS/mtl2W14lP1HYrWd2GqC
         OiAtJzmcFfu5k4TRgbzklRNiSai99aNSK7BUfrpqb/iyZtK52xFaBnXZ52MhVd9jKUvW
         jqvFULBzNcXcpxJzG1ebN7AwC+ENwamw1MgkJLOeW+JTPCJ89SS015ZVgaIBxNb4dVWg
         sHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796890; x=1730401690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=fmW5TqwS1ckPWgk2fshF28xGwqhI3e0LdRGBTd3ekbMY+QqG+toTTyKNhqsJu0DaI1
         l7xPE9rk2CSpZv5eyoXkja+wY4iS+HdypwaGoXUyQoFGSGyobD5JQ5QaxYLC4fOlyay8
         EQ/KSLajVTE/+f9gP3GtV40ULC0CH+INzBVd9L/XUVo1776oow8KEVtMASMmQlyOl4ks
         dFRThWvGByMqe8wS0hMeoVUWWTCvb5TxEgC7IteYxqYB3O0LdLGrU1ad8/axxah3vXqS
         fzvREia7BL3xD+goH3H/91iFR3/SYWtIj7sImElXpDiV9aafBx6QYo3szxW7Q0/jzSLZ
         K3ww==
X-Forwarded-Encrypted: i=1; AJvYcCUYuUKvYxzskEp93OULGclARxhX2KwC/RetLBiJvXqFnExKxzjDR0wYWN7G/3igAftFTjDmWmCGJ1U=@vger.kernel.org, AJvYcCVBmzbqI0sA7rjfvACUjTwbBfDSqJcYg0llwT76pZMDg3MEmKeuZBFsGP1KhDYsL+LCNJSwK9C4R5R6OSA=@vger.kernel.org, AJvYcCVE+xrUFv+njt/gRzTnOxSdoZsbewOSUGqiR22J67T2NfJj8q+JzVU9BISrothIK3LQzMfIrORV@vger.kernel.org, AJvYcCVEtgqhmUF8J9ZZ/Bw0yJcZCbBvKba8I2iU1245MabSpNw6uZXrZ0uUd2eLgE397/5PUZmkEI4Pzzyfqg==@vger.kernel.org, AJvYcCVHnlvRyz3r8KX7EDNhT+0WyICw7VHnOAAnRrJSxQXIPgCiSzKbvz3zXKMPz5GLnd2t9Df5XKvBaZXc@vger.kernel.org, AJvYcCWRjriQDrFcqW7K/YGIbPxC3wUMgHvwb4pwKMn4+oAPZB3t1ePOuq0TXqXh+VN93ciiEYABJDvATk1dMYU=@vger.kernel.org, AJvYcCWdKA6keMlwdQ9jkyU2wZHZkVqAYoPG0V72p9v6RfYeUJbNCGK3l2y1Z3ZnKi7SCSzR9YPu2khSTZNZ0oU=@vger.kernel.org, AJvYcCWnqu7SGhdrdLjClelDngaWRlB/0AItTWNRfOqOkyiKIjFES8fQ9GvVe/6mARvlnowRSlM08Yel1AyF@vger.kernel.org, AJvYcCX/xJpQZmujIbC959KUSsK0q5WBJfg4vavda6gHB+R2oEb9MV1jqc8mBCEIkLXSxfd6AUu1VpEQjs816fAh4s8pToU=@vger.kernel.org, AJvYcCXBzqizK+EIxc4W4PCS01k0
 iLdFOACSGw9sWgfemGuclfrt9Z2KFZdOa0sbZJzvVWXJo3P0ojWYtv9ysA==@vger.kernel.org, AJvYcCXHlAH949Gnu2YQjNlDlYqeVNmZ4qlzjKJhw936b0tfbMnvZ4qFFpdfcrkcsq7XC+AR0toanaqC9a+i@vger.kernel.org, AJvYcCXdAFXAjASiMBdd/1YpF5OTGkpIj6zNNm2dsLe7qJhJczx3M/zZ0jPZC4dry9bCScIb84LEYMl/Di7tfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd9bPv6zhzm8XhLruSji8AngeiLSD++ZK0FV5/MbygMskVOiwa
	sI1EGtBNrhTmoPwf5V8afE0HTW8edxJ7h69xNpoIIDVIyLBiatSE
X-Google-Smtp-Source: AGHT+IEd9nZawShFz6CYN6J6iKZ0U8QzKV9wET/JcjIZ6cvtj+uCrnkNxNJF8knF4itDcthZdOwqdQ==
X-Received: by 2002:a05:6512:1050:b0:539:fb49:c48e with SMTP id 2adb3069b0e04-53b1a30c01amr3880373e87.11.1729796889514;
        Thu, 24 Oct 2024 12:08:09 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223efb01sm1466371e87.70.2024.10.24.12.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:08:07 -0700 (PDT)
From: Russian Troll Factory No23060182024416380525440170451926936691156862103912740708129141738823946402926672226902566110254283736742249027058607213094 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:08:03 +0300
Message-ID: <20241024190803.14530-1-vladimirputin693389@gmail.com>
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




