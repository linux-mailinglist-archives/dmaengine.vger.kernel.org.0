Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A199474C93
	for <lists+dmaengine@lfdr.de>; Tue, 14 Dec 2021 21:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbhLNUXF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Dec 2021 15:23:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:22040 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229795AbhLNUXE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Dec 2021 15:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639513384; x=1671049384;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RtKOIgUsX0ONjn3LDYm25DDa4ssMMVTq7ABiD1A96fg=;
  b=iB0320x8QAEdCNQkB1x56tgkUm4PKLM/EGwah39qk+OsRwbuP6w86K8k
   jMzwEjcBAjI8X+ivjQlXtr+QBfjjEugv9sj+THQMeqc9yTTu0MJPBneUI
   lE3lCzRx3jNGI+J0D49GUw3n9PP/te17TdmbJ2VxfC9xo1nNsVmC26fnW
   yj+POgPOHtZ1ZMNDS8bTsxLsHwoxhUMtnwlugazO+kPmCHHLy023NZyZZ
   ro1G4jQG/wJDsLZD0YsJALZS1v5+LtMx/modfWawAhQNHukkLg9SHM1gA
   ct2Jp43Zf4WQNj66XZQK2purPrJtJAwnHK80lhYrEKmFoTR4JoAOAXlTv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="219094454"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="219094454"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 12:23:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="753107996"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 12:23:04 -0800
Subject: [PATCH 0/2] Repalce term 'token' with 'read buffer'
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 14 Dec 2021 13:23:03 -0700
Message-ID: <163951326835.2988321.1053110337527742301.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DSA spec v1.2 has replaced the term 'token' with 'read buffer' to clarify
the intended usage. Update driver to replace 'token' with 'read buffer' in
order to be in sync with the spec and remove confusion.

Old token sysfs attributes is moved to deprecated under documentation and
will print warning when used.

---

Dave Jiang (2):
      dmaengine: idxd: change bandwidth token to read buffers
      dmaengine: idxd: deprecate token sysfs attributes for read buffers


 .../ABI/stable/sysfs-driver-dma-idxd          |  47 +++--
 drivers/dma/idxd/device.c                     |  25 ++-
 drivers/dma/idxd/idxd.h                       |  12 +-
 drivers/dma/idxd/init.c                       |   6 +-
 drivers/dma/idxd/registers.h                  |  14 +-
 drivers/dma/idxd/sysfs.c                      | 177 +++++++++++++-----
 6 files changed, 197 insertions(+), 84 deletions(-)

--

