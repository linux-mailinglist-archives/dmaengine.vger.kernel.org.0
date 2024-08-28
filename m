Return-Path: <dmaengine+bounces-2980-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508B6962818
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 15:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C77C9B23D4B
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 13:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51782186E2A;
	Wed, 28 Aug 2024 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="betqoZdk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296C8187FFE;
	Wed, 28 Aug 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850006; cv=none; b=Y3WnI9r8DnCvUfhbWMruPJF5v/p1qUoykc1iYIf+D2T3LImBcvFX80KBh/ZtVtHwqEo1cpFgrjKWmvDgyqIGAql4DCfe6o/7e+LnUWfYFt0qIS4M8ylp3Y2ScSXbd6SY5q2wFdr0cKtxRPLyUSvtEz6iy7rELCZC1dhSBtZkTcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850006; c=relaxed/simple;
	bh=ppXGUx4gumiCTouLnD4h6rIEnTuLgLZpmcVndMBlmvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJc6E+3XvGBcSaORRs9CBlaafNTrcHapU4Oz1bHquSxHkuF7r5eCHyf9fdulkx11zrmvQZwx1soYLqKQU184iUrECdLWyk4AtAF3Q50oXlR02s1NICoGxW8qLHNmhLdMLzBUlTMCPGZEaatfQAMR+9OOu4vzCzaTAfB1yRQkVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=betqoZdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF39C4CAC5;
	Wed, 28 Aug 2024 13:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724850005;
	bh=ppXGUx4gumiCTouLnD4h6rIEnTuLgLZpmcVndMBlmvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=betqoZdkyWFU8S5dAIdP788j3bwcSCDi16RBcuhSVwLkjpAfZwuyjbMwAmRws2xMf
	 NsWFgItYSLDaKC0uCbIAZcqHl0Ol6T8Q84V9ba8hdj9M6WzrWyCuwXqxiIKf6Ycmsb
	 LtG0xfMeUkDeNMbF4XK8b1uDt8lyoOLAfYXEYgyKKDKZzu3AcfLWTYJ2V3xi+du7Kz
	 E+8R3q9I3miGvKh7ILVX1GRYCVCF+LgxKaj6oWvY3su4CWrZtJRs6Yo8vvpGA3zD3T
	 ZzwldT60y0tpZEVHlSSPoOoRTTkLEITVAdMR3d3uEphGYFBXjHqA7LkhTm1CvJ3PFb
	 1mQCwHJTLkkXA==
Date: Wed, 28 Aug 2024 18:30:01 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] dma:imx-dma:Use devm_clk_get_enabled() helpers
Message-ID: <Zs8fUQujVbIswdnr@vaman>
References: <20240823101933.9517-4-liaoyuanhong@vivo.com>
 <20240826122156.27038-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826122156.27038-1-liaoyuanhong@vivo.com>

On 26-08-24, 20:21, Liao Yuanhong wrote:
> Use devm_clk_get_enabled() instead of clk functions in imx-dma.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
> v2:use dev_err_probe() instead of warn msg and return value.

This is not a way to post the v2, please post a new series.
While at it, please se dmaengine: imx...: Use devm... Please pay
attention to spaces and formatting as well

-- 
~Vinod

