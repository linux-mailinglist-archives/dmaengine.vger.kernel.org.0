Return-Path: <dmaengine+bounces-9070-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPf8A9LbnmkTXgQAu9opvQ
	(envelope-from <dmaengine+bounces-9070-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:24:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F9519665A
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2383E3124DEF
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87848392C59;
	Wed, 25 Feb 2026 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3jmThW3"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DEB37B40E;
	Wed, 25 Feb 2026 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018463; cv=none; b=Vhf+cxX8BBtu3BFaAKfNIF1KVDhrdk+/XgRCzIUZ8dbKzff07/6lhspfMtZS8YA0JyXlwczssg12S1WBJbBCLqbyNEKQvVi7gcG7KXtuwJQx3MfaXwjyMQ5WkAm4ItUmEsJSnwcLuvOk6yjYZweYjw14+++Y7RodOY+2ruNSr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018463; c=relaxed/simple;
	bh=K1v+cMMQE7GuCgYPADnCo18a8KFBYp6JSy2KW4kwWDI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YL+R7mlTMDpoy4LGRIMewGchKrWWCWnYfpTXb5UN5Cy8xZPMZplT2WzhebrvdD8ztKX6DUnhaXXqyYjW53AaVGxQusp+9dfVcl1QLvVfhdjsUU1F7fKiZd9JsDSs6oeYMO/jFjlqFYDphXL7CaKmCUiqq5fR8t90myPIWfehI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3jmThW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70784C116D0;
	Wed, 25 Feb 2026 11:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772018463;
	bh=K1v+cMMQE7GuCgYPADnCo18a8KFBYp6JSy2KW4kwWDI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=D3jmThW3ih13pQFyGZxXjKfvFpkNFYWrqMPUltafTAG+IdlS0kBlfehQm6/I5uGEf
	 CBcQdi1sAusBSkoVDrxn+vsMUfE0SPtdR57xENXIDMxQc2SrFIAIeeC9wXT3g0pDWG
	 b/hp7FZwAlEQzToMgizi0Y08p/3xLT+fIwjmdf1TcuuuUg3XR/v00xUTiDfoWQ4E8B
	 +pCr7C8Jl6Ae4Psj/7LZXn4R71elyQYwiZYP12N09Z4Sb0oX3vdn3PuL4oxvHD4/+t
	 FnmNGO0IswZ8YA+JZSSR+Ct4wva2YqSovs9/i8TawSm9YIF5l8e9BQG0xU6/zlDVD7
	 5TRiRq5x8Prjg==
From: Vinod Koul <vkoul@kernel.org>
To: Frank.Li@nxp.com, Shi-Shenghui <ssh.mediatek@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brody.shi@m2semi.com, kevin.song@m2semi.com, qixiang.zhong@m2semi.com, 
 tom.hu@m2semi.com, richard.yang@m2semi.com, 
 Manivannan Sadhasivam <mani@kernel.org>
In-Reply-To: <20260209103726.414-1-brody.shi@m2semi.com>
References: <20260209093642.273-1-brody.shi@m2semi.com>
 <20260209103726.414-1-brody.shi@m2semi.com>
Subject: Re: [PATCH v7] dmaengine: dw-edma: fix MSI data programming for
 multi-IRQ case
Message-Id: <177201846009.86127.5800129460585896515.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 16:51:00 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-9070-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 83F9519665A
X-Rspamd-Action: no action


On Mon, 09 Feb 2026 18:37:25 +0800, Shi-Shenghui wrote:
> When using MSI (not MSI-X) with multiple IRQs, the MSI data value
> must be unique per vector to ensure correct interrupt delivery.
> Currently, the driver fails to increment the MSI data per vector,
> causing interrupts to be misrouted.
> 
> Fix this by caching the base MSI data and adjusting each vector's
> data accordingly during IRQ setup.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: dw-edma: fix MSI data programming for multi-IRQ case
      commit: 77b19d053ac2cce9e873007ad4b09f2323c93576

Best regards,
-- 
~Vinod



