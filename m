Return-Path: <dmaengine+bounces-4684-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB3BA5A59E
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 22:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E873ABEC6
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 21:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3C11E25E3;
	Mon, 10 Mar 2025 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qh7Z+3py"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FAB1E25E8;
	Mon, 10 Mar 2025 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640805; cv=none; b=TXCBXGdwHwalPKqRuoyr/GucRxnOugQrdaUwAkgGwPqxxkzFZ5VO7JATky96ARmzfGeMI6JkFDIfYYHQhxczH1wtWlxZzIpHkhcKBMk351pHaFTgoiYgEk6F2PwzIndn8nUqbq6mUWIZ13SxW5q7ISNbaZ4Pf4EYsO1BfKAJEDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640805; c=relaxed/simple;
	bh=GK3gE6I8YU0RfcnHt8moeIj8mJNYCFOvOsO/AmnY1UU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cGoIvXzW73P16vjkl013NARIhXxRF171xYObSLw2Fvuu9dDu3OVu9OPt5RrpWsir2F5VZxGts1cFHsGDxGV4roF5DqZXDwgh1deABOTYABAdQOja3ky79KzBofSC3qDwKQEXOKEqBUBLgdl4FhwlnOY/V0BZGf8rjmE2ygJw34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qh7Z+3py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912A2C4CEE5;
	Mon, 10 Mar 2025 21:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741640804;
	bh=GK3gE6I8YU0RfcnHt8moeIj8mJNYCFOvOsO/AmnY1UU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Qh7Z+3pyJ9+veSOdTPFoJoDwaMktzUJXDB6uFGC7nDjZKSeYH1WAMIcRBp3XP6gCd
	 s3SF4NmZM/3zw3TFlRdSecA6a/sPlcAZ8IMhDybW2Oz3rAMwhDkxaToOglMlVMotXY
	 3tflnmhgGRvVCJ8l7VZebV5pO85bD+hBziXoP+RJ59IC8IeZCsmKnYNJANdYbaOHXm
	 xzCtiUNCc8tpAUfsb5VuqkCy/GEzeF620DMgEVGXF1XpMrkqKZjmigPKusg6aoidYa
	 DUUv7bKRYny5rceITOGWGNjOHo9g0jZMPsyimJ03kKU6BUsxQbFioXPV/0dP0Ov7Q2
	 s7BE2Udaz1u0A==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: dave.jiang@intel.com, kristen.c.accardi@intel.com, 
 kernel test robot <oliver.sang@intel.com>
In-Reply-To: <20250305230007.590178-1-vinicius.gomes@intel.com>
References: <20250305230007.590178-1-vinicius.gomes@intel.com>
Subject: Re: [PATCH v1] dmaengine: dmatest: Fix dmatest waiting less when
 interrupted
Message-Id: <174164080219.489187.12685687661837510000.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 02:36:42 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 05 Mar 2025 15:00:06 -0800, Vinicius Costa Gomes wrote:
> Change the "wait for operation finish" logic to take interrupts into
> account.
> 
> When using dmatest with idxd DMA engine, it's possible that during
> longer tests, the interrupt notifying the finish of an operation
> happens during wait_event_freezable_timeout(), which causes dmatest to
> cleanup all the resources, some of which might still be in use.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: dmatest: Fix dmatest waiting less when interrupted
      commit: e87ca16e99118ab4e130a41bdf12abbf6a87656c

Best regards,
-- 
~Vinod



