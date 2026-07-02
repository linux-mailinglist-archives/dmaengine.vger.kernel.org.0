Return-Path: <dmaengine+bounces-11982-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G6s+BFOJRmpWYAsAu9opvQ
	(envelope-from <dmaengine+bounces-11982-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:52:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5FA6F9B61
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:52:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lbQiMxaz;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11982-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11982-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCCA43046D6C
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDD42EC0B0;
	Thu,  2 Jul 2026 15:51:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A53D955D;
	Thu,  2 Jul 2026 15:51:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007483; cv=none; b=SBl1j1e5FflJfD22+l2izaxYW57Q1Gtzbz2ThSdSSw7J3mGy3lmFM3NzO7oCeMYJt9+dpXihanEEPs7rBmUQK72LV7uj4dIpNUHV3ol1a3a5HdH1JlPfDDLwvgrNeDknd/8mwJCv0qDYU0Np6FDAJQokidzja6KqWTblUm/TPws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007483; c=relaxed/simple;
	bh=eF2TKmC7OlpFQF58ktgGbQ3ehjcNlKEA6R/vfZ5rY2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tId1Hb7k6UUSqVwVvpxGC3m3mA3x3zNN3vp5e2CXwIoQbzX2wqq1aXKV3jXoKx6jThLSQROIcSgn4flgn8HIslEpzA8K//3KI+MEysHzWXDZp2RLJAJ9tMC42wl3UEahcgmi9l+bnTaZTc9dRYMP8zeRExa9HmPAMLmRTNCXT50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbQiMxaz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B85E1F000E9;
	Thu,  2 Jul 2026 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007480;
	bh=BGqmxq2YKT75uEs34RuTcEtmv5NEzmCyZjVvAGYL7sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lbQiMxazOvEStfHXVX0RjB3/hJKvru6uz9ayl7ooWC2epwOMrmzYgYomx0eAutIxg
	 DwQfKgeanczazH2uMcqToe3XjLOrFmJiNhxXNgxYF6QNZ7Dm9QX2rijDs5SSoaiqEZ
	 /9eAebNo3WyB3yVWYUIPQ8emltYcsNF7CX6bouJdAxKx1PHvrVV0BtypAkRd2kbrDd
	 m3/sqru0IOMReNgOYhZrsJ4Bj8S3wwb0qZoV4aLcjnqI7VHl5TG5wHdpv66Xpo9Hxn
	 VpxSQGZFG78BtfAoMO+DMCdb44fzvdX/Zi4foFSXARqbnhKZWpacXweROcSGcNqLjR
	 pg5CKFCztwlKQ==
Date: Thu, 2 Jul 2026 16:51:13 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH 09/11] regulator: db8500-prcmu: Remove EPOD regulators
Message-ID: <20260702155113.GW2108533@google.com>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11982-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ulfh@kernel.org,m:broonie@kernel.org,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lee@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.infradead.org,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C5FA6F9B61

On Thu, 18 Jun 2026, Linus Walleij wrote:

> Remove the obsolete DB8500 PRCMU regulator drivers.
> 
> Drop the regulator build hooks now that EPODs are power domains.
> 
> Keep the MFD cell around because a later patch reuses it for a
> small compatibility regulator driver.
> 
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/mfd/db8500-prcmu.c             | 239 +---------------
>  drivers/regulator/Kconfig              |  12 -
>  drivers/regulator/Makefile             |   2 -
>  drivers/regulator/db8500-prcmu.c       | 501 ---------------------------------
>  drivers/regulator/dbx500-prcmu.c       | 155 ----------
>  drivers/regulator/dbx500-prcmu.h       |  55 ----
>  include/linux/regulator/db8500-prcmu.h |  38 ---
>  7 files changed, 1 insertion(+), 1001 deletions(-)

Any deps?

-- 
Lee Jones

