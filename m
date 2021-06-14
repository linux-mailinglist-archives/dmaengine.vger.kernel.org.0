Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACFB3A6D02
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jun 2021 19:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhFNRUp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Jun 2021 13:20:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:28077 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235570AbhFNRUl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Jun 2021 13:20:41 -0400
IronPort-SDR: e3tLaqW+n7UV2DcX3t72IkdyBILIHKtf67Pn9huIUgA7O4MXF6RDSNVDCQpz31WX1vhTFjpB6r
 1WunamCPSX1w==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="186220783"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="186220783"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 10:18:39 -0700
IronPort-SDR: eldgU2b6x1lPfvjvqE6O7pb0Gq9HrffN/NHki1mbMF9y899jppwlDX4FGhXRPNWCYeSXj6OIBO
 TtZml28Fp8lw==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="403952343"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.124.219]) ([10.212.124.219])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 10:18:38 -0700
Subject: Re: [PATCH 00/18] Fix idxd sub-drivers setup
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        jgg@nvidia.com, ramesh.thomas@intel.com
References: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
Message-ID: <4212b8af-0f02-d2b9-a128-0576a2a8b4e5@intel.com>
Date:   Mon, 14 Jun 2021 10:18:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 5/21/2021 3:21 PM, Dave Jiang wrote:
> Vinod,
> Please consider this series for the 5.14 merge window. Thank you!

Hi Vinod. Gently ping on this series. Thanks!


>
> The original dsa_bus_type did not use idiomatic mechanisms for attaching
> dsa-devices to dsa-drivers. Switch to the idiomatic style. Once this
> cleanup is in place it will ease the addition of the VFIO mdev driver
> as another dsa-driver.
>
> ---
>
> Dave Jiang (18):
>        dmaengine: idxd: add driver register helper
>        dmaengine: idxd: add driver name
>        dmaengine: idxd: add 'struct idxd_dev' as wrapper for conf_dev
>        dmaengine: idxd: remove IDXD_DEV_CONF_READY
>        dmaengine: idxd: move wq_enable() to device.c
>        dmaengine: idxd: move wq_disable() to device.c
>        dmaengine: idxd: remove bus shutdown
>        dmaengine: idxd: remove iax_bus_type prototype
>        dmaengine: idxd: fix bus_probe() and bus_remove() for dsa_bus
>        dmaengine: idxd: move probe() bits for idxd 'struct device' to device.c
>        dmaengine: idxd: idxd: move remove() bits for idxd 'struct device' to device.c
>        dmanegine: idxd: open code the dsa_drv registration
>        dmaengine: idxd: add type to driver in order to allow device matching
>        dmaengine: idxd: create idxd_device sub-driver
>        dmaengine: idxd: create dmaengine driver for wq 'device'
>        dmaengine: idxd: create user driver for wq 'device'
>        dmaengine: dsa: move dsa_bus_type out of idxd driver to standalone
>        dmaengine: idxd: move dsa_drv support to compatible mode
>
>
>   drivers/dma/Kconfig       |  21 ++
>   drivers/dma/Makefile      |   2 +-
>   drivers/dma/idxd/Makefile |   8 +
>   drivers/dma/idxd/bus.c    |  92 +++++++
>   drivers/dma/idxd/cdev.c   |  65 ++++-
>   drivers/dma/idxd/compat.c | 114 ++++++++
>   drivers/dma/idxd/device.c | 207 +++++++++++++-
>   drivers/dma/idxd/dma.c    |  82 +++++-
>   drivers/dma/idxd/idxd.h   | 129 +++++++--
>   drivers/dma/idxd/init.c   | 132 ++++-----
>   drivers/dma/idxd/irq.c    |   2 +-
>   drivers/dma/idxd/sysfs.c  | 553 +++++++-------------------------------
>   12 files changed, 868 insertions(+), 539 deletions(-)
>   create mode 100644 drivers/dma/idxd/bus.c
>   create mode 100644 drivers/dma/idxd/compat.c
>
> --
>
