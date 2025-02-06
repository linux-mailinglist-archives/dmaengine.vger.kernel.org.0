Return-Path: <dmaengine+bounces-4326-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBB8A2B62D
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 00:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA631884812
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 23:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BB22417EF;
	Thu,  6 Feb 2025 22:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="f5fZ5dxc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC1E2417E1
	for <dmaengine@vger.kernel.org>; Thu,  6 Feb 2025 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882795; cv=none; b=VeAiymSVFf2Bu5G+PCjnam1rRbJS5YLTd7qC7W/ALqIibPnufxNXJZtGxkLvL1jCi7D0Y2psWvtzx8x2xAO3FjHw3pI59w/x4nph0oRmL6/oArxhUUl4ObxR4DmhRmNEEs6QsH+Yv9+7yDbSAVkITN9GPFWSlZr3nFBGJkMy6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882795; c=relaxed/simple;
	bh=8wEjDCTuOvcktBrfjhLQ0lipXUb5sf39X+VV2LrhSa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivYPr1l7Zd5iBlQi5ljD/gROYIbaBvWb9ySnWPoe7pYqv79xklLbj9gW1IguVpiqRaFWazJ4DP/Z4JPUzZecVVrVjHwBw025Yp4IzQNtdDefDWpl3N50X05v3qvWSZjWCVa/fMWPz+BfoKLlNK7WntjeETDifb6wttiCSPWNbdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=f5fZ5dxc; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 43C2D240029
	for <dmaengine@vger.kernel.org>; Thu,  6 Feb 2025 23:59:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1738882792; bh=8wEjDCTuOvcktBrfjhLQ0lipXUb5sf39X+VV2LrhSa8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=f5fZ5dxc+yiDR/WQT0Po4+rbJRF/txKc1K68b+9pnLBawItBAJwI2Z+S2x4Y1a6dX
	 3o9+6n8Ac6zOKWwBStCcVuzT4EfA0PH63bkmdao7A9yMOyDhJLdUvKZn+fvhstXL9L
	 0eQBvnQV4jdarLr3kJ2yWQtio5/V7D4cf2HNmkQN4XUTDviSnDQU7R+xCWplMukXe9
	 +/rP6AcoIJq9HCiegXVNIG3oaULtkuSzrOyxk3NmiwBryyj79VZfhfrWtcJpkaWkFz
	 qbpUtlZoAlUOyOFhP/QKs6fx1h+aRBctKN8niJcY4kyyQox7dY+X47sFoQ99SfrYy8
	 UeOGQqYnODnjQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Ypsxb3GYrz9rxD;
	Thu,  6 Feb 2025 23:59:47 +0100 (CET)
Date: Thu,  6 Feb 2025 22:59:43 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Frank Li <Frank.li@nxp.com>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH RFC 9/9] dt-bindings: nand: Convert fsl,elbc bindings to
 YAML
Message-ID: <Z6U-38ONJ0F3ILCo@probook>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-9-50649f51c3dd@posteo.net>
 <Z5qzMH1t7jIr39Ce@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5qzMH1t7jIr39Ce@lizhi-Precision-Tower-5810>

On Wed, Jan 29, 2025 at 06:01:04PM -0500, Frank Li wrote:
> On Sun, Jan 26, 2025 at 07:59:04PM +0100, J. Neuschäfer wrote:
> > Convert the Freescale localbus controller bindings from text form to
> > YAML. The list of compatible strings reflects current usage.
> >
> > Changes compared to the txt version:
> >  - removed the board-control (fsl,mpc8272ads-bcsr) node because it only
> >    appears in this example and nowhere else
> >  - added a new example with NAND flash
> >
> > Remaining issues:
> >  - The localbus is not really a simple-bus: Unit addresses are not simply
> >    addresses on a memory bus. Instead, they have a format: The first cell
> >    is a chip select number, the remaining one or two cells are bus
> >    addresses.
> >
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
> >  .../devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml |  61 +++++++++
> >  .../bindings/powerpc/fsl/fsl,elbc-gpcm-uio.yaml    |  55 ++++++++
> >  .../devicetree/bindings/powerpc/fsl/fsl,elbc.yaml  | 150 +++++++++++++++++++++
> >  .../devicetree/bindings/powerpc/fsl/lbc.txt        |  43 ------
> >  4 files changed, 266 insertions(+), 43 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml b/Documentation/devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml
[...]
> > +  "#address-cells": true
> 
> should limit to a number set like
> 
> 	- const: 2

Will do

> > +
> > +  "#size-cells": true
> 
> the same as #address-cells.

Will do


Thanks,
J. Neuschäfer

