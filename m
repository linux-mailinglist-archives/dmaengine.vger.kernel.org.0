Return-Path: <dmaengine+bounces-8500-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG0mNlFMd2msdwEAu9opvQ
	(envelope-from <dmaengine+bounces-8500-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 12:13:21 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 369718787C
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 12:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 283CB3015447
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EA3330B36;
	Mon, 26 Jan 2026 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ReS2TnnT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F2255F5E;
	Mon, 26 Jan 2026 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425972; cv=none; b=PO27Kok1isPyk71mpicJ1Go5eE0xA25FCDEJLmvFdOAlEU+H6Nl+SY1ERcSOYeSOGEPGYu2obEzhs3KeYrRdYlcHbR4IoTBO1ecUBNuVzIyh2JOg4W4+eoyo/9+VBb7ukNmiM4nRvoLCTOP4KJi2FO/DwWwh3lcS5aNZFcBTX28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425972; c=relaxed/simple;
	bh=98h7xXq/h2U+g4+Hr6nSZSxhE4H7VOtTEv+txphZmmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=lcVRlr8YANpdBTkaipw35osp8xAx74VOkdZsl2/aA2jNXQWuyiEzdqQADgSzDn/E8klrg/3iGQ3s5h4QvtuvwzWE66c9PRkqudGYBnZ97JYDkqnp3PgJV/q+3LljBn0pD4VwXSC2SOOLIFZzau9TlyN6G46co0fRHnaO+wvcADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ReS2TnnT; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769425948; x=1770030748; i=markus.elfring@web.de;
	bh=o36WgUHPbrLkgmub2Bb1Eqxy7VvIXOvJkl7UKQPiY3Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ReS2TnnTAd2+Dh1Hee7CZhqsgrvMGoqAae2cBWz4swDQu66VfTlUvNhPDDWM49nV
	 ZPCYIfGNzAPHYXSE476RIVgvhWIYUjskXTTe66pDs/lGcb5Gj5yyJKkAxwtTiJm12
	 A75N/S0A+ee3HRgA1fw8ib5hTpE4Af7aXpSphkiOhsSJyE+4PChFOD1SRoFXjBW8h
	 L/tSGNR19ORbYVLyI9k1GS5RhVqOcwhxUPsKqDD98Fj0pvtNolRRDNKwdwSEf0+Br
	 +hyFSg8xoyai/r1NkY4mqNE1vyKnfzQNQGbwiOJW+kJD4gQJWO463hXTtUxjDZbSx
	 NSwg9Lqr+A7og4z6Rw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.253]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9479-1vmvP91V6F-0169P4; Mon, 26
 Jan 2026 12:12:28 +0100
Message-ID: <425fd53d-9b97-4d4d-ba21-ef35d821c89b@web.de>
Date: Mon, 26 Jan 2026 12:12:26 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dmaengine: dw-axi-dmac: fix Alignment should match
 open parenthesis
To: Khairul Anuar Romli <karom.9560@gmail.com>, dmaengine@vger.kernel.org,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
References: <20260126103652.5033-1-karom.9560@gmail.com>
 <20260126103652.5033-2-karom.9560@gmail.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260126103652.5033-2-karom.9560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:I6ITziasMKVN+eVNRO3Kw34tVDqDyttT/EsHAKUPI6po6KCnYpo
 T5mNYoJ30p9Aq9RlwlffODuNsc8BpWdsAICaWGrSYbWQQZh7jWcrVEbzug/wHaeh0UJB4qB
 ZZptQV0aKeQg3lMyU93H85LYtWAlWIYAA+b6aU+ecUrZFwnWISy3mLqYgc06n8aeF1drUtP
 zgof+DmQSj4Xhs+ADngTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GYHmF4dxgrs=;YzDd1HRN+wYt7U8gsIQ756flzHs
 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
 9Rl0kKPE=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8500-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: 369718787C
X-Rspamd-Action: no action

> Correct alignment issue so that continuation lines properly match the
> position of the opening parenthesis.

Line break?


>                                      This alignment issue were detected

                                       This issue was?


> with the help of the checkpatch.pl analysis tool with --strict --file
> option.

Would it be nicer to put such information into another paragraph?


> - 'commit 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")'
> - 'commit e32634f466a9 ("dma: dw-axi-dmac: support per channel
>    interrupt")'

Is there a need to reformat such details a bit more?


How do you think about to refine the summary phrase another bit?

Regards,
Markus

