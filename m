Return-Path: <dmaengine+bounces-10367-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBzoGdk1A2of1wEAu9opvQ
	(envelope-from <dmaengine+bounces-10367-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:14:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 502C25221B9
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 223ED3061EB4
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F8A3A4274;
	Tue, 12 May 2026 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDZKGB4K"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC1B39E9C3;
	Tue, 12 May 2026 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594802; cv=none; b=BMJHkGrWfj2JkwkadD/5qJpymwA72Wa/+psikkLdjd/skSKQzsZgKwvaS6i7uoDxg4gN8T1bHX8aP0ES/xtzfM9toza6ilGlD8B+ypk36UOyfwNuHfh5inE4znkZ2Ay984cZw0TRZBpSOQ2hWpikuJ000LhSrtamV0kNoFjUw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594802; c=relaxed/simple;
	bh=sCdTEzy+9QK/GAC04dwJjssIvAEaneP0B0TsanrVNU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coYhsrOVuCdgRHQFZ5VPFSLnpWZR4O6YZ6tMqtVdj0ErdJzSrIVn8qgl05Nz+Oew5mSjSxSj2Nwj47R2x60FnT6G8MycOTiaK+V6Myq1kM3372zfVM1w1SN7CUx1rKIxgK7smLOdltbzzUVX3kPgUjGIxyLwGk4EtA6jVP8bIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDZKGB4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D46C2BCB0;
	Tue, 12 May 2026 14:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594802;
	bh=sCdTEzy+9QK/GAC04dwJjssIvAEaneP0B0TsanrVNU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDZKGB4K/KBTh0Hm7t50LbJjRocFOeAjXT7hnG3mtf0eR5wpLkBPGFChYay35v5jR
	 ydExe4pHsdItNrltZjn0Zl/A1JOLcD7mSI+mP/isxUIBIurNBAVrRShc6A+D6yxg+3
	 Vtbr4nhW6DufgKxyIA66OT8C+PXB2nXdhPXaPP/y6lvYMkSJajNohSDH5Hmyv9+Cfc
	 1Ce/VN1TCfraCWHNezX4SKDa4bORpvEXKO2RQa2WMBfGWHhu2J4ZnnYF4E6ANe1TpT
	 Q8KxiX7IK7Y9CzE/AnWNzG7Z9bRu1p3tQPtnHltGqqdxEFaFn+FX8MvN7ivhfgkdQE
	 HoCvd9wnsUc3w==
Date: Tue, 12 May 2026 19:36:31 +0530
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
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v4 7/9] nvmet: pci-epf: Use
 dmaengine_prep_config_single_safe() API
Message-ID: <xebioeyo4eecaj3sum6scttqqmubpcqutzdcrpjquvtmoaiskm@d2y744phmffd>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
 <20260506-dma_prep_config-v4-7-85b3d22babff@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506-dma_prep_config-v4-7-85b3d22babff@nxp.com>
X-Rspamd-Queue-Id: 502C25221B9
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
	TAGGED_FROM(0.00)[bounces-10367-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 04:44:19PM -0400, Frank Li wrote:
> Use the new dmaengine_prep_config_single_safe() API to combine the
> configuration and descriptor preparation into a single call.
> 
> Since dmaengine_prep_config_single_safe() performs the configuration and
> preparation atomically and the mutex can be removed.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/nvme/target/pci-epf.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 2afe8f4d0e46104a1b3c98db3905cf33e8c9e011..04d8f48d6950349ca97d2dbeae4e38e4714ad0d4 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -388,22 +388,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
>  		return -EINVAL;
>  	}
>  
> -	mutex_lock(lock);
> -
>  	dma_dev = dmaengine_get_dma_device(chan);
>  	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
>  	ret = dma_mapping_error(dma_dev, dma_addr);
>  	if (ret)
> -		goto unlock;
> -
> -	ret = dmaengine_slave_config(chan, &sconf);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto unmap;
> -	}
> +		return ret;
>  
> -	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
> -					   sconf.direction, DMA_CTRL_ACK);
> +	desc = dmaengine_prep_config_single_safe(chan, dma_addr, seg->length,
> +						 sconf.direction,
> +						 DMA_CTRL_ACK, &sconf);
>  	if (!desc) {
>  		dev_err(dev, "Failed to prepare DMA\n");
>  		ret = -EIO;
> @@ -426,9 +419,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
>  unmap:
>  	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
>  
> -unlock:
> -	mutex_unlock(lock);
> -
>  	return ret;
>  }
>  
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

