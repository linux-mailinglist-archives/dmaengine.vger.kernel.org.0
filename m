Return-Path: <dmaengine+bounces-5244-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67648AC049F
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 08:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55F11BC06B4
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 06:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AC01B21AD;
	Thu, 22 May 2025 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cQ0D3NUP"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C59F1714B4;
	Thu, 22 May 2025 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747895626; cv=none; b=uasMvbyZC8iEygty4pBgCB0j9KK6LNNmlFm1WgY9yzdlQO6xv+1dbyNcZqtjSgarvSP1N6lQ8dlEcea7Udjj5etxPkVjM9eM81Xi0hHvAvIDy8TcPv28m/shjn/6dxJhYZl5WkNS+x8xvYbc+suBblBtpxJZ60pT9g9OmLozack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747895626; c=relaxed/simple;
	bh=CUFxhyDVr0xLwX7m27ThYmU07naEB+SMbY+iLXOBXt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckUVUuf6UHxwRS4K2LSqwTXObCbYozpZsNeuNmxSj9UMA+D4R+t/rLU/gdSJ6COk9BqqEK1ofp+rTl3izAASbUFpcOo4gN/Wss3dWtDluivhsojzDbREcBwjFLPx9YwpA1zhk5jD1BDL9xjnDjhVoR2mwxX65Ip3CZQrvvGCWwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cQ0D3NUP; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747895613; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6u+Ws6X5pzzDW5QmSYZtMVI4ITusZY9qox+oFBTbG7M=;
	b=cQ0D3NUPPxucsRyZDusK2qSPHaXOpDqRn5amT+wkPj+4nd1qLTOA3w4akp2Hwpov7RrPgsGATDi6Xq6y75gZ+tI0jk1k1IOF4AbILJmRtqIJWhw6C+FqUiOegOWsj2JT15p8mNQN0mz3Y6RmYTK97ruPiTeehmWjfO73oEjlFYo=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WbUiQMz_1747895611 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 May 2025 14:33:32 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	fenghuay@nvidia.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	colin.i.king@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] dmaengine: idxd: minor fixes for idxd driver
Date: Thu, 22 May 2025 14:33:27 +0800
Message-ID: <20250522063329.51156-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two minor fixes for idxd driver.

Shuai Xue (2):
  dmaengine: idxd: Fix race condition between WQ enable and reset paths
  dmaengine: idxd: fix potential NULL pointer dereference on wq setup
    error path

 drivers/dma/idxd/device.c | 20 ++++++++++++++++++--
 drivers/dma/idxd/init.c   |  3 ++-
 2 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.43.5


