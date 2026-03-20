Return-Path: <dmaengine+bounces-9552-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMiGIAQQvWlf6QIAu9opvQ
	(envelope-from <dmaengine+bounces-9552-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 10:14:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC27B2D7D5C
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 10:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C39503014973
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 09:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41D633D4F2;
	Fri, 20 Mar 2026 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8CaJ8cz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D9328B63;
	Fri, 20 Mar 2026 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998034; cv=none; b=uVAt8BeqW8xbtylFiGDFOU0mh/gZPSNDXDnz1AiZeBi9cKdB9nFQmfmnFfGRAtqXgd7WYceBawFpOA3wqzetxAcx0AAvtRCKPn+P45AS0eB5EEJJ4boWH0DmYhkcBitra5Nn/zVSyQ/x7OkyNi37YlkklbdyaF9a0EbDwXIrhXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998034; c=relaxed/simple;
	bh=tztxCWk/azlp9/3WAu9AIUNeDnzKJBRVMxT9Iapv/mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWxHRg+g0jUslru7ptjuUb5lBKUk7YtHfULFhdyBJvulet4rZwXX90YMFuXJhQFMDd2QbS6zv7s6E/X26xScMLnITOC3Qm3eY3VkqkFhxyd4DHTk6PsUNHkZ6AbIZp8jc325+rfEJ5kgNyKjUAIehdybgwt7REk5mq4k8QRvaMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8CaJ8cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBB3C4CEF7;
	Fri, 20 Mar 2026 09:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773998034;
	bh=tztxCWk/azlp9/3WAu9AIUNeDnzKJBRVMxT9Iapv/mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8CaJ8cz56Cn82Cp0dF240cxHxY0ifL+XnrllMgIfAUtfnIZ9FDm1CWa0kf6fjutm
	 NWTsdd8vEqKnwstWereLzRYx1SYxB768AXRync8tKLT5BC6IGEJnXIICFbdivoDyrd
	 +OPSkB/KkTO3HYFJWcfFEOLpiL5/rlTXcjZxt+0dQR3mYXX+H8kGEF3FEfjzM8IByb
	 9595AMSm6qR9XNTyumLe5x1HftBn64qy+VhRSBRUGdLCU1KoXIOh7ZYQJdqZYOcEb+
	 mfToFo/pemoKmGCdVoYJ/kpB/NxGvGFDL+bZ0tW0s31J3j37g2coQgPKtE+YcXzOXx
	 NchlYO+CKDq9Q==
Date: Fri, 20 Mar 2026 10:13:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jun Guo <jun.guo@cixtech.com>
Cc: peter.chen@cixtech.com, fugang.duan@cixtech.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com, 
	schung@nuvoton.com, robin.murphy@arm.com, Frank.Li@kernel.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cix-kernel-upstream@cixtech.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] arm64: dts: cix: add DT nodes for DMA
Message-ID: <20260320-attentive-turtle-of-perfection-c38ed3@quoll>
References: <20260319101723.246539-1-jun.guo@cixtech.com>
 <20260319101723.246539-4-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319101723.246539-4-jun.guo@cixtech.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9552-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.908];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cixtech.com:email]
X-Rspamd-Queue-Id: DC27B2D7D5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 06:17:23PM +0800, Jun Guo wrote:
> Add the device tree node for the dma controller of the CIX SKY1 SoC.
> 
> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
> Link: https://lore.kernel.org/r/20251216123026.3519923-4-jun.guo@cixtech.com

How useful is this link? It points to exactly same code, so what does it
tell?

Drop all Links from your patches and read the docs how they are used.

Best regards,
Krzysztof


