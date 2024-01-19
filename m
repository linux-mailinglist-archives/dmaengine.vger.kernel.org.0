Return-Path: <dmaengine+bounces-757-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED8D8329BB
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 13:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B0A1F23AC6
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 12:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAB952F6F;
	Fri, 19 Jan 2024 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5eph6EO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455852F61;
	Fri, 19 Jan 2024 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705668643; cv=none; b=rz8ck/RkXjS7B/c8gbITRTC2tZ4VPJe3/ZNkIV014UG9RLCz9pfHWIMNYH9yXpJVeQlnQZkGOC/VuEeyu/SKOd/WvfyBp+ghBkqOaIJ9UD8nOPbdgf+2cOEP5VxCkzGR04NyRHqpT6pAOsM7U7tIQNHpQproC6lUBYwwpY+JLAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705668643; c=relaxed/simple;
	bh=W30j+6xPy6cUeAZEgfVIhN/c9OYj0SxAoxddbCYFL1o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bx/HxROgqLUXXG4i8FlGdiNi1nXJXWOnaQZbP0zdmey4MMj3tLA6dAhUtonTeDJ/ZdsTjSZf/ejpem+OajpzXlOl5Tjm5Dc8E5L5vhN0pP873oCCPUK984FKv09hQB0oOmksnPY+/G+/rFk9bdFBktTXZqC6upFQv2lOAylHA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5eph6EO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C634AC433F1;
	Fri, 19 Jan 2024 12:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705668643;
	bh=W30j+6xPy6cUeAZEgfVIhN/c9OYj0SxAoxddbCYFL1o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=l5eph6EOyfHiK5WMh/Udh+oAI7oZAwzfM/nkxtH3aRwtbhJO2ypzuKkNXWbkD9pz+
	 SNV56UVNEjyXRsUVFKjwyz8rRmck0+ATOEIj0dd1DpCEdx8eHo3JO4i8+MmurtoR85
	 DMLBhs8/rHhstc+kovk92pZ3n9Jhjsd6F3ezwRo3JFdh7onJ1W5cQEZmt+1ss4csS4
	 2vUXEiyKJ2FhEIOL9zIfF0DM18kFRImlCTg2mJb3i7Y4R5ssUDVUWqRAHjUNiZhal2
	 E06WYMf8DlJbnm2HLfleEOu/qolkp0AnRrM2BLVPSuIL2PemHrdkD6/t4zrsYfwpiU
	 VqvCjQICEA3Xw==
From: Vinod Koul <vkoul@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Kees Cook <keescook@chromium.org>, 
 Prabhakar <prabhakar.csengg@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240110222210.193479-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240110222210.193479-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dmaengine: usb-dmac: Avoid format-overflow warning
Message-Id: <170566863937.152659.9559198996956911602.b4-ty@kernel.org>
Date: Fri, 19 Jan 2024 18:20:39 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 10 Jan 2024 22:22:10 +0000, Prabhakar wrote:
> gcc points out that the fix-byte buffer might be too small:
> drivers/dma/sh/usb-dmac.c: In function 'usb_dmac_probe':
> drivers/dma/sh/usb-dmac.c:720:34: warning: '%u' directive writing between 1 and 10 bytes into a region of size 3 [-Wformat-overflow=]
>   720 |         sprintf(pdev_irqname, "ch%u", index);
>       |                                  ^~
> In function 'usb_dmac_chan_probe',
>     inlined from 'usb_dmac_probe' at drivers/dma/sh/usb-dmac.c:814:9:
> drivers/dma/sh/usb-dmac.c:720:31: note: directive argument in the range [0, 4294967294]
>   720 |         sprintf(pdev_irqname, "ch%u", index);
>       |                               ^~~~~~
> drivers/dma/sh/usb-dmac.c:720:9: note: 'sprintf' output between 4 and 13 bytes into a destination of size 5
>   720 |         sprintf(pdev_irqname, "ch%u", index);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] dmaengine: usb-dmac: Avoid format-overflow warning
      commit: 62b68a88795942512936896b9fec1ee7d5fa9922

Best regards,
-- 
~Vinod



