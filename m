Return-Path: <dmaengine+bounces-3474-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342259AE850
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 16:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653751C22412
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90591E885C;
	Thu, 24 Oct 2024 14:13:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.104.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6631E282B;
	Thu, 24 Oct 2024 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.104.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779238; cv=none; b=JcUK9CR64Kf6O8wvpTwSKGkJf0j4r8q4CzWGMCTgK8HypsrIqtzPjjieFySoIZIk5J7TEpM1YrwxXNkEXgnb5fXA4Ssul5/40cfmbsDvug2HdmnyfmX06Re2BWYx+jHlYWovc0o9XBmS0S4V4FDq+4Pshci7MkbLWmfxgr8Yzns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779238; c=relaxed/simple;
	bh=FqtmwA94oipzr+62VsJdTfpQcYtuXccvlcXq2Sfzq50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=au0COAI16dULNcXGdUNXTIlCCCN8p0UrTKKClTGFc0uKlFqvWQtzaanUE9v5OMLUoBz7kxP9rfQUlOrV5wNiBphk1gmpaVXI2I4PKpVEyZi1hhslLuyl39FuupbU87wJii41XnF8gJSTD/5RuOu0p2rwTPgQibTNqCQwvyhJmo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kremlin.ru; spf=fail smtp.mailfrom=kremlin.ru; arc=none smtp.client-ip=148.135.104.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kremlin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kremlin.ru
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 434E85E5C5;
	Thu, 24 Oct 2024 10:03:59 -0400 (EDT)
From: Vladimir Vladimirovich Putin <vladimir_putin_rus@kremlin.ru>
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
	xeb@mail.ru,
	LKML <linux-kernel@vger.kernel.org>,
	Vladimir Vladimirovich Putin <vladimir_putin_rus@kremlin.ru>
Subject: [PATCH 0/2] MAINTAINERS: Remove few Chinese Entries
Date: Thu, 24 Oct 2024 22:03:51 +0800
Message-ID: <20241024140353.384881-1-vladimir_putin_rus@kremlin.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
References: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi, Linux Community.

If you haven't heard of Chinese sanctions yet, you should try to read
the news some day.  And by "news", I don't mean Chinese
state-sponsored spam like Central China Television some kind of BS.

So I hereby submit another two patches to remove the entries owned by
two US-sanctioned entities Huawei[1] and LoongSon[2]. "They can come
back in the future if sufficient documentation is provided."

Best Regards,

Vladimir Vladimirovich Putin

---
Привет, Linux-сообщество.

Если вы еще не слышали о китайских санкциях, попробуйте прочитать
новости когда-нибудь.  И под «новостями» я не имею в виду китайские
спам, спонсируемый государством, типа Центрального китайского
телевидения, какая-то чушь.

Поэтому я отправляю еще два патча для удаления записей, принадлежащих
две компании, находящиеся под санкциями США, Huawei[1] и LoongSon[2]. 
«Они могут прийтив будущем, если будет предоставлена
достаточная документация».

С наилучшими пожеланиями,

Владимир Владимирович Путин

[1]: https://sanctionssearch.ofac.treas.gov/Details.aspx?id=30947
[2]: https://en.wikipedia.org/wiki/Loongson

Vladimir Vladimirovich Putin (2):
  MAINTAINERS: Remove Huawei due to compilance requirements.
  MAINTAINERS: Remove Loongson due to compilance requirements.

 MAINTAINERS | 96 -----------------------------------------------------
 1 file changed, 96 deletions(-)

-- 
2.47.0


