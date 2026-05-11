Return-Path: <dmaengine+bounces-10290-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNr1DZKKAWpJcwEAu9opvQ
	(envelope-from <dmaengine+bounces-10290-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 09:51:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EF7509980
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 09:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEEC93017EC3
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 07:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176FA3AC0CB;
	Mon, 11 May 2026 07:49:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E373A75BB;
	Mon, 11 May 2026 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485775; cv=none; b=FdvLCYAprjSKQHT1xKu1H2bFY7tvbktB9zTiuh04HppB9ylmt5g6GtshWWqC5GyR3JCGJkt9YH/TZ+j81lUXmB60Sg7p0qgLBqEawkhQUAPtBwZ8tkpqvwZBoMRsElkDZuUTAvM1X+PAOFTopTz6jW2a9SIhvJCOG1HIzjx3Bzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485775; c=relaxed/simple;
	bh=COnxLTpBeRtTxJE5SWfa9e45j7zx7qoLFKcZuOauqbk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dL/CNxQE5YL9PKZTtQv3MUn0YnG5UvC45XZbTJmg40PsdYLgT5uaeUKVpG0qRUlw44uGm2QGzef7S009gUvxbB98lCv3FHOvwsGXVRq+uG14FZVT3STNDsY2dBhgSijzZKnIXp1i69npwo06Y8MKZydV1Cr+RH8PwZE5SWSfo5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D594CC2BCB0;
	Mon, 11 May 2026 07:49:29 +0000 (UTC)
Message-ID: <895036f1-259d-412c-9272-666ceb4fa226@tuxon.dev>
Date: Mon, 11 May 2026 10:49:27 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sashiko.dev review (Re: [PATCH v4 13/17] dmaengine: sh: rz-dmac:
 Add cyclic DMA support)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 p.zabel@pengutronix.de, geert+renesas@glider.be,
 fabrizio.castro.jz@renesas.com, long.luu.ur@renesas.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
 <20260411114303.2814115-14-claudiu.beznea.uj@bp.renesas.com>
 <047007f9-d5cc-401a-846a-ab13ad0380b6@tuxon.dev>
Content-Language: en-US
In-Reply-To: <047007f9-d5cc-401a-846a-ab13ad0380b6@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D9EF7509980
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10290-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[tuxon.dev];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.941];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 4/20/26 15:51, Claudiu Beznea wrote:
> 
>  > Also, because the lock is dropped when exiting the scoped_guard before
>  > vchan_tx_prep() is called, a concurrent terminate_all() could potentially
>  > clear the flag before the descriptor is queued.
>  > Could the driver rely on the desc->type field instead of a global state
>  > flag to identify cyclic transfers?
> 
> I'm going to explore that but I think this will complicates the code further.

As the channel can only accept a single cyclic transfer enqueued and no other 
types of transfers (since the HW cannot handle mixed cyclic and non-cyclic 
transfers), the exact scenario described above can only happen if the user of 
this channel terminates the cyclic transfer before it even prepared it. I don't 
think that is a valid case.

Thank you,
Claudiu

