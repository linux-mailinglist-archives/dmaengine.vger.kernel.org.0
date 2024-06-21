Return-Path: <dmaengine+bounces-2496-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4996291219B
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 12:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C11EEB23CD4
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 10:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0461B17334D;
	Fri, 21 Jun 2024 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhW7pzto"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C581A172BD9;
	Fri, 21 Jun 2024 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964389; cv=none; b=pC5mONmRDeJsqqapm8o6i0C3qQt86pghiv2Vz9UUbyrphVjoi4KvrXVIVQY3NJ0hEsFY81H6QgfHmVgK+5NokH0891+DtNiV72QlGkHVJVkzzFZwF8jvz5O2FOIYPPt0H012DUAM9YOHD4Uet8mBB4b0HL4Lc8SKuNl/VJUwiZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964389; c=relaxed/simple;
	bh=1GKLKGeRzQY51YWSHCRfEazQ3RSI3b+fO3L2sCeLnXA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GEI6eV3U4x8ogwEcueEUhtbhjzr1gpJd1R8pckcgGD8gwSx9+bk5pbkTz8UC/sgf8A1poYIg7KOhw9dgwev2PiKLCQ+VPtCUtHy5Sm+vVe5/4ycGp71V1RjTMbBMcN+KePRMW/2R1E8kLJJ16L1V7luahSioepH9aJ+gk9BkO6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhW7pzto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C0BC32781;
	Fri, 21 Jun 2024 10:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718964389;
	bh=1GKLKGeRzQY51YWSHCRfEazQ3RSI3b+fO3L2sCeLnXA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JhW7pztoxJCkRjT1yLv7ThPWJWQqRkYgeFtNV8D6Vdr6R+6/OsZQDo4FBdUype8Sh
	 d318Thsws/swtFoXoebuAHdHMkwwdtZSYGGuZG+ihlFwVWLMbg/l8UsIL/rKKjrNpt
	 cLzKuxr9b6bPx1Z8lvJhPdGXgA3aACBsG82RZ+hIe1YR0TuVxRFELRYv+7QWnNzBag
	 RgVdmEQ7cOA4bzMw7jw9eFjm210ABRKiCqEayJ+0zjHURsdUbTsYSIQzWa0YaWdr5w
	 f2P9Av5rlyYQxEdk8NM/NN3GBJUI1PLV3X+sGnN4acoHbJQvpAoQHk10kHGtmO6Adr
	 qlkHePqiX3OZg==
From: Vinod Koul <vkoul@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Paul Cercueil <paul@crapouillou.net>
Cc: Jonathan Corbet <corbet@lwn.net>, Nuno Sa <nuno.sa@analog.com>, 
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org
In-Reply-To: <20240620122726.41232-1-paul@crapouillou.net>
References: <20240620122726.41232-1-paul@crapouillou.net>
Subject: Re: (subset) [PATCH v12 0/7] iio: new DMABUF based API v12
Message-Id: <171896438479.273533.11227587889239181030.b4-ty@kernel.org>
Date: Fri, 21 Jun 2024 15:36:24 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 20 Jun 2024 14:27:19 +0200, Paul Cercueil wrote:
> Here's the v12 of my patchset that introduces DMABUF support to IIO.
> 
> Apart from a small documentation fix, it reverts to using
> mutex_lock/mutex_unlock in one particular place, which used cleanup
> GOTOs (which don't play well with scope-managed cleanups).
> 
> Changelog:
> - [3/7]:
>     - Revert to mutex_lock/mutex_unlock in iio_buffer_attach_dmabuf(),
>       as it uses cleanup GOTOs
> - [6/7]:
>     - "obtained using..." -> "which can be obtained using..."
> 
> [...]

Applied, thanks!

[1/7] dmaengine: Add API function dmaengine_prep_peripheral_dma_vec()
      commit: 5878853fc9389e7d0988d4b465a415cf96fd14fa
[2/7] dmaengine: dma-axi-dmac: Implement device_prep_peripheral_dma_vec
      commit: 74609e5686701ed8e8adc3082d15f009e327286d
[7/7] Documentation: dmaengine: Document new dma_vec API
      commit: 380afccc2a55e8015adae4266e8beff96ab620be

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


