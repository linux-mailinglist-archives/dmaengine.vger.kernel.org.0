Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B9E2336CA
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jul 2020 18:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgG3Qba (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jul 2020 12:31:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:8505 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG3Qba (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 30 Jul 2020 12:31:30 -0400
IronPort-SDR: Hijr8CJSQFd2X/rFZJl2QSMVE2RelpVBnxa4/e7z+WN7KZQbKdc6rK+XNTKN1E9HPD4lDzHXH4
 R0APq1lsW0OA==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="151608154"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="151608154"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 09:31:26 -0700
IronPort-SDR: 7+0IDPbkCdwdt2NUHP7Dt1PrtAyG4ggT0gl3MlFt2PJuMPLAvzdGXW93bPkb8S1aaJ3ysDXkq+
 S182+oIGEDCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="491185453"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jul 2020 09:31:23 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k1BSk-004zJk-KR; Thu, 30 Jul 2020 19:31:22 +0300
Date:   Thu, 30 Jul 2020 19:31:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] dmaengine: dw: Ignore burst setting for memory
 peripherals
Message-ID: <20200730163122.GW3703480@smile.fi.intel.com>
References: <20200730154545.3965-1-Sergey.Semin@baikalelectronics.ru>
 <20200730154545.3965-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730154545.3965-5-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 30, 2020 at 06:45:44PM +0300, Serge Semin wrote:
> According to the DW DMA controller Databook (page 40 "3.5 Memory

Which version of it?

> Peripherals") memory peripherals don't have handshaking interface
> connected to the controller, therefore they can never be a flow
> controller. Since the CTLx.SRC_MSIZE and CTLx.DEST_MSIZE are
> properties valid only for peripherals with a handshaking
> interface, we can freely zero these fields out if the memory peripheral
> is selected to be the source or the destination of the DMA transfers.
> 
> Note according to the databook, length of burst transfers to memory is
> always equal to the number of data items available in a channel FIFO or
> data items required to complete the block transfer, whichever is smaller;
> length of burst transfers from memory is always equal to the space
> available in a channel FIFO or number of data items required to complete
> the block transfer, whichever is smaller.

But does it really matter if you program there something or not?

-- 
With Best Regards,
Andy Shevchenko


