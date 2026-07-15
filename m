Return-Path: <dmaengine+bounces-12552-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ywwYN7V/V2qsTQAAu9opvQ
	(envelope-from <dmaengine+bounces-12552-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 14:40:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F17475E42A
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 14:40:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=VltoKQHc;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12552-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12552-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F73230EAEDC
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 12:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA79472798;
	Wed, 15 Jul 2026 12:31:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5893B47A0B0;
	Wed, 15 Jul 2026 12:31:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118678; cv=none; b=AaZM0WbsiIoJSO1/0hy6sIZ67e6zOmdkV9df2xLIpTPkOWwD3qeql9bxeBAxCgxwI4RoYbp5tOmT5fnbeiyiHgQkwWkzUNDJ98Ivwe3S1uG6ROA3qhLLXC85NDYKvNAOG3Vb/DaQUEXffPFRUwj33cMZB7eyQs9z9tP+H4mca2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118678; c=relaxed/simple;
	bh=egBPbzIXms4fL1Qs09T5XJ/wfT9wY+BYWZ3eoAlNZds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/JCj6KccHMoI1npMgvWWIO7uLjwIdG4UWZbBpZSgS56YyxZlHapiEc1qN0Tfbg4Idy0t15uL+bAWHwNjL9/jGBKfwLgKhz8j0LCGDCOfxMB96+iklNFbfk/jtCs5dgxXCLfY13qRNbJrWnQoHdI8l525J9W6ShMUH1+6fbAXHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VltoKQHc; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EFDA1477;
	Wed, 15 Jul 2026 05:31:12 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D78FC3F7B4;
	Wed, 15 Jul 2026 05:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784118676; bh=egBPbzIXms4fL1Qs09T5XJ/wfT9wY+BYWZ3eoAlNZds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VltoKQHcQlJoexJ6Jjp1KA4NelG2bX/uvsh5bL9ZClb4EclHnT1d40E/afJa1IGeg
	 JJMEyTjyWcvN23arFO6KJvqIM6oy/YRGbo9LoeE4/opElDdFRETlU9ka3gvC/hgKIU
	 fc6ytDHpi7PFogTDUVijGk8Ii2vAIQyrtPjlwQ5Y=
Message-ID: <f9d66162-a30f-4184-aa0e-61719afbd1e1@arm.com>
Date: Wed, 15 Jul 2026 13:31:09 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] dmaengine: arm-dma350: enable ANYCH interrupt for
 shared IRQ wiring
To: Jun Guo <jun.guo@cixtech.com>, peter.chen@cixtech.com,
 fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20260521072924.3000282-1-jun.guo@cixtech.com>
 <20260521072924.3000282-2-jun.guo@cixtech.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260521072924.3000282-2-jun.guo@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12552-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jun.guo@cixtech.com,m:peter.chen@cixtech.com,m:fugang.duan@cixtech.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:vkoul@kernel.org,m:ychuang3@nuvoton.com,m:schung@nuvoton.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cix-kernel-upstream@cixtech.com,m:linux-arm-kernel@lists.infradead.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[robin.murphy@arm.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F17475E42A
X-Rspamd-Action: no action

On 21/05/2026 8:29 am, Jun Guo wrote:
> Enable DMANSECCTRL.INTREN_ANYCHINTR during probe so channel
> interrupts are propagated when integrators wire DMA-350 channels
> onto a shared IRQ line.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
> ---
>   drivers/dma/arm-dma350.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
> index 84220fa83029..09403aca8bb0 100644
> --- a/drivers/dma/arm-dma350.c
> +++ b/drivers/dma/arm-dma350.c
> @@ -13,6 +13,11 @@
>   #include "dmaengine.h"
>   #include "virt-dma.h"
>   
> +#define DMANSECCTRL		0x200
> +
> +#define NSEC_CTRL		0x0c
> +#define INTREN_ANYCHINTR_EN	BIT(0)
> +
>   #define DMAINFO			0x0f00
>   
>   #define DMA_BUILDCFG0		0xb0
> @@ -582,6 +587,10 @@ static int d350_probe(struct platform_device *pdev)
>   	dmac->dma.device_issue_pending = d350_issue_pending;
>   	INIT_LIST_HEAD(&dmac->dma.channels);
>   
> +	reg = readl_relaxed(base + DMANSECCTRL + NSEC_CTRL);
> +	writel_relaxed(reg | INTREN_ANYCHINTR_EN,
> +		       base + DMANSECCTRL + NSEC_CTRL);
> +
>   	/* Would be nice to have per-channel caps for this... */
>   	memset = true;
>   	for (int i = 0; i < nchan; i++) {


