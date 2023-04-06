Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED516D91FC
	for <lists+dmaengine@lfdr.de>; Thu,  6 Apr 2023 10:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjDFIvM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Apr 2023 04:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDFIvL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Apr 2023 04:51:11 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D0D5B88;
        Thu,  6 Apr 2023 01:51:08 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pkLKQ-00D1yQ-Dq; Thu, 06 Apr 2023 16:50:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 06 Apr 2023 16:50:46 +0800
Date:   Thu, 6 Apr 2023 16:50:46 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org,
        dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        clabbe@baylibre.com, daniele.alessandrelli@intel.com,
        prabhjot.khurana@intel.com, mgross@linux.intel.com,
        declan.murphy@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/3] crypto: Move Intel crypto drivers to
 drivers/crypto/intel
Message-ID: <ZC6H5pt/pvTZEjM4@gondor.apana.org.au>
References: <20230328153951.126564-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328153951.126564-1-tom.zanussi@linux.intel.com>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 28, 2023 at 10:39:48AM -0500, Tom Zanussi wrote:
> As part of the series adding the IAA crypto driver ([PATCH v2 00/15]
> crypto: Add Intel Analytics Accelerator (IAA) crypto compression
> driver) [1] to drivers/crypto, Herbert Xu suggested moving the other
> Intel drivers there too.
> 
> [1] https://lore.kernel.org/lkml/20230328153535.126223-1-tom.zanussi@linux.intel.com/T/#m6d6bff882778a3091317c5295f82373a4ad09e39
> 
> Tom Zanussi (3):
>   crypto: keembay - Move driver to drivers/crypto/intel/keembay
>   crypto: ixp4xx - Move driver to drivers/crypto/intel/ixp4xx
>   crypto: qat - Move driver to drivers/crypto/intel/qat
> 
>  MAINTAINERS                                   | 32 +++++++++----------
>  drivers/crypto/Kconfig                        | 17 ----------
>  drivers/crypto/Makefile                       |  3 --
>  drivers/crypto/intel/Kconfig                  |  3 ++
>  drivers/crypto/intel/Makefile                 |  3 ++
>  drivers/crypto/intel/ixp4xx/Kconfig           | 14 ++++++++
>  drivers/crypto/intel/ixp4xx/Makefile          |  2 ++
>  .../crypto/{ => intel/ixp4xx}/ixp4xx_crypto.c |  0
>  drivers/crypto/{ => intel}/keembay/Kconfig    |  0
>  drivers/crypto/{ => intel}/keembay/Makefile   |  0
>  .../keembay/keembay-ocs-aes-core.c            |  0
>  .../{ => intel}/keembay/keembay-ocs-ecc.c     |  0
>  .../keembay/keembay-ocs-hcu-core.c            |  0
>  drivers/crypto/{ => intel}/keembay/ocs-aes.c  |  0
>  drivers/crypto/{ => intel}/keembay/ocs-aes.h  |  0
>  drivers/crypto/{ => intel}/keembay/ocs-hcu.c  |  0
>  drivers/crypto/{ => intel}/keembay/ocs-hcu.h  |  0
>  drivers/crypto/{ => intel}/qat/Kconfig        |  0
>  drivers/crypto/{ => intel}/qat/Makefile       |  0
>  .../crypto/{ => intel}/qat/qat_4xxx/Makefile  |  0
>  .../qat/qat_4xxx/adf_4xxx_hw_data.c           |  0
>  .../qat/qat_4xxx/adf_4xxx_hw_data.h           |  0
>  .../crypto/{ => intel}/qat/qat_4xxx/adf_drv.c |  0
>  .../crypto/{ => intel}/qat/qat_c3xxx/Makefile |  0
>  .../qat/qat_c3xxx/adf_c3xxx_hw_data.c         |  0
>  .../qat/qat_c3xxx/adf_c3xxx_hw_data.h         |  0
>  .../{ => intel}/qat/qat_c3xxx/adf_drv.c       |  0
>  .../{ => intel}/qat/qat_c3xxxvf/Makefile      |  0
>  .../qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c     |  0
>  .../qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.h     |  0
>  .../{ => intel}/qat/qat_c3xxxvf/adf_drv.c     |  0
>  .../crypto/{ => intel}/qat/qat_c62x/Makefile  |  0
>  .../qat/qat_c62x/adf_c62x_hw_data.c           |  0
>  .../qat/qat_c62x/adf_c62x_hw_data.h           |  0
>  .../crypto/{ => intel}/qat/qat_c62x/adf_drv.c |  0
>  .../{ => intel}/qat/qat_c62xvf/Makefile       |  0
>  .../qat/qat_c62xvf/adf_c62xvf_hw_data.c       |  0
>  .../qat/qat_c62xvf/adf_c62xvf_hw_data.h       |  0
>  .../{ => intel}/qat/qat_c62xvf/adf_drv.c      |  0
>  .../{ => intel}/qat/qat_common/Makefile       |  0
>  .../qat/qat_common/adf_accel_devices.h        |  0
>  .../qat/qat_common/adf_accel_engine.c         |  0
>  .../{ => intel}/qat/qat_common/adf_admin.c    |  0
>  .../{ => intel}/qat/qat_common/adf_aer.c      |  0
>  .../{ => intel}/qat/qat_common/adf_cfg.c      |  0
>  .../{ => intel}/qat/qat_common/adf_cfg.h      |  0
>  .../qat/qat_common/adf_cfg_common.h           |  0
>  .../qat/qat_common/adf_cfg_strings.h          |  0
>  .../{ => intel}/qat/qat_common/adf_cfg_user.h |  0
>  .../qat/qat_common/adf_common_drv.h           |  0
>  .../{ => intel}/qat/qat_common/adf_ctl_drv.c  |  0
>  .../{ => intel}/qat/qat_common/adf_dev_mgr.c  |  0
>  .../qat/qat_common/adf_gen2_config.c          |  0
>  .../qat/qat_common/adf_gen2_config.h          |  0
>  .../{ => intel}/qat/qat_common/adf_gen2_dc.c  |  0
>  .../{ => intel}/qat/qat_common/adf_gen2_dc.h  |  0
>  .../qat/qat_common/adf_gen2_hw_data.c         |  0
>  .../qat/qat_common/adf_gen2_hw_data.h         |  0
>  .../qat/qat_common/adf_gen2_pfvf.c            |  0
>  .../qat/qat_common/adf_gen2_pfvf.h            |  0
>  .../{ => intel}/qat/qat_common/adf_gen4_dc.c  |  0
>  .../{ => intel}/qat/qat_common/adf_gen4_dc.h  |  0
>  .../qat/qat_common/adf_gen4_hw_data.c         |  0
>  .../qat/qat_common/adf_gen4_hw_data.h         |  0
>  .../qat/qat_common/adf_gen4_pfvf.c            |  0
>  .../qat/qat_common/adf_gen4_pfvf.h            |  0
>  .../{ => intel}/qat/qat_common/adf_gen4_pm.c  |  0
>  .../{ => intel}/qat/qat_common/adf_gen4_pm.h  |  0
>  .../qat/qat_common/adf_hw_arbiter.c           |  0
>  .../{ => intel}/qat/qat_common/adf_init.c     |  0
>  .../{ => intel}/qat/qat_common/adf_isr.c      |  0
>  .../{ => intel}/qat/qat_common/adf_pfvf_msg.h |  0
>  .../qat/qat_common/adf_pfvf_pf_msg.c          |  0
>  .../qat/qat_common/adf_pfvf_pf_msg.h          |  0
>  .../qat/qat_common/adf_pfvf_pf_proto.c        |  0
>  .../qat/qat_common/adf_pfvf_pf_proto.h        |  0
>  .../qat/qat_common/adf_pfvf_utils.c           |  0
>  .../qat/qat_common/adf_pfvf_utils.h           |  0
>  .../qat/qat_common/adf_pfvf_vf_msg.c          |  0
>  .../qat/qat_common/adf_pfvf_vf_msg.h          |  0
>  .../qat/qat_common/adf_pfvf_vf_proto.c        |  0
>  .../qat/qat_common/adf_pfvf_vf_proto.h        |  0
>  .../{ => intel}/qat/qat_common/adf_sriov.c    |  0
>  .../{ => intel}/qat/qat_common/adf_sysfs.c    |  0
>  .../qat/qat_common/adf_transport.c            |  0
>  .../qat/qat_common/adf_transport.h            |  0
>  .../qat_common/adf_transport_access_macros.h  |  0
>  .../qat/qat_common/adf_transport_debug.c      |  0
>  .../qat/qat_common/adf_transport_internal.h   |  0
>  .../{ => intel}/qat/qat_common/adf_vf_isr.c   |  0
>  .../{ => intel}/qat/qat_common/icp_qat_fw.h   |  0
>  .../qat/qat_common/icp_qat_fw_comp.h          |  0
>  .../qat/qat_common/icp_qat_fw_init_admin.h    |  0
>  .../qat/qat_common/icp_qat_fw_la.h            |  0
>  .../qat/qat_common/icp_qat_fw_loader_handle.h |  0
>  .../qat/qat_common/icp_qat_fw_pke.h           |  0
>  .../{ => intel}/qat/qat_common/icp_qat_hal.h  |  0
>  .../{ => intel}/qat/qat_common/icp_qat_hw.h   |  0
>  .../qat/qat_common/icp_qat_hw_20_comp.h       |  0
>  .../qat/qat_common/icp_qat_hw_20_comp_defs.h  |  0
>  .../{ => intel}/qat/qat_common/icp_qat_uclo.h |  0
>  .../{ => intel}/qat/qat_common/qat_algs.c     |  0
>  .../qat/qat_common/qat_algs_send.c            |  0
>  .../qat/qat_common/qat_algs_send.h            |  0
>  .../qat/qat_common/qat_asym_algs.c            |  0
>  .../{ => intel}/qat/qat_common/qat_bl.c       |  0
>  .../{ => intel}/qat/qat_common/qat_bl.h       |  0
>  .../qat/qat_common/qat_comp_algs.c            |  0
>  .../{ => intel}/qat/qat_common/qat_comp_req.h |  0
>  .../qat/qat_common/qat_compression.c          |  0
>  .../qat/qat_common/qat_compression.h          |  0
>  .../{ => intel}/qat/qat_common/qat_crypto.c   |  0
>  .../{ => intel}/qat/qat_common/qat_crypto.h   |  0
>  .../{ => intel}/qat/qat_common/qat_hal.c      |  0
>  .../{ => intel}/qat/qat_common/qat_uclo.c     |  0
>  .../{ => intel}/qat/qat_dh895xcc/Makefile     |  0
>  .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.c   |  0
>  .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.h   |  0
>  .../{ => intel}/qat/qat_dh895xcc/adf_drv.c    |  0
>  .../{ => intel}/qat/qat_dh895xccvf/Makefile   |  0
>  .../qat_dh895xccvf/adf_dh895xccvf_hw_data.c   |  0
>  .../qat_dh895xccvf/adf_dh895xccvf_hw_data.h   |  0
>  .../{ => intel}/qat/qat_dh895xccvf/adf_drv.c  |  0
>  123 files changed, 38 insertions(+), 36 deletions(-)
>  create mode 100644 drivers/crypto/intel/ixp4xx/Kconfig
>  create mode 100644 drivers/crypto/intel/ixp4xx/Makefile
>  rename drivers/crypto/{ => intel/ixp4xx}/ixp4xx_crypto.c (100%)
>  rename drivers/crypto/{ => intel}/keembay/Kconfig (100%)
>  rename drivers/crypto/{ => intel}/keembay/Makefile (100%)
>  rename drivers/crypto/{ => intel}/keembay/keembay-ocs-aes-core.c (100%)
>  rename drivers/crypto/{ => intel}/keembay/keembay-ocs-ecc.c (100%)
>  rename drivers/crypto/{ => intel}/keembay/keembay-ocs-hcu-core.c (100%)
>  rename drivers/crypto/{ => intel}/keembay/ocs-aes.c (100%)
>  rename drivers/crypto/{ => intel}/keembay/ocs-aes.h (100%)
>  rename drivers/crypto/{ => intel}/keembay/ocs-hcu.c (100%)
>  rename drivers/crypto/{ => intel}/keembay/ocs-hcu.h (100%)
>  rename drivers/crypto/{ => intel}/qat/Kconfig (100%)
>  rename drivers/crypto/{ => intel}/qat/Makefile (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_4xxx/Makefile (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_4xxx/adf_4xxx_hw_data.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_4xxx/adf_4xxx_hw_data.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_4xxx/adf_drv.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_c3xxx/Makefile (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_c3xxx/adf_c3xxx_hw_data.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_c3xxx/adf_c3xxx_hw_data.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_c3xxx/adf_drv.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_c3xxxvf/Makefile (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_c3xxxvf/adf_drv.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_c62x/Makefile (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_c62x/adf_c62x_hw_data.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_c62x/adf_c62x_hw_data.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_c62x/adf_drv.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_c62xvf/Makefile (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_c62xvf/adf_c62xvf_hw_data.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_c62xvf/adf_c62xvf_hw_data.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_c62xvf/adf_drv.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/Makefile (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_accel_devices.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_accel_engine.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_admin.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_aer.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_cfg.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_cfg.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_cfg_common.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_cfg_strings.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_cfg_user.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_common_drv.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_ctl_drv.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_dev_mgr.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_config.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_config.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_dc.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_dc.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_hw_data.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_hw_data.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_pfvf.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen2_pfvf.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_dc.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_dc.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_hw_data.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_hw_data.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_pfvf.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_pfvf.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_pm.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_gen4_pm.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_hw_arbiter.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_init.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_isr.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_msg.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_pf_msg.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_pf_msg.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_pf_proto.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_pf_proto.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_utils.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_utils.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_vf_msg.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_vf_msg.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_vf_proto.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_pfvf_vf_proto.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_sriov.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_sysfs.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_transport.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_transport.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_transport_access_macros.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_transport_debug.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_transport_internal.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/adf_vf_isr.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_comp.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_init_admin.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_la.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_loader_handle.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_fw_pke.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_hal.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_hw.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_hw_20_comp.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_hw_20_comp_defs.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/icp_qat_uclo.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/qat_algs.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/qat_algs_send.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/qat_algs_send.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/qat_asym_algs.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/qat_bl.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/qat_bl.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/qat_comp_algs.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/qat_comp_req.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/qat_compression.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/qat_compression.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/qat_crypto.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/qat_crypto.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/qat_hal.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_common/qat_uclo.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_dh895xcc/Makefile (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_dh895xcc/adf_drv.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_dh895xccvf/Makefile (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.h (100%)
>  rename drivers/crypto/{ => intel}/qat/qat_dh895xccvf/adf_drv.c (100%)
> 
> -- 
> 2.34.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
