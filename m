Return-Path: <dmaengine+bounces-9119-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP9OJJp8n2mrcQQAu9opvQ
	(envelope-from <dmaengine+bounces-9119-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 23:50:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A23ED19E737
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 23:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F02783009F15
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B9133C539;
	Wed, 25 Feb 2026 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLQgSWqw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0542A2FB0A3;
	Wed, 25 Feb 2026 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772059797; cv=none; b=inQ2vR2s9wFsAc2NbU8MEgq7R+gXRA7FqoIavpKyeb51pSHN1vEvPgffMmShEwhq/tPNcqOqOHeUX0vfZ1w8ABMknFIuhTGUaDykq/DezCAsHGofMHt4Uue3tyVCLbc2TExHWDFuMMvkjxpOtUtNDYwoVQ31YHNooDncYvqPkpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772059797; c=relaxed/simple;
	bh=mgxqDo5rlL2fSjIeQ+XKlvcKVTdg4JhBlzt9laj0qHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8Z0l65NT8KEPzD4yiuYtvF2DHwjx9lgMxiVpDwKxQqelkCejjwOSiQPAOgKVQLRIt8XbajxF9W0OEMtYPTxoUZQe5XBSkrp6OBftkeWvSVrDIQo0u3gHkFNphm/x5KX43DMi/zChOiMiTQf1cvSlVT58FawgdXNrx2Xs1fhk5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLQgSWqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F67C116D0;
	Wed, 25 Feb 2026 22:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772059796;
	bh=mgxqDo5rlL2fSjIeQ+XKlvcKVTdg4JhBlzt9laj0qHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLQgSWqwB5/tv0+42PqFvJIC6uAPHKjAVuUraKTMifpKvdyvIvgx2av6xiXb+jH5w
	 vfxvNUjNhJQFj7zDnuSMySWY8oxqftC2658+awD+Z+ssthXdxbiRx2An5UKGIFeWSW
	 m+38CS/WIcesBthKltLTgLd6s6YyLAEHVGDq4KfM7hukPxRtfCPnQNWC84zww7ujzV
	 GkMRN2aBhoBsLVtQ+AL+0EQxWMyo9+QZJEmm9A++JG1qYr+RfGPm9tKIQRmFWkajWl
	 82fndr47I2wtRIv+6rSlpJIR0iMlE8DmQUIsXlOHENAShAHcrP2x+JZZmYK471ujpS
	 y9e3wzlMle7Ig==
Date: Wed, 25 Feb 2026 23:49:49 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
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
	Koichiro Den <den@valinux.co.jp>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/9] dmaengine: Add new API to combine configuration
 and descriptor preparation
Message-ID: <aZ98jbxb2Wh-yRe1@ryzen>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
 <aXD/EYqhhRJEN8oy@lizhi-Precision-Tower-5810>
 <aX0EXjM4LlO3Hygd@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aX0EXjM4LlO3Hygd@lizhi-Precision-Tower-5810>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9119-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A23ED19E737
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 02:19:58PM -0500, Frank Li wrote:
> 
> Vinod Koul:
> 
> 	Do you have chance to pick up (at least first 2 patches) for 6.20?
> So I can start do more cleanup work.

Why only the first two patches?

Mani has already given his ack and said that he thinks it should go via
the dmaengine tree:
https://lore.kernel.org/dmaengine/6f4elcu5iql65jeqfeqhmllquv253xh4gb37ivef2kyvsj5lps@w35ciehuwxym/

The series still applies to dmaengine/next btw :)


Kind regards,
Niklas

