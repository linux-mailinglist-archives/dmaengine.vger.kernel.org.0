Return-Path: <dmaengine+bounces-8647-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKzDOTgUf2nnjQIAu9opvQ
	(envelope-from <dmaengine+bounces-8647-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 09:52:08 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A56C547D
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 09:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA996300B47F
	for <lists+dmaengine@lfdr.de>; Sun,  1 Feb 2026 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D322DFF3F;
	Sun,  1 Feb 2026 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nePIa1fJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B1C2877CF;
	Sun,  1 Feb 2026 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769935926; cv=none; b=iYgOjbHmzYGiadxxCpYJ2Dv1wjdvNhPoxTisUC3fDB2a4R+KnhosTY+TYoUEgWs1PsuGjmTBJsLByp+cpMWkEi00dJWPkAHITNmYXYsGY+kr6oVIC5YWIZVVMwd51eQgxzuiXbRPGNtsOG1eQxD3JEYLWhFJnpl8c3okJsi5Q10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769935926; c=relaxed/simple;
	bh=sGQjovvPy/D7h2op/Cz4ZHxugCAx8JAhmTJO+KXvLHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=MVa5/QXy6UtTVIq76G072oB1Q0Bz5X3CBNEIK5k9ZD11IxS3Jqr32RON/bBpenJOcbhRwJ/PriFwHL93yj81251dJ2cuvU9eiW7LUR4ZZD+4dsBeth/FQEq8TIun+2RykOp93nGcL2izQG7hc7lj380f9JxkcsQKgLbj/YZgt2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nePIa1fJ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769935918; x=1770540718; i=markus.elfring@web.de;
	bh=OLb/QmvWs9OFG7BnLnPS3WL91c7DGHvvhmQVsqgOADw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nePIa1fJc3WetGMbNgTfvBzn1+Ro+jSbn6sGoNCOd2olLqXnHfJElaDQlOk89i/v
	 hlnt2keKB++6UfunY3wxrh/dKoiOdT0MjMxgOQ2gMO9QbVPRiY4YKwuKaERExwCvy
	 1slcjxtvjPOuj4tOE4MGlPUEpGGkpey0RzaG7MT+VmIIkgTb+W8PTldl/xG3vVlUG
	 UpYd2mT2sopBHUQp2niojai6mFeacqBl84phHx0zInx6a58rikYhvScV63Th67BrQ
	 9hwwlB0yEKLNqmDAy3TtHqhirOiVbwfKys7h9RY2aPWzzimjswPeYoNj5oMKAnNHZ
	 LitpDN3EzT4AjYVjQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.255]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZSFO-1vG6cS2K98-00IBQQ; Sun, 01
 Feb 2026 09:51:58 +0100
Message-ID: <b3df4910-da8b-4a8d-aff5-00c881de29ed@web.de>
Date: Sun, 1 Feb 2026 09:51:57 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] dmaengine: dw-axi-dmac: Remove not useful void
 return function statements
To: Khairul Anuar Romli <karom.9560@gmail.com>, dmaengine@vger.kernel.org,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
References: <20260201000500.11882-1-karom.9560@gmail.com>
 <20260201000500.11882-4-karom.9560@gmail.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260201000500.11882-4-karom.9560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sGAZDWsIjcnzjysBXblGIAIt/EZxes0lnyvYBuTloQDRFprstnt
 MeHtmrPYy5bm/LTOvQNRisC1ZKMEgPAWBdu8TPjDAO0x2FycFYXVr0nmuj809ps2Gaql4rs
 c4/Qvps6erfj+leCVHLQnmgSOI0xv2mjDsFPI5H68RV+QQq4nOTkNzbZrOeNr2R9NZh33zV
 dUk70r/PzhSH9igHuD1Ew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/XC+lNezPBQ=;SagSJEAGGmGWEiQiPon5QLQ1Lcf
 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
 ioaN7LKU=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8647-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,synopsys.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49A56C547D
X-Rspamd-Action: no action

=E2=80=A6
> This fix resolves a coding style issue introduced by
=E2=80=A6

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc7#n94


> This unnecessary return were detected with =E2=80=A6

                          was?

Regards,
Markus

