Return-Path: <dmaengine+bounces-12541-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 78qtKZAkV2puFwEAu9opvQ
	(envelope-from <dmaengine+bounces-12541-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 08:11:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CDF75ADC1
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 08:11:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=DYceG6mc;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12541-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12541-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E14B03019CA9
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 06:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C1F33DEE5;
	Wed, 15 Jul 2026 06:11:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC73093CF;
	Wed, 15 Jul 2026 06:11:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095886; cv=none; b=imbVFV18DSIkXf4TGvQ+L9m9d+74IN+nclegOQoX0Ql4byrJIMHrHPXB+rIo6ERO4E3FUopWKRl9wVaotliAF+ImzT8d8iveVb9sShjiIW88ssyu6UjjwaIxQeGt8zCdJyQodkfk1pjAdu8tCVT2yH6Yc0UWqh8YbdoWUB5hbi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095886; c=relaxed/simple;
	bh=3/yuIQIFWs4a2SrHntG3KGb9ADRhrRJKKg09bDpG6So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqJaXejSELQh0svuO1+DZgCNq2U0ZFuheZbHge6VTNNif+LHNKfLyp/dzq3SnVmTSECOgLkA+kP3dKeByFNg0EDPTQ4K58uwnbAe+aTSmv6+vvEJnmB2V3UdQdzgJbZTuyqOCy+G+6vNLEvYtG93BBJYCj7p/Z7Z7diJ5KKn31k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DYceG6mc; arc=none smtp.client-ip=212.227.15.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784095871; x=1784700671; i=markus.elfring@web.de;
	bh=njEAlV3QVvhZjGKuPCd9kFXdkLpXSyyVdbgrHnyuKOo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DYceG6mczdY2VWFLOGr9I932nq7jp5YiRyF/C9xco9jwCJi5k3aH2J5FcqfB2lOv
	 nAd+83Ftb4wgVWeXhTVbdF3jrT/gmGUroMziFghH6/L0fLbiidzES3dqPudzH9isa
	 zHsqfqq9ysUvYPnjaP06E3duL/CyBnWAI4wgP+DJfXkDxZdBZJPw6+AWSt2hOQAwv
	 R/avupOgH+JcLqGbdWoW3Dk493HFnTHstTdOrnzrZnN9J5R4d5iTqAoN6koxTKFg/
	 JbhxXMlQQnwYGFDFP2EzZcUxC21XEyFHbmgtKLROe6zqiozP7P0aBbpclZIVNUB5J
	 2BpngmchPBhoD676Bg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHVaf-1wnzYd3Rir-00B0dK; Wed, 15
 Jul 2026 08:11:10 +0200
Message-ID: <ac9b775f-7a3e-4bf3-9f31-058039a7dd93@web.de>
Date: Wed, 15 Jul 2026 08:11:09 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: fl1-edma: Add error handling for
 devm_kasprintf
To: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 imx@lists.linux.dev
Cc: Frank Li <Frank.Li@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Griffin Kroah-Hartman <griffin@kroah.com>, stable@kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <178403257631.822807.3647660559296965382.b4-ty@kernel.org>
 <1ef78e50-0578-44cd-84ff-87a0f497c48f@web.de> <alch-r9QvhyiblOC@vaman>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alch-r9QvhyiblOC@vaman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jZ6L+LccopITf3NDfLua1BNFql/ugU4zqBJfGu5Qo7+EHpCnx07
 3nS8Q/5oDhFg+tO/kLYD0mtrk3akQJtglA/NqUkU2y75QmS4mkWBUaWMhQw9V4YBkKz43eG
 poO4Fau47cxyszYh+87jm2annG35NLzjugOyY0l3ydw9dLgRKH8JQBn3rOwNHtv+EAQc/dY
 vDEyP4WT68Ar/SOWzlsjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WAsSt5yn1nk=;GIslZ5U3a6bcudiVMTwcMZQBX/E
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12541-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00CDF75ADC1

>>>> Add error handling statement to fls_edma3_irq_init() for the
>>>> devm_kasprintf call.
>> =E2=80=A6
>>> Applied, thanks!
>>>
>>> [1/1] dmaengine: fl1-edma: Add error handling for devm_kasprintf
>>>       commit: bf1af4dfdc017dfe989c0dbcf0e608dc95f1d2cb
>>
>> Frank Li requested a corrected patch subject.
>=20
> Which was done while applying
> bf1af4dfdc01 dmaengine: fsl-edma: Add error handling for devm_kasprintf
I find it unfortunate that an improvable text was mentioned in the notific=
ation.

Did different development opinions remain if all involved function names
should usually be marked with parentheses?

Regards,
Markus

