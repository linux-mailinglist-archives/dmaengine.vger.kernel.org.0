Return-Path: <dmaengine+bounces-2412-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F6D90DB4A
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 20:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246EF1C21C2E
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 18:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156AC1509BF;
	Tue, 18 Jun 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reM0BcBU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC414F13E;
	Tue, 18 Jun 2024 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734093; cv=none; b=iYbKpTCcC2w2ScW0+6eTksiJPEejCpZ7e92Q3QbId8gxn6P+h5wzTvWzM/VM/KktTWxWSNTVUq/CovRIfyeSvs4RE8uohcLljQ/H/5fmr9/HWxxsWT8zWAPxIG/e/IFSKB2ehPsMQDHZNZsxSngeMt4GR3hGgALwH14YZldXkew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734093; c=relaxed/simple;
	bh=DIWXHzFM9LsRVNoscUsRZE3SjmaDFUBGMVeyHHcwIVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IH5sKXsTjNvKFXtLoLG6zUMgN303xXA6y50ihBncmnhASDC326x2lXWDXQVIH1lfKv527tVlPTg7phMv/YweAsEk82b7yEvewrPPIMN5Eioc9xTFr5IalH57E2bFOLHbxB1ZUNmqiFntMnFR+wrex7JKvh9SPhvVaU88CFEgpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reM0BcBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7DEC3277B;
	Tue, 18 Jun 2024 18:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734092;
	bh=DIWXHzFM9LsRVNoscUsRZE3SjmaDFUBGMVeyHHcwIVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=reM0BcBULhL6vYCBFsQHRbgWG5t1mnQuBX+OxOLkwHYD+348b48Pop5sdU56arf7R
	 5ZUKPyMW2OeJ4YWwFCVqziOF8Dvt/0qf4QJ9BGGLpPdXhhPwtO2QwbnqLDNLCBkb3C
	 d3ye1WHVxcV5T2Khjv6w5GVrPKRK4R6bsu38ajXcO2fyb0PJrcFC+8/5tQlNph6Mqp
	 Ts/78Nny3XKmqU8zGR6pWzZri2i2DfZ0j45IsZzgIdBJTAw88ywiABpYlyIGycAFhG
	 2iVl2TLzmtH5vNbKEQfW8UqChqsI4M8sPv9NNrjj58eo5AMnzITc48yooNFNJsiC9n
	 LlRU+twT52wOA==
Date: Tue, 18 Jun 2024 11:08:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Nikita Shubin via B4 Relay 
 <devnull+nikita.shubin.maquefel.me@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Hartley Sweeten <hsweeten@visionengravers.com>, Alexander
 Sverdlin <alexander.sverdlin@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Lukasz Majewski <lukma@denx.de>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy
 Shevchenko <andy@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Thierry Reding
 <thierry.reding@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Damien Le Moal <dlemoal@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Ralf Baechle <ralf@linux-mips.org>, "Wu, Aaron"
 <Aaron.Wu@analog.com>, Lee Jones <lee@kernel.org>, Olof Johansson
 <olof@lixom.net>, Niklas Cassel <cassel@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
 netdev@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-ide@vger.kernel.org, linux-input@vger.kernel.org,
 linux-sound@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v10 00/38] ep93xx device tree conversion
Message-ID: <20240618110808.7829d214@kernel.org>
In-Reply-To: <eb3e6c0b883f408fed68e725a23b54854701ce9e.camel@maquefel.me>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
	<20240618073339.499a7fd2@kernel.org>
	<eb3e6c0b883f408fed68e725a23b54854701ce9e.camel@maquefel.me>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 19:33:49 +0300 Nikita Shubin wrote:
> On Tue, 2024-06-18 at 07:33 -0700, Jakub Kicinski wrote:
> > On Mon, 17 Jun 2024 12:36:34 +0300 Nikita Shubin via B4 Relay wrote:  
> > > The goal is to recieve ACKs for all patches in series to merge it
> > > via Arnd branch.  
> > 
> > Why? The usual process is for every subsystem to accept the relevant
> > patches, and then they converge during the merge window.  
> 
> It was decided from the very beginning of these series, mostly because
> it's a full conversion of platform code to DT and it seemed not
> convenient to maintain compatibility with both platform and DT.
> 
> Generally i think it's too late to ask such a question, when just a few
> patches left.

Put the relevant information in the cover letter. Justification why you
can't follow normal merging rules is very relevant.

