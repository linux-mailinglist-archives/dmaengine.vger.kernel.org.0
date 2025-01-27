Return-Path: <dmaengine+bounces-4212-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5569DA1D26E
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 09:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611E21886C28
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 08:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DA8156886;
	Mon, 27 Jan 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIv8GsOT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6818C11;
	Mon, 27 Jan 2025 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737967056; cv=none; b=p3EEQB0uMpvaeeOPgCYt1TBoci4+PCyjmOQXymtELE1zBKyf945ZirGA9Aiz7Lg777GRDnNWbplG3riWMXhIVaiCWGql+t/vmKMWEWfUVAVOTlAkpiBp9fvuj8W//gJWTCimSAoJPQl6ahJO1DNiocr5/DpLdpNmCBQPOxpAsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737967056; c=relaxed/simple;
	bh=lO9NymPFr6bhwMFfAllVvVLeDbAVw1xGh+GP1heN7js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3qheuOiNiqQWsiejrrguJv9UV2QrBHlwbiE3pJR3jA/vDYXC8N03ZJGQ+6Wf6fwylbFBvLVSs23PP6UlhV530MLa0QLexdGWT2IVIbjIUAf0HkVprv+Y2ZnjuL2mo0rLXhcqY9/btS3+zTcOT+tkC2iR6oP1TRI8CtgXJDppgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIv8GsOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B5CC4CED2;
	Mon, 27 Jan 2025 08:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737967055;
	bh=lO9NymPFr6bhwMFfAllVvVLeDbAVw1xGh+GP1heN7js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIv8GsOTxD0MNBdcccL2gsR2GrsPOH7kYiWCdaqYHMQJl06quxNk06u372au5ecHh
	 2Km7poxUCviWvnWyWTOZ2XsGaIdWVQ95eEQxqPt76q/lEMFBkasYlNeYPXT0k1/s5u
	 mw2TCXDM4aOChO8w9BDR2JG1aT6fNADge7Ss9cZJlS5a3vzIg1SFxeuKR3unpvtQKp
	 5EUGDJ/a2/K6EDh3hGmn5JXR7YdC39zqGsMjrUUUGw34bynf+MWBTNE9KVb2eth6CY
	 DslXsJIm1PuK3EsUVpPhPjXU33U6TD2oYXqG8X2GLTSv/NG2/ufxjvVXHEYaaJzxMw
	 Y5cb5He53K49Q==
Date: Mon, 27 Jan 2025 09:37:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Scott Wood <oss@buserror.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH RFC 9/9] dt-bindings: nand: Convert fsl,elbc bindings to
 YAML
Message-ID: <20250127-cuddly-dalmatian-of-saturation-5f1ae2@krzk-bin>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-9-50649f51c3dd@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250126-ppcyaml-v1-9-50649f51c3dd@posteo.net>

On Sun, Jan 26, 2025 at 07:59:04PM +0100, J. Neusch=C3=A4fer wrote:
> Convert the Freescale localbus controller bindings from text form to
> YAML. The list of compatible strings reflects current usage.

simple-bus and 20 other compatibles you used were not present in the
original binding. Does above "list of compatible strings" mean you just
added them?

>=20
> Changes compared to the txt version:
>  - removed the board-control (fsl,mpc8272ads-bcsr) node because it only
>    appears in this example and nowhere else
>  - added a new example with NAND flash
>=20
> Remaining issues:
>  - The localbus is not really a simple-bus: Unit addresses are not simply
>    addresses on a memory bus. Instead, they have a format: The first cell
>    is a chip select number, the remaining one or two cells are bus
>    addresses.
>=20
> Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>
> ---
>  .../devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml |  61 +++++++++
>  .../bindings/powerpc/fsl/fsl,elbc-gpcm-uio.yaml    |  55 ++++++++

Please split the conversion from adding new bindings. For example above
file and its compatible fsl,elbc-gpcm-uio was not documented in original
TXT.

=2E..

> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fsl,elbc.yaml =
b/Documentation/devicetree/bindings/powerpc/fsl/fsl,elbc.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..6bbceb82c77826499abe85879=
e9189b18d396eea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/fsl,elbc.yaml
> @@ -0,0 +1,150 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/powerpc/fsl/fsl,elbc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Enhanced Local Bus Controller

What sort of bus is it? Memory bus? Then place it with others, see
memory directory.

> +
> +maintainers:
> +  - J. Neusch=C3=A4fer <j.ne@posteo.net>
> +
> +properties:
> +  $nodename:
> +    pattern: "^localbus@[0-9a-f]+$"
> +
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
> +          - const: simple-bus
> +
> +      - items:
> +          - const: fsl,mpc8272-localbus
> +          - const: fsl,pq2-localbus
> +
> +      - items:
> +          - enum:
> +              - fsl,mpc8247-localbus
> +              - fsl,mpc8248-localbus
> +              - fsl,mpc8360-localbus
> +          - const: fsl,pq2pro-localbus
> +          - const: simple-bus
> +
> +      - items:
> +          - enum:
> +              - fsl,mpc8540-localbus
> +              - fsl,mpc8544-lbc
> +              - fsl,mpc8544-localbus
> +              - fsl,mpc8548-lbc
> +              - fsl,mpc8548-localbus
> +              - fsl,mpc8560-localbus
> +              - fsl,mpc8568-localbus
> +          - const: fsl,pq3-localbus
> +          - const: simple-bus
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    enum: [2, 3]
> +    description: |
> +      The first cell is the chipselect number, and the remaining cells a=
re the
> +      offset into the chipselect.
> +
> +  "#size-cells":
> +    enum: [1, 2]
> +    description: |
> +      Either one or two, depending on how large each chipselect can be.
> +
> +  ranges:
> +    description: |
> +      Each range corresponds to a single chipselect, and covers the enti=
re
> +      access window as configured.
> +
> +patternProperties:
> +  "^.*@.*$":
> +    type: object

And probably you need=20
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    localbus@f0010100 {
> +        compatible =3D "fsl,mpc8272-localbus",
> +                     "fsl,pq2-localbus";
> +        #address-cells =3D <2>;
> +        #size-cells =3D <1>;
> +        reg =3D <0xf0010100 0x40>;

compatible, then reg - see DTS coding style.

> +
> +        ranges =3D <0x0 0x0 0xfe000000 0x02000000
> +                  0x1 0x0 0xf4500000 0x00008000
> +                  0x2 0x0 0xfd810000 0x00010000>;
> +
> +        flash@0,0 {
> +            compatible =3D "jedec-flash";
> +            reg =3D <0x0 0x0 0x2000000>;

Well, here it is correct

> +            bank-width =3D <4>;
> +            device-width =3D <1>;
> +        };
> +
> +        simple-periph@2,0 {
> +            compatible =3D "fsl,elbc-gpcm-uio";
> +            reg =3D <0x2 0x0 0x10000>;
> +            elbc-gpcm-br =3D <0xfd810800>;
> +            elbc-gpcm-or =3D <0xffff09f7>;
> +        };
> +    };
> +
> +  - |
> +    localbus@e0005000 {

compatible, reg

> +        #address-cells =3D <2>;
> +        #size-cells =3D <1>;
> +        compatible =3D "fsl,mpc8315-elbc", "fsl,elbc", "simple-bus";
> +        reg =3D <0xe0005000 0x1000>;
> +        interrupts =3D <77 0x8>;
> +        interrupt-parent =3D <&ipic>;
> +
> +        ranges =3D <0x0 0x0 0xfe000000 0x00800000
> +                  0x1 0x0 0xe0600000 0x00002000
> +                  0x2 0x0 0xf0000000 0x00020000
> +                  0x3 0x0 0xfa000000 0x00008000>;
> +
> +        flash@0,0 {

compatible, reg

> +            #address-cells =3D <1>;
> +            #size-cells =3D <1>;
> +            compatible =3D "cfi-flash";
> +            reg =3D <0x0 0x0 0x800000>;
> +            bank-width =3D <2>;
> +            device-width =3D <1>;
> +        };
> +
> +        nand@1,0 {

compatible, reg

> +            #address-cells =3D <1>;
> +            #size-cells =3D <1>;
> +            compatible =3D "fsl,mpc8315-fcm-nand",
> +                         "fsl,elbc-fcm-nand";
> +            reg =3D <0x1 0x0 0x2000>;
> +        };

Best regards,
Krzysztof


