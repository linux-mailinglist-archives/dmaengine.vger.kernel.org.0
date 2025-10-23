Return-Path: <dmaengine+bounces-6969-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE8DC0265A
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 18:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BAA3AEE25
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 16:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688C3296BC9;
	Thu, 23 Oct 2025 16:19:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7988381C4
	for <dmaengine@vger.kernel.org>; Thu, 23 Oct 2025 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236353; cv=none; b=s2uy8Ui0nXKyDK6qjjpJVAbTA1DE4kgPJN8SiOabGvyl9eOlbka2Yc0CPiedVrRBYNHhKU0R/rYRH37webLKLNubzjwBXp/LXZ0yQ1OGupWB/jsPG8KptNSomjkkFM58D50E5nxOS9X0bNxM2AUqGO1ui3w0SbyI5WL7CrUmtmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236353; c=relaxed/simple;
	bh=J9fgQRAtf/jgUHeHMg6pXGR492Zh7Odx8vgo1NDj8Sw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YLBcvDU6yOHNB87dn0VFxufpoqto0jMVJ3ziveNIgwHtit/q2gtXZiPNN+xhT6XKufMhaku+IDEkzbk2NvPxt1v7gI38yZNQDjYKIgiLty6kAz/zkosIni3GP02DZc/N5cziKmsMt8pHBVSB5teMIE8m0DLu/qSwRAcv8cwR/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vBy0f-0003DE-8X; Thu, 23 Oct 2025 18:17:53 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vBy0Z-0055JC-1Z;
	Thu, 23 Oct 2025 18:17:47 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vBy0Z-00000000E1b-1FyP;
	Thu, 23 Oct 2025 18:17:47 +0200
Message-ID: <660b87b77ac97a186796ce4783acd510741f7c54.camel@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: Remove extra blank lines
From: Philipp Zabel <p.zabel@pengutronix.de>
To: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Stephen Boyd	
 <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter	
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,  Vinod Koul
 <vkoul@kernel.org>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Guenter Roeck
 <linux@roeck-us.net>, Andi Shyti <andi.shyti@kernel.org>,  Jonathan Cameron
	 <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Georgi
 Djakov	 <djakov@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Joerg
 Roedel	 <joro@8bytes.org>, Jassi Brar <jassisinghbrar@gmail.com>, Mauro
 Carvalho Chehab	 <mchehab@kernel.org>, Lee Jones <lee@kernel.org>, Miquel
 Raynal	 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>,  Johannes Berg <johannes@sipsolutions.net>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,  Manivannan
 Sadhasivam	 <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Kishon
 Vijay Abraham I	 <kishon@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Mark Brown
 <broonie@kernel.org>, Mathieu Poirier	 <mathieu.poirier@linaro.org>, Olivia
 Mackall <olivia@selenic.com>, Herbert Xu	 <herbert@gondor.apana.org.au>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-pm@vger.kernel.org, 	iommu@lists.linux.dev,
 linux-media@vger.kernel.org, 	linux-mtd@lists.infradead.org,
 netdev@vger.kernel.org, 	linux-wireless@vger.kernel.org,
 linux-pci@vger.kernel.org, 	linux-phy@lists.infradead.org,
 linux-pwm@vger.kernel.org, 	linux-remoteproc@vger.kernel.org,
 linux-crypto@vger.kernel.org, 	linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org
Date: Thu, 23 Oct 2025 18:17:47 +0200
In-Reply-To: <20251023143957.2899600-1-robh@kernel.org>
References: <20251023143957.2899600-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

On Do, 2025-10-23 at 09:37 -0500, Rob Herring (Arm) wrote:
> Generally at most 1 blank line is the standard style for DT schema
> files. Remove the few cases with more than 1 so that the yamllint check
> for this can be enabled.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
[...]
>  Documentation/devicetree/bindings/reset/ti,sci-reset.yaml    | 1 -

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

