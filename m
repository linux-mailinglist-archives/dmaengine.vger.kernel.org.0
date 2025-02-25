Return-Path: <dmaengine+bounces-4576-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E93A43FBD
	for <lists+dmaengine@lfdr.de>; Tue, 25 Feb 2025 13:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFCEF7AA7E2
	for <lists+dmaengine@lfdr.de>; Tue, 25 Feb 2025 12:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA74268C4A;
	Tue, 25 Feb 2025 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="mjILcAIk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1542686AE
	for <dmaengine@vger.kernel.org>; Tue, 25 Feb 2025 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488078; cv=none; b=K/TL5HxsSYc1Oz7OcR1lAmVfGbBnxo+SM5FHG3j4qH4yM/BWAjb4ihool6GZFuAdTex3u3pEebEKj7+YMTXKLN3nPkNz9CUIDNqulqqLrVQ0W/56paeHhZqeoJX8g3cXBcdlaVzqtZMY3TSFUIEkzsNEbTxVCSEg8u+Y00V4EIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488078; c=relaxed/simple;
	bh=W8LIqF7kkH6cCLj3gN0Tz1ix7jTva4xQTCeEx72fA+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJXhEfSGqr90gT2WkVkbs10Y9jLZ+WTy+kuagL+bFcPUdQhODiyFc9hvLduRE/b9LgginIIgtGl9O8f/m5uyAiKUW3a1CIqZxWkMsz5zj6CtArDQFjCK91lE/yJ/si7JqTQsJAqBIeDAkOhbJcRGjgdjN4bfPcCQQ+Yjv2+W4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=mjILcAIk; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4AD04240104
	for <dmaengine@vger.kernel.org>; Tue, 25 Feb 2025 13:54:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1740488073; bh=W8LIqF7kkH6cCLj3gN0Tz1ix7jTva4xQTCeEx72fA+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=mjILcAIkXqzqNKdVJx8aNZciCsFDMgWk1hSEOtkfGbO6HFVdhu5Vy04vupoKrYvbv
	 c6on3zliqSDojlPicjEIhjGdw22NRnh01nANE/3jRMwtf45rqgaGqjBEPbDvvOZQgg
	 s4Jb6KbceFTD97AcdgGFKHeQkXDlrBbwG3iChrbmjhflZJIT8e5l8aV2shsyZ4sXKo
	 6ofVmK+sYqzNywRiys2+yrDszLO59sxgwWTEXz+wqj0Y8Kj8BPrm6dHb8ttxz+aByz
	 WtF5CLyU4itMYTueMHGswR3Km+h6T3R2kOXkZBOleO2kFLusG00NHpXaxrg6YwUFTp
	 3ou6TTWtB7XpA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Z2HcG3WCTz9rxG;
	Tue, 25 Feb 2025 13:54:21 +0100 (CET)
Date: Tue, 25 Feb 2025 12:54:21 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: Frank Li <Frank.li@nxp.com>, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
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
Subject: Re: [PATCH v2 05/12] dt-bindings: dma: Convert fsl,elo*-dma to YAML
Message-ID: <Z729fRBNLAxdYD22@probook>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-5-8137b0c42526@posteo.net>
 <Z6pV4eauZj75+911@lizhi-Precision-Tower-5810>
 <Z684nUnDX4Sb98rQ@probook>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z684nUnDX4Sb98rQ@probook>

On Fri, Feb 14, 2025 at 12:35:41PM +0000, J. Neuschäfer wrote:
> On Mon, Feb 10, 2025 at 02:39:13PM -0500, Frank Li wrote:
> > On Fri, Feb 07, 2025 at 10:30:22PM +0100, J. Neuschäfer via B4 Relay wrote:
> > > From: "J. Neuschäfer" <j.ne@posteo.net>
> > >
> > > The devicetree bindings for Freescale DMA engines have so far existed as
> > > a text file. This patch converts them to YAML, and specifies all the
> > > compatible strings currently in use in arch/powerpc/boot/dts.
> > >
> > > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > > ---
[...]
> > Need ref to dma-common.yaml?
> 
> Sounds good, but I'm not sure what to do about the #dma-cells property,
> which is required by dma-common.yaml.
> 
> There aren't many examples of DMA channels being explicitly declared in
> device trees. One example that I could find is the the xilinx_dma.txt
> binding:
> 
> 
> 	axi_vdma_0: axivdma@40030000 {
> 		compatible = "xlnx,axi-vdma-1.00.a";
> 		#dma_cells = <1>;
> 		reg = < 0x40030000 0x10000 >;
> 		dma-ranges = <0x00000000 0x00000000 0x40000000>;
> 		xlnx,num-fstores = <0x8>;
> 		xlnx,flush-fsync = <0x1>;
> 		xlnx,addrwidth = <0x20>;
> 		clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>, <&clk 4>;
> 		clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk", "m_axi_s2mm_aclk",
> 			      "m_axis_mm2s_aclk", "s_axis_s2mm_aclk";
> 		dma-channel@40030000 {
> 			compatible = "xlnx,axi-vdma-mm2s-channel";
> 			interrupts = < 0 54 4 >;
> 			xlnx,datawidth = <0x40>;
> 		};
> 		dma-channel@40030030 {
> 			compatible = "xlnx,axi-vdma-s2mm-channel";
> 			interrupts = < 0 53 4 >;
> 			xlnx,datawidth = <0x40>;
> 		};
> 	};
> 
> 	...
> 
> 	vdmatest_0: vdmatest@0 {
> 		compatible ="xlnx,axi-vdma-test-1.00.a";
> 		dmas = <&axi_vdma_0 0
> 			&axi_vdma_0 1>;
> 		dma-names = "vdma0", "vdma1";
> 	};
> 
> It has #dma_cells (I'm sure #dma-cells was intended) on the controller.
> 
> 
> Another example is in arch/powerpc/boot/dts/fsl/p1022si-post.dtsi:
> 
> 	dma@c300 {
> 		dma00: dma-channel@0 {
> 			compatible = "fsl,ssi-dma-channel";
> 		};
> 		dma01: dma-channel@80 {
> 			compatible = "fsl,ssi-dma-channel";
> 		};
> 	};
> 
> 	...
> 
> 	ssi@15000 {
> 		compatible = "fsl,mpc8610-ssi";
> 		cell-index = <0>;
> 		reg = <0x15000 0x100>;
> 		interrupts = <75 2 0 0>;
> 		fsl,playback-dma = <&dma00>;
> 		fsl,capture-dma = <&dma01>;
> 		fsl,fifo-depth = <15>;
> 	};
> 
> 
> There, the DMA channels are used directly and without additional
> information (i.e. #dma-cells = <0>, althought it isn't specified).

I had another look at dma-common.yaml and it explicitly requires
#dma-cells to have a value of at least 1, so this second idea won't
work.


Best regards,
J. Neuschäfer

