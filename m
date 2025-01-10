Return-Path: <dmaengine+bounces-4095-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED6BA089E0
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 09:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747413A1F25
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 08:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB1F2080FB;
	Fri, 10 Jan 2025 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ai6kumnP"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CD62080E3;
	Fri, 10 Jan 2025 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497369; cv=none; b=Iwc0QKC4CyLE4NLyJ5UUIjQhHgPCCdyc/I1yOBpyi8Fqc6fmzbfQZPvtHLKSXVW0CbHG+jQDc4BVlkjH4ktuaerFxppTnKAlNjfeD46rMJd5QkTxIFMp1uvEpXcXokY65KMvUXRPBjcV3I1/rcR3RA71sOiiMKPsyzAeO1/r1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497369; c=relaxed/simple;
	bh=3uyhXy5PSrQnoLWxSs9AJR7+HGOIKdGdCsPnt6Q/Waw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rGw38QIhSIo1JbEKTMciUSLO4G0KLJeNBFC6oFXnPZQ5raYhqeB4DP6q8vvssIIVRDZBQFUZ5AfL1rndRbbs+LMAmgpb4KaIUsubjeB50kU8OZHztcOnnl3zaS/MsyzuHhICPl0wsCTSMUYsLCUuqAiIlYbLo6bSQ+k3/2aBFLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ai6kumnP; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736497359; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=uzfh0r8O7bF0Jsshy+sDijZHeb2niU6oJaNTfiM6qI4=;
	b=ai6kumnPF0VGqY6l+DsT6EuqZ+hnB1x5QHvyvOzmXsCZhwbI6mBJf290CykE19/kKKcOxSJuE0MrESKvDrN3czKZXgncN5g+FAS4E62gixRMdgKCzGNXSVXNyESM2wLOwkvldZkzcyTSUCHeAs0SS38yXjDb4kxYOt/yxGFD8DQ=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WNKKAwc_1736497357 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Jan 2025 16:22:39 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: fenghua.yu@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] dmaengine: idxd: fix memory leak in error handling path
Date: Fri, 10 Jan 2025 16:22:32 +0800
Message-ID: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shuai Xue (5):
  dmaengine: idxd: fix memory leak in error handling path of
    idxd_setup_wqs
  dmaengine: idxd: fix memory leak in error handling path of
    idxd_setup_engines
  dmaengine: idxd: fix memory leak in error handling path of
    idxd_setup_groups
  dmaengine: idxd: fix memory leak in error handling path of idxd_alloc
  dmaengine: idxd: fix memory leak in error handling path of
    idxd_pci_probe

 drivers/dma/idxd/init.c | 62 ++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 13 deletions(-)

-- 
2.39.3


