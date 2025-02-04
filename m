Return-Path: <dmaengine+bounces-4272-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C70A279A0
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 19:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF08C188735C
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 18:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADA478F4A;
	Tue,  4 Feb 2025 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="QLuSB3Cp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2276217645
	for <dmaengine@vger.kernel.org>; Tue,  4 Feb 2025 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693163; cv=none; b=gLVQeFIbDnNP3k9Xbtiu6ET4TPCKxS2GNN0A/ZXQwsi/C4SyFAGJ/PXCGkG5I52+27M7hiTxZ1J7Yw0SnEU0vlBBR1pbM9EbXXsAuoEDD/wrmDuxqR+HridYxmblSDfrBuYj5HpVM7kjGhF0Un+tkUMmzHdEffYxIcWYq2TPlxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693163; c=relaxed/simple;
	bh=TCqqBaH/6DxhhY4LxUIZxLWTUzfo7FZ0g9lCT/VEHVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHGvy2eJyhku6T9Cq0vRAzt8tt+CRs7bFdR3BihOxmheEFBQ6ukJRjdteRS2bdfNsTzPK+Hy6C+VQ2ar8cVaDrV1CI/ZUKJQQ+5uUT6i4qx5FMtO1bPaNtgS45tyO0dQppJbsW94i+C9JQlCIAK/wAcHoTqCKSzcgga5Sd6xjw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=QLuSB3Cp; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 145F4240105
	for <dmaengine@vger.kernel.org>; Tue,  4 Feb 2025 19:19:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1738693152; bh=TCqqBaH/6DxhhY4LxUIZxLWTUzfo7FZ0g9lCT/VEHVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=QLuSB3Cp5wmxvy0AcnxYAbea4vAVqLHQ2qWlm36gLR16yyS9Z6v9YRiCvyp4j4gn5
	 LgZDTviocjTkkrBZfKjqIX7HKrKmbEgZd5usiMBwfyowuAzH7n9ya5rw+1WcRG1Oim
	 61l/YRbLQ/MuqjUeCkWoQ1kkGDN+vaSKCCpYDwnidKomCYAjqhFy+gkv+aXN4VknA6
	 SHTFc7qSWaWjKRuglfENNnh6zyhAw0zuaTMO+sMLjEjkDm5sMj/UWLXt8eIducymRH
	 jcDEMinpzWrqCDL2LTwSNhNU1eiDWLfNxb9bwY4wxFJwO7H3iV26supD7Xr4Uco5Zq
	 7tomMw0Ep2Izg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YnWpc4lyZz6tw4;
	Tue,  4 Feb 2025 19:19:03 +0100 (CET)
Date: Tue,  4 Feb 2025 18:19:03 +0000
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
Subject: Re: [PATCH 5/9] dt-bindings: dma: Convert fsl,elo*-dma bindings to
 YAML
Message-ID: <Z6JaFxfwC0tAB4uQ@probook>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-5-50649f51c3dd@posteo.net>
 <20250127044735.GD3106458-robh@kernel.org>
 <Z5zYGdZU-IXwIuR6@probook>
 <CAL_JsqJAX1QbXvG16NV2g6DGece6KiG_V-uyKQQLA618Oq9miw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJAX1QbXvG16NV2g6DGece6KiG_V-uyKQQLA618Oq9miw@mail.gmail.com>

On Fri, Jan 31, 2025 at 04:16:07PM -0600, Rob Herring wrote:
> On Fri, Jan 31, 2025 at 8:03 AM J. Neuschäfer <j.ne@posteo.net> wrote:
> >
> > On Sun, Jan 26, 2025 at 10:47:35PM -0600, Rob Herring wrote:
> > > On Sun, Jan 26, 2025 at 07:59:00PM +0100, J. Neuschäfer wrote:
> > > > The devicetree bindings for Freescale DMA engines have so far existed as
> > > > a text file. This patch converts them to YAML, and specifies all the
> > > > compatible strings currently in use in arch/powerpc/boot/dts.
> > > >
> > > > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > > > ---
> > > >  .../devicetree/bindings/dma/fsl,elo-dma.yaml       | 129 +++++++++++++
> > > >  .../devicetree/bindings/dma/fsl,elo3-dma.yaml      | 105 +++++++++++
> > > >  .../devicetree/bindings/dma/fsl,eloplus-dma.yaml   | 120 ++++++++++++
> > > >  .../devicetree/bindings/powerpc/fsl/dma.txt        | 204 ---------------------
> > > >  4 files changed, 354 insertions(+), 204 deletions(-)
> > [...]
> > > > +patternProperties:
> > > > +  "^dma-channel@.*$":
> > > > +    type: object
> > >
> > >        additionalProperties: false
> >
> > I'll add it.
> >
> > > (The tools should have highlighted this)
> >
> > With dtschema 2024.11 installed, "make dt_binding_check
> > DT_SCHEMA_FILES=fsl,elo-dma.yaml" does not highlight this.
> 
> Actually, it's the top-level 'addtionalProperties: true' that disables
> the check here. That should be false as well.

Noted. This did indeed help me find more errors.


Best regards,
J. Neuschäfer

