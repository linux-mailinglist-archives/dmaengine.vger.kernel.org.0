Return-Path: <dmaengine+bounces-12262-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G6ThD/X7T2oVrgIAu9opvQ
	(envelope-from <dmaengine+bounces-12262-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 21:52:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 229C873533D
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 21:52:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S2EkifLA;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12262-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12262-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E77AE300A643
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 19:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A94F3C0A02;
	Thu,  9 Jul 2026 19:52:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317583C5823;
	Thu,  9 Jul 2026 19:52:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626726; cv=none; b=ODeXpDlKUALqwu4UxlsbhGKxq7P3YDJxTomGDLKeGXwNIZt3rRnzF6CtWJ7WsBCGgabl872UMo4h35sC6mmSEHHp6ChzxIPBGYAFmWdfoAo8I0TEiQ+ObLDY+YU7NrlMmd1btuPC/95rxTiRnoH4fx+aXJtoX0JfiVTevK5Kv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626726; c=relaxed/simple;
	bh=CRPaV1YmbzKWbZJtG24RiPNCZS/Y2w8pTojZ5EHiWV0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=etysHW5GFz07stI34phdi58vXFkNDudJf/v+Csc1lPxvWRvtymWqEWtwL5HVZTU+TdBmOLQetPtMWmXJKbVo/XjfApnGI4N3Os4pegbukacVrEDFr5EQJag9diiZga3MZ3rKN5pEloVsamrvrC44JvNtHIDmJg3MWdL9p31IyV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2EkifLA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847051F00A3A;
	Thu,  9 Jul 2026 19:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783626724;
	bh=lcOeZjQ1Y6NqCwb7DExMzSG3PRvuO4awJLokV768DDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=S2EkifLAg5Vb/F4xGBkmYhaBJDuKem8xeb/s+2BBHrtqfj48ztECd0b0dtDbQqK1j
	 D+w5+l2qQVV5aUepaSkDOQsG29C7qnGPdK79ZEb0YVbD1YEW+UNXKIltN5YBMT4EPV
	 FcPSNTgXRpJ/eAj3R9RcOE4lwhl2tfTphskwzM2O2HC04/mr1QseGM7v4LlZ4GGq2a
	 5zwlZAeP42X8xSmgqNjtfhwHxfE9J9pjrvbWi07T1Hly6CpBQtZbfplLpIjCEKHqVh
	 P1nGdAO6CsjxXvbR9aYLMB1+77MRyvT3L+iIg+Mq1P0nclzyyeBjIF2EWu959z3kfb
	 l8rUmv/qTxJLw==
Date: Thu, 9 Jul 2026 14:52:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank.Li@oss.nxp.com
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
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v7 3/9] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
Message-ID: <20260709195203.GA874193@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-dma_prep_config-v7-3-1f73f4899883@nxp.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:vkoul@kernel.org,m:mani@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:den@valinux.co.jp,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:mhi@lists.linux.dev,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:imx@lists.linux.dev,m:Frank.Li@nxp.com,m:dlemoal@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER(0.00)[helgaas@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-12262-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bhelgaas:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 229C873533D

On Thu, May 21, 2026 at 11:32:49AM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Use dmaenigne_prep_config_single() to simplify code.

s/dmaenigne/dmaengine/ both in subject and commit log.

