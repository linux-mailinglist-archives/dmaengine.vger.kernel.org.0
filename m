Return-Path: <dmaengine+bounces-10364-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLQLG4g8A2pK2AEAu9opvQ
	(envelope-from <dmaengine+bounces-10364-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:43:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1774D522CBF
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3793E3399E7C
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 14:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F9C3A9862;
	Tue, 12 May 2026 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpdNMZTi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB839D3ED;
	Tue, 12 May 2026 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594643; cv=none; b=IqyUGSAoLZHwDe6Dz8A82JgGkDw0R5alxWV+GkSK6ixLWzEQoq77t5/LXn3fzjK7mByWtkeJtABikKaHygwuUSBKOBYIkj8o5Vk4PiaxW5ZYBUz+0QnZcuy5AU5o5uvGpma89w2DZNkZCOnVT5bkDwWRwU6W0Go3Wf1oumsfagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594643; c=relaxed/simple;
	bh=wZIDx7vXSGoTrkQ9Gai4XwKtCh48yAuiTnAYTQ2Zz9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFf70qZy/2cnk/JkELnUpTZEDxJODC8AtQY9qGwf4PRz+syDcpO3M48l9zEFBoaLCQPjjIwBBugPHpv9TOSQe3sQYHXxw4p1mwRjz7kbZc5lWkUb0hSBKrXR3SR0aatFcePzii7Z9MfRDB/TXUxDA0mixNHX/3a1cuT7rbhNEcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpdNMZTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B730C2BCB0;
	Tue, 12 May 2026 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594642;
	bh=wZIDx7vXSGoTrkQ9Gai4XwKtCh48yAuiTnAYTQ2Zz9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bpdNMZTibadEBjbeQDSM9SwNXYlJWq/aP1DZ7nbJtV85oGI0nyDSxZXUeFJnOniHe
	 9Xf+bnpk+WrN8NtAZ0sqh3ejX948zKaly44LK/qNu595lycRemW82MSF/zk5jX88LD
	 o+DMvIKSsZk/T4oCsqkLzL40/sNQYWTzB7ekDR4uJVWUuNEwvtIfhpzJjAuDqLV43b
	 IlSgWBt+n7hBM0KVKiEK182XCyeTlWcEHqZIVS7DGf4a9Mzsexiu48/6Cq/X53V7BY
	 xQgKTtGSlYkDFEfAl09ifBuVUygFr6kS1rrEWATVAs/Va9XrWRdBYRHYoqeOUTknN8
	 AgCun9dDR48yg==
Date: Tue, 12 May 2026 19:33:51 +0530
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
Subject: Re: [PATCH v4 4/9] dmaengine: dw-edma: Use new
 .device_prep_config_sg() callback
Message-ID: <bjroe5qbpggiolfqqexm5vy2edmhxp5qyrejxdklwlg5y53gfc@n3bz7i2jqja6>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
 <20260506-dma_prep_config-v4-4-85b3d22babff@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506-dma_prep_config-v4-4-85b3d22babff@nxp.com>
X-Rspamd-Queue-Id: 1774D522CBF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10364-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 04:44:16PM -0400, Frank Li wrote:
> Use the new .device_prep_config_sg() callback to combine configuration and
> descriptor preparation.
> 
> No functional changes.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> change in v4
> - drop context in callback.
> change in v3
> - add Damien Le Moal review tag
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index c2feb3adc79fa94b016913443305b9fae9deef12..f7f58b0010e26b529ffb7382d5b166a703587c71 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -577,10 +577,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  }
>  
>  static struct dma_async_tx_descriptor *
> -dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
> -			     unsigned int len,
> -			     enum dma_transfer_direction direction,
> -			     unsigned long flags, void *context)
> +dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist *sgl,
> +			      unsigned int len,
> +			      enum dma_transfer_direction direction,
> +			      unsigned long flags,
> +			      struct dma_slave_config *config)
>  {
>  	struct dw_edma_transfer xfer;
>  
> @@ -591,6 +592,9 @@ dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
>  	xfer.flags = flags;
>  	xfer.type = EDMA_XFER_SCATTER_GATHER;
>  
> +	if (config)
> +		dw_edma_device_config(dchan, config);
> +
>  	return dw_edma_device_transfer(&xfer);
>  }
>  
> @@ -970,7 +974,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  	dma->device_terminate_all = dw_edma_device_terminate_all;
>  	dma->device_issue_pending = dw_edma_device_issue_pending;
>  	dma->device_tx_status = dw_edma_device_tx_status;
> -	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
> +	dma->device_prep_config_sg = dw_edma_device_prep_config_sg;
>  	dma->device_prep_dma_cyclic = dw_edma_device_prep_dma_cyclic;
>  	dma->device_prep_interleaved_dma = dw_edma_device_prep_interleaved_dma;
>  
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

