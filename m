Return-Path: <dmaengine+bounces-10779-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 949NGgZtEmo7zQYAu9opvQ
	(envelope-from <dmaengine+bounces-10779-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 05:14:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2145C1335
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 05:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E89BC3011040
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 03:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C9D26ED45;
	Sun, 24 May 2026 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp0EIjWq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDAE2517A5;
	Sun, 24 May 2026 03:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779592449; cv=none; b=NUt9W3HlygwrkilFyVi8yh/rHw0d4icIqGmz8gTPbkOVrB2LG86xzIjf2T4d/QrXXty6pwWJv6IsZyjcR8AgMy/55AYX7n8eAXfI4Qiuo6Jhkz0YjbhuOfoYr5s+brJ2pFRQrUa4sLshZBTFdqcZfAmIHbuk+c2a+yV6rr1b8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779592449; c=relaxed/simple;
	bh=coTy/t8ogKnjHWCXsqRBJhplHI+RoqN3OXdbX5bt/+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwTL3QW5nCAcZV3pPv7/XDhAPf+VgCJLGak9C7gePTOq79DCpkEW4Dv/dU5m2gVGSXTJbz4AA0EkfdxySjHdHudjvhFiGd3rzGK38D5zXdbjUrLwFWTPIsv9Rn9R0i8A5JzoQ/LmTeE2FraK1EMC1jyPRbLWiefEECpLVLUPtKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gp0EIjWq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B697A1F000E9;
	Sun, 24 May 2026 03:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779592448;
	bh=iPaVYRaVqI3HRfM7FrPIQR8XxzMRy5ZmQXJQPPCTbo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gp0EIjWqC6mBjk1mX1hoO/215LqS+qvPA+VjHLtKWK5KPwc9OZh0Fjxt6cGD92aWa
	 hALuVbg3AUKFWuX/E3P2NUsJVh/y8V7/9UGcy0FvBOV4spHltcAezpghAZkbDHrlGl
	 DlmZLwTja0K73dpCe44F26PXmCyce6BpCOBv9O3C3qKBiXQz1aBLgSe0P15QeovMbn
	 iB507eQ2kNH2jc9dMl40CwNm/VAseEGlCaSc/URKXKnc+egfE+tqvKS7WQebBSEbi4
	 QLQcG7gXMCn+593P73QT2lifXWLRwa82IJ9/sg+Vq64fM2olpJ+fVRAYAtoZhmJW4n
	 /g2ZHz8cuG5Eg==
Date: Sun, 24 May 2026 08:44:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, vkoul@kernel.org, dmaengine@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v1] dmaengine: dw-edma: Remove dw_edma_add_irq_mask()
Message-ID: <3o7rek4lwnp7saci44acwxdxfhr2w2hd72feofcl3gipbofcjv@iazqkn57gqvl>
References: <20260521100640.3333076-1-devendra.verma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521100640.3333076-1-devendra.verma@amd.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10779-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CE2145C1335
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:36:40PM +0530, Devendra K Verma wrote:
> Function dw_edma_add_irq_mask() is not used anywhere. The
> output of the function is not used hence it is redundant and
> can be removed safely.

Where is your s-o-b tag?

- Mani

> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index c2feb3adc79f..89a4c498a17b 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -988,20 +988,12 @@ static inline void dw_edma_dec_irq_alloc(int *nr_irqs, u32 *alloc, u16 cnt)
>  	}
>  }
>  
> -static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
> -{
> -	while (*mask * alloc < cnt)
> -		(*mask)++;
> -}
> -
>  static int dw_edma_irq_request(struct dw_edma *dw,
>  			       u32 *wr_alloc, u32 *rd_alloc)
>  {
>  	struct dw_edma_chip *chip = dw->chip;
>  	struct device *dev = dw->chip->dev;
>  	struct msi_desc *msi_desc;
> -	u32 wr_mask = 1;
> -	u32 rd_mask = 1;
>  	int i, err = 0;
>  	u32 ch_cnt;
>  	int irq;
> @@ -1038,9 +1030,6 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  			dw_edma_dec_irq_alloc(&tmp, rd_alloc, dw->rd_ch_cnt);
>  		}
>  
> -		dw_edma_add_irq_mask(&wr_mask, *wr_alloc, dw->wr_ch_cnt);
> -		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
> -
>  		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
>  			irq = chip->ops->irq_vector(dev, i);
>  			err = request_irq(irq,
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

