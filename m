Return-Path: <dmaengine+bounces-9809-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBFwLBcHzWkjZgYAu9opvQ
	(envelope-from <dmaengine+bounces-9809-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 13:52:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA5C379E49
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 13:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 352B9305047D
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 11:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194AE3BBA0F;
	Wed,  1 Apr 2026 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bereza.email header.i=@bereza.email header.b="mlrDwguG"
X-Original-To: dmaengine@vger.kernel.org
Received: from fsn-vps-1.bereza.email (fsn-vps-1.bereza.email [162.55.44.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2437E2E9;
	Wed,  1 Apr 2026 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.44.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775043681; cv=none; b=OMcN5r4pUqkm8VGV2eoC3MIYd4tXCoqqQD2YilWxR3TxHrjhjKFrlBT7v6xdRQv5pJboUTMHjzrnvg2TU71mVyyn6CqK2VSj075vpLeA7Vhuv15If/2cH47Ufx80kx8sOGaXs5oTOPd3fIx5fBO0XlYscd6PkYFb0yAW83BmQBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775043681; c=relaxed/simple;
	bh=rGi3+b9PYSRUSUN6fg8GwyoE7KR890hxP+JIX+fz2zU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tifjg7LhiuXr7KfMFCbG2/bMBc8SEWormaQTFbDrPIvUuRQqVxQcL0290HAM0srxb7fu91J3uNXqUJmjYHsN/ARZfymXSBanTkMEws4+KgMZhnd8sQ4oksY7nA+3Hgv8Tedxg0luANsaVca7XXcVcUvFbR+rRFV5YyzvtCmc1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bereza.email; spf=pass smtp.mailfrom=bereza.email; dkim=pass (2048-bit key) header.d=bereza.email header.i=@bereza.email header.b=mlrDwguG; arc=none smtp.client-ip=162.55.44.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bereza.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bereza.email
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bereza.email; s=mail;
	t=1775043677; bh=rGi3+b9PYSRUSUN6fg8GwyoE7KR890hxP+JIX+fz2zU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=mlrDwguGri0x0UDUD8Sxay4cdgmLeCaw4o5i6d7ogyvyzSOFpxWaXNmoYNCbbWTHW
	 BQpAaEjWbEv2Wq+CtgD3XzN7CxehHlcDabNyEnWg2KOCYlOvqXLUn2dBDcGtV6OHhs
	 5wBfjXBebpZA+c8yRJN46JV+FP4QucOXSdRBuDo69N28YyGoK5ALxGtF+8xMDRm/hN
	 T4M97sCiBu1/xm5WB6SmsVayhL+QqI5hoOgwUAa7LrLuXUIDQ3bDRdTXBG1Zw7Ogtd
	 lGWc6USRSKvVJkANUSiu1baHEdhTfElV8Hv2ro5ykEujlRBNewgvLhocKjrtgVvTy6
	 8vYcFm1WW6Uww==
Received: from localhost (pd95bbad8.dip0.t-ipconnect.de [217.91.186.216])
	by fsn-vps-1.bereza.email (Postfix) with ESMTPSA id 52AA95DF94;
	Wed,  1 Apr 2026 13:41:17 +0200 (CEST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 13:41:17 +0200
Message-Id: <DHHSGVWF7G9L.2SRDJY6GS561B@bereza.email>
Cc: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Fix CPU stall in
 xilinx_dma_poll_timeout
From: "Alex Bereza" <alex@bereza.email>
To: "Gupta, Suraj" <suraj.gupta2@amd.com>, "Alex Bereza"
 <alex@bereza.email>, "Vinod Koul" <vkoul@kernel.org>, "Frank Li"
 <Frank.Li@kernel.org>, "Michal Simek" <michal.simek@amd.com>, "Geert
 Uytterhoeven" <geert+renesas@glider.be>, "Ulf Hansson"
 <ulf.hansson@linaro.org>, "Arnd Bergmann" <arnd@arndb.de>, "Tony Lindgren"
 <tony@atomide.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260331-fix-atomic-poll-timeout-regression-v1-1-5b7bd96eaca0@bereza.email> <vA8GpbivDeKzKN1k0B6m1cvW-rZwJjKzvhksYdUJPo4fsfhLQoXtWoK59V1YX_U2U3jcVR2PAmzrleamvq8Dmw==@protonmail.internalid> <833bb42a-65b8-4c93-8109-d2959f8b807f@amd.com> <DHHOCNHDN27K.RIE745OFAACD@bereza.email> <kOnlFSDZQEhF3ojzQjMcbXIfkhwssDgozLNV7KPXr_zaZ_9QOifwp4nyFe8li-AkYulMsLHKXtgEBihiXHhCzQ==@protonmail.internalid> <f5a8ac32-3c65-4703-87fc-d0990839887d@amd.com>
In-Reply-To: <f5a8ac32-3c65-4703-87fc-d0990839887d@amd.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bereza.email,quarantine];
	R_DKIM_ALLOW(-0.20)[bereza.email:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9809-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@bereza.email,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[bereza.email:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bereza.email:dkim,bereza.email:mid]
X-Rspamd-Queue-Id: ABA5C379E49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Suraj,

On Wed Apr 1, 2026 at 1:15 PM CEST, Suraj Gupta wrote:

>>>> Hi, in addition to this patch I also have a question: what is the poin=
t
>>>> of atomically polling for the HALTED or IDLE bit in the stop_transfer
>>>> functions? Does device_terminate_all really need to be callable from
>>>> atomic context? If not, one could switch to polling non-atomically and
>>>> avoid burning CPU cycles.
>>>>
>>>
>>> dmaengine_terminate_async(), which directly calls device_terminate_all
>>> can be called from atomic context.
>>
>> Right, thanks! Just for my understanding: I still think there is potenti=
al for improvement, because
>> from my understanding it would be beneficial to do the waiting for the b=
its in the status register
>> and the freeing of descriptors in xilinx_dma_synchronize. Do I understan=
d correctly that this is
>> currently not possible due to how the DMA engine API is structured? To m=
ake this possible I think
>> the deprecated dmaengine_terminate_all would have to be removed and all =
users of this API would have
>> to be adapted accordingly, correct? So this would be a patch of much lar=
ger scope than xilinx_dma
>> driver alone.
>
> Yes, your understanding of xilinx_dma_synchronize()and proposed changes
> looks correct.

Thank you for the feedback on this. It is really helpful since I'm quite ne=
w to
writing patches for the kernel. I was thinking about whether I can improve =
the
xilinx_dma driver in this regard, but given the large scope of changing the
whole DMA engine API and all its users unfortunately this task is too big f=
or
me.

BR
Alex

