Return-Path: <dmaengine+bounces-10230-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL55GSZL+2nWYwMAu9opvQ
	(envelope-from <dmaengine+bounces-10230-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 16:07:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E894DBB53
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 16:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C2C69300B2A6
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A82F48033F;
	Wed,  6 May 2026 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E0GFlRfg"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4040547DD5B
	for <dmaengine@vger.kernel.org>; Wed,  6 May 2026 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076107; cv=none; b=KTc2FV10D9fgpzyA7tBvfD0SXxpTEzg79rXSOzho4AUHfww4l7mk/Wkl9gTy9DNsX5JpOfTADX7t6dySQDUEBx/Wt0LSZkh/H4ReAsY5ubncJX0RpIK9jo9mMaW9md9k4dM6CKM3wS74DQlyqO7wNqhc4uKAkz14mUJeYPS7W04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076107; c=relaxed/simple;
	bh=pw5M7wHyJF7qGE8EOkabTS3y0p6s5JDD1IostcxlSv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j47fC1VBeIAout3Ohc/zv9ypmu0irK51iw0pPVaU66GT0yFpAUPTilmtKh7eNB8FHx0Git6KGqdD2I4ep3ZntOgfpomloOea0dCufKei0HMurXJvlHYO9f7qkvp2fKxkM7nJz+KqHArq2S6tenRyU/t8tHOAfjMxnaLN2H86rVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E0GFlRfg; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EC98CC5DC4B;
	Wed,  6 May 2026 14:02:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A74CE6053C;
	Wed,  6 May 2026 14:01:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6FB89107F1B59;
	Wed,  6 May 2026 16:01:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778076100; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8VpBetH3FnMFpP2ml6zi3fZvsO0QOprxF497sdCPnpM=;
	b=E0GFlRfgdvdfui6wsFff2FGJz4F3OVteevBzZRDss8yVpWUh1wped7N0f7uVaAupIDnbr4
	8Mc88MlkQGntEj0sowal1DfNFSuHRORrCiGp0D6wyHk74AFoNTZ6EC1yuRUgAZSkbQFp8C
	K1NZSsKqPIU2q2hTksznzNHzCCsCWzHFcYiDrCNjxJbPSDWrM+VDAvpRoOqmwDkP6J2UVE
	6WLKHN7x1Tg2KfFQ4ReQIDwvC7OSi8HG5/Aj3YOUfyXWJIxkQuB6N7t2BO3Ohe1potTaQd
	YAbscpQGxaiFP/fje6S6tflDZ84gnB0hdVsfOXjnr5T3lL/vr9d2+Q2xCgZ0rw==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH RFC 2/2] dmaengine: fsl-edma: Support dynamic scatter/gather
 chaining
Date: Wed, 06 May 2026 16:01:37 +0200
Message-ID: <43uRGEDfSHihWPAxby2EOg@bootlin.com>
In-Reply-To: <afoHxJM-s846s6EG@lizhi-Precision-Tower-5810>
References:
 <20260430-fsl-edma-dyn-sg-v1-0-4e0ecbe2df66@bootlin.com>
 <y-kZDXvATLGuBxQOHfCRwA@bootlin.com>
 <afoHxJM-s846s6EG@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 53E894DBB53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10230-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]

On Tuesday, 5 May 2026 at 17:07:48 CEST, Frank Li wrote:
> > >         how do you test it? and how much preformance improved?
> > I did my tests by doing SPI transfers with the LPSPI controllers, doing=
 DMA
> > transactions with different number of buffers and different buffer size=
s.
> > Without chaining, interruptions on the SPI bus occur between each DMA
> > transaction. With chaining, the activity on the SPI bus is continuous as
> > long as DMA transactions are issued before the end of the current
> > transaction.
>=20
> Does SPI support issue new transfers without wait for previous transfer
> complete, or SPI transfer already support async queue?
>=20
This is done with a local version of fsl-lpspi driver adding a simple
offload support by borrowing the DMA channels allocated to the SPI
controller. I can then issue multiple DMA transactions with the dma_buf API
of the IIO subsystem and trigger SG chaining.

Best regards,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




