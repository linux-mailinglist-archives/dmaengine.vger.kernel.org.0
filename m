Return-Path: <dmaengine+bounces-9080-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC9yLYrcnmkTXgQAu9opvQ
	(envelope-from <dmaengine+bounces-9080-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:27:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 334A0196761
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A694230514B4
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFD0394488;
	Wed, 25 Feb 2026 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un87D/TF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19733394483;
	Wed, 25 Feb 2026 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018661; cv=none; b=AXK70reVyrLYVppC1w6W4MhzsBEWvUGkhIE6F7IwNpNVdJheeCrykKz4xN3Ww8gQ6CQ9+cA0t/bfPkKX/QhtA8MqRFDEM3Fm+xp381zcv+W2FJN8OTyc0NAxcF6LdNjy8Vnn4jere/Eailvix7Dl7tGOnwPERDXbaKc+aumOW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018661; c=relaxed/simple;
	bh=lTZRQ6ECKIDCjnXoqV9NZawRVm0UDR+4Sn2CyOQl7RA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qxqI+FUacvP3SMOM9WFzc3N51uORR7qsCie9DGtwsCYMJR6F14appEdd+ZX4pshBqPMFDzIERyxQBdA7Jtfs/OSmC1aDkz1ovp5vJ90/5u6cKmx1YEova8uHL6KPK3X/SehiiA7LOA7AX/5+KFvA41fE/dL72NN/89AKXPrONyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un87D/TF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95E2C19423;
	Wed, 25 Feb 2026 11:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772018660;
	bh=lTZRQ6ECKIDCjnXoqV9NZawRVm0UDR+4Sn2CyOQl7RA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Un87D/TF1FyrERxhop9XHTXEyFDk5BBBs3KPxVtklEzCGhB+ka4G+VbNYBOZ4kNFl
	 UCFabHeQX1UvlVMRezvjqptNIJdtBEo7FDp80LgzLDoq0SkvY3ZGo/ZCrzwTs6bKMQ
	 d8WS+3Zvcr6virbHPysBrGOOHK2zBUssj2GKK3Be9xvso+BN9PWbo4jrikNA/v/w1C
	 3ym3Ti6+vC4+2ZF+Ty4etA9U92w9IW1F/x5ejMp43Z9EBJSFE3XakcanifF5G6BDBL
	 DrdSqMukVW8ld5u9UCIYpcVb0QehenMFUO3V2e2mYmR2iYuUA+skL3hKZfG/ky6txA
	 KUogtMxXbxvnA==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260109173718.3605829-1-andriy.shevchenko@linux.intel.com>
References: <20260109173718.3605829-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/3] dmaengine: A little cleanup and refactoring
Message-Id: <177201865938.93331.1579737459020105084.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 16:54:19 +0530
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9080-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 334A0196761
X-Rspamd-Action: no action


On Fri, 09 Jan 2026 18:35:40 +0100, Andy Shevchenko wrote:
> This just a set of small almost ad-hoc cleanups and refactoring.
> Nothing special and nothing that changes behaviour.
> 
> Changelog v3:
> - fixed checkpatch warning (mixed tabs and spaces) (Vinod)
> 
> v2: 20251110085349.3414507-1-andriy.shevchenko@linux.intel.com
> 
> [...]

Applied, thanks!

[1/3] dmaengine: Refactor devm_dma_request_chan() for readability
      commit: 4dd56ef8a26190f1735de9dddb854f175adbc6cd
[2/3] dmaengine: Use device_match_of_node() helper
      commit: db4709e19ba3d50ceeba9e01db373f672698ff1f
[3/3] dmaengine: Sort headers alphabetically
      commit: 9a07b4bb2c6019a8c585f48ee9b87fc843840e6e

Best regards,
-- 
~Vinod



