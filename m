Return-Path: <dmaengine+bounces-1732-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5E78971C8
	for <lists+dmaengine@lfdr.de>; Wed,  3 Apr 2024 15:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC5D1F231CA
	for <lists+dmaengine@lfdr.de>; Wed,  3 Apr 2024 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3E0148839;
	Wed,  3 Apr 2024 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="WL9AME1F"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m49253.qiye.163.com (mail-m49253.qiye.163.com [45.254.49.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E2B147C78;
	Wed,  3 Apr 2024 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152638; cv=none; b=oRjSUejf9g9PDn12CwC7SMHLz92s6yAps/cQ2HNmyVqFuw774DyOeZXsbyiFCNgGOXcJlQaGSyrbwlO7SIIBVYh4mwUewhUPrDtIINfQHQeJTytpYLzQSYAlYKw4PDqPgtzXS6JOl+hzdwgX9rLm0dToricFUyVvOvtf2N8TtsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152638; c=relaxed/simple;
	bh=Yi2rfy/c/FEfpMRtlXRZ23HDICk1lcPrg8Fy+0GTG60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VW9GNYaaB4R3EPQO8S0zPtg1XFfec1mN3MTSOYjnCs0uM0et6XrO6AK7qf/mEwmOMKFh4WH3ZtjxTyj9Ys1/li0PYSvN41lYZwhQFVFHlYBOQhV6EedZkXYjFQ3118XS6c2ShPdlDJMtmHMA3yHcUtmOEUrm85SLgh51c81GQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=WL9AME1F; arc=none smtp.client-ip=45.254.49.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=WL9AME1FbN3qwG5Wk/f79Xhi/AskTVfgq4tjVjSPsooez9x8BryWqJeBNcj8nT7Cip+10fOlPiHqsHn8OL6mSsNN5q36mI+y2RXFwcfUM3ELmMp1gzB+DCuJ32O/rK9vlsmI9opkB5wX7NvQcY5vCQd4rypsKVxDSSE7JkQ2MLE=;
	c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=hVhk+TI4SRZhbF4gUP3nkD3PWMY3UDprkFnGH1+J064=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id C6D807C03A7;
	Wed,  3 Apr 2024 21:18:44 +0800 (CST)
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: heiko@sntech.de,
	vkoul@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dmaengine: Add support for audio interleaved transfer
Date: Wed,  3 Apr 2024 21:18:22 +0800
Message-Id: <20240403211810.v2.1.I502ea9c86c8403dc5b1f38abf40be8b6ee13c1dc@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1712150304-60832-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1712150304-60832-1-git-send-email-sugar.zhang@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ09IT1ZNHx0aTU8YHksfSh5VEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a8ea41ca76e09d2kunmc6d807c03a7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjY6CDo*DTMTATUZNTFJHhdD
	LCoKCR1VSlVKTEpJSk5LSElOT09OVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
	WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBSENJTDcG
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

This patch add support for interleaved transfer which used
for interleaved audio or 2d video data transfer.

for audio situation, we add 'nump' for number of period frames.

e.g. combine 2 stream into a union one by 2D dma.

DAI0: 16CH
+-------------------------------------------------------------+
| Frame-1 | Frame-2 | Frame-3 | Frame-4 | ...... Frame-'numf' |
+-------------------------------------------------------------+

DAI1: 16CH
+-------------------------------------------------------------+
| Frame-1 | Frame-2 | Frame-3 | Frame-4 | ...... Frame-'numf' |
+-------------------------------------------------------------+

DAI0 + DAI1: 32CH

+-------------------------------------------------------------+
| DAI0-F1 | DAI1-F1 | DAI0-F2 | DAI1-F2 | ......              |
+-------------------------------------------------------------+
|      Frame-1      |      Frame-2      | ...... Frame-'numf' |

For audio situation, we have buffer_size and period_size,
the 'numf' is the buffer_size. so, we need another one for
period_size, e.g. 'nump'.

| Frame-1 | ~ | Frame-'nump' | ~ | Frame-'nump+1' | ~ |  Frame-'numf' |
|

As the above shown:

each DAI0 transfer 1 Frame, should skip a gap size (DAI1-F1)
each DAI1 transfer 1 Frame, should skip a gap size (DAI0-F1)

So, the interleaved template describe as follows:

DAI0:

struct dma_interleaved_template *xt;

xt->sgl[0].size = DAI0-F1;
xt->sgl[0].icg =  DAI1-F1;
xt->nump = nump; //the period_size in frames
xt->numf = numf; //the buffer_size in frames

DAI1:

struct dma_interleaved_template *xt;

xt->sgl[0].size = DAI1-F1;
xt->sgl[0].icg =  DAI0-F1;
xt->nump = nump; //the period_size in frames
xt->numf = numf; //the buffer_size in frames

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

Changes in v2:
- Add the pl330 interleaved transfer

 include/linux/dmaengine.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 752dbde..5263cde 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -144,6 +144,7 @@ struct data_chunk {
  *		Otherwise, destination is filled contiguously (icg ignored).
  *		Ignored if dst_inc is false.
  * @numf: Number of frames in this template.
+ * @nump: Number of period frames in this template.
  * @frame_size: Number of chunks in a frame i.e, size of sgl[].
  * @sgl: Array of {chunk,icg} pairs that make up a frame.
  */
@@ -156,6 +157,7 @@ struct dma_interleaved_template {
 	bool src_sgl;
 	bool dst_sgl;
 	size_t numf;
+	size_t nump;
 	size_t frame_size;
 	struct data_chunk sgl[];
 };
-- 
2.7.4


