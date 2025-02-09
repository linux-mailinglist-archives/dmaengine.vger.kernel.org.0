Return-Path: <dmaengine+bounces-4357-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA389A2D9E8
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2025 01:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667613A71D0
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2025 00:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540CA211C;
	Sun,  9 Feb 2025 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="sCbG1BSJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957FF653
	for <dmaengine@vger.kernel.org>; Sun,  9 Feb 2025 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739059632; cv=none; b=EKVKzYK/FtX0Y2vA20V7eaXQhdcIkVe3qZmqsSSb4rNfaxSIETLw+SmfK5HiKD3uGbdpTib2c6RhWNZjdwf2mz+dzLOHZFSqlhpfsmeQQZU14szIgm+UTDc/4KaK7x2rRvv0VYW6Wu4JXZOqwoRrUX1HZUAhhziwZbq932z4nR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739059632; c=relaxed/simple;
	bh=Rnod+Cv9JGN27bc74JTeUwsZwKe+/eQ5wUgORPxiuzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivZzwR1M7K9vCa5rZJwCMcVwS61jmvZ/5FfBZhwpKOEnEhhYZ3evb28wmtcdRkCe9LIrDMSxYBdwej2bETGv0XVwwgd5Vuru6FxCVsegs6Cfbzg8sZpiQCwjBlt6xJCM3oGlccz/NqajAuSnrZI9c3f3PIygzJh5iomm+I5uBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=sCbG1BSJ; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D1E19240106
	for <dmaengine@vger.kernel.org>; Sun,  9 Feb 2025 01:07:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739059627; bh=Rnod+Cv9JGN27bc74JTeUwsZwKe+/eQ5wUgORPxiuzc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=sCbG1BSJdZWt1edyZAzOTS89N0duEs07ccSnsXnT+UfdGlLRohceTvrjdWe79zbfs
	 eXTauh4a7bfbU54NMlv0wt2ckdtHyqNMA5jU/nTYL9wlljl70+913YyJ7GSz9iXVCa
	 dM2dye/dE/TNwH+03LPRGl6X6bim/7wCj1YDYh7TO/gZqxQiJsQZvqb3waq5GcW3VB
	 LWNwgMARWtEpgVqV+hn0uSbBeAryngWszChEdcIJGYVZaTlnyQgub6Ei6jGqkmW3dZ
	 mmvAZpiZsA+skofsC8RZ4YedleBUtbHJK50JQGGkCiVAw8xfGrX/A2AkaDIyXDPYcd
	 gX32aB4WdFYkQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Yr7LD23pfz6v0D;
	Sun,  9 Feb 2025 01:06:59 +0100 (CET)
Date: Sun,  9 Feb 2025 00:06:59 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: j.ne@posteo.net
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk@kernel.org>, imx@lists.linux.dev,
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
Subject: Re: [PATCH v2 06/12] dt-bindings: pci: Convert fsl,mpc83xx-pcie to
 YAML
Message-ID: <Z6fxo4j5a6ro0f1w@probook>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-6-8137b0c42526@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207-ppcyaml-v2-6-8137b0c42526@posteo.net>

On Fri, Feb 07, 2025 at 10:30:23PM +0100, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> Formalise the binding for the PCI controllers in the Freescale MPC8xxx
> chip family. Information about PCI-X-specific properties was taken from
> fsl,pci.txt. The examples were taken from mpc8315erdb.dts and
> xpedite5200_xmon.dts.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> V2:
> - merge fsl,pci.txt into fsl,mpc8xxx-pci.yaml
> - regroup compatible strings, list single-item values in one enum
> - trim subject line (remove "binding")
> - fix property order to comply with dts coding style
> ---
>  .../devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml   | 115 +++++++++++++++++++++
>  Documentation/devicetree/bindings/pci/fsl,pci.txt  |  27 -----
>  2 files changed, 115 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml b/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..57c5503cec47e6e90ed2b09835bfad10309db927
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/pci/fsl,mpc8xxx-pci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale MPC83xx PCI/PCI-X/PCIe controllers
> +
> +description: |
> +  Binding for the PCI/PCI-X/PCIe host bridges on MPC8xxx SoCs.
> +  See also: Documentation/devicetree/bindings/pci/fsl,pci.txt

This is obviously a bit wrong; I ended up putting the information from
fsl,pci.txt entirely under the fsl,pci-agent-force-enum property, but
forgot to remove the reference to the old txt file.

> +properties:
[...]
> +  fsl,pci-agent-force-enum:
> +    type: boolean
> +    description:
> +      Typically any Freescale PCI-X bridge hardware strapped into Agent mode is
> +      prevented from enumerating the bus. The PrPMC form-factor requires all
> +      mezzanines to be PCI-X Agents, but one per system may still enumerate the
> +      bus.
> +
> +      This property allows a PCI-X bridge to be used for bus enumeration
> +      despite being strapped into Agent mode.
> +
> +required:
> +  - reg
> +  - compatible

