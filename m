Return-Path: <dmaengine+bounces-4411-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74985A2FBEF
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 22:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53B11885964
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 21:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181AB1C1F2F;
	Mon, 10 Feb 2025 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okX4G/08"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D26189B8C;
	Mon, 10 Feb 2025 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222708; cv=none; b=oo4Wog/9y22zPVnnn096NlYQT/TVI+BbYFqJ3wyY6hAF6dMai7Br4WEHbuy8Qtr+5sa5kE+xIQxfgZQCr/iJZD23VKI4vJKrA+Wr76NFMNI8I12XDl06jerVd7BpxgDK4rim1SlvyrPRa2ZdLC2zSaTwR/jNmQ1LhGnprw/2i3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222708; c=relaxed/simple;
	bh=odzw75cV5CCw5F2vlG3P/t5VL3psVGoWe8Jb/yZ+oYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNEl+Oxvl2QlUuDwreqIOm/QxTA7bzuzHG9uuURHYv0oYoNPVuvu7Qfq10FrYxzo1VuGo6jCb/tZqWSV1+vvCfEu3SFgYEBfU9Ol56tW8y2oZMX787YfWRsw4juIWS7eFrWFz//RzKqenXb+CACG0oNWUWLqjpcuJLTeIVhyjRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okX4G/08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07006C4CED1;
	Mon, 10 Feb 2025 21:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739222707;
	bh=odzw75cV5CCw5F2vlG3P/t5VL3psVGoWe8Jb/yZ+oYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=okX4G/08PMaMILx+F7JidAMdoMWndseWORO9ude8E6aWFIxh17YXQ46LJnk2B5eaf
	 CsmusmqxJGdFmvFxiBt3uPj0Rk3r2oisfAITv+KHRCfLBjiL6BwomL+sTzmqCqwURA
	 l9TTcqCPGmkGodVb/N007KnsDnN5leSYWOswBK3NQ1SNmqKJnMiVqugPnYdUdoYpre
	 IF+Kyml+/75V34sBLta5+UFzTQDIfwZISfv9DJLnHSk6goxZ+SweEGrJsKADOs18/x
	 KSzQ+SLbbjMfXB81ZQ8UBYbOveDQExy9USZXdFkjmtEk9ORBlQqeTEwDSuzPL6iBCk
	 hMxOmsDQ+zv5A==
Date: Mon, 10 Feb 2025 15:25:06 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk@kernel.org>, imx@lists.linux.dev,
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
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 06/12] dt-bindings: pci: Convert fsl,mpc83xx-pcie to
 YAML
Message-ID: <20250210212506.GA1036627-robh@kernel.org>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-6-8137b0c42526@posteo.net>
 <Z6fxo4j5a6ro0f1w@probook>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6fxo4j5a6ro0f1w@probook>

On Sun, Feb 09, 2025 at 12:06:59AM +0000, J. Neuschäfer wrote:
> On Fri, Feb 07, 2025 at 10:30:23PM +0100, J. Neuschäfer via B4 Relay wrote:
> > From: "J. Neuschäfer" <j.ne@posteo.net>
> > 
> > Formalise the binding for the PCI controllers in the Freescale MPC8xxx
> > chip family. Information about PCI-X-specific properties was taken from
> > fsl,pci.txt. The examples were taken from mpc8315erdb.dts and
> > xpedite5200_xmon.dts.
> > 
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
> > 
> > V2:
> > - merge fsl,pci.txt into fsl,mpc8xxx-pci.yaml
> > - regroup compatible strings, list single-item values in one enum
> > - trim subject line (remove "binding")
> > - fix property order to comply with dts coding style
> > ---
> >  .../devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml   | 115 +++++++++++++++++++++
> >  Documentation/devicetree/bindings/pci/fsl,pci.txt  |  27 -----
> >  2 files changed, 115 insertions(+), 27 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml b/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..57c5503cec47e6e90ed2b09835bfad10309db927
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml
> > @@ -0,0 +1,115 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +
> > +$id: http://devicetree.org/schemas/pci/fsl,mpc8xxx-pci.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale MPC83xx PCI/PCI-X/PCIe controllers
> > +
> > +description: |
> > +  Binding for the PCI/PCI-X/PCIe host bridges on MPC8xxx SoCs.
> > +  See also: Documentation/devicetree/bindings/pci/fsl,pci.txt
> 
> This is obviously a bit wrong; I ended up putting the information from
> fsl,pci.txt entirely under the fsl,pci-agent-force-enum property, but
> forgot to remove the reference to the old txt file.

Looks fine other than that.

Rob


