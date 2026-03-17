Return-Path: <dmaengine+bounces-9464-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHcOG3AvuWkYuAEAu9opvQ
	(envelope-from <dmaengine+bounces-9464-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:39:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5662A8172
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DC62302D186
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 10:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A253A6B7E;
	Tue, 17 Mar 2026 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOUr0clK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98243A63F8;
	Tue, 17 Mar 2026 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743865; cv=none; b=DyjMhiTD1qbNZiR/wln+Qku1VqAruXwLvxFBSWbD5G0InGiQWE5RfnDp+GVgSpczpUUZRKf+sZY4Qo/38VNyHqZQGGPBdP4VpTWkoyoRNaDO3a+KYVorChYRbe1wHVN/7Ql7YCKPK3sB+Nj1qtIjOiPbDwMSkzFAeS8zfysSi1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743865; c=relaxed/simple;
	bh=bVEWdLxO6ioCtZnPQrdXen+JMCFn/KT/7+euMbV69tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0Qcjha6B+lmO1sD3axjOkAJYG+KIfEO5DiIqfq3TupFFdswYcpXCMqbHu8hwAOnYnmYir6Kzg4TT1x0ji1XlOZqwp8D1jyNTePQH9MRQArBMXST9LDY2fx4bL3XLMj9bzeK/jfh/6TxJHkb9ajslaM/UZaTb/2tlroN8a+eUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOUr0clK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BA2C2BC9E;
	Tue, 17 Mar 2026 10:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773743865;
	bh=bVEWdLxO6ioCtZnPQrdXen+JMCFn/KT/7+euMbV69tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOUr0clKofRpKlPQbpoGfbgW9oToJQusdYtrjFwC+xX+oDNSZytwUiA4CRIDQXhMT
	 xdfBatwQU3l+u8MhtrvnIpgsESwkSLOQjt3qB/Xc59eOYZt41K7Yt5IQ6r+3wsvTNk
	 RYvRm7XfIZmvxULvrr+bHWanoNOdZIoHkimQjH7QoO1I5DRxl+ZJOSbOWf2CfvfYxw
	 o4Mt2aeShixX/CrnBsDtw+1tkhO2TN36FEwVR+VGjLGHhhYcVsFwy4vZ2PfCApJoEK
	 k1zTCdZbe2/7yoHhavk0gUqPVYdHLfuZGEAMSXZvoUuG9ZVbrIy4t6izS5WAXy2E+p
	 LE2sQDdblsyOg==
Date: Tue, 17 Mar 2026 16:07:41 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/8] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Message-ID: <abku9bXxkZWUwOhE@vaman>
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
 <20251218-dma_prep_config-v2-1-c07079836128@nxp.com>
 <aa6pW-zpxnrZnfPn@vaman>
 <aa7cbL-B5sbjZr_l@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa7cbL-B5sbjZr_l@lizhi-Precision-Tower-5810>
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
	TAGGED_FROM(0.00)[bounces-9464-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E5662A8172
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 09-03-26, 10:42, Frank Li wrote:
> On Mon, Mar 09, 2026 at 12:04:59PM +0100, Vinod Koul wrote:
> > On 18-12-25, 10:56, Frank Li wrote:
> > > Previously, configuration and preparation required two separate calls. This
> > > works well when configuration is done only once during initialization.
> > >
> > > However, in cases where the burst length or source/destination address must
> > > be adjusted for each transfer, calling two functions is verbose and
> > > requires additional locking to ensure both steps complete atomically.
> > >
> > > Add a new API dmaengine_prep_config_single() and dmaengine_prep_config_sg()
> > > and callback device_prep_config_sg() that combines configuration and
> > > preparation into a single operation. If the configuration argument is
> > > passed as NULL, fall back to the existing implementation.
> > >
> > > Add a new API dmaengine_prep_config_single_safe() and
> > > dmaengine_prep_config_sg_safe() for re-entrancy, which require driver
> > > implement callback device_prep_config_sg().
> >
> > Okay to add API
> >
> > > +	struct dma_async_tx_descriptor *(*device_prep_config_sg)(
> > > +		struct dma_chan *chan, struct scatterlist *sgl,
> > > +		unsigned int sg_len, enum dma_transfer_direction direction,
> > > +		unsigned long flags, struct dma_slave_config *config,
> > > +		void *context);
> >
> > Do we want to have drivers implement one more callback. It does not make
> > sense to me. Why not handle this in framework and have it call the
> > respective lower level APIs.
> 
> To avoid use addtional lock! suppose each API is re-entriable.
> 
> thread 1:  call dmaengine_prep_config_sg_safe()
> thread 2:  call dmaengine_prep_config_sg_safe()
> 
> If DMA engine driver implement device_prep_config_sg, thread 1 and thread 2
> can run parallel.
> 
> If driver have not implement this callback, it have to use mutex make sure
> config and prep atomic.
> 
> https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com/
> show finial opitimziation result, which depend on this. If can't call
> prep() function parallel, which will kill performace.

Which seems to be 10% in your case.

> > Drivers should implement simple apis and collectively the functionality
> > can come from the framework.
> >
> > Would you consider revising as such. Bonus all existing drivers can
> > start using this API, no change required for drivers in that case'
> 
> Not that simple, some devices just call config at probe, especial fix
> FIFO address and burst length.
> 
> Call config and prep only need for the case, which need adjust src/dst
> address, burst length or other parameter for each transfer.

Correct. In the cases where config is done once they can invoke with
NULL config. I would like the middle layer to handle complexities and
drivers should be simpler

> 
> Frank
> 
> >
> >
> > --
> > ~Vinod

-- 
~Vinod

