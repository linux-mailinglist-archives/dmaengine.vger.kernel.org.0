Return-Path: <dmaengine+bounces-12460-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0oTcEcnjVWo8uwAAu9opvQ
	(envelope-from <dmaengine+bounces-12460-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 09:22:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB06751CD3
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 09:22:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MhNiYTWa;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12460-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12460-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23D6A3012552
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 07:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074633ED3A6;
	Tue, 14 Jul 2026 07:22:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95EE3EC2EF
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 07:22:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013764; cv=none; b=R1PuDqYf6qtmzfntTbHWAhJ6lY/3qXx44SkAbqsg8M3h5XHDj/H+UoQnk8H11x2ERjdqEcUkOhyG1Cyr5fnr8aG4L8mO8jT7uRgyb/21q5DX18CYA2RmkgK0xcJBfmy32/TqveMmaAqAzF1RiCNO1Epj1QZV5fN9AODnsAmavf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013764; c=relaxed/simple;
	bh=WRZ2ewAYjgyjuXxwXRW/Cahpxl1wR+bHT8Hf4joJOzQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t5EGgfRgB2ITeHU5VL/B/FWFAa1jaMuv9ICzGcRRfyaTWl1o/WXskoYudZF5S+YIEj9NIJgiL13HWYXsJ5EMzQsAbOcf7XjhlLeh58LSQXrykCMW052tnYGgTNyBxnQBc25euNJ7DRTnH7c/qYj5ncYr3nrCYmwQ6ZDqelmLRFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhNiYTWa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE7F1F00A3A;
	Tue, 14 Jul 2026 07:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784013763;
	bh=ALq/s4r94U8nnEOUp3vwrqlIUpMIPsbSf2kPLIw2aIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MhNiYTWaQMZJKtsH1KxztI+hIoplyl9e1TVfMYSOBeMeoYWr+l3/vlfdqiWGFKWJV
	 yrcZe1mbTLGNAzsFW9U17y+d8OVj6cT17qn6pHFNkorUMe6nB2w997jcOiFgBIU9DC
	 5zHyGsTJ1hIEpsLUPijyVMhFaXdOzzIZyjIchPYdLIgF8mFsK5Rq6CTtJEQiNBTuWr
	 Nl7PacaVkbADG+jWXSt2QFF9HZa6jk5IJBn2AuctR5yr3blvB6ksES5imNSnB5UG6J
	 wCoK4RwJzK2ofVBThDkkAXbzWdFNsRFOH1Jh7oPIRxQeoJUCP4OPfqzxFcqIk/CcWm
	 OHj53u5giBSlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] net: xilinx: axienet: Derive RX frame length
 from residue in dmaengine path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srinivas Neeli" <srinivas.neeli@amd.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260713072146.45269-4-srinivas.neeli@amd.com>
References: <20260713072146.45269-1-srinivas.neeli@amd.com>
 <20260713072146.45269-4-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 07:22:43 +0000
Message-Id: <20260714072243.7CE7F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12460-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:srinivas.neeli@amd.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEB06751CD3

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The dmaengine teardown path leaks all in-flight SKBs and DMA mappi=
ngs when the interface is stopped.
--

--- Patch [3]: [PATCH v4 3/4] net: xilinx: axienet: Derive RX frame length =
from residue in dmaengine path ---
commit 99e70bd1e2ac117d993d11234fd0dea54d95440b
Author: Srinivas Neeli <srinivas.neeli@amd.com>
Subject: net: xilinx: axienet: Derive RX frame length from residue in dmaen=
gine path

This commit updates the dmaengine RX path to derive the received frame
length from the dmaengine residue rather than descriptor APP metadata.
This removes the dependency on the optional AXI4-Stream status/control
interface.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/=
net/ethernet/xilinx/xilinx_axienet_main.c
> index fcf517069d161..67d1b8e91d683 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -53,7 +53,6 @@
[ ... ]

While reviewing this code, I noticed a pre-existing issue in axienet_stop():

drivers/net/ethernet/xilinx/xilinx_axienet_main.c:axienet_stop() {
    ...
    for (i =3D 0; i < TX_BD_NUM_MAX; i++)
        kfree(lp->tx_skb_ring[i]);
    kfree(lp->tx_skb_ring);

    for (i =3D 0; i < RX_BUF_NUM_DEFAULT; i++)
        kfree(lp->rx_skb_ring[i]);
    kfree(lp->rx_skb_ring);
    ...
}

[Severity: High]
This is a pre-existing issue, but does this dmaengine teardown path leak
all in-flight SKBs and DMA mappings when the interface is stopped?

When using dmaengine, the DMA channels are terminated which aborts
transfers without calling completion callbacks. The code then iterates
through the descriptor arrays and frees each skbuf_dma_descriptor
container.

It appears to fail to unmap the dma_address and free the actual skb stored
within the descriptor.

Could toggling the interface down and up repeatedly leak the entire RX ring
and any pending TX SKBs along with their DMA mappings, potentially
exhausting system memory and IOMMU space over time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713072146.4526=
9-1-srinivas.neeli@amd.com?part=3D3

