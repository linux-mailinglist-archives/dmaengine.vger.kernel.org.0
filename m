Return-Path: <dmaengine+bounces-11554-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dzoYJswTMWofbQUAu9opvQ
	(envelope-from <dmaengine+bounces-11554-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 11:13:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2561D68D6C1
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 11:13:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mlIOg8pb;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11554-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11554-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97BBA300CB3F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 09:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6452241B365;
	Tue, 16 Jun 2026 09:13:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A24739DBF2;
	Tue, 16 Jun 2026 09:13:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601226; cv=none; b=MkUrJyYkpYdD2xXy3W8HjGCi8j5UbgeZIxUjjUvu7nHzZWGYLLiyJUeUXQ44M6rU9e9szOmMq70roGiY4VrEj+LRsb4ewQA18HAVNxqKg2yJnqv31cEP0zsQo4g1pftsGHTzSod2pgu1LvCHD3EvpblpTNLvmYLh23pFvZMkCRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601226; c=relaxed/simple;
	bh=dr5QjL3Y5+7Y/dCPDwngV6wqM9mvwgQs8oxaLaUIUrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU+sVaLn6i0bDOCyYO8eJuNhgcz4XymWrK3vnVmW56EsLcxjm3O4cQgZDUnov8AHu9DoPZiJwpm3Zd/0ee/idko1n4Yn9ATPnUUllanYkiQ5wGIG9nydVVMhTZDkQ1S8bMRAZT2xymBxX/FpvNmAy+NbaJmF/pprGH2ikP4Q4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlIOg8pb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01011F000E9;
	Tue, 16 Jun 2026 09:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781601225;
	bh=T6O0q1IfXtevvhpoYxo0G7LAbHxOjdSWxBrNhX9eDVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mlIOg8pbv1qOCEvNNDhAPtuDD04+gXQ/Xhse2HRlLBTtPUftUc2rudUqDY4awhyoS
	 iPgd5rI0w1Xh0dKxqLIhJ5QzGXuuKfrMqIFryOMr1zi38dYd4VSlD/7IIdyxeJlcsJ
	 Cw5EI4ZopUH0vkI9eug1lykNfJwVTMA8ws0Vzf31ImBOtf7pQhK99Du5pgDgEdZ9TN
	 SIclzhh2ZWuT+nobYj3nW8occsmHvSxumKN7pl9mrAAd3WbEHffgPf6P/BxwSJj3kY
	 Kki9er0GHtysQfDL/pDEzjKWpzUUhcaKmA+6SKOIQw+ncVLTDjeRrxXUUvJkuZf8cZ
	 oCdGBWUMZCTqg==
Date: Tue, 16 Jun 2026 11:13:39 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] dmaengine: dw-edma: Support dynamic LL appends
Message-ID: <ajETw7uwVx_U9o5F@ryzen>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11554-lists,dmaengine=lfdr.de];
	FORGED_SENDER(0.00)[cassel@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev,amd.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ryzen:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2561D68D6C1

Hello Koichiro,

On Tue, Jun 16, 2026 at 12:40:54AM +0900, Koichiro Den wrote:
> Hi,
> 
> This series is a reworked version of Frank's earlier RFT series:
> 
>   https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com/
> 
> After discussing the HDMA test results with Frank, I am sending this as a
> standalone series that keeps the main dynamic-append direction, while adding the
> fixes and HDMA handling needed to make it work reliably on both eDMA and HDMA.
> 
> Several patches are kept from, or based on, Frank's RFT series; the individual
> patches carry the corresponding attribution.
> 
> The series has been tested on both eDMA and HDMA systems. Both completed the fio
> test set reliably; performance results are shown below.

Great work! The performance increase is significant :)

In Frank's earlier RFT series, the change
"dmaengine: dw-edma: Dynamically append requests while running"
broke the pci_endpoint_test selftest:
https://lore.kernel.org/dmaengine/aXNQcowVEMaE1xr5@ryzen/

I can see that you have included a modified version of this change in
this series. Does the pci_endpoint_test selftest pass with your series?


Kind regards,
Niklas

