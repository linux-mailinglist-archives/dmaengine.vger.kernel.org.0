Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FBA1CA949
	for <lists+dmaengine@lfdr.de>; Fri,  8 May 2020 13:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgEHLMn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 May 2020 07:12:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:42358 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgEHLMm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 8 May 2020 07:12:42 -0400
IronPort-SDR: 0apcZ8snRwAlAt3zRBLYnEWgMaoPFwZmJpbZiEs/AhgU8VTJM+djXDrAb60Mjvl7ljbBwge0Yh
 lCwfz3NAt2ug==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 04:12:42 -0700
IronPort-SDR: tPHsjctFLhnpEdjqGPIIIxGggrO9E26MnEi9onjtxKSOg4ih5enAwxq/IZzB8OmVioRf/5Bojm
 +O89XXil6fuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="305411701"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 08 May 2020 04:12:39 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX0vq-005P9x-6B; Fri, 08 May 2020 14:12:42 +0300
Date:   Fri, 8 May 2020 14:12:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: dma: dw: Add max burst transaction
 length property
Message-ID: <20200508111242.GH185537@smile.fi.intel.com>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508105304.14065-3-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 08, 2020 at 01:53:00PM +0300, Serge Semin wrote:
> This array property is used to indicate the maximum burst transaction
> length supported by each DMA channel.

> +  snps,max-burst-len:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Maximum length of burst transactions supported by hardware.
> +      It's an array property with one cell per channel in units of
> +      CTLx register SRC_TR_WIDTH/DST_TR_WIDTH (data-width) field.
> +    items:
> +      maxItems: 8
> +      items:

> +        enum: [4, 8, 16, 32, 64, 128, 256]

Isn't 1 allowed?

> +        default: 256

-- 
With Best Regards,
Andy Shevchenko


