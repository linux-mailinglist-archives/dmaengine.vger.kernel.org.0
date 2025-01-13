Return-Path: <dmaengine+bounces-4107-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 291A3A0B505
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jan 2025 12:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35043188635C
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jan 2025 11:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729F922AE5E;
	Mon, 13 Jan 2025 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="ohO9M+eI";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="Z2wGCD81"
X-Original-To: dmaengine@vger.kernel.org
Received: from mta-03.yadro.com (mta-03.yadro.com [89.207.88.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A061C1F00
	for <dmaengine@vger.kernel.org>; Mon, 13 Jan 2025 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736766198; cv=none; b=Tg1K02IjM/t6UZ7CFsJO45mVKGTAxwrsG6dsiyB6h1ppIZO6Jhq/XAjSMN1ZUt5bXKc7IqJQohZ3woB+2v76Sf6E2HNVWSOdbBnCsb+38hS8+Sp4HW4WXXlV55BRKsHM4LmKb/rfR+heMyt0s/dcYDsRJt6z75ojzCOBiCRITq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736766198; c=relaxed/simple;
	bh=Me/nSxERnjUpcvW1RFbqnL1F0jtPwooQphrvbWoXXE8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TB8cFnC5Hrpp6YlO6qYJ5C1ZSl1pYx5mZdDP8MAPTpC2h3UOp51JhnN8f9OEi/GDvqaGTAIFOdGzMozxPsIv1xSi86t6Iz3uzpM8tM/EOY5TEMPNDDcP7cJuxqAEMxLcUyVDtA0udEmUBkVw+S4ICKgOfgvzJqHB5GUJRybtj7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=ohO9M+eI; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=Z2wGCD81; arc=none smtp.client-ip=89.207.88.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 600D7E0026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1736765799; bh=GPkBzbEa74bl5EdCDEBHXIO3MAGG7toGPMqv8S0lHMU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=ohO9M+eIH81Gs8wmoM4Jstlex4u75e2ERR0QflVzbku6EA53OwBBN1Xr0PBjRjeOz
	 326bsSpSNqa8tzzB/mj/LRHcEQ2uhMnKgu4Nu7MEGwODqSR+JJjG+oTbETZV2MDmmo
	 HmkpA6m5329PtifGfw2F8RFesb3R/uaHTq8JZs+MpzsZJCbKDNybG/aHemmGQxluyg
	 s7DGm3MauS2a7L0TLcP6c6Uy1UbvdaDaM+/BgfGulRMvYdwDGy7z26r3i373krE3zM
	 mHamuYEHcXg3gmF4C0g2J37k589ZMQaIgAW2u1M4KEVjR/lkn/kdbQfPvTSGx56Ybp
	 ORE/dWNka0DOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1736765799; bh=GPkBzbEa74bl5EdCDEBHXIO3MAGG7toGPMqv8S0lHMU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=Z2wGCD812wkIH7w+lGI1I9nfaNHd9NgN6W1d2Q3LC4vUSD/WcmcuBn3m4/ykaUC5b
	 w7+n60x2N7GfEJbZfwCjmpAixa7ma9x4SMp9oBNea30N1iSkKcGXsWNeUt4Bo9fOlR
	 iuKIeUXsEcPn7OQsQivZllYYQ4QZD13HWoindrAAaZM9C+CLhYAae6YHQGM8msS1YR
	 /rZv+XnC8BuJBSANPkc+TluAgFusJZ9uqY32IH37/ugdIyh94ahdL54VofIqGd3cDZ
	 +qI5shAqyFxiHzAkMtOlmYYBnFm5z9V4DVP0Aoj6ALa4Srtu7t/6N6Ghe3lhM5LcnK
	 juHpbqFh9/Jmg==
Date: Mon, 13 Jan 2025 13:56:27 +0300
From: Nikita Proshkin <n.proshkin@yadro.com>
To: Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux@yadro.com>, Nikita Proshkin <n.proshkin@yadro.com>
Subject: Re: [PATCH 0/2] dmaengine: sf-pdma: Fix dma transfers errors
 handling
Message-ID: <20250113135627.7b245f92.n.proshkin@yadro.com>
In-Reply-To: <20241111152600.146912-1-n.proshkin@yadro.com>
References: <20241111152600.146912-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 S-Exch-02.corp.yadro.com (10.78.5.239)

On Mon, 11 Nov 2024 18:25:58 +0300
Nikita Proshkin <n.proshkin@yadro.com> wrote:

> Fix several problems in the sf-pdma driver related to handling situations
> when the dma transfer fails (for example, due to IOMMU activities).
> 
> Nikita Proshkin (2):
>   dmaengine: sf-pdma: Fix dma descriptor status reporting
>   dmaengine: sf-pdma: Fix possible double-free for descriptors
> 
>  drivers/dma/sf-pdma/sf-pdma.c | 106 ++++++++++------------------------
>  drivers/dma/sf-pdma/sf-pdma.h |   3 -
>  2 files changed, 32 insertions(+), 77 deletions(-)
> 

Gently pinging. Any requests/comments for me?

Thanks,
Nikita Proshkin

