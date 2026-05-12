Return-Path: <dmaengine+bounces-10366-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGRhMMA1A2of1wEAu9opvQ
	(envelope-from <dmaengine+bounces-10366-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:14:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB1D52218B
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F02A630E9887
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 14:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523593A8391;
	Tue, 12 May 2026 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsTWv+Ya"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C863A8384;
	Tue, 12 May 2026 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594753; cv=none; b=g8cj1DbKidXHRW56G/d18mKLnQaQr8sdHaxuoc+KEkExg93h5VJtsViURBQF5Dhbpo8c7FVxWagOMZ24c7lNBL3VKdfGM+NvdxwYouiEC3AWmJdRnWMmb9PLIinlDCF9xmi+ucad2Omo4xoSZq12e4HkapqbD5g6cUY1IEhZrhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594753; c=relaxed/simple;
	bh=YycF+BsXmkOHi140SD9bIOo3d5bDA4TH49ncUJknjxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEUOQPhii0m9EDlUTpvsO+/Py/rSqAFUIXygiWpi+G9tj3CujU07po+0aiSJTSWOGDRNPRszJIzOowxX+q/ANMeGNuHP485byneQd78Mqb4SS/mzokmHmPn+c8GFMgn4SsZoqvRvfsBXaOMbmiXO5ZWeuB9fi60eNPrMwiaUeDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsTWv+Ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E89DC2BCF7;
	Tue, 12 May 2026 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594752;
	bh=YycF+BsXmkOHi140SD9bIOo3d5bDA4TH49ncUJknjxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hsTWv+Yabh5UIWyhp+vUaLL6nGSFKGZg2bIVVyicNmzP9NDYyN1C+KI3j1Z25Vn31
	 evnVRLXKipTZ5nVsO84Sfz4y6dBTQH9JYo993w9QlvT04WNOadYwToKyg2Qy1+M5hM
	 eHUKeL2xW1PiiuU/s1gFNwpJYlrBN7fpYb+AvX3dGIcbntFITb3Hdb0E6K7AZh88Lc
	 YtlYOW2bGR7CCs9p0vm3s11Vs7gYkX7O57njh7Wbc+gijRiK4H1H8l4U0Fptcngew6
	 7Caeze5M5bfF1KPW/RAcigtB+UEahAZ8Lcdvvx9oU53wAE3XwBeOI8D9vhJ6ogUFde
	 6FiFgfmxDKVSg==
Date: Tue, 12 May 2026 19:35:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v4 6/9] nvmet: pci-epf: Remove unnecessary
 dmaengine_terminate_sync() on each DMA transfer
Message-ID: <u4elm5jenwxp7r6zrn2ksxo2jqzkyttp2gyxufpvjhxevbtn7l@p7yr6wdbthgb>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
 <20260506-dma_prep_config-v4-6-85b3d22babff@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506-dma_prep_config-v4-6-85b3d22babff@nxp.com>
X-Rspamd-Queue-Id: 7CB1D52218B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10366-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 04:44:18PM -0400, Frank Li wrote:
> dmaengine_terminate_sync() cancels all pending requests. Calling it for
> every DMA transfer is unnecessary and counterproductive. This function is
> generally intended for cleanup paths such as module removal, device close,
> or unbind operations.
> 
> Remove the redundant calls for success path and keep it only at error path.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> This one also fix stress test failure after remove mutex and use new API
> dmaengine_prep_slave_sg_config().
> ---
>  drivers/nvme/target/pci-epf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 4e9db96ebfecd796244e5dc67c23e1abb1a14974..2afe8f4d0e46104a1b3c98db3905cf33e8c9e011 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -420,10 +420,9 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
>  	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
>  		dev_err(dev, "DMA transfer failed\n");
>  		ret = -EIO;
> +		dmaengine_terminate_sync(chan);
>  	}
>  
> -	dmaengine_terminate_sync(chan);
> -
>  unmap:
>  	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
>  
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

