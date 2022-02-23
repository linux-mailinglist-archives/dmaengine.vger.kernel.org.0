Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58834C145B
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 14:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240989AbiBWNkW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 08:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240976AbiBWNkV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 08:40:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938F4AC054;
        Wed, 23 Feb 2022 05:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645623593; x=1677159593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FZ0KBu+BtqC0jHUHWhLs4ra2S4pC0DzuTvWKIPDmerE=;
  b=e0a0gmGX4MG8Eh4u9XYodxU72GUXU4xDhWUJXcPh/ON4LM9mEl4FKLxi
   zRFePeBDgsB+tkMPkRtL1G+7cGyH6d0shGw8wVuwpBJ9chPlul7WKQher
   oge0ncbHdZZW6RG4ruM+Ajcah5KzSDBRhlZbPoDfN+P7cfRDwQk4g+iES
   XnNOcL2Bv3T6vMvnxa1945/81lYu3Brzt36bVNpM4inpl+2UY1fc/mbCG
   4/mkMcqpUEP/yxo2tSkEZF+22e672pXZ42Ma6DMAdWSs88OGRL9x/cQ5p
   9A9Myah0b2b+vR85w0s0+qFAFaNdEl7cxSmYSk4o3bRs/6InC8eJYAGvw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="232584674"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="232584674"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 05:39:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="491199009"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 05:39:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nMrr7-007R40-QO;
        Wed, 23 Feb 2022 15:38:57 +0200
Date:   Wed, 23 Feb 2022 15:38:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>
Subject: Re: [PATCH 5/8] dma: dw: Avoid partial transfers
Message-ID: <YhY48chuezpa5i/q@smile.fi.intel.com>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
 <20220218181226.431098-6-miquel.raynal@bootlin.com>
 <YhIcyyBp53LnMbjU@smile.fi.intel.com>
 <TYYPR01MB7086F412B035A09AED2037A9F53A9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
 <YhPDZ4yb50sMdVgV@smile.fi.intel.com>
 <TYYPR01MB7086183461B9343A2301B4E1F53C9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
 <TYYPR01MB70869A99001C96933FCCFD36F53C9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYYPR01MB70869A99001C96933FCCFD36F53C9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Feb 23, 2022 at 08:01:25AM +0000, Phil Edworthy wrote:
> > > Also, which version of the DW DMAC IP is being used in this SoC?
> > I'm still checking, but it looks to be 2.18b
> Our HW people have told me it's v2.19a

Thanks for both answers, I have commented the same patch in v2 with my
interpretation of what's going on. Let's continue there.

-- 
With Best Regards,
Andy Shevchenko


