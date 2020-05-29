Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83B41E7D05
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 14:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgE2MT0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 May 2020 08:19:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:38922 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgE2MTZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 29 May 2020 08:19:25 -0400
IronPort-SDR: zqooVUshT+kHYcSRjr6zrXmS3THhX/QAv7x7RXVK2kjn1r4HsyPAduJUo9Gm/p2MGx3H6drU6M
 XPB6EooK+h+w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 05:19:25 -0700
IronPort-SDR: UwnEsUdti8QDgr6qW+aMhCIiL6RniPh+0VYq6dTYmGAwe0sUOd22BrKmCFK9qLG4dkZ5NXD7KD
 MHKD4ZzhLjmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="302825850"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 29 May 2020 05:19:22 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jedyv-009c1y-3m; Fri, 29 May 2020 15:19:25 +0300
Date:   Fri, 29 May 2020 15:19:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/11] dmaengine: dw: Add dummy device_caps callback
Message-ID: <20200529121925.GM1634618@smile.fi.intel.com>
References: <20200528222401.26941-1-Sergey.Semin@baikalelectronics.ru>
 <20200528222401.26941-9-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528222401.26941-9-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 29, 2020 at 01:23:58AM +0300, Serge Semin wrote:
> Since some DW DMA controllers (like one installed on Baikal-T1 SoC) may
> have non-uniform DMA capabilities per device channels, let's add
> the DW DMA specific device_caps callback to expose that specifics up to
> the DMA consumer. It's a dummy function for now. We'll fill it in with
> capabilities overrides in the next commits.

This one I leave to Vinod to decide what to do.
It is not harmful per se, but I consider better if it has a user already.
Thus, no tag, sorry.

-- 
With Best Regards,
Andy Shevchenko


