Return-Path: <dmaengine+bounces-11618-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r2CjFVrBM2o2FwYAu9opvQ
	(envelope-from <dmaengine+bounces-11618-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 11:58:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DF869F0B4
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 11:58:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=emRJWnyk;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11618-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11618-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B76F303BB24
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 09:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5670F3E075C;
	Thu, 18 Jun 2026 09:51:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF173E6396
	for <dmaengine@vger.kernel.org>; Thu, 18 Jun 2026 09:51:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776273; cv=none; b=oiCY0v04DqfUDtWWhWMD7SNeoIwx5wcy0pEUZa+yJtfKeTJe59o2FDxW1I3kefLTy/xF8Ke29slgmDILb5demUCmeRBym/4HnizOI0LtM2JnEP/MRgopBk3bHXH9JS6Cv1pfQKuGzPai7tNjjcCy2zGTaewiqw/F7vP9xLfKZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776273; c=relaxed/simple;
	bh=kUi4B1sAC6SRtLE8mYC5fWq+3M+CfSyLXU8aNlVeBxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qytx3tZs9OdPOE9aQuFJ7xEy6mdqM4ZoxIdsKoBvOeKajpUF9GNETJ65Ziyvy46IW+rIpbBrsZGxX8TCy6MzF6XedSglC44DKPe78bYNn6FQI0sJQQiNtMMDtZoBNC5baD4+ftsUuQxiXhF08/c+sFepQpZBJHx0mrzT5fuKnOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=emRJWnyk; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3085EC06CC8;
	Thu, 18 Jun 2026 09:51:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A80505FF03;
	Thu, 18 Jun 2026 09:51:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C91E106C888E;
	Thu, 18 Jun 2026 11:51:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781776267; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=W6xJzhq3eQ/1H8oHvoBYc8KIhlbLCwKv1mLFAll1qjs=;
	b=emRJWnykeDSuP1Wptma20OiUQCWd8ohdbN2DaEJ1THnFKmpKMSTDUmLHfRxjjNpc0hyWa1
	QloUJLZ6rmVSTHyuq1hSOE8XJpamQUjMZgbig8oYUR4VKdZ+9CYmcz2pdc3Tv7HxjZheSs
	fFyQUU+Mvy4D1Br6OMhcg9iErAmspJZq4F/cRGWd97Jr/c/1EnUv8b7/Azt1ExIYxR9f+f
	2OLKsY2VcjH15kPRZaBdQsYixmTaHBizWWegavfNNdZyDHvVfy2kUkHmkdFrsODgPBirTA
	E/FNE4nNTKp4iiuSmeeyTx/l3zeS7TKHdtzB/EMi9gTJMnyx5iiLo4ouszANdg==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v4 2/2] dmaengine: fsl-edma: Support dynamic scatter/gather
 chaining
Date: Thu, 18 Jun 2026 11:49:06 +0200
Message-ID: <8kDwWenCRx-QFWAJA2KyZQ@bootlin.com>
In-Reply-To: <aiH1qDT5yoanBE_2@lizhi-Precision-Tower-5810>
References:
 <20260518-fsl-edma-dyn-sg-v4-0-8ce7d95b1ce9@bootlin.com>
 <20260518-fsl-edma-dyn-sg-v4-2-8ce7d95b1ce9@bootlin.com>
 <aiH1qDT5yoanBE_2@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11618-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@nxp.com,m:vkoul@kernel.org,m:thomas.petazzoni@bootlin.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:url,bootlin.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4DF869F0B4

On Friday, 5 June 2026 at 00:01:13 CEST, Frank Li wrote:
> On Mon, May 18, 2026 at 02:36:45PM +0200, Beno=C3=AEt Monin wrote:
[...]
> > +static void fsl_edma_link_sg(struct fsl_edma_chan *fsl_chan, struct fs=
l_edma_desc *fsl_desc)
> > +{
> > +	u32 flags =3D fsl_edma_drvflags(fsl_chan);
> > +	struct fsl_edma_hw_tcd *last_tcd;
> > +	struct fsl_edma_desc *prev_desc;
> > +	struct virt_dma_desc *vdesc;
> > +	u16 csr;
> > +
> > +	lockdep_assert_held(&fsl_chan->vchan.lock);
> > +
> > +	if (!(flags & FSL_EDMA_DRV_SPLIT_REG))
> > +		return;
> > +
> > +	vdesc =3D list_last_entry_or_null(&fsl_chan->vchan.desc_submitted,
> > +					struct virt_dma_desc, node);
> > +	if (!vdesc)
> > +		vdesc =3D list_last_entry_or_null(&fsl_chan->vchan.desc_issued,
> > +						struct virt_dma_desc, node);
> > +	if (!vdesc)
> > +		return;
> > +
> > +	prev_desc =3D to_fsl_edma_desc(vdesc);
> > +	last_tcd =3D prev_desc->tcd[prev_desc->n_tcds - 1].vtcd;
> > +
> > +	csr =3D fsl_edma_get_tcd_to_cpu(fsl_chan, last_tcd, csr);
> > +	if (!(csr & EDMA_TCD_CSR_D_REQ))
> > +		return;
> > +
> > +	fsl_edma_set_tcd_to_le(fsl_chan, last_tcd, fsl_desc->tcd[0].ptcd, dla=
st_sga);
> > +
> > +	csr &=3D ~EDMA_TCD_CSR_D_REQ;
> > +	csr |=3D EDMA_TCD_CSR_E_SG;
>=20
> suppose here need dma_wmb() to make sure dlast_sga happen before csr.
>=20
Yes, I will add it.

> I remember ask dma risk condition problem, but I forget detail.
>=20
>  TCD1
>  TCD2
>  TCD3 (last one),
>=20
> If DMAengine already load TCD3 to register and moving data,
>=20
> You update TCD3's dlast_sga? Does DMA engine fetch again TCD3 to get
> updated dlast_sga?
>=20
If the DMAengine already fetched TCD3 from the main memory, then the changes
done to dlast_sga and csr in memory will be ignored. In that case, we are
back to the current operation. After handling TCD3, the DMAengine will
raise the end-of-transfer interrupt, the channel will be set to
DMA_COMPLETE, then the call to fsl_edma_xfer_desc() will re-enable the
channel with the next issued descriptor.

Best regards,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




