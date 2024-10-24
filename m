Return-Path: <dmaengine+bounces-3546-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FA49AF2B0
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA01D1C220A7
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E736F1FF04A;
	Thu, 24 Oct 2024 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="R8fs2ChI"
X-Original-To: dmaengine@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECC4200BA4
	for <dmaengine@vger.kernel.org>; Thu, 24 Oct 2024 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729798797; cv=none; b=qgM74CBzFHKealsSdqaaJtOYaljvzAKRj27Q52ZUbLkcFsGhpTcpwfNYoZYdQ+GzQWAM5uYC5Wwg3SN9Eum3+EOOLUheoQkoGr/rVWpDZ6B4CIqrUcK+kphiImZCcrcwmG9cV6sneG86+fvpw0g+H0f9i2YY67hluQS4A8RsXlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729798797; c=relaxed/simple;
	bh=O1dcXIyUjlAbIPr9ZrfWvPFBrJ1WmrTHcLovVsabp0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxTFg+sizOf+g09oy58DwcBUihZUTMuyVeaYerscbNQBznT49l8qr/tho9sjvThSRNBBQPeqhvahIPunAPScUEncJ2nVHvK4dy1UY+feMa8eBRRdnihRzb5T58X6E5XJuX/auF+NTQcvjxagTr/9xZ/pLX9R+I2R93BzsXXcLn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=R8fs2ChI; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49OJbTWu001700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 15:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729798665; bh=okMMcBGH5/TsuAYsZMeQd9odZhnIVG8nrgmmktEZgjE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=R8fs2ChICzYzHoORWY0TGyuLGcRZ/iRnqCQWyYhJimwXjbUfRi6XceFJZA+gHyxuZ
	 xL4W0b/efMryxORB6vle0p3gsXveCnGoUnS6pSgoGSyf34BLdVkHHBXH4SDDOq0HB0
	 c6Sx7xktLa7DcOcuwU/fk4OvdTbarl5XsmV/RctOxT6/X8mQ7mILQVzDe7Q+8Y0XTt
	 NOVgAyFRBJIjw8CY9yefNE9Ppn/+2FIG/ldE3grvR1/bDa3PIKPIzKr8rQj0Db2pXd
	 Cbq47JZ/Is3uffqYmMQZDrCqDVJSBTYLo14jsArP9D9ddy06MwCGE3/D3nsaxMuX6L
	 HG1osXMNtxVNQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3A2FE15C0329; Thu, 24 Oct 2024 15:37:29 -0400 (EDT)
Date: Thu, 24 Oct 2024 15:37:29 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hantong Chen <cxwdyx620@gmail.com>
Cc: ajhalaney@gmail.com, allenbh@gmail.com, andrew@lunn.ch,
        andriy.shevchenko@linux.intel.com, andy@kernel.org, arnd@arndb.de,
        bhelgaas@google.com, bp@alien8.de, broonie@kernel.org,
        cai.huoqing@linux.dev, dave.jiang@intel.com, davem@davemloft.net,
        dlemoal@kernel.org, dmaengine@vger.kernel.org, dushistov@mail.ru,
        fancer.lancer@gmail.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, ink@jurassic.park.msu.ru,
        james.bottomley@hansenpartnership.com, jdmason@kudzu.us,
        jiaxun.yang@flygoat.com, keguang.zhang@gmail.com,
        kory.maincent@bootlin.com, krzk@kernel.org, kuba@kernel.org,
        linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux@armlinux.org.uk, linux@roeck-us.net,
        manivannan.sadhasivam@linaro.org, netdev@vger.kernel.org,
        nikita.shubin@maquefel.me, nikita@trvn.ru, ntb@lists.linux.dev,
        olteanv@gmail.com, pabeni@redhat.com, paulburton@kernel.org,
        robh@kernel.org, s.shtylyov@omp.ru, sergio.paracuellos@gmail.com,
        shc_work@mail.ru, siyanteng@loongson.cn, tsbogend@alpha.franken.de,
        xeb@mail.ru, yoshihiro.shimoda.uh@renesas.com
Subject: Re: linux: Goodbye from a Linux community volunteer
Message-ID: <20241024193729.GP3204734@mit.edu>
References: <20241024173504.GN3204734@mit.edu>
 <20241024181917.1119-1-cxwdyx620@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024181917.1119-1-cxwdyx620@gmail.com>

On Thu, Oct 24, 2024 at 06:19:16PM +0000, Hantong Chen wrote:
> 
> I wonder some of Ukrainian misiles and drones might also be using
> the embedded Linux controllers, and why aren't there any sanctions.
> This cannot be used as an excuse.

The question of whether there are any sanctions is up to governments
and legislatures of those countries that have enacted the relevant
laws and regulations.  This is not up to the Linux development
community.  But given that we are citizes of our respective countries,
we are obliged to follow the laws of our countries --- and if we
don't, we can be subject to enforcement actions of our countries'
governments.  For someone who is a Chinese citizen, the same would
apply to any rules and regulations promulgated by the Chinese
government, no?

The question of why a particular country has decided to sanction
Russia and not Ukraine, and why a country has decided to support one
country versus another, whether it's Germany, France, and Poland
sending tanks and armored vehicles to Ukraine, or North Korea sending
artillary shells to Russia, is not up to the Linux development
commuity.  As individuals we may have our own opinions of the
appropriatness one one versus another, but the fact remains that there
are sanctions imposed on one set of countries, but not the against the
other set.

Hypothetically, if someone was a Russian Citizen, and there was a
Russian Law forbidding them to provide technical assistance to US
entities, then that person would be obliged to respect that law, and
not send any patches to US-based open source projects.  Depending on
how that law was worded, a Russian-based open source project might not
be allowed to accept changes from US entities, and again, if you were
a Russian open source project maintainer, you would be obliged to
follow that law --- or maybe you would be thrown into a Russian jail.
Whether you are a Russian patriot and are 100% behind the Russian law,
or think that perhaps it's not the best policy, doesn't really matter;
you are still obliged to follow the law one way or another.

(Personally, my sympathies are entirely with Ukraine, but my opinions
really don't matter for the purposes of this discussion, because I
don't make my country's foreign policy.)

> What LF and Linus done will inevitably create a climate of fear where
> contributors and maintainers from the *Countries of Particular Concern*
> feels endangered.

In the ideal world, one country would't be invading another conutry,
and we wouldn't have these sanctions regimes.  But they were not
*caused* by the decisions of the LF and Linus.  The sanctions regimes
were enacted by multiple countries' legal governmnts, and now the
question is how can we best protect the Linux development comunity,
the operators of web and git servers that are redistributing Linux
kernel sources. etc.

The Linux community may be an international open source project.  But
it is composed of individuals who have to respect the rule of law of
their individual country; and many countries have spoken quite clearly
on this subject.

Cheers,

					- Ted

