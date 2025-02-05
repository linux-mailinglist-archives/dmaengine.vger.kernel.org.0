Return-Path: <dmaengine+bounces-4301-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988E6A28FCC
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 15:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B47AA7A1DE4
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AADD156C5E;
	Wed,  5 Feb 2025 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="PACWVV/B"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB0B158536
	for <dmaengine@vger.kernel.org>; Wed,  5 Feb 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765765; cv=none; b=I3u4tEvz5C19LXuQ66mRBTVOpsaTHgYsQokGGacFZmx4qn6jzdgXe8jYYls65aCmWaK7DX8f5UrBlrzAl0+HGAYgYIcY1xw9xPFvKeUV0Yizd2OSHBUTU7ac0MtXeBP7QgvMAyyDwD0bpyMERosWUokYtgCAm1u1eobBtfA7gzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765765; c=relaxed/simple;
	bh=e42SIVOUhhbdor72mrNuSIArnji9rVNQMG+KjSfReLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbKLb4HjIyxhxlWF3u8el9wD8USlCw9kvuxSJHtc7cFRUuvsw4915fzxlJMWnlq9O3kMLuViDd0UawSayGk+6altHjgs4TOaaVZi/as8SFAignVzC5udRRAg1F5OOuixzEGrw2+jHrcD0MqmFEiziMqmJrpWPS6e2GVnIbU0ymQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=PACWVV/B; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 2207724002B
	for <dmaengine@vger.kernel.org>; Wed,  5 Feb 2025 15:29:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1738765761; bh=e42SIVOUhhbdor72mrNuSIArnji9rVNQMG+KjSfReLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=PACWVV/B2zEXa/3zM3iFyWGMCvq1ep2tJrc4lnPcQd3vMa6GfKW9yWUGJflhWkzB6
	 mdwFgQnP74Q/JsCwaMpTD/CjCuigxBwGIzzFxwKWVOeHk4MaYvlikd7rp62zTC36An
	 Agq7QhuBJJS77HdFXurVKxgAqrp2UMVQuGlfqmMXwEUvTE2X+Q7vjO9yeuFfneWNi4
	 UzFkZdRD0ItU6gs7hUevNamTNwgpLFYRa/IWNqQMQfGMroi2NGU2e/DlG3TmQlVncm
	 PLI6VUrrsbH50E1C83K8fRG84DpnJGcwKJONJ/5Rq2M0DazTqmw5sg53lAryZJ//tS
	 +5vr8gbAqJFJA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Yp2fz0fXhz9rxQ;
	Wed,  5 Feb 2025 15:29:14 +0100 (CET)
Date: Wed,  5 Feb 2025 14:29:14 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Rob Herring <robh@kernel.org>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 8/9] dt-bindings: spi: Convert Freescale SPI bindings to
 YAML
Message-ID: <Z6N1uqg4Dji4Pt3X@probook>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-8-50649f51c3dd@posteo.net>
 <20250127050901.GB3127337-robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250127050901.GB3127337-robh@kernel.org>

On Sun, Jan 26, 2025 at 11:09:01PM -0600, Rob Herring wrote:
> On Sun, Jan 26, 2025 at 07:59:03PM +0100, J. Neuschäfer wrote:
> > fsl-spi.txt contains the bindings for the fsl,spi and fsl,espi
> > contollers. Convert them to YAML.
> > 
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
> >  .../devicetree/bindings/spi/fsl,espi.yaml          | 56 +++++++++++++++++
> >  Documentation/devicetree/bindings/spi/fsl,spi.yaml | 71 ++++++++++++++++++++++
> >  Documentation/devicetree/bindings/spi/fsl-spi.txt  | 62 -------------------
> >  3 files changed, 127 insertions(+), 62 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/fsl,espi.yaml b/Documentation/devicetree/bindings/spi/fsl,espi.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..350275760210c5763af0c7b1e1522ccbfb97eec7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/fsl,espi.yaml
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/fsl,espi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale eSPI (Enhanced Serial Peripheral Interface) controller
> > +
> > +maintainers:
> > +  - J. Neuschäfer <j.ne@posteo.net>
> > +
> > +properties:
> > +  compatible:
> > +    const: fsl,mpc8536-espi
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts: true
> 
> How many?
> 
> > +
> > +  fsl,espi-num-chipselects:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: The number of the chipselect signals.
> 
> Constraints?
> 
> > +
> > +  fsl,csbef:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Chip select assertion time in bits before frame starts
> 
> Constraints?
> 
> > +
> > +  fsl,csaft:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Chip select negation time in bits after frame ends
> 
> Constraints?

I'll add appropriate constraints to all of these.


> > diff --git a/Documentation/devicetree/bindings/spi/fsl,spi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi.yaml
[...]
> > +  clock-frequency:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Don't need a type.

Will remove

> 
> > +    description: input clock frequency to non FSL_SOC cores
> > +
> > +  cs-gpios: true
> > +
> > +  fsl,spisel_boot:
> > +    $ref: /schemas/types.yaml#/definitions/flag

I do wonder, what's the difference between
$ref: /schemas/types.yaml#/definitions/flag and type: boolean?



Thanks for your review.

Best regards,
J. Neuschäfer

