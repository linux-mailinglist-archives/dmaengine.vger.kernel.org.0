Return-Path: <dmaengine+bounces-8486-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B50E3gad2kjcQEAu9opvQ
	(envelope-from <dmaengine+bounces-8486-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 08:40:40 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E01F284E98
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 08:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 335273001327
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 07:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADFF2E03EA;
	Mon, 26 Jan 2026 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Lnro4JZD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A42DC76B;
	Mon, 26 Jan 2026 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413235; cv=none; b=ei4+wq4V7fCrNWF/62FKM+mJu52MOZ0w64gVtb380e05fnvJ2tohoO8zacjjdiABOpHmshXgVQP5/RlQpP3RUq00emxeh8jglRG5aRePeo/vwbJr8W7HRUHnZLLYxRWDCu/oxpUTAfUZWraTgy+tTGRVRmDtCxwRAd6o1DuWl9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413235; c=relaxed/simple;
	bh=lme+7iyq+Eu7ZGpkm6oWQh1afgA5huG+wzm56Gb2q00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+aVYvjDiBxcALDzjkUVg5lVcOvfMpeTswjaEFGUd3vvXm+jqe3SqLfU8sYIDmnV3FivshGNU+s9L3EgxadTLd5U8mEjCxai+TbD2Y7pBZJE5mIzTHbadBJCDawN8lq2Tzq0SEd2SIi/KF9PZNxFWDEzz6wssqQBXjNQboaZuI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Lnro4JZD; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769413224; x=1770018024; i=markus.elfring@web.de;
	bh=+IkQOpVvJE859yPpAH1MU6xbj/QB6E5JJ0VTe3/hBuk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Lnro4JZDS1AtO6rUzuGBB+ABOImT8/i2y/6g+pxnKiCDe1ywn3IKKKUQhsHNNfvL
	 CCmUiZxw1bFM1hWYQiwE5pNLlx8lpy1H8Eau/rkc75l6ZEQsz6N7LZj+gDfE8bNJT
	 Q2e3TljdgGFhf8rtY531tmklrtqwx7opyJvwl1efX8em+s3fr6gsJ3HhrUf2RYJJI
	 4QI2mssyQWx3lmPCqTZhg8iV9wKaF+lzimY6hCop2ekIriHAKF/9l3rtHPIjwMhJR
	 f9GepGfeHi/tIEtrSIvaDZFgMz4BUhdjLWUrKLak/znADE2fUh299gg8eXU1NmTga
	 heuyartY7W/xN4D4NQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.253]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZQY-1w6Qjw0I9w-00e4Fq; Mon, 26
 Jan 2026 08:40:24 +0100
Message-ID: <0b654535-7b72-4e8b-b085-2e9e0dc0bcce@web.de>
Date: Mon, 26 Jan 2026 08:40:13 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 0/3] dmaengine: dw-axi-dmac: Coding style cleanups
To: Khairul Anuar Romli <karom.9560@gmail.com>, dmaengine@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
References: <20260125015407.10544-1-karom.9560@gmail.com>
 <3d1c8106-b954-47db-b3b9-a213b7966759@web.de>
 <d1778b28-9223-4d08-87c6-33c1f625544c@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d1778b28-9223-4d08-87c6-33c1f625544c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kXWjs8j0/D9SBT74gXBJkk07kDgEJYFJ8KVnfd2713lEVyHHG4I
 kJJqs0/N9ADfDjJNkEOEj9o+4I7UwokfLAnAO3v6BV2vt62FE7e1w8D0df3CeOXUvvpcl3s
 ko/zIqaKtxHS1LILVBBNBTyVxOsPgIpFLuS8wZk08tljsZz9SpJ7d8berRPk3u2UHAP64pA
 3fl5VzPsAqYuABPjNC16w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k5eRke8Mf6E=;OT9JlMGabJOB0bBMc5rFrXHUsDI
 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
 t1pCRMo8=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8486-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E01F284E98
X-Rspamd-Action: no action

>> I find further wording refinements helpful here.
>> How do you think about to indicate in a consistent way that mentioned a=
djustment
>> possibilities were detected with the help of the analysis tool =E2=80=
=9Ccheckpatch.pl=E2=80=9D?
=E2=80=A6
> Sure. I can resend the v5 and indicate the in cover letter that we the p=
atch series was detected with the help of checkpatch.pl analysis tool.

                                             in each patch

Regards,
Markus

