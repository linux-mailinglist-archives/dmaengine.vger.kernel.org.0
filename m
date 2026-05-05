Return-Path: <dmaengine+bounces-10220-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJo2Bwf2+Wk/FgMAu9opvQ
	(envelope-from <dmaengine+bounces-10220-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 15:52:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C5B4CED98
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 15:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B99130463BD
	for <lists+dmaengine@lfdr.de>; Tue,  5 May 2026 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B6647DFB2;
	Tue,  5 May 2026 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dltLJJY9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E84747DD57;
	Tue,  5 May 2026 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989109; cv=none; b=LMr6h0cfPPR/mnQngw9ya0KR+FsPp7lhbywnj24xZsreS9JbF+StuLsoNbLKFi6YYKqRitXpK/TW+w+FqGn0WDTH7Rr8gKhTFsqU+gzyKUEe5F1d3FRhI8YcbHx+HOu7LV6wyR3Aln9FhnEitXut5JJUwS9aBh7Q3ELe1s1e6ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989109; c=relaxed/simple;
	bh=xo5umndcEyLGiWOJhHMf9q3v4XEGsmwU7lViijkWpXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWS0AC3B+NSazl8G/gjS7b4GS5W4138CvKEdWlIjgkSlsSwWCTZhitGehCKhwdXtUqZy6MnY6kUw54lj+2XG6cgDWV75TKzJ59x0/5XkiqzZrX4Tr7AjHKTg1RJmXDsNjWZcQlUKxkRY/m762XmOeRLrSspg/Eh9JZ0OnyLk9eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dltLJJY9; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 48D7D4E42BC9;
	Tue,  5 May 2026 13:51:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EA4576053C;
	Tue,  5 May 2026 13:51:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 47E0411AD0190;
	Tue,  5 May 2026 15:51:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777989105; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xo5umndcEyLGiWOJhHMf9q3v4XEGsmwU7lViijkWpXM=;
	b=dltLJJY95nTFBOjhnhLmFVlYQMKVPbsLzwwbT8GLD4la63Nvrirx7k7dZ/oZHPVo+q4Y4l
	RRg66/ed60XEZZgEIzIgjjHYAepLfvRJxwSPvkyWe/I+hh1F6bspOJDTx4Q8jho8zXoGO4
	GQ1bvcQBpxuud1GES7Eq5/fg9CnWW2NdgOVdMGusW4NQmujr0HkJn3mPbiGiMWF9HBpsUg
	ZrOB10stqv1DjM+1AXWsSzdBjl4vfBRTK16EpxfkwYRZbVa8YPSx2TJ7dKoHqwbYzTy4uO
	WfjJx1k/m4/Ig4XyQ1th9yghakZdGq7cdWMYbUI/hFckfw8eZ6udrbmpoCCYQA==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH RFC 1/2] dmaengine: fsl-edma: Implement
 device_prep_peripheral_dma_vec
Date: Tue, 05 May 2026 15:51:43 +0200
Message-ID: <BXbYyeoYQ824UWckgqlzqQ@bootlin.com>
In-Reply-To: <afjCEG_Do01eVBBO@lizhi-Precision-Tower-5810>
References:
 <20260430-fsl-edma-dyn-sg-v1-0-4e0ecbe2df66@bootlin.com>
 <20260430-fsl-edma-dyn-sg-v1-1-4e0ecbe2df66@bootlin.com>
 <afjCEG_Do01eVBBO@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 87C5B4CED98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10220-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Monday, 4 May 2026 at 17:58:08 CEST, Frank Li wrote:
> On Thu, Apr 30, 2026 at 11:49:32AM +0200, Beno=C3=AEt Monin wrote:
> > Add implementation of .device_prep_peripheral_dma_vec() callback to set=
up
> > a scatter/gather DMA transfer from an array of dma_vec structures. Setup
> > a cyclic transfer if the DMA_PREP_REPEAT flag is set.
> >
> > Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> > ---
>=20
> Please remove RFC for this patch.
>=20
Ok, will do.

Best regards,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




