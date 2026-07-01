Return-Path: <dmaengine+bounces-11903-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /jYoCL94RGqNvQoAu9opvQ
	(envelope-from <dmaengine+bounces-11903-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 04:17:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A87436E939C
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 04:17:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="PFmvh/uc";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11903-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11903-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21E8F3027346
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 02:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C18B7E0FF;
	Wed,  1 Jul 2026 02:17:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12EB191
	for <dmaengine@vger.kernel.org>; Wed,  1 Jul 2026 02:17:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872252; cv=none; b=kj3ciJ/wZ+vOEyik7k4GqGaVooUbcscmC583bNRmiHaSm9mDvHNKXfBebTXc5N/8wM/W37niNHFJle5Ib/mQJqA8O95lL8+zciEG9NrdxKTW84JreRxpnwgsLof/z+pdVlOngVnXz1c9eMaiNfS28bFB190X9TNISRz3NVtp4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872252; c=relaxed/simple;
	bh=zcG2T9adU2GnEqw21fsX+7R6V09to5NKmWH6GDOJOYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2YEiW6K2CiXYksQQHyvcZ8A3Yfm5u8LZ4JFEQkJIStB178k8RaxqZVU0cRGIChiN0kHPblINQFBiooSROYd0b2y6hUMgw1A15+sjrnDlW0iW53BSpJFX+/7Se1JYN15g+H8RsT70ag6juFjpnidiskS3NB991PqhWSOTB63TNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFmvh/uc; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so761785e9.0
        for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 19:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782872250; x=1783477050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w1mJMvxhvpDlwQYPljRt72HB9NQEgi3Qs1gpX9zQIsw=;
        b=PFmvh/ucStkg4Rng9Bp2p9mXqWShuNx9bGKXmftug3MXEeVSoOzpTIStO3Df3JTLJX
         P2SLwjvAwLdM5mxn67f8x92IA7G0C9kDOsPaQUsUKHA6pdPSXkcWqH/0T4xxdVeraoB/
         QZq4t+x3GvXLtOaskIAM0hq14ygkbXP1X+4684EhXXQUc3CtCO/2Yo8qlha5p11eH4Pj
         cwyi++EOc+REV9oGJOynURsz6LqRthiZmomXpRrG11d9M+PhKv25i5L8EnD8CqwLdiXo
         guNnUhXRdASpuHvGNLbOIAs1jIwearZxmRhZtN6QIxRegXKTggX5V4iVdr6P4PIHb0yd
         osTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782872250; x=1783477050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1mJMvxhvpDlwQYPljRt72HB9NQEgi3Qs1gpX9zQIsw=;
        b=I6inSaJv2S+KaSpRYAk83JplZtelyuO/1WP9rGSsyMgl9DQR0pZLf0NsHuPMwPeAVr
         Lhpf/SyIkx/WfH666M69NDn2ZhireCOhXFP97k7jySjQtiRJu3JyrqU4AxqoG+HhjtQd
         pZbWFa2ctQ0qw19olZ4peDKnT12wxVZhV950m/Rjm+qR4K++iUs81aqYtSodo+wkEdht
         HBmDNO3eZtHTiGqyBlh7udmZ/0fFTvJSOO4wnQxkDYv/fP41qKmbeRIC/R8xsuq0VxIm
         Vr/kDFkVNzSCCBEcl8KcbOyFHuS4HwBUncaXJVAj34jalMioZikFy/LY2X2W6xAW/unx
         4b9g==
X-Forwarded-Encrypted: i=1; AFNElJ+RUxQrh7lMdMto5mkOC64ZBtkEKk7+YCS6Fs2W6lOyw6dmZzATjKxjOYTxff/5j1JOMBzoCIjW0KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEsz6LLEoWHg26aCoUuCqtb3S00NCezViE3dkrTYe+GivWmKZ8
	28FBiywCDPgP3SSlGuu4+G2EX2fnxz7z4EywHROJi4rftsupZvIlF6Ff
X-Gm-Gg: AfdE7ckuc4gN2OXlN4aPYyc0IFtRYtwo5p+p7579xh0vt36CRbLqfRea4Um07MGBgiz
	mTEGtt2v4t5Xs+ONhlNk73jkzs4/4JtHLEtHaPKtAlhM9FK+UO/4yiUHOafeAFKwA1Vm8rgo7WW
	q68x+PCQfK6DtyYeZjM5TV5L5Gae8LlppdvCG9FTaW+QdfovHmDqmWJz2BPpS/58R1iJS3YiLLr
	z4XcFtsaMY9LqCW8rKYSXuI6pKWY3Xo4QqJkvbdTVg5QsNbwwesYd1r99ZanxeMqzJlGXXLSx24
	H3wFbeM0YUchmwrSmgwmzXeobNjZGHxOSqC/FoICfC2RMrQwY3QGuJV+5fpaBikGSGVgNyUXl/6
	4RnkQjeagC9wyQie0z8LAj6M+FP72g5ljlcpKcRsPSLc5DSU6YTVhQ2EruNf7I5cM/6gTEeCKy8
	UDsEnwx+ULAzQd2WPeynlthMVgUT4=
X-Received: by 2002:a05:600c:3acf:b0:493:be37:df11 with SMTP id 5b1f17b1804b1-493be37e0bamr30875215e9.16.1782872250156;
        Tue, 30 Jun 2026 19:17:30 -0700 (PDT)
Received: from olivier-manjaro ([78.196.47.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4c7f2csm44508855e9.3.2026.06.30.19.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 19:17:29 -0700 (PDT)
Date: Wed, 1 Jul 2026 04:17:18 +0200
From: Olivier Dautricourt <olivierdautricourt@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	Stefan Roese <sr@denx.de>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: altera-msgdma: replace maintainer
Message-ID: <akR4roTi60VyFWCo@olivier-manjaro>
References: <065e447dc41ea149c900338e64f047575ca6c348.1782279704.git.adrian.ho.yin.ng@altera.com>
 <aj4yodoqp-ZWQVEs@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj4yodoqp-ZWQVEs@vaman>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[olivierdautricourt@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:adrian.ho.yin.ng@altera.com,m:sr@denx.de,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11903-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olivierdautricourt@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,olivier-manjaro:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A87436E939C

On Fri, Jun 26, 2026 at 10:04:49AM +0200, Vinod Koul wrote:
> On 24-06-26, 13:49, Adrian Ng Ho Yin wrote:
> > Olivier Dautricourt has stepped down as maintainer of the Altera
> > msgDMA driver as he no longer has access to the hardware. Add
> > Adrian Ng Ho Yin as the new maintainer and update the status to
> > Maintained.
> 
> Olivier okay with this?

Vinod, still acking the change, but I just realized the maintainer change must be done
in the dt-bindings aswell, not sure if i missed a patch.

Kr,
Olivier

