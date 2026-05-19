Return-Path: <dmaengine+bounces-10562-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDIWFNyhDGq8jwUAu9opvQ
	(envelope-from <dmaengine+bounces-10562-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 19:46:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C7E583461
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 19:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F5F6302514F
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 17:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8D234389E;
	Tue, 19 May 2026 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iutuC3Tv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B842934389A;
	Tue, 19 May 2026 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212443; cv=none; b=SrvCfv00sqMjkVfhmT95HS926XaLZV2CnpTnyAPyGDgfz67N53taZwAmzAPLrLUBWrByZovPJvdNXp/06kd2ID1HZ8JjRCLL9Q7q1mYdInB/7+hmLUoHBu5WeAqbd8Bn/mll/kkVdm7GYdfu6JHzulQ8ywzWJ0u4O6Ot0N4J3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212443; c=relaxed/simple;
	bh=7smRnSHfNvExkO2Pj5cOfs+RyrAV+X1clOUXFHPWAZU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZQuViBBgXu6qmSAnX8voeQ5EcBXWAz2Zy/GSoV14OVBl+0sOBsARQtoMT9R+MWHIIMjSVwqt/E/bNKkT3CarqVcvxlVBILVc9Ij1dxhXFneYWXQ7gR9VGLQml9efkzVoxFAuQATafv8QbGQWC4SV4HgYiQig1QP+bHYfAF3boTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iutuC3Tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69ABC2BCB3;
	Tue, 19 May 2026 17:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779212443;
	bh=7smRnSHfNvExkO2Pj5cOfs+RyrAV+X1clOUXFHPWAZU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iutuC3TvI8WuqNPrqNpjS27MgPyFCu0C3Jm0W6Oy/p0vXYeCh6BUVbRbV4h0nv819
	 8zc2Qa3i0X2p0AKmXXt8QkvgXqrhVuQqSAh+iozlmsszbcyHJDVyLuH8OYGQ3BMSRb
	 RydFYg/zC+ha+pJi6PCNKawAde+gwqDHw2DaS0uuh2dPsD/Cz+w8MmDmqXiboLHucF
	 AZzKQzMnZriDYktV8DoWa8dqBRJnoZSblQxa1EXIl3m1tRxJRbek248QQaAUUVxk2y
	 2/apHya7wZf1nKxAwLT2OONYa3SgOzftTuR3uHyABlGh0u9LQiJv/4iG6NpgB3h5Y5
	 tvevMppmBdqiA==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Frank Li <Frank.Li@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xueyao An <xueyao.an@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260401124028.589931-1-mukesh.ojha@oss.qualcomm.com>
References: <20260401124028.589931-1-mukesh.ojha@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: dma: qcom,gpi: Document GPI DMA engine
 for Hawi SoC
Message-Id: <177921243931.339411.13386216899817681145.b4-ty@kernel.org>
Date: Tue, 19 May 2026 23:10:39 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10562-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E6C7E583461
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 01 Apr 2026 18:10:28 +0530, Mukesh Ojha wrote:
> The Hawi GPI DMA engine follows the same programming model and
> register interface as previous generation of Qualcomm SoCs like
> kaanapali, glymur, and is fully compatible with earlier GPI DMA
> implementations.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: qcom,gpi: Document GPI DMA engine for Hawi SoC
      commit: 998514806998f76d367f935940d0c5e5e5cd12c6

Best regards,
-- 
~Vinod



