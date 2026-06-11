Return-Path: <dmaengine+bounces-11439-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bbS8IPdMKmoOmgMAu9opvQ
	(envelope-from <dmaengine+bounces-11439-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 07:51:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBD166ECA6
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 07:51:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KXf+91Rs;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11439-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11439-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D939B3023DA9
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D581B3537FF;
	Thu, 11 Jun 2026 05:51:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2CB2FC876;
	Thu, 11 Jun 2026 05:51:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157082; cv=none; b=SPOpz416PrxADG9toeagpwVDq09xAag2JdPcIHYiq7dh7AvBjZ3LHLcaoWhGN3XKahAZeFau59BjOGbhg/pqwlabmvjjqk4aO3vGLdu90nv9OD6Ske32y4j4BxA/fKoyo3Rs+OmN6/NB5eocDcVz8CN3jvzU6zZxk4oy+mPAtxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157082; c=relaxed/simple;
	bh=LRVh/Mjk8X1vOWUM9+veeY0ohfXKgE+Jvd+woyEI3oE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OhmlLaSHLNPE6FqkkII/QVmZlnG1ZHMkZ4Lsaqr+ElJ4cEjYm9/N3AkQLnlqMs4KmFbRBOng56186Dz7r3HWxRZvmnXEwzsMcccsYvFZwkMzV1CNyNHCe04IBMggGUCPqjY9IgmR/WJi3SkZW33QDSNoCzXoAskN/uxpOVmFVFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXf+91Rs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6A61F00898;
	Thu, 11 Jun 2026 05:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781157081;
	bh=RemkpoCDnTZqBstYyXo0MejTmhJR+KFvhfknxwHkkJM=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=KXf+91RscAkOyQ/mijyMEYqS9lQbxVAjkf/UVjbat+VXQDepRWYuK4MOPSNQ2kHPs
	 7zAQ49JEb8R0S9kAQL/WKG5ppmL2wcsY7BlSVekSpVqGVhuBym1iGUqz7AR6NP4G4X
	 PwbhRWdtc0VQT8uZfXB3hI6/pciujovqGIPnNi/wIMf3GA0yEA4R3BBdx4iuojIEmz
	 E35lOIoFcSKSGkR2ztthUaMPQC3nUkclhYW+JlwKaj7PAik8013Fq/aOfdUWFbiyWb
	 vEKoqTfJpDyrNtBCGQGST5djbzT9uQ/0Nsnhbx/gF28zdSlIngY4q8kwJNz+gY3JIw
	 OjPfAOCyQjRKw==
From: Vinod Koul <vkoul@kernel.org>
To: Olivier Dautricourt <olivierdautricourt@gmail.com>, 
 Stefan Roese <sr@denx.de>, Frank Li <Frank.Li@kernel.org>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tze.yee.ng@altera.com
In-Reply-To: <f6f3b4a2e2eb0eb1a51976de3f5d1ef5bab9bd76.1779697226.git.tze.yee.ng@altera.com>
References: <f6f3b4a2e2eb0eb1a51976de3f5d1ef5bab9bd76.1779697226.git.tze.yee.ng@altera.com>
Subject: Re: [PATCH v2] dma: altera-msgdma: Use memcpy_toio for descriptor
 FIFO writes
Message-Id: <178115707884.468137.4553819272853590376.b4-ty@kernel.org>
Date: Thu, 11 Jun 2026 11:21:18 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:olivierdautricourt@gmail.com,m:sr@denx.de,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tze.yee.ng@altera.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,denx.de,kernel.org,vger.kernel.org,altera.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11439-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,altera.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFBD166ECA6


On Mon, 25 May 2026 01:37:30 -0700, tze.yee.ng@altera.com wrote:
> The descriptor FIFO requires that all words of a descriptor are written
> in order, with the control word written last to flush it into the DMA
> engine. Using memcpy() with __force to __iomem is not the correct API
> and does not guarantee appropriate MMIO access on all architectures.
> 
> Replace the descriptor body copy with memcpy_toio(), using
> offsetof(struct msgdma_extended_desc, control) to exclude the control
> word. This matches the previous sizeof(desc->hw_desc) - sizeof(u32)
> length only when control is the last struct member; add a static_assert
> to enforce that layout so a future field after control cannot silently
> break FIFO ordering.
> 
> [...]

Applied, thanks!

[1/1] dma: altera-msgdma: Use memcpy_toio for descriptor FIFO writes
      commit: 94963138cce29f85605d76c94fa1d43a0335ead9

Best regards,
-- 
~Vinod



