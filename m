Return-Path: <dmaengine+bounces-8646-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFVbHWwSf2lcjQIAu9opvQ
	(envelope-from <dmaengine+bounces-8646-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 09:44:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E383CC5450
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 09:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6925300AC18
	for <lists+dmaengine@lfdr.de>; Sun,  1 Feb 2026 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41889308F03;
	Sun,  1 Feb 2026 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LdN/Dz6R"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417E32E11BC;
	Sun,  1 Feb 2026 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769935466; cv=none; b=Ee/3h8eORaZEwRqnc8UJvHmG10UmRYr2XsZ9peA2RXSzGRNBSLMe/KZVnOVTaM0VRcUCLsrXdKkBKWWVOHzJhkM4edldU4DQJ+SjRcDOu5rXTef42smrzEwXfVLV7LSd4d9g/m0E8gOLsT1M1b1GVzk/ga1Jx4hCy2lqB1iWPtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769935466; c=relaxed/simple;
	bh=1wVBpDjbQMDSqVtD8LD0wS+fosH9xz4rsLae3VTszYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=W0aS8m/LFKL3KR7udjdbS+wq7BdWbvefeGiopds7CGGfLJyP6SVG97kGCLKywtwoF+OUCrkvVDQIA6EftTLF+3pwBoyOGnuYWJ1ZbTeZU3LBdBqRVIgF5psmxu4yOHEO1ubMfJNb5+89M4qZ3ZXB/YbdkDQLOgGeQmw3Opxxcug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LdN/Dz6R; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769935458; x=1770540258; i=markus.elfring@web.de;
	bh=1wVBpDjbQMDSqVtD8LD0wS+fosH9xz4rsLae3VTszYk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LdN/Dz6R8J5UPAtS1vx7jGvvSjeArH5xT7jXeN/X4LkXyIEqdXvKkLXoiaqA+lzG
	 +BdGwIOYo82TkRAkrDz0EX9mwTXlx4hSX0x/bKqhDXsxpaSbFp03oR+d0LduwzyAn
	 HnaB4EJldM3vQEq5pkcPTaEfidHSW0Z6wkNci7EtGHJWT8zr1W+HnSjavuj6fDxhZ
	 DQYOLAxWknHyumqzyY9zLZq+ylhkIWfjzjiRNxNpi476koLoX+HMZQEhVrlFiWaRQ
	 LCcG0qq6zK9G6yQ13EoPNkngoEEE89C0Nkim06MUhzQepEy6B6tMad33PxVpeA3Hd
	 W2QHS4yIVxf8bB9PjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.255]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mc1ZT-1wHgsv2GxL-00dTbx; Sun, 01
 Feb 2026 09:44:18 +0100
Message-ID: <c0b02e68-f442-44b8-bf29-dd1fb1829f28@web.de>
Date: Sun, 1 Feb 2026 09:44:17 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] dmaengine: dw-axi-dmac: Add blank line after
 function
To: Khairul Anuar Romli <karom.9560@gmail.com>, dmaengine@vger.kernel.org,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
References: <20260201000500.11882-1-karom.9560@gmail.com>
 <20260201000500.11882-3-karom.9560@gmail.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260201000500.11882-3-karom.9560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iphADYqTO06wfj3B/RE+0yKfYXv9Bz+oYxuGflToKAF/LQjbjou
 zGavGGhOEdi5tJD8Qb3mKBWNTX1eoLnSauPuSyS/WClxsLt3c8BI7SxijEOHLwk+5BlFwkC
 dCgSDEAKS3oa7NENwr6IwhZhhHP1w6xzpBzLFWXkVs7ngGJlSRSmn0061EFC4j6iY51Gzhl
 zFYSC//NQbwoky1XDPoRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EQxk8jRTWjE=;WfMRSnxrqIJPMIVSCKQosHQJq/H
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8646-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: E383CC5450
X-Rspamd-Action: no action

> Resolved checkpatch.pl --strict warning by inserting a blank line after
> declaration.

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc7#n94

Regards,
Markus

