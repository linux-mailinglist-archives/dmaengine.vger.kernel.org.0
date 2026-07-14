Return-Path: <dmaengine+bounces-12488-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EqAeB1QoVmos0QAAu9opvQ
	(envelope-from <dmaengine+bounces-12488-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:15:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6427545F4
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:15:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ym1S2jkQ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12488-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12488-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA0EE302047D
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11953914FE;
	Tue, 14 Jul 2026 12:07:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA1C379EC6
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 12:07:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030876; cv=none; b=LZ7SoqKZ4WRQ/VGPwh6S10oG1rYIz6kvCS8SN5V6CtarMjUGxpk+FTWz8EClWz3vSx+Ag+Bf6F4mQuEu+Fpcb7TkvpYeVqpszkVq3hOLg/gu0BCSRb+nXIO4CH2E5IsotTll4PZjvaqVToCtLFPpkvxceWL4cLIERgeSkKfLSIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030876; c=relaxed/simple;
	bh=OMgrFuAHO48rjnve0IC7BkW6T1cWgVV5IqCaIa4ACps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3eV4D3jgz43f+dJVjUjxvAtu2JJStfOLy7pWfyW+rTTKkw9pQJ88YsgywDpS3cSZw/4mJWjyuNFihCfKo9fRP8uzi7I0CA0CL9LgK9Vcm4jrSuwdNB8X+K6si6EtXhhg3sQzlX7Q6e3vsmxw+KIOSljrBwqUtEL0Bk5DM13gRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym1S2jkQ; arc=none smtp.client-ip=209.85.161.47
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6a30bcadd95so428621eaf.1
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 05:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030874; x=1784635674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rBtlx7iHFHOhX9UuDDBDnXkrtPmiJE4QMJttkANYWxs=;
        b=Ym1S2jkQ3rodfkYBfpZ076IJbKQQVkMe5Kuqr6FjFVopmfSS9VRACdnAm+a/fgjFis
         eVzx/bCmqjtZ+PiHUAbkkFGlBZqbYaaIvA6xG1XLruvJZc8i1J1F8e4Kao9o1H00s3iV
         R1v0RaSyFmtaLJGZCczITdVJCDWLUWu5IOaCOk4BOsZTcLiCa+gYX32nF5TLtexkyJFH
         EwWtT/up56cBmdp+kvtlpqt5i6d03i/uO6Jci9S/0d5LPHcr5vEs4zwG/VbVM7hoQREb
         nt3TlX+M5YJZ9YThD3PTwsss2ph/hVVkkLymsSH46u3+LLFm14gJkxhYZQ1tyjgXu/xc
         2mJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030874; x=1784635674;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rBtlx7iHFHOhX9UuDDBDnXkrtPmiJE4QMJttkANYWxs=;
        b=Lz6AI4DD1cTQFiAhbK/EDJvHH2V86cAs99y4YNNHIouKKFmVzYhoPcoOeBpqkQGL9e
         2VvsC6Fbuu+7iaIJymCS7sz/qY6laI7KjT4aEh5JJG7Gd7tQHKZMNUYfvo+TN/fvVaeV
         QY21s4zYiXk8hD2RujSvkeHs89yJZ3cKLprMPNNj4Qq6nIgiQBoAAUvleDPAgeLy8iot
         hZtfQocMgCFnjmUvrU99mW4EeI+528pjCzCZqrY4fqFDv4bLH26HB6Ue/HIfKzTGLKgy
         BuJhYsZtTWCNOl/8Py4xC5Pb0qfm74cTJXt3tfgeAsZVL9CArgOSAl8zTLDxREu/6NUk
         aWGA==
X-Forwarded-Encrypted: i=1; AFNElJ+PGXM7CMCHVKr1Lot10DUdWEnoVBxjBbvWzFge1cPsSkiolRL2bvJq1xSn5mtT7xx3fGauIfZpdG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qewN5zwlJF4CkwzwMGMmFTwjkMURyxvqXZQRfW5F2GolFNU4
	9N/qiphhkyEMExfUjLHYS+vct4WI4ZFCIoQDdpkI45GekeLrHM1j4etI
X-Gm-Gg: AfdE7cnoOeLH5HJsQi2fbfJxo1B8pZT/H3nlp+nMcRPBh95QSTRrjsjjyvUEF2gljSo
	Bs4Dab2gbUdiEMNVFhEgtnDp+dUjSsCslkORk3rrXTw0895TA2Lm7kPIh+S83xLfa8VddzGvZrI
	eGIrQT6/DPt7o4j8Uby1+EnlFgWWX0tVZWspo1Ff1RAvHqVr6S+2k3PtR5PCC+DrfofgpXABkFK
	B+rGLc38ZQWxnsX9tAHwKZKtIcugiPOPL0ibfEGZ2t1f3DI4c/87XmjpWMYXhmwSpowRyezQ3Pg
	C+/ZPyfcviEwts3cDX3GwZ4rbcGVB1wnG0SA2xtDhzZHAT/9M9B62UKekB0CAbGksV2jkTZCq4A
	Jaac+dAvxkf99EzUm4H4GDmOFiHq4671vkRv1QZUQTH7ItStIJ4cWjNMkG72v2W+mb6AErBCbUL
	NF3CsvRQp8rXj+n+9ZS2IIyJjGHQ==
X-Received: by 2002:a05:6820:1627:b0:6a1:50f8:abb5 with SMTP id 006d021491bc7-6a39bee703cmr6227343eaf.32.1784030873900;
        Tue, 14 Jul 2026 05:07:53 -0700 (PDT)
Received: from localhost ([74.80.182.78])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb3f2b86sm14964026a34.26.2026.07.14.05.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:07:51 -0700 (PDT)
Date: Tue, 14 Jul 2026 15:07:46 +0300
From: Dan Carpenter <error27@gmail.com>
To: "Taedcke, Christian" <christian.taedcke-oss@weidmueller.com>
Cc: christian.taedcke@weidmueller.com, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: nbpfaxi: Fix setting channel irqs in
 probe()
Message-ID: <alYmkuGtjGRvMqup@stanley.mountain>
References: <20260703-upstreaming-nbpfaxi-v1-v3-1-24f7f9aa102f@weidmueller.com>
 <ak96OkpYvJrK1Vbt@stanley.mountain>
 <84676bd8-3815-433b-b531-2715b8e8693f@weidmueller.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84676bd8-3815-433b-b531-2715b8e8693f@weidmueller.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12488-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[error27@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:christian.taedcke-oss@weidmueller.com,m:christian.taedcke@weidmueller.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,stanley.mountain:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,weidmueller.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F6427545F4

On Tue, Jul 14, 2026 at 01:58:53PM +0200, Taedcke, Christian wrote:
> 
> 
> On 7/9/2026 12:38 PM, Dan Carpenter wrote:
> > On Fri, Jul 03, 2026 at 09:56:12AM +0200, Christian Taedcke via B4 Relay wrote:
> >> From: Christian Taedcke <christian.taedcke@weidmueller.com>
> >>
> >> When one irq is used for errors and each channel gets a dedicated irq,
> >> the total number of irqs is num_channels + 1. If the error irq is not
> >> the last entry in irqbuf[] but an earlier one, the loop assigning
> >> per-channel irqs terminates one iteration too early and the last
> >> channel is left without an irq.
> >>
> >> Iterate over all collected irqs instead of num_channels so the
> >> error-irq skip does not shorten the effective channel count.
> >>
> >> Fixes: 188c6ba1dd92 ("dmaengine: nbpfaxi: Fix memory corruption in probe()")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
> >> ---
> >> Changes in v3:
> >> - Guard against out-of-bound writes to chan in case of an invalid eirq.
> >> - Link to v2: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v2-1-e6d6b178a278@weidmueller.com
> >>
> >> Changes in v2:
> >> - Advance chan only when assigning a real irq to fix out-of-bounds
> >>   memory access.
> >> - Remove now redundant ARRAY_SIZE(irqbuf) check.
> >> - Link to v1: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com
> >>
> >> To: christian.taedcke-oss@weidmueller.com
> >> To: Vinod Koul <vkoul@kernel.org>
> >> To: Frank Li <Frank.Li@kernel.org>
> >> To: Dan Carpenter <error27@gmail.com>
> >> Cc: dmaengine@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> ---
> >>  drivers/dma/nbpfaxi.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> >> index 05d7321629cc..b1f06f0bd0d5 100644
> >> --- a/drivers/dma/nbpfaxi.c
> >> +++ b/drivers/dma/nbpfaxi.c
> >> @@ -1374,14 +1374,14 @@ static int nbpf_probe(struct platform_device *pdev)
> >>  		if (irqs == num_channels + 1) {
> >>  			struct nbpf_channel *chan;
> >>  
> >> -			for (i = 0, chan = nbpf->chan; i < num_channels;
> >> -			     i++, chan++) {
> >> +			for (i = 0, chan = nbpf->chan; i < irqs; i++) {
> >>  				/* Skip the error IRQ */
> >>  				if (irqbuf[i] == eirq)
> >> -					i++;
> >> -				if (i >= ARRAY_SIZE(irqbuf))
> >> +					continue;
> >> +				if (chan >= nbpf->chan + num_channels)
> > 
> > Prefer my check, but sure...
> 
> I tested changing the condition back to check for i. But after a few different approaches, i think the check in v3 (chan >= nbpf->chan + num_channels) is more robust.
> 
> It handles the following cases well:
> 1. eirq is the last entry in irqbuf[]
> 2. eirq is not in irqbuf[] (which is not expected)
> 
> This check also makes it clear that the write destination is verified.
> 
> -> i would prefer to keep the v3 patch as is.
> 

Ah, yeah.  You're right.  v3 is good.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter


