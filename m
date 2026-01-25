Return-Path: <dmaengine+bounces-8478-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EuVWJTXldWlYJgEAu9opvQ
	(envelope-from <dmaengine+bounces-8478-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 10:41:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 879978012C
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 10:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18C8A300579A
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 09:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA0D225762;
	Sun, 25 Jan 2026 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="b9vyULDR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4837E220F38;
	Sun, 25 Jan 2026 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769334066; cv=none; b=CXA+onlaBrwVZkFoMzsdfLryVoJorUzG1oW86n9R0LuJwRl8f3x/Q9cCy05HjnUyuFTmUZ5s/vweM4M7F9rD+MF5yslLjSkyaCUCqz2Tb7MYklZsCvPg+HJCoNazdGjP1uPlSXf3pw9SQHxyEzrybw3+rzAjzq5AaNv/Lm2gTyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769334066; c=relaxed/simple;
	bh=/9KLw71xb5S3u6FTyqQOmzACYtm1kEDlgA/q1FMxl4k=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=uAkXWH1zrG45Tk6kfzZ7V4ZIWjTDPLORkkRMFSv8CfadDfg1klSDzQb0aNJEXE8e7+gJzkG3qooX3X26AOOFJB/nSA9bsF32Jwu46YoDqjnHwCK44GI4NXA8xUXjL6Z9WkHmQ/CPK02yNdwL6UrwevNh4EdU1JOef+dxfWUO3Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=b9vyULDR; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769334055; x=1769938855; i=markus.elfring@web.de;
	bh=/9KLw71xb5S3u6FTyqQOmzACYtm1kEDlgA/q1FMxl4k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=b9vyULDRcR/qc7iXI2hOxr71FuTXrpl3xNeOuHr89kcnPmBb4bvI2ULg8hBq3IUr
	 r1udKqgATk3GYd0PxyXjZUPsxjQXFyTlF83RnWD16dVLbl0wQesFDbg3i3Fyyd0ku
	 jh22lhuDny4ljrknDyFZn/8ZAwztz4yOUD9AOrMgqpMgIpquZBcYPkLLqvxnUYp7D
	 uyk3vvOh2/VojJBXeT6nFU9pmFutEqZkIUeZL0MVmHjQtMigkMKxCnigO6NZjhmg8
	 +c8+LQI4Chwz3CdAszYPja9CvFC8VZIbaMrkotaUV7O36wdD1TA8GfkQCOnTzTALy
	 aZ8R2Isywt2aoOTC0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzTPW-1vwxIF16um-014V9L; Sun, 25
 Jan 2026 10:40:55 +0100
Message-ID: <3d1c8106-b954-47db-b3b9-a213b7966759@web.de>
Date: Sun, 25 Jan 2026 10:40:14 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Khairul Anuar Romli <karom.9560@gmail.com>, dmaengine@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
References: <20260125015407.10544-1-karom.9560@gmail.com>
Subject: Re: [PATCH v4 0/3] dmaengine: dw-axi-dmac: Coding style cleanups
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260125015407.10544-1-karom.9560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DEYQ+th3lzKqn1WKM8UbUc0o1Z6fwmCt6Ai850bR79tc26R2nK/
 aOH7JCQXC6xPtV3rXC4yarxvABXN92inRHgzTaXKvCexLmvDvrFZM3MNtXuT2xXzskISNSi
 WXtCAU9cSE3SHsPzPn3uF0AjEyjhMNpApl7q3gmNUQb2lj1PlEsAU9lznZVro0ZCN6mkw/K
 WTyDpURTTsWCGgvl+qYgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LbQQXPb5dHI=;l32NgsLWk/gYW9ruAYB0WGCXT9R
 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
 oFCaI649L9+s4MHfA=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8478-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[web.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,dmaengine@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 879978012C
X-Rspamd-Action: no action

> This series contains a single patch that fixes minor coding style
=E2=80=A6

I find further wording refinements helpful here.
How do you think about to indicate in a consistent way that mentioned adju=
stment
possibilities were detected with the help of the analysis tool =E2=80=9Cch=
eckpatch.pl=E2=80=9D?

Regards,
Markus

