Return-Path: <dmaengine+bounces-7675-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6F4CC3F90
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5DD930475E0
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ABB33D6F5;
	Tue, 16 Dec 2025 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2hUAtWG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED7335558;
	Tue, 16 Dec 2025 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898600; cv=none; b=Tr/CWp3r7GofYKxOSXTOb4XTu14BBeiAVbkeV8KAr6vxvWP1QbYYlZET11H34kXk6NvoOVwZr/uIaeLIW9o8Ma/nFE4iJK308BmLbEGlnZH3m0/zgZ7SuN1pRgDgxKs/diYED8t/NYIgGROguMn4SsqnXZ2vXOTXrEYLQmimwgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898600; c=relaxed/simple;
	bh=poxxidryPk6pZK/7R6prbfZDAe3T3Jxk+yRbb7+zbYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUONqRMPw0kkZsyIi5rssn8S2+Q7FYQUrO2Y+dLFuq/HDzgvS8UwHZsrhPpz3OAl41jtVpUUrFYTDvA1CCyC82YY+lb3n+27I+z/6nkgXGKqNIhfxlJr/dhLVYEiXqS6VlFMenMHZXigA3JiFAXE7UAgiAzVpPdkWU8BMdWYdUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2hUAtWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE07C4CEF1;
	Tue, 16 Dec 2025 15:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765898600;
	bh=poxxidryPk6pZK/7R6prbfZDAe3T3Jxk+yRbb7+zbYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m2hUAtWGh/ZhYvhLzQJD5nDGxZcUUlbZb7CmgcDoCvNKUF+IAv+Qnb6lMHqgNxKet
	 E03W3k5V1kpZbchZhFRNWJzFYq1mtvdOO6DRog67tXia8bhsiG/qaVkIKMY9BND+fP
	 TFFjS65sk03LYvKFxrkIXB+ApvExEJ36vca0hTK/52FSOYZgvwUCFd+gK1gUpqAchA
	 RgWEljtp/ORo1DBKe34iZIc6quXgQjesxwjH2CvlqjYAmKrd3dvYB1MS5FWj0gkQXm
	 yl8S6ZHVrp0wcwV/7snN7HpFTWgGTGZttS4a7CjwXhJL0NpEUZhUgdzroxwu3PTBTQ
	 DCgNYSLYLpoFw==
Date: Tue, 16 Dec 2025 20:53:16 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "Sheetal ." <sheetal@nvidia.com>, ldewangan@nvidia.com,
	jonathanh@nvidia.com, dmaengine@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: tegra-adma: Fix use-after-free
Message-ID: <aUF5ZK7nTgPACXdO@vaman>
References: <20251110142445.3842036-1-sheetal@nvidia.com>
 <ovxny5nhgn2lnfq2bespxwzntkug7l7pwfwhrn47nc42nvtn2h@6fqgpmvbxfla>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ovxny5nhgn2lnfq2bespxwzntkug7l7pwfwhrn47nc42nvtn2h@6fqgpmvbxfla>

On 27-11-25, 10:25, Thierry Reding wrote:
> On Mon, Nov 10, 2025 at 07:54:45PM +0530, Sheetal . wrote:
> 
> Tiny nit-pick: there should be no blank line between the tags above
> (i.e. between the Fixes: and Signed-off-by: lines).
> 
> Vinod, is that something you can fix up while applying, or do you want a
> new patch for that?

Yep, fixed that

-- 
~Vinod

