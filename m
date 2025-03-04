Return-Path: <dmaengine+bounces-4640-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842DDA4DF5F
	for <lists+dmaengine@lfdr.de>; Tue,  4 Mar 2025 14:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEBE31887605
	for <lists+dmaengine@lfdr.de>; Tue,  4 Mar 2025 13:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7132045A6;
	Tue,  4 Mar 2025 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="d0s+Fhdb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877B82036F6
	for <dmaengine@vger.kernel.org>; Tue,  4 Mar 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095295; cv=none; b=heK1TIFiTerdxdIR7qjR3Wub7I+tA806r3gytUEZTjIG7dnJjHZiBesH3kn3CW8zgahzyN1l91TTTKOQx2HevQnAZy0+yxm9qFdev63yK8DEH5Swt26bqiHQguBW2rYH8xcUIL6izMNoLofabVEuo3zZn/63fC6+bqRbtMBi9hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095295; c=relaxed/simple;
	bh=GPsFfWzJ45kkPKaIC8bUVtCSlM7aVHTBZr1/4Ads9no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKhzKqqpPfAd9gHWsqeGPYpdlJW0jCS/QXI+fkKDf3zhRaJpO8Bpu5slvOB2lyAqC1WiceTD54EcJUpLCstCmIcagG2SMRLfaNQJP4g7TjC8bHlpQjPVvjdRiMQEa/AP9KDaurr0TCTsEAZMCwCFaXLfSnbVoMsGEdkkKwzD3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=d0s+Fhdb; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C70DD240103
	for <dmaengine@vger.kernel.org>; Tue,  4 Mar 2025 14:28:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1741094934; bh=GPsFfWzJ45kkPKaIC8bUVtCSlM7aVHTBZr1/4Ads9no=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=d0s+FhdbcuLFwkfFcRwE0nqixpJG3lUz+6op8v5ee+kPQxW4c8DAimFo+uWWN14Xr
	 6h5PVkvfRVxBNEIVhA+s+hJKMA/5wnlT+WFT2Up2p1IolpujhW9j1jLTkXSooiTpYe
	 C97Aa+YPXYlNBWDX+brECSJR1tPv3+XREPbQEHWLyBkMGMgzRIgiLzlqaZQaHhdrM2
	 hdj2o7yUiXQq2dW3uONLrMbZopjqpAXb3etXMJYl0KFQk9xjZ8qA3wD2R2agnB+//b
	 Ab29dpSekP4Z585SMPTIcPR10qytyg0LgSyTjncWnnYKbcqVEwBNtoBWHqd6ejWE1I
	 WN6cw/6Pyp6rA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Z6c2r19WLz9rxF;
	Tue,  4 Mar 2025 14:28:52 +0100 (CET)
Date: Tue,  4 Mar 2025 13:28:51 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Rob Herring <robh@kernel.org>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Conor Dooley <conor+dt@kernel.org>,
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
Message-ID: <Z8cAE0L3qnPHWLCR@probook>
References: <20250226-ppcyaml-dma-v3-1-79ce3133569f@posteo.net>
 <174059099427.2999773.4836262903761680275.robh@kernel.org>
 <20250303134200.GA1710704-robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303134200.GA1710704-robh@kernel.org>

On Mon, Mar 03, 2025 at 07:42:00AM -0600, Rob Herring wrote:
> On Wed, Feb 26, 2025 at 11:29:54AM -0600, Rob Herring (Arm) wrote:
> > 
> > On Wed, 26 Feb 2025 16:57:17 +0100, J. Neuschäfer wrote:
> > > The devicetree bindings for Freescale DMA engines have so far existed as
> > > a text file. This patch converts them to YAML, and specifies all the
> > > compatible strings currently in use in arch/powerpc/boot/dts.
> > > 
> > > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > > ---
[...]
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/fsl,elo-dma.example.dtb: dma-controller@82a8: '#dma-cells' is a required property
> > 	from schema $id: http://devicetree.org/schemas/dma/dma-controller.yaml#
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/fsl,eloplus-dma.example.dtb: dma-controller@21300: '#dma-cells' is a required property
> > 	from schema $id: http://devicetree.org/schemas/dma/dma-controller.yaml#
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/fsl,elo3-dma.example.dtb: dma-controller@100300: '#dma-cells' is a required property
> > 	from schema $id: http://devicetree.org/schemas/dma/dma-controller.yaml#
> 
> Just stick with 'dma' for node name as that's what .dts files are using 
> and 'dma-controller' is reserved for users of DMA provider binding.
> 
> Rob

Ok, makes sense.

Thanks,
J. Neuschäfer

