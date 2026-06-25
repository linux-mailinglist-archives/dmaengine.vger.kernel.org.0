Return-Path: <dmaengine+bounces-11780-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pyCrFHD0PGrYuwgAu9opvQ
	(envelope-from <dmaengine+bounces-11780-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:27:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C606C4360
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:27:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eRsvbs1d;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11780-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11780-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BF44315917E
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 09:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AEE380FC4;
	Thu, 25 Jun 2026 09:20:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D943803FD;
	Thu, 25 Jun 2026 09:20:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379240; cv=none; b=XlHKOkRT9B9I8TNOZCDzXaQxQzmDhP4m9VUyziVIHahojDM8cfH+mfOCLSIN5wF4QoRo2jMZINL7Wzaow7MyMGFYeeDYvBRc73CKQ2gCAuzjcwzK7N/Ak1GTMYfi/MLExRJtvG7vkv7Hp/plhkETym5WcDhdToCv3HEVMPsyF4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379240; c=relaxed/simple;
	bh=NnkG0LvREYMOjpL9Cyd2P83GELQnlTFtH+tWfVG7cI0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TiSgtbmi1mrvqpPTmv1PVfgx7mRfTPRvxvYOUCm1ba1SmtJ4cDt6OWe5v5Rj1svBPedXqSwz7zm06Et6J58IRejFhh0sgDFjiklrCV1koXu9yKMILV7yixdtFzEz4oTE8bIiMA/pikEC7gI6231jOGeNRm3O3rxImUniD+HnoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRsvbs1d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEF71F00A3A;
	Thu, 25 Jun 2026 09:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782379239;
	bh=ZmtqwaEfrCM1u9fWEVQASF5DOPAFCjKZpojpUgoJkzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eRsvbs1dokLAI2sGi8rf4XCSASXeuTYoPDltekiccRYc7qP/8IWRE0Y8B+K91LXH4
	 4ubFNi1l5/GuM+y8M+slpKc5qOdLOr3nxClmggJ5dCxNZaMHH9n6w+VvyeDTR7kKu8
	 b8l71La/DVX5gh/GX/7KLdVlCFXTG+K4E+47Veg+STrsflVmE7A4zj88nVtNIRUF0z
	 leTL/WPnWLrfalvE0tFI3QCqSp9C3i6/QdFpiM548E7RXqemHAa6SOEjOzGriHB14D
	 2vnNjCyvdat7UGBNtkvivpCnwZcui2MW052wQGnbmXHAXX1indXGFTb3VYTQNXcbyr
	 nzIBNR2R90Qrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] dmaengine: fsl-edma: Add FSL_EDMA_DRV_MCF flag
 for ColdFire eDMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jean-Michel Hautbois" <jeanmichel.hautbois@yoseli.org>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260625-b4-edma-dmaengine-v3-2-44be00ace37d@yoseli.org>
References: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
 <20260625-b4-edma-dmaengine-v3-2-44be00ace37d@yoseli.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 09:20:38 +0000
Message-Id: <20260625092038.ADEF71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11780-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yoseli.org:email,sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jeanmichel.hautbois@yoseli.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98C606C4360

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch correctly bypasses the XOR byte-lane adjustment for 8-bi=
t registers on MCF eDMA via the FSL_EDMA_DRV_MCF flag, but fails to apply t=
he same bypass for 16-bit registers written via edma_writew(). This will co=
rrupt TCD 16-bit register writes on ColdFire platforms.
--

commit e23a155133dba0ca56d6eea575c63bb35a8ef9ab
Author: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

dmaengine: fsl-edma: Add FSL_EDMA_DRV_MCF flag for ColdFire eDMA

This commit adds a new flag FSL_EDMA_DRV_MCF for the ColdFire eDMA driver to
bypass the XOR byte-lane adjustment for 8-bit registers, ensuring writes
target the correct documented addresses.

> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index abc8f78055156..64b5375272917 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h

[ ... ]

> @@ -419,7 +421,8 @@ static inline void edma_writeb(struct fsl_edma_engine=
 *edma,
>  			       u8 val, void __iomem *addr)
>  {
>  	/* swap the reg offset for these in big-endian mode */
> -	if (edma->big_endian)
> +	/* MCF eDMA has different register layout, no XOR needed */
> +	if (edma->big_endian && !(edma->drvdata->flags & FSL_EDMA_DRV_MCF))
>  		iowrite8(val, (void __iomem *)((unsigned long)addr ^ 0x3));
>  	else
>  		iowrite8(val, addr);

[Severity: High]
This isn't a bug introduced by this patch, but should edma_writew() be upda=
ted
to bypass the address adjustment as well?

Looking at edma_writew() right below this function, it performs 16-bit writ=
es
and unconditionally applies the ^ 0x2 XOR offset adjustment for big-endian
controllers:

drivers/dma/fsl-edma-common.h:edma_writew() {
	/* swap the reg offset for these in big-endian mode */
	if (edma->big_endian)
		iowrite16be(val, (void __iomem *)((unsigned long)addr ^ 0x2));
    ...
}

Without checking FSL_EDMA_DRV_MCF here, wouldn't writing 16-bit TCD registe=
rs
on native ColdFire platforms still apply the ^ 0x2 offset and incorrectly s=
wap
registers like soff and attr?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-b4-edma-dm=
aengine-v3-0-44be00ace37d@yoseli.org?part=3D2

