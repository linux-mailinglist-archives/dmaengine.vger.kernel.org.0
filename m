Return-Path: <dmaengine+bounces-12168-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rIvXEW59T2o2iAIAu9opvQ
	(envelope-from <dmaengine+bounces-12168-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 12:52:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE8272FE4B
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 12:52:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XMmKUPyL;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12168-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12168-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26CD330690F8
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 10:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A263D3FBB69;
	Thu,  9 Jul 2026 10:27:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213BC2D781B
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 10:27:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592841; cv=none; b=lAxNSerUsnFw0RQLMwzeCDI0IW3CywjNOsLHSkiEIyYqrY2Nqgl5y6iUCeU5HdISFqZSf4bE6hyrqPsLG5WSbWWcNm/2AfJ16Mx5OhQet20OzmwnEBdcMt3+a44Nl9ytsCZhe8C2shJfhom24BpoLaB8ioXOwwxMYqww9oQbdz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592841; c=relaxed/simple;
	bh=L2WCr6taxGkTOVHzUf3RYCQ2nUSH6l8pW3+moY7GGhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6ogvnI0cp7gugqUkelosdd6pAMm6ZYzm/xvtX9pSsL93rt9h49oIVjr/L0mCKOt4HyisUO4QWl0xNTD5dzzGnIDF5pg54rSWdD05dRrswejsODNuCoeNxT2ARVkl59mkxoDMEBZ4K6E/PbfRz9/m+1dWkNF/JNs47TWN7pQkD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMmKUPyL; arc=none smtp.client-ip=209.85.161.53
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a384e29a20so89728eaf.1
        for <dmaengine@vger.kernel.org>; Thu, 09 Jul 2026 03:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783592839; x=1784197639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yTHA/HAGmx+6vLyILbr+Ji6px3cTIRCKaDC8NslzL3E=;
        b=XMmKUPyL5cepxfvC1sytDE50rvwWz0WpmOPoZt0EQZc5uHqin6aH5olO9ekZzFKeZm
         kKgr3UHr2zIC+oTZNiGV+UbfvmI+yEfvz1JesK5Gn4j3wHGVvb5Hik3UxL8/P+tSd5hB
         5/Mhz6p0ZL6KMb1d0A6aDLqF7SnxQgD67P8eD8b6BMrqWZm3w1r3fZIaLPLlu1+WnHHJ
         QKnZuSfJrduak1B8fs5asfugeS7eOFsK0bqAtjLMiL+AOG4wHLY6KjoeS7c5+BJpBMLa
         khwlcdMeDphFSyhbQKNi57VpPi8A/FamsuhqKZW0Yg+D+dWjNmqlY/Jfx4DmWXfL8D36
         Y85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783592839; x=1784197639;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yTHA/HAGmx+6vLyILbr+Ji6px3cTIRCKaDC8NslzL3E=;
        b=RHacoRNB1LCJCww042cNHExoNlOPlqzrsgVN6KW8PkVn7BwHBj4SpyHbO/mLkGkEpe
         qYL1Y7Dwsro29Rwy1Yxq5YvF5nrVIc5FG0SgUEgk0tutYHttxeXiVSn/J+r3VELBftgV
         4OqlmZ+ghPz91vCGB3D24iF6/+dbxPk7F1fe6yiMujuywhRkEhoXos0q+xcwsGE+27N3
         FMBcbmU7jD+FXB1K0pODICTgXCKp6NXo1aUzTwqlwRrXPTapqiCuBuEDm0Y7ARL2qvzt
         5q5LaIcw8cdsBJud/yhHRX3sZUVz3tBXNoMvERahINmiCMyRKIeft2FEgPnymcbm9hPt
         ADoQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nZfminu8V7ILP/FPZcNBs2PDn26ChCUlRlVMfJ4uAEryhJ2RqQSu5QfkSwPbNpK6X2eJT+98+u8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+iXnPjNnhihgHjE1NVvicg4HT1R9SHQ/3z7Y3ZnFytzgJlcW
	O4ZglxxYf03HAV/Zi3/gBJs5k8E+42K8jAxBH1syuV41jL7pks3/eCv7
X-Gm-Gg: AfdE7cmcKPb9E1EU1KtnDUGdEAVrY8sIz/UmvgdWZ7EK4gYwFiHdmknyVA/mWHhYcJv
	vFGxQhhy5fA/uW360UOdnIIkGfpNpV2N0Exgj08vIkHcvAOu0Xi9KYPVgrp3kIUD+FAR5Ou4+AC
	PWXzlamlnGf78pUfXVSjCnwTCiNw/+/Iqc7iUgFAFfLZ/w3vcFoF39kcsIc4qoxIk9bswMW8bPl
	2Cbn372bs+NBOKVUfQMxGdeX6uAs5jQF5pmjEnqA/CHjDDLxXwMGx3KUHmigTNqyBv2BGGD0B3S
	gEMR4e8yjfPOeanLo053QWl972AZ3WHt7OjrdxSUKM8Z9OwUNHYt3gDFPEoAl9obfrq5QwmVaNO
	DgO56vuOkuBY2UIU4D8CFRLHvnXqSZPKJBnzdoW/yZZmRXSVkJpJ3Kvd3wykr2SuEL35EQMxRkK
	u4W1yTPU+ZN5+M3Pc=
X-Received: by 2002:a05:6820:189a:b0:6a3:15c3:e60d with SMTP id 006d021491bc7-6a36da65eaamr5053920eaf.71.1783592839034;
        Thu, 09 Jul 2026 03:27:19 -0700 (PDT)
Received: from localhost ([74.80.182.70])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a37b58f98csm1338565eaf.13.2026.07.09.03.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:27:17 -0700 (PDT)
Date: Thu, 9 Jul 2026 13:27:11 +0300
From: Dan Carpenter <error27@gmail.com>
To: christian.taedcke@weidmueller.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	christian.taedcke-oss@weidmueller.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: nbpfaxi: Fix setting channel irqs in probe()
Message-ID: <ak93fxRvw9UvxJLJ@stanley.mountain>
References: <20260702-upstreaming-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-upstreaming-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12168-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[error27@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:christian.taedcke@weidmueller.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:christian.taedcke-oss@weidmueller.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,weidmueller.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FE8272FE4B

On Thu, Jul 02, 2026 at 03:43:29PM +0200, Christian Taedcke via B4 Relay wrote:
> From: Christian Taedcke <christian.taedcke@weidmueller.com>
> 
> When one irq is used for errors and each channel gets a dedicated irq,
> the total number of irqs is num_channels + 1. If the error irq is not
> the last entry in irqbuf[] but an earlier one, the loop assigning
> per-channel irqs terminates one iteration too early and the last
> channel is left without an irq.
> 
> Iterate over all collected irqs instead of num_channels so the
> error-irq skip does not shorten the effective channel count.
> 
> Fixes: 188c6ba1dd92 ("dmaengine: nbpfaxi: Fix memory corruption in probe()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
> ---
>  drivers/dma/nbpfaxi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> index 05d7321629cc..74ff7bd979e2 100644
> --- a/drivers/dma/nbpfaxi.c
> +++ b/drivers/dma/nbpfaxi.c
> @@ -1374,7 +1374,7 @@ static int nbpf_probe(struct platform_device *pdev)
>  		if (irqs == num_channels + 1) {
>  			struct nbpf_channel *chan;
>  
> -			for (i = 0, chan = nbpf->chan; i < num_channels;
> +			for (i = 0, chan = nbpf->chan; i < irqs;
>  			     i++, chan++) {
>  				/* Skip the error IRQ */
>  				if (irqbuf[i] == eirq)
> 
> ---

Ah.  Thanks.  I feel like it would make sense to change the other
condition as well to:

-                       for (i = 0, chan = nbpf->chan; i < num_channels;
+                       for (i = 0, chan = nbpf->chan; i < irqs;
                             i++, chan++) {
                                /* Skip the error IRQ */
                                if (irqbuf[i] == eirq)
                                        i++;
-                               if (i >= ARRAY_SIZE(irqbuf))
+                               if (i >= num_channels)
                                        return -EINVAL;
                                chan->irq = irqbuf[i];

If we don't find the error IRQ then it would be possible to go out of
bounds of the chan->irq.  It's not likely to happen in real life but it
sort of makes the code make more sense?

regards,
dan carpenter

