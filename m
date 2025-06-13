Return-Path: <dmaengine+bounces-5432-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB9AAD8ADB
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 13:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729713BA40A
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068AF2E2F01;
	Fri, 13 Jun 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="vCaZPppF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5618BC0C
	for <dmaengine@vger.kernel.org>; Fri, 13 Jun 2025 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814917; cv=none; b=qt5OJ7GlIIILIqFhoz3pQtHSCziZbkKwzL+q/3EB1+cBmWJ+SSJUjNQyXh27XGy6goUkRZdJUiQ1+Q6yhWMSR11bRrvcXIz2m6UVAYxG0qpqPKZGu9x5BgD6IlPbkF9378LE2xY7Qj3PwtfO1KYp6o7J9wk9YjTiJAtkVRphGdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814917; c=relaxed/simple;
	bh=Xu9/tBx7J9HDSStwJKx4qcuH0x0i4S5UUTdM0NWoFms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvM+rCutBuKs1JNsT3zS6yd8YwTisuYBmX3nflAByJ3s9qihzAA5gdyyGqmiQzTJ3fb2jDj6mv2X2m7AlKOibF1qBQd9M0PAPnSCm204xjQ93QdWKF/kBnG76Zjny/rqyyhjt9cc11BvYeqKYTLSYRhBX+riPQczyubqzwUAtOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=vCaZPppF; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6facf4d8e9eso21444706d6.1
        for <dmaengine@vger.kernel.org>; Fri, 13 Jun 2025 04:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1749814915; x=1750419715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IO9Rd2HFTD+1YUfAySkfEq/dcEm2RB+c5PiJqcKqYFw=;
        b=vCaZPppFKldwMOpfY9qwXMyXK2n63c4Y3wPPdUCkD/NsZWDSzWPhcMrXiaMn397fQK
         lpnhZ7mzLivt8EIJyBy6XjV4oMyqIL0XCtWdsgk31eJdw+AOufwlLY+480r64Su+xOMU
         1738ZjQi87AJ6UGtfhqX3hP7zeSo7D72mgGlpsV/qQ+a52flJbbDe2ec/U8Fl/ZB5y5k
         TvXr0njPK4Emygrhl/JeatCHrJgo/c8q6yZ/vAbtZsu7HM+kaR+7wOT2RRnvkc1PLBbZ
         siE5NBO4GzqM+8O1l2XfaB/uQ2c42VI7ShrVgPFbk74bFmCnyXa+5PDGEhQ5hyHhP87+
         ETiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814915; x=1750419715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IO9Rd2HFTD+1YUfAySkfEq/dcEm2RB+c5PiJqcKqYFw=;
        b=GZ3qYo9wCetgx/7PNkn7iXRnMfWBEE35voexOZ5AUX7xAlJMWF5UgLXa+mIjDobpm+
         gZuojESPXK961+riKfQwdTTztT3Gw41Wse9AT1KKVNtzx2ZQEOaXGkwh55svEJ3cB4G0
         DI6kummfLhO/1XnRh+tfv6e9kCVEqjAntpY9jDgrBAYY7WrHfxH8bGyWW+1YdqbZx0NG
         vCk4B3QoA4+sDcE9LI0tqgBUSYEzbyZO+QZiQLgVLP7KTrylhzjMBhSaqx8CR2iZIArz
         ao0WgTFCfLS/R57w94FjxFZdE+d/fDcIzf423ZqTOwlQTMge4qgrpAv/R637ruib/Efc
         BFjg==
X-Forwarded-Encrypted: i=1; AJvYcCV9SQBDI5BHyRQs3vBCOkVOnx71Ma5TffXSWRQL6tyA9fPkszyIw7qkAhgN3eCyVvUmnz/fjdEhD58=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvBbIh5eOJLoerU10NnavP9ZsiJO88mKIzh0KO6sMU/0lKwBjq
	KQrluJ+vuU+Q4kUcRgNsogU7HbmorL0WfbShILN0qOSM4NXithG6g5utqeL27umZp2k=
X-Gm-Gg: ASbGncuns86ocZEYEZkc4FqJHbCOeawazj+eDPfRnIwo3y9JVULa7Oswhw2P+CY7iwI
	5Yy9+vjk5tR1NetU/26hUw8Aiqi3OeyDBzy0Nvn2KbUJkA44wXm7y+XuE6T+nQjTkpVnlresEfz
	gJhm1zp55GModTScUz2v2tQeZPMMhMQxcc4jfhFTSijSATFnxLsuFPn+nPIohW1ZOdG6Kcz41UO
	/X0jMHPmPAwbTG4AAk4p/KTB78wad+7ACp5fS/aXMO3M8RWKA6M1MjRSLHjyG4oma6dq2x8amp1
	khFMs2HvkPk6s2nLTfovHie3MkXoXDTu6wLSLh1sfTkKiM4XxCPUtGjIkZtXB4zf9VvZqTMySEI
	jjYSo6lltrGkID2cYnM2MVGMyfJ/4SvCz
X-Google-Smtp-Source: AGHT+IEc5wMP8ofTZTO6iGwnPV4OsQNdZGNQL5zwacGNvbNKtJCkrAxEGOyHCjmYXgP1YxiBm+lShw==
X-Received: by 2002:a05:6214:2344:b0:6f5:106a:270e with SMTP id 6a1803df08f44-6fb3e60bc99mr35271836d6.44.1749814914668;
        Fri, 13 Jun 2025 04:41:54 -0700 (PDT)
Received: from fedora.. (cpe-109-60-82-18.zg3.cable.xnet.hr. [109.60.82.18])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6fb35b3058fsm20558206d6.37.2025.06.13.04.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:41:54 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	ore@pengutronix.de,
	luka.perkov@sartura.hr,
	arnd@arndb.de,
	daniel.machon@microchip.com
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v7 0/6] arm64: lan969x: Add support for Microchip LAN969x SoC
Date: Fri, 13 Jun 2025 13:39:35 +0200
Message-ID: <20250613114148.1943267-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds basic support for Microchip LAN969x SoC.

It introduces the SoC ARCH symbol itself and allows basic peripheral
drivers that are currently marked only for AT91 to be also selected for
LAN969x.

DTS and further driver will be added in follow-up series.

Robert Marko (6):
  arm64: lan969x: Add support for Microchip LAN969x SoC
  spi: atmel: make it selectable for ARCH_LAN969X
  i2c: at91: make it selectable for ARCH_LAN969X
  dma: xdmac: make it selectable for ARCH_LAN969X
  char: hw_random: atmel: make it selectable for ARCH_LAN969X
  crypto: atmel-aes: make it selectable for ARCH_LAN969X

 arch/arm64/Kconfig.platforms   | 14 ++++++++++++++
 drivers/char/hw_random/Kconfig |  2 +-
 drivers/crypto/Kconfig         |  2 +-
 drivers/dma/Kconfig            |  2 +-
 drivers/i2c/busses/Kconfig     |  2 +-
 drivers/spi/Kconfig            |  2 +-
 6 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.49.0


