Return-Path: <dmaengine+bounces-9475-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PG1Bew6uWmvwAEAu9opvQ
	(envelope-from <dmaengine+bounces-9475-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:28:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E04232A8B46
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 211DA306572D
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F983ACA70;
	Tue, 17 Mar 2026 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFmUT6ut"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA763932F0;
	Tue, 17 Mar 2026 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746908; cv=none; b=WxREexQCFgz6UQfgiF20iT7QVDLYDaSDrSTF3bUyWp+64d6/f7gmLifPphUxPNinEvqAkrSmH5ZQpzSVRfGi67CbZINjVfz9eNMBktgWuBq/UBCVG9o+L52Ud318mq5T+HSaX3pj+7rhEMCfeJyEHucMpnX+HNJ/2G+KkkoJCOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746908; c=relaxed/simple;
	bh=4py1MVzG7VKGzhA3K9QBQHZ0QJsQyv4qAQ3ZBFkYMcA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g7MpfMHG7hv+DtXS7SnCLDGJNSfG3gcQQrFv9kszJGgvTCLbTV6QCcRjqu8c2tRYj3jhUj25dEjQYnyTR+yiZe2JPRpTIz5jOoNJKK2YXlAqj22IRxhEtvih0Fs4EXnaWFxvAo+KZaTYx2jmEqdLS3T9jCHdXIyc189E3rnta/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFmUT6ut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1290C4CEF7;
	Tue, 17 Mar 2026 11:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773746908;
	bh=4py1MVzG7VKGzhA3K9QBQHZ0QJsQyv4qAQ3ZBFkYMcA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UFmUT6utUb8CIpSQdAQP+tV4gjFL2+nZIL16gGOW1R3a4Ut53NTCQcsKCpCOM+frD
	 tDYD/s96rf5TfrSCu3c/gOd1nmqsJdq7JJVF2gWYFChlRCk3PtGHfmfkXM4mTAS1ac
	 uweLjqzXSBJVD/Tp42D2FuHhKwLU5lcts+eOOVwa5zwkvhu62AT5K2RbMEqikdfhjM
	 dK3GoJZ3Y9v9mXINHd+hha0BKSIlfQ4e7FJB2MUhgOnv4Xnsy5ZMiQ/YQph0eVUOh5
	 Zt6tHZZIcHulDuTk7ZKh3zVJIHuVSd6YcEeaSaNjtH3C6HVUN1IObEprMTVflceVIc
	 Zhu5FqNm+9KwA==
From: Vinod Koul <vkoul@kernel.org>
To: Frank.Li@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, michal.simek@amd.com, radhey.shyam.pandey@amd.com, 
 Abin Joseph <abin.joseph@amd.com>
Cc: git@amd.com, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260309033444.3472359-1-abin.joseph@amd.com>
References: <20260309033444.3472359-1-abin.joseph@amd.com>
Subject: Re: [PATCH v5] dt-bindings: dma: xlnx,axi-dma: Convert to DT
 schema
Message-Id: <177374690462.337210.3827619168842658001.b4-ty@kernel.org>
Date: Tue, 17 Mar 2026 16:58:24 +0530
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9475-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E04232A8B46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 09 Mar 2026 09:04:44 +0530, Abin Joseph wrote:
> Convert the bindings document for Xilinx DMA.
> No changes to existing binding description.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: xlnx,axi-dma: Convert to DT schema
      commit: 2d5c2952b972be1cc87c215a2636d208b5e483d4

Best regards,
-- 
~Vinod



