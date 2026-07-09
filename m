Return-Path: <dmaengine+bounces-12170-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NMe0BL96T2pPhwIAu9opvQ
	(envelope-from <dmaengine+bounces-12170-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 12:41:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E8372FC0E
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 12:41:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ArqUx5zo;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12170-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12170-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76C523020BF1
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 10:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ECB33ADB9;
	Thu,  9 Jul 2026 10:39:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7353F9284
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 10:38:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593540; cv=none; b=dEOjdg5AExSeWmzcL2ie0JrJO0dZXNCDX0wmhilfOXmrJrqudU1WYphR9tjrdzPDyzbbKuBSYh4NtEU8P2GMpQGtigq1GyOzajOAA0hcJA46bQA4zWToVeoWCvLEtwjOhQ1CSNXM59j8pOzuj3YXFSfXv6saytNLcqOR7MlnT3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593540; c=relaxed/simple;
	bh=DOuG5gjS8VtY9hgxIHCg3ZQCp1FjR2d9Tt/GATMdNpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFAK86LJUksGLw3Aopy2LtcVXPo7nO7HtuasB9O0ysds3/P3ZwUWzZcFHhnJqXAXxctPRB8XJWiTKpWwRDtNvfCTQzHCRjEKmHmCY6/sSFdH9DLBknldSofKcDM9kR6BFgJh79bv/6fxjYdbgoJqTXZace27BEctWCeTFQsJ0fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArqUx5zo; arc=none smtp.client-ip=209.85.167.173
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-495c49f8eccso1197106b6e.3
        for <dmaengine@vger.kernel.org>; Thu, 09 Jul 2026 03:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783593538; x=1784198338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AVlcql+y5AX7/oXVhdB5xhu8xk1LBRNpNhGhNJlFcnw=;
        b=ArqUx5zoktzFib6Sm+jNLDx87X+YYHieMXRt2xthrY4wjf4Q6MC4+Klfa3JD60vOKv
         VosYDfIGPob40aV6OFeQGTVvHXgHSkaM3o5wYc0z/JyD/ZphdYSUuZ4Mz3HTnn8tMqj6
         VKiMUg7ozvX8fuUg6ebvfGlXXRy4TsaQklzbA709I2Zqa8lRF3YEMQjZI+mnlbs9yX0k
         1Wfz5TcIKnI9vofHWnLFE7SEs60jsnH5ayGbmrFYdZlHhbqkMAyucc1deNZLW1/xCDPL
         0tGleX3lJPmN5yGmu24/YD68BHI0xbJ+aX3GLikM96xfkdIyjXwgrtAdTwH6hYOTM3Nt
         ICYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783593538; x=1784198338;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVlcql+y5AX7/oXVhdB5xhu8xk1LBRNpNhGhNJlFcnw=;
        b=ZFfnhb5mCN20p9e8f7CSoflLLgMR7EHFykyX0uJjylz0tdK+PEa+/vxk40CDpEaOvJ
         pdo4S2n5d89ZKVwibM8Jvg9XQBLgYpDKuyeA8ilGgbazQrMuqSB6uFijcrosq6x2WJ0F
         6Hq5JEgoeUZggRZOqBMUBPE5jr6ECyywJWENp0C80chk8rXsvI9l8zvGctgWfem6JMTa
         ESBtvykRPuhMAaTxwgSOSg9taneXc/MXVDaMPgSscQKOsrrDZ1ePd1CF1iW6dmxAs+Mf
         8wBue7CEUA2BjdjzIidDN98mtF+Zu2CCXgYUKdP4bbhs6nqb4ZkD5tZbh0+fHe7eHapO
         Ay5Q==
X-Forwarded-Encrypted: i=1; AFNElJ88RxKfO9c4DE0VBZHIDn6BP3bT9QihtoEouSeBt65ppyDbw8a8zbQuUOBeqVVBXYTH8zDuR7ZB8B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTciZkXUH/Zj6Cno5fkaT3U9odtKqLjuU8vewacaY/t5Rym672
	DYxKOsn4pkisQnRvQa5eFWPaSdtiPrZw/nEcvpGcZ4I29Si7kJBVyGqd
X-Gm-Gg: AfdE7ckFm5F9XY+fNycoOw7meKqHj7CkRbQyCQhAUy3wwunRRu2k4Nr/lKBVIoAq6Dt
	llzjkXVejhX89DzghluIqAXR6JDoQk13TVEah7SGU3ubFgSJRZTJat3S0kaFI4EGgxAyq0syR2s
	CRhstqJHEPJ4dA/GGgAGwuespew8jqRVXBN9RxbM2ZwwUiqZ2qgJQPip8hMHZNDJ1udw7mkUcS6
	ORw0/nj6IMakL+Zb9JTKtBWwUhbGwQ+Bknwtn/8HCp8skVep0nkZLC1TNt951oOYfwKzt1278Pt
	gqJgdzRJolGOTnvqLWH3IS4A1n0XfWqU8wzIEkhQakI0hUl8xKSPMMww08u5K3l987cdstnhPWg
	dyudln0bX2fC5dB0Z8OexFwGwZetQmIEetEgLiS5cc8SGakximyY0CfOH4sXKUVgCU51+9VUMp0
	hPZupe
X-Received: by 2002:a05:6808:6c82:b0:497:8b9:bdc7 with SMTP id 5614622812f47-4a202d93e5dmr5395525b6e.15.1783593537569;
        Thu, 09 Jul 2026 03:38:57 -0700 (PDT)
Received: from localhost ([74.80.182.70])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1b02e5abbsm3510973b6e.15.2026.07.09.03.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:38:56 -0700 (PDT)
Date: Thu, 9 Jul 2026 13:38:50 +0300
From: Dan Carpenter <error27@gmail.com>
To: christian.taedcke@weidmueller.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	christian.taedcke-oss@weidmueller.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: nbpfaxi: Fix setting channel irqs in
 probe()
Message-ID: <ak96OkpYvJrK1Vbt@stanley.mountain>
References: <20260703-upstreaming-nbpfaxi-v1-v3-1-24f7f9aa102f@weidmueller.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-upstreaming-nbpfaxi-v1-v3-1-24f7f9aa102f@weidmueller.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12170-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[error27@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:christian.taedcke@weidmueller.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:christian.taedcke-oss@weidmueller.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:from_smtp,stanley.mountain:mid,weidmueller.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27E8372FC0E

On Fri, Jul 03, 2026 at 09:56:12AM +0200, Christian Taedcke via B4 Relay wrote:
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
> Changes in v3:
> - Guard against out-of-bound writes to chan in case of an invalid eirq.
> - Link to v2: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v2-1-e6d6b178a278@weidmueller.com
> 
> Changes in v2:
> - Advance chan only when assigning a real irq to fix out-of-bounds
>   memory access.
> - Remove now redundant ARRAY_SIZE(irqbuf) check.
> - Link to v1: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com
> 
> To: christian.taedcke-oss@weidmueller.com
> To: Vinod Koul <vkoul@kernel.org>
> To: Frank Li <Frank.Li@kernel.org>
> To: Dan Carpenter <error27@gmail.com>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/dma/nbpfaxi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> index 05d7321629cc..b1f06f0bd0d5 100644
> --- a/drivers/dma/nbpfaxi.c
> +++ b/drivers/dma/nbpfaxi.c
> @@ -1374,14 +1374,14 @@ static int nbpf_probe(struct platform_device *pdev)
>  		if (irqs == num_channels + 1) {
>  			struct nbpf_channel *chan;
>  
> -			for (i = 0, chan = nbpf->chan; i < num_channels;
> -			     i++, chan++) {
> +			for (i = 0, chan = nbpf->chan; i < irqs; i++) {
>  				/* Skip the error IRQ */
>  				if (irqbuf[i] == eirq)
> -					i++;
> -				if (i >= ARRAY_SIZE(irqbuf))
> +					continue;
> +				if (chan >= nbpf->chan + num_channels)

Prefer my check, but sure...

It's pretty annoying that sashiko bot doesn't CC the CC list.

regards,
dan carpenter

>  					return -EINVAL;
>  				chan->irq = irqbuf[i];
> +				chan++;
>  			}
>  		} else {
>  			/* 2 IRQs and more than one channel */


