Return-Path: <dmaengine+bounces-9289-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDWxGVIlqmkPMAEAu9opvQ
	(envelope-from <dmaengine+bounces-9289-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 01:52:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA1321A089
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 01:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91C5B300A673
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 00:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D99F2F12CF;
	Fri,  6 Mar 2026 00:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7B3JtXo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5980E8635D;
	Fri,  6 Mar 2026 00:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758348; cv=none; b=M5ZelEbonqKAArqLBWZWdkxGkgMakDWEMcoUbrEz6ZHXj6oaHAMP/ksGMWuLTwjGe5t68O9f2UvtB8EUGKy2V85OgqR/8Ja+cQVp4jTm2Vxz974/GB+8KVivgqvRaphC8WXmJkYGEKNC6W2IYlDMHtOXsLnDzOBgRcwhMGhqREc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758348; c=relaxed/simple;
	bh=UUTNhv8aBYJM/+Attg0iaFqxl2VS+N9B5RaZRXbfJ04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4c0IAKPGF4R2MgPF++3NEkfQdT2FHyNbfBPOrhHxAerkFP3abNcOAWiN16NGbT4jzik6wzCr6Qn4NjBVHloeFM+BPCjRSh9azRJyAcazuwyUpNbn+0VQ9VxRy8Pm9l+99+vTCgJy7Fd1RTj0MGXNykqsQaBWZXYAFuD1/sXQ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7B3JtXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74260C116C6;
	Fri,  6 Mar 2026 00:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772758348;
	bh=UUTNhv8aBYJM/+Attg0iaFqxl2VS+N9B5RaZRXbfJ04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q7B3JtXoHw4e+m0A/AhSwnw76iAsusTDdOsHm2ncK+OPWd8zHgsJmWpAcLHapHweM
	 7qZ2YghVZ6xlvSWlZrVvT8005RnbfzAU2YcXDnAGCXUzk/bILdtbSR406VhRq1jbti
	 F1K5jy2Didd6Bt6HYl0nFZk8EU2w8sJSQalTvdPDLkLSGd75uDwNK/tWnk1aRPhca7
	 CEgJt5MMhoNs8IC7RFor2TTA6Bs4AMExPJAMi2sgA3AGTisaMZWna8QDqIxhg+9hau
	 JuVhvcMqkbwlIUp5TCDzUzG9tYTdShA1Ov+MCYb20P4LGaujgmjQB1pAax3MfosuMG
	 F/Gosp8CzqdTQ==
Date: Thu, 5 Mar 2026 18:52:25 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, dmaengine@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Xuerui Wang <kernel@xen0n.name>, Frank Li <Frank.Li@kernel.org>,
	devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
	Binbin Zhou <zhoubb.aaron@gmail.com>, loongarch@lists.linux.dev,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 5/6] dt-bindings: dmaengine: Add Loongson
 Multi-Channel DMA controller
Message-ID: <177275834494.880921.341794128592716386.robh@kernel.org>
References: <cover.1771989595.git.zhoubinbin@loongson.cn>
 <37c29c43b8acb406a3d20c4575da7d4f1163d812.1771989596.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37c29c43b8acb406a3d20c4575da7d4f1163d812.1771989596.git.zhoubinbin@loongson.cn>
X-Rspamd-Queue-Id: 5FA1321A089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,loongson.cn,xen0n.name,gmail.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-9289-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,loongson.cn:email]
X-Rspamd-Action: no action


On Wed, 25 Feb 2026 15:41:10 +0800, Binbin Zhou wrote:
> The Loongson-2K0300/Loongson-2K3000 have built-in multi-channel DMA
> controllers, which are similar except for some of the register offsets
> and number of channels.
> 
> Obviously, this is quite different from the APB DMA controller used in
> the Loongson-2K0500/Loongson-2K1000, such as the latter being a
> single-channel DMA controller.
> 
> To avoid cluttering a single dt-binding file, add a new yaml file.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../bindings/dma/loongson,ls2k0300-dma.yaml   | 81 +++++++++++++++++++
>  MAINTAINERS                                   |  3 +-
>  2 files changed, 83 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


