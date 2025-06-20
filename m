Return-Path: <dmaengine+bounces-5544-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E6CAE1BB6
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jun 2025 15:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D12147AA873
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jun 2025 13:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D699128C857;
	Fri, 20 Jun 2025 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jG2L3H3x"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C238428D8F8;
	Fri, 20 Jun 2025 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425013; cv=none; b=uqD6nRaYY6AE14Zvrir65/kEp7JlAPrvew8DkyvQrnk4LNKfsiqbdy0FpCJnUXP4IOOd9axOEPm/ReOcf5M89anikYh8LDymo6wMNk6DhXNPk7q8Ns8OZ9aF7VBI+cfAmZGQcjtFFiaUo/7egj/lb0EwptjSdRG1HuP1vH6ygXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425013; c=relaxed/simple;
	bh=wD9kvq63OMsE8gXCXi6rVt39wRx5i7RafSZhiuPMUsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gmnn/iR50bOr35Ak12OnQ3dKM0DB3xuENVHVOPxu38532SaW3K3pap6lOOEii/abu/16+fSHV/4+3bDUvqbe+84jCG222tPVa/pMQEuAU9pj1UR/6/2aTMiz2vnLYodjexbFhe5KJgs7MBsmTB/LAui3qWq7sGyHPso142UI4eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jG2L3H3x; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750425011; x=1781961011;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wD9kvq63OMsE8gXCXi6rVt39wRx5i7RafSZhiuPMUsY=;
  b=jG2L3H3xTPbvsAzlAkHRuyaTu9CFjHpRV0dNtE8/3H6Q+9DDqq9UxpjS
   /Nu+oDVAU9ricuYbj9Ceipf69IDdYUmBdryR390G7QmHOx1COQaHHSHXH
   v6GuRPg1XC/PAUbBn2cZLcQL+CmEChjBoEt07yyqH34T1btWZy5KXgf7U
   bW7JLK0fPNQtg+JTL+Z9VSX64rVhh8+zujNRSrqpq1tGk3Womx42XAvbo
   UgcXPbqg5U9No8XwMiuLn5yuMZWTzjTjCK8uy1QX95YolsXpW0DLOhmlH
   qWGIi0Q2g9oUoaVVsRR5uCKQIjCpj5nQLsmZN1nW9uSvkT7jNB/ilhp1i
   Q==;
X-CSE-ConnectionGUID: KTu4gOQNTgufU+6goce4iw==
X-CSE-MsgGUID: UIKwuTsXQwKxttdELUrYOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52388881"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="52388881"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 06:10:10 -0700
X-CSE-ConnectionGUID: wPgNx4wkQ5yTzmcAsPz8uw==
X-CSE-MsgGUID: DKYJufbMTNSmphM4gFzFZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="154928674"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by fmviesa003.fm.intel.com with ESMTP; 20 Jun 2025 06:10:07 -0700
From: Yi Sun <yi.sun@intel.com>
To: dave.jiang@intel.com,
	vinicius.gomes@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fenghuay@nvidia.com,
	philip.lantz@intel.com
Cc: yi.sun@intel.com,
	gordon.jin@intel.com,
	anil.s.keshavamurthy@intel.com
Subject: [PATCH v2 0/2] dmaengine: idxd: Add basic DSA 3.0 capability and SGL support
Date: Fri, 20 Jun 2025 21:09:51 +0800
Message-ID: <20250620130953.1943703-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces foundational support for DSA 3.0 features,
exposing hardware capability registers to userspace in the IDXD driver.

DSA 3.0 introduces several new features that require awareness and
configuration from both kernel and userspace. It is necessary to
understand the hardware's capabilities for userspace tools (e.g.,
idxd-config, libraries, and applications) to make use of the features
properly, such as supported features, memory layouts, and opcode
compatibility.

Patch 1/2 exposes the three new capability registers (dsacap0-2)
introduced in the DSA 3.0 specification through a new sysfs entry.
This allows tools and users to query hardware capabilities such as
supported SGL formats, floating-point options, and maximum supported
sizes.

Patch 2/2 enables configuration of the maximum SGL size for DSA 3.0
devices. Some DSA 3.0 opcodes (e.g., Gather Copy, Gather Reduce) require
that the workqueue's SGL size is explicitly configured. This patch sets
that value based on hardware capabilities at initialization time,
allowing these opcodes to function without additional user configuration.

---
Changes in v2:
- Added the link to the DSA 3.0 spec in the commit message (Dave)
- Fixed typos in the commit messages (Fenghua)
- Updated the sysfs ABI documentation for accuracy (Fenghua)
- Renamed the ABI entry from 'dsacap' to 'dsacaps' (Fenghua, Philip)
- Moved the definition of dsacap0_reg from patch #2 to patch #1 (Fenghua)
- Fixed the output format (Fenghua, Philip)
- Reordered the capability registers to match the DSA 3.0 spec (Fenghua)
- Add conditon checking to avoid accessing dsacaps when DSA 3.0 is not
  supported (Fenghua)

Yi Sun (2):
  dmaengine: idxd: Expose DSA3.0 capabilities through sysfs
  dmaengine: idxd: Add Max SGL Size Support for DSA3.0

 .../ABI/stable/sysfs-driver-dma-idxd          | 15 ++++++++++
 drivers/dma/idxd/device.c                     |  5 ++++
 drivers/dma/idxd/idxd.h                       | 19 +++++++++++++
 drivers/dma/idxd/init.c                       | 11 ++++++++
 drivers/dma/idxd/registers.h                  | 28 ++++++++++++++++++-
 drivers/dma/idxd/sysfs.c                      | 24 ++++++++++++++++
 6 files changed, 101 insertions(+), 1 deletion(-)

-- 
2.43.0


