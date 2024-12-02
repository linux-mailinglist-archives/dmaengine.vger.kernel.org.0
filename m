Return-Path: <dmaengine+bounces-3863-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7769E0B17
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 19:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0153DB43913
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077E41DC197;
	Mon,  2 Dec 2024 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxzbKhbl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA61DBB37;
	Mon,  2 Dec 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160684; cv=none; b=j01NdEhV0NRWyW5uhvwvWZGum0PTgWWuNvnHMQ+ukC58IGNalwT0bq4divZy/bM5+UAxSMbM/2DJqoSN+fktEfYjYPKgrDqmI7tB+rSkW4gSeIqLvaFAE2jBUZw3GIlMesguwn4KtTCkUNOH04PRtJVDyj2TWw4unn0dhxk+PeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160684; c=relaxed/simple;
	bh=PGfz3qrJMnd9eKlqvVVsBvzsKQLdcXhr1djaPp3Fs6o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WNaRPNINnDJVbwp/4iPtjGqet8ccyfsXittTPQneYUftNwevd+hNwPGd5wiLyXXKtCB77JrO8U94g7T6qUUiYzPzM5lfV5X1pdJBHjNkY6e7sxeGug28HvbV1K/2t/FgFaT04CQJJnBgNpFARbuxzxIVfjvAXGp8aWdO7O+ymaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxzbKhbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FC7C4CED1;
	Mon,  2 Dec 2024 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160684;
	bh=PGfz3qrJMnd9eKlqvVVsBvzsKQLdcXhr1djaPp3Fs6o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JxzbKhbl0imGSOXaHzu9UhW6wd51hTdtK1XpV1qxuUzLBOPgS+5y+Gi3tvpoZl5ef
	 cIjKgj0NHW18oBSPiNms8LyOcoRFwi4tT+rd6OXs+WKo+y4AZpXv6Y3LnQhoI5bgYG
	 8L2KMg4DZqhE+vynBVIT99eb9Vew1PwL6N6YF+4zqvTAOGm0A+py6YKX3WOQqvf+dd
	 jxGHz4OqG++HQjSstKjw5obZxU1WYkhS/oHAcr+cPW8djDWaqHC/dkGugBeOADR6vf
	 G7/JOXehhhplpmNOyHSATvOrIneQUbpJgvrEvKWJ8C6Jjn3+GAznubhk27eso/q4lQ
	 ibs+k/Te4gPFA==
From: Vinod Koul <vkoul@kernel.org>
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 dmaengine@vger.kernel.org
In-Reply-To: <e08df764e7046178ada4ec066852c0ce65410373.1730547933.git.christophe.jaillet@wanadoo.fr>
References: <e08df764e7046178ada4ec066852c0ce65410373.1730547933.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] dmaengine: idxd: Remove a useless mutex
Message-Id: <173316068184.538095.12399702457018913277.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 23:01:21 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 02 Nov 2024 12:46:04 +0100, Christophe JAILLET wrote:
> ida_alloc()/ida_free() don't need any mutex, so remove this one.
> 
> It was introduced by commit e6fd6d7e5f0f ("dmaengine: idxd: add a device to
> represent the file opened").
> 
> 

Applied, thanks!

[1/1] dmaengine: idxd: Remove a useless mutex
      commit: 8d0191a6020e325a1c9730539dd2f0c03d71d9b4

Best regards,
-- 
~Vinod



