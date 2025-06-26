Return-Path: <dmaengine+bounces-5647-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E975AEAA11
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 00:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3045189EED5
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jun 2025 22:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9074F25D1E3;
	Thu, 26 Jun 2025 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5XK5TNF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A7225C838;
	Thu, 26 Jun 2025 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750978092; cv=none; b=KxosWkDkANycH+RhrZBtOAagW347BnnScc7s2ukV7HYhT4qjyZyL6c4ibVWmnaaobznDGF2DS5ZmtSjYwjCFmN2VIfgWIeGlFzYP2jBb2FqpZY1FVp53gJ+Ajsqj9enHCo+RNG9m3aeUxc32xpG3+r6qswZGwDspI171tTDEjq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750978092; c=relaxed/simple;
	bh=J12J5XfeZXyV18Vt+aK65OFuYooc+35vw7qinUAIPwc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Co7bXe3RalvxWz1xKbZsqvP37rsratkA9UogCAJfcUaNcrq5TlvoW8ag/XTR1BfhVS56n+QMUJb5TYAtBj+5cs8G/RS/ApN26NBODZmir0k5WY/+FV1anY+1CPUOcOZBIkpYK8kc76FpQjFKUq0M4NaG1aR0Dik+lz6Hyv3wOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5XK5TNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984F4C4CEF8;
	Thu, 26 Jun 2025 22:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750978091;
	bh=J12J5XfeZXyV18Vt+aK65OFuYooc+35vw7qinUAIPwc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A5XK5TNF7nG2MJrvWRBzheNSwEwPbME4cVUgiMnWY9TMn6qOxDnwLM7Sh0SAG8XFJ
	 xxzT58xL+vcAopSxKMO+WNArOTdT9cI1pJZlK+dZOo5acDmVBlayKaUUnXDWLKpsJ4
	 nhgYl5yJeCtDv6CpXxdv1CGPYmwhEefg1nkVQixU3ltuyS2i8mlchweNm0u63M9j/Q
	 qGQSV7n9U6XnWE//Vl6x954+CaAgcyIaGV3VyY7cL17pHdr9G7bDrbbgI1snJKDZ71
	 bXjLR49bH9G4xNmEYNzUjl+wlGkQ05T5nQkgWOkIKmelEc2AFVA9dttAgESaRjD1lb
	 sVWQBd2KnErPQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yi Sun <yi.sun@intel.com>
Cc: gordon.jin@intel.com, yi.sun@linux.intel.com, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250404053614.3096769-1-yi.sun@intel.com>
References: <20250404053614.3096769-1-yi.sun@intel.com>
Subject: Re: [PATCH v2] dmaengine: idxd: Remove __packed from structures
Message-Id: <175097809157.79884.15067500318866840512.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 15:48:11 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 04 Apr 2025 13:36:14 +0800, Yi Sun wrote:
> The __packed attribute introduces potential unaligned memory accesses
> and endianness portability issues. Instead of relying on compiler-specific
> packing, it's much better to explicitly fill structure gaps using padding
> fields, ensuring natural alignment.
> 
> Since all previously __packed structures already enforce proper alignment
> through manual padding, the __packed qualifiers are unnecessary and can be
> safely removed.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Remove __packed from structures
      commit: 671a654aecc710a278bdd30cfd2afef2d4e0828f

Best regards,
-- 
~Vinod



