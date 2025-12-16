Return-Path: <dmaengine+bounces-7704-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C03DDCC484D
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 099143062FB1
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9072320386;
	Tue, 16 Dec 2025 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K10ZcPOW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386842BE7AB;
	Tue, 16 Dec 2025 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904386; cv=none; b=UMqITsJKwMj9qctQmPIAGZD4tCxh/ERJmpNIom68MItKg4nK0fx7O4dkyc1NMlUK3mlSzPKk5S//P8K8E7J6Rywz3q0edz3kHIXlTNkn/Ygr/rxCh2n/ul36d84IpXBtD+QFWj+NW9R8Iyn77n8WN28kBjy6SA9MRZ//MC8LdgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904386; c=relaxed/simple;
	bh=W/X2VxJRpTojMR9uqAxwXMGCviIoIhTVQO42sSdwrtw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O1yLDpxHNd6LUeUmbmDFvMKRpHJicQyFI4kT1zGXWGrDDlX6ktXDQfW9t7JdvhU0aOjmybzSTKCiAS83dR9ir+L6JBpKphUaIsvtkTqP61OIPzRdyBsOn0UgT71yOwtioRe0VDgh6hmew+rC8p9UxCs0dffLadGU74CCrZLuOq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K10ZcPOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52F3C4CEFB;
	Tue, 16 Dec 2025 16:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904385;
	bh=W/X2VxJRpTojMR9uqAxwXMGCviIoIhTVQO42sSdwrtw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=K10ZcPOWF+QzIe9WQe2qXUAQq/JpBtNVLUhjhnaqeyvlREK/EdkXnjI8RDuASp/W/
	 DSgzVCG0bWynps2e+LA+wcANFkDVS/5uU8uHumVbS4IF05nBYglF1lEnV5bKsqwReD
	 ur17WHXocnFKjVLErI6/z2HrsTgfItzKla+w/hIqonmOcsrZfLgh/AUM61Yh1uY8t1
	 ezF/XebFw1wVxHwDFA9xbSGjIXU7PMb6YFpOJqlLQS1LfYwzpCgxNeWSuw9QpqMV2w
	 moenWvJWQJQ+KYRQze4t9W4jInm/L9CmBD06lQhlO09SMJLgPHxPkg8VI1rE1Voy9X
	 7jWM9zx2w4LuQ==
From: Vinod Koul <vkoul@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, dmaengine@vger.kernel.org
In-Reply-To: <20251101191524.1991135-1-rdunlap@infradead.org>
References: <20251101191524.1991135-1-rdunlap@infradead.org>
Subject: Re: [PATCH] dmaengine: dw_edma: correct kernel-doc warnings in
 <linux/dma/edma.h>
Message-Id: <176590438430.430148.13852948544103905139.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 22:29:44 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 01 Nov 2025 12:15:24 -0700, Randy Dunlap wrote:
> Use the correct enum name in its kernel-doc heading.
> Add ending ':' to struct member names.
> Drop the @id: kernel-doc entry since there is no struct member named 'id'.
> 
> edma.h:46: warning: expecting prototype for struct dw_edma_core_ops.
>  Prototype was for struct dw_edma_plat_ops instead
> Warning: edma.h:101 struct member 'ops' not described in 'dw_edma_chip'
> Warning: edma.h:101 struct member 'flags' not described in 'dw_edma_chip'
> Warning: edma.h:101 struct member 'reg_base' not described
>  in 'dw_edma_chip'
> Warning: edma.h:101 struct member 'll_wr_cnt' not described
>  in 'dw_edma_chip'
> Warning: edma.h:101 struct member 'll_rd_cnt' not described
>  in 'dw_edma_chip'
> Warning: edma.h:101 struct member 'll_region_wr' not described
>  in 'dw_edma_chip'
> Warning: edma.h:101 struct member 'll_region_rd' not described
>  in 'dw_edma_chip'
> Warning: edma.h:101 struct member 'dt_region_wr' not described
>  in 'dw_edma_chip'
> Warning: edma.h:101 struct member 'dt_region_rd' not described
>  in 'dw_edma_chip'
> Warning: edma.h:101 struct member 'mf' not described in 'dw_edma_chip'
> 
> [...]

Applied, thanks!

[1/1] dmaengine: dw_edma: correct kernel-doc warnings in <linux/dma/edma.h>
      commit: f5a4aa643ee968137eea902aa321c58c14c256c7

Best regards,
-- 
~Vinod



