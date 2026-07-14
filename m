Return-Path: <dmaengine+bounces-12463-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OvzwFeXpVWrivgAAu9opvQ
	(envelope-from <dmaengine+bounces-12463-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 09:48:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAC07520FC
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 09:48:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=puMJ1FFK;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12463-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12463-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A434F30068FB
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 07:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF51B308F0A;
	Tue, 14 Jul 2026 07:48:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A8637AA95
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 07:48:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015307; cv=none; b=HIm+7L63AUOVvftIMfJHm+IsLnOdBoUM1aHLQ+c2iUQw4RPhFT5qVkv+++SuwZT8bONERmqO7yQQvsc/AtvSOgBFUjLCeSqUWYf/HtYUekakiHEcM78h6Nncnx0Lx/5YwolBdRri1FyBBGTMnti265NoxksQz2mklxA0W02Haew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015307; c=relaxed/simple;
	bh=UzIpQvdgLlLmdEHkcbM8fn3Gj6yOw8Amrfp5HGyfXNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxeDXZI9IjW9nmbj5CTbtX/m/DibPOGBfvVj4Wqdg/eb/YuA06Murx+Y989aH1GStkhkHKcn6K2uiQOs8s/7tFLFVmBV68OqtAu38h69XzmdfyxGo5FZy7DbyffX2R9sWf84ZGdySWmVJBf72Q0QGx7IFKAIICxR4b++IjnVDoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=puMJ1FFK; arc=none smtp.client-ip=209.85.160.42
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-451fd21113cso670192fac.1
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 00:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784015305; x=1784620105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EnDWZQFCaqFrKcYRbfLF0I0CeGWYxEfSRV+U8/QwLQE=;
        b=puMJ1FFKE0bXil0ccIRkMD5YMX24uu3p0j92CP3sYc9NB2Aj2pePKlYCOt9tWqqoum
         kDe0V6WZRNyZG9r2k2R6CDumU0wOfodwPs+9OZ8LtwnBZrdrmzD5yERaJuOB3vuI4piR
         AJ4vjVoNoXVF5UGQ3xHkpOrbALydbpXD2nd/2XmYcAp0kha+tMXq8Mrad6HFqG5PYR2l
         elaLR1tcDFWdzOUbNTrrqFy3Y5zx1GT34DYmsJG249LioteucEzUSWt4jLuf4ckMIZ10
         U3TowfhiWz7KJJix3GLrg4/5uVmq8RSsDhwLHfXgCyl7hSREo6wrG79BIoC3/Gai3IW1
         wnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784015305; x=1784620105;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EnDWZQFCaqFrKcYRbfLF0I0CeGWYxEfSRV+U8/QwLQE=;
        b=reLVFXvEAYYXcHpNS8UPkbJXhRsBOoRuv37xZmsC5Tnq7/Uj5Z8TCXU5+vMwcs6GbN
         rN4n8ai3lDLc1wA5/wWc6YNP3Z8I09R0skrjyBwLgcVrhlu5c2svjSS9oslJaB0cNzfH
         6CzrxFC5XCcwCjTiSf9ykJeeOfKt7DYaAcl1nyKn/dPX4kvf1lbl3IYra9VceUsAsonF
         1Eu/G8oPXL5686J2+Jo+wyzlFujhzTmortZU3bDCea8pOMGJKyJwj/q/fhAXMtWhKu1X
         RmZVYenV4/QVLgGFS64u5H9A6FewXRyHQThMMkqSFhs9HV/B9frKbXVF2rHHsz4NEApf
         ZDaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9XAUG2ZPwfRbjsCO91YHauxE0hKCoCkPyysKVKRfuMnbORCBf2VvFNbTZ/Ch/4esHJg2J+N3go9Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUnkd+JQxhtawWqdKyFb3MHRNPdCzm7SzPchiXxTVMhCte0ytO
	AFm3sxemMFGmZ2CVzI+SizKrwQY/Ad2Mg+MucK4HtPF+WMnbHouBbjx+
X-Gm-Gg: AfdE7ckzmMJ31uNr9ro5qN1w2InO/UMqXgo3I2MXYZZN8IcVhx1IPprsVUc1s8Sd6cm
	2SxGoHKTBQ3y58R8Uuu7295R3V5pjtK5wiBrxunby3zbT7CXHiQac28/G2J9kTU+RDAx3gwJJjW
	OJqphH+etrL2VRm8cRQXOG08QB64MLdSJtfvhEAWlLYNnKh+ddZiwos4vTbPXVPGAOoAKJCrgez
	K1hEdP1tClAXkHLeqGaqiRO4gallj67OMwGIx/aLw8bSBFsFA+N4QYLiqG4AUPJAq6DIfch4l0z
	P8GNXEk5PJ78Taedgcji3XrfHf7Yvaz3feSvK2zlZpYEIjYSwatx++CnwqJmWFE67zOVTu75ZRf
	SiImgInwRQsjch2dgfh4YVu1opaOGL+D5uq63UFmau0GA0tPpmw41Bt4i/CqnHD/Ok0DwVnQ6gF
	kfA7jKVc9J6dgEwZo=
X-Received: by 2002:a05:6871:5386:b0:43b:891d:7c89 with SMTP id 586e51a60fabf-451f279c84cmr6166807fac.11.1784015305044;
        Tue, 14 Jul 2026 00:48:25 -0700 (PDT)
Received: from localhost ([74.80.182.78])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4560a9b178fsm870394fac.5.2026.07.14.00.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:48:23 -0700 (PDT)
Date: Tue, 14 Jul 2026 10:48:16 +0300
From: Dan Carpenter <error27@gmail.com>
To: "Taedcke, Christian" <christian.taedcke-oss@weidmueller.com>
Cc: christian.taedcke@weidmueller.com, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: nbpfaxi: Fix setting channel irqs in
 probe()
Message-ID: <alXpwPZauHMhFJF8@stanley.mountain>
References: <20260703-upstreaming-nbpfaxi-v1-v3-1-24f7f9aa102f@weidmueller.com>
 <ak96OkpYvJrK1Vbt@stanley.mountain>
 <a9eec0a6-6f16-48d7-9864-0051cb8c455b@weidmueller.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9eec0a6-6f16-48d7-9864-0051cb8c455b@weidmueller.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12463-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[error27@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:christian.taedcke-oss@weidmueller.com,m:christian.taedcke@weidmueller.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,vger.kernel.org:from_smtp,msgid.link:url,weidmueller.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CAAC07520FC

On Tue, Jul 14, 2026 at 09:44:22AM +0200, Taedcke, Christian wrote:
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
> Thank you for your review, i send a new version where i try to use your preferred check.
> > 
> > It's pretty annoying that sashiko bot doesn't CC the CC list.
> 
> Is there anything i can do to improve this? Should i reply to the sashiko bot comments and also send this to the CC list?
> 

Not at all.  Just random grumbling.

regards,
dan carpenter


