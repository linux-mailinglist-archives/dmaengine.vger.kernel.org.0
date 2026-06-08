Return-Path: <dmaengine+bounces-11306-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2M/XEvexJmoqbQIAu9opvQ
	(envelope-from <dmaengine+bounces-11306-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:13:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD70F656035
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:13:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="lJCC/7YE";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11306-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11306-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C3E13021E76
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 12:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B716033D6D7;
	Mon,  8 Jun 2026 12:09:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96081E5B63;
	Mon,  8 Jun 2026 12:09:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920568; cv=none; b=LfEla5zAN6PnzJDI/l5F95xMML5Z/lJDD56rXrmnrArPOvN/EgT4UQBzBiTA3SwZ/+cRB/J3LNv9Gtm0NCl4VhtdCtyW4pbvW6ShcNOFs+UpUAJOI07BBIXcXl6JHL+JCl527rS8+ZyKu4k9b1DannvdnTWlxVGlhZDVoC6bH8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920568; c=relaxed/simple;
	bh=afFlbiE1PJ1WlaaiaJEYNVfsDX6QYlh7ghKtTCuesgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1ia6wurT3JE3ka08lSEW+aBMMmlpejf6fRkC1jy+sEP0ejimEfzp8Ti6VXECeAkWBEwuYyuJLpQAjpdmeml2cs0F7z2a+qOYXyCbu1703tmBME4G9N2EG0EaphHRzhXOM+yXq1JeqhT7n2XgdN1ZpNSBCM46QheSRaetBLtf1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJCC/7YE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66961F00893;
	Mon,  8 Jun 2026 12:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780920567;
	bh=ZpiDNYSzBKDsaWbTBujoPCwlcdcM+NFdKmVE3hxzxeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lJCC/7YE41aeB5clAPeyVTZk3YLMVU80Z1V9qVIoHxt/2jE9jDRZzi1AJoDaK/ir0
	 z15VqiP2oUSSZUZHHsCRLMC6ySZXrcRtd8fS/ZYFFPIcarqSlrKI942f9LrO6GYrb9
	 U6x8eH/UbJNwrXnjSuguPi+0iR8yy+vk0lzCInPpH6VYbtIPgymTL609+9/hTn/Az5
	 5by8i8H86uhm7vRsYSNTGdJgjXG0qVGDPAP3S172oQayraAiO2WZDT9geFQAelUBoe
	 xHdW8OGgsxCwDGTU1MTKg9P1dEgHJk4KQozUExwmuNzXmfj8PV6Ahp/fy5uEdSQiLv
	 QxWYuvBjpgIcg==
Date: Mon, 8 Jun 2026 17:39:23 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: linux-kernel@vger.kernel.org, Frank.Li@kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v1] include: Remove unused dma-iop32x.h
Message-ID: <aiaw87jYQRnYivUA@vaman>
References: <20260605073952.840988-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605073952.840988-1-costa.shul@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11306-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:costa.shul@redhat.com,m:linux-kernel@vger.kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vaman:mid,mleia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD70F656035

On 05-06-26, 10:39, Costa Shulyupin wrote:
> The IOP32X platform was removed in commit b91a69d162aa
> ("ARM: iop32x: remove the platform") and its DMA driver in
> commit cd0ab43ec91a ("dmaengine: remove iop-adma driver").
> No file includes this header.

Thanks for the patch. This is same as [1], which I have applied
So dropping this

[1]: 20260114051508.3908807-1-vz@mleia.com

-- 
~Vinod

