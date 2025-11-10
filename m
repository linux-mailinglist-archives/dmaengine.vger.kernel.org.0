Return-Path: <dmaengine+bounces-7106-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F98EC45754
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 09:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B923B4405
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 08:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9851A2FD689;
	Mon, 10 Nov 2025 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lx6z4nC+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B52FCC17;
	Mon, 10 Nov 2025 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764834; cv=none; b=qJ1KJ+aiK/WsRq4K4Qe+XXx/yD4y5WE6rue+a/c3ArWBsyA1RQM6ddfkdAPRYpUHQ0NOaWhhSyWE/UdeWe75kspWaaPxtblFQuURi9qJMfFvXayG+bn2zTjDklJtSTfgeqftxue5HEWFh8H6d7u4mvteSRIakn30oZyp794pDrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764834; c=relaxed/simple;
	bh=crbMG+pzsPkQNipuqRNtjlB6OdHSkO2qYPLzI5EzOjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsXrQgX3//dO6IfYyLioN6ZN2PlYRyMhfjpdbIkkozO8ITRoSXxF5zy4FULqVFFOqO4P4/PKmhh79WrRTIUtCsUKIpEwV1RJjaZdkK+8qcKZDAIEDhsvqqIc934Upx/gCFFaXSACR8e06oI60DfuZzZRQRN20/+kpaz/pAgjmgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lx6z4nC+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762764833; x=1794300833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=crbMG+pzsPkQNipuqRNtjlB6OdHSkO2qYPLzI5EzOjw=;
  b=lx6z4nC+DGiRyZjpcEQpTs0EMn03TMazLDWoTPGnyQj4ML0ab/PUF7gl
   sDZFai+L6ttAXEuKNm347LIQAuaKfKBM8SXGLtoRuRAnob4RZRRBqqOCa
   wL8ACkJc7I0/Pkd40fOt+o8EejLp1yRgoDJ2RAk0BpKNKjPsKA3iqtUJ4
   IalsTT37mS+7S102f2c5KfMQ7jaEeDIlDotO2EcQy0yCnWx8wk+qqVWXP
   pa9xtXXnooGRvHbtX3De5QrDJzQTnhghQ7hKmZX8mhmXpIBwyNxyfkC2k
   tiL/EtO9ZTkYfxjFiVgbeu/nsE2g+onIGF2eSV8iVNKnQ7lBNKVZDUXC+
   g==;
X-CSE-ConnectionGUID: Ew4XA0lgS+2nFUrJbvaQPw==
X-CSE-MsgGUID: khTRkNzGQje7mbrzEmE4GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="63818366"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="63818366"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 00:53:52 -0800
X-CSE-ConnectionGUID: exRcMnyPTmWxGv7zlDb7Lg==
X-CSE-MsgGUID: OGo+ISxGTIq097lQk77ysA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="187927395"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 10 Nov 2025 00:53:51 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2449096; Mon, 10 Nov 2025 09:53:50 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 1/3] dmaengine: Refactor devm_dma_request_chan() for readability
Date: Mon, 10 Nov 2025 09:47:43 +0100
Message-ID: <20251110085349.3414507-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251110085349.3414507-1-andriy.shevchenko@linux.intel.com>
References: <20251110085349.3414507-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yes, while it's a bit longer in terms of LoCs, it's more readable
when we use the usual patter to check for errors, and not for
a success). This eliminates unneeded assignment and moves the
needed one closer to its user which is better programming pattern
because it allows avoiding potential errors in case the variable
is getting reused. Also note that the same pattern have been used
already in dmaenginem_async_device_register().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmaengine.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ca13cd39330b..eb27a72cd4c5 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -943,12 +943,14 @@ static void dmaenginem_release_channel(void *chan)
 
 struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
 {
-	struct dma_chan *chan = dma_request_chan(dev, name);
-	int ret = 0;
+	struct dma_chan *chan;
+	int ret;
 
-	if (!IS_ERR(chan))
-		ret = devm_add_action_or_reset(dev, dmaenginem_release_channel, chan);
+	chan = dma_request_chan(dev, name);
+	if (IS_ERR(chan))
+	        return chan;
 
+	ret = devm_add_action_or_reset(dev, dmaenginem_release_channel, chan);
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.50.1


