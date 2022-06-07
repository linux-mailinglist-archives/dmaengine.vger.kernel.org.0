Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986FD5403D1
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jun 2022 18:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiFGQcz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jun 2022 12:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343920AbiFGQcy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jun 2022 12:32:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAE3237CA
        for <dmaengine@vger.kernel.org>; Tue,  7 Jun 2022 09:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654619573; x=1686155573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i81fXv7o2XdfNuapPPBTi8kvKEUsrdMQXecjKyu9Ppo=;
  b=HIg67NXDIFhiYuTFdJJgrW/WjgmC5LeZzJenrrbud7Jbe8m7nOggJxl0
   QwfupuzBMSvXnNs6FQa7QGn98WlYJKl5GSyd2+UiYbGYdnBmg3n8IMiJb
   NfHfrzbB8w6X0zsDkvTVNxTw8pdGwDHlN6xmYCxsaU/3AuGnEsXWUZ9iO
   HxFA9x0lBDPJFPt0ehL1NHINfkJ9WcTUxr24xfvAUqk0QfohW1QmEBTit
   14hsYijht+zGhMkp0wSk32Kz9qh6GhHxy/6f1kY0D0HFEb//NdWLSIrpJ
   0ad6Qisj8AJSLLv2XIwdhVBEL5pBkca/WD5YKi04FjW8w3qrklhY8y4wj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="256564794"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="256564794"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 09:32:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="682821483"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 09:32:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nyc8N-000VrU-Ld;
        Tue, 07 Jun 2022 19:32:47 +0300
Date:   Tue, 7 Jun 2022 19:32:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/2] dmaengine: dw: dmamux: Fix build without CONFIG_OF
Message-ID: <Yp99r87N7uyQYvwz@smile.fi.intel.com>
References: <20220607152215.46731-1-miquel.raynal@bootlin.com>
 <20220607152215.46731-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607152215.46731-2-miquel.raynal@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jun 07, 2022 at 05:22:15PM +0200, Miquel Raynal wrote:
> When built without OF support, of_match_node() expands to NULL, which
> produces the following output:
> >> drivers/dma/dw/rzn1-dmamux.c:105:34: warning: unused variable 'rzn1_dmac_match' [-Wunused-const-variable]
>    static const struct of_device_id rzn1_dmac_match[] = {
> 
> One way to silence the warning is to enclose the structure definition
> with an #ifdef CONFIG_OF/#endif block.
> 
> In order to keep the harmony in the driver, the second match table is
> also enclosed with the same #ifdef CONFIG_OF/#endif block and the use of
> the match table forwarded by the of_match_ptr() macro.

No, what I asked is the opposite.
So, the most of this patch seems not needed (see below).

...

> +#ifdef CONFIG_OF
>  static const struct of_device_id rzn1_dmamux_match[] = {
>  	{ .compatible = "renesas,rzn1-dmamux" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, rzn1_dmamux_match);
> +#endif
>  
>  static struct platform_driver rzn1_dmamux_driver = {
>  	.driver = {
>  		.name = "renesas,rzn1-dmamux",
> -		.of_match_table = rzn1_dmamux_match,
> +		.of_match_table = of_match_ptr(rzn1_dmamux_match),
>  	},
>  	.probe	= rzn1_dmamux_probe,
>  };

-- 
With Best Regards,
Andy Shevchenko


