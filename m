Return-Path: <dmaengine+bounces-2994-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E189634EF
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 00:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FDF1C244FF
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 22:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B850D167D97;
	Wed, 28 Aug 2024 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3pmzRoL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A91158546;
	Wed, 28 Aug 2024 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884904; cv=none; b=LZKqR2LnuzHT9vbq9z4oJVUWH/tPOdr8MkxNfL3Flm0LaBR0Z3qcj63rx23N++rbUnq7W0bxvORaNmMH5FcVcdh0CZF/9id9hvFqFLf1P//MS1DweHELbu1ncIey8U4ZpxB5xu7t45IY9oPchc2lt+EkMfEMdgKQ9dPuZgUwSGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884904; c=relaxed/simple;
	bh=WGZRCKqA6QDzucsideihhPiW6S9aKDcQEF/N9eCqBw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CFPC78ydGN1o2NHksCRBtO41B85iyE9TUNVXIiVpdYbrJSQNCsUNTSU7R0SKPPqwj0XfNJxziq/fkffAkGbxkZkf7n3UPOJackmYT3GpfEYCMdbUwqXc5taY61w2xd0PVB4QOkHud0UC+KJHy9BYdnZdLrfA3o8rFAKJyPdJYxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3pmzRoL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884903; x=1756420903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WGZRCKqA6QDzucsideihhPiW6S9aKDcQEF/N9eCqBw4=;
  b=K3pmzRoL9qtO6M90UUljrdmMFNfwyjJvct11msIEt/mK7+53oByA6lpu
   9snfzM2rgWOLkujBsgIJNCutPef9y6yVkG9w2zhDDyWe6LP2tQdarETsn
   lp8dgtoAFbtWfA3Z3+Q+5aitFRn2oyWIrXUHZTzVg3xSM/HPzkBEEPwZu
   01a4T5CQo6L2dpHI5XBaI+G8VPzG+d50q6QwAGfnXx9NuXo2x851BwM9W
   bhoOjiaVH4+ve8VAjRuxeliOwSouMzS1EvNbfJa76haCRBolVtJoCXt3d
   HPiN0j0AJhgbFWH2WtkX+J4lCgkeG+eM/sscUM+jTOGAtbxYZ/LZHlgRq
   w==;
X-CSE-ConnectionGUID: vusze93hTI6pr4xH8BhEEw==
X-CSE-MsgGUID: TgCI5jKtRdSHdcmUMZZCkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="26348976"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="26348976"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:41:42 -0700
X-CSE-ConnectionGUID: ZX1merGhQziw9g7jgdBHrQ==
X-CSE-MsgGUID: q83OV5uyTU2hICBiTh3PBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="67520115"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmviesa003.fm.intel.com with ESMTP; 28 Aug 2024 15:41:42 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 0/2] Add a few new DSA/IAX device IDs
Date: Wed, 28 Aug 2024 15:42:02 -0700
Message-Id: <20240828224204.151761-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to a potential security issue, it's not safe to assign legacy
DSA/IAA devices to virtual machines. This issue has been addressed
by adding the legacy DSA/IAA device IDs to the VFIO denylist[1].

With the security issue fixed in newer DSA/IAA devices, which have
new device IDs, these devices can be safely assigned to virtual
machines without needing to add their IDs to the VFIOI denylist.
Additionally, the new device IDs may be useful to identify any other
potential issues with specific device as well in the future.

[1] commit 95feb3160eef ("VFIO: Add the SPR_DSA and SPR_IAX devices to
    the denylist")

Fenghua Yu (2):
  dmaengine: idxd: Add a new DSA device ID on Granite Rapids-D platform
  dmaengine: idxd: Add new DSA and IAA device IDs on Diamond Rapids
    platform

 drivers/dma/idxd/init.c | 6 ++++++
 include/linux/pci_ids.h | 3 +++
 2 files changed, 9 insertions(+)

-- 
2.37.1


