Return-Path: <dmaengine+bounces-4325-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0692FA2B618
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 23:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C12166AC4
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 22:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96FD2417E9;
	Thu,  6 Feb 2025 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="p+RkgaMV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB0D2417E1
	for <dmaengine@vger.kernel.org>; Thu,  6 Feb 2025 22:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882754; cv=none; b=c/NV/vYTdxfoOMIyAhu8loYlwIZiFhujmPYBsLtYsb9lnexKlQJzKBDKbvRbjr+7fAoZJUK7oo5oIMQ1rOfO7w2UItEUEkrroSar2FSOmfs5zCMOqkFXz9rK1emOhCfNR6AfFlV6o6s7JCck6yoNmwIKYo+vXt0xCezduF1nuOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882754; c=relaxed/simple;
	bh=0ntnTKWhZutag/x3HVhP8VZ4Ui4mFuohPb6mz+tL+nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNXv21cEEcyv8KgrHQC3gXbwheyYmPDHGJWSzP68LXS5sxMDslaDeCHHKEpZAtC0l3GlhiEWVXR8gQQCxsL8FCQ0lvzAMpnuBtjq7VlTO/iyp3tYICcnSn/fba+65NcqfzIP2GoFqCUH5QAzlEfH2jzvzY7H+uQ1z0hbPLXoTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=p+RkgaMV; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4CDCF240103
	for <dmaengine@vger.kernel.org>; Thu,  6 Feb 2025 23:59:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1738882750; bh=0ntnTKWhZutag/x3HVhP8VZ4Ui4mFuohPb6mz+tL+nc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=p+RkgaMV9VIAIT8MYZFio3VSfTcUJfYA5FEc+zjfP1EnW22lPFrmANL4PS3LwQnNT
	 602ylrOf2+AntvRiDwn14Jhfy2V1nnrN9wFBJI/kI4PU/+5npRjv6xJ5/AKy/RW6Fv
	 f2YlHOM7k210lFFssN1JAaYVF1YyIKI+GQ7tKJM9pc/jWJBzOM7DVXjYe2MOUXkiue
	 adEt/Bw2fk5rtfWCmrCQoBw9fD94uNiGGmSrUf1QNQ80AgJUDYsJdGYQqwmqTTrn2R
	 oMDGYBC4J4au3YLekaecSKppQGFujoThS8rsOtEJnu5EMXQ+xZWUsk7caf5RSxDEGG
	 7rekhBdR5x3gA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Ypswl20Tqz6txc;
	Thu,  6 Feb 2025 23:59:02 +0100 (CET)
Date: Thu,  6 Feb 2025 22:59:01 +0000
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
Subject: Re: [PATCH RFC 9/9] dt-bindings: nand: Convert fsl,elbc bindings to
 YAML
Message-ID: <Z6U-tVhmbwwULuzQ@probook>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-9-50649f51c3dd@posteo.net>
 <20250127042321.GA3067818-robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250127042321.GA3067818-robh@kernel.org>

On Sun, Jan 26, 2025 at 10:23:21PM -0600, Rob Herring wrote:
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
> 
> That's every external parallel bus. See bindings/memory-controllers/*
> 
> Probably fine to leave 'simple-bus' if that's your question. It's more 
> that there is configuration for the chipselect timings that make's this 
> not a simple-bus. But the address translation should work just fine.

My concern mainly stems from the resulting warnings if I allow/use simple-bus:

Documentation/devicetree/bindings/memory-controllers/fsl,elbc.example.dts:77.23-84.15:
  Warning (simple_bus_reg): /example-1/localbus@e0005000/flash@0,0: simple-bus unit address format error, expected "0"
Documentation/devicetree/bindings/memory-controllers/fsl,elbc.example.dts:86.22-92.15:
  Warning (simple_bus_reg): /example-1/localbus@e0005000/nand@1,0: simple-bus unit address format error, expected "100000000"

Existing devicetrees specify the eLBC with compatible = ..., "simple-bus",
which lead me to include the simple-bus compatible both in the binding
itself and in the examples, which in turn leads to (correct) warnings
from DTC about node names such as nand@1,0 (it expects 100000000).
nand@1,0 was however completely correct for the eLBC bus, because it's
not one big linear address, but rather a chip select (1) and an address (0).

My current idea to resolve this contradiction is to remove simple-bus
from the binding and change affected devicetrees later.

> 
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
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..127f164443972bbaf50fd9daa80c504577ddd7bd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/fsl,elbc-fcm-nand.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NAND flash attached to Freescale eLBC
> > +
> > +maintainers:
> > +  - J. Neuschäfer <j.ne@posteo.net>
> > +
> > +allOf:
> > +  - $ref: nand-chip.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> 
> Don't need oneOf.

How would I express "either one of various chip-specific strings
followed by fsl,elbc-fcm-nand, or fsl,elbc-fcm-nand alone"?

> 
> > +      - items:
> > +          - enum:
> > +              - fsl,mpc8313-fcm-nand
> > +              - fsl,mpc8315-fcm-nand
> > +              - fsl,mpc8377-fcm-nand
> > +              - fsl,mpc8378-fcm-nand
> > +              - fsl,mpc8379-fcm-nand
> > +              - fsl,mpc8536-fcm-nand
> > +              - fsl,mpc8569-fcm-nand
> > +              - fsl,mpc8572-fcm-nand
> > +              - fsl,p1020-fcm-nand
> > +              - fsl,p1021-fcm-nand
> > +              - fsl,p1025-fcm-nand
> > +              - fsl,p2020-fcm-nand
> > +          - const: fsl,elbc-fcm-nand
> > +      - const: fsl,elbc-fcm-nand
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#address-cells": true
> > +
> > +  "#size-cells": true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> 
> If you use anything from nand-chip.yaml, then you need 
> unevaluatedProperties here.

Noted, will fix.

> 
> > +
> > +examples:
> > +  - |
> > +    localbus {
> > +        #address-cells = <2>;
> > +        #size-cells = <1>;
> > +
> > +        nand@1,0 {
> > +            #address-cells = <1>;
> > +            #size-cells = <1>;
> > +            compatible = "fsl,mpc8315-fcm-nand",
> > +                         "fsl,elbc-fcm-nand";
> > +            reg = <0x1 0x0 0x2000>;
> > +        };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fsl,elbc-gpcm-uio.yaml b/Documentation/devicetree/bindings/powerpc/fsl/fsl,elbc-gpcm-uio.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..60f849b79c11a4060f2fa4ab163f9fa9317df130
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/powerpc/fsl/fsl,elbc-gpcm-uio.yaml
> > @@ -0,0 +1,55 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/powerpc/fsl/fsl,elbc-gpcm-uio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Userspace I/O interface for Freescale eLBC devices
> > +
> > +maintainers:
> > +  - J. Neuschäfer <j.ne@posteo.net>
> > +
> > +properties:
> > +  compatible:
> > +    const: fsl,elbc-gpcm-uio
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  elbc-gpcm-br:
> > +    description: Base Register (BR) value to set
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  elbc-gpcm-or:
> > +    description: Option Register (OR) value to set
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  device_type: true
> 
> This should be dropped.

Will do


> > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fsl,elbc.yaml b/Documentation/devicetree/bindings/powerpc/fsl/fsl,elbc.yaml
[...]
> > +  "#address-cells":
> > +    enum: [2, 3]
> > +    description: |
> 
> Don't need '|' unless there's some formatting.

Will remove.

> 
> > +      The first cell is the chipselect number, and the remaining cells are the
> > +      offset into the chipselect.
> > +
> > +  "#size-cells":
> > +    enum: [1, 2]
> > +    description: |
> > +      Either one or two, depending on how large each chipselect can be.
> > +
> > +  ranges:
> > +    description: |
> > +      Each range corresponds to a single chipselect, and covers the entire
> > +      access window as configured.
> > +
> > +patternProperties:
> > +  "^.*@.*$":
> 
> You should define the unit-address format here: @<chipselect>,<offset>

Will do.



Thanks,
J. Neuschäfer

