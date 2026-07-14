Return-Path: <dmaengine+bounces-12505-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EKmWE4pdVmqB4AAAu9opvQ
	(envelope-from <dmaengine+bounces-12505-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 18:02:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 065C4756C2F
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 18:02:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=wB7t0Irq;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12505-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12505-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5042312D6EB
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E60496918;
	Tue, 14 Jul 2026 15:58:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65411496911;
	Tue, 14 Jul 2026 15:58:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044731; cv=none; b=Bxo2/yaTAHYbSoaHJxDqgkXXUyVYDwgBugY9tbHzQ7T7NKyLpikqRgu2lYCc8aUc+DWV1Sk/3DAJ7UVy8o5myrLnIJgXegS2QGpYg4WTPyyLgErn/XH0BdOL5p2DC0z/TDkeprdmPtVSJFdiAjQiVOzgIPZwhpAJHPp1K7kFtV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044731; c=relaxed/simple;
	bh=SaOIwxsJUpe4oQ4ukvfVFMjq6Snu0MdRnzBtitry7ls=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=TMKGDbg6puq//UwSnAvG2sp/HcjMrVLvub1OBvu7DErZ7j3dCYZ8NQyCMIvx++jmLlsuho6aF3FQ8LsmDalbPLFUMu+xkmTRg4VPjW0UhrjZAYl4jMZ/zgYnmq2cfayvlDLfq+sMLsntv5gdYOXb3rIL+jg5gDc0dVYmOLt+X7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wB7t0Irq; arc=none smtp.client-ip=212.227.17.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784044714; x=1784649514; i=markus.elfring@web.de;
	bh=gYySRZk50YZ8kV/Fk2MDuMRiQ+24X2HjFtHZZlE+UCI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wB7t0IrqYZV0duibmAP4pJ1p8rr4VhsmI08YOWGUX6ySrAwhiTEGxNY0oe/5cfqh
	 N5pjeehGD2KINk3jf9QdweoSEMjij5NXn5IMSvU+COfK6ymcQwzYSt+WzDuZQ30tp
	 pjSEMFOQohMC/QvZV435hWFdDAog0F04hgwoSsce8Jce1tYSNAvLORi0FWmUR9yah
	 T6XVf4EnLnGZGdJx2J/e8VZOOTgUK/YXHiT6xFs5LoC85tJcpBEvImrvbySgOWzv2
	 grclLtLM16og1Cdnd+51iDwqjmhiYjCUdS4DP4pCkvnYFsuPW614Mq8MNTBHMPz1J
	 ia3Z7VDk9f2lRDMLgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNfU1-1wPVJZ1l6p-00Q8hq; Tue, 14
 Jul 2026 17:58:34 +0200
Message-ID: <544a88f9-d523-4add-af0b-93337de4556c@web.de>
Date: Tue, 14 Jul 2026 17:58:32 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Griffin Kroah-Hartman <griffin@kroah.com>
Cc: stable@kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <178403257631.822807.3647660559296965382.b4-ty@kernel.org>
Subject: Re: [PATCH] dmaengine: fl1-edma: Add error handling for
 devm_kasprintf
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <178403257631.822807.3647660559296965382.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XGBQVvPVq7sjL2Ik4CUC/GdxNA373af84b/248ovYCZiXxCXUhY
 +SvQdfOfNrF29VjDGNx4eJORPoT9xnbtCuN0rTapjje4+4hdnES2s8g7cK1zFuAVvuRJsV0
 lTwgZmkcH0Qak0GSiPY/j3p54Z5FqnPxVloH8dem5udV5zTT3j6xQ8daraNa7G4csfEdWau
 jJK5LLthxLNNlmSgL0mfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:utCIBEYaMPk=;Mzat4W3ODM9WhOEYJzSDl1Ii2Mz
 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
 w63UHGdOhxjgLhTt2g=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12505-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:imx@lists.linux.dev,m:Frank.Li@nxp.com,m:gregkh@linuxfoundation.org,m:griffin@kroah.com,m:stable@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[web.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 065C4756C2F

> > Add error handling statement to fls_edma3_irq_init() for the
> > devm_kasprintf call.
=E2=80=A6
> Applied, thanks!
>=20
> [1/1] dmaengine: fl1-edma: Add error handling for devm_kasprintf
>       commit: bf1af4dfdc017dfe989c0dbcf0e608dc95f1d2cb

https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit=
/?h=3Dnext&id=3Dbf1af4dfdc017dfe989c0dbcf0e608dc95f1d2cb

Would it become helpful to add the following tag?


Fixes: d175222f5e90b7e1f23713378823c338fabb3258 ("dmaegnine: fsl-edma: add=
 edma error interrupt handler")


Regards,
Markus

