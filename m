Return-Path: <dmaengine+bounces-3345-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EAA99D687
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 20:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2101F211FB
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 18:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B4213BC0D;
	Mon, 14 Oct 2024 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wpd4GmnL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB06231C95;
	Mon, 14 Oct 2024 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930755; cv=none; b=G2Y6y0k8oXgeJVpEdREA7zjBH4SAwdWhfi905lllzJCwlnGp0iTIK1Ta74qhzABGgmwW984qlEkCu2kkKbsORLB9DlZs48ZIQ6ovhTIbBa7J5hTxjTknZ9k00f8cd7L1UphAMIcwbAwoM7gGQKVx+uUXTxlE3zPHM9HSlrRO3p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930755; c=relaxed/simple;
	bh=3fsaV5CvX3cLmJSdgeCPLfOI3HAupGcliKAGMyZq3bk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dDArEP4gLwLtoWvW8+Tm3Ej7DS2IoPlHDxy7WraOZtbeGzlZU77+MspSv8iksUBchlziwjq3kY0HdpcSv6hptimWm75hjFW0qAWvtHpFMdOGajl7n4ekV3NEi01JBpkKk23Gvl4u+xD9JeyoeP7ntapzt4NW5nuIT5vMkmlAl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wpd4GmnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE09C4CEC3;
	Mon, 14 Oct 2024 18:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728930755;
	bh=3fsaV5CvX3cLmJSdgeCPLfOI3HAupGcliKAGMyZq3bk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Wpd4GmnLk9hx4OxHN/ciqsN/Ct7oEUlbV9E3RcFTD7y8AGs68h/Oz3Z5h7A2aO/5L
	 H6RXd2Gf/HtQ1SVMqXwUqKXDAkywcUIXzSoktPxtGu2eLd0FoEK87smG5ktDThyG53
	 wmj1ABTifAvRXtyX8SSSltGbNP43ymB2ymTaHFxm4pCniU2p1CwToTK0bSahaFiyQ4
	 txnHa8SsihLet05+J/KgZUuw5C/vNBQzC9c9JGALwYtprKPRI2vZ/iFxSIhkdJ6dEk
	 qUw3v8pOFjdujOG+9xjaIlynGtgzgOueGSROPckaviSQhF292LPMad3VDF/vKc+Flg
	 bYXiMYuLsEeCg==
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Jai Luthra <jai.luthra@linux.dev>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Rishikesh Donadkar <r-donadkar@ti.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240930-z_cnt-v2-1-9d38aba149a2@linux.dev>
References: <20240930-z_cnt-v2-1-9d38aba149a2@linux.dev>
Subject: Re: [PATCH v2] dmaengine: ti: k3-udma: Set EOP for all TRs in
 cyclic BCDMA transfer
Message-Id: <172893075181.75950.15122834753763958777.b4-ty@kernel.org>
Date: Tue, 15 Oct 2024 00:02:31 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 30 Sep 2024 13:02:54 -0400, Jai Luthra wrote:
> When receiving data in cyclic mode from PDMA peripherals, where reload
> count is set to infinite, any TR in the set can potentially be the last
> one of the overall transfer. In such cases, the EOP flag needs to be set
> in each TR and PDMA's Static TR "Z" parameter should be set, matching
> the size of the TR.
> 
> This is required for the teardown to function properly and cleanup the
> internal state memory. This only affects platforms using BCDMA and not
> those using UDMA-P, which could set EOP flag in the teardown TR
> automatically.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ti: k3-udma: Set EOP for all TRs in cyclic BCDMA transfer
      commit: d35f40642904b017d1301340734b91aef69d1c0c

Best regards,
-- 
~Vinod



