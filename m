Return-Path: <dmaengine+bounces-4673-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE518A5958A
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 14:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D0637A2522
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 13:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1666C22156E;
	Mon, 10 Mar 2025 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRlts/Zh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE2321E0AE;
	Mon, 10 Mar 2025 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611768; cv=none; b=SbYC5XGycDVULgcyYTNBDkyI0X5ATvHmm5n4iSEoY7GDLHpES9Ia1p4/6OM7Fqir/47KAJUp/2mTSp4BB99jcqBVx/xiArJahs68LSuQdYxoBp1rZsw+IVlNItiKyybflG/ttqi+ODp6oRRirGGEXAA4+OAn6Jj5mJXgZqEZpo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611768; c=relaxed/simple;
	bh=qyHh1D1vX+68dKTG+EegRL4UgZ0evFBOJqQTycLFst0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsDEhDMMvbzjVz7GHbj4utIRtYcHKJKjQTfmIYpUXk4g1XWHDKUq2DMm6pcpCWm8OKVKN1z7hXo12mVoj/VRhK3Ba9RFMxIvzvqOKMZM5+/4WBQm8Uc0iheB/Rv2+tiwElabRRO2iKppjZd7IMW2dVnuKxtN1uunKl1h2Fi5NcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRlts/Zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E466AC4CEE5;
	Mon, 10 Mar 2025 13:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741611767;
	bh=qyHh1D1vX+68dKTG+EegRL4UgZ0evFBOJqQTycLFst0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tRlts/ZhNbYmFlrv133aUmOYU1WOKML75MIEjpre2hEcv3myqd87DyFLQEmRo1fSQ
	 Wt77rGT8CpCxMYXdxnlvGTDS7gVM/oq+0Yabg9KyRwCimrQgMYcva+lH7NZ8Ll9pXT
	 DjBQod9Nx2NN6R9+cyg0tr40cw8i1YvJ/mmVNrRyeTu5NnjxP5g70GRT1QK4r+m/eF
	 Xg1XMXbNVXmVRdwS2el6Qp8uB8QkqKQHLL2d4ouqkJ9uNiSPx5IvzOLHUcAatGa5Sv
	 //U55Hsf/t4AGYvngoH/4h0Px+Rys2VgQFM0d0Bt00bFVLeMhJJrU+h4lJckhhwp48
	 zmChkwQWd2oCg==
Date: Mon, 10 Mar 2025 08:02:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Crystal Wood <oss@buserror.net>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4] dt-bindings: dma: Convert fsl,elo*-dma to YAML
Message-ID: <174161174500.3899711.4362879691608337681.robh@kernel.org>
References: <20250308-ppcyaml-dma-v4-1-20392ea81ec6@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250308-ppcyaml-dma-v4-1-20392ea81ec6@posteo.net>


On Sat, 08 Mar 2025 19:33:39 +0100, J. Neuschäfer wrote:
> The devicetree bindings for Freescale DMA engines have so far existed as
> a text file. This patch converts them to YAML, and specifies all the
> compatible strings currently in use in arch/powerpc/boot/dts.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> I considered referencing dma-controller.yaml, but that requires
> the #dma-cells property (via dma-common.yaml), and I'm now sure which
> value it should have, if any. Therefore I did not reference
> dma-controller.yaml.
> 
> V4:
> - switch DMA controller node name (in examples) back to dma@ because the
>   dma-controller.yaml binding is not used.
> 
> V3:
> - Link: https://lore.kernel.org/r/20250226-ppcyaml-dma-v3-1-79ce3133569f@posteo.net
> - split out as a single patch
> - restructure "description" definitions to use "items:" as much as possible
> - remove useless description of interrupts in fsl,elo3-dma
> - rename DMA controller nodes to dma-controller@...
> - use IRQ_TYPE_* constants in examples
> - define unit address format for DMA channel nodes
> - drop interrupts-parent properties from examples
> 
> V2:
> - part of series [PATCH v2 00/12] YAML conversion of several Freescale/PowerPC DT bindings
>   Link: https://lore.kernel.org/lkml/20250207-ppcyaml-v2-5-8137b0c42526@posteo.net/
> - remove unnecessary multiline markers
> - fix additionalProperties to always be false
> - add description/maxItems to interrupts
> - add missing #address-cells/#size-cells properties
> - convert "Note on DMA channel compatible properties" to YAML by listing
>   fsl,ssi-dma-channel as a valid compatible value
> - fix property ordering in examples: compatible and reg come first
> - add missing newlines in examples
> - trim subject line (remove "bindings")
> ---
>  .../devicetree/bindings/dma/fsl,elo-dma.yaml       | 137 ++++++++++++++
>  .../devicetree/bindings/dma/fsl,elo3-dma.yaml      | 125 +++++++++++++
>  .../devicetree/bindings/dma/fsl,eloplus-dma.yaml   | 132 +++++++++++++
>  .../devicetree/bindings/powerpc/fsl/dma.txt        | 204 ---------------------
>  4 files changed, 394 insertions(+), 204 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


