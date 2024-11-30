Return-Path: <dmaengine+bounces-3831-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC79B9DEEE0
	for <lists+dmaengine@lfdr.de>; Sat, 30 Nov 2024 05:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61412163637
	for <lists+dmaengine@lfdr.de>; Sat, 30 Nov 2024 04:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB87E78C76;
	Sat, 30 Nov 2024 04:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAskCHrb"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074A1EB3D;
	Sat, 30 Nov 2024 04:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732939512; cv=none; b=eELGwFCuyQnzarKX1GAuFDEDjeZNN9MLoWryPwpLEp0t87R954RdfYN5Hk86CXSol44uxI3oZLdG5/JhLnB6CKKum0UFtoflBdIPTqzZ2lxNlmlcio3M10xix1yIP3/6IMvFS+QD2Q6WOrA7mDaA9ytr0UrYIb4VexQ0u9syVow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732939512; c=relaxed/simple;
	bh=J+yWMeElKC/wy0LdewAgmAXpJwqJQdoSPQCF/yS6RMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JssLgw/ERLeAfgFeQu0wbkBVO0aTcsqYirpTsI4C6FsuyekIlnJFrt3lyF65pn7WhYRv/4tLaWf7b6aIkAE5f3zYyuTLWNsUc0JfQvM4Xb06d4YEUDivaNxhp6sSVGBm5H9XE2GUar9OCS8heXTHjKQxBM7iBre0RCtvjnZSgzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAskCHrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10CDC4CECC;
	Sat, 30 Nov 2024 04:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732939512;
	bh=J+yWMeElKC/wy0LdewAgmAXpJwqJQdoSPQCF/yS6RMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gAskCHrb95155Uf1w6MZKbLwh0Gegiy8PcWe7bGNuq7Saj7PvX4KiNn0Gi4Fq3ASx
	 lmaIKj7kSEYPcO1oIexORufR9D8bsljEeVeF/f5EoybQnoKK96Ff3SX6C4V94f4jyC
	 x9hOXLTR31sfjPzV2SYY6WFgNxnBy1K3PL91s+1msQhL74ZY0RJYnoSdLohnyjSpCf
	 CRIEK4atexATnJoAPWP3ldksrGuijNNPT83Xb/bfC8UkWPwe+mgQGBxlwG3gB4u+Hd
	 G+BfqM888p22gXW9qHKlRtHQ78FIBACuz3goeEVukeBPNbFLYxbSnZio95p9glDpy7
	 BwbWHrad6Lnmw==
Date: Fri, 29 Nov 2024 22:05:07 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
Subject: Re: [PATCH v2 1/2] dmaengine: qcom: gpi: Add GPI immediate DMA
 support
Message-ID: <fbpdzrwmlmqhyblchgaq6etmnc5wjd3ierwmtrer5hnwjf7qb3@axgwdegmbs6z>
References: <20241128133351.24593-1-quic_jseerapu@quicinc.com>
 <20241128133351.24593-2-quic_jseerapu@quicinc.com>
 <obv72hhaqvremd7b4c4efpqv6vy7blz54upwc7jqx3pvrzg24t@zebke7igb3nl>
 <1666035c-d674-43dd-bc33-83231d64e5f7@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666035c-d674-43dd-bc33-83231d64e5f7@quicinc.com>

On Fri, Nov 29, 2024 at 05:02:22PM +0530, Jyothi Kumar Seerapu wrote:
> On 11/28/2024 8:53 PM, Bjorn Andersson wrote:
> > On Thu, Nov 28, 2024 at 07:03:50PM +0530, Jyothi Kumar Seerapu wrote:
> > > diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
[..]
> > 
> > >   	/* first create config tre if applicable */
> > >   	if (direction == DMA_MEM_TO_DEV && spi->set_config) {
> > > @@ -1763,14 +1767,32 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
> > >   	tre_idx++;
> > >   	address = sg_dma_address(sgl);
> > > -	tre->dword[0] = lower_32_bits(address);
> > > -	tre->dword[1] = upper_32_bits(address);
> > > +	len = sg_dma_len(sgl);
> > > -	tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
> > > +	/* Support Immediate dma for write transfers for data length up to 8 bytes */
> > 
> > And what happens if the developer writing the SPI driver forgets to read
> > this comment and sets QCOM_GPI_IMMEDIATE_DMA for a 9 byte transfer?
> In V2 patch, QCOM_GPI_IMMEDIATE_DMA is set based on
> QCOM_GPI_IMMEDIATE_DMA_LEN only.
> 

I assume you mean "patch 2/2". So, what happens if someone refactors the
SPI driver in the future, will they read this comment?

> As per Hardware programming guide, immediate dma support is for up to 8
> bytes only.
> Need to check what is the behavior if we want to handle 9 bytes using
> immediate dma feature support.
> 

I'm saying that you have a comment here which says that the caller must
not pass len > 8. Write that comment in code to avoid mistakes - either
now or in the future.

> > 
> > > +	if ((spi->flags & QCOM_GPI_IMMEDIATE_DMA) && direction == DMA_MEM_TO_DEV) {
> > 
> > Why is this flag introduced?
> > 
> > If I understand the next patch, all DMA_MEM_TO_DEV transfers of <=
> > QCOM_GPI_IMMEDIATE_DMA_LEN can use the immediate mode, so why not move
> > the condition here?
> > 
> > Also ordering[1].
> > 
> > 	if (direction == DMA_MEM_TO_DEV && len <= 2 * sizeof(tre->dword[0]))
> > 
> > 
> Sure, thanks for the suggestion.
> so, instead using "QCOM_GPI_IMMEDIATE_DMA_LEN" need to use " 2 *
> sizeof(tre->dword[0])" for 8 bytes length check.
> 

Either one works, but I'm guessing that while 8 is the right number the
reason for 8 is that the data is passed in 2 * dword.


The important thing is that you're encoding the length check here, so
that the client can't by mistake trigger immediate mode with > 8 bytes.
As a side effect, you no longer need the QCOM_GPI_IMMEDIATE_DMA flag and
should be able to drop patch 2.

> > [1] Compare "all transfers of length 8 or less, which are mem to device"
> > vs "all transfers which are mem to device, with a length of 8 or less".
> > The bigger "selection criteria" is the direction, then that's fine tuned
> > by the length query.
> > 
> > > +		buf = sg_virt(sgl);
> > 
> > It's a question of style, but I think you could just put the sg_virt()
> > directly in the memcpy() call and avoid the extra variable.
> 
> Okay, i will directly put sg_virt() in memcpy().

Try it out, pick the option that look the best.

Regards,
Bjorn

