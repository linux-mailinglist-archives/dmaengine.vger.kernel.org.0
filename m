Return-Path: <dmaengine+bounces-12518-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6XnPNN+tVmo7AAEAu9opvQ
	(envelope-from <dmaengine+bounces-12518-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:45:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E88A759093
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:45:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=deltatee.com header.s=20200525 header.b=ZNnkTYRG;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12518-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12518-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=deltatee.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0568730276B7
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 21:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9E141C2FE;
	Tue, 14 Jul 2026 21:44:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E367429CE8;
	Tue, 14 Jul 2026 21:44:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784065460; cv=none; b=U+0oOI65nENucIMe6GmRbMFLJzNo7lap1JsfTdmJDqDj75JXsztZoDFaDRrPtbxdNbqSkcyu5iYAWrJorpolDOK8v145oIKANwydms1XymHF483FS8rexZz7WLhmvSkq9n+gdpX25uCalYUDLpUXdlBGuY+6ZcsuIqruVANTKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784065460; c=relaxed/simple;
	bh=5MMvUzfPFSHRFS9iGY5trpg9sc8q7isOO7HuCXazzbc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=UFrA3TSJKrJJmieZ/+Wopf6bbOYBZzgv2JLGjp6kyCSXS3MPDV5o6YPIEW4CBGjAnUwWsu2ZkjvYGvzOHvaQT0+MyKt8PIhJf88HFf43HI2s67BPMGWk4S/vEBdd7fB7RAjhUU2SH/gxtWecF3gmssWCyj8Z5RwRDn2x9pwN5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=ZNnkTYRG; arc=none smtp.client-ip=204.191.154.188
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=JvSBZj1Vq5wUOwV0VVic1jYGrF9K1DEaesscS8WrHOs=; b=ZNnkTYRGed9/i/sXg025bNJf+s
	MV0+tcfokYyDYVzmOXwycEU0UtZ4gBngjEe/EBqL8KLTgzl5F+ib1Ghnz8X0WlIw+IsQ4/frU8PrR
	GGeHgurLuKrAHiiUiboU/efnTJZwa8CmLybiwXadtLYsmWJrVSf/rVkehF1PlEpcNL4F/ALatT+YH
	uZ2tmuByOwLbXl0TSwpjeK5W8clTf497Qzps3MGBG6dv5gPaaUKTS9yIpjfTevSNzdgcEOXT7v9Eq
	G4IuOTB5Qdhecgzj5k7aH3cc3b6jBWU/gqxiLZ4Bf/JsZOkkFW/nP9Z3RTdFylf6c/31oRCFg+gfT
	YH4agZrQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wjkvK-00000006fJT-0mvL;
	Tue, 14 Jul 2026 15:44:18 -0600
Message-ID: <f51bb6b4-700f-44f4-bac1-5815e47edfd6@deltatee.com>
Date: Tue, 14 Jul 2026 15:44:18 -0600
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org,
 dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20260714212010.230606-1-logang@deltatee.com>
 <20260714212010.230606-4-logang@deltatee.com>
 <20260714213824.A2F201F000E9@smtp.kernel.org>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260714213824.A2F201F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v1 3/3] PCI: Add PCI1008 to switchtec NTB DMA alias quirk
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[deltatee.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[deltatee.com:s=20200525];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12518-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[deltatee.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,deltatee.com:from_mime,deltatee.com:dkim,deltatee.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E88A759093



On 2026-07-14 15:38, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This isn't a bug introduced by this patch, but while looking at the function
> triggered by this quirk (quirk_switchtec_ntb_dma_alias()), I noticed an
> incorrect pointer arithmetic issue.
> 
> In drivers/pci/quirks.c:quirk_switchtec_ntb_dma_alias():
> 
> 	partition_map = ioread32(&mmio_ntb->ep_map);
> 	partition_map |= ((u64) ioread32(&mmio_ntb->ep_map + 4)) << 32;
> 
> Since mmio_ntb->ep_map is a u64, does the + 4 advance the pointer by 32
> bytes (4 * sizeof(u64)) instead of the intended 4 bytes?
> 
> Looking at struct ntb_info_regs, this would read from offset 36
> (target_part_low) instead of the upper 32 bits of ep_map at offset 8. This
> populates the upper 32 bits of partition_map with unintended data, causing
> the device initialization loop to process invalid partition IDs, which
> could potentially access out-of-bounds MMIO registers or create incorrect
> DMA aliases.
> 
> Could this read be corrected to avoid scaling by the type size?
> 

As noted by the Sashiko bot, this issue is unrelated to this series. But
I'll dig into it and try to remember if that was intended or a mistake
and send a patch if needed. In the mean time, this shouldn't gate this
series.

Logan

