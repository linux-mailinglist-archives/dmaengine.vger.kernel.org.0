Return-Path: <dmaengine+bounces-8134-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD5AD06DB9
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 03:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B5BF300E3C2
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 02:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820BA314D3F;
	Fri,  9 Jan 2026 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVomjLhC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D03930FF1D;
	Fri,  9 Jan 2026 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767926031; cv=none; b=mRCUSNveeV+3yZesrYuYOMQilVEfWP+1JzLfMJ+1OPoW/4/mvfGzpkgsNlBDz7Ano4OVEiUz2w1itPpWxR87Nl/TIC1bsk5t83+0Md5B51A8riX+t3hVvILkn5xztocZA7xRbSSvHiGbAY1pVKNA7jVJQhjtAJL5ddDG2pQwvSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767926031; c=relaxed/simple;
	bh=UKYkPiFyNNBwE7sYWnWNClkXpzgVuyxBkB/AzfDgTcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHqe1sBGuaj9dLZY+dWQv/R4RQi2DrzzGfrUYwwnblB84hzQ8AVCUfcoqXndheBK97HXIpzqoU9cCH9o7Jn2J4XU1/UwRcm0xuEO0MnkkTR9HKTd2skNTzzDFZivcIe2/BG8USME3mTii4/0fU3U6sC07BMYAeudQlP7SmYvFFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVomjLhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D23C116C6;
	Fri,  9 Jan 2026 02:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767926030;
	bh=UKYkPiFyNNBwE7sYWnWNClkXpzgVuyxBkB/AzfDgTcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVomjLhCxoqgLjUpX2lrS6WRNOoaxfTEzs1ZE/sFpSGzTTXGcWVf+JeTyZtcg2ee7
	 KlmOcaRlqGbGhDKWPRlFYQbUq2DZsriNExRZ+SmPvS30cJiCNqM8d3+HsFfcxsQayY
	 h3nuuwc7IUMhZnE7awvORDtFp9R6+rzf7UWs4D08rwJsrYGA7I9M+/ECn0j5rXTclj
	 4TGq46LYWIs3Nc/vizqf3Q8Yq6ke2ByQ1a/vR+K7hrGofFv+azqSFzMP/z7sYhoAm9
	 Wn23wrAS17yEoWU7hc9VrdCMdoNgOQlA2sn+4nYsWVXZoKjXhJR7fTDSfYXOHN3l+n
	 0ZnriBXQeZGjQ==
Date: Fri, 9 Jan 2026 08:03:47 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] dmaengine: A little cleanup and refactoring
Message-ID: <aWBpC3un9BmJ6dYU@vaman>
References: <20251110085349.3414507-1-andriy.shevchenko@linux.intel.com>
 <aV9SJrOpQvRsJ3nA@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV9SJrOpQvRsJ3nA@smile.fi.intel.com>

On 08-01-26, 08:43, Andy Shevchenko wrote:
> On Mon, Nov 10, 2025 at 09:47:42AM +0100, Andy Shevchenko wrote:
> > This just a set of small almost ad-hoc cleanups and refactoring.
> > Nothing special and nothing that changes behaviour.
> 
> Any comments on this series?

Looks good mostly, seems to have a small checkpatch error, pls fix that
and update

-- 
~Vinod

