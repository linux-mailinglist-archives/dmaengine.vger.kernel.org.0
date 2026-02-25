Return-Path: <dmaengine+bounces-9077-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L+NOQvcnmltXgQAu9opvQ
	(envelope-from <dmaengine+bounces-9077-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:24:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 317411966B9
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7ED430372E7
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B958C394469;
	Wed, 25 Feb 2026 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuS2kFH+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FCE39447A;
	Wed, 25 Feb 2026 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018651; cv=none; b=lj/H7BntDKh5GgoYGDRL9wIsVrb8kVWHZSGOLZPFgoFt0uqB4Ku78MJ2Z6S+Oj6Floi9IoFsTWone6oLxIwnwYG50fXNXySvKjJJA6Cq7VSRJT1xc41MqldgvAJOzjZXWoIfhHbl6sFoS0WGbRSKhDegGUSfeJGwEJjCJ8rDVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018651; c=relaxed/simple;
	bh=w0t3HBg39hkW5eN5XKWeIPxBe+jpBk6uZWfkmh6G+RQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AYDkB2kkJ+J8lRMuPEAGnFlFWk+iSetifhAd1OLPKAn7gQGp8Cu01dCAM7LhBQi2xfLJzx3XoKztfPTCefLvmizLKZRbS1U6VXWPiXVgw+kfK3eE/4uGcNQF0CVeVRL84BY+59g28HSjSGtEeFwG3uwKLq0E8LJi2FBFgNVbh7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuS2kFH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82725C19421;
	Wed, 25 Feb 2026 11:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772018651;
	bh=w0t3HBg39hkW5eN5XKWeIPxBe+jpBk6uZWfkmh6G+RQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GuS2kFH+vGonAASw5cpR7VH3zLk/OXtq5pfZDHsMXD2uuu/YjsZgXp/+G26J/znQJ
	 UPYxvVmNzAG8inht9RBWtWsTxiFk2hPbucuzF/Z73oYUbA0kR/9EYEElY/rVDn9bBy
	 STDqEWsMW38pZT/IjYNBs9gr6FycFcIH6cY+S5ZpkOMxskSXs61T5oEb4LQyOpaysL
	 44PWRTZxB5bhk9xjBganTt1PRMHzosNFdgGeDTN1VnY6nLpe20vzPXdpUCvK/TJ/3L
	 YanJ+2eXBkZj+M+tXOy97ImyaJugZuR+IH4HqeRmMtZG0kxip6IRaehFo/Jf6wosmV
	 49o/8HmCAlg7Q==
From: Vinod Koul <vkoul@kernel.org>
To: Eugeniy.Paltsev@synopsys.com, Dinh Nguyen <dinguyen@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>, 
 Rob Herring <robh@kernel.org>
In-Reply-To: <20260131172856.29227-1-dinguyen@kernel.org>
References: <20260131172856.29227-1-dinguyen@kernel.org>
Subject: Re: [PATCH] dt-bindings: dma: snps,dw-axi-dmac: add dma-coherent
 property
Message-Id: <177201864915.93331.2089924813116515907.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 16:54:09 +0530
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9077-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 317411966B9
X-Rspamd-Action: no action


On Sat, 31 Jan 2026 11:28:56 -0600, Dinh Nguyen wrote:
> The Synopsys DesignWare AXI DMA Controller on Agilex5, the controller
> operates on a cache-coherent AXI interface, where DMA transactions are
> automatically kept coherent with the CPU caches. In previous generations
> SoC (Stratix10 and Agilex) the interconnect was non-coherent, hence there
> is no need for dma-coherent property to be presence. In Agilex 5, the
> architecture has changed. It  introduced a coherent interconnect that
> supports cache-coherent DMA.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: dma: snps,dw-axi-dmac: add dma-coherent property
      commit: ff7cbcca2b32c6e079941e577c41c74036861d5a

Best regards,
-- 
~Vinod



