Return-Path: <dmaengine+bounces-9060-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLsfEPvPnmnwXQQAu9opvQ
	(envelope-from <dmaengine+bounces-9060-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:33:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D659D195CCE
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CE763079B90
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 10:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABB6168BD;
	Wed, 25 Feb 2026 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAsB6zgE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA1392C27;
	Wed, 25 Feb 2026 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772015409; cv=none; b=TzTUW2Ga7K0E9+66P/1I6EMEvz18RDvu7AOC4t4koDms/4cAzZft6mgCKa7yA3pH7Uazc1UUIlX+phI53M/TDAgrKvcOV6O2UuxoP71/tO2nlq9q1vgv3t6/Aefjc8EXcVV10brSdPnIX16K5yiajv147Cuw3zbqgDlKCZVkdUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772015409; c=relaxed/simple;
	bh=yvsBqcgbBxN3PsC9TQJxXhhlhJlGMx/bZ4A6gDi5mYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEJi9gtSHZUC5qg8/Z/ov5ta8H0E2LJrNLjPnm0ilPeztmpppcryVTT5VS6Mqx6cOHy7E6HvgW4SisTwBXK6OMvI2tzkW8Afr+UkhmDiB7i3RHZdHKzXO13hvT3a/yxKiyduwDuiMkA04rnHbRZ70FO0j579EZkC4yxXJLE2oQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAsB6zgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203BAC116D0;
	Wed, 25 Feb 2026 10:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772015408;
	bh=yvsBqcgbBxN3PsC9TQJxXhhlhJlGMx/bZ4A6gDi5mYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MAsB6zgEa3O9fbPh7dwCcqqTclghdnqipBOuMPspWVWuoNxQDb3//fq8tRK8ArZmq
	 0CUZxHj4fr33OgI2iG3/4ZHFr+1uh2vNlhTzaHqgmWSmkTD/PT8/Wxvuz+LvVAamH0
	 xtDUT64UKE2u0xQBZdLJfyD8w8NRDotV8r9xKJYP5r78sa7UB3zDNVI2Pw1/MBOMxg
	 Pl/tV2Rx/AfRRppX5INg0Vzju3JCCAoMPeoGWCTU1jOWcFGSg+r3kZbdsQg2LULAGA
	 OlB5Bdf43aCqAOo9uix2itads2FzNKm0dCOAKaLH+wpf3BoxrUMwlZ2Ia7NaiVkhA3
	 ra/C1ac+C0j2A==
Date: Wed, 25 Feb 2026 16:00:04 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>, Ze Huang <huangze@whut.edu.cn>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B
 compatible
Message-ID: <aZ7PLPFVnWjaBDpa@vaman>
References: <20260120013706.436742-1-inochiama@gmail.com>
 <20260120013706.436742-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120013706.436742-2-inochiama@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9060-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[synopsys.com,kernel.org,outlook.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,whut.edu.cn,vger.kernel.org,lists.linux.dev,lists.infradead.org,gentoo.org];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D659D195CCE
X-Rspamd-Action: no action

On 20-01-26, 09:37, Inochi Amaoto wrote:
> The DMA controller on CV1800B needs to use the DMA phandle args
> as the channel number instead of hardware handshake number, so
> add a new compatible for the DMA controller on CV1800B.

Applied this manually, please check if that is okay after push

> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index a393a33c8908..0b5c8314e25e 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -20,6 +20,7 @@ properties:
>      enum:
>        - snps,axi-dma-1.01a
>        - intel,kmb-axi-dma
> +      - sophgo,cv1800b-axi-dma
>        - starfive,jh7110-axi-dma
>        - starfive,jh8100-axi-dma
>  
> -- 
> 2.52.0

-- 
~Vinod

