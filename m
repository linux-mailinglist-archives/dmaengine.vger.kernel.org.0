Return-Path: <dmaengine+bounces-3515-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB29AF0B8
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BA31F22BBA
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072F82185B7;
	Thu, 24 Oct 2024 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXJ+MWtt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808ED21831C;
	Thu, 24 Oct 2024 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796846; cv=none; b=MKMs/RRzMwu/QyLQiNZVWaV9dtrXdHclyMFogbvEMDvM28HDBRv7BvuI/yYrl6Ch4IeGBQMgLjtZrVzk1hcX66YeBhQI8oIphPXGCmiLGbGUG/lLIwuL6KXDMVNHMgvPjk92EEbfXO+3nzuDnoBXJnGpkKs5UGW6qjYOyF9Gsvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796846; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g22tf2/Xj0Z5SDdoHbsiB9TfEYqrWfd2BD5p3C4PcTOp8hugw3KMF546Go5ZVM3mlvDt9FzSOSxlrcBTgQuENAYNGCuuWyJJ0aUamiAZCmoF/tyUjgAMLehESKQgbwj0uH048iUiqm08oq7AsjccmBkelgUU+QZavYEWqaK+/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXJ+MWtt; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-539f6e1f756so1547508e87.0;
        Thu, 24 Oct 2024 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796842; x=1730401642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=nXJ+MWttkPO/CXAz2oNpU7zRYPC3hwsf6f3usr78pLXojQTTU5OQJXPhCDpSnMVGBG
         +0i/feNOQUmknwqheoNDe21yejHtTXPZmlfjvRwnGif4pnmpcfCjEYNQumcd6WWSTLCf
         S7yUlGD2MQOcPAm/enzIulXy7KZdr/HITOlwCEwkk/Js6q3/TmN+wj4RxANRIz4VPcVw
         9/ZHvqvgXfOVEpo1T8GSWjmKgv/VW5qLuRdvFfuhTv8sBCeI/4NHZYpz6NRjAt4kMn1l
         VN8YzRUe28CKNACvrY8jpTdbeJvo9pYFjGTotS7Hs/T7YLGdZD693ye0ZSoL8i5//s+Z
         3ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796842; x=1730401642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=o4V2Tz9i5S02f5gUJoiO1ylLDOpVvDmn4nDa0MCIps9E+Jl9LiF5HEMWp5orHLU6ZQ
         nurJ4RHoTi/w4UEogWmqiD+mO6uKsrjVuhwkJRXmqIRkyPJSuhndhQx27RW4XXiwXUrt
         Q/Mwo2/8ylJsqtHdlfuWNAoB4wRI27XCUj1HNKmoJN9T3y2c4MggJc/OP2VT6aHHp8C0
         T9akxoL6E1ixXZgWx419E17aNzIylfmsW8A9gjhLu5I9QXKAeMxiEAjUq/v2UjVnRRuW
         7yKTrkFzRjhwxs35vg6Qb8BhnjtA7c6tAscqObFoEp3EqMNqa53mpVeqxZJBHG4sclA0
         fsTg==
X-Forwarded-Encrypted: i=1; AJvYcCUE8geLhqj2Y3Se2qUngkJwZw1c3EA2mnMhuJHEyPqGsRZcYeCsvwQlkInB1SKkQIKNUwwojwT2ymua@vger.kernel.org, AJvYcCUWtFD7CLxGGUwYGJ/LAAFIsSGTI5ZTcyCOBE5/LNRZO4YRuFCBirSSLEdVIOnmWE7ZyFuZAJpiKDfi@vger.kernel.org, AJvYcCUpROxytzblag53NYc4N1F0Nii79CkLgHpZA4NTt9LAjhZfj29JW01v7gxKXVLOj90+FN2U26cX@vger.kernel.org, AJvYcCUtu2L+PWKxqPzCLJ6vxfkT33rTpFsKfPfiC4W6IuDh/ewmg5tiKsQodlsNZ7F/C0idaGSsXXoUtdt1gw==@vger.kernel.org, AJvYcCV7eYv3uGa7zDfm5TwI4kvVixrIb8xMFo/H9G5K1ZtS8Wzk4RcOWZUcpu8XM46BqRSfL1u2pD+K0ZQ=@vger.kernel.org, AJvYcCVKUy8+nT5tftzn7WYdnakAnJ5LbMxrjVDQ0TRUdXWPEAy4i61OwbxR+GOkIo1kuMuovxK2gk0o2ZZvC+ajeaQOF+4=@vger.kernel.org, AJvYcCVL0miRf5f7CdVwqXSbl96z+1wJcVsPWE+z0mC4aUDkB81MEkbWMV/SMnWhOnGaWMtTSYiRQZP3C5fK8n4=@vger.kernel.org, AJvYcCVbRZ7461qE+6JXn7uA+USuN1f4QXE6mLsB6dlnfboEMYkw1kMHHk/baI4Q/xm28/RJHZVSaV/MWIerWtY=@vger.kernel.org, AJvYcCWBpNmtXdmRLwoeWjLIVl/F57oME8+JCv+HsZvSzLsOg2VpZExMkVoETAQVjcHuncRO3XaYzCHySfdmBw==@vger.kernel.org, AJvYcCWr6PlfpRSkGUNYx2a0wZ2M
 kcZ2h2PXiXEsvnluF1yinvErqb52FnTfpBJFhMZkkVUpdit7mTUzKGrJAHA=@vger.kernel.org, AJvYcCXMiLeBfBS+fQlfdMxJvKfkLzjz7DwYiSRrOpBgV9QTchJFZN8w9FqKAuGR34XcHzHQofIfpQrUuHyv@vger.kernel.org, AJvYcCXN4Ta0xqCAaXnWRzrO2aBA5+3KlHMeSaGWGENfGagG5CthKSCFbo1sZUwLMQQZXh03psqSBLy+/PsalA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0TUstVxjNcB3Z8PYj6VWYDiEt3kOFOxZmowUESyW5LusgqRMg
	fg2IFENkVOr+CvtqiKOMZKU1k3KrK3xNQDVxQQhD9qUdgTh4XlQX
X-Google-Smtp-Source: AGHT+IH8m/UINwLw5QdXNqyaYTkQtq5r2H2Sgm141m3AvapzbBF/FL4wIpa481MPJLWYY2cW3mZvtA==
X-Received: by 2002:a05:6512:1249:b0:539:e60a:6dd0 with SMTP id 2adb3069b0e04-53b23ea0162mr2123323e87.51.1729796842419;
        Thu, 24 Oct 2024 12:07:22 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22431569sm1444645e87.222.2024.10.24.12.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:21 -0700 (PDT)
From: Russian Troll Factory No101558695295104112222171147244812024410111895196322567722811215107263107132653141041551231219108641203329828612151322236011190 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:07:18 +0300
Message-ID: <20241024190718.14409-1-vladimirputin693389@gmail.com>
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




