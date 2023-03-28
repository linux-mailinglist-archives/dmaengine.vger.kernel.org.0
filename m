Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379806CC6E3
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 17:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjC1PmR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 11:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjC1Pli (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 11:41:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0420FD311;
        Tue, 28 Mar 2023 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680018037; x=1711554037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AMA8EofbhA//DFk0oiAVA/xLpdgoMD5167QPiuE+r7k=;
  b=ePfXzgth/n/pSGtkl1WJJ2IIWKBDXvw1NYYjWhOs9xL7CkUuOsRWFf1o
   UegzUk867xczfTdz1qdaIa2Dgxl3kYcnsf1lmokNAu2W7t1rFJbe1yn7K
   7p2qnPtAzHvNqAoHKcaTEh24BryGTfq/iRJz+vuFaUzRKd87Sdujlxe6q
   MxLcNLQ0lQb6bzPOgfzyilycUD7XLel2A0koOJFRwYMXVh67BAgIX6uHB
   MBQ4MajHd+VlGuMg3JsqauAifsHtzQJqCbjoS3OEj39JfTCjmHlZfNNJt
   7T8WO2Ceo4STgbUwLEQSdSWApfgs+Q4IGKU1NK941ZLMacqUFShtAvKFe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="405543678"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="405543678"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="773185280"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="773185280"
Received: from sdwarak1-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.127.200])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:40:02 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        clabbe@baylibre.com, daniele.alessandrelli@intel.com,
        prabhjot.khurana@intel.com, mgross@linux.intel.com,
        declan.murphy@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 3/3] crypto: qat - Move driver to drivers/crypto/intel/qat
Date:   Tue, 28 Mar 2023 10:39:51 -0500
Message-Id: <20230328153951.126564-4-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328153951.126564-1-tom.zanussi@linux.intel.com>
References: <20230328153951.126564-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With the growing number of Intel crypto drivers, it makes sense to
group them all into a single drivers/crypto/intel/ directory.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 MAINTAINERS                                                     | 2 +-
 drivers/crypto/Kconfig                                          | 1 -
 drivers/crypto/Makefile                                         | 1 -
 drivers/crypto/intel/Kconfig                                    | 1 +
 drivers/crypto/intel/Makefile                                   | 1 +
 drivers/crypto/{ => intel}/qat/Kconfig                          | 0
 drivers/crypto/{ => intel}/qat/Makefile                         | 0
 drivers/crypto/{ => intel}/qat/qat_4xxx/Makefile                | 0
 drivers/crypto/{ => intel}/qat/qat_4xxx/adf_4xxx_hw_data.c      | 0
 drivers/crypto/{ => intel}/qat/qat_4xxx/adf_4xxx_hw_data.h      | 0
 drivers/crypto/{ => intel}/qat/qat_4xxx/adf_drv.c               | 0
 drivers/crypto/{ => intel}/qat/qat_c3xxx/Makefile               | 0
 drivers/crypto/{ => intel}/qat/qat_c3xxx/adf_c3xxx_hw_data.c    | 0
 drivers/crypto/{ => intel}/qat/qat_c3xxx/adf_c3xxx_hw_data.h    | 0
 drivers/crypto/{ => intel}/qat/qat_c3xxx/adf_drv.c              | 0
 drivers/crypto/{ => intel}/qat/qat_c3xxxvf/Makefile             | 0
 .../crypto/{ => intel}/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c    | 0
 .../crypto/{ => intel}/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.h    | 0
 drivers/crypto/{ => intel}/qat/qat_c3xxxvf/adf_drv.c            | 0
 drivers/crypto/{ => intel}/qat/qat_c62x/Makefile                | 0
 drivers/crypto/{ => intel}/qat/qat_c62x/adf_c62x_hw_data.c      | 0
 drivers/crypto/{ => intel}/qat/qat_c62x/adf_c62x_hw_data.h      | 0
 drivers/crypto/{ => intel}/qat/qat_c62x/adf_drv.c               | 0
 drivers/crypto/{ => intel}/qat/qat_c62xvf/Makefile              | 0
 drivers/crypto/{ => intel}/qat/qat_c62xvf/adf_c62xvf_hw_data.c  | 0
 drivers/crypto/{ => intel}/qat/qat_c62xvf/adf_c62xvf_hw_data.h  | 0
 drivers/crypto/{ => intel}/qat/qat_c62xvf/adf_drv.c             | 0
 drivers/crypto/{ => intel}/qat/qat_common/Makefile              | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_accel_devices.h   | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_accel_engine.c    | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_admin.c           | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_aer.c             | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_cfg.c             | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_cfg.h             | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_cfg_common.h      | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_cfg_strings.h     | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_cfg_user.h        | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_common_drv.h      | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_ctl_drv.c         | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_dev_mgr.c         | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_config.c     | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_config.h     | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_dc.c         | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_dc.h         | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_hw_data.c    | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_hw_data.h    | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_pfvf.c       | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_pfvf.h       | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_dc.c         | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_dc.h         | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_hw_data.c    | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_hw_data.h    | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_pfvf.c       | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_pfvf.h       | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_pm.c         | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_pm.h         | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_hw_arbiter.c      | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_init.c            | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_isr.c             | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_msg.h        | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_pf_msg.c     | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_pf_msg.h     | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_pf_proto.c   | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_pf_proto.h   | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_utils.c      | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_utils.h      | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_vf_msg.c     | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_vf_msg.h     | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_vf_proto.c   | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_vf_proto.h   | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_sriov.c           | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_sysfs.c           | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_transport.c       | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_transport.h       | 0
 .../{ => intel}/qat/qat_common/adf_transport_access_macros.h    | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_transport_debug.c | 0
 .../crypto/{ => intel}/qat/qat_common/adf_transport_internal.h  | 0
 drivers/crypto/{ => intel}/qat/qat_common/adf_vf_isr.c          | 0
 drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw.h          | 0
 drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_comp.h     | 0
 .../crypto/{ => intel}/qat/qat_common/icp_qat_fw_init_admin.h   | 0
 drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_la.h       | 0
 .../{ => intel}/qat/qat_common/icp_qat_fw_loader_handle.h       | 0
 drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_pke.h      | 0
 drivers/crypto/{ => intel}/qat/qat_common/icp_qat_hal.h         | 0
 drivers/crypto/{ => intel}/qat/qat_common/icp_qat_hw.h          | 0
 drivers/crypto/{ => intel}/qat/qat_common/icp_qat_hw_20_comp.h  | 0
 .../crypto/{ => intel}/qat/qat_common/icp_qat_hw_20_comp_defs.h | 0
 drivers/crypto/{ => intel}/qat/qat_common/icp_qat_uclo.h        | 0
 drivers/crypto/{ => intel}/qat/qat_common/qat_algs.c            | 0
 drivers/crypto/{ => intel}/qat/qat_common/qat_algs_send.c       | 0
 drivers/crypto/{ => intel}/qat/qat_common/qat_algs_send.h       | 0
 drivers/crypto/{ => intel}/qat/qat_common/qat_asym_algs.c       | 0
 drivers/crypto/{ => intel}/qat/qat_common/qat_bl.c              | 0
 drivers/crypto/{ => intel}/qat/qat_common/qat_bl.h              | 0
 drivers/crypto/{ => intel}/qat/qat_common/qat_comp_algs.c       | 0
 drivers/crypto/{ => intel}/qat/qat_common/qat_comp_req.h        | 0
 drivers/crypto/{ => intel}/qat/qat_common/qat_compression.c     | 0
 drivers/crypto/{ => intel}/qat/qat_common/qat_compression.h     | 0
 drivers/crypto/{ => intel}/qat/qat_common/qat_crypto.c          | 0
 drivers/crypto/{ => intel}/qat/qat_common/qat_crypto.h          | 0
 drivers/crypto/{ => intel}/qat/qat_common/qat_hal.c             | 0
 drivers/crypto/{ => intel}/qat/qat_common/qat_uclo.c            | 0
 drivers/crypto/{ => intel}/qat/qat_dh895xcc/Makefile            | 0
 .../crypto/{ => intel}/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c  | 0
 .../crypto/{ => intel}/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h  | 0
 drivers/crypto/{ => intel}/qat/qat_dh895xcc/adf_drv.c           | 0
 drivers/crypto/{ => intel}/qat/qat_dh895xccvf/Makefile          | 0
 .../{ => intel}/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c     | 0
 .../{ => intel}/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.h     | 0
 drivers/crypto/{ => intel}/qat/qat_dh895xccvf/adf_drv.c         | 0
 111 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/crypto/{ => intel}/qat/Kconfig (100%)
 rename drivers/crypto/{ => intel}/qat/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_4xxx/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_4xxx/adf_4xxx_hw_data.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_4xxx/adf_4xxx_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_4xxx/adf_drv.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c3xxx/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c3xxx/adf_c3xxx_hw_data.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c3xxx/adf_c3xxx_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c3xxx/adf_drv.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c3xxxvf/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c3xxxvf/adf_drv.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c62x/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c62x/adf_c62x_hw_data.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c62x/adf_c62x_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c62x/adf_drv.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c62xvf/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c62xvf/adf_c62xvf_hw_data.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c62xvf/adf_c62xvf_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_c62xvf/adf_drv.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_accel_devices.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_accel_engine.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_admin.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_aer.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_cfg.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_cfg.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_cfg_common.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_cfg_strings.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_cfg_user.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_common_drv.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_ctl_drv.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_dev_mgr.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_config.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_config.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_dc.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_dc.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_hw_data.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_pfvf.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_pfvf.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_dc.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_dc.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_hw_data.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_pfvf.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_pfvf.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_pm.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_pm.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_hw_arbiter.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_init.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_isr.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_msg.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_pf_msg.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_pf_msg.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_pf_proto.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_pf_proto.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_utils.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_utils.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_vf_msg.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_vf_msg.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_vf_proto.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_vf_proto.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_sriov.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_sysfs.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_transport.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_transport.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_transport_access_macros.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_transport_debug.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_transport_internal.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/adf_vf_isr.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_comp.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_init_admin.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_la.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_loader_handle.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_pke.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_hal.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_hw.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_hw_20_comp.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_hw_20_comp_defs.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_uclo.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_algs.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_algs_send.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_algs_send.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_asym_algs.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_bl.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_bl.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_comp_algs.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_comp_req.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_compression.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_compression.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_crypto.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_crypto.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_hal.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_common/qat_uclo.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_dh895xcc/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_dh895xcc/adf_drv.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_dh895xccvf/Makefile (100%)
 rename drivers/crypto/{ => intel}/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c (100%)
 rename drivers/crypto/{ => intel}/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.h (100%)
 rename drivers/crypto/{ => intel}/qat/qat_dh895xccvf/adf_drv.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index e49d331aba47..da46f5a96fef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17026,7 +17026,7 @@ QAT DRIVER
 M:	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
 L:	qat-linux@intel.com
 S:	Supported
-F:	drivers/crypto/qat/
+F:	drivers/crypto/intel/qat/
 
 QCOM AUDIO (ASoC) DRIVERS
 M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 007299bcd36c..38296235c3e6 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -487,7 +487,6 @@ config CRYPTO_DEV_MXS_DCP
 	  To compile this driver as a module, choose M here: the module
 	  will be called mxs-dcp.
 
-source "drivers/crypto/qat/Kconfig"
 source "drivers/crypto/cavium/cpt/Kconfig"
 source "drivers/crypto/cavium/nitrox/Kconfig"
 source "drivers/crypto/marvell/Kconfig"
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 17f323718b6a..51d36701e785 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -32,7 +32,6 @@ obj-$(CONFIG_CRYPTO_DEV_OMAP_SHAM) += omap-sham.o
 obj-$(CONFIG_CRYPTO_DEV_PADLOCK_AES) += padlock-aes.o
 obj-$(CONFIG_CRYPTO_DEV_PADLOCK_SHA) += padlock-sha.o
 obj-$(CONFIG_CRYPTO_DEV_PPC4XX) += amcc/
-obj-$(CONFIG_CRYPTO_DEV_QAT) += qat/
 obj-$(CONFIG_CRYPTO_DEV_QCE) += qce/
 obj-$(CONFIG_CRYPTO_DEV_QCOM_RNG) += qcom-rng.o
 obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP) += rockchip/
diff --git a/drivers/crypto/intel/Kconfig b/drivers/crypto/intel/Kconfig
index a777e558b004..a82ead557563 100644
--- a/drivers/crypto/intel/Kconfig
+++ b/drivers/crypto/intel/Kconfig
@@ -3,3 +3,4 @@
 source "drivers/crypto/intel/iaa/Kconfig"
 source "drivers/crypto/intel/keembay/Kconfig"
 source "drivers/crypto/intel/ixp4xx/Kconfig"
+source "drivers/crypto/intel/qat/Kconfig"
diff --git a/drivers/crypto/intel/Makefile b/drivers/crypto/intel/Makefile
index 93a3cf3a8703..4d5d0129930b 100644
--- a/drivers/crypto/intel/Makefile
+++ b/drivers/crypto/intel/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO) += iaa/
 obj-y += keembay/
 obj-y += ixp4xx/
+obj-$(CONFIG_CRYPTO_DEV_QAT) += qat/
diff --git a/drivers/crypto/qat/Kconfig b/drivers/crypto/intel/qat/Kconfig
similarity index 100%
rename from drivers/crypto/qat/Kconfig
rename to drivers/crypto/intel/qat/Kconfig
diff --git a/drivers/crypto/qat/Makefile b/drivers/crypto/intel/qat/Makefile
similarity index 100%
rename from drivers/crypto/qat/Makefile
rename to drivers/crypto/intel/qat/Makefile
diff --git a/drivers/crypto/qat/qat_4xxx/Makefile b/drivers/crypto/intel/qat/qat_4xxx/Makefile
similarity index 100%
rename from drivers/crypto/qat/qat_4xxx/Makefile
rename to drivers/crypto/intel/qat/qat_4xxx/Makefile
diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
similarity index 100%
rename from drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
rename to drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h
similarity index 100%
rename from drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
rename to drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h
diff --git a/drivers/crypto/qat/qat_4xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
similarity index 100%
rename from drivers/crypto/qat/qat_4xxx/adf_drv.c
rename to drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
diff --git a/drivers/crypto/qat/qat_c3xxx/Makefile b/drivers/crypto/intel/qat/qat_c3xxx/Makefile
similarity index 100%
rename from drivers/crypto/qat/qat_c3xxx/Makefile
rename to drivers/crypto/intel/qat/qat_c3xxx/Makefile
diff --git a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c b/drivers/crypto/intel/qat/qat_c3xxx/adf_c3xxx_hw_data.c
similarity index 100%
rename from drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
rename to drivers/crypto/intel/qat/qat_c3xxx/adf_c3xxx_hw_data.c
diff --git a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h b/drivers/crypto/intel/qat/qat_c3xxx/adf_c3xxx_hw_data.h
similarity index 100%
rename from drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h
rename to drivers/crypto/intel/qat/qat_c3xxx/adf_c3xxx_hw_data.h
diff --git a/drivers/crypto/qat/qat_c3xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c
similarity index 100%
rename from drivers/crypto/qat/qat_c3xxx/adf_drv.c
rename to drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c
diff --git a/drivers/crypto/qat/qat_c3xxxvf/Makefile b/drivers/crypto/intel/qat/qat_c3xxxvf/Makefile
similarity index 100%
rename from drivers/crypto/qat/qat_c3xxxvf/Makefile
rename to drivers/crypto/intel/qat/qat_c3xxxvf/Makefile
diff --git a/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c b/drivers/crypto/intel/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
similarity index 100%
rename from drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
rename to drivers/crypto/intel/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
diff --git a/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.h b/drivers/crypto/intel/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.h
similarity index 100%
rename from drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.h
rename to drivers/crypto/intel/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.h
diff --git a/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c b/drivers/crypto/intel/qat/qat_c3xxxvf/adf_drv.c
similarity index 100%
rename from drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
rename to drivers/crypto/intel/qat/qat_c3xxxvf/adf_drv.c
diff --git a/drivers/crypto/qat/qat_c62x/Makefile b/drivers/crypto/intel/qat/qat_c62x/Makefile
similarity index 100%
rename from drivers/crypto/qat/qat_c62x/Makefile
rename to drivers/crypto/intel/qat/qat_c62x/Makefile
diff --git a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c b/drivers/crypto/intel/qat/qat_c62x/adf_c62x_hw_data.c
similarity index 100%
rename from drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
rename to drivers/crypto/intel/qat/qat_c62x/adf_c62x_hw_data.c
diff --git a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h b/drivers/crypto/intel/qat/qat_c62x/adf_c62x_hw_data.h
similarity index 100%
rename from drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h
rename to drivers/crypto/intel/qat/qat_c62x/adf_c62x_hw_data.h
diff --git a/drivers/crypto/qat/qat_c62x/adf_drv.c b/drivers/crypto/intel/qat/qat_c62x/adf_drv.c
similarity index 100%
rename from drivers/crypto/qat/qat_c62x/adf_drv.c
rename to drivers/crypto/intel/qat/qat_c62x/adf_drv.c
diff --git a/drivers/crypto/qat/qat_c62xvf/Makefile b/drivers/crypto/intel/qat/qat_c62xvf/Makefile
similarity index 100%
rename from drivers/crypto/qat/qat_c62xvf/Makefile
rename to drivers/crypto/intel/qat/qat_c62xvf/Makefile
diff --git a/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c b/drivers/crypto/intel/qat/qat_c62xvf/adf_c62xvf_hw_data.c
similarity index 100%
rename from drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
rename to drivers/crypto/intel/qat/qat_c62xvf/adf_c62xvf_hw_data.c
diff --git a/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.h b/drivers/crypto/intel/qat/qat_c62xvf/adf_c62xvf_hw_data.h
similarity index 100%
rename from drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.h
rename to drivers/crypto/intel/qat/qat_c62xvf/adf_c62xvf_hw_data.h
diff --git a/drivers/crypto/qat/qat_c62xvf/adf_drv.c b/drivers/crypto/intel/qat/qat_c62xvf/adf_drv.c
similarity index 100%
rename from drivers/crypto/qat/qat_c62xvf/adf_drv.c
rename to drivers/crypto/intel/qat/qat_c62xvf/adf_drv.c
diff --git a/drivers/crypto/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
similarity index 100%
rename from drivers/crypto/qat/qat_common/Makefile
rename to drivers/crypto/intel/qat/qat_common/Makefile
diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_accel_devices.h
rename to drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
diff --git a/drivers/crypto/qat/qat_common/adf_accel_engine.c b/drivers/crypto/intel/qat/qat_common/adf_accel_engine.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_accel_engine.c
rename to drivers/crypto/intel/qat/qat_common/adf_accel_engine.c
diff --git a/drivers/crypto/qat/qat_common/adf_admin.c b/drivers/crypto/intel/qat/qat_common/adf_admin.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_admin.c
rename to drivers/crypto/intel/qat/qat_common/adf_admin.c
diff --git a/drivers/crypto/qat/qat_common/adf_aer.c b/drivers/crypto/intel/qat/qat_common/adf_aer.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_aer.c
rename to drivers/crypto/intel/qat/qat_common/adf_aer.c
diff --git a/drivers/crypto/qat/qat_common/adf_cfg.c b/drivers/crypto/intel/qat/qat_common/adf_cfg.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_cfg.c
rename to drivers/crypto/intel/qat/qat_common/adf_cfg.c
diff --git a/drivers/crypto/qat/qat_common/adf_cfg.h b/drivers/crypto/intel/qat/qat_common/adf_cfg.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_cfg.h
rename to drivers/crypto/intel/qat/qat_common/adf_cfg.h
diff --git a/drivers/crypto/qat/qat_common/adf_cfg_common.h b/drivers/crypto/intel/qat/qat_common/adf_cfg_common.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_cfg_common.h
rename to drivers/crypto/intel/qat/qat_common/adf_cfg_common.h
diff --git a/drivers/crypto/qat/qat_common/adf_cfg_strings.h b/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_cfg_strings.h
rename to drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h
diff --git a/drivers/crypto/qat/qat_common/adf_cfg_user.h b/drivers/crypto/intel/qat/qat_common/adf_cfg_user.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_cfg_user.h
rename to drivers/crypto/intel/qat/qat_common/adf_cfg_user.h
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_common_drv.h
rename to drivers/crypto/intel/qat/qat_common/adf_common_drv.h
diff --git a/drivers/crypto/qat/qat_common/adf_ctl_drv.c b/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_ctl_drv.c
rename to drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
diff --git a/drivers/crypto/qat/qat_common/adf_dev_mgr.c b/drivers/crypto/intel/qat/qat_common/adf_dev_mgr.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_dev_mgr.c
rename to drivers/crypto/intel/qat/qat_common/adf_dev_mgr.c
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_config.c b/drivers/crypto/intel/qat/qat_common/adf_gen2_config.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_gen2_config.c
rename to drivers/crypto/intel/qat/qat_common/adf_gen2_config.c
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_config.h b/drivers/crypto/intel/qat/qat_common/adf_gen2_config.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_gen2_config.h
rename to drivers/crypto/intel/qat/qat_common/adf_gen2_config.h
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_dc.c b/drivers/crypto/intel/qat/qat_common/adf_gen2_dc.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_gen2_dc.c
rename to drivers/crypto/intel/qat/qat_common/adf_gen2_dc.c
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_dc.h b/drivers/crypto/intel/qat/qat_common/adf_gen2_dc.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_gen2_dc.h
rename to drivers/crypto/intel/qat/qat_common/adf_gen2_dc.h
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.c b/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_gen2_hw_data.c
rename to drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.c
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_hw_data.h b/drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_gen2_hw_data.h
rename to drivers/crypto/intel/qat/qat_common/adf_gen2_hw_data.h
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c b/drivers/crypto/intel/qat/qat_common/adf_gen2_pfvf.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
rename to drivers/crypto/intel/qat/qat_common/adf_gen2_pfvf.c
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_pfvf.h b/drivers/crypto/intel/qat/qat_common/adf_gen2_pfvf.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_gen2_pfvf.h
rename to drivers/crypto/intel/qat/qat_common/adf_gen2_pfvf.h
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_dc.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_dc.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_gen4_dc.c
rename to drivers/crypto/intel/qat/qat_common/adf_gen4_dc.c
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_dc.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_dc.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_gen4_dc.h
rename to drivers/crypto/intel/qat/qat_common/adf_gen4_dc.h
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_hw_data.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_gen4_hw_data.c
rename to drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_hw_data.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_gen4_hw_data.h
rename to drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_pfvf.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_pfvf.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_gen4_pfvf.c
rename to drivers/crypto/intel/qat/qat_common/adf_gen4_pfvf.c
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_pfvf.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_pfvf.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_gen4_pfvf.h
rename to drivers/crypto/intel/qat/qat_common/adf_gen4_pfvf.h
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_pm.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_gen4_pm.c
rename to drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_pm.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_gen4_pm.h
rename to drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h
diff --git a/drivers/crypto/qat/qat_common/adf_hw_arbiter.c b/drivers/crypto/intel/qat/qat_common/adf_hw_arbiter.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_hw_arbiter.c
rename to drivers/crypto/intel/qat/qat_common/adf_hw_arbiter.c
diff --git a/drivers/crypto/qat/qat_common/adf_init.c b/drivers/crypto/intel/qat/qat_common/adf_init.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_init.c
rename to drivers/crypto/intel/qat/qat_common/adf_init.c
diff --git a/drivers/crypto/qat/qat_common/adf_isr.c b/drivers/crypto/intel/qat/qat_common/adf_isr.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_isr.c
rename to drivers/crypto/intel/qat/qat_common/adf_isr.c
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_msg.h b/drivers/crypto/intel/qat/qat_common/adf_pfvf_msg.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_pfvf_msg.h
rename to drivers/crypto/intel/qat/qat_common/adf_pfvf_msg.h
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.c b/drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_msg.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.c
rename to drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_msg.c
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.h b/drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_msg.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.h
rename to drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_msg.h
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c b/drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_proto.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
rename to drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_proto.c
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.h b/drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_proto.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.h
rename to drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_proto.h
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_utils.c b/drivers/crypto/intel/qat/qat_common/adf_pfvf_utils.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_pfvf_utils.c
rename to drivers/crypto/intel/qat/qat_common/adf_pfvf_utils.c
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_utils.h b/drivers/crypto/intel/qat/qat_common/adf_pfvf_utils.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_pfvf_utils.h
rename to drivers/crypto/intel/qat/qat_common/adf_pfvf_utils.h
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c b/drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_msg.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c
rename to drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_msg.c
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.h b/drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_msg.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.h
rename to drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_msg.h
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c b/drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_proto.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
rename to drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_proto.c
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.h b/drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_proto.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.h
rename to drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_proto.h
diff --git a/drivers/crypto/qat/qat_common/adf_sriov.c b/drivers/crypto/intel/qat/qat_common/adf_sriov.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_sriov.c
rename to drivers/crypto/intel/qat/qat_common/adf_sriov.c
diff --git a/drivers/crypto/qat/qat_common/adf_sysfs.c b/drivers/crypto/intel/qat/qat_common/adf_sysfs.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_sysfs.c
rename to drivers/crypto/intel/qat/qat_common/adf_sysfs.c
diff --git a/drivers/crypto/qat/qat_common/adf_transport.c b/drivers/crypto/intel/qat/qat_common/adf_transport.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_transport.c
rename to drivers/crypto/intel/qat/qat_common/adf_transport.c
diff --git a/drivers/crypto/qat/qat_common/adf_transport.h b/drivers/crypto/intel/qat/qat_common/adf_transport.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_transport.h
rename to drivers/crypto/intel/qat/qat_common/adf_transport.h
diff --git a/drivers/crypto/qat/qat_common/adf_transport_access_macros.h b/drivers/crypto/intel/qat/qat_common/adf_transport_access_macros.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_transport_access_macros.h
rename to drivers/crypto/intel/qat/qat_common/adf_transport_access_macros.h
diff --git a/drivers/crypto/qat/qat_common/adf_transport_debug.c b/drivers/crypto/intel/qat/qat_common/adf_transport_debug.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_transport_debug.c
rename to drivers/crypto/intel/qat/qat_common/adf_transport_debug.c
diff --git a/drivers/crypto/qat/qat_common/adf_transport_internal.h b/drivers/crypto/intel/qat/qat_common/adf_transport_internal.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_transport_internal.h
rename to drivers/crypto/intel/qat/qat_common/adf_transport_internal.h
diff --git a/drivers/crypto/qat/qat_common/adf_vf_isr.c b/drivers/crypto/intel/qat/qat_common/adf_vf_isr.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/adf_vf_isr.c
rename to drivers/crypto/intel/qat/qat_common/adf_vf_isr.c
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/icp_qat_fw.h
rename to drivers/crypto/intel/qat/qat_common/icp_qat_fw.h
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw_comp.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_comp.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/icp_qat_fw_comp.h
rename to drivers/crypto/intel/qat/qat_common/icp_qat_fw_comp.h
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw_init_admin.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/icp_qat_fw_init_admin.h
rename to drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw_la.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_la.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/icp_qat_fw_la.h
rename to drivers/crypto/intel/qat/qat_common/icp_qat_fw_la.h
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw_loader_handle.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_loader_handle.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/icp_qat_fw_loader_handle.h
rename to drivers/crypto/intel/qat/qat_common/icp_qat_fw_loader_handle.h
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw_pke.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_pke.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/icp_qat_fw_pke.h
rename to drivers/crypto/intel/qat/qat_common/icp_qat_fw_pke.h
diff --git a/drivers/crypto/qat/qat_common/icp_qat_hal.h b/drivers/crypto/intel/qat/qat_common/icp_qat_hal.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/icp_qat_hal.h
rename to drivers/crypto/intel/qat/qat_common/icp_qat_hal.h
diff --git a/drivers/crypto/qat/qat_common/icp_qat_hw.h b/drivers/crypto/intel/qat/qat_common/icp_qat_hw.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/icp_qat_hw.h
rename to drivers/crypto/intel/qat/qat_common/icp_qat_hw.h
diff --git a/drivers/crypto/qat/qat_common/icp_qat_hw_20_comp.h b/drivers/crypto/intel/qat/qat_common/icp_qat_hw_20_comp.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/icp_qat_hw_20_comp.h
rename to drivers/crypto/intel/qat/qat_common/icp_qat_hw_20_comp.h
diff --git a/drivers/crypto/qat/qat_common/icp_qat_hw_20_comp_defs.h b/drivers/crypto/intel/qat/qat_common/icp_qat_hw_20_comp_defs.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/icp_qat_hw_20_comp_defs.h
rename to drivers/crypto/intel/qat/qat_common/icp_qat_hw_20_comp_defs.h
diff --git a/drivers/crypto/qat/qat_common/icp_qat_uclo.h b/drivers/crypto/intel/qat/qat_common/icp_qat_uclo.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/icp_qat_uclo.h
rename to drivers/crypto/intel/qat/qat_common/icp_qat_uclo.h
diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/intel/qat/qat_common/qat_algs.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/qat_algs.c
rename to drivers/crypto/intel/qat/qat_common/qat_algs.c
diff --git a/drivers/crypto/qat/qat_common/qat_algs_send.c b/drivers/crypto/intel/qat/qat_common/qat_algs_send.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/qat_algs_send.c
rename to drivers/crypto/intel/qat/qat_common/qat_algs_send.c
diff --git a/drivers/crypto/qat/qat_common/qat_algs_send.h b/drivers/crypto/intel/qat/qat_common/qat_algs_send.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/qat_algs_send.h
rename to drivers/crypto/intel/qat/qat_common/qat_algs_send.h
diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/intel/qat/qat_common/qat_asym_algs.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/qat_asym_algs.c
rename to drivers/crypto/intel/qat/qat_common/qat_asym_algs.c
diff --git a/drivers/crypto/qat/qat_common/qat_bl.c b/drivers/crypto/intel/qat/qat_common/qat_bl.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/qat_bl.c
rename to drivers/crypto/intel/qat/qat_common/qat_bl.c
diff --git a/drivers/crypto/qat/qat_common/qat_bl.h b/drivers/crypto/intel/qat/qat_common/qat_bl.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/qat_bl.h
rename to drivers/crypto/intel/qat/qat_common/qat_bl.h
diff --git a/drivers/crypto/qat/qat_common/qat_comp_algs.c b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/qat_comp_algs.c
rename to drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
diff --git a/drivers/crypto/qat/qat_common/qat_comp_req.h b/drivers/crypto/intel/qat/qat_common/qat_comp_req.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/qat_comp_req.h
rename to drivers/crypto/intel/qat/qat_common/qat_comp_req.h
diff --git a/drivers/crypto/qat/qat_common/qat_compression.c b/drivers/crypto/intel/qat/qat_common/qat_compression.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/qat_compression.c
rename to drivers/crypto/intel/qat/qat_common/qat_compression.c
diff --git a/drivers/crypto/qat/qat_common/qat_compression.h b/drivers/crypto/intel/qat/qat_common/qat_compression.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/qat_compression.h
rename to drivers/crypto/intel/qat/qat_common/qat_compression.h
diff --git a/drivers/crypto/qat/qat_common/qat_crypto.c b/drivers/crypto/intel/qat/qat_common/qat_crypto.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/qat_crypto.c
rename to drivers/crypto/intel/qat/qat_common/qat_crypto.c
diff --git a/drivers/crypto/qat/qat_common/qat_crypto.h b/drivers/crypto/intel/qat/qat_common/qat_crypto.h
similarity index 100%
rename from drivers/crypto/qat/qat_common/qat_crypto.h
rename to drivers/crypto/intel/qat/qat_common/qat_crypto.h
diff --git a/drivers/crypto/qat/qat_common/qat_hal.c b/drivers/crypto/intel/qat/qat_common/qat_hal.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/qat_hal.c
rename to drivers/crypto/intel/qat/qat_common/qat_hal.c
diff --git a/drivers/crypto/qat/qat_common/qat_uclo.c b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
similarity index 100%
rename from drivers/crypto/qat/qat_common/qat_uclo.c
rename to drivers/crypto/intel/qat/qat_common/qat_uclo.c
diff --git a/drivers/crypto/qat/qat_dh895xcc/Makefile b/drivers/crypto/intel/qat/qat_dh895xcc/Makefile
similarity index 100%
rename from drivers/crypto/qat/qat_dh895xcc/Makefile
rename to drivers/crypto/intel/qat/qat_dh895xcc/Makefile
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c b/drivers/crypto/intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
similarity index 100%
rename from drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
rename to drivers/crypto/intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h b/drivers/crypto/intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h
similarity index 100%
rename from drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h
rename to drivers/crypto/intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_drv.c b/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c
similarity index 100%
rename from drivers/crypto/qat/qat_dh895xcc/adf_drv.c
rename to drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c
diff --git a/drivers/crypto/qat/qat_dh895xccvf/Makefile b/drivers/crypto/intel/qat/qat_dh895xccvf/Makefile
similarity index 100%
rename from drivers/crypto/qat/qat_dh895xccvf/Makefile
rename to drivers/crypto/intel/qat/qat_dh895xccvf/Makefile
diff --git a/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c b/drivers/crypto/intel/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
similarity index 100%
rename from drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
rename to drivers/crypto/intel/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
diff --git a/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.h b/drivers/crypto/intel/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.h
similarity index 100%
rename from drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.h
rename to drivers/crypto/intel/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.h
diff --git a/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c b/drivers/crypto/intel/qat/qat_dh895xccvf/adf_drv.c
similarity index 100%
rename from drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
rename to drivers/crypto/intel/qat/qat_dh895xccvf/adf_drv.c
-- 
2.34.1

