Return-Path: <dmaengine+bounces-8669-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +It7D2fDgGl3AgMAu9opvQ
	(envelope-from <dmaengine+bounces-8669-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 16:31:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72380CE468
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 16:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87A1A3017786
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FD337B3EB;
	Mon,  2 Feb 2026 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QtEVrYBh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D77F3793DA;
	Mon,  2 Feb 2026 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045684; cv=none; b=ST2jyvpvx2GmcftcDxqDKU9n7cs69IKFj34WnfJcXdSJIAijhG2+SouA2xU7BwpUWAXk4M6hwZQo3I4JneNh8Q1UM8s+oe41Amy4zRtlhLlGFF8qSka0/aRS/Eq8evQAUZF1Udud8Uf470RfYOeJODZ1o29KlF9eIemCLbWkgdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045684; c=relaxed/simple;
	bh=fiqOyj32gmy/ItacXYow4nyol3CpjUxZ8njslg+jzBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=mtCxP2GbSPj9fTbJDcVGoAuPgQ8XzGQKcxfOSM9XXphtFm5TR7Fz2haT5ixRP+A70MRotAC462H7/VIHjroUwHSw2Sy5RMcaVDdlqNcsq/DijHL9LwEeJeaOcapVx2Rp2GXGQHu8gPbbWQFNmpeBkAKeCkvVrYPsUv5QVYCar3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QtEVrYBh; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770045662; x=1770650462; i=markus.elfring@web.de;
	bh=fiqOyj32gmy/ItacXYow4nyol3CpjUxZ8njslg+jzBI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QtEVrYBhrK5TkI0SQLKHCyoEpBiJb3yaux4NzOCIDLewhhZR3SE8rDuZ89AspJKp
	 5P4D8vu73Dp+MQKvagNLcOFxyA/yYxY8BnXMpHvMPXKOpD8Nf5a1Bh+cVoE6/qUGu
	 FlFUOtJTtZasqz6rmDhMwb/G/MvczeaTfquj+QIx4IsA7mx0IN2koNiU6/m2vTEJ2
	 5wuW0MRpgDHTgYJHkNvzRjA2vHHMGOWV64hK9q1/NjGzylUuwDmm/nwHRzQqtcgP6
	 JIXpGiW0Fa5JnayE3w4tfP7u08G5Zq8oEpUD3fJZNiVPgwMEWNBndV/0vJI+ZRxZg
	 SwCElaBg8hcvC0KEyA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.223]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2ggd-1vr4Sn1KFb-00GJZK; Mon, 02
 Feb 2026 16:21:02 +0100
Message-ID: <2ed6258c-f6cd-4264-ac51-1bc723febd8d@web.de>
Date: Mon, 2 Feb 2026 16:20:49 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] dmaengine: dw-axi-dmac: Coding style cleanups
To: Khairul Anuar Romli <karom.9560@gmail.com>, dmaengine@vger.kernel.org
References: <20260202060224.12616-1-karom.9560@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
In-Reply-To: <20260202060224.12616-1-karom.9560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q6oqsxalPO/5j+6V2wwg9ymweR9/imcTQx/2ThTj4AIp2Dm0eG5
 6mlwfjXSrp4UFKE60xlq62XT/++GHSkQKvXdGCXS3jvhUmJUaJsibkrg/+anQBhROjLhYIt
 bVyJVFZw/kULVE+9/b2H2PEHpxK9GzQcFsrA6BM6jbxdxKq+kFCXFRz6LCZCshNP+Lev0gA
 gm94H1XsPmLe3xKFL3W9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LTITYlCK8zM=;ehiwvLiB4ss9ZyTYW68UWz42hoA
 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
 n9zMLPorSvfTq9Sqg=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8669-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72380CE468
X-Rspamd-Action: no action

> =E2=80=A6 This adjustment =E2=80=A6

Did you move any related information into better patches?


=E2=80=A6
> ---
> Subject: [PATCH 0/3] *** SUBJECT HERE ***
>=20
> *** BLURB HERE ***

Why were such questionable data sent =E2=80=9Caccidentally=E2=80=9D?

Regards,
Markus

