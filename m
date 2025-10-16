Return-Path: <dmaengine+bounces-6866-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 059C8BE419A
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 17:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E73F0508134
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 15:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296F133EAF5;
	Thu, 16 Oct 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upxPcwZa"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407A3314A4
	for <dmaengine@vger.kernel.org>; Thu, 16 Oct 2025 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626931; cv=none; b=tn3jAfSOV4W118ceN93MkgFD5V85SmB4KIfrlcYIPMd+hPvBhAh6fkxZqZXngErFSfocVJs572Y+eqfMWC3d3T56zriDEG7TeTQN7Hwt7dCMLlSjf3qoiN0zTLYP7wKPkbAn4Yp2cZOZvKaSE1/JDBy/0OLL3Igdt7La2QCUN/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626931; c=relaxed/simple;
	bh=OQBdUjzJFrUlMBUrLT0oJE6Yw6lZ/3zLzuov1zi4vEI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aoE1kdX2f9EXSYjYdrQNNjAVIPqTs9/lDUDljOqZxSDQQShf8hTasmgXP8ujNuodfN2bxsGvMGyld3jEPiXJRYjNr7gRBmoST7pw3A7mfvO/vNqy+ysgj0G4qf3x+EchK/srkcu0a6YZY3S5T+MLctD5ol6CNiHLXsrb0cnMXJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upxPcwZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBE0C4CEFE;
	Thu, 16 Oct 2025 15:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760626930;
	bh=OQBdUjzJFrUlMBUrLT0oJE6Yw6lZ/3zLzuov1zi4vEI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=upxPcwZaEwPUNdNO5OFl/nr0AAoQBRQFfqcbUaFrZCLUE9wltOekYXyx9/Jb+4n4c
	 ++uXU8ECElS+NSpAoG/nlA145EPkWqt00nh/V/gkvFJODjqmT9qVid6o+74Hmw+SY1
	 QyJQqsa4YdZ66MDKT880B8dhUEsYpjVldCnlOsR3Reak15b4G7DVrvdqLcUHMNJdua
	 wfbAkPIHXFVHqY0csnaIndl4OlI513KOJXksMAeqWdQQ2YiUQF6DKEWnZC0ovcodRb
	 5ECEaWidmetYUu6uydYHpx1kDShF0Lyt5C8RpWwqqEtVkTchledCA9XyKMTVi+ekjn
	 ZYlaSnPvSlTbQ==
From: Vinod Koul <vkoul@kernel.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: dmaengine@vger.kernel.org
In-Reply-To: <02d3145b37348bd48e7b63a544ecaaac64b061b0.1756999580.git.geert+renesas@glider.be>
References: <02d3145b37348bd48e7b63a544ecaaac64b061b0.1756999580.git.geert+renesas@glider.be>
Subject: Re: [PATCH] dmaengine: nbpfaxi: Convert to RUNTIME_PM_OPS()
Message-Id: <176062692922.525215.9442627135259337776.b4-ty@kernel.org>
Date: Thu, 16 Oct 2025 20:32:09 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 04 Sep 2025 17:28:37 +0200, Geert Uytterhoeven wrote:
> Convert the Renesas Type-AXI NBPF DMA driver from SET_RUNTIME_PM_OPS()
> to RUNTIME_PM_OPS(), and pm_ptr().  This lets us drop the check for
> CONFIG_PM, and reduces kernel size in case CONFIG_PM is disabled, while
> increasing build coverage.
> 
> 

Applied, thanks!

[1/1] dmaengine: nbpfaxi: Convert to RUNTIME_PM_OPS()
      commit: 75396f5b9534780add6a32aaa9b005911bc98dd2

Best regards,
-- 
~Vinod



