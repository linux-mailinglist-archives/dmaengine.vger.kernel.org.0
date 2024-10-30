Return-Path: <dmaengine+bounces-3642-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4C39B5997
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 02:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E8F1C22A8A
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 01:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB22146D40;
	Wed, 30 Oct 2024 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R311AVpD"
X-Original-To: dmaengine@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7C42A8B
	for <dmaengine@vger.kernel.org>; Wed, 30 Oct 2024 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730253011; cv=none; b=c3NiR9tWzJbxuVHsmzsQLK9VNOG/Anq54FM9L5d1vqSaKWUp5cA0OyaV/l598kb1YPszBdNH/6dofVhTfXRCGAXABkhhKD0q6oSX5pj7NSaLCUcn5M2fL7Uk3ELvQXrFmeT5S/6OItBZ5m0okHJpjYb7ZXje4mTaPTmnZM2lh9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730253011; c=relaxed/simple;
	bh=y6+bM0zEOiH5MPMkoFS9BwHieAQZ9fNfXnP4ex+lu34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8m10SkqFqkZvApdlxUdBWGJN3s1XxIB3Rl3tqJxqz2aqMh2wKrMVZpIEP9NvYhduc/YPFCmL5i45w2lHEiW34BU+sQaGD8eS2EjjUw4wHqrWVOEDKGKSMVzelxKnd/s+ERLtPlndLBU1Rq+f5VkNs4f0DLYtIc8eXZsOhkDYa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R311AVpD; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b545a75b-868b-4238-94c9-d647b4da27e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730253006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fASV8AOO8/1SMF1wEDZo6V3RiSsMj7qVwz3D1JJ4NY=;
	b=R311AVpD6h39kuoBfQMZcou/TW+9M7Ha6QZbtAoMphNYN9MH0oXmGkIAvOKWCM9ZOrcPEF
	Gjpnl216h1Ku7/fV2KC4gZvBBmk93nr+2pKh6BY8jFhAuGTUWBDpHQruAvfuy8/XQ9eypr
	pGzGw+jnfvbeLMUijB0Y0hpPbqejZRQ=
Date: Wed, 30 Oct 2024 09:49:44 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: linux: Goodbye from a Linux community volunteer
To: Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev, Andy Shevchenko <andy@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Paul Burton <paulburton@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Arnd Bergmann <arnd@arndb.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-mips@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-pci@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <olteanv@gmail.com>, Keguang Zhang
 <keguang.zhang@gmail.com>, Yanteng Si <siyanteng@loongson.cn>,
 netdev@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 linux-hwmon@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 linux-edac@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-serial@vger.kernel.org
Cc: Andrew Halaney <ajhalaney@gmail.com>, Nikita Travkin <nikita@trvn.ru>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Alexander Shiyan <shc_work@mail.ru>, Dmitry Kozlov <xeb@mail.ru>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Evgeniy Dushistov <dushistov@mail.ru>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Nikita Shubin <nikita.shubin@maquefel.me>,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




在 2024/10/24 12:27, Serge Semin 写道:
> Yoshihiro, Keguang, Yanteng, Kory, Cai and everybody I was lucky to meet in the
> kernel mailing lists, but forgot to mention here. Thank you for the time spent
> for our cooperative work on making the Linux kernel better. It was a pleasure to
> meet you here.
I am also deeply delighted to meet you here. In the process of 
collaborating with you,
I have gained a lot and am really full of gratitude.
>
> Hope we'll meet someday in more pleasant circumstances and drink a
> couple or more beers together. But now it's time to say good bye.
Let's spend more of our spare time on enjoying life.

Thanks,
Yanteng
>
> Best Regards,
> -Serge(y)
>


