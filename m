Return-Path: <dmaengine+bounces-7701-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B75C6CC4807
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 17:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EC23300DBA0
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFEF311596;
	Tue, 16 Dec 2025 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DE0SgbaP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9BC298CC7;
	Tue, 16 Dec 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904376; cv=none; b=EIBQSkAdXfwAmxdUbEHfV/tcBRL3rJHTPKW6d6RHm4QvGAoD7g+8RK1rwIj4jsHnMeTcYLGT11LTnzwde1SjNrWvpGu7TtdBaV3cfxTk/ZrruC0uTOW4qpgCS5E5WEM8euje4z1ve3kybv5wuzLnnDczqn0ZzEFgz5AGITZRAN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904376; c=relaxed/simple;
	bh=e1C4KOJTl9D5pOlMuNTV416mojlmAUnXOpvyfNikmb4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hQi+4ODKQZlaE6f1P1Q9eWiJrKD/6LrYAoLk2bQiSH+qKa69mF7YR1dANXMhGQ14ZZ1BpvjCg5GQDAgHnRMCwvaMT6nB/70pJCphCfhzo+0bYrNMcxkGAFpQKE3XE9RmksRhBI6lGvpbMGkRL68xZGE5x0QSHGyxSBmRm7Y+oQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DE0SgbaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E4AC4CEFB;
	Tue, 16 Dec 2025 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904375;
	bh=e1C4KOJTl9D5pOlMuNTV416mojlmAUnXOpvyfNikmb4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DE0SgbaPscxem7LXCKvGGmT2w7b5gB+1OD1ZZeYlMbTpbDM+1T2+w9d5+44PDhb1y
	 jovZhAEI3LtdSVaBy2zJ1HIjscLiHO04iBY0yFshtCkopzUn7SHy/g+wi5l4+kj8xm
	 kgNz0YHNU0K2+y/gvllRqy0co4dn7plTL7KIN1mml5TZq4rhXmDFSYAl0S38yh3fGp
	 LiRbMF2e8MwXv+rR6bP0RI3Uj9V+dRjMFsf82VcU9vimFIUTnoMiBZ5bHfApIUOrtH
	 5kcyue52li0vZsZf3tFhFSQYhjQozCneXUw1NZ3wBoIfZmS2u1Niz+bO7eCysJKItZ
	 1u7Bn7lATco6w==
From: Vinod Koul <vkoul@kernel.org>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251125015734.1572-1-chuguangqing@inspur.com>
References: <20251125015734.1572-1-chuguangqing@inspur.com>
Subject: Re: [PATCH] dmaengine: pl08x: Fix a spelling mistake
Message-Id: <176590437425.430148.17782339414981482942.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 22:29:34 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 25 Nov 2025 09:57:34 +0800, Chu Guangqing wrote:
> "Accound" is an archaic spelling variant of "account". It had completely
> fallen out of formal use as early as the 17th century, when the spelling
> of Modern English became standardized. Here, it is corrected to "account"
> to enhance comprehension.
> 
> 

Applied, thanks!

[1/1] dmaengine: pl08x: Fix a spelling mistake
      commit: bbfb8677d31a78a898c8d02e3ca58790b89a6dda

Best regards,
-- 
~Vinod



