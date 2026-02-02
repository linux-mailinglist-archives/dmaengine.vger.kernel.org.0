Return-Path: <dmaengine+bounces-8660-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIh5BqNEgGkE5gIAu9opvQ
	(envelope-from <dmaengine+bounces-8660-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 07:30:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 468F7C8B7F
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 07:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97C83303181A
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 06:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8182F744F;
	Mon,  2 Feb 2026 06:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YIIcz0Nq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C62D8DB1;
	Mon,  2 Feb 2026 06:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770013646; cv=none; b=RWgdrt4Ab4DcA5QsKjpVXY/ldVccGJVszzcG+RP9igvBvefqsfDrnu8KWPG+tj439+qAukrskZKHW+lHviG+nUU8n1NiqQbVFQN55LyiaP697AAbzUmFE/EbvhdsC4rLT7UD/fN6OicgAC3qasxEaxsc1jR761+kqBJGi/Wvnrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770013646; c=relaxed/simple;
	bh=Nu9Iyypi8FJ1v4FxmPbyKQxydq1uqa1i6Rs2iebBKpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=gWjVw3e4IKapPMm3DjZaM0eQg3JRGSy6RrjdryRv3zJ9QjrgitEJB91N76htb5jd5yuTFShGgcX9TfjhsqtXKWCx7HKfL2PAw0nyemqMJnNmwdMCCfAD7/7nYQsY7KOtrlcD67j/MPXD9Aqp26r7WwouFhjdhHRhDKuJ+St3mRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YIIcz0Nq; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770013631; x=1770618431; i=markus.elfring@web.de;
	bh=Nu9Iyypi8FJ1v4FxmPbyKQxydq1uqa1i6Rs2iebBKpo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YIIcz0NqWjzzndN919+LVnSwEjMjSwEjuYpPmOWIlXblK4FGfv2s8qazObGxgGaR
	 oMT8vipFTyBk8gX2hgNpyyJIXKJIp40F31zgVs7asdNFCaE+6y1AIODpPgbVhrMxU
	 5KbtzL0wt6mfiEVpyPGFkV18hEGThbnUWqPEY9K2/DnhYkbI5jG2lCN6XAB5mqfWs
	 s+JQiUUfBn1sRVQmyzO4FEnZ1SPSkmBhGMpm5hH8doDgLi0PtzoQPyrk+pR7h3P+Y
	 Iqa92hDglrt+OQ40b61E31vblpxP7C1lTcKxttxJwV5CrWm8p2El7h0W+KUKL5Skz
	 Q9jydrgnjkJ9z+Io8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.223]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mi4yz-1vIQSU0lzF-00jaeG; Mon, 02
 Feb 2026 07:27:11 +0100
Message-ID: <ac172a42-5480-4538-bc59-c17c71eb6b66@web.de>
Date: Mon, 2 Feb 2026 07:26:44 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] dmaengine: dw-axi-dmac: fix Alignment should match
 open parenthesis
To: Khairul Anuar Romli <karom.9560@gmail.com>, dmaengine@vger.kernel.org
References: <20260202060224.12616-1-karom.9560@gmail.com>
 <20260202060224.12616-2-karom.9560@gmail.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260202060224.12616-2-karom.9560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aEO1dX3T+0gxhNk1zh4xQGyC1DBcB1ogF/3/D4kWSLGF4wRpLp4
 g+Zc+43M01kvPuvllTJaUoqhMi0HDdEjVJuJ6YExPSEXlcoOTRy2Rvt3qxH8qVV59Ow/B/b
 HHDISAqTMjVTDl0mRP3F8Q7ItCsVSWhE+e/9tnveA7Mp9uEa91HQFHJwgna62KW0aASJ3/K
 RQle1W61L1Wf809vaE53Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B2QAOfNnC48=;bHksfOZCX0fYyB8BjP52aJeR2Xb
 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
 Nw29noCwUVlLT3arZEaH/RRs5p/HH
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
	TAGGED_FROM(0.00)[bounces-8660-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
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
X-Rspamd-Queue-Id: 468F7C8B7F
X-Rspamd-Action: no action

=E2=80=A6> This patch fixes =E2=80=A6

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc8#n94

Did anything hinder you to use imperative mood for improved change descrip=
tions?

Regards,
Markus

