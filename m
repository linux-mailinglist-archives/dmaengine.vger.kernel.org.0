Return-Path: <dmaengine+bounces-8805-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLMQHo1AhmmFLQQAu9opvQ
	(envelope-from <dmaengine+bounces-8805-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 20:27:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62206102B77
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 20:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86DCB3007963
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 19:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BC33093A7;
	Fri,  6 Feb 2026 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="FP0oHngw"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3232D949F;
	Fri,  6 Feb 2026 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406025; cv=none; b=tctsALm7Xiyj6wbwwbuLRbBT3KZ1NAXuxnnZ8x2g7NcUsavTdZR3rYm9XAI3wvkiHozCTmhmGZD0cZ3uFokt0egzKeE8uFsCjb8xvCNjXKeypn24YOPreYd9V6tI+yIx1gG+efqwuOslNx9HRu/fA1Tq+a3NDV9VG4QyHwTzFzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406025; c=relaxed/simple;
	bh=kCje0ywR5tJdbB2b6TCzigSsLI+g4vllS74WkXuBVHs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=OS77mvVQ1qSfBCzcf1yTl2SHb1UJq4PmsdqJgy0XsR9a4EFFsChZ2QL9dRLIETchRhq6J98dmt5m3DaOa1qDrDstOSSnS69XUMpXix0LBB2FLLm0aZqSqjuWlp/Tnsw+7r+2QWv8execB4RypDX9TDdF/jRxjvG5nK8Fv6/jp4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=FP0oHngw; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=OwUrc3I2Ad9tpzFIxqgw4V9+ayDcZReXEtjpU+M7Ziw=; b=FP0oHngw9CUJrIa3Z1qTP99s9S
	wItjiVaG9pdS2eQsgYxr0aE/B0psav3Q9/p2uLmyFvWa7S7GLO4PYSoMaIXVBwG0AkHsUseLnTEtc
	sgJXybdQytIpan2St+rVFhH2DO/KDvz5DQDsYXSaC/SzLhqKmSbjsm6GXwH2z4LwTvTMGaE+b9P3z
	ZZieU+yUMyzIOaPbNyk+AwYyfHJOabI2VSgHJMaQded2SH/jmEowf2IbElrZklTkBP1dajZz5zync
	csjDYEhIe8g+d0ozJ1w7DoFagOQ0y0GBfzahIT735mMthD4GwHzJW6Cc4f1ckmugE5V2xjIQ8y3zE
	e+TTByQQ==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([96.51.150.74] helo=[10.0.33.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1voQoO-0000000893a-2cAM;
	Fri, 06 Feb 2026 11:44:13 -0700
Message-ID: <829601a5-f39e-43a1-bec5-80195a8833da@deltatee.com>
Date: Fri, 6 Feb 2026 11:43:59 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pat Somaru <patso@likewhatevs.io>, Tejun Heo <tj@kernel.org>,
 Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260206090058.1127675-1-patso@likewhatevs.io>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260206090058.1127675-1-patso@likewhatevs.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 96.51.150.74
X-SA-Exim-Rcpt-To: patso@likewhatevs.io, tj@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] dma: plx_dma: Convert from tasklet to BH workqueue
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[deltatee.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[deltatee.com:s=20200525];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8805-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[deltatee.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[likewhatevs.io:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,deltatee.com:email,deltatee.com:dkim,deltatee.com:mid]
X-Rspamd-Queue-Id: 62206102B77
X-Rspamd-Action: no action



On 2026-02-06 2:00 a.m., Pat Somaru wrote:
> The only generic interface to execute asynchronously in the BH context
> is tasklet; however, it's marked deprecated and has some design flaws
> such as the execution code accessing the tasklet item after the
> execution is complete which can lead to subtle use-after-free in certain
> usage scenarios and less-developed flush and cancel mechanisms.
> 
> To replace tasklets, BH workqueue support was recently added. A BH
> workqueue behaves similarly to regular workqueues except that the queued
> work items are executed in the BH context.
> 
> This patch converts drivers/dma/plx_dma.c from tasklet to BH workqueue.
> 
> The PLX DMA driver uses a single tasklet to process completed DMA
> descriptors in BH context after an interrupt signals descriptor
> completion. This conversion maintains the same execution semantics while
> using the modern BH workqueue infrastructure.
> 
> This patch was tested by:
>     - Building with allmodconfig: no new warnings (compared to v6.18)
>     - Building with allyesconfig: no new warnings (compared to v6.18)
>     - Booting defconfig kernel via vng and running `uname -a`:
>     Linux virtme-ng 6.18.0-virtme #1 SMP PREEMPT_DYNAMIC 0 x86_64 GNU/Linux
> 
> Semantically, this is an equivalent conversion and there shouldn't be
> any user-visible behavior changes. The BH workqueue implementation uses
> the same softirq infrastructure, and performance-critical networking
> conversions have shown no measurable performance impact.
> 
> Maintainers can apply this directly to the DMA subsystem tree or ack it
> for the workqueue tree to carry.
> 
> Signed-off-by: Pat Somaru <patso@likewhatevs.io>

Looks good to me, thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


