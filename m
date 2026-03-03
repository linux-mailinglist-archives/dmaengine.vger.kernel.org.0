Return-Path: <dmaengine+bounces-9224-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKzaDm1Dp2kNgAAAu9opvQ
	(envelope-from <dmaengine+bounces-9224-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 21:24:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A19F1F6C10
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 21:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8BC230ECBDC
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 20:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4823C375F8D;
	Tue,  3 Mar 2026 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="n1CNVCXE"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE935D5FC;
	Tue,  3 Mar 2026 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569189; cv=none; b=bgcxx29iRRY6MpDiSGEk6IgCp+djbFGtp1V1OkdlNmKzEtT+1BW8ciqfmPueqI107pDTrutyq8XBBoywzopvAda3I24AZuaUyHDTRcfPjgLokx4M8tV/WZRzixdiX0gyjcnLt/dZqYSgfryPa7G/IGLnbR7APb/kYd7rLDz0sos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569189; c=relaxed/simple;
	bh=h5MeTRsQDTUiaWKOieV+NG2xHrk8f+TiRkqVKiT4Bdg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=Vn+WiLB5dyjcldEVs0qjOdUl2+3n7jOLOpJQttwRXXDA7UO4NKN3/NpE+yE6WO1Ahs9KR1vJl99WlAhrRaXWcGxDWnhf3Quv7jo+FTXIcD76ZXuIk02LWOcRfR8NizK+r1VDqlGC0wy7CKdimPLUYvQ9XhO3CB2D4iVN1m2Yy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=n1CNVCXE; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:Subject:To:
	From:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pF6V3B1qOpozco2GfEBhVD0JBZUNTaUDHRIurlyzIcE=; b=n1CNVCXEbTzgH8p0H2lMQsL+tC
	8dEHAF5YG21JDl7D80YMj9DZY9KFWy1AKJstoXtfsVi6584VUUq0RIZ2zmSQSdw8ajjbZEqKG1sHX
	1lvd/dFNNJ3yON2aCBTWNQe5AMpZeF6joZe5WTOzsanXr4R4GzvSW2ennRbAgURv6Rptx0WGGOwQ0
	4xClT5Z5Zh+yA05yT0x46u+10bfsIX41bMdikX5VzZR73mwiVrUeQzT/HokLIcwAM/2l2gC3zQ6yc
	RpGDWQ9zIozoHqnhy2/kgvdxOqlbzkR08kp840FrzxwqENVZkO5PQI40ONTHSFoRUFQHCF043UEMl
	k2M/8SAw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vxWDS-0005V6-1a;
	Tue, 03 Mar 2026 21:19:38 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vxWDR-0002Qu-24;
	Tue, 03 Mar 2026 21:19:37 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Mar 2026 20:19:35 +0000
Message-Id: <DGTFBXGJDU7C.3KAUWCSCGQFR2@folker-schwesinger.de>
Cc: "Rahul Navale" <rahul.navale@ifm.com>, <dmaengine@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
 <suraj.gupta2@amd.com>, <thomas.gessler@brueckmann-gmbh.de>,
 <radhey.shyam.pandey@amd.com>, <tomi.valkeinen@ideasonboard.com>,
 <marex@nabladev.com>, <marex@denx.de>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Rahul Navale" <rahulnavale04@gmail.com>
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction
 reporting via device_caps
X-Mailer: aerc 0.21.0-119-g0a449d4a7ff3
References: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
 <20260302072433.5091-1-rahulnavale04@gmail.com>
 <DGTF4AVSQZBJ.184UEIYAHWGMW@folker-schwesinger.de>
In-Reply-To: <DGTF4AVSQZBJ.184UEIYAHWGMW@folker-schwesinger.de>
X-Virus-Scanned: Clear (ClamAV 1.4.3/27929/Tue Mar  3 08:24:19 2026)
X-Rspamd-Queue-Id: 8A19F1F6C10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[folker-schwesinger.de,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[folker-schwesinger.de:s=default2212];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9224-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[folker-schwesinger.de:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@folker-schwesinger.de,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue Mar 3, 2026 at 9:09 PM CET, Folker Schwesinger wrote:
> So I think it's reasonable to assume that either (1) the change in
> return value of dma_get_slave_caps() causes different behaviour in the
> callers (possibly [2][3]; needs verification) or that (2) dma_slave_caps
> *caps, whose fields now get populated in dma_get_slave_caps() cause
> different behavior in downstream users of said caps.
>
> For the next debugging step I suggest that we focus on (2) but also on
> getting some insight into the callers. Could you please reapply
> 7e01511443c3, keep the RFC patch in place...

To quickly test theory (2), you could then comment out the caps->
assignments in dma_get_slave_caps() and check if this fixes your issue
or not.

<-->8-->

diff --git i/drivers/dma/dmaengine.c w/drivers/dma/dmaengine.c
index ca13cd39330b..91c5d7abb028 100644
--- i/drivers/dma/dmaengine.c
+++ w/drivers/dma/dmaengine.c
@@ -592,6 +592,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dm=
a_slave_caps *caps)
 	if (!device->directions)
 		return -ENXIO;

+	/*
 	caps->src_addr_widths =3D device->src_addr_widths;
 	caps->dst_addr_widths =3D device->dst_addr_widths;
 	caps->directions =3D device->directions;
@@ -603,6 +604,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dm=
a_slave_caps *caps)
 	caps->cmd_pause =3D !!device->device_pause;
 	caps->cmd_resume =3D !!device->device_resume;
 	caps->cmd_terminate =3D !!device->device_terminate_all;
+	*/

 	/*
 	 * DMA engine device might be configured with non-uniformly

<--8<-->

