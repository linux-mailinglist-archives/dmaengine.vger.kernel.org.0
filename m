Return-Path: <dmaengine+bounces-4380-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E79FEA2EB1B
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 12:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8F418882D4
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 11:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FB31E04B5;
	Mon, 10 Feb 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="JpmWN1g6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0AA1DEFFC
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187096; cv=none; b=HruptK/dwouX56/hzRfowK+tMPRffzQYBCbNB3BF0JQO1FB1AZw0JaIYJXvB/GyiJEcgv3k8Q7l5p5g1o9Q7+GvqEwBegkua1/DvQLZeFZuPIeN/iC2jpx3X6bBw+DM5ttMutVuTXYFmivePeDePWowMDXdn4mXWPRwB9KqQA20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187096; c=relaxed/simple;
	bh=JF/n15lnAm7NZMFbEUTi4J8f8m2TQ7lxj7+v1eHdIuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYuJoAAARB+vl0nO5hZ22/QL4IpJW4+eqF2BLhD25IzEbxSKD6g6fzThN2EKeuBEm5iyaeQM7vHi07WcZNGaCLWodFAqwaLZgQ0zlpvZAPU1Z3obrtoJGTV0L8EwCa63OpaRHc7alsMCr6LXux6d4ZUdHA4k+heqYbIuACmXCMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=JpmWN1g6; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 1410F240028
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 12:31:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739187085; bh=JF/n15lnAm7NZMFbEUTi4J8f8m2TQ7lxj7+v1eHdIuY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=JpmWN1g6e9WQyrXQ7YqKa6Kz7YaEDYolPFawuJollCAzXyAykqbJGoZ+zalrhTLl8
	 0f20eLO/gb+kGMQG2fH5TKmJEFrqGaN6UwBOAyyTSCiSuA57Gfh1FfJR75F2BTuW7Y
	 /y2wCp2bUoNfwe8q67lwJI2tleg3YW+PS4g+S57IUQyxrG6AeC8sx71dc9aXf0Q5rE
	 ikLvW6yzzw4cRkk6JOrSz2ttcOw/XLuzsx6rsHe0z0p6E3OCWI5L8kDFa14iqPeDcP
	 /xijkoq/1z1YJJwTE3M4e6n7DlQEG+y3BB99cR2HqY4pCUnD30XDSw+fWIzzAOuBpH
	 CY8rACCyyxnAw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Ys2TK4ysMz6tw3;
	Mon, 10 Feb 2025 12:31:17 +0100 (CET)
Date: Mon, 10 Feb 2025 11:31:01 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Crystal Wood <oss@buserror.net>
Cc: j.ne@posteo.net, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk@kernel.org>, imx@lists.linux.dev,
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
	linux-mtd@lists.infradead.org, Li Yang <leoyang.li@nxp.com>,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2 09/12] dt-bindings: memory-controllers: Convert
 fsl,elbc to YAML
Message-ID: <Z6njdeo8kHw6RtYH@probook>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-9-8137b0c42526@posteo.net>
 <Z6kQpuQf5m-bXTyt@buserror.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6kQpuQf5m-bXTyt@buserror.net>

On Sun, Feb 09, 2025 at 02:31:34PM -0600, Crystal Wood wrote:
> On Fri, Feb 07, 2025 at 10:30:26PM +0100, J. Neuschäfer via B4 Relay wrote:
> > From: "J. Neuschäfer" <j.ne@posteo.net>
> > 
> > Convert the Freescale localbus controller bindings from text form to
> > YAML. The updated list of compatible strings reflects current usage
> > in arch/powerpc/boot/dts/, except that many existing device trees
> > erroneously specify "simple-bus" in addition to fsl,*elbc.
> > 
> > Changes compared to the txt version:
> >  - removed the board-control (fsl,mpc8272ads-bcsr) node because it only
> >    appears in this example and nowhere else
> >  - added a new example with NAND flash
> >  - updated list of compatible strings
> > 
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
> > 
> > V2:
> > - fix order of properties in examples, according to dts coding style
> > - move to Documentation/devicetree/bindings/memory-controllers
> > - clarify the commit message a tiny bit
> > - remove unnecessary multiline markers (|)
> > - define address format in patternProperties
> > - trim subject line (remove "binding")
> > - remove use of "simple-bus", because it's technically incorrect
> 
> While I admit I haven't been following recent developments in this area,
> as someone who was involved when "simple-bus" was created (and was on the
> ePAPR committee that standardized it) I'm surprised to hear simple-bus
> being called "erroneous" or "technically incorrect" here.

It is quite possible that my understanding of it is incomplete or wrong.

> 
> For non-NAND devices this bus generally meets the definition of "an
> internal I/O bus that cannot be probed for devices" where "devices on the
> bus can be accessed directly without additional configuration
> required".  NAND flash is an exception, but those devices have
> compatibles that are specific to the bus controller.
> 
> The fact that the address encoding is non-linear is irrelevant; the
> addresses can still be translated using the standard "ranges" mechanism. 
> This seems to be a disconnect between the schema verification and the way
> the compatible has previously been defined and used.

This is what led me to my assumptions: The simple-bus validation logic
in dtc complains about unit addresses such as nand@1,0 which are quite
appropriate for the eLBC.

> 
> And as a practical matter, unless I'm missing something (which I might be
> since I haven't been in devicetree-land for nearly a decade), Linux is
> relying on simple-bus to probe these devices.  There is a driver that
> binds to the bus itself but that is just for error interrupts and NAND.

As of now, yes, that's correct. Without simple-bus, a current Linux
kernel doesn't find the device nodes inside such a localbus.

> 
> You'd probably need something like commit 3e25f800afb82bd9e5f8 ("memory:
> fsl_ifc: populate child devices without relying on simple-bus") and the 
> subsequent fix in dd8adc713b1656 ("memory: fsl_ifc: populate child
> nodes of buses and mfd devices")...

I have prepared such a patch, based on the same assumptions:

  [PATCH] powerpc/fsl_lbc: Explicitly populate bus
  https://lore.kernel.org/lkml/20250209-localbus-v1-1-efcd780153a0@posteo.net/

> 
> I'm curious what the reasoning was for removing simple-bus from IFC.  It
> seems that the schema verification also played a role in that:
> https://www.spinics.net/lists/devicetree/msg220418.html

Yes, that's the same as my reasoning.

> 
> ...but there's also the comment in 985ede63a045eabf3f9d ("dt-bindings:
> memory: fsl: convert ifc binding to yaml schema") that "this will help to
> enforce the correct probe order between parent device and child devices",
> but was that really not already guaranteed by the parent/child
> relationship (and again, it should only really matter for NAND except for
> the possibility of missing error reports during early boot)?

I'm inclined to agree with you, but it's somewhat beyond my skill level.

I'll let Li Yang or Rob Herring comment on that.

> 
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - fsl,mpc8313-elbc
> > +              - fsl,mpc8315-elbc
> > +              - fsl,mpc8377-elbc
> > +              - fsl,mpc8378-elbc
> > +              - fsl,mpc8379-elbc
> > +              - fsl,mpc8536-elbc
> > +              - fsl,mpc8569-elbc
> > +              - fsl,mpc8572-elbc
> > +              - fsl,p1020-elbc
> > +              - fsl,p1021-elbc
> > +              - fsl,p1023-elbc
> > +              - fsl,p2020-elbc
> > +              - fsl,p2041-elbc
> > +              - fsl,p3041-elbc
> > +              - fsl,p4080-elbc
> > +              - fsl,p5020-elbc
> > +              - fsl,p5040-elbc
> > +          - const: fsl,elbc
> 
> Is it really necessary to list every single chip?
> 
> And then it would need to be updated when new ones came out?  I know this
> particular line of chips is not going to see any new members at this
> point, but as far as the general approach goes...

As far as I'm aware, this reflects common practice today.

> 
> Does the schema validation complain if it sees an extra compatible it
> doesn't recognize?  If so that's obnoxious.

Yes.

> 
> > +examples:
> > +  - |
> > +    localbus@f0010100 {
> > +        compatible = "fsl,mpc8272-localbus",
> > +                     "fsl,pq2-localbus";
> > +        reg = <0xf0010100 0x40>;
> > +        ranges = <0x0 0x0 0xfe000000 0x02000000
> > +                  0x1 0x0 0xf4500000 0x00008000
> > +                  0x2 0x0 0xfd810000 0x00010000>;
> > +        #address-cells = <2>;
> > +        #size-cells = <1>;
> > +
> > +        flash@0,0 {
> > +            compatible = "jedec-flash";
> > +            reg = <0x0 0x0 0x2000000>;
> > +            bank-width = <4>;
> > +            device-width = <1>;
> > +        };
> > +
> > +        simple-periph@2,0 {
> > +            compatible = "fsl,elbc-gpcm-uio";
> > +            reg = <0x2 0x0 0x10000>;
> > +            elbc-gpcm-br = <0xfd810800>;
> > +            elbc-gpcm-or = <0xffff09f7>;
> > +        };
> 
> I know this isn't new, but... since we're using this as an example,
> where is the documentation for this fsl,elbc-gpcm-uio and
> elbc-gpcm-br/or?  What exactly is a simple-periph?

fsl,elbc-gpcm-uio is handled in the following patch
(dt-bindings: memory-controllers: Add fsl,elbc-gpcm-uio).

simple-periph is something I haven't thought about, because this whole
example comes from the old txt-format binding. The whole purpose of
fsl,elbc-gpcm-uio is to allow userspace drivers to interact with
localbus devices, so that doesn't make the intention any clearer, either.

> 
> There are no in-tree device trees that use this either.  The bcsr
> node was actually a much more normal example, despite that particular
> platform having been removed.  There are other bcsr nodes that still
> exist that could be used instead.

Ah, fsl,mpc8568mds-bcsr for example, good point. I'll add it back.

> 
> -Crystal

Thank you for reaching out!

Best regards,
J. Neuschäfer

