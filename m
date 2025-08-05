Return-Path: <dmaengine+bounces-5948-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB55B1AC0C
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 03:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5870117DE17
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 01:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7021E9B3A;
	Tue,  5 Aug 2025 01:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="foc0feWG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85011D5AB7;
	Tue,  5 Aug 2025 01:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357298; cv=none; b=nFh/0wyjgStHYJBngqJc4tb5PWe3cTUdb/+dFVisx8HzoNeawFqf1fDbIKhd0yoemKj6OnVPkDtvmSY32qG1MTlahIlHqeOrx6imYGFGMVYHVXgBnbcCIi4CRYcIgMkOo3VhQcdGTnisgIhd0PT5H0ZB3U/mdMwGd/ILIVDimUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357298; c=relaxed/simple;
	bh=w2K9gcdNs0x+bQQ4NQocswwAKqj6gCP5v/62LBm0zi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eT3opI6QNpTWhzlZDU4SdPFui/RSTlxRG/5CjY33cUq5+HZD7OEMRDEOJgD5aF8ruVoFV3CgQjC5ZrYH7PSqyCa8GL9qjdMcjLw8f1eUwHe6zAZzRf/oLReOdSjDf+DsU0o9hJrLbh93yImEG4uCvwkL44m5YbG7K/4kumBQxbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=foc0feWG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754357297; x=1785893297;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=w2K9gcdNs0x+bQQ4NQocswwAKqj6gCP5v/62LBm0zi8=;
  b=foc0feWGSg1nk8iMswKTELn+nc0Axww8brv0+cbMUuW5zocy1cjp7hHz
   GXme+uJV8WNre5RPZb91kkHZP+tBo1GOgd8RDM1tnLHJhZnZJ4tah8eqe
   WgYJQpZuBBMOo3QbwXpAJaExt90NNUOoNcgtN168GN0gfdkwfDWPqoIwl
   b1Rt5yGCxCdJDBP/KlP31/rWT7x8CG5NSLpVH/5TpM+p9PmnF1m3IWovk
   cfDTYmMVVpTGIotAe/l/E4X9Lm+AqXUfwxCRYvGqoP8YzYm0Olo1/NwPJ
   5xBfTKa8VfOtsKso6NddCASbIa8s4ej60ZNOeB7B7+ng2enm1JaGTfKrj
   Q==;
X-CSE-ConnectionGUID: w8Fa0wbRSuaxRhb0MQdmZQ==
X-CSE-MsgGUID: E54q9k5NTtKlU1v+lYUcXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="68085361"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="68085361"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
X-CSE-ConnectionGUID: uW2rUZpkTei1lNKd2DN4lg==
X-CSE-MsgGUID: akTtzs76Sdi3GSuT2ROH1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169699559"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.32.147]) ([10.98.32.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 04 Aug 2025 18:27:57 -0700
Subject: [PATCH 6/9] dmaengine: idxd: Fix not releasing workqueue on
 .release()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-6-4e020fbf52c1@intel.com>
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754357291; l=811;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=w2K9gcdNs0x+bQQ4NQocswwAKqj6gCP5v/62LBm0zi8=;
 b=cPOmR3w6vItxMTn+RqmUG+hX7v68fpY86f05lVvaKYdJMjnfhMyBm/bdZUMZwn7V4H1krynyv
 5z+JLWPg4p6C5mY2YtY0xMfpBWWJJtMeEAdwJRFLqjVYwtsf9wJl/kq
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

The workqueue associated with an DSA/IAA device is not released when
the object is freed.

Fixes: 47c16ac27d4c ("dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 9f0701021af0e6fbe3c3c04a0e336ee9cd094641..cdd7a59140d90c80f5837473962017114cd00b13 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1812,6 +1812,7 @@ static void idxd_conf_device_release(struct device *dev)
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
+	destroy_workqueue(idxd->wq);
 	kfree(idxd->groups);
 	bitmap_free(idxd->wq_enable_map);
 	kfree(idxd->wqs);

-- 
2.50.1


