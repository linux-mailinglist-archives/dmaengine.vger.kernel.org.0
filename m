Return-Path: <dmaengine+bounces-7948-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B06CCDDEA3
	for <lists+dmaengine@lfdr.de>; Thu, 25 Dec 2025 17:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03824300B99A
	for <lists+dmaengine@lfdr.de>; Thu, 25 Dec 2025 16:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020D229D265;
	Thu, 25 Dec 2025 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JEp21IQ6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA8C263F4A;
	Thu, 25 Dec 2025 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766679920; cv=none; b=rGuFZ3WYKz2A90vHkGqqMvS0idZhh8IMbKshLi0BL/A0/+XZmFH/iHwOt27xu39Pl9+P5Teaz4H+JKsVqVaAC40NsaBQ3HO9sXG7SmLyjKJf6OwE6zZC5GgIevRHlYSrb6gf3SzBp8QeQqIN98JLSneCv6szONaoZBXxT9AhhAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766679920; c=relaxed/simple;
	bh=TLU2BdrHcQkvuM7H/hYIg10i3NgoaJ1oOt4xioffyJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR1vgQ70Agcx7OGzN6In3kqu6x6RhLa98EU84mREdGQ7Qac8ORGQUsRCzrEOS8MQUGYInq0BdtM/51A4+Amq4WUyjzSvMahUg2o2/Ir53SA2DflBW+YRoAf/HBwBSJe9xt0tjry8/eeWjkYqDYnDGTCAXHwX/8O9l0t33SU7nvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JEp21IQ6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 313F24E41D99;
	Thu, 25 Dec 2025 16:25:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DF33360742;
	Thu, 25 Dec 2025 16:25:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BF4C103C8CAF;
	Thu, 25 Dec 2025 17:24:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766679907; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9w9PoOAphBvrMeuMPvt+UDtYQWc7xDRbIiFcY8PW7pU=;
	b=JEp21IQ6lhvA7GHyuGEFtjRTQ4IGqq4eZbh2FLAyWSrqCEeOvJV9lOYHMkYJknW5QyyXv6
	PGQpmEkwa+Ttf+W+qBq/IViwdlSgz1BWTOI98b7sbc7y7ggDQCzB+GcyEaNdPW63p56nD7
	VUyEVD8AvdIbBgxmgEW+Ou1evzJhsH2mU8zW39XvcYQ9aON4sQMY3Pc8VNGd8rU1LZ7N67
	v9mruJxmT99O7L9E+AcZwKtSMRHEUdVlFS3hcqeiJ7hZOgufxVRRQoPJ8bQgbMx0b9vV2Q
	SQEfEaeFx0h6BJIg8LdoIOmGeDEhG4BSWIKmxlXpY911xsKxLvOwGckKnEa1jw==
Date: Thu, 25 Dec 2025 17:24:55 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
	andi.shyti@kernel.org, lee@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linusw@kernel.org, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
	olivia@selenic.com, radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, broonie@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, lars.povlsen@microchip.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-clk@vger.kernel.org,
	luka.perkov@sartura.hr
Subject: Re: [PATCH v3 01/15] include: dt-bindings: add LAN969x clock bindings
Message-ID: <2025122516245554f59e2e@mail.local>
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
 <20251223201921.1332786-2-robert.marko@sartura.hr>
 <20251224-berserk-mackerel-of-snow-4cae54@quoll>
 <CA+HBbNGym6Q9b166n-P=h_JssOHm0yfyL73JZ+G9P81muK=g4A@mail.gmail.com>
 <78bf252c-fd5e-4a36-b1a3-ca8ed26fde7a@kernel.org>
 <CA+HBbNG+ZVD6grGDp32Ninx7H1AyEbGvP0nwc0zUv94tOV8hYg@mail.gmail.com>
 <d210552f-c8bf-4084-9317-b743075d9946@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d210552f-c8bf-4084-9317-b743075d9946@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 25/12/2025 09:47:34+0100, Krzysztof Kozlowski wrote:
> On 24/12/2025 15:01, Robert Marko wrote:
> > On Wed, Dec 24, 2025 at 2:05 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On 24/12/2025 11:30, Robert Marko wrote:
> >>> On Wed, Dec 24, 2025 at 11:21 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>>>
> >>>> On Tue, Dec 23, 2025 at 09:16:12PM +0100, Robert Marko wrote:
> >>>>> Add the required LAN969x clock bindings.
> >>>>
> >>>> I do not see clock bindings actually here. Where is the actual binding?
> >>>> Commit msg does not help me at all to understand why you are doing this
> >>>> without actual required bindings.
> >>>
> >>> I guess it is a bit confusing, there is no schema here, these are the
> >>> clock indexes that
> >>> reside in dt-bindings and are used by the SoC DTSI.
> >>
> >> I understand as not used by drivers? Then no ABI and there is no point
> >> in putting them into bindings.
> > 
> > It is not included by the driver directly, but it requires these exact
> > indexes to be passed
> > so its effectively ABI.
> 
> How it requires the exact index? In what way? I do not see anything in
> the gck driver using/relying on these values. Nothing. Please point me
> to the line which directly uses these values.... or how many times I
> will need to write this is not ABI?
> 

The index here is the exact id that needs to be set in the PMC_PCR
register and so it is dictated by the hardware.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

