Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BEC58C19D
	for <lists+dmaengine@lfdr.de>; Mon,  8 Aug 2022 04:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242562AbiHHC2m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 7 Aug 2022 22:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243731AbiHHC2U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 7 Aug 2022 22:28:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5A5DC4
        for <dmaengine@vger.kernel.org>; Sun,  7 Aug 2022 19:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659925649; x=1691461649;
  h=from:to:cc:subject:date:message-id;
  bh=hbJQg9TmLytqktp6Q7y+1XDE5ydMwNXnCZbPgAcHoi0=;
  b=P6kq53+rEtgC12JxvXwefsciyl4vPdBj3km7B053rE3YQTDt5riOTn3D
   ZvmUElKQywEV/AdhDqwALbwni5dY9kEEYzQbC04JK4BlLUn00M5wMfZAH
   LRv2CzEP5qCrcUqwp57GFxkWtE0YECG2Z+IehEFX3aWpYh2TxIoaIaJCC
   Df9JQFbEOG0S3R4ldB8k6DFo45o5OFeQrwBrz8dWSo+Xv6l5pATKNalGL
   +TGvhap+FIOT4WUzy1fapICxrt2gihsN88BE/NNbHao0KHtaLsK2loz7z
   5nZyD5IVIprWoU0DPBBowA1s9ys12mm8UWTqXYoUH4cKcNPrps8LTE5J8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="290494597"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="290494597"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 19:27:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="663734198"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by fmsmga008.fm.intel.com with ESMTP; 07 Aug 2022 19:27:06 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     vkoul@kernel.org, fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org
Cc:     ramesh.thomas@intel.com, tony.luck@intel.com, tony.zhu@intel.com,
        pei.p.jia@intel.com, xiaochen.shen@intel.com
Subject: [PATCH 0/2] dmaengine: idxd: Fix max batch size issues for Intel IAA
Date:   Mon,  8 Aug 2022 11:19:20 +0800
Message-Id: <20220808031922.29751-1-xiaochen.shen@intel.com>
X-Mailer: git-send-email 2.18.4
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix max batch size related issues for Intel IAA:
1. Fix max batch size default values.
2. Make max batch size attributes in sysfs invisible.

Xiaochen Shen (2):
  dmaengine: idxd: Fix max batch size for Intel IAA
  dmaengine: idxd: Make max batch size attributes in sysfs invisible for
    Intel IAA

 .../ABI/stable/sysfs-driver-dma-idxd          |  2 ++
 drivers/dma/idxd/device.c                     |  6 ++--
 drivers/dma/idxd/idxd.h                       | 32 +++++++++++++++++++
 drivers/dma/idxd/init.c                       |  4 +--
 drivers/dma/idxd/sysfs.c                      | 32 ++++++++++++++++++-
 5 files changed, 70 insertions(+), 6 deletions(-)

-- 
2.18.4

