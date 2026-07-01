Return-Path: <dmaengine+bounces-11902-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AZC8Op5sRGrHugoAu9opvQ
	(envelope-from <dmaengine+bounces-11902-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 03:25:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6B96E90D7
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 03:25:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="rFiq/xdk";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11902-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11902-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82CBD301B733
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 01:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F138B1A680E;
	Wed,  1 Jul 2026 01:25:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA03233956
	for <dmaengine@vger.kernel.org>; Wed,  1 Jul 2026 01:25:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782869110; cv=none; b=H/qHc9fpd3zCNhjFNPXsI8v1khIzMlSJS0a7J0uOYApT/tgpzz33N5NeXcQijcCMPOVzMXyLzrvAHNNVinJFf3cYAtHrIiXvPYOELb4G1MsL8XUqmeNDo/XS4LwTZQsqSUs2X8kzX+URQzUhst2Jb0QTdpOB9MEGkaVdNotztoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782869110; c=relaxed/simple;
	bh=cQgW2mR/PgRRulrVfvEf6e+/uhRckMzhzP7q+52jQ98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ny3ce/hyWyXkmxMm/XRG8g4fHOx7CzC6ajJ4ibSHiWywKIkBjp9letHL43eUIOmmQF5jqMrRL8aCNW0cl9NwYSZx3n4wpM5yKj/lrFe+Wn0JspKJdH6QvwIXHCNFtNHh2Dj8wXT23RlfWYpqnIRA9mUOAl9RnfQ4nAlH25ub/5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rFiq/xdk; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4939a809b24so882325e9.1
        for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 18:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782869108; x=1783473908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nC9KbANghxEmmk8WaplVyIhxH6ahWbDMKn7hzWBiDi4=;
        b=rFiq/xdk/aVWsIB5B2hR8tQ9Jd/BGMcEfunGlOL2EaMxH6wfgXkuuYPOdGBuO1EXkW
         6P8Z391yaN2kmUvjGpto0sZTifNH+i2jGkoCWPuTGkJUMFRqqE268v2C0XOwBDwYseih
         Ppqd5ZyBwYElvv6LPBEJVX5XQCsCwvxOYapKYkaCfuO0dN7YI7deNAvxS90z8WP1Levo
         xd4kV8SBHLqOqYH7fGHOvaWNKh4xxsL23gS3bHcSQb5wb88YxrxnF5CuB0aE7SoJXWwB
         ngOiE4YGyfQhaoylcpPg0P1YLp7dtB5x2j0OEQC40uPN+PhW2tnVfeeS/YT4KOrkYJRP
         ZJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782869108; x=1783473908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nC9KbANghxEmmk8WaplVyIhxH6ahWbDMKn7hzWBiDi4=;
        b=SsSBMKhOUgffwDMfvLhHy6uE0EEQF1AY7R7xnjZ6SNwB5eZQFW5c5esvlJ2BJhoumH
         N21HXqKRWW5X+0BJmvL49XGkuxMIitd70FeCVJU3iNThkaf8iuEIa3Qdvd8ilAv+ygpY
         jpGU6qpUwk/sLkq1tK2hQlktNtbiaChWw9O7EHeQlUjQcQ7DSys2UBIFYa0woFAPAGpL
         DwDvAhiHQvxuizMr4m+ZnQ4SK1mHIiI19crnMLjemEstRY7ysLv5N98xoEmQsVKB/Dci
         joRMuOsWMftAQgSJkqNgcxE6Q3AWgBSMnuYocHVgyPG0zwvkCQoXobfuX9K1Maltsjgi
         cGdg==
X-Forwarded-Encrypted: i=1; AFNElJ+cEMpTiGvdNIyhucRI6SQiI8govDnx41tebRFjyU5qTdWHUFfzpRX1MEjlwwl8yIq2Qd/U9o6NuHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqTHX9ClIG3epFgSyY92JMusyOd1emFNtSx1uKEc1gVcShWofb
	XqTZyqdzF4QKwzD8QZwqmCT9UNagy+YrJU9bgDOQeI5LWJS8DbE/RGn+
X-Gm-Gg: AfdE7cmFvQUCf8BQbOcjBYhqMXpnMQ6RnJ1e0XkatclRFCZQvUc+X10hFA4s433i4uE
	JNbR0iJIOrVprjmmP/PB2FCotR18dIkznm9rcE86z0Mg7MIed4a0Bc3q1EU5gpwDU5xqOlHIbya
	mVmjD9vrjE1XK/dcZvF+AIWZlyDuj/udwZgGO98frs3WbkJLo+fmLsyfrrNmuyc7q7jpzkI+MYi
	00KkY9zclyFT1e13dW2K5TQtUWsKNMK+f1PQSsHvk102J0aIClth7vahFvlOQPnReRvLuDAVAEn
	2Skur75E5ca+JMSKvV+8UXpqD22KgnnivIVMgzyYMwVYnBOVfvjMowKriNLpPlniGYbhYuByIXq
	ve2V0Hy9exVyDm1/3NckCJaHngXDq5jMDaStFCz32uNUuQrEBc3vlWf0HnCBIFY0L1chHtHEhTy
	9jNHwhxgXos5R9GMnAyvTCFhA3+dJ43eYbC4ywA9vJ6Ak4n9ur
X-Received: by 2002:a05:600c:6085:b0:492:437a:a653 with SMTP id 5b1f17b1804b1-493bdaa8f32mr37301465e9.26.1782869107714;
        Tue, 30 Jun 2026 18:25:07 -0700 (PDT)
Received: from olivier-manjaro (oliv-cloud.duckdns.org. [78.196.47.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4dd77bsm33542595e9.10.2026.06.30.18.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 18:25:07 -0700 (PDT)
Date: Wed, 1 Jul 2026 03:25:05 +0200
From: Olivier Dautricourt <olivierdautricourt@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	Stefan Roese <sr@denx.de>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: altera-msgdma: replace maintainer
Message-ID: <akRscQhCethn25Kt@olivier-manjaro>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-11902-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,olivier-manjaro:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F6B96E90D7

On Fri, Jun 26, 2026 at 10:04:49AM +0200, Vinod Koul wrote:
> On 24-06-26, 13:49, Adrian Ng Ho Yin wrote:
> > Olivier Dautricourt has stepped down as maintainer of the Altera
> > msgDMA driver as he no longer has access to the hardware. Add
> > Adrian Ng Ho Yin as the new maintainer and update the status to
> > Maintained.
> 
> Olivier okay with this?
> 

Yes i am, sorry guys for the late reply.

Acked-by: Olivier Dautricourt <olivierdautricourt@gmail.com>


