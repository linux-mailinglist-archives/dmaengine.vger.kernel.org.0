Return-Path: <dmaengine+bounces-9319-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLfaEwqMrGnCqgEAu9opvQ
	(envelope-from <dmaengine+bounces-9319-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 07 Mar 2026 21:35:22 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFB822D840
	for <lists+dmaengine@lfdr.de>; Sat, 07 Mar 2026 21:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD2D301495F
	for <lists+dmaengine@lfdr.de>; Sat,  7 Mar 2026 20:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7BA2BF3D7;
	Sat,  7 Mar 2026 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv3jG6JB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2517523EA8C;
	Sat,  7 Mar 2026 20:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772915719; cv=none; b=KzKqcNonvvYy/jAgvyZEf07yFg+4j4Pw6IrghVTncRI8uK8QVCPcFH08r7RoABGvFzMMhFzHLNVgL/HEKlV4J2v7M+CJyB3k9X5AIdceadbhqOY/zaGOWCwZ/WiUaXE8LT4HuQiCwWOTKPim1y9VV3AeWA6me+n3fVacSTWZa84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772915719; c=relaxed/simple;
	bh=un14T0IT/vIqcYm6aN8xOLPJnlapIRXG/s+nnWU1kqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwYnNBvwJYXUhK40J0G/hQFD/BjYouuGVsSCqewxFbOX73OKom+r11+DkWHSVq1G/KDTb8lZCv9GPdyeZqDfpKKLNxmjguu2vvxZHmiSFJ44J6ffFnA3weq6b3SYMnBktMwzdcvp89wiJ9ev9KgsFAiAhglBGvap9N72saL5rO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv3jG6JB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E94DC19422;
	Sat,  7 Mar 2026 20:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772915718;
	bh=un14T0IT/vIqcYm6aN8xOLPJnlapIRXG/s+nnWU1kqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fv3jG6JBv75N4xFs3hP3/xuPfMcJfEmgzLxtHA1/0aBvtRCg1GamFg0WRHTl1VfTT
	 W9ACjsPMPLYWQrfKKpz+6uz24D/uggUV0a+0G9qGqtv5eDXbjcm3bCyczwfsOzbdOP
	 1moudz6U3cYKoVxc2nm9W051L9fmJApiixzy3/iWnQ8NojskWhU54NzItkTLcUhX/9
	 OkyRJbjkwRxR0M13mJx9jwEAitNTIM8Tly6TE3Esj1WzMX1soHZcnPHqDwOgw6D5rK
	 pcK3r+cS+o9G3okXQVTUV2ZGxUR50Harvo1UPy8o1XYlAKzJ3RJPlBe4UH5U05MRO6
	 bjn/SKVoRzJFQ==
Date: Sun, 8 Mar 2026 02:05:14 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Udit Tiwari <quic_utiwari@quicinc.com>,
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
	Md Sadre Alam <mdalam@qti.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH RFC v11 07/12] crypto: qce - Communicate the base
 physical address to the dmaengine
Message-ID: <aayMAlkJNxp9h4KO@vaman>
References: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
 <20260302-qcom-qce-cmd-descr-v11-7-4bf1f5db4802@oss.qualcomm.com>
 <aahEMjjBRINXL5zC@vaman>
 <CAMRc=Md2G7k7DGMZv2Du75ososQtsAutw2WwwAQ3WL8pC_-LmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md2G7k7DGMZv2Du75ososQtsAutw2WwwAQ3WL8pC_-LmQ@mail.gmail.com>
X-Rspamd-Queue-Id: AAFB822D840
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9319-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,kernel.org,amd.com,vger.kernel.org,lists.infradead.org,linaro.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Action: no action

On 04-03-26, 16:05, Bartosz Golaszewski wrote:
> On Wed, Mar 4, 2026 at 3:39 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 02-03-26, 16:57, Bartosz Golaszewski wrote:
> > > In order to let the BAM DMA engine know which address is used for
> > > register I/O, call dmaengine_slave_config() after requesting the RX
> > > channel and use the config structure to pass that information to the
> > > dmaengine core. This is done ahead of extending the BAM driver with
> > > support for pipe locking, which requires performing dummy writes when
> > > passing the lock/unlock flags alongside the command descriptors.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > > ---
> > >
> > >       dma->txchan = devm_dma_request_chan(dev, "tx");
> > >       if (IS_ERR(dma->txchan))
> > > @@ -121,6 +123,12 @@ int devm_qce_dma_request(struct qce_device *qce)
> > >               return dev_err_probe(dev, PTR_ERR(dma->rxchan),
> > >                                    "Failed to get RX DMA channel\n");
> > >
> > > +     cfg.dst_addr = qce->base_phys;
> > > +     cfg.direction = DMA_MEM_TO_DEV;
> >
> > So is this the address of crypto engine address where dma data is
> > supposed to be pushed to..?
> 
> No. In case I wasn't clear enough in the cover letter: this is the
> address of the *crypto engine* register which we use as a scratchpad
> for the dummy write when issuing the lock/unlock command. Mani
> suggested under the cover letter to use the descriptor metadata for
> that.

This is overloading of address field. If we go this was I would add a
comment in code explaining this and why in the setup the engine does not
need peripheral address. Meta data sounds okay as well.

-- 
~Vinod

