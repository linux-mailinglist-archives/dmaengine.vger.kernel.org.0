Return-Path: <dmaengine+bounces-4366-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7C4A2E0CE
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2025 22:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4F0163E1C
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2025 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578661E231F;
	Sun,  9 Feb 2025 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=buserror.net header.i=@buserror.net header.b="0UnPtkDc"
X-Original-To: dmaengine@vger.kernel.org
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB81A1DFE16;
	Sun,  9 Feb 2025 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.227.176.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739135911; cv=none; b=MNwEr+nn9+4g2L8bz7nAjFGVL4iE6HwuIVR9WpzukCjwi6cbGV/3iT35XX5B0uS0cUzQAeBKbSBbmgFFJj+MwhQ8hsMpK2/iWRlfKz6eYqoyVBiSM4d4bP5E62whuB2A6FG2RzF/fItzo/GZQ6NJgEuoJ/7te4eTAfFEDTDFl5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739135911; c=relaxed/simple;
	bh=Kg6oaiN5VgUed118o3orQZEWOHSb84YE2ygFB+H2ORo=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Subject; b=dU7dlYWvVjs2yHmPCYz9K7BAbCKotz8kkMlb5ky3IEdRrGHKMWyFrcYC34CfyFIVchSjoMQpv/9SWRnNwdnEc0VzsOi6b+Y4eadHUZZlGOkAGP5BvMSa20l/j1F0YYdU++oinV5IewEXtrT85cACLK8fqPKaBEvOIc4awoS/0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=buserror.net; spf=pass smtp.mailfrom=buserror.net; dkim=pass (2048-bit key) header.d=buserror.net header.i=@buserror.net header.b=0UnPtkDc; arc=none smtp.client-ip=165.227.176.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=buserror.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buserror.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=buserror.net; s=rsa_sel; h=Subject:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Cc:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EpToGD3dUgsdAKwVgr42gOxVA1d/S1QPZ4reqp0Dgs8=; b=0UnPtkDcmzDcjvHDUHyLT2CjRU
	Wu31RLzuZn8p0dV1DURWjhl+4+u/yXCjfpbN//Fv+gzr7dFxyWAIY13siJk1+2c2h7flpXKEbo5GK
	Nzb0MrDhlkKl23df30ZGunrnNmUcpvB/tY7q0jPyZACh4u0zgcDKAURgcZgDdJCfSub1blBNmf6Ye
	2sc/RnS11ATYBdxLh4TOGHrIUM868ob5a1q6cLyIoCxxUqwRzg3HVOyqHUfIDBNgC955YJewdlyOP
	VUcjGVLAyzhCUnLHWphUkyZmWKmwZrAiNhydfaGiX5Yiakntm82WcDWO+upyCLZ9SU2k3ajGLNyec
	oI4TO6mg==;
Received: from oss by baldur.buserror.net with local (Exim 4.96)
	(envelope-from <oss@buserror.net>)
	id 1thDxm-00C5Xt-1r;
	Sun, 09 Feb 2025 14:31:35 -0600
Date: Sun, 9 Feb 2025 14:31:34 -0600
From: Crystal Wood <oss@buserror.net>
To: j.ne@posteo.net
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
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
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
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
Message-ID: <Z6kQpuQf5m-bXTyt@buserror.net>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-9-8137b0c42526@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207-ppcyaml-v2-9-8137b0c42526@posteo.net>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: j.ne@posteo.net, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, krzk@kernel.org, imx@lists.linux.dev, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, dlemoal@kernel.org, cassel@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, lee@kernel.org, vkoul@kernel.org, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com, j.neuschaefer@gmx.net, wim@linux-watchdog.org, linux@roeck-us.net, broonie@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, leoyang.li@nxp.com, john.ogness@linutronix.de
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Level: 
X-Spam-Report: 
	*  -15 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	* -0.0 NO_RELAYS Informational: message was not relayed via SMTP
Subject: Re: [PATCH v2 09/12] dt-bindings: memory-controllers: Convert
 fsl,elbc to YAML
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)

On Fri, Feb 07, 2025 at 10:30:26PM +0100, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> Convert the Freescale localbus controller bindings from text form to
> YAML. The updated list of compatible strings reflects current usage
> in arch/powerpc/boot/dts/, except that many existing device trees
> erroneously specify "simple-bus" in addition to fsl,*elbc.
> 
> Changes compared to the txt version:
>  - removed the board-control (fsl,mpc8272ads-bcsr) node because it only
>    appears in this example and nowhere else
>  - added a new example with NAND flash
>  - updated list of compatible strings
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> V2:
> - fix order of properties in examples, according to dts coding style
> - move to Documentation/devicetree/bindings/memory-controllers
> - clarify the commit message a tiny bit
> - remove unnecessary multiline markers (|)
> - define address format in patternProperties
> - trim subject line (remove "binding")
> - remove use of "simple-bus", because it's technically incorrect

While I admit I haven't been following recent developments in this area,
as someone who was involved when "simple-bus" was created (and was on the
ePAPR committee that standardized it) I'm surprised to hear simple-bus
being called "erroneous" or "technically incorrect" here.

For non-NAND devices this bus generally meets the definition of "an
internal I/O bus that cannot be probed for devices" where "devices on the
bus can be accessed directly without additional configuration
required".  NAND flash is an exception, but those devices have
compatibles that are specific to the bus controller.

The fact that the address encoding is non-linear is irrelevant; the
addresses can still be translated using the standard "ranges" mechanism. 
This seems to be a disconnect between the schema verification and the way
the compatible has previously been defined and used.

And as a practical matter, unless I'm missing something (which I might be
since I haven't been in devicetree-land for nearly a decade), Linux is
relying on simple-bus to probe these devices.  There is a driver that
binds to the bus itself but that is just for error interrupts and NAND.

You'd probably need something like commit 3e25f800afb82bd9e5f8 ("memory:
fsl_ifc: populate child devices without relying on simple-bus") and the 
subsequent fix in dd8adc713b1656 ("memory: fsl_ifc: populate child
nodes of buses and mfd devices")...

I'm curious what the reasoning was for removing simple-bus from IFC.  It
seems that the schema verification also played a role in that:
https://www.spinics.net/lists/devicetree/msg220418.html

...but there's also the comment in 985ede63a045eabf3f9d ("dt-bindings:
memory: fsl: convert ifc binding to yaml schema") that "this will help to
enforce the correct probe order between parent device and child devices",
but was that really not already guaranteed by the parent/child
relationship (and again, it should only really matter for NAND except for
the possibility of missing error reports during early boot)?

> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,mpc8313-elbc
> +              - fsl,mpc8315-elbc
> +              - fsl,mpc8377-elbc
> +              - fsl,mpc8378-elbc
> +              - fsl,mpc8379-elbc
> +              - fsl,mpc8536-elbc
> +              - fsl,mpc8569-elbc
> +              - fsl,mpc8572-elbc
> +              - fsl,p1020-elbc
> +              - fsl,p1021-elbc
> +              - fsl,p1023-elbc
> +              - fsl,p2020-elbc
> +              - fsl,p2041-elbc
> +              - fsl,p3041-elbc
> +              - fsl,p4080-elbc
> +              - fsl,p5020-elbc
> +              - fsl,p5040-elbc
> +          - const: fsl,elbc

Is it really necessary to list every single chip?

And then it would need to be updated when new ones came out?  I know this
particular line of chips is not going to see any new members at this
point, but as far as the general approach goes...

Does the schema validation complain if it sees an extra compatible it
doesn't recognize?  If so that's obnoxious.

> +examples:
> +  - |
> +    localbus@f0010100 {
> +        compatible = "fsl,mpc8272-localbus",
> +                     "fsl,pq2-localbus";
> +        reg = <0xf0010100 0x40>;
> +        ranges = <0x0 0x0 0xfe000000 0x02000000
> +                  0x1 0x0 0xf4500000 0x00008000
> +                  0x2 0x0 0xfd810000 0x00010000>;
> +        #address-cells = <2>;
> +        #size-cells = <1>;
> +
> +        flash@0,0 {
> +            compatible = "jedec-flash";
> +            reg = <0x0 0x0 0x2000000>;
> +            bank-width = <4>;
> +            device-width = <1>;
> +        };
> +
> +        simple-periph@2,0 {
> +            compatible = "fsl,elbc-gpcm-uio";
> +            reg = <0x2 0x0 0x10000>;
> +            elbc-gpcm-br = <0xfd810800>;
> +            elbc-gpcm-or = <0xffff09f7>;
> +        };

I know this isn't new, but... since we're using this as an example,
where is the documentation for this fsl,elbc-gpcm-uio and
elbc-gpcm-br/or?  What exactly is a simple-periph?

There are no in-tree device trees that use this either.  The bcsr
node was actually a much more normal example, despite that particular
platform having been removed.  There are other bcsr nodes that still
exist that could be used instead.

-Crystal

