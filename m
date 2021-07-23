Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4F33D3C27
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jul 2021 17:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhGWO0N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Jul 2021 10:26:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:36182 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235351AbhGWO0N (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 23 Jul 2021 10:26:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="208781636"
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="208781636"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 08:06:46 -0700
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="433686816"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.100.174]) ([10.212.100.174])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 08:06:45 -0700
Subject: Re: [bug report] dmaengine: idxd: move dsa_drv support to compatible
 mode
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     dmaengine@vger.kernel.org
References: <20210723133508.GA18022@kili>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <60a20b28-bf03-9bc9-e80d-301ec7c5b4e8@intel.com>
Date:   Fri, 23 Jul 2021 08:06:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210723133508.GA18022@kili>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 7/23/2021 6:35 AM, Dan Carpenter wrote:
> Hello Dave Jiang,
>
> The patch 6e7f3ee97bbe: "dmaengine: idxd: move dsa_drv support to
> compatible mode" from Jul 15, 2021, leads to the following static
> checker warning:
>
> 	drivers/dma/idxd/compat.c:66 bind_store()
> 	error: uninitialized symbol 'alt_drv'.


Thanks Dan! This patch should make static checker happy:

https://lore.kernel.org/dmaengine/162689250332.2114335.636367120454420852.stgit@djiang5-desk3.ch.intel.com/T/#u


>
> drivers/dma/idxd/compat.c
>      33  static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t count)
>      34  {
>      35          struct bus_type *bus = drv->bus;
>      36          struct device *dev;
>      37          struct device_driver *alt_drv;
>      38          int rc = -ENODEV;
>      39          struct idxd_dev *idxd_dev;
>      40
>      41          dev = bus_find_device_by_name(bus, NULL, buf);
>      42          if (!dev || dev->driver || drv != &dsa_drv.drv)
>      43                  return -ENODEV;
>      44
>      45          idxd_dev = confdev_to_idxd_dev(dev);
>      46          if (is_idxd_dev(idxd_dev)) {
>      47                  alt_drv = driver_find("idxd", bus);
>      48                  if (!alt_drv)
>      49                          return -ENODEV;
>      50          } else if (is_idxd_wq_dev(idxd_dev)) {
>                             ^^^^^^^^^^^^^^^^^^^^^^^^
> Presumably this condition is always true but the static checker is not
> smart enough to figure it out.
>
>      51                  struct idxd_wq *wq = confdev_to_wq(dev);
>      52
>      53                  if (is_idxd_wq_kernel(wq)) {
>      54                          alt_drv = driver_find("dmaengine", bus);
>      55                          if (!alt_drv)
>      56                                  return -ENODEV;
>      57                  } else if (is_idxd_wq_user(wq)) {
>      58                          alt_drv = driver_find("user", bus);
>      59                          if (!alt_drv)
>      60                                  return -ENODEV;
>      61                  } else {
>      62                          return -ENODEV;
>      63                  }
>      64          }
>      65
>      66          rc = device_driver_attach(alt_drv, dev);
>      67          if (rc < 0)
>      68                  return rc;
>      69
>      70          return count;
>      71  }
>
> regards,
> dan carpenter
