Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1240D512FF2
	for <lists+dmaengine@lfdr.de>; Thu, 28 Apr 2022 11:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiD1Jty (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Apr 2022 05:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347517AbiD1Jcy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Apr 2022 05:32:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5467CDD9;
        Thu, 28 Apr 2022 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651138180; x=1682674180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7BV5PZE7OVogZ8OnZ8XL8xlxDzHseF6zynr6xKJK83U=;
  b=CXo5QWa5l1k4oNzpWYHHVdYZmM5SQ2Rwh+K9/eoBFGhEAqHjTOPmHNrE
   MtspgnbxHp7v+X2YRzXePdKr71JeWjY5zWkXYlwk8poQrM1Zif8hYa0Gv
   YWRAd0bcSEdLy/oRtYcyK53Uuy9a8PLWvC6DmTPZqPUDyjeY7VGNWr+Z0
   h5qDqG0XOFCeSzmzSZx1j5nbpcAY+KN6Jup/iNnICVtJHtBT3JVOnkzc7
   m1BCtoeidSa7sb93/4yIAoL0NAEt4PbgvIg49K5LTajaxD2rSKOcLT080
   X3qK4kEmd5P+qbryzskbXk2rBfg66GUIRvvtoeWR47pobeU80E3meGxgB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="246139709"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="246139709"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 02:29:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="618047838"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 02:29:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nk0Si-009ERe-Hp;
        Thu, 28 Apr 2022 12:29:24 +0300
Date:   Thu, 28 Apr 2022 12:29:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Allen Pais <apais@linux.microsoft.com>,
        olivier.dautricourt@orolia.com, sr@denx.de, vkoul@kernel.org,
        keescook@chromium.org, linux-hardening@vger.kernel.org,
        ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com,
        gustavo.pimentel@synopsys.com, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, wangzhou1@hisilicon.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com, afaerber@suse.de,
        mani@kernel.org, logang@deltatee.com, sanju.mehta@amd.com,
        daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, agross@kernel.org,
        bjorn.andersson@linaro.org, krzysztof.kozlowski@linaro.org,
        green.wan@sifive.com, orsonzhai@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, patrice.chotard@foss.st.com,
        linus.walleij@linaro.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
Message-ID: <YmpedDjzZXz2t6NS@smile.fi.intel.com>
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com>
 <353023ba-d506-5d45-be68-df2025074ed6@kernel.org>
 <3ee366a7-e61f-e513-aa2f-12e8d5316f3c@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ee366a7-e61f-e513-aa2f-12e8d5316f3c@embeddedor.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Apr 25, 2022 at 02:55:22PM -0500, Gustavo A. R. Silva wrote:
> On 4/25/22 10:56, Krzysztof Kozlowski wrote:
> > On 19/04/2022 23:16, Allen Pais wrote:

...

> > > Github: https://github.com/KSPP/linux/issues/94
> > 
> > 3. No external references to some issue management systems, change-ids
> > etc. Lore link could work, but it's not relevant here, I guess.
> 
> I think the link to the KSPP issue tracker should stay. If something,
> just changing 'Github:' to 'Link:'

BugLink: would be more explicit.

-- 
With Best Regards,
Andy Shevchenko


