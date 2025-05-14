Return-Path: <dmaengine+bounces-5161-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30008AB6EB8
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 17:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869323BABC3
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 15:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0981AC458;
	Wed, 14 May 2025 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYkEz35g"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0F619341F;
	Wed, 14 May 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234962; cv=none; b=e8cJCuOot4TP9MMTLPVevPpPYLG2Hb5iRB20FpciyxvRx12LGwtK99pYc+1uBAm+hx/Jf+fvKo2SkMzI2CXTy/eNuGiM368FTBOXMv/u+zSC4leFPxWfYNf4pxCsDGpoDW2Ae/hGqbI7a4xRBjD+NifFnlqIOPNg3gg1rDpiD9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234962; c=relaxed/simple;
	bh=D5QrjYtZqdxl9aDAD4Mt0N5C+A1l4Okat5ZD8j05CX8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AR6qa3T9qHeJ5fILtafQJU7TJD/dYXefbbT9tOgVFaJ7mkfumJAQCjLgVGi6j542Lf14QQcLKFrrAd1d6Gb35DJtQkai1/WyTjpWnY2+bdKYGzho6aHK6dRDYCcY75aCs6tlc+JkVNe1Gwvua69kRktSiBKL6YLr3CE/Ex2Rufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYkEz35g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9DCC4CEE3;
	Wed, 14 May 2025 15:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234960;
	bh=D5QrjYtZqdxl9aDAD4Mt0N5C+A1l4Okat5ZD8j05CX8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iYkEz35ghEPY/E/ZEsQiPGJVJ70ATHHNVAVhBU4YQd4KlA0o7ljoi31EUooIirf4l
	 L5QMIjyZqYu4M7IdQcxyO0LFT8tEGScl/+NdqWCVLF5DWwm9//jGp8YgTqhD2iul0L
	 rZ2X+hio3TR93rTlo0V5tMxEYQlqyv++E01kyLMz1EVBeMahtJHttcauIEUIjlJ7Ok
	 hT7leKp/L1ehnLcOJjlwBwkK2bR6fglZuh4Om/zoppilPOeL5qWNS6nN1hEiKZEVv+
	 IXLZZN7TLUfIaKswbtSJq6vVxiA+vQubPX5Fbamt9YnoYbzcwjvlZSpzzNdo5yQ+Cy
	 1yBGTaWr73+4g==
From: Vinod Koul <vkoul@kernel.org>
To: sean.wang@mediatek.com, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, 
 Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 baijiaju1990@gmail.com, stable@vger.kernel.org
In-Reply-To: <20250508073634.3719-1-chenqiuji666@gmail.com>
References: <20250508073634.3719-1-chenqiuji666@gmail.com>
Subject: Re: [PATCH v2] dmaengine: mediatek: Fix a possible deadlock error
 in mtk_cqdma_tx_status()
Message-Id: <174723495814.115648.10076437402947235700.b4-ty@kernel.org>
Date: Wed, 14 May 2025 16:02:38 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Thu, 08 May 2025 15:36:33 +0800, Qiu-ji Chen wrote:
> Fix a potential deadlock bug. Observe that in the mtk-cqdma.c
> file, functions like mtk_cqdma_issue_pending() and
> mtk_cqdma_free_active_desc() properly acquire the pc lock before the vc
> lock when handling pc and vc fields. However, mtk_cqdma_tx_status()
> violates this order by first acquiring the vc lock before invoking
> mtk_cqdma_find_active_desc(), which subsequently takes the pc lock. This
> reversed locking sequence (vc → pc) contradicts the established
> pc → vc order and creates deadlock risks.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: mediatek: Fix a possible deadlock error in mtk_cqdma_tx_status()
      commit: 157ae5ffd76a2857ccb4b7ce40bc5a344ca00395

Best regards,
-- 
~Vinod



