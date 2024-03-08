Return-Path: <dmaengine+bounces-1319-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1415C876C1B
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 22:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB0CB2153C
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 21:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF455E094;
	Fri,  8 Mar 2024 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uyLuEqbz"
X-Original-To: dmaengine@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71B85B20C
	for <dmaengine@vger.kernel.org>; Fri,  8 Mar 2024 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931643; cv=none; b=AraXNDINkDAs9eoCHldzdrt9vH2CVUmTbEFiqjbmYORzxQk+YzVCTTwfDMndlb8X4gnYUKu1jhuFl3wkyzo6V9asUbdImQ77r0V2iSHeL7fRXh9udzfyu5WdCUOp+OFbyLF8zc/p5mByc4jCiFiyLFoqrVKoi7yDvzvI8y29K8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931643; c=relaxed/simple;
	bh=3K5ULUfKXMnPO5jig2Y0yO2WjJR3O/sqFArdDG+H1sc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IlQOtFd60LCZ+gxeLFezeE/3vwI2N5Cmvab/fwHZ4Kx3hGxnKHmtU3r0TvuOwz3XCJH4hDTW+KHTSHlm+0qxWp82bkast9Qi+1/DnFTbehe7v/fswjDtIfxqG199HLZPinXatKYgsKiELl6zNNgTl71W+vb5orU9yI3RyrUq71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uyLuEqbz; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709931640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QehjjxOVDT80rxgpnNGSVuuYoo3gXQUxxRf5l1oRF9w=;
	b=uyLuEqbzqAr2mbfreaXd4U5ktA6Pld8IeViU6zghRiluUWjgxd/YMB2xl04jL4z55T9yrI
	7tiwRB/mzzz42njknXjyvBcZk5fRL5+im/OIoRaEiU2Mcmw52ngTiirxUXVSt+d+3/ca02
	wh/Cenpo1Ua7grID2vIS54CtvQ8O6/I=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Hyun Kwon <hyun.kwon@xilinx.com>,
	Tejas Upadhyay <tejasu@xilinx.com>
Subject: [PATCH 0/3] dma: xilinx_dpdma: Fix locking
Date: Fri,  8 Mar 2024 16:00:31 -0500
Message-Id: <20240308210034.3634938-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series fixes some locking problems with the xilinx dpdma driver. It
also adds some additional lockdep asserts to make catching such errors
easier.


Sean Anderson (3):
  dma: xilinx_dpdma: Fix locking
  dma: xilinx_dpdma: Remove unnecessary use of irqsave/restore
  dma: Add lockdep asserts to virt-dma

 drivers/dma/virt-dma.h            | 10 ++++++++++
 drivers/dma/xilinx/xilinx_dpdma.c | 23 ++++++++++++++---------
 2 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


