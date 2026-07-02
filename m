Return-Path: <dmaengine+bounces-12005-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rh+FMYDZRmpcegsAu9opvQ
	(envelope-from <dmaengine+bounces-12005-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:34:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B046FCFC3
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:34:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BpmzKru2;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12005-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12005-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B92E303D2D5
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 21:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF3339EF16;
	Thu,  2 Jul 2026 21:31:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372452E54B6;
	Thu,  2 Jul 2026 21:31:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027916; cv=none; b=R6TAeiq/MOlvhBv0MZJDSu2i74v1f9i/Xh1cNg8QxbXXfIFAbPTc50mwg2GtHPrOZcfTR1vzQVkBROxA6aRQ7DlWBUMjY+uRku2dTJDlMqk3ULHyNkowUxLvBV0ngFd8kDRE/8r7KweiLpuBPR2FgM2kXvOPY/hQbd7oO/sJ3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027916; c=relaxed/simple;
	bh=HZhUV4EM8bWQkAKf3IuhmmwkAq/B5kh4zS9DhKoA/vA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dS2MPa+Exyjod2aWrkxzAozlSHv2cTIMyWPUObEOdnH+A9R3hFIsWNpBm404SrUF5WNe72QllZXCreEgnDd7EYILQfWLwA7uNN0GAkgbFpHTydZGG9jNwY/h6t8U3gQY/8nLxT+tOWCW7YGUsQORJsfpgE3WDKrtRkv9L3TA4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpmzKru2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC411F00A3A;
	Thu,  2 Jul 2026 21:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783027915;
	bh=FFbMX19yCdv1YwUWUuil3P0baYF2HqJEZ0RZlmyXBZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BpmzKru2rP/kYuiRTzDkcie09BeRaQQUI69mlVEgu0ArOhxx59bE5myemSSxqbvpJ
	 wKhA4tqcaMFbh3ZZWDovJd/tgtJClE/mP1Z8RA76yeqoYsno3VdfdYGvfMWgKLFpnZ
	 i5w8ZDP/aJ3BUKZSGILZBRqks6XZ/Vzrv2KYAz3ANCieLiGtTLpCiwdrOTSkZLHlmD
	 iYY2phlTT86bogziZ4en3S5+j7UDHVheiUdrgTCD9TDOBaL2hYnPrRn4+vvuRobVH5
	 0fiFSGVDk/2pumFLJcTo2thN0cmqb+9/eCydM9GoQcx6y0dzSXdxv0oyeRFhsUzo5V
	 u3Dw0YSlEleaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/10] dmaengine: dw-edma: Move ll_region from struct
 dw_edma_chunk to struct dw_edma_chan
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260702-edma_ll-v3-3-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
 <20260702-edma_ll-v3-3-877aa463740c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:31:54 +0000
Message-Id: <20260702213154.BDC411F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12005-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,nxp.com:email];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:imx@lists.linux.dev,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15B046FCFC3

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing lock acquisition in dw_edma_device_resume() when accessing=
 vchan descriptors.
--

commit 80df5f151f3cb77451f6a2e4ec10cbaad5b50565
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_e=
dma_chan

This commit moves the ll_region field from struct dw_edma_chunk to struct
dw_edma_chan to avoid redundant copies. Since the ll_region is identical
for all chunks belonging to the same DMA channel, it can be shared.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 53469c8c8b82e..2652ad8e7a8f6 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c

[ ... ]

> static int dw_edma_device_resume(struct dma_chan *dchan)
> {
>         ...
>         dw_edma_start_transfer(chan);
>         ...
> }

[Severity: High]
This is a pre-existing issue, but can this sequence cause a data race on
the descriptor lists?

Looking at dw_edma_device_resume(), dw_edma_start_transfer() is called
without holding the chan->vc.lock. This invokes vchan_next_desc(), which
reads from the desc_issued list.

If another CPU concurrently calls dw_edma_device_issue_pending(), it uses
vchan_issue_pending() which runs list_splice_tail_init() on desc_issued
while holding the lock.

Could this concurrent access corrupt the list pointers when a client driver
dynamically pauses and resumes channels?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-edma_ll-v3=
-0-877aa463740c@nxp.com?part=3D3

