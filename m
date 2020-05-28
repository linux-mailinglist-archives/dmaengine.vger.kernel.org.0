Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3001E64B2
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 16:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391351AbgE1OxH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 10:53:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:1728 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391349AbgE1OxG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 May 2020 10:53:06 -0400
IronPort-SDR: LBwS2Hp/10q4c/MqEDIgNTM9n1fCbS9PAtOg6P9J4l7YvToGZ0lnHdXBIfYjHOmfRcNf5C00V9
 SPWpXam2xI/g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 07:53:06 -0700
IronPort-SDR: XJE73Pykesx7YX0HnG+ihINBfAg2RBknVwW8TgTVC9TylLzeFvcDRBXHaw5SjxfjkTG6n5+EOB
 B/5TcXTxj6BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="310945955"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 28 May 2020 07:53:01 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jeJu3-009Rb9-H3; Thu, 28 May 2020 17:53:03 +0300
Date:   Thu, 28 May 2020 17:53:03 +0300
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
Subject: Re: [PATCH v3 08/10] dmaengine: dw: Add dummy device_caps callback
Message-ID: <20200528145303.GU1634618@smile.fi.intel.com>
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
 <20200526225022.20405-9-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526225022.20405-9-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 27, 2020 at 01:50:19AM +0300, Serge Semin wrote:
> Since some DW DMA controllers (like one installed on Baikal-T1 SoC) may
> have non-uniform DMA capabilities per device channels, let's add
> the DW DMA specific device_caps callback to expose that specifics up to
> the DMA consumer. It's a dummy function for now. We'll fill it in with
> capabilities overrides in the next commits.

I think per se it is not worth to have it separated. Squash into the next one.

-- 
With Best Regards,
Andy Shevchenko


