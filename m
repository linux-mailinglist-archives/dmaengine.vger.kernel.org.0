Return-Path: <dmaengine+bounces-3025-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B29964CC8
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 19:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FB51C228ED
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 17:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E6A1B7903;
	Thu, 29 Aug 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAyNDAN0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746AB1494BD;
	Thu, 29 Aug 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952633; cv=none; b=L2i2CeD0ezvV2f88dBa5RSFt6YZThZXWx54plF5SbgX93Q5Yfm+2+228Q/I/SPVzzdbb4jFUUZlF72/T8OLtTal8EAcKdN2EQFKs9y63V5vK+0M9nUQIfi1n40XGfgU3BeLLHQ3oX6VCDeKBHNMAiZVQe3IYfv2rJXo6OWgtFbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952633; c=relaxed/simple;
	bh=0DKsWWtD98DXeeHZ/Lq4dI+NGfCIWVAYsiA73B5uPTY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M1ybqFlzqy1U8z61a74OjuUZx05yz/Z//S6XnrAC7m5Q1Jv7qmzxUgYIJT4cqqr8LDq0/MTfqfcHswF6XvJUNqWvvNZZGBq1k6zfJRiwfmYMbrHK07m1Ortn46o0uK0A0huMltEW0R63VAj8w0R6Nx5oHvohEz/2w9mO9WagCHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAyNDAN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81825C4CEC9;
	Thu, 29 Aug 2024 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724952632;
	bh=0DKsWWtD98DXeeHZ/Lq4dI+NGfCIWVAYsiA73B5uPTY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MAyNDAN0YwAJwZBq+kC4JvFwZDNifbGh2drFVbaZq2cW4DDpZ3xsW7C98dwMW0BGY
	 RYUZCPa1IPMUqWKhuS73Gd6sIpePgmni9g/m1QuX/CHxOLvAV0KIlyRUxh4p6thNd2
	 +nNnDjd7KOoFuALLs1rPi9lTXMl1ATtcYDyAaJdWgAUTsMkpdW/bVjkZw/FvR/ud21
	 d+SlmYihwplsAlQBwLaz1F8Klsn8ttI8eZipQ9YKnQ5YjKQwRyj21z+JB3v4cU5IE+
	 zU9KqqxzUPjbbH0J8Mh09R1MpHgWN5OEg5zBj26fHs400Ufps7RxgF4ndFKpsFLoBq
	 AVhQT+EtrEBPg==
From: Vinod Koul <vkoul@kernel.org>
To: michal.simek@amd.com, robh@kernel.org, conor+dt@kernel.org, 
 krzk+dt@kernel.org, u.kleine-koenig@pengutronix.de, 
 radhey.shyam.pandey@amd.com, harini.katakam@amd.com, 
 Abin Joseph <abin.joseph@amd.com>
Cc: git@amd.com, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240808100024.317497-1-abin.joseph@amd.com>
References: <20240808100024.317497-1-abin.joseph@amd.com>
Subject: Re: [PATCH v2 0/2] Add support for ADMA
Message-Id: <172495262916.385951.5476247700148608614.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 23:00:29 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 08 Aug 2024 15:30:22 +0530, Abin Joseph wrote:
> Add support for Versal Gen 2 DMA IP by adding a compatible string and
> separate Versal Gen 2 DMA IP register offset.
> 

Applied, thanks!

[1/2] dt-bindings: dmaengine: zynqmp_dma: Add a new compatible string
      commit: 36545c6a68b858671cfeb71df682e8cc58b082da
[2/2] dmaengine: zynqmp_dma: Add support for AMD Versal Gen 2 DMA IP
      commit: 13113f750a4ae0b1770fa25dc94852977ebfb942

Best regards,
-- 
~Vinod



