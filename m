Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A4215B24
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2020 17:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgGFPso (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jul 2020 11:48:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:36637 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729267AbgGFPso (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Jul 2020 11:48:44 -0400
IronPort-SDR: SsIi2+cZjC/b6+dAYnLA5D8z6TUEDEq2Mr2NFoIVbGa9AoHX/n6b0t9yCuIWLvwtQj/DHQOTY/
 dRaSNA1UEXNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="145541157"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="145541157"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 08:48:43 -0700
IronPort-SDR: mWtp9jT1oxvVNrM8s4daFQ6nnPj+gYN2ssBS7Syix2KbmUM20xaxbsrT/kOeHfi4jicS3LFxaE
 clCawcSTm4Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="323244256"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2020 08:48:42 -0700
Date:   Mon, 6 Jul 2020 08:48:42 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org,
        Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH 13/17] Documentation/driver-api: nvdimm: drop doubled word
Message-ID: <20200706154842.GC1123188@iweiny-DESK2.sc.intel.com>
References: <20200704034502.17199-1-rdunlap@infradead.org>
 <20200704034502.17199-14-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704034502.17199-14-rdunlap@infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 03, 2020 at 08:44:58PM -0700, Randy Dunlap wrote:
> Drop the doubled word "to".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>

Acked-by: Ira Weiny <ira.weiny@intel.com>

> Cc: linux-nvdimm@lists.01.org
> ---
>  Documentation/driver-api/nvdimm/nvdimm.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200701.orig/Documentation/driver-api/nvdimm/nvdimm.rst
> +++ linux-next-20200701/Documentation/driver-api/nvdimm/nvdimm.rst
> @@ -73,7 +73,7 @@ DAX:
>    process address space.
>  
>  DSM:
> -  Device Specific Method: ACPI method to to control specific
> +  Device Specific Method: ACPI method to control specific
>    device - in this case the firmware.
>  
>  DCR:
