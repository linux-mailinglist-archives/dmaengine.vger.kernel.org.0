Return-Path: <dmaengine+bounces-3706-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F809C41CF
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2024 16:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9772284D28
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2024 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E41130E27;
	Mon, 11 Nov 2024 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="NZD7j3Eb";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="kK8j2+Kp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mta-03.yadro.com (mta-03.yadro.com [89.207.88.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F1E49625
	for <dmaengine@vger.kernel.org>; Mon, 11 Nov 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338870; cv=none; b=BNFuKsIFRVwK8ase6bE5eQw3gLHU8w+U/pvRGWMViL4bqVyBghGFK1KINMavv/CiNW79JfN+8Yit9anheAyRZFthm9CWm/4OZs2wHl8EXh1ts/fMp3buw6KMwB8Jh8VM8/TLuzDH12qFhcUH4/yu/XLvbRS3mQvaaAyGUq89+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338870; c=relaxed/simple;
	bh=V/JOctpAQE/5BaMv0rJhc8RXlALmd/o7ZFbwWLS6tBI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SNbwnV/gUwYPWvaLl5snHelyzfRzvQlMTHcir3LTzfK/YiWqGDgtsZWothizrrVB0sXFo+l87H7uL2VL5SLKVWNSHowzpa4J1ZmjDLy2Xc1lBqMyRSEPVk/T3U6kQ9lRFa9pL0lFOYkfYx5Fl9s2n+T1Y33JSiMtRQ3r5iPyJFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=NZD7j3Eb; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=kK8j2+Kp; arc=none smtp.client-ip=89.207.88.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 281FFE0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1731338863; bh=P1q9YtQSiOCqCWqQ13Z64MtWTXxNj/Gk+WZ4mFy36To=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=NZD7j3EbhZUrhEI3fCVRI7mKo9V1WQY41wB+6jTbuTSZys6Ye9EwIKIBGnPyrReyP
	 d7SMs4cJtkTupFxCONdT7V8T/H0uAq+VBzxoMGG5zyHK9myNwX+w/H5C9RUhte6tzx
	 3RCdO5tDKJN4mlNHVnb83pQu51T5s0RVo0mBrabP0rKjGH+ADbLeF2NIHdEjew35gi
	 Addbt5vW6wJZ807Syh7ED3PnUieQ2J9ltK441Ug7qs8ygXYzgzgpT1YLp4HNcbt4YO
	 tXRahaemKIOFc6GvPepWaUTKdf4lHc3kT6thw94kHxCsOq6VXQoeogYVWjGIUKUJUz
	 8TSwOnKtF/x+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1731338863; bh=P1q9YtQSiOCqCWqQ13Z64MtWTXxNj/Gk+WZ4mFy36To=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=kK8j2+KplXPT874qyOY8nFPUgBfjlNBOTz/s9ep3t7rhYLcUGsmvVtn3Jp/Yha/Mu
	 rL/6I8+7GkpQpRr4U5xgyXZyvwRx2ZU8xvcbHdwZVVulKen+R4FfPeZWd0rJXqHCbM
	 jCDR/V+Mc9+7gpsapwqxE+JDvggC1bA9PVMMcyLdXspXzLstX9QNnpyZBgJVBwMmba
	 ZNo1a1CpsUCzAIKY8Qg8UpblZ3GzR04u8BULy8jbflLaV4paF1dWJVOZ7UjBsbmLCv
	 0QbW/NEotO4JcoiWP+48/fkB+xzUMWOIzWBrNe5dV2u0a8gKZY4UxCGaz6bWWF0Hu1
	 FjK788xN+F0+A==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux@yadro.com>, Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 0/2] dmaengine: sf-pdma: Fix dma transfers errors handling
Date: Mon, 11 Nov 2024 18:25:58 +0300
Message-ID: <20241111152600.146912-1-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)

Fix several problems in the sf-pdma driver related to handling situations
when the dma transfer fails (for example, due to IOMMU activities).

Nikita Proshkin (2):
  dmaengine: sf-pdma: Fix dma descriptor status reporting
  dmaengine: sf-pdma: Fix possible double-free for descriptors

 drivers/dma/sf-pdma/sf-pdma.c | 106 ++++++++++------------------------
 drivers/dma/sf-pdma/sf-pdma.h |   3 -
 2 files changed, 32 insertions(+), 77 deletions(-)

-- 
2.34.1


