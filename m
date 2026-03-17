Return-Path: <dmaengine+bounces-9463-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP+yBn8tuWmVtQEAu9opvQ
	(envelope-from <dmaengine+bounces-9463-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:31:27 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7582A7EEF
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 789B1306B600
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBCD3A5E8E;
	Tue, 17 Mar 2026 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EK+pGd/Q"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC15A3A5424;
	Tue, 17 Mar 2026 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743203; cv=none; b=MpbVerwFtURHKLz5h4TbDVUG+li/gfyCGBm3Txai3jPlfC4nBuMZckKdazf9GqoUCSnLFaw0m8lUWIob9D3//sTc4gIZQn3azMsSw8KJEu1TyzQFG8rD1muTW42DaZnzws+TxoNPAqI5214++689MBFF6fAnaBdVkpLYSFF4GKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743203; c=relaxed/simple;
	bh=leILco6ESwbAPx5/ChEkDeGOl9TARpFn5FFt7fhV91M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JS/RbMrO0ucygMZzynQZdNEwZbu38/NZjYSZoL4ApW2LaDGKu5/fQeaJt1dpvUryWBKbtSMheAllPabTmAjpHhVeDW0Y4WCajxVcbPr6c7ZYIL6QCZFpnjUwx7pWZmhMqpuV31xrhKLT2UP1CL7ksliEsqmt8wAaTuMrGDn6Edg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EK+pGd/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150C7C4CEF7;
	Tue, 17 Mar 2026 10:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773743203;
	bh=leILco6ESwbAPx5/ChEkDeGOl9TARpFn5FFt7fhV91M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EK+pGd/Qe+hHDmgY8MA52uxvkIPEOhyj8ZVsNmndCnSG5dr/RFkQ9EnPdTtgdc61H
	 Cv1BQnZ3IDVErs0ElcARTaHFjSgtOIlIttxmykiFG8ScBTqIlcuYsDPneEBfXC7EYC
	 Xkspxjnc6XfG8/+Gl8Htahhn2o+gOhHRob/jNy+0w4tkPw5+r5eNhsc1WethmBcvky
	 xWXG2L5QQNS+FE1dYze7XpRzUc/frOLIjc4Nb3FErpzmNekXVc2Q/wMIWWsO/HxGE/
	 VcqQcQuMnZ8Of7QoctvtautlGcfI4NcN1sQiB7KTCaig1mVy2DW5gr/cfnhvZYZf5/
	 CxzWscbT1RSHQ==
Date: Tue, 17 Mar 2026 15:56:40 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] dmaengine: Add common dma_slave_config and split it
 into src and dst parts
Message-ID: <abksYB2WQ0oNDSbS@vaman>
References: <20260114-dma_common_config-v1-0-64feb836ff04@nxp.com>
 <aa6t8QrrlearBOXI@vaman>
 <aa7Y20I2_Hlp63gk@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa7Y20I2_Hlp63gk@lizhi-Precision-Tower-5810>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-9463-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA7582A7EEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 09-03-26, 10:27, Frank Li wrote:
> On Mon, Mar 09, 2026 at 12:24:33PM +0100, Vinod Koul wrote:
> > On 14-01-26, 12:12, Frank Li wrote:
> > > Many DMA engine drivers store a dma_slave_config per channel. Propagate
> > > this configuration into struct dma_chan to avoid duplicating the same
> > > code in each driver.
> > >
> > > Much of dma_slave_config is identical for source and destination. Split
> > > the configuration into src and dst groups and use a union to preserve
> > > backward compatibility. This reduces the need for drivers to repeatedly
> > > check the DMA transfer direction.
> >
> > The reason why we had both the src/dstn sides was intended method to
> > allow upport ofr device to device dma. Some interest was shown for that
> > at that time.
> > I dont think we have such a user even now...
> 
> My means is the field name is identical, not value identical although most
> case is the identical. but it is possible, especial FIFO space windows,
> 
> sound/soc/fsl/fsl_asrc_dma.c use DEV_TO_DEV, at least src and addr use
> differece address.

Yeah so this would break if we go ahead. Thanks for looking this up

-- 
~Vinod

