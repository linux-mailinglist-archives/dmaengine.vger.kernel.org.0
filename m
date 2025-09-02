Return-Path: <dmaengine+bounces-6320-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F63DB3FB1D
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 11:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7BF483AF1
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 09:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388E527AC2E;
	Tue,  2 Sep 2025 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYzAFZ38"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1048023BCEE;
	Tue,  2 Sep 2025 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806587; cv=none; b=TYNmXkcfMloxSLyNUDOtlFPKUKhPy46VaIQ+sa65WTkOc6KjuqEYX8s0uqWy3/NeaOeac+QG/87ryFmnwRp3D+GIQ14se0Kf1ZcdePKzgK0EtOpta9eGmR9aRur1fkuxeMW1XTLwf/8W5tNLgdhd+7cFWoS3RPoVBPirNID2zFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806587; c=relaxed/simple;
	bh=oiC77Gt5Bj8xCAydKBJRED6CaafusXzrJw9yIWxwsDw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MwesOTSaBhFnhc0mJzeQn4P8DQtkxYFWkzehYHq+lv/YsslBh9kQIVQn1PuGHDXNrzAq+WnJjyJ9VkuPP6wIBEbxW6YouS9GBLZy1ZU9wfDmTt6c3iAITixI10TJevHR5bBm7drBqQkfk7LAurSafSGfSwr2oRns9iNx2j7RxBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYzAFZ38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9B7C4CEED;
	Tue,  2 Sep 2025 09:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806586;
	bh=oiC77Gt5Bj8xCAydKBJRED6CaafusXzrJw9yIWxwsDw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tYzAFZ38V5G6Gt3eTwgJvUQUA7ZPqTjMvC3nQOZ/EyjmYUBXTCYCw8DaoGrJdvjYM
	 bZyBoyzCstWCUjYVf3TS4iak2Qr/3IL6VIbDPwQc6LLegOdZp/vFyqCPgYTRDsncr7
	 kI9CawhkuRWGTeyPunYkMRiF7/TgHZ7SuU6BUA0hLpcuE0OGQl8hd2YyA4FowukegJ
	 sZdOHIl4Wpwd1FYlGXuBJyu3v8FtADzdkv8R15Ip+dilBj3RQ8uCz11iTwfdSU8OYV
	 MGEvVnpHDhVcJdgY4LqalvPG/MIpfwXwGQ17c9LtA8QKsb0WFbnl3DGFlrCOBsAT4K
	 C1oOOVJXtQPqA==
From: Vinod Koul <vkoul@kernel.org>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, 
 Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250830132633.1803300-1-chelsyratnawat2001@gmail.com>
References: <20250830132633.1803300-1-chelsyratnawat2001@gmail.com>
Subject: Re: [PATCH] dma: Replace zero-length array with flexible-array
Message-Id: <175680658329.246694.13588903495066267713.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 15:19:43 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 30 Aug 2025 06:26:33 -0700, Chelsy Ratnawat wrote:
> Documentation/process/deprecated.rst suggests that zero-length
> and one-element arrays are deprecated, flexible-array members
> should be used instead.
> 
> 

Applied, thanks!

[1/1] dma: Replace zero-length array with flexible-array
      commit: 981d4978ff09d13690739663b3cd71ad8bb5ad94

Best regards,
-- 
~Vinod



