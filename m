Return-Path: <dmaengine+bounces-8648-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5+4OIXwjf2mNkgIAu9opvQ
	(envelope-from <dmaengine+bounces-8648-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 10:57:16 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDCAC55D0
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 10:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A1563010175
	for <lists+dmaengine@lfdr.de>; Sun,  1 Feb 2026 09:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B717D31AA8F;
	Sun,  1 Feb 2026 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BvaASJZz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0E42E5D17;
	Sun,  1 Feb 2026 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769939833; cv=none; b=QbWvj50eu+o4XLlatbUiY2VJPOaqy1VoJRhxKdKflYdYDNT4rh4w+spUD7aHO3PP540D5YmEq8RUdNJJOgDLJ1QNKNyJWi3Z+TBF9oULQhlrv0I18Rnr0kOAbRjf1scDR2PQSrLlIOmUsYW+6/f18XuPX9HObGAFzgWLlEX8xrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769939833; c=relaxed/simple;
	bh=2tZWAatAeagNsmGrp7mJ5gKnvervbpLcEj1CAuV07Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=RBJLU0Lx0V7fYGGSHdtUoaXL44iUhsEAOToPUmoUEwmnHrkkrUAwUZAWYBipE8O8pW6ohhDpGyf+Xuvad2iDTpIE4LAdz5dDNK0ND+UlazKR5PZXYZUOqcANdQYM0/XFRoVam2XiUw5X98XrQQb4aT68jPk1KxERwlTqng/kLfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BvaASJZz; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769939823; x=1770544623; i=markus.elfring@web.de;
	bh=2tZWAatAeagNsmGrp7mJ5gKnvervbpLcEj1CAuV07Vc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BvaASJZzM4lNoWOdm8D7O1ecD4qAKSIOaMZ7eYclU6W1/MbpVQpjZVWzUsAi6+44
	 bvKWbgoY2HaVRbBTTx8oOU9aKkt+RldOZD9O9kT/S91LpiMp6vOsRvEQrocwr66Yh
	 OltAKHAzBXl47CGJ1lwlPPGuZJzJaulek3k+JypJA6iXyKmcBKyHxuF3Yfj7e7gCq
	 Z41VsnqSwdO3BbKmMQtSvyT7khF3+QWPscQ6vLtCSE4HcB0W+qv5DR688zoXo3HAZ
	 iL4+9UDHFepLIchCkkfvYyaABdnk0LjLp/QtKxnN1ZjdMkNE0GJafiI1uDm2crbms
	 62t3s/HwpSF1zc1epA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.255]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjgT9-1w9y6e3Elf-00hyq8; Sun, 01
 Feb 2026 10:57:03 +0100
Message-ID: <157e96d6-9d99-4ca0-bbfd-626def824c8c@web.de>
Date: Sun, 1 Feb 2026 10:57:02 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 0/3] dmaengine: dw-axi-dmac: Coding style cleanups
To: Khairul Anuar Romli <karom.9560@gmail.com>, dmaengine@vger.kernel.org,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
References: <20260201000500.11882-1-karom.9560@gmail.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260201000500.11882-1-karom.9560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ILvj4jrMBOQsO74PWl0b2jhPid8kvU48RUxPkbezY7cXSh1jHM5
 /0sC+bWafS/qJniNK0PuUPQ4ZKxYgtBxVKKGVUB5mxGWf2DBHBVJyvnfsStaiylWEJbd20a
 MJI6AOa+GOb/CiWTq+h6a2ojQ8zrTGgmirTi4EekQ33JdlNg6rZcMPR7kxF7RbHQV/l/rRo
 L0RNzmUuDyr6PoR2f/oDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ssvWqDr2oI4=;dzLcYl4Pb2cFNVl++7kM9bv3Jrz
 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
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8648-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,synopsys.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: CDDCAC55D0
X-Rspamd-Action: no action

> This series contains a single patch that =E2=80=A6

Please correct such information.

Regards,
Markus

