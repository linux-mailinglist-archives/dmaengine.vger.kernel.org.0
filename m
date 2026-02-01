Return-Path: <dmaengine+bounces-8645-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JFVODYQf2nijAIAu9opvQ
	(envelope-from <dmaengine+bounces-8645-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 09:35:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55889C541B
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 09:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7F3A30038F1
	for <lists+dmaengine@lfdr.de>; Sun,  1 Feb 2026 08:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F333D2E2EF9;
	Sun,  1 Feb 2026 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mE69fVhr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACBD1A0BE0;
	Sun,  1 Feb 2026 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769934899; cv=none; b=MqcGfcMfwYQSg/mQSZiBenj9EJ+DrvJPMlgGRKyT3kFKWeinO3zg31KGNqn1fB9TdKOnQrSBwJcmWeFYXDOkds3uLIicgHh4iU0++mtsTC4eUy74xQ8RTKPHWODzd1yTbEMRQiWZ/oNViplSao47O/P80CP8yWcyhG2SWWef5lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769934899; c=relaxed/simple;
	bh=CebHTnIp5OcKB/mTrWebIs5xIqpsNmjqsFPV3qrzwdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=OuMrHx3yo0LYK3I/VLoCdt4OhxnAj5Yq+E0ydSxf8KXXmKmb1+fIpMYv8GoqYkpP56UOlYaDC0CY0e8fiya3uJwvHpOBAufNaKDR8KxCTjxO4evKZFwrtJahYVtPLLXhgdAaiparUQxxiNE35sp3NID4wyNpzHsnGZ8bCuqaJMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mE69fVhr; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769934896; x=1770539696; i=markus.elfring@web.de;
	bh=HIz/rkufYsoq7w4iNSv8LRdcpiC1zBouNIxm/EJOqqo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mE69fVhr6Hav81QRvjy9lxZYuWINkMXVyE/XZb/VkoPAQNLLmUkwqyA82CWachA4
	 zQ/7tzqBE4atXPJA9YlbLWtlHBHFWBT9Yfv9eQ3aPYI1Z8jtHflL0zTkhivManTix
	 VWXnSuPApRmy6lyfjOloH1ZnQqsoSjs/m617QW59nQJMchJ0GZYgldp8ivPdqw7Tn
	 Uv91aM1JoXVTKaCnRRhF4Hv7HnIyaaFy2QE6FInsWpFNBkGzIrmIfggdFNDlwhvlm
	 v7mJC4cTUI7VOZ0RGiw4y7tKGIEkY1Y4MgIoFSeI+pCXFV+d/k7ECb5zYC6kQ/zVs
	 fEpdW/mCsEBJZYqlFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.255]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mcpqo-1wLFly0hv8-00ZurI; Sun, 01
 Feb 2026 09:34:56 +0100
Message-ID: <2be0e80f-0ba8-4d67-a6db-6cc0ac26c7c3@web.de>
Date: Sun, 1 Feb 2026 09:34:54 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] dmaengine: dw-axi-dmac: fix Alignment should match
 open parenthesis
To: Khairul Anuar Romli <karom.9560@gmail.com>, dmaengine@vger.kernel.org,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
References: <20260201000500.11882-1-karom.9560@gmail.com>
 <20260201000500.11882-2-karom.9560@gmail.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260201000500.11882-2-karom.9560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FjSxuEQa/5j8zczivheTh7UDZz/GOEBsWsyx4S+KtJ4mWkGT4KT
 yo7V4qC0bJG5cu5CLwq1krdC5G+tnUCr1Sq2H8a2ncDw8GLFtL5fxLvdgGjmGdkflkKHa02
 9gHILJDrFm7mihwcVgstyF68OpDhoZdSbhH77k/32edEZ2kPNX8qHEyUCrwAa3f/DVxW3Ar
 UKKU2h/unmISq3I7ZBe/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TPsCD/8AqWY=;4U+Pe6mdtmUG2p+/s612M3ZCxZG
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8645-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: 55889C541B
X-Rspamd-Action: no action

=E2=80=A6
> - 'commit e32634f466a9 ("dma: dw-axi-dmac: support per channel
>    interrupt")'

* Would the mentioned commit summary be nicer without an extra line break =
here?

* How do you think about to omit single quotes for such information?


=E2=80=A6
> This Alignment should match open parenthesis issue were detected with th=
e

  This issue was?


> help of the checkpatch.pl analysis tool with --strict --file option.

I see still further possibilities to refine also the summary phrase.


Regards,
Markus

