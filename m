Return-Path: <dmaengine+bounces-10416-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LHlCOmNBGoVLgIAu9opvQ
	(envelope-from <dmaengine+bounces-10416-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 16:42:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9481653553F
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 16:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E711342999B
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 13:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF7742E01D;
	Wed, 13 May 2026 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjVu/Ru1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA3357A3E;
	Wed, 13 May 2026 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679116; cv=none; b=ieOxhUZSHv7wGrZMv1iupo1saoJc4kahWbmyGTnfHQrO9n6rnNXcuGoG+V7uKTnX19HD3FmNaWdom96HaLpRzzXVSQWWlrQg22U0jVDO84ZGGxd9meX80Wz/gMnOfuPZuKkiJJbNWN99qe9Cwd/lxg57DOIEdpBXDolr/QgFnC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679116; c=relaxed/simple;
	bh=xarcToYSD8OZNTRk5cuihVSaWuEjfYe3mjW1TtprUC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qug9z/O7p//9P1aGKMKlzJrmRHH0GF1G+hwgf1GO4fwslRV2IlNvXyq0FqhdtAFdZeEKWJ3qGaaWknLDNPwID7gBAuTyDL5ccM4rWYqQDf+r++lHDQgswWFTTZYyjN7qinkwSEx7zSA2NR4Mc4pZJsU1oQI008edNnLBGPMTAsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjVu/Ru1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0A3C2BCB7;
	Wed, 13 May 2026 13:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778679115;
	bh=xarcToYSD8OZNTRk5cuihVSaWuEjfYe3mjW1TtprUC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HjVu/Ru1ld6VYiNkdtbZ6GWVmp2w2RQn1zci8vHfFKGf25Zlrv4QJY0t5ZCkFeHJl
	 biHLJjhVXeX/QQgzruoI92s2bc1TFMBMPnhe8aGdjM7DgBwlHpjLkxCLonoH6jDlGk
	 NF9I8tJIjbSnLraIhzaSCCyIu7LPa3lA0j75Kl28hJEFiQJxbPVKh+bFmgbjdhgKWY
	 /zC1CWFpIpcuwEzpEtQWdYIcXc8DJe+YflfxMb8UQnS8O1liskd14nQPUNXP07zuzj
	 pQQGL096ZEcr4H66zssqRgnU5EIJ8lHG7UTg8qyaYayIoIhIGt0cEgnhxw3ao67cJ5
	 RVM9hHir6v97g==
Message-ID: <f9aa583c-37f3-4b64-983d-11c7b15caf43@kernel.org>
Date: Wed, 13 May 2026 16:31:49 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/17] dmaengine: sh: rz-dmac: Fix incorrect NULL check
 on list_first_entry()
To: Frank Li <Frank.li@nxp.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 p.zabel@pengutronix.de, geert+renesas@glider.be,
 fabrizio.castro.jz@renesas.com, kuninori.morimoto.gx@renesas.com,
 long.luu.ur@renesas.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-3-claudiu.beznea.uj@bp.renesas.com>
 <agOPL-rdfePlvOtm@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <agOPL-rdfePlvOtm@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9481653553F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10416-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi, Frank,

On 5/12/26 23:35, Frank Li wrote:
> On Tue, May 12, 2026 at 03:12:03PM +0300, Claudiu Beznea wrote:
>> The list passed as argument to list_first_entry() is expected to be not
>> empty.
> 
> Little confused,
> 
> #define list_first_entry_or_null(ptr, type, member) ({ \
> 	struct list_head *head__ = (ptr); \
> 	struct list_head *pos__ = READ_ONCE(head__->next); \
> 	pos__ != head__ ? list_entry(pos__, type, member) : NULL; \
> })
> 
> 
> both list passed to list_first_entry() or list_first_entry_or_null() must
> be not NULL.

The intention was to to express that checking the pointer returned by 
list_first_entry() may lead to problems. I'll adjust the description to be more 
clear.

-- 
Thank you,
Claudiu


