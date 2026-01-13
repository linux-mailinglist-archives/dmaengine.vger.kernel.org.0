Return-Path: <dmaengine+bounces-8233-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A25C4D18F04
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 13:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE36B308B37E
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4893A38FF01;
	Tue, 13 Jan 2026 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Jh0Q9Kkg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D166A288C2C
	for <dmaengine@vger.kernel.org>; Tue, 13 Jan 2026 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308637; cv=none; b=dmE8Q6IYrJHfXHYHFI4OumE9n4+vJBiit1Tm5fq8MS1ECriY0X14NnpvaX8dHJLdeW4vddeUWiIy6mH61RCCCJ97eZh2tmyNQm+k4QG478iQO1P2la8HGO5gq/O/Wk2f9q2rhfxDysgmWOL3XntnNIg+2LMWqPOT4fKGHfyCY2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308637; c=relaxed/simple;
	bh=1DKmmAMrTMc/B32nL+XGjSAKOro5Gz96ACGi7IqMW9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUYwO9b+XhoRl08AmCbRbD3KU6vk+kIjohK+fM0Xfe5Zv+C1HimGtzp3aq33N4mtTKoEwSgQn7Gh0iQJqSlP3120jVdz/w37SYJB60JMBq9yYMap2Dv3ko5cjXEYMt6pZgx8v1V9JUEiopJ79GqYXzOYuj4hvmftm6R1qPyOSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Jh0Q9Kkg; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=bgYz
	Q023QCEOFph6EUgTHi0vVdD25uncinH1QX1E4EQ=; b=Jh0Q9Kkg9hoNCkqQXdhX
	gcQkYx9o2x2ZvYqfkeWiPR4Rkaj1Zf3CajlD71h1nMVg0c+0U4UjtOWGqg/ZOPEX
	/BTlcNWWF8rtomnudWesc7ZlFTxZBmXB1g7oavfNE1OPq3JejuM46kUz5UApMOir
	5c+p8x6pM5dgbBnNjRjB7s/sydNLK/TL7Nyy5H6F0nb0XzI1esKAT0mKlBi2iktG
	S4UawpvkqZ+Y7tSpLv/uy4aYQn0w82z6Ohw59LIuyUN6AkduqdwWrZLZsnl6+nEN
	UEvaydNjnROjP+RQ9g8y3Vmupz74Mu64hEkIPhSzTbpzi0usr51RLyLOfM5wo/TI
	6w==
Received: (qmail 1683370 invoked from network); 13 Jan 2026 13:50:26 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jan 2026 13:50:26 +0100
X-UD-Smtp-Session: l3s3148p1@aJd4b0RI2soujnvx
Date: Tue, 13 Jan 2026 13:50:24 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Robert Marko <robert.marko@sartura.hr>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, herbert@gondor.apana.org.au,
	davem@davemloft.net, vkoul@kernel.org, andi.shyti@kernel.org,
	lee@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linusw@kernel.org,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com, olivia@selenic.com,
	radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	broonie@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	lars.povlsen@microchip.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org, luka.perkov@sartura.hr,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 06/15] dt-bindings: i2c: atmel,at91sam: add
 microchip,lan9691-i2c
Message-ID: <aWY_kMIX_G2iSltN@ninjato>
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
 <20251223201921.1332786-7-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223201921.1332786-7-robert.marko@sartura.hr>

On Tue, Dec 23, 2025 at 09:16:17PM +0100, Robert Marko wrote:
> Document Microchip LAN969x I2C compatible.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Andi Shyti <andi.shyti@kernel.org>

Applied to for-next, thanks!


