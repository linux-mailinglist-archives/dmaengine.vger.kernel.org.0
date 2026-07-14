Return-Path: <dmaengine+bounces-12504-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fy2RMy1QVmrw3AAAu9opvQ
	(envelope-from <dmaengine+bounces-12504-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 17:05:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CEC756358
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 17:05:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=I6GmQ9zC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12504-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12504-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65AA13108816
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01B047DD5F;
	Tue, 14 Jul 2026 15:01:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5588444716;
	Tue, 14 Jul 2026 15:01:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041296; cv=none; b=KvztXyCmptawrIYYysYQQYSotaUaqKL8mm7+yWqSUEgly9vBxYEPD1Wmaarm7pQ0P/JIjoUoBurfd89mGzD++291N4ZrNvE7837RslhUUgzub0mpiQwvlOJ/0IfDCefyCs5HKpcrCAXvUHY7fkAAcbMrhqqEiJtUyFOEztgHHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041296; c=relaxed/simple;
	bh=nTwrHuc0Fiui3qoP0aGQfjEwawGGi8+LfMTuzb+BTTw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=IZLtiap/547YzlmbuGS4HAkezx0JTxNr7DfE8Eqdn1DSVC6B0ljWfOLIpdPCrYEIQYfVFFpfEW5Q4q2DmooZQAqyQ3pJwxf84g3FMjnh5ZNa8ETn5GQVYI39/IYpRu3yrmBDv+J5EEaOGm5PoLmiC/nf2RMox57mDCin87aguDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=I6GmQ9zC; arc=none smtp.client-ip=212.227.17.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784041285; x=1784646085; i=markus.elfring@web.de;
	bh=caD7w1h4Y8/l8jkkBZodQJr+uBu8Po2tnDxIip5W7tI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=I6GmQ9zCwsPUmN0Yr7yi6TNpwrYjhPawQHd/VKVscC8tS8IJV8j+zVRxlOlMEGyt
	 Aqd5XKLVsiSY3cOFGR+1QjNxG1Se/G1+2A65XuN4sPhLGHSG+wKgqzo9MPg5ucnCf
	 q9IQyrrjnbGm4cSk4ipprzvbvT8YZ4+TEdg7AfyldGBgdLTl1rALfwRQfmNiaPV2c
	 19xgNZ4K6lkSgAIyuP7pv9GE6RmYLgCkIgxscRsEr9ZtY1EJ6FtdeKizBP7SKIeLQ
	 nLWzTsZ6xitZAMTDOnOGtQc5eBS/kkP3/Fr+xazeKabQBZ0bxW7nQyRDSiMRovx6T
	 wzHg/4js+QGnXBQuNg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MD5jv-1wslK02LOD-00AIit; Tue, 14
 Jul 2026 17:01:25 +0200
Message-ID: <1ef78e50-0578-44cd-84ff-87a0f497c48f@web.de>
Date: Tue, 14 Jul 2026 17:01:23 +0200
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
X-Provags-ID: V03:K1:8O031vCFkGigGw8ISSVJ90J3ypRKVrCt5QJOJPf37a/XysXjJcL
 yJ6IHd/M3gvVuxDc8MyOuc6Pvt/QUcDZ6Wm/KkAcfspoSuBwdRVYRv2VGoFbKUnzCaEBu7v
 uC41Hiq9tbb1bQYh6IEYVFxm6xvy68ySpeSlK5KzEcHfdWSitsnd5MVwxNON19uKSdRAELR
 rcusADc0JoMtlwb1si7VA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LFFWOT0twko=;r4xL+VD0sZhm+0XNGCLYA97+4bI
 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
 J28fjDqliIyKoW3dDuAvWRr325SrAWmn1hzA=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12504-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:imx@lists.linux.dev,m:Frank.Li@nxp.com,m:gregkh@linuxfoundation.org,m:griffin@kroah.com,m:stable@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27CEC756358

> > Add error handling statement to fls_edma3_irq_init() for the
> > devm_kasprintf call.
=E2=80=A6
> Applied, thanks!
>=20
> [1/1] dmaengine: fl1-edma: Add error handling for devm_kasprintf
>       commit: bf1af4dfdc017dfe989c0dbcf0e608dc95f1d2cb

Frank Li requested a corrected patch subject.

Regards,
Markus

