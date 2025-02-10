Return-Path: <dmaengine+bounces-4398-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C47C3A2EFE8
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 15:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18EA91888638
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5BA23CF09;
	Mon, 10 Feb 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqXSf3jx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3740E2309BA;
	Mon, 10 Feb 2025 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198118; cv=none; b=FbTPK3PjokztYbyBxwOXEWFOX6gDAnHkFJ0yLhHINJnssiSPI4dvPc0tFNFKsCL7SmseU4riaokZyo/V7L5oyt3Ex/BFSKsBFCfqNQxbE0Iy6ZWRfU4x/Fr094m4DOQtY5As6XNDKK9h/YE1rs3i+wDkhSmr9QJLWYHfg51dG7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198118; c=relaxed/simple;
	bh=XcHJif2FfnwAjAbH7baaX4yilC2v5vnNJYy1PFC2dr8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=erXmhK+gxKX3bMHtl6t3f2zs39vP4r6wq07HFVA+vTzX+iGnegaKSUPOWM5q4ja3PKBfnmlIIdWN0ukbtM4ktZFrgJ+6IwfxB0rT9z7ieQknrnLhItfgp/liBBGD5QANWUepte8pHLafxjEwL1xbPpveO3gssBzAz1SzgVX951Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqXSf3jx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B93C4CED1;
	Mon, 10 Feb 2025 14:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739198115;
	bh=XcHJif2FfnwAjAbH7baaX4yilC2v5vnNJYy1PFC2dr8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KqXSf3jxdv1BjMeENVN1I84vhH53dlRaeGCEoz3u4I+4L8YlFqZo+NfubU5dr1pRz
	 yw5tBwiU7NzeOEounrDA6MqfRsmXv8vpuw3O2smhmCWxjuXiNBuwghioUnHu3aZJb6
	 WbD5M7QghXYbVsoWDDtrWw6cRCd3eq4Z6ljpiugcR5zwLH6Zpg280oQnzefC2poblC
	 zr9ER9OT/yerqrg6MUw/sKSFTEmvzV+Fx6rG2ZStTJN1hRd1kOUTE5XEqsJVmaxQ61
	 CXX8DgwfjfvwYowbxAAI1yogJoiCtkIxNYk05vQvUDjyCsmwnVJuEUtAg2sUQYunMq
	 C3NCU3q+mfwKQ==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Stefan Wahren <wahrenst@gmx.net>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250205091455.4593-1-wahrenst@gmx.net>
References: <20250205091455.4593-1-wahrenst@gmx.net>
Subject: Re: [PATCH] dmaengine: fsl-edma: Add missing newlines to log
 messages
Message-Id: <173919811383.71959.2258535246777923144.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 20:05:13 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 05 Feb 2025 10:14:55 +0100, Stefan Wahren wrote:
> Not all log messages have a newline at the end. So fix it.
> 
> 

Applied, thanks!

[1/1] dmaengine: fsl-edma: Add missing newlines to log messages
      commit: 1c4c8609d498173382913b8ef6a105f3e6ff3472

Best regards,
-- 
~Vinod



