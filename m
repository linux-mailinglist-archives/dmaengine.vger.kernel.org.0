Return-Path: <dmaengine+bounces-10417-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAD/FG+EBGqILAIAu9opvQ
	(envelope-from <dmaengine+bounces-10417-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 16:02:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3192153499B
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 16:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8DE430FC95D
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADB443E4BC;
	Wed, 13 May 2026 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDOmQsaJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D707C43DA42;
	Wed, 13 May 2026 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679208; cv=none; b=MdNd/H6jCJYPpDHSocbQD7FvXu2h4eKSQ4dy+ck6dEWjY/7z/FIRXNS8yGcZrTKRvPVxUlFApt2sg6F+TWcET8ocrSSoNXqheQiDdJyb2khopIm8nTLWPsSsp+kfouXbCweDi2pkrT6rK/3Ddn0Vv9LNjjrS6Lf9bxOMM4F8L0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679208; c=relaxed/simple;
	bh=1bcPFAQzLxvgGxJikLGUECoa3w1UKQaIQQrTukoaIuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GvTD5mAyUu+/lHKbXrbuwJNxOwS5vS8LQaQPWa7guKu60/viDDmodgYBTErR9jUZvUnOoja4YRQmeEAfZIFlQk3S+wmPIfZP+7TXNdNAO2THf4nQLtZ6JyPlOtArCr+NZaQ4z1Zyba28ccRYwyAEqWYMrHaz0DTc25bdTKFmaGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDOmQsaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D36C2BCB8;
	Wed, 13 May 2026 13:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778679208;
	bh=1bcPFAQzLxvgGxJikLGUECoa3w1UKQaIQQrTukoaIuQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XDOmQsaJ9yr0MB04y52uLja4tKYzI4Chkx8w4RixC/E8y8gQNnwsfr4evL8Ps+gVH
	 Ft8SDOecC2ndLFLuHYd4uodd47zotckWDwZ5Ds9KLXoRYAbqsT0x9W6PbPrYORrPbn
	 3T8UFVBATKGIfbmFyLBjguJ4t2t4P1qXB+bQa0emtOXrfyc5tzilcquARFhxjJKCxX
	 ic17hFZefKUDk04rBW8OknQTGR7R34NUeIAIvlcieBmHJlKocKcVElkzgNt01HivFV
	 jFOicKsdEjYnLvj3vo4PK8Tuk3LsbajG0Ai/DyqvsO218VLRhNH41MGdz9DGncq0Zv
	 i6W2u+MJd0ARw==
Message-ID: <6de7d96b-32a4-4d99-9dc4-9c9341c0e257@kernel.org>
Date: Wed, 13 May 2026 16:33:19 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/17] dmaengine: sh: rz-dmac: Save the start LM
 descriptor
To: Frank Li <Frank.li@nxp.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 p.zabel@pengutronix.de, geert+renesas@glider.be,
 fabrizio.castro.jz@renesas.com, kuninori.morimoto.gx@renesas.com,
 long.luu.ur@renesas.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-7-claudiu.beznea.uj@bp.renesas.com>
 <agOSGoaNXKfV_pFV@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <agOSGoaNXKfV_pFV@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3192153499B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10417-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[bootlin.com:query timed out];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Action: no action

Hi, Frank,

On 5/12/26 23:48, Frank Li wrote:
> On Tue, May 12, 2026 at 03:12:07PM +0300, Claudiu Beznea wrote:
>> Save the start LM descriptor to avoid looping through the entire
> 
> where the looping you try to avoid?

Here: https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/dma/sh/rz-dmac.c#L701

The point was to avoid starting from the head pointer and use directly the 
descriptor of interests:

-static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel, 
u32 crla)
+static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel,
+						 struct rz_dmac_desc *desc, u32 crla)
  {
-	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
+	struct rz_lmdesc *lmdesc = desc->start_lmdesc;

Maybe "loop" was not the right word to use in the patch description. I'll adjust it.

-- 
Thank you,
Claudiu


