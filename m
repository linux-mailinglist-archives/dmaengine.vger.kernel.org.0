Return-Path: <dmaengine+bounces-1768-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E58289B301
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8801C22032
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9AA39FF2;
	Sun,  7 Apr 2024 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8VjABU2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603EC3C099;
	Sun,  7 Apr 2024 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507914; cv=none; b=R1kUVhf0OEkgXWhZ5ExwtijzWBtOvREMIvsSBUROH8cObsm2QGHd4fu63+l0XYZetazGOeL5AP2wndckL+Dbr5+UASpbPKW7MhJ5R4VDtkD++QhedD/O+HP//hEZal9CalpDwJ5CUi0i3yetrqvGZ66gB3VDfcQ+55G/VtB1qrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507914; c=relaxed/simple;
	bh=oc8xWPA36O1wMeOhXe1fCq4HHo6Vh3a+uGcXh+hY4m0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iZ1W1VbydXxqjvu0Hpmg66v+9whr7Wkg0Mch+VLLkskd1y8CGdK6WACMzbAycuzwhXs1srlc/yHlRqmu0u1Xz5S7/6+DorPIaJqjpFt4G7PZfAXOtz9vI9UxZIZEOoCtnCD5Vb8nprIBLdU6iKqwtJ+Qt2ovGIUOWF4Dm5CXYmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8VjABU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82292C433C7;
	Sun,  7 Apr 2024 16:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507913;
	bh=oc8xWPA36O1wMeOhXe1fCq4HHo6Vh3a+uGcXh+hY4m0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O8VjABU2WDxctDB4F6msemqMibMKaj3vX2CQPebTcBrqFseCNjsdPz+LUuu0qs7hx
	 f+6Ad2CfkJ+3G2Mb84HCqLaDJEXdKWjlvuXAYaPI3wfo3Bam0QuOu8l/jM9LgrUl4x
	 DaVCtkAgjwVVs8881GtUuaY+qlpshRptbaSar2W/yChvvtd69+LLtd98BNp50qTcsd
	 5X9elHJHeQ9iu6AH1cq5jON6YCUmwNZsmQ7XLRl7/0qAShGPonRB6dgtEqDVz8eRxj
	 sF6PE2Ahe4sQbur8IeTIz9t4sg7v5jh/t8AWFfUjWM8rAF5k6ACKh1zzv7QsX52gVo
	 KIEw0tJcX04DQ==
From: Vinod Koul <vkoul@kernel.org>
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Jan Kuliga <jankul@alatek.krakow.pl>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20240327-digigram-xdma-fixes-v1-0-45f4a52c0283@bootlin.com>
References: <20240327-digigram-xdma-fixes-v1-0-45f4a52c0283@bootlin.com>
Subject: Re: [PATCH 0/3] dmaengine: xilinx: xdma: Various fixes for xdma
Message-Id: <171250791012.435162.10419880314005894379.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:08:30 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 27 Mar 2024 10:58:47 +0100, Louis Chauvet wrote:
> The current driver have some issues, this series fixes them.
> 
> PATCH 1 is fixing a wrong offset computation in the dma descriptor address
> PATCH 2 is fixing the xdma_synchronize callback, which was not waiting
>    properly for the last transfer.
> PATCH 3 is clarifing the documentation for xdma_fill_descs
> 
> [...]

Applied, thanks!

[1/3] dmaengine: xilinx: xdma: Fix wrong offsets in the buffers addresses in dma descriptor
      commit: 5b9706bfc094314c600ab810a61208a7cbaa4cb3
[2/3] dmaengine: xilinx: xdma: Fix synchronization issue
      commit: 6a40fb8245965b481b4dcce011cd63f20bf91ee0
[3/3] dmaengine: xilinx: xdma: Clarify kdoc in XDMA driver
      commit: 7a71c6dc21d5ae83ab27c39a67845d6d23ac271f

Best regards,
-- 
~Vinod



