Return-Path: <dmaengine+bounces-3497-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3699AEF99
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10BE1F222BB
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D166F2003B4;
	Thu, 24 Oct 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ4bFe1/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC041FE0EA;
	Thu, 24 Oct 2024 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794026; cv=none; b=iLS4Cr8xPYzWBKaYhJVB2te/QRZ3XEB0+mpHbm7hWPNEvCGA5EWhnYmyWlcD537+r+BWaMVq2/BUbpU8XwykDxMbD7nITQmU22Aldm2UcInQNh8tjd1HOSYhxBI5haghMlsrpOGPuWFyM1xbPRp6yE5YQFT0XvaN860EfME7Llo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794026; c=relaxed/simple;
	bh=wEkB3zq4LCxabrUV4KO/q95T5XBmhZmXXKdUWSfGc14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLuE/Oi45QRHDk2B5Ngtewx5T97rkW0Cb3DVhEnqXptdue3NeN0hfG5sE6GFgx8D1Fc0JKg+fdgrZ65YGK77q5tljAog6Y0Nrdvx4+oVx4WsQ1sKyDSBUzzfjtnlkW5eClW68IRRoszoz9o26Fp69VRFsb6YaU+rSoMP3vhr/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZ4bFe1/; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20caea61132so9311355ad.2;
        Thu, 24 Oct 2024 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729794024; x=1730398824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJRMzi03Xu9OgYRc3CEyzmmOuaUb/klqYsHXiTiyAMg=;
        b=ZZ4bFe1/iPRMb1EawhaHXUrhrW+71UYzE1XFHM7zo/rOpdmY6H0bURQXUnxwmQt5Nc
         X4h477KIb0/8vOncDbbCjLG9LJCobSkv6rSj/0OkZ7jMbPIXOjdcfnX8M0H8dNjQNYGA
         wYoKop8elWT5bsoI8F3Qxx/UE+5PnQC+q/W6yOnxTSjzKgCPkLFiwgOZnu3ccHWMfjrL
         SJL6obE9V7LOXRqJ03akjN+hAcV4wAS3+qpntdKjyNRaVRGuguDxURihn5XWuXoecbDv
         ToB06sFO9DGZn8bfxgLTOh5S8Y/cWAYVNdIgioQ1TnH3jHOIiE5wscnxiFs8z3JGPAPc
         x/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729794024; x=1730398824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJRMzi03Xu9OgYRc3CEyzmmOuaUb/klqYsHXiTiyAMg=;
        b=GQq9uqoC2uv8OB6Q1zcBJwLitnhITUymiLb7tCeYNld1klwQdgRhHnvixM1ci9jGMQ
         dL5kEAEZqomOGtL+5s9gLsXO+XMkzm6Bbz0lVsk9P9rnXhHV3kgKRuDCavN92qfhHBb7
         RD5oBhS+Aqaj0BSmqm0fveMy/RI75dKYtg/UVF1kyVamFk7PHboBcwRoHhebvyzXIkY6
         zyJeUZKL202lfxmgyRBeLGLzVOPUpW2G3C9TOKgciZA9nF9/DarTCbqy5omKZoWKFKkl
         xsGZWRrs5O7UIIePiV7ECuFbJPRhJB8jyJzHP5ceYoR9PtZQDeJCI8PcgYCKPVDRZqkW
         jG2A==
X-Forwarded-Encrypted: i=1; AJvYcCUfce/kltyyVvh8b1WCJYwEXJTJ2WXaMegbfLcQMYHvKQNUujIch9VdmsdV0ytf6g0YZ95qzLf/@vger.kernel.org, AJvYcCUuVMWUSCG7JrAZEK0pU21yFjVN1PQOBwNgEye5nxW3h0R8BXV0HCIiClorbFCKYxkz+ZGMjUAqvssBDJo=@vger.kernel.org, AJvYcCW4uJu9mG4i7clgF9NpgbWyQNbrxMtU5mwQ02SKLEmiZjVm5umMEREnrObgyZoCnaN4AgIgJ8tyQ/SL@vger.kernel.org, AJvYcCWJ8sGfC4tBhwKLFFiRiVN4dGZF0+wIe2gP0mVso7JQkbP7ltBeu+zya85/AIjfZvvFE1qNRg7sG2P1WARQ@vger.kernel.org, AJvYcCWRVzNyhHBIQsi/B/u4g4Ta/5zIa4UEYXVSkgV8tYHaXugraZiK8tCo1GLItqvtgeU0uUTt5Wm7qhel@vger.kernel.org, AJvYcCWed/noCn+IujYXy2k0Rl4YMznU1mUvXq/ZyF7tDrp3CV5U3qZpjaT9/bgtEGjzKpnlvt7lEIcn3babrZMSFQyfc2Q=@vger.kernel.org, AJvYcCX0q6YTiVGjpufQYlJXYxdclsuQDC2DyYPcG8M183OPdaDg3/Y0gDFffrK1+IUc0TM4y0fOimWdG6HPg529@vger.kernel.org, AJvYcCX5DYB2Fgc4ch9AkyZOozndo3wFuiteHnfqj8rHQwzU9u9KMXEVbpTDAHV3r6kamVtSuEXmTPN74NdYxw==@vger.kernel.org, AJvYcCXjiRB7/kGZgbGmGMJj4RgiDtp7ojutaLNKZIHoUZl/UFMYkgezNhTEW8MSWr0jikQm9H4OCoIupG7B@vger.kernel.org, AJvYcCXlbektPWH1PNRQcznzJu9k
 iq9d31vwPcjZ31IqQk2P2k5BbdsR5awHod9uZqCR5BAsNyulLcIsTTI=@vger.kernel.org, AJvYcCXmEgtwQqSpWlQSYBXBDcnuvW76U8Hnuv3Z9XBeTbsM3oF74LhB7RtUL0p+ywE7OjvMW3UX/eLQbFUtsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaSJH10gSKfyVBSZ0HmRZtKELdDIYflDgiXsuZezk1Wgg5tstc
	r/nwiBPhoBEPLhVzhztg0B/sPZD19SyhHUvkG1xPpCQG3YzTii/B
X-Google-Smtp-Source: AGHT+IGYKpMxQstbgNZ3LiMaRt+C1kt3vQ5CO9mGWGwaEAcyM8hDC2KY72x67dsHopqzCGRceRlU4w==
X-Received: by 2002:a17:902:f785:b0:1fb:57e7:5bb4 with SMTP id d9443c01a7336-20fa9e9f8c6mr74829205ad.37.1729794024010;
        Thu, 24 Oct 2024 11:20:24 -0700 (PDT)
Received: from localhost.localdomain ([240b:4001:20c:6000::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd53dsm74915625ad.122.2024.10.24.11.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:20:23 -0700 (PDT)
From: Hantong Chen <cxwdyx620@gmail.com>
To: tytso@mit.edu
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
	cxwdyx620@gmail.com,
	dave.jiang@intel.com,
	davem@davemloft.net,
	dlemoal@kernel.org,
	dmaengine@vger.kernel.org,
	dushistov@mail.ru,
	fancer.lancer@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	ink@jurassic.park.msu.ru,
	james.bottomley@hansenpartnership.com,
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
Date: Thu, 24 Oct 2024 18:19:16 +0000
Message-ID: <20241024181917.1119-1-cxwdyx620@gmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
In-Reply-To: <20241024173504.GN3204734@mit.edu>
References: <20241024173504.GN3204734@mit.edu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> However, note that China is *not* actively attacking Taiwai=0D
> militarily, while there are Russian missiles and drones, some of which=0D
> may controlled by embedded Linux systems, that are being used against=0D
> Ukraine even as we speak.  Hence, it should not be surprising that the=0D
> rules imposed by the US Government might be different for Huawei=0D
> compared to other sanctioned entities that are directly or indirectly=0D
> controlled by the Russian Military-Industrial complex.=0D
=0D
I wonder some of Ukrainian misiles and drones might also be using=0D
the embedded Linux controllers, and why aren't there any sanctions.=0D
This cannot be used as an excuse.=0D
=0D
What LF and Linus done will inevitably create a climate of fear where=0D
contributors and maintainers from the *Countries of Particular Concern*=0D
feels endangered.=0D
=0D
This is clearly NOT what contributors truly want. People from around the wo=
rld=0D
once firmly believed that Linux was a free and open-source project. However=
, =0D
Greg's commit and Linus' response deeply disappoint them.=0D
=0D
Open-source projects might be international, but the people or organization=
s=0D
controlling them are not. This is the source of concern and disappointment.=
=0D
=0D
> Of course, if China were to militarily attack Taiwan or some other=0D
> country in Asia, circumstances might change at some point in the=0D
> future.  Hopefully Chinese leaders will pursue a path of wisdom and=0D
> those consequences won't come to pass.  Ultimately, though, that's not=0D
> up to any of us on this mail thread.=0D
=0D
Finally, I must point out that Taiwan's status as part of China has never=0D
changed and will never change. The term "military attack" is therefore=0D
**inappropriate**. The move to solve the Taiwan question and achieve=0D
China's reunification is coming soon and before that China must make full=0D
preparation for the upcoming *sanctions* from the U.S. government, includin=
g=0D
handling the issue of high dependence on any international open-source=0D
projects.=0D

