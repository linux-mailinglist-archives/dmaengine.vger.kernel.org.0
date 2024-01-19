Return-Path: <dmaengine+bounces-755-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 636D08329B5
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 13:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD812856A0
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 12:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A2451C34;
	Fri, 19 Jan 2024 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCOaOZpN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3A54EB5B;
	Fri, 19 Jan 2024 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705668636; cv=none; b=EiB5FzsWs3Idgszx1iqPg4DDdUjC3X7YpyfT8p0L8ac+BtHF0SrsIyU8pRZK/6AgoJkjhzyGxFkbzBFT4y6VyoKQJIXHob3PZitdwSHHEEC8qBmTI82iHHqoAPen6VZE57pYZZG+pUBITIJT0lE2+BuoRGzfte5uVukR4lxN6YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705668636; c=relaxed/simple;
	bh=MrihAkGv/bllwDFoIifxhGswuE2qpNP+qVhAez8KQMQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mL45eQAA/tKsHTDO0qpbhUlrgVT5akrkIN8nfeK9A1bJQZF6sKST6wDjg5HunnZ2qnj60eVEhRAjEDamEGGg+CCKctj3fFgWrqcc7m7X/KtsJ37ZXuA7Yecc9lX361r+BFgsD+x5cMefw1NaL9UaE3lUi+PjiJMl2OQ05hMoOqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCOaOZpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA703C43399;
	Fri, 19 Jan 2024 12:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705668635;
	bh=MrihAkGv/bllwDFoIifxhGswuE2qpNP+qVhAez8KQMQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BCOaOZpNYux+Bq5uzoqnFuXL/LiIuiQWl3TV71XfI54/iHyrmevES8Q8hJaWYB4OT
	 G+eKorJ6/BOHWm2qbBaCRxvBQOmrDgAE4MI955BviP+Z613Vm3w0wEr7c2GtmQGyBt
	 xj7xo+SxDpqCgPBxGn8yQQtwQgiuvOqc5tPjdZMeEviBYcvcR3nSXEt75V5jpDWtDL
	 7HmppqZXpcoZ14XGvfv9aQ4cPq9lD8e5fu3KuCghn6zasItGRQV7keMtwTHa43o+vt
	 J5NPu575D8mvTf30ptyqONwTbYVIoiZZyyNSV1GBcp1j/9nWbvwvNGw+X0eLndANaU
	 oRr249MVSEE1Q==
From: Vinod Koul <vkoul@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240119032832.4051-1-rdunlap@infradead.org>
References: <20240119032832.4051-1-rdunlap@infradead.org>
Subject: Re: [PATCH] dmaengine: imx-sdma: fix Excess kernel-doc warnings
Message-Id: <170566863346.152659.8712837527823083203.b4-ty@kernel.org>
Date: Fri, 19 Jan 2024 18:20:33 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 18 Jan 2024 19:28:32 -0800, Randy Dunlap wrote:
> Fix warnings of "Excess struct member" by removing those lines.
> They are extraneous.
> 
> imx-sdma.c:467: warning: Excess struct member 'context_loaded' description in 'sdma_channel'
> imx-sdma.c:467: warning: Excess struct member 'bd_pool' description in 'sdma_channel'
> imx-sdma.c:500: warning: Excess struct member 'script_addrs' description in 'sdma_firmware_header'
> 
> [...]

Applied, thanks!

[1/1] dmaengine: imx-sdma: fix Excess kernel-doc warnings
      commit: 98373a21159379341742dadd6c038fe8ff34d9a1

Best regards,
-- 
~Vinod



