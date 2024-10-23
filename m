Return-Path: <dmaengine+bounces-3448-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E296C9AD475
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 21:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1E51C221A1
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 19:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9071CDFB9;
	Wed, 23 Oct 2024 19:04:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE3414AD20;
	Wed, 23 Oct 2024 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710270; cv=none; b=RfRVBPQohNR4FWC4FJa3VEIrc/9SwuchfnkWJV6ojqJDgujmiFN3Fu3k+H8b+taczwcwIF9lMpMBZ1Ai0ZINw8mp9NPGKX2IdzOuMmxYExHcaSiZ0FTIE9Kt2Oj5Vnpg3JPuDIy56A/TvlxIL9/juyF20hSV7RWWnFskdshG3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710270; c=relaxed/simple;
	bh=dLDtMcQtwOlYVJACTfw+Y4G1ep4/MeX/RYcgDLXlk68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sdX8Pn+PYycZ/2chH6v8PrDb6mZ6cKKb3qvvMrr0603gdfVnSjyS3Yb//uyLjpW5JQwdV2Nemby8l6vTM1A3/e18mnPe5RRIVzB/lui+15RxxDCFuCYxOtCdBaGpW2cp1WoY0PpXmXUePNFmf3glfesbAdusQU/jvv613/lwbHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 1964E54936; Wed, 23 Oct 2024 14:56:45 -0400 (EDT)
From: Phillip Susi <phill@thesusis.net>
To: Linus Torvalds <torvalds@linux-foundation.org>, Tor Vic
 <torvic9@mailbox.org>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io,
 gregkh@linuxfoundation.org, wangyuli@uniontech.com, aospan@netup.ru,
 conor.dooley@microchip.com, ddrokosov@sberdevices.ru,
 dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com,
 geert@linux-m68k.org, hoan@os.amperecomputing.com,
 ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
 manivannan.sadhasivam@linaro.org, mattst88@gmail.com,
 netdev@vger.kernel.org, nikita@trvn.ru, ntb@lists.linux.dev,
 patches@lists.linux.dev, richard.henderson@linaro.org, s.shtylyov@omp.ru,
 serjk@netup.ru, shc_work@mail.ru, tsbogend@alpha.franken.de,
 v.georgiev@metrotek.ru, wsa+renesas@sang-engineering.com, xeb@mail.ru
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
In-Reply-To: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io>
 <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
 <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Date: Wed, 23 Oct 2024 14:56:45 -0400
Message-ID: <87bjzay7f6.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus Torvalds <torvalds@linux-foundation.org> writes:

> If you haven't heard of Russian sanctions yet, you should try to read
> the news some day.  And by "news", I don't mean Russian
> state-sponsored spam.

I am not a lawyer, but my understanding is that sanctions means you can
not buy things from them, sell things to them, or otherwise exchange
money.  It does NOT mean you are forbidden from emailing them or
mentioning their email address.

And even if, somehow, legally they must be removed from their maintainer
role, the commit doing it should still be clear.

