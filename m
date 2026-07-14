Return-Path: <dmaengine+bounces-12493-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ar63JkkoVmon0QAAu9opvQ
	(envelope-from <dmaengine+bounces-12493-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:15:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E290A7545E8
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:15:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mSJLzUZ1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12493-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12493-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEB023012BE3
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A963E39E9DE;
	Tue, 14 Jul 2026 12:11:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8D339F16B;
	Tue, 14 Jul 2026 12:11:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031082; cv=none; b=PZ+b2KPmy4JTFZIYMM4vblhCcL96SdHtCncyHd3M+/gWFObti2z/PNQCDJA2HTlz+fm/d9+rJU6Jffz/keAEBH38hBn/47qEhMEgeK3HkEQrAbSk2I04nplfVlghHInAW/YRbGLHaLiCyPYaDYJa2e1sTalVhVTI3v+d5FNqhbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031082; c=relaxed/simple;
	bh=bb3djj0fZ+30tt25Nowh80ILINn4nn8130Kw2SRrtW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDF7Jq6cFzczTGIgzgazLepLkKRsT1vEA2Pj7LE+JzJZvDgWervFrxVwQT4FCWxbSX8FSPgZCFDTeeFcDESPj86lSQfEhX96AzufQReNG5zkMYOSbfjW6vaK9iF/ckBsYAXpKmuVOjvJOj+vpoeaGWEHpYwJ5db42oE1g1odZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSJLzUZ1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401061F000E9;
	Tue, 14 Jul 2026 12:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784031077;
	bh=eiFPBn1tbYiWnXsgsAeerc+9XoO81Qyg9ewXiIEgCIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mSJLzUZ1u4So/jNeJG3gQdyMRyt76jnISJCj95cssU5cPktGnVw0pZzi0wUI1BV8h
	 ZH1RYmG6WUXAld29tnNWXxcdZI1ND3WLQr3l3iA0OkCL1qTj8WsLgIDWkes6dg+wju
	 uAJu9/IMZPwkyuSXvXUfuidGWD7Y0nKFNuH5PGEbnAUzp72tNR7hSN4hJObGu7H0XK
	 yHdJXNL9PoReWtbdiXpN++LWC6GSlYCO3L23cFqTTy3Sy85XKZSpWcBd0SyJAdx3o6
	 Ub6SXF6/hO5yJ5rtgQZjJkXAOLO7fPJ0JeVw+CFhwTpcluT1yG76US3bCqvBL5IQZD
	 Y1syx3MaHkDoQ==
Date: Tue, 14 Jul 2026 17:41:13 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank.Li@oss.nxp.com, Manivannan Sadhasivam <mani@kernel.org>,
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
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v7 3/9] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
Message-ID: <alYnYY0DHl3qi5T6@vaman>
References: <20260521-dma_prep_config-v7-3-1f73f4899883@nxp.com>
 <20260709195203.GA874193@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709195203.GA874193@bhelgaas>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:helgaas@kernel.org,m:Frank.Li@oss.nxp.com,m:mani@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:den@valinux.co.jp,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:mhi@lists.linux.dev,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:imx@lists.linux.dev,m:Frank.Li@nxp.com,m:dlemoal@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-12493-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vaman:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E290A7545E8

On 09-07-26, 14:52, Bjorn Helgaas wrote:
> On Thu, May 21, 2026 at 11:32:49AM -0400, Frank.Li@oss.nxp.com wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> > 
> > Use dmaenigne_prep_config_single() to simplify code.
> 
> s/dmaenigne/dmaengine/ both in subject and commit log.

Yeah I had fixed while applying

-- 
~Vinod

