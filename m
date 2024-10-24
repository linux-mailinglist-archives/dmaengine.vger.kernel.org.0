Return-Path: <dmaengine+bounces-3493-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7959AEE55
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8343281AE8
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 17:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617AD1FC7F6;
	Thu, 24 Oct 2024 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1JjMb11"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DA91FBF78;
	Thu, 24 Oct 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791540; cv=none; b=lclqTSuzRHzdlgT2BfolYubQx2mE9K2jODuUjKaHXXtR2VjH2MQ33s+2IEOZZLtDz8IiCP8+Ux78iA4yIlx8JMX/2TiFypp6TgMufa8LzQcxVpo+dJUvs8AcxI6kGs6pWCCjMLxLMJWDmthZD73Pshgj0JYNnQ9tXfwygaIHsz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791540; c=relaxed/simple;
	bh=8WJnbrt2+eyPMiVYG09me24q/mcBtJcn+Lsz0IxKsZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+xQA5VwtxQ16haexufUJxFmQldaea3HHsZFoxV1hAOvJzhW0ejIKw2ZWzh6jdavG0V5ud/JzhbCBR0iC/7APQYzffZ9Q+PhnibebJxMo/TbPYcjW2s9wCGu2hHwSCD9MPxLxlCT1QVATTPoP8gPyWJZOV4QFHq3wCly5Cis8ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1JjMb11; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539fe76e802so1554599e87.1;
        Thu, 24 Oct 2024 10:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729791536; x=1730396336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WJnbrt2+eyPMiVYG09me24q/mcBtJcn+Lsz0IxKsZc=;
        b=k1JjMb118dsFYjCSHYW1Fg9ZdL907l9C96EF23tPLwnAxAvxoWbFaofuNdtkgHT6rH
         +RuW3jBfmcTnutdnyFpnYfXft34ewD1c2YDnbdm/aIP96hSIeuuypc/LOESQKNQMhd1u
         TW0uAwi1BslA2qzA3y39ZiRK4mDUTrScBO1IWLjfs4/6fgOpwx12Iz+A08W2pbHehLr+
         TgpilJWN2ct1+P7oJNYukBubxiSJM/Y+Eco3DJwH7CtH2rur5BPiUAmWMlGoRYikeDM/
         0R59CSTYMd7EGmR2vC/DtSjIh1bxzefZUKZsi30dYvRjwbRIFSnpmwoj+NZu3aWGPSlZ
         AxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729791536; x=1730396336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WJnbrt2+eyPMiVYG09me24q/mcBtJcn+Lsz0IxKsZc=;
        b=B2IyLFeSncWyqr1A3NDVnxzWruqQcFqF0MFY6At6bOMYzA1ERCOPxeEZXS+YGTe7A8
         j2271in/dhQydDjPYC96AfYoSipQem+tbEALRTKBGxCaO9YwtTqw2ZhjyzMaiwf7vP91
         WDZmAwWFUuDLqpl7p+AsUYODtPzjlPMG69a5lqHck2Wi60uRaGS79Q2/H2OcnjWdfyEe
         NgVV/lPz0P5kLfjNqy84GNsfamRsGe8sRnwx3laRfp1JjqzTRetoZIE/bGtHf/5jJRd/
         xV/UV+SlYq+hudR67hXVXywYMvSoBDU8DPGMbTsTbmWi3WSN5Chdh7t4eX/5RVg9aU1K
         HseQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA1AdS/G2JBISRT3KBqDIDlqDJE9cXCpAhQdHNBw0gcOt8X97tVGRnVFj1TfiRO2NnACSxK5cEMwNj@vger.kernel.org, AJvYcCUeNQZZpmZZwQMecf5ZnroHh3AUUWy3AK/wqIvIlD5AigpMKxP3NwPQbTGPG2PxDRn7tYWluEfFreYi@vger.kernel.org, AJvYcCVwrKESK4zCd2CdCoNxtOyisOGJmV2+8bsVI0akfZtl/fqUtSiyX7YuUJoQJnyIP/GKljCXUYwxI9pykbg=@vger.kernel.org, AJvYcCWHCqLpedMcQl4n/V8bcuqAOG49dBslE+QIMulsCQERI6kT0bgy0JB7FXp2qoO2d6z+CSvS5eoGVrY=@vger.kernel.org, AJvYcCWQOs8fYGeZUe13aeLMFm5AUz1JJbrhEOazB1yp9FPbTgGfZjNYhRV2KQI9/3PtwAqFYU4W2Yq26YW1MA==@vger.kernel.org, AJvYcCWemBXmukxrYULt7bO+2RMPf8IBDSiBuwcM8wISB2rg290HTciXM7vQh0aNhazOyWfvSII6pGz5nta77A==@vger.kernel.org, AJvYcCWksYbsq2UNmsu7fl79lxstci1EFdcpp7hj4V0c4plqWnLow7ejLhflG+exmJpt2VSGy1rlCDTd6kQS1ks=@vger.kernel.org, AJvYcCWtUTsGWp5BcPWot+Ku51O7D0b4KQBxHFbs7GqZkPepA0K/Qyvt5JKPupG1jzF2UnOsfqVbDdTp@vger.kernel.org, AJvYcCWv0Mp/vpy5OZu0vhNeUKeWfO9UdfDd1iB8R+/bbDnuSB1/lYEi8V+Wo+6GqpJMfysYrQG2l+8y+jgk4vAQ/9FaSCI=@vger.kernel.org, AJvYcCX7Fdoi7Z4q4hfebhnDW5gc
 5FKHneNGzVBBKqt9BpYdUQxUzrL4JxYl8xUc5ySiGY1xI6tDad/zd7cOFq0=@vger.kernel.org, AJvYcCXJ54+VAKpODHwyPtNeDkfFD/SsInh1CCdK4LsvQ0qdGV117h+7xXY+xzSCbIIZpoE8NpS/IJyIu7Pq@vger.kernel.org, AJvYcCXaxuJyzAFQHMq9Y+IlmNFgqSEMMufavZ7ZF5SHe26QJDtUernuPxXp9NobsmN4LKq5znxkEb6CKTXfSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgi09+v6a2tY4vJmCwjwA/9oIgXi9fCCjc/0671BJGBmwYt+6p
	JKic5CHlzIEE8zvHJ2vWYGrj24Ij9x8CRr3TWAI8M00D+1JmiRJj
X-Google-Smtp-Source: AGHT+IHBgp08+X7VDah7A1PXK+oh2J53hxr+ZwxrWtWH2iwrLcyRGNg7D7RBAUjcie/LivvlgLDo6g==
X-Received: by 2002:a05:6512:3a96:b0:539:e436:f1cd with SMTP id 2adb3069b0e04-53b1a306993mr4517544e87.16.1729791536088;
        Thu, 24 Oct 2024 10:38:56 -0700 (PDT)
Received: from seven-swords.. ([2a03:d000:2:9006:4eed:fbff:fe72:e806])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2242024csm1417428e87.121.2024.10.24.10.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:38:55 -0700 (PDT)
From: Ivan Epifanov <isage.dna@gmail.com>
To: linux@roeck-us.net
Cc: andriy.shevchenko@intel.com,
	aospan@netup.ru,
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
Date: Thu, 24 Oct 2024 20:38:51 +0300
Message-ID: <20241024173851.245260-1-isage.dna@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <68e35542-d360-4a37-9ff1-16fe76594b6f@roeck-us.net>
References: <68e35542-d360-4a37-9ff1-16fe76594b6f@roeck-us.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Yes, everyone should do that, and I did.

If you did, you'd knew that their defence ended in 1940 with peace treaty.

Surely, Great Britain, Canada, Australia, New-Zealand and Union of South Africa delcared war on Finland in 1941, because Finland was "defending", right?

