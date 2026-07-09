Return-Path: <dmaengine+bounces-12171-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T8TFLHeJT2pujAIAu9opvQ
	(envelope-from <dmaengine+bounces-12171-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 13:43:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27517730868
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 13:43:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=ApEx2uWT;
	dmarc=pass (policy=quarantine) header.from=web.de;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12171-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12171-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D051030F0EDB
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 11:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE82416D1A;
	Thu,  9 Jul 2026 11:33:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48763F99E3;
	Thu,  9 Jul 2026 11:33:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596818; cv=none; b=MQM+8mHQT4l4gfUwCE6PHK+IVPlmosUgsGCG5RYeduQ69vJJYU7aXjU8neLsp324kKka9NGNBkYBYHuIINlvPklc6FE+h83khqr6yKYkRnK98jn4PWFNnhJOU94TEFHXHZ6XOS0EhlcwJP6vyd63xf+fgcihYFWf8EgjqHIt0RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596818; c=relaxed/simple;
	bh=3u1eCIMC61U1iunia4gabiq+oDAXttkxAv6ATOhWy2A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=lq+Cm6NJKvsaLybeDhHp7B79qoER8sWa035s9+6wXFWjnpd6+/JSAP5FcxZZUGS66eIUamQ/Ad1eWjMogts2dQ4GaP1NZ7bisLkGoedIVTJxMIGqGYH+j8r+AMRXqtXGMo12Tbox35HOLUDhRoMhGEZr8UtkTJWTifaa5B7Yc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ApEx2uWT; arc=none smtp.client-ip=212.227.17.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783596808; x=1784201608; i=markus.elfring@web.de;
	bh=dU3V5lsCup//9g4z3abO31CvstIgXQ6vFr0DdAt97Vk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ApEx2uWT2md4Ljv7OHE2JGXqcbX/scE8BbdwHpueNt/FfjNRPd7zMo5xWTJ64KA+
	 4HD4/CmpOpy4leFt00T+d515WIuTFPEkT8ol5X2FRuM6ttauJK91ZSjl47bKkq6mj
	 0+Y4zx2epfB7tmTepLDGItLZQD/3SYGuWhpaXd6Y3Ok/+3d3YuV5apyTEn5kgLaO/
	 NXKsDFrjTUD7AYIsr+O/ZafS9APq3ogw9k2o8D1ErXmD0DbcQeLCxORtZjRbNmc8s
	 BW1FAN5znfDfut8cAqUK8pdpaSxhXmCD69ancM4JHm1reQCmZlpc2f56Pg6yeovPF
	 pfy3VVHXnyvvnn828Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVJRl-1wXA3L0Rrb-00RPky; Thu, 09
 Jul 2026 13:33:28 +0200
Message-ID: <eb695a2a-2e80-414c-91a1-3d7fa580c7ec@web.de>
Date: Thu, 9 Jul 2026 13:33:24 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Frank Li <Frank.Li@nxp.com>, dmaengine@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, imx@lists.linux.dev,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook
 <kees@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Devendra Verma <devverma@amd.com>,
 Koichiro Den <den@valinux.co.jp>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
Subject: Re: [PATCH v4 00/10] dmaengine: dw-edma: flatten desc structions and
 simple code
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lazUhBIMmLzqNSbxN+eYaYB2AqlmNHAb516c8ebt3InwwhzLtrl
 JOpmxNLhNl0IGmmgJGm4FIip5O7NhfW9Q72B3HqfOpbI6n9lkr37fMKSuMcllBOayHT34Ej
 dWsUTUCocwfbqdOphT2+KXnImaUeXXrLj2zus2RjLoJRYfsnwi1MY8kdF38mq3HXujFwSmi
 ecu9u0pPRgv56187FP8Gw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+Sjfrk61JOk=;sgpjzjLoMopB1XcWzDVZmB7Gaex
 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
 TZd1CGY3MxPtY0zsSGDpfPyMdP4=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:dmaengine@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:imx@lists.linux.dev,m:bhelgaas@google.com,m:hch@lst.de,m:gustavoars@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kishon@kernel.org,m:kwilczynski@kernel.org,m:mani@kernel.org,m:cassel@kernel.org,m:vkoul@kernel.org,m:linux-kernel@vger.kernel.org,m:devverma@amd.com,m:den@valinux.co.jp,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12171-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[web.de];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27517730868

=E2=80=A6
> And reduce at least 2 times kzalloc() for each dma descriptor create.
=E2=80=A6

How do you think about to use a summary phrase like =E2=80=9CFlatten destr=
uctions
and simplify code=E2=80=9D?


=E2=80=A6
> The finial goal is dymatic add DMA request when DMA running. =E2=80=A6

                     dynamic?

Regards,
Markus


