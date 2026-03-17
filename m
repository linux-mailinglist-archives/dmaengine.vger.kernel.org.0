Return-Path: <dmaengine+bounces-9476-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFmRHt47uWkowQEAu9opvQ
	(envelope-from <dmaengine+bounces-9476-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:32:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABEA2A8D96
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBF3930E537F
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746353ACA54;
	Tue, 17 Mar 2026 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rItg2e/A"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426C53AB275;
	Tue, 17 Mar 2026 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746912; cv=none; b=toa6rXo2KPdPR4CaZwriJxqzqkhV8QNH3S2pcHOd9ZiteahpZ7/nZPzAW5zw+v/Q/+oIuhN2qc3ghV+BQAQk+4vX1zLhZB+fOiJxi0RcyJ3l2oddPRWIvbeJkMHJlir91Sz/wVRH2RxcLkRuKRQMDteCteh1sDWx6gRJliEf4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746912; c=relaxed/simple;
	bh=7MS7Odatrc28GGahSuXodA1j4BTKHK8U6ebok7EBrOk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NyH5VoSJ2q4zkVuT7nlUobsxFqwwX5iikMROA0Q7zF6V/zXF7IH126jl0sDEUzgaDD7T5oIo9OJekyisnsGa43px6/ZTZiyZfKDF4dOrD4San3we6ZxozGxiB2nYJ6VcEOj+6qM+hNrgRM6L+GKm+vxiydBwr8bdfhKyMtwpang=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rItg2e/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C054C2BCB0;
	Tue, 17 Mar 2026 11:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773746911;
	bh=7MS7Odatrc28GGahSuXodA1j4BTKHK8U6ebok7EBrOk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rItg2e/A04b4BF/9+cTtBd09SDdhWHkS0liklWLHDbem8dG1pEppzQxNAUUfE00iv
	 zBgkmuGMYep+Cw4deHFSo0I8XM3uPh+THS4aRmrRVJwGIYjBTMWRlQZXNwn9VEPH/O
	 JdKLffEtgWrePG9lF8QGE3db1/TSwD0zaOfZgh0+Kk32p9uKJTvVBJvRtuATaTSHNV
	 k6oTmoBLTm3YJiqHVH/9rQjCIQQNqglOFElKfX+KXdpihr3uvf6SBBHMBwftnuL+p6
	 /1Q6uL24MUCkksGOZwGJejV/zevX09JHrw1WGWmyR5VCQWyzHlT3BlgIRwOHvr5P+K
	 Fak4HUVfNsx+A==
From: Vinod Koul <vkoul@kernel.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 dmaengine@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
 loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>, linux-mips@vger.kernel.org
In-Reply-To: <cover.1772853681.git.zhoubinbin@loongson.cn>
References: <cover.1772853681.git.zhoubinbin@loongson.cn>
Subject: Re: [PATCH v4 0/6] dmaengine: Add Loongson Multi-Channel DMA
 controller support
Message-Id: <177374690827.337210.13271036907193844178.b4-ty@kernel.org>
Date: Tue, 17 Mar 2026 16:58:28 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9476-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org,loongson.cn];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,xen0n.name,lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1ABEA2A8D96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Sat, 07 Mar 2026 11:25:09 +0800, Binbin Zhou wrote:
> This patchset introduces the Loongson multi-channel DMA controller,
> which is present in the Loongson-2K0300 and Loongson-2K3000 processors.
> 
> It is a multi-channel controller that enables data transfers from memory
> to memory, device to memory, and memory to device, as well as channel
> prioritization configurable through the channel configuration registers.
> 
> [...]

Applied, thanks!

[1/6] dmaengine: loongson: New directory for Loongson DMA controllers drivers
      commit: ffee2dc04e7e06534aaa4fd51ef89645b809b6b8
[2/6] dmaengine: loongson: loongson2-apb: Convert to dmaenginem_async_device_register()
      commit: 7d348227f4961bbf21255281438ee3aebe12830f
[3/6] dmaengine: loongson: loongson2-apb: Convert to devm_clk_get_enabled()
      commit: bdf1621a6a67b6327e2a26a1d47bffcde3be3b26
[4/6] dmaengine: loongson: loongson2-apb: Simplify locking with guard() and scoped_guard()
      commit: 9de4303fc04977d15b257726a6519caca687c43a
[5/6] dt-bindings: dmaengine: Add Loongson Multi-Channel DMA controller
      commit: 7a65e81e8e2e58b0db9f2dedda410ee2b6042859
[6/6] dmaengine: loongson: New driver for the Loongson Multi-Channel DMA controller
      commit: 1c0028e725f156ebabe68b0025f9c8e7a6170ffd

Best regards,
-- 
~Vinod



