Return-Path: <dmaengine+bounces-4241-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF98AA23DA7
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jan 2025 13:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2927A2BE5
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jan 2025 12:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C831C2304;
	Fri, 31 Jan 2025 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="ZH/QrR6C"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E61C07C9
	for <dmaengine@vger.kernel.org>; Fri, 31 Jan 2025 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738326195; cv=none; b=asq240jwmIxaSQaPDTsQvpy5KiZEDsHFnJE9qluQ4VHkVhBb4cGlt1Lzfq1jSU0/tvCgvharyMvD8zCcl7G2E4vE7vtrBhdNXIxlguTN5AGsztsLyBlW0Zsx6gztvqTkhPrG/0swUPpOC0/QNg6YyRgD6/u7YlibF2MOkM2yl3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738326195; c=relaxed/simple;
	bh=2qfaRTO5iG5mOYJ+RvO6+d2r0hfl5IUM+PXTysg9LQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7mt9ypLZ/w9ktEArCxEgQP7UrJVj0tB+OZ/l/0YweZmi/ndlnr8Jmumd+MJMA84GUXomk9by39ojih4oDYYcgU/iurBSe1sJwtE+U8kowj3rDpC0cNcB7oGv6gCIiDuJhmq0Sf8i7qRBCX2NdqHg/8uuBlp+YPvv+WCjSnSKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=ZH/QrR6C; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 1B329240029
	for <dmaengine@vger.kernel.org>; Fri, 31 Jan 2025 13:23:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1738326192; bh=2qfaRTO5iG5mOYJ+RvO6+d2r0hfl5IUM+PXTysg9LQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=ZH/QrR6CDzrfRyOcDdDH1yAPCkywXurHgOK68RDcFhhdhoq8xD44Fh+6uUGh+dwWw
	 UBOzkZwnU3ddtLRTeU9gq3Ro9Pye5t/VIvS47EuiR6p52UR5Egh3g+CwT4bretriRL
	 9P1/U02bGR2CHxLzixwpkWxHjV7Zcn5ENGNT8IMCsYNGV7EkvrLpD208SD1pV3iCbJ
	 YJpiFVWgIAxaRW3ZJfEeJKJ2G+bPdrPU3tXn5FZ2drudvcOkXIkQH7TlekHEnIB4sg
	 LdJzUnEBnSD/51ERodPs5mvutRoWmEeP0pN0ROgbkERvi/mrMIgITeGplhnDse7Plf
	 4sz+RCqcxm1yg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Ykw5h1ywDz6typ;
	Fri, 31 Jan 2025 13:23:03 +0100 (CET)
Date: Fri, 31 Jan 2025 12:23:03 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: j.ne@posteo.net, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: Re: [PATCH 2/9] dt-bindings: ata: Convert fsl,pq-sata binding to YAML
Message-ID: <Z5zAp3X7U0oftneH@probook>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-2-50649f51c3dd@posteo.net>
 <a9df1ae6-8779-4dc0-8f03-eda939c0e533@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9df1ae6-8779-4dc0-8f03-eda939c0e533@kernel.org>

On Mon, Jan 27, 2025 at 08:22:55AM +0900, Damien Le Moal wrote:
> On 1/27/25 03:58, J. Neuschäfer via B4 Relay wrote:
> > From: "J. Neuschäfer" <j.ne@posteo.net>
> > 
> > Convert the Freescale PowerQUICC SATA controller binding from text form
> > to YAML. The list of compatible strings reflects current usage.
> > 
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
> >  .../devicetree/bindings/ata/fsl,pq-sata.yaml       | 59 ++++++++++++++++++++++
[...]
> > +description: |
> > +  SATA nodes are defined to describe on-chip Serial ATA controllers.
> > +  Each SATA port should have its own node.
> 
> Very unclear. The SATA nodes define ports or controllers ? Normally, a single
> controller can have multiple ports, so the distinction is important.

I'll change it to "Each SATA controller ...", see below.


> > +  cell-index:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [1, 2, 3, 4]
> > +    description: |
> > +      1 for controller @ 0x18000
> > +      2 for controller @ 0x19000
> > +      3 for controller @ 0x1a000
> > +      4 for controller @ 0x1b000
> 
> Are you sure these are different controllers ? Are they not different ports of
> the same controller ? Given that the previous text description define this as
> "controller index", I suspect these are the port offsets and you SATA nodes
> define ports, and not controllers.

They have no shared registers, and each instance has the same register
set (at a different base address).

The MPC8315E reference manual (for example) documents them as:

	SATA 1 Controller—Block Base Address 0x1_8000
	SATA 2 Controller—Block Base Address 0x1_9000

(table A.24 Serial ATA (SATA) Controller)

Section 15.2 Command Operation implies that each SATA controller
supports a single port:

	The SATA controller maintains a queue consisting of up to 16
	commands. These commands can be distributed to a single attached
	device or, if the system contains a port multiplier, over each
	of the attached devices.

So, in conclusion, I'm fairly sure "controller" is the right description.


Best regards,
J. Neuschäfer

