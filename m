Return-Path: <dmaengine+bounces-5223-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E647AABE754
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 00:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B9E7AD321
	for <lists+dmaengine@lfdr.de>; Tue, 20 May 2025 22:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCFC2609F2;
	Tue, 20 May 2025 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iJKwUAVL"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56253256C95;
	Tue, 20 May 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780762; cv=none; b=GzwHGpV4d/sMURgAk9/ALA1B59IE9C1uLjZy1VEpf1OOcY0ycbHVdVBEF5MC4bNemlYFx7T+Z2rFLQO/oIHcSEhgDk2nD4Fob+bKKl0+7Jy4GxMoTWC3WaeTh1jTADQ5FpBK6jFUViBJxbh6pahSFrOYpGUiB2iXinb79a6j8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780762; c=relaxed/simple;
	bh=KJLJl5G4ZEfIrYP7fvFanGybKGNHrPy/BUDBhJeSwyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DI4maeE0xOGGs+bHhetadQe5RT20BZ5uOxoQmorBa9+h2TssHc/dYqOWd6hLonnUht4enXqdyh95p4IGtvCTyxOFlI4F/faHiVMBdkMzx2Kj1n3Ip220QL/1AH3AttWbKTMuwPjBDHTwD1pEk/q2JhSAYvB2kPrYU/xFMO300fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iJKwUAVL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=h5biAlmqEKw4A5Scse4dJjnS3AKbz0TdTPBvhrSpi/E=; b=iJKwUAVLeSAm4yCglWJSEzEVhC
	l30/DXblP1bcU2a9tex2L/L8OcfB0COTH7jVVrt2/EQMIXxB2NbzNShoBO4JDAwBNdgS+NP1bANm5
	ewy0Cqs9WgW7SGTAAhmXXcTw9Ctsemu/GX+b/LKCEIoOc9MVeoXGbY/yd3Ls6/SSZV9y34pPpyQT6
	P/HBbNXs7f5fCL+mSaS77Hf6GQHomqfG5XDIGnjoo13T2FDOuPfEZ3fSHdkWjGA5D+EKi7702C+lG
	R+U6pxygAvhl0DVFHXe8rchZJW9x9RHLU6VEAbYpoHw0qmEzcE2hyjsUxL1olPZoFuzhV8qnRARzC
	hKM2f7+A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHVcA-0000000EIM8-0So0;
	Tue, 20 May 2025 22:39:14 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: vkoul@kernel.org,
	chenxiang66@hisilicon.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	leon@kernel.org,
	jgg@nvidia.com,
	alex.williamson@redhat.com,
	joel.granados@kernel.org
Cc: iommu@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH 0/6] dma: fake-dma and IOVA tests
Date: Tue, 20 May 2025 15:39:07 -0700
Message-ID: <20250520223913.3407136-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

We don't seem to have unit tests for the DMA IOVA API, so I figured
we should add some so to ensure we don't regress moving forward, and it allows
us to extend these later. Its best to just extend existing tests though. I've
found two tests so I've extended them as part of this patchset:

  - drivers/dma/dmatest.c
  - kernel/dma/map_benchmark.c

However running the dmatest requires some old x86 emulation or some
non-upstream qemu patches for intel IOAT a q35 system. This make this
easier by providing a simple in-kernel fake-dma controller to let you test
run all dmatests on most systems. The only issue I found with that was not
being able to get the platform device through an IOMMU for DMA. If folks have
an idea of how to make it easy for a platform device to get an IOMMU for DMA
it would make it easier to allow us to leverage the existing dmatest for
IOVA as well. I only tried briefly with virtio and vfio_iommu_type1, but gave
up fast. Not sure if its easy to later allow a platform device like this
one to leverage it to make it easier for testing.

The kernel/dma/map_benchmark.c test is extended as well, for that I was
able to add follow the instructions on the first commit from that test,
by unbinding a device and attaching it to the map benchmark.

I tried twiddle a mocked IOMMU with iommufd on a q35 guest, but alas,
that just didn't work as I'd hope, ie, nothing, and so this is the best
I have for now to help test IOVA DMA API on a virtualized setup.

Let me know if others have other recomendations.

The hope is to get a CI eventually going to ensure these don't regress.

Luis Chamberlain (6):
  fake-dma: add fake dma engine driver
  dmatest: split dmatest_func() into helpers
  dmatest: move printing to its own routine
  dmatest: add IOVA tests
  dma-mapping: benchmark: move validation parameters into a helper
  dma-mapping: benchmark: add IOVA support

 drivers/dma/Kconfig                           |  11 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/dmatest.c                         | 795 ++++++++++++------
 drivers/dma/fake-dma.c                        | 718 ++++++++++++++++
 include/linux/map_benchmark.h                 |  11 +
 kernel/dma/Kconfig                            |   4 +-
 kernel/dma/map_benchmark.c                    | 512 +++++++++--
 .../testing/selftests/dma/dma_map_benchmark.c | 145 +++-
 8 files changed, 1864 insertions(+), 333 deletions(-)
 create mode 100644 drivers/dma/fake-dma.c

-- 
2.47.2


