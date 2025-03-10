Return-Path: <dmaengine+bounces-4687-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEAAA5A5A4
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 22:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA893A75C9
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 21:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB591E573F;
	Mon, 10 Mar 2025 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5rSR7e2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1462C1E5B62;
	Mon, 10 Mar 2025 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640814; cv=none; b=EVlW3IDrk3n5qIzYhQ+R9uYs5S8fp6T+/oDi8OvJVcO8V/hgYj1k2d+vEh6dgab84s8gVK2g5BaaWDIo+lcS5TDwL+b4XjRbO0RAkx7ZEuEquRLC050V7cFRr1qfYVU0T4gK/7hQykS6KKTqk3HCpC3eoYjVRUsos0h3rhgVGLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640814; c=relaxed/simple;
	bh=w3JGUoFoP4s4o1EYb78J+8jvJOeydIyBNZmbEoCe2w0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Zt6hndTKMOr6JmqpMPid3IOfEa/jj0vzXyxW8YK3WK4/jEEwYe5VFkUrtoQGTAargbqDCG8u+oFPj6UokPIH5znO4D4O6lezKn+sYdiqCIs8g200HkYNkqjQBzGl2SbSlBdAAVOBNZlZFkcpPMlvDRCXOMCNgFlFsF6FtrRKXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5rSR7e2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3055CC4CEED;
	Mon, 10 Mar 2025 21:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741640813;
	bh=w3JGUoFoP4s4o1EYb78J+8jvJOeydIyBNZmbEoCe2w0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=q5rSR7e2arCQtcsqfVS3LjgCtGkhwx2Vg/Z2dcW8XiCKOOP7joc9VWEYP1fyQwpoT
	 4O0ak4YHnJtkNY14eCXfXZSu6EtE0hCVhcOFk3CPXjKF8NpyCwtLZ1tIsBSWeM+qLq
	 RcdTrpwotdEpcq/Z8Lm3LstaeCQ1Ix2MXg9wxWk4lY2YSX9XcSDXRfZd4MoaGipRz6
	 bNoGNKyOBUuoQ0dN/L6nctA/ej9tJ9JR0AqNudhMW/GRuMzaIJltbq9snl2YFoR/Db
	 Pmdt7FGWGQDNPmhqc2POLwulidaacsFVpi/jAuVJCWPJpfCdxv0E9kAZuUxu+h221k
	 6ZGBM99NFG9Lw==
From: Vinod Koul <vkoul@kernel.org>
To: peter.ujfalusi@gmail.com, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, srk@ti.com
In-Reply-To: <20250205121805.316792-1-s-vadapalli@ti.com>
References: <20250205121805.316792-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Enable second resource range
 for BCDMA and PKTDMA
Message-Id: <174164081079.489187.11258465770123332216.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 02:36:50 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 05 Feb 2025 17:48:01 +0530, Siddharth Vadapalli wrote:
> The SoC DMA resources for UDMA, BCDMA and PKTDMA can be described via a
> combination of up to two resource ranges. The first resource range handles
> the default partitioning wherein all resources belonging to that range are
> allocated to a single entity and form a continuous range. For use-cases
> where the resources are shared across multiple entities and require to be
> described via discontinuous ranges, a second resource range is required.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ti: k3-udma: Enable second resource range for BCDMA and PKTDMA
      commit: 566beb347eded7a860511164a7a163bc882dc4d0

Best regards,
-- 
~Vinod



