Return-Path: <dmaengine+bounces-1480-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091BC889F06
	for <lists+dmaengine@lfdr.de>; Mon, 25 Mar 2024 13:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE8A1F3827E
	for <lists+dmaengine@lfdr.de>; Mon, 25 Mar 2024 12:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F08130A61;
	Mon, 25 Mar 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XJu3axtJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m32123.qiye.163.com (mail-m32123.qiye.163.com [220.197.32.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110E413C66E;
	Mon, 25 Mar 2024 03:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711336626; cv=none; b=a+uaW4ebEYZ62snPgvGV5ZUKDT8TWaQEz+bB79JGbyOdI2f9AqI2iEmS1hg5vIroWr4zQeM5kne3RoxpQCTesAKWkf3Tib897beEIK2E5EfgxX5UhCLxB3r31nGJQTXhdvS5FN+ifXyWgb1YME3wuGPmyzRVedPQlJLQc1H7+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711336626; c=relaxed/simple;
	bh=IV+b5GbhTAg4OFsAhpQ2bmvejJAJKfMTsfB5GnpgPsg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Grbs1gTImPG5E/7ze6qTYyMjzO+sE3Rwg4mLYDedntQm9EbNF8I3olIJ83Q3IGkW4J6+PrSRdutq/YNFjjwoEoTSptxs5gNTjrAoamvYiPCwpqeCvAaFhTcscZT9prb3QCdlidc0eSw9GJmiXA8bGXpHaEd1dQSCCdTp0/01xhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XJu3axtJ; arc=none smtp.client-ip=220.197.32.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=XJu3axtJuclKjDhrBiJnfTTZK1beWCElLQpLCJ5C0A3Z0UK70ZnF8fBg/PxSPLRmYBjnhK46XOcecJ909nhrPk7cH0/VXPmKLQkfPqn+7Sd4sSBwjETQv+zBG8HK26ljiVGSAkoO5dAJ4UrFFFHDKIx49wyPdl2wXJrFJ2rE8p4=;
	c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=jMh34jf4s6vSoWqvWlOz1uTF/jW64ljn7FLzVGPFfxU=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 8C1707C0373;
	Mon, 25 Mar 2024 10:38:10 +0800 (CST)
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: heiko@sntech.de,
	vkoul@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dmaengine: Add support for audio interleaved transfer
Date: Mon, 25 Mar 2024 10:37:49 +0800
Message-Id: <20240325103731.v1.1.I502ea9c86c8403dc5b1f38abf40be8b6ee13c1dc@changeid>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUtLQ1ZNTkJOQ0JMSENOTkpVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a8e7378f5c309d2kunm8c1707c0373
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDo6SBw*NDMLHg04HAscSjQd
	MRkKCT9VSlVKTEpKSEhPSUJKTU5CVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
	WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBSkJLTTcG
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

This patch add support for interleaved transfer which used
for interleaved audio or 2d video data transfer.

for audio situation, we add 'nump' for number of period frames.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

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


