Return-Path: <dmaengine+bounces-9496-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOzOE1qOuWk5KQIAu9opvQ
	(envelope-from <dmaengine+bounces-9496-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 18:24:42 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF13E2AF804
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 18:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB7B9308E86A
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536192EF67A;
	Tue, 17 Mar 2026 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="aTN8Yiz9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963862DF132;
	Tue, 17 Mar 2026 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768050; cv=none; b=I258Lh7PjOK1Xlp/sIuhgPBGwGIzDI3IK9jQ1QQwQrQXGETnn7PcCRKi0X5Blp4qTd8WE4IRWQW7Bfd79PgbXBB9UNu3tekOpF6o/L9OKCLK/LLMSP44M8nu7JUKSvRaXYZokH56ApY1MHczRJDDfjm3ynUrrolOdLJH2fB7cOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768050; c=relaxed/simple;
	bh=E8iGa2mmDPj3sCEE2QV26eCTzbwh+nIaRgunYN5pihc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShepaxZA1ii91uMrYMQgdPUfhi2BBQQhGtTXsUFOewguka5qDeflxFiYDAV/EJGDU7zSIGwG8u+PzgG3QtJNs880bsYerrQ8w03epectAY/0bMlt3a+sDYL+f408kBfihDi9mIxcoQ5FNfgmvr6eXJDH63+nBUDhv1kfbTDzg30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=aTN8Yiz9; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 32A7B10D90E;
	Tue, 17 Mar 2026 18:20:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773768040;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ER1Wx1cLo48PWOXiIHDwWNLWadUbn+AOiGeXP4sXszM=;
	b=aTN8Yiz9hBMF4UUOfecSjMgGKpOQg0aHaiq5TV18OviysEmB/UfIMUyjcmqtUDXz5D6A/E
	nGDdBoX8T+CpT3lja3J+SQCvPNghVsCzjymc2+n4kJjSH8d4OZJAWZcM45yE0FeySYYEbf
	TbWHPhT+bVQshlQdewle2AMdqY/maZU4e3OSbv/jdnuOPpNsBmAnLRLgUmIkzKSaGlyD8G
	d2no3yitMLOA+eDWgStEKyQoFrxW0LHv1SVcw/LshGyBJMRzdol97OMob+I+Cq1ml2tPub
	55TUfBDxBp0jCklBSNwK1L+tjtlv04hloidZ21C3FYJoa9z6u+xlRz3Vb0Fb0w==
Message-ID: <6ad18fb7-75e8-4ef6-909c-0f2c356fa8ac@nabladev.com>
Date: Tue, 17 Mar 2026 18:20:36 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction
 reporting via device_caps
To: Rahul Navale <rahulnavale04@gmail.com>,
 Folker Schwesinger <dev@folker-schwesinger.de>
Cc: Rahul Navale <rahul.navale@ifm.com>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 vkoul@kernel.org, Frank.Li@kernel.org, michal.simek@amd.com,
 suraj.gupta2@amd.com, thomas.gessler@brueckmann-gmbh.de,
 radhey.shyam.pandey@amd.com, tomi.valkeinen@ideasonboard.com, marex@denx.de
References: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
 <20260317104933.4846-1-rahulnavale04@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260317104933.4846-1-rahulnavale04@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,folker-schwesinger.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9496-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nabladev.com:dkim,nabladev.com:mid,ifm.com:email]
X-Rspamd-Queue-Id: CF13E2AF804
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 11:49 AM, Rahul Navale wrote:
> From: Rahul Navale <rahul.navale@ifm.com>
> 
> Hi Folker,
> 
>> Just to double check, and to make sure the regression you're seeing is
>> not a combination of any additional, yet unknown side-effects, could you
>> perform one more test?
>> In dmaengine_pcm_pointer() (the function we just patched), could you
>> replace the call to snd_dmaengine_pcm_pointer() with
>> snd_dmaengine_pcm_pointer_no_residue() while keeping 7e01511443c3 active
>> and test if this fixes your issue or not?
> 
> I have performed the test (replace the call in dmaengine_pcm_pointer()
> function of provided patch) while keeping 7e01511443c3 active.
> I see issue is fixed audio is working with this.
> 
> Hi Marek,
> 
>> I came to the same conclusion, that the residue handling is broken in
>> the xilinx DMA driver for cyclic transfers, and the fix is below, with
>> two extra fixes in top:
> 
> I have tested the provided patches the audio is not fixed with this.
Do you have any other patches applied on the xilinx DMA driver by any 
chance ? If yes, make sure you only test these three.

