Return-Path: <dmaengine+bounces-4633-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD830A4C23E
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 14:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40BA3A55B3
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 13:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A801820DD62;
	Mon,  3 Mar 2025 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7aarzRr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEED78F44;
	Mon,  3 Mar 2025 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009323; cv=none; b=FSjldq+DWA+7vRLtia+RiqhZ5FuaYoZ6gxKjFepX/o2VB9lBKWW2DoXF8zsbfLTsnaAEw7yOAWoRnMDlPwd0oYxoxR37UML+/clbkB0Lmf7zbAjP3AKPmHhknfEXtS1dL8tMTdw8t/v/ifp+gMVlz/BGgZ6JOLgZo5t0AM3EMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009323; c=relaxed/simple;
	bh=vrDxbcIJQqkSw75KhA73NGqZilboXIjAwfnFMaIawGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KggWQiduhoGP8cj+y7ps4kPQ10ibTj3i/TRwEoQZ8Lwoqd0Ha83E/noEgBnqmergXq6aVOi+kZ6etN5wFnxCB14E+NbBrfZAOI75YyyP6Pe3+KlomNT3Ach5JF0fukH2B4FBviMisxkrFgq/NYUIFwA0eUC+VyE6xaCflx8r40w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7aarzRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0938C4CED6;
	Mon,  3 Mar 2025 13:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741009322;
	bh=vrDxbcIJQqkSw75KhA73NGqZilboXIjAwfnFMaIawGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7aarzRrmLRsznWXpkijE8LUo25+hran6IjEWQuaXLrYb1b+NIPc1PFI8034OPHIe
	 OUOmb1DUuiaYiaDQ7Lo4x1pm3b6YTqdDxrl7lOOgOVWkmCTfCmF2rYgQm/ufqMAvYZ
	 /tdYJhy3fcNeC/ipdmAopssOdyqlYRj1OFY64lr8SazI6kYSqpIbdBQ1B8kiNuqhMc
	 IGgRiIHXYzK3uNjCwRwqdO3yYfV1VOfSoFMfGk+iU8ZTkqgdgRdcz2dN8O/KGtsnkX
	 +L3KCuL6YuHgke59P7VXrbYFqqHQVen5yT7a3Bzkx2rh1ayMvsy9fDETax5XZv3Zff
	 jS/b5faWidrjA==
Date: Mon, 3 Mar 2025 07:42:00 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	dmaengine@vger.kernel.org, Crystal Wood <oss@buserror.net>,
	linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Naveen N Rao <naveen@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: dma: Convert fsl,elo*-dma to YAML
Message-ID: <20250303134200.GA1710704-robh@kernel.org>
References: <20250226-ppcyaml-dma-v3-1-79ce3133569f@posteo.net>
 <174059099427.2999773.4836262903761680275.robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174059099427.2999773.4836262903761680275.robh@kernel.org>

On Wed, Feb 26, 2025 at 11:29:54AM -0600, Rob Herring (Arm) wrote:
> 
> On Wed, 26 Feb 2025 16:57:17 +0100, J. Neuschäfer wrote:
> > The devicetree bindings for Freescale DMA engines have so far existed as
> > a text file. This patch converts them to YAML, and specifies all the
> > compatible strings currently in use in arch/powerpc/boot/dts.
> > 
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
> > I considered referencing dma-controller.yaml, but that requires
> > the #dma-cells property (via dma-common.yaml), and I'm now sure which
> > value it should have, if any. Therefore I did not reference
> > dma-controller.yaml.
> > 
> > V3:
> > - split out as a single patch
> > - restructure "description" definitions to use "items:" as much as possible
> > - remove useless description of interrupts in fsl,elo3-dma
> > - rename DMA controller nodes to dma-controller@...
> > - use IRQ_TYPE_* constants in examples
> > - define unit address format for DMA channel nodes
> > - drop interrupts-parent properties from examples
> > 
> > V2:
> > - part of series [PATCH v2 00/12] YAML conversion of several Freescale/PowerPC DT bindings
> >   Link: https://lore.kernel.org/lkml/20250207-ppcyaml-v2-5-8137b0c42526@posteo.net/
> > - remove unnecessary multiline markers
> > - fix additionalProperties to always be false
> > - add description/maxItems to interrupts
> > - add missing #address-cells/#size-cells properties
> > - convert "Note on DMA channel compatible properties" to YAML by listing
> >   fsl,ssi-dma-channel as a valid compatible value
> > - fix property ordering in examples: compatible and reg come first
> > - add missing newlines in examples
> > - trim subject line (remove "bindings")
> > ---
> >  .../devicetree/bindings/dma/fsl,elo-dma.yaml       | 137 ++++++++++++++
> >  .../devicetree/bindings/dma/fsl,elo3-dma.yaml      | 125 +++++++++++++
> >  .../devicetree/bindings/dma/fsl,eloplus-dma.yaml   | 132 +++++++++++++
> >  .../devicetree/bindings/powerpc/fsl/dma.txt        | 204 ---------------------
> >  4 files changed, 394 insertions(+), 204 deletions(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/fsl,elo-dma.example.dtb: dma-controller@82a8: '#dma-cells' is a required property
> 	from schema $id: http://devicetree.org/schemas/dma/dma-controller.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/fsl,eloplus-dma.example.dtb: dma-controller@21300: '#dma-cells' is a required property
> 	from schema $id: http://devicetree.org/schemas/dma/dma-controller.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/fsl,elo3-dma.example.dtb: dma-controller@100300: '#dma-cells' is a required property
> 	from schema $id: http://devicetree.org/schemas/dma/dma-controller.yaml#

Just stick with 'dma' for node name as that's what .dts files are using 
and 'dma-controller' is reserved for users of DMA provider binding.

Rob

