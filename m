Return-Path: <dmaengine+bounces-3167-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32FE979C28
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 09:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46715B222FE
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 07:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0698813D2BC;
	Mon, 16 Sep 2024 07:40:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5200613D28F;
	Mon, 16 Sep 2024 07:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472456; cv=none; b=CMtqiuSeZOu5+8OU+gu+UmajO4AgLRAPY8yrACyymrVkCcK4/sOwAsagcv88WuZAsMwv5phzdu+nG7TVqpaWETPMFhjy5SgtLIsaZVH/+BCKmxcOaifuOwOBPJwfARCbdCteR7BFPjBwCJqw/c3hYuiAYcgrZxNUAT3moW6jOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472456; c=relaxed/simple;
	bh=j6sU9uDfg4k4A6QoHxtT3rJK5j+RZDSfsuYqBWiRX0g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H5A4SPX7DqQ1y7gRAg7sxwziPtf1tDwkHHHR2+J+sZUGPat+y2RpP/DpZsWSB/lezWlV1ujTUw2z6zYFH7bQMssDlirpckCQYdEpPjRB0Hjf0otTJAAJvc/d8COEMoShBokJakmkpR6Wrj+gYcECetq1QSChptM5pxlzaUtxHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C7EAA227AAD; Mon, 16 Sep 2024 09:40:51 +0200 (CEST)
Date: Mon, 16 Sep 2024 09:40:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Vinod Koul <vkoul@kernel.org>, Nishad Saraf <nishads@amd.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Please revert the addition of the AMD QDMA driver
Message-ID: <20240916074051.GA18902@lst.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Vinod,

I just noticed you added the AMD QDMA driver for this merge window,
which is completely broken in terms of DMA API usage by using the
private get/set_dma_ops APIs.  These were never for driver use (
and I've been working for years to fix the few abusers), but with the
DMA changes in 6.12 it actually can't work at all, as the dma-iommu
driver now also sets NULL DMA ops in addition to dma-direct.

As a reminder drivers must never try to inherit dma settings from
one device or another, instead pass the actual DMA device to whatever
layer does the DMA mapping.  Without that you break all kinds of
thing.

