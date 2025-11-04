Return-Path: <dmaengine+bounces-7052-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C44C32068
	for <lists+dmaengine@lfdr.de>; Tue, 04 Nov 2025 17:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7B304F3A8B
	for <lists+dmaengine@lfdr.de>; Tue,  4 Nov 2025 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677F4330B13;
	Tue,  4 Nov 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oahc3jZx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7B52248BE;
	Tue,  4 Nov 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273311; cv=none; b=CRj7vKQvqZbia7gPTeWBNSrMQY6rZ8ayv7lvZcJdeKXrEFUvYHKB6BbMy5Lo3wwklXD39hQT9qg0aTCVJiz0wGF4r1xrYyqJJ8jsnVW83WxQngD6ZW6VXGYm18PBGkWaRfBYnxl30SBMZtW5PnQ68TAnGldsqa3CRBs1eY5GFRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273311; c=relaxed/simple;
	bh=o7+zi7GXqBkQz18IsHHUAZB/ZiKichtFr8qpatSjrio=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kG0NJ8MpOoH8JNvMKWyuOlo0FTdjCZD6NFiLFcjhB2C+ozgi72GqvF9bhrp7P1jkdDY/QZSGF0s0zNJkuAXiw1vhAX3eIzbXD1d7iYxJ7Y8nu29bdlakskTX17b+H9YZ3HQmRPWxFRZF7P7qjQHB8yy/nRZGEKDTRDGxxNIpq20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oahc3jZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D91B1C4CEF8;
	Tue,  4 Nov 2025 16:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762273310;
	bh=o7+zi7GXqBkQz18IsHHUAZB/ZiKichtFr8qpatSjrio=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=oahc3jZxo13ZrzFONDCrPCsVzlnKRpBtNcVtSsC3WQCnZXoS3Bqro7uYJkGyb2eQR
	 7HC75blGRRDLgVK8yUcZ1p8G5Ao0hm2WodCtTEX7BYSlexad1NZ4kagFBaRODJ/m4D
	 b/CqfBF2EbhQ6bXAKHRYUz7CkvCaU+uMdGpgbZwb/EMerN9I+uE9viduXH1A2D5Np5
	 Cr1NLWs/V0Hu3gEnUjItVdzt+Q8wDrGbaTAOtF+R1y2dq1t5i9Md0ZCNljFbeXVgh7
	 135EzkbHx1Zksaem9trTbjZd6DX4y3BMy54kGF72souslO6pxJDJPvvXlCDxtKQBkM
	 4IP7xbVYdyUCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FEBCCFA04;
	Tue,  4 Nov 2025 16:21:50 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH RESEND 0/4] dma: dma-axi-dmac: fixes and improvements
Date: Tue, 04 Nov 2025 16:22:24 +0000
Message-Id: <20251104-axi-dmac-fixes-and-improvs-v1-0-3e6fd9328f72@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEAoCmkC/x2MMQqEMBAAvyJb34KJpvDqs71CS7FYkvVuC6NkQ
 YTg3w2WAzOTQTkJK7yrDIkPUdliAfOqwP8p/hglFAZbW2dM3SKdgmElj4ucrEgxoKx72g5Fbig
 4Y6mxnYcy2BM/UuknGPqx/35gvq4biUob43QAAAA=
X-Change-ID: 20251104-axi-dmac-fixes-and-improvs-e3ad512a329c
To: Vinod Koul <vkoul@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Paul Cercueil <paul@crapouillou.net>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762273345; l=799;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=o7+zi7GXqBkQz18IsHHUAZB/ZiKichtFr8qpatSjrio=;
 b=CP+rdy2Ry0Bg7k8FJBgMtRxfz4jFy8Qn7wAFi54kfHeJVq79GhUxjYsf/rGuxNEpaaLjQt/h2
 8RTjgXeyz/PBtG3L2SQ86aCjDsSerZZgCAu9v2W/eOcSw9vIpsNqlZW
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

This series adds some fixes to the DMA core with respect with cyclic
transfer and HW scatter gather.

It also adds some improvements. Most notably for allowing bigger that
32bits DMA masks so we do not have to rely on bounce buffers from
swiotlb.

---
Nuno Sá (4):
      dma: dma-axi-dmac: fix SW cyclic transfers
      dma: dma-axi-dmac: fix HW scatter-gather not looking at the queue
      dma: dma-axi-dmac: support bigger than 32bits addresses
      dma: dma-axi-dmac: simplify axi_dmac_parse_dt()

 drivers/dma/dma-axi-dmac.c | 48 +++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)
---
base-commit: 398035178503bf662281bbffb4bebce1460a4bc5
change-id: 20251104-axi-dmac-fixes-and-improvs-e3ad512a329c
--

Thanks!
- Nuno Sá



