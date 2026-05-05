Return-Path: <dmaengine+bounces-10221-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEmmCgL2+Wk/FgMAu9opvQ
	(envelope-from <dmaengine+bounces-10221-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 15:52:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B46084CED89
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 15:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 913CD301AF57
	for <lists+dmaengine@lfdr.de>; Tue,  5 May 2026 13:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384BA47DFA8;
	Tue,  5 May 2026 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BBA9h9GV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA29547DD78;
	Tue,  5 May 2026 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989116; cv=none; b=hb6V64kZG4ePRIoMMSHdVUZBORo688TLvSJvOs1hh1kQ9rFS9mSw7V2f7/RyUGRSYXFX0a4vio7GEA7pgpTbrzdGfUjiW3nHrMXnXwpwH6f0b7Y6zzs6NuJbXNEoJptwH/8fiMz0zw8nCvIk5zeEWyr5L9Y3p+aBTYbgC2We3eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989116; c=relaxed/simple;
	bh=nUXR2txkx0LMcLQZYptDj2ePjr3R0uywxYKqIgePB7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M121vD8KX1pR79T/D9QzKIXNhCPhNSdrqWnQ9l7BycWy0lpmhyp5tZr6cf3IzYEtzZ49f/HCnJHK2WeLRrIqtDhUcFMowjj5rIcMuGKWXN6ZQ17qf5iROB/+sFRF0xbB5/P9OT1vWFR3wxfyuK8fw6DKsCVjeGSwOa+BK6vneNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BBA9h9GV; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F0E38C5D739;
	Tue,  5 May 2026 13:52:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 246206053C;
	Tue,  5 May 2026 13:51:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB48C11AD0190;
	Tue,  5 May 2026 15:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777989112; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=V+yXS+YXYcFMGTArzrNiGaHYBdMMST6QBiAWRORJgjc=;
	b=BBA9h9GVp1drtJAwZVzilUsv8E7PLBaHOiUprtI9h4VhKkm198SnQGn9gP8+8djAQsI5fS
	blhGN/NGCZJH3Bagp3McchQSpahPkLG5PcpCErgI0jICLQwjC0TXEuAQiHdCB/j9SVqBzR
	+rzZfX+ijiZ2bPmROieExjoKs8l/i0qRM8sKgAmgU4dQdz92L/v4I1kJKUt0JtUtOuQE9+
	xBNQHsE7SRRiR0fdHbWPjPwuAUGHlTNkBNYXx1qHOb+hYEzyR/9qXq9l+2RlSsfzsxaHfv
	C1OSYb35+cMEQsXEn40ffKJX3It1nni8XGIKQGs9bio6HBjZgmw6UFwnv4CjtQ==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH RFC 2/2] dmaengine: fsl-edma: Support dynamic scatter/gather
 chaining
Date: Tue, 05 May 2026 15:51:51 +0200
Message-ID: <y-kZDXvATLGuBxQOHfCRwA@bootlin.com>
In-Reply-To: <afjDoZbRlKnsNxwe@lizhi-Precision-Tower-5810>
References:
 <20260430-fsl-edma-dyn-sg-v1-0-4e0ecbe2df66@bootlin.com>
 <20260430-fsl-edma-dyn-sg-v1-2-4e0ecbe2df66@bootlin.com>
 <afjDoZbRlKnsNxwe@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: B46084CED89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10221-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Monday, 4 May 2026 at 18:04:49 CEST, Frank Li wrote:
> On Thu, Apr 30, 2026 at 11:49:33AM +0200, Beno=C3=AEt Monin wrote:
> > Implement dynamic linking of scatter/gather transfers to enable
> > chaining multiple DMA descriptors without stopping the channel.
> > This avoids waiting for the channel to go idle if there is another
> > transaction already issued.
> >
> > Add fsl_edma_link_sg() to dynamically link the last TCD of a previously
> > submitted descriptor to the first TCD of a new descriptor by setting
> > the scatter/gather address and the E_SG flag, and keeping the channel
> > active by clearing the DREQ bit.
>=20
> Thank for your trying this, which I want to do long time ago.
>=20
> The key problem is
>=20
>         how to guarratee safe when link to last TCD and DMA is working it?
>         if update last TCD's next pointer before DMA load it, it is good.
>         but, if update last TCD's next pointer after DMA load it. DMA eng=
ine
>         may stop.
>=20
I followed what is described in the dynamic scatter/gather chapter of the
i.MX93 reference manual. We update two registers of the last TCD when
chaining SG transfers, first TCD_DLAST_SGA then TCD_CSR. This gives us
three possibilities of concurrence between CPU writes and eDMA reads.

* First case, both registers are updated before the eDMA reads the TCD, we
  get the expected chaining.
* Second case, both registers are updated too late and the eDMA have already
  read the TCD, we are back to the current implementation. After processing
  the last TCD, the eDMA will disable the channel and the call to
  fsl_edma_xfer_desc() from fsl_edma_tx_chan_handler() will move to the next
  issued descriptor and re-enable the channel.
* Final case, only TCD_DLAST_SGA gets picked up by the eDMA. The eDMA will
  also disable the channel after processing the last TCD, the only differen=
ce
  is that it will update TCD_DADDR by adding the value TCD_DLAST_SGA. Since
  we are not reusing TCD_DADDR, this has no impact.

>         how do you test it? and how much preformance improved?
I did my tests by doing SPI transfers with the LPSPI controllers, doing DMA
transactions with different number of buffers and different buffer sizes.
Without chaining, interruptions on the SPI bus occur between each DMA
transaction. With chaining, the activity on the SPI bus is continuous as
long as DMA transactions are issued before the end of the current
transaction.

Best regards,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




