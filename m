Return-Path: <dmaengine+bounces-1782-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E0B89B320
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBE51F22BDB
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E8144377;
	Sun,  7 Apr 2024 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpKp7MLl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995F54436F;
	Sun,  7 Apr 2024 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507972; cv=none; b=ArVUnnr0s01a9FAnDZ7ZFIG7XgoBSUPpYZv701x+d5QRM/UAB+FXbrP843lSOvXWu2cTj4FmZkxJrQpSc+yNRRVf5+tH9wyTl0OcPLBaVCRuTRiemz7KEyR1jKUJMxd3yTl7ec5u/KFPzVkQcQxGGU9oIvDgTw7cw8OzVGE60EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507972; c=relaxed/simple;
	bh=aYE0LPbj0UqNR/GD3pDKhH4l/Zf9h9AanycUw9dj54o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n+xSwWxpy6cDg9+MVs29iYCEGf+HtigVimIeL2D1qSl/a3rcibx1TECB1MNB2r83MVXzIDd4O4cbIqJ00R2QrK1HuUjWPDz0ne1/14EZsP+nXkEx9w1XLQ3TYWrAz/vCeqXJCj8nCbpS9fQ+wRpSfFP69QztndlBF+4zGam5DRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpKp7MLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C78C433F1;
	Sun,  7 Apr 2024 16:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507971;
	bh=aYE0LPbj0UqNR/GD3pDKhH4l/Zf9h9AanycUw9dj54o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rpKp7MLlunN2B9HgiZ4M9mzpsG/FkvGGmYHr81A/oB4tsR/RF+tSSUhQ9oox0OYJ9
	 fdMGXPQdmkK6OmPH1ihjGWDEJm0Ku8EDfxRgeJjkqqhsxhlcW8MGIbVqg7xRqsg0te
	 QvxlN/gk/53VEYMVAzy/0cpTDgoema3/il7VNUd8ipPqnwmkOVdNNyQld4YR+X5OTH
	 bw7+PTtIV6B9acnk7f7lE9zLyAvkAb9QJf6Mo5CFtWjgvuUwfEwbRiZ5jSVCz75Cpj
	 vBmPFbbpxMbbEz1uWm0bGRwSpvRy5THjrbmzL9UWry/zfdYHXu9J7ktaaH5uaBCT/2
	 4cicJGTrBiDrg==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240308134750.2058556-1-colin.i.king@gmail.com>
References: <20240308134750.2058556-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] dmaengine: pch_dma: remove unused function
 chan2parent
Message-Id: <171250796960.435322.1751126757223779847.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:09:29 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 08 Mar 2024 13:47:50 +0000, Colin Ian King wrote:
> The helper function chan2parent is not used and has never been
> used since the first commit to the code back in 2010. The function
> is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/dma/pch_dma.c:158:30: warning: unused function 'chan2parent' [-Wunused-function]
> 
> [...]

Applied, thanks!

[1/1] dmaengine: pch_dma: remove unused function chan2parent
      commit: 4665be0e952f68306cc6fba2cce68b940a7ec78c

Best regards,
-- 
~Vinod



