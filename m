Return-Path: <dmaengine+bounces-6738-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B82BAFFBF
	for <lists+dmaengine@lfdr.de>; Wed, 01 Oct 2025 12:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA241884E91
	for <lists+dmaengine@lfdr.de>; Wed,  1 Oct 2025 10:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479001E9905;
	Wed,  1 Oct 2025 10:21:31 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C93A1B0420;
	Wed,  1 Oct 2025 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314091; cv=none; b=UsJ45I2B3amXcqjyBI1BY8HkG0OHVfGOE8mRbA43mPoLjJHB8td0ZLzb9WJ6WlGWwvAkQkUiU4GZVoSaAxBzF9kKJfNGuIQ3b102s/JKHzp75Y1QFktdM30CMbcRXx5cRWpvsxuzcypLxih3wcPblRnUiYz83cekU8ye1OCr2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314091; c=relaxed/simple;
	bh=ODeNv/xSjUtbdZAeBsFlGuryHUWRemRcqjm8xDajy7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dylHR7wnLcAZvpRQmsJqAtq9FGcz21KK6pkgDWwZDUw5QODIkDNR7tFKFEJIMMF6RTGLJryCqTRCU4Gw9yPf6Dd178KA6K+u21oBRXNpqZ1rAiaoQTvOqZbL4ZKrTsPxE8ZoCJCQdcXAM9Yq4j+OU9YG5w5DKcreL9sCMCXnRoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 7418972C8CC;
	Wed,  1 Oct 2025 13:11:48 +0300 (MSK)
Received: by imap.altlinux.org (Postfix, from userid 705)
	id 6C02E36D070F; Wed,  1 Oct 2025 13:11:48 +0300 (MSK)
Date: Wed, 1 Oct 2025 13:11:48 +0300
From: Michael Shigorin <mike@altlinux.org>
To: Michael Shigorin <mike@altlinux.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tor Vic <torvic9@mailbox.org>, Kexy Biscuit <kexybiscuit@aosc.io>,
	jeffbai@aosc.io, gregkh@linuxfoundation.org, wangyuli@uniontech.com,
	aospan@netup.ru, conor.dooley@microchip.com,
	ddrokosov@sberdevices.ru, dmaengine@vger.kernel.org,
	dushistov@mail.ru, fancer.lancer@gmail.com, geert@linux-m68k.org,
	hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru,
	ntb@lists.linux.dev, patches@lists.linux.dev,
	richard.henderson@linaro.org, s.shtylyov@omp.ru, serjk@netup.ru,
	shc_work@mail.ru, tsbogend@alpha.franken.de, v.georgiev@metrotek.ru,
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Subject: Re: what about CoC? (was: [PATCH] Revert "MAINTAINERS: Remove some
 entries due to various compliance requirements.")
Message-ID: <20251001101148.GA30625@imap.altlinux.org>
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io>
 <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
 <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <20241024095339.GA32487@imap.altlinux.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024095339.GA32487@imap.altlinux.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Oct 24, 2024 at 12:53:39PM +0300, I wrote
> It's not about the patch but rather about the attitude;
> Documentation/process/code-of-conduct-interpretation.rst:
> 
> "regardless of ... ethnicity, ... nationality, ... race"
> "Focusing on what is best for the community"
> 
> "Examples of unacceptable behavior ... insulting/derogatory
> comments ... Public or private harassment"
> 
> Get back to single-standard integrity for yor own's sake.

Glad to hear that ESR thinks -- and speaks! -- in a similar vein.

I believe that Linus -- whose daughter has been basically
kidnapped mentally[1][2] by the same hypicrites who speak "love"
but groom real hate -- has his own merits to rise against those.

But it does take leadership and guts in a "modern" world.

[1] http://reddit.com/r/linux/comments/9go8cp/linus_torvalds_daughter_has_signed_the/ [del, heh]
[2] http://unz.com/isteve/and-they-came-for-somebody-who-actually-gets-things-done-linus-torvalds/

-- 
Michael Shigorin
http://t.me/anna_news

