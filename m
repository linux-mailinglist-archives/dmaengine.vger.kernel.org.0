Return-Path: <dmaengine+bounces-7690-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA863CC482F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 726BF300A847
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5BD1684BE;
	Tue, 16 Dec 2025 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/krUy48"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6657E7DA66;
	Tue, 16 Dec 2025 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904179; cv=none; b=uy78usvaOEeIigBJRx3FVhz3jvMmDx9+ww0RncLjwYYznd5pXlq+F/zuu/zjfp6MjBQksRKZRM4VW+SMB/0Q03txbO4EDgQWOAFPyDzMNAHAqMG1hr+YFqHGW1cAzvCjhYGWa2IgymkvG+7Ny8VdyuY6lm8VVwe+hUl6tRCWA7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904179; c=relaxed/simple;
	bh=OCqmTnv58reUa+8AOWzbV3shGc9SErtNrMj9xfPYk0Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dBkbJJjLY9RbDjFuOnn9emQEGbGz9uosEy2GED0za5m3u7bpBbDzbix4Chl+mKaeT3iBn8LHasFStA1WabazMaWAYAblWbyamU04TWH6Ug4zI1LAZghWDoyPgzt6Rvb+u/yy2y6HVam5Lpk58ODvGq4qObH78IGpvDW/WmP79qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/krUy48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC249C4CEFB;
	Tue, 16 Dec 2025 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904178;
	bh=OCqmTnv58reUa+8AOWzbV3shGc9SErtNrMj9xfPYk0Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p/krUy48g3BAEVBjBgmCnvEv8eNAPApeX+sFrWITwcAt1HKI/sP4QVqJnAO7eub7n
	 bg2qfkQq9ofD7/RVnV0FJh4T6xgDGQ+YPJ6I4sBhae94wjvILrWDksEAVzY9isqEg/
	 FeYobE56XbtQN9aru6Owjov1/MtN7Q9Js89Koh8JPaceB0y35SnYBybRQdFNqA7DeB
	 UD68wU1E+IAU2Dq2HW98kdK+3zdRRAoSPqfcVgHGmBKf0ZKyCiC0+r+KYgTZISuIY8
	 HJRHI1MmHWDo962DJOUyQCs7kaAvHK/HP+h0th7a7KA5/2QRp7tAeMaLeqTTHhIOIM
	 Uccp+W2D1kLCw==
From: Vinod Koul <vkoul@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, Vladimir Zapolskiy <vz@mleia.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251117161258.10679-1-johan@kernel.org>
References: <20251117161258.10679-1-johan@kernel.org>
Subject: Re: [PATCH 00/15] dmaengine: fix device leaks
Message-Id: <176590417458.422798.1985360247148370741.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 22:26:14 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 17 Nov 2025 17:12:42 +0100, Johan Hovold wrote:
> The dmaengine drivers pretty consistently failed to release references
> taken when looking up devices using of_find_device_by_node() and similar
> helpers.
> 
> Included are also two OF node leak fixes and a couple of related
> cleanups.
> 
> [...]

Applied, thanks!

[01/15] dmaengine: at_hdmac: fix device leak on of_dma_xlate()
        commit: b9074b2d7a230b6e28caa23165e9d8bc0677d333
[02/15] dmaengine: bcm-sba-raid: fix device leak on probe
        commit: 7c3a46ebf15a9796b763a54272407fdbf945bed8
[03/15] dmaengine: cv1800b-dmamux: fix device leak on route allocation
        commit: 7bb7d696e0361bbfc1411462c784998cca0afcbb
[04/15] dmaengine: dw: dmamux: fix OF node leak on route allocation failure
        commit: ec25e60f9f95464aa11411db31d0906b3fb7b9f2
[05/15] dmaengine: idxd: fix device leaks on compat bind and unbind
        commit: 799900f01792cf8b525a44764f065f83fcafd468
[06/15] dmaengine: lpc18xx-dmamux: fix device leak on route allocation
        commit: d4d63059dee7e7cae0c4d9a532ed558bc90efb55
[07/15] dmaengine: lpc32xx-dmamux: fix device leak on route allocation
        commit: d9847e6d1d91462890ba297f7888fa598d47e76e
[08/15] dmaengine: sh: rz-dmac: fix device leak on probe failure
        commit: 9fb490323997dcb6f749cd2660a17a39854600cd
[09/15] dmaengine: stm32: dmamux: fix device leak on route allocation
        commit: dd6e4943889fb354efa3f700e42739da9bddb6ef
[10/15] dmaengine: stm32: dmamux: fix OF node leak on route allocation failure
        commit: b1b590a590af13ded598e70f0b72bc1e515787a1
[11/15] dmaengine: stm32: dmamux: clean up route allocation error labels
        commit: 10bf494fd77b34d0749e098c939f85abf52801d1
[12/15] dmaengine: ti: dma-crossbar: fix device leak on dra7x route allocation
        commit: dc7e44db01fc2498644e3106db3e62a9883a93d5
[13/15] dmaengine: ti: dma-crossbar: fix device leak on am335x route allocation
        commit: 4fc17b1c6d2e04ad13fd6c21cfbac68043ec03f9
[14/15] dmaengine: ti: dma-crossbar: clean up dra7x route allocation error paths
        commit: 646ff780338bd7305c9f2fdeb418fdb01623a71c
[15/15] dmaengine: ti: k3-udma: fix device leak on udma lookup
        commit: 430f7803b69cd5e5694e5dfc884c6628870af36e

Best regards,
-- 
~Vinod



