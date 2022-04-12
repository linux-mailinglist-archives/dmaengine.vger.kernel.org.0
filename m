Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD2F4FDFB2
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 14:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242515AbiDLMLV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 08:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354699AbiDLMKU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 08:10:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F876E542;
        Tue, 12 Apr 2022 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649761939; x=1681297939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z9qRvBkKuAStE4W4+5TXrpgRMO8sNJUiwpVjTLiS+Ow=;
  b=MVLfVfyXD5CPnHF9NPXaFOK66nWS9bDMvrl+DbJjxvbKJuBpWpnYX5CG
   OyG4BojdGqLNPFMVW37D9nGHvCHYEfAoCFd+AGw+/MZEXlyd7C3xubWWj
   8E0ZaPyOvtKo47SFWvdWhJzby6n+Wn3cqeNi598IAFOfoy0RE4XecDUfV
   WehOjFRKO2SjXfTPRf8p4tBbxeQ1Mpj7OWHMSDWVrqSQv1mZF+f/XAJzb
   6aFuxgE0XV/ZNMsL8JUeoo1eHnJtw/sTOSImH3Qg/DAKRHL+TgOlULsBL
   F0QDEQDt3xe1dm0zFF2GhcwU6tCkrfz1V/Y3iWPHfLQhe9NHAP3ujeIEV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261786941"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="261786941"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:12:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="507505520"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:12:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1neENu-001Ycb-07;
        Tue, 12 Apr 2022 14:08:34 +0300
Date:   Tue, 12 Apr 2022 14:08:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA router
 support
Message-ID: <YlVdsTVpWrx+XaUH@smile.fi.intel.com>
References: <20220412102138.45975-1-miquel.raynal@bootlin.com>
 <20220412102138.45975-6-miquel.raynal@bootlin.com>
 <YlVdNpuYdgzo7Vgi@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlVdNpuYdgzo7Vgi@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Apr 12, 2022 at 02:06:31PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 12, 2022 at 12:21:34PM +0200, Miquel Raynal wrote:

...

> > +	clear_bit(BIT(map->req_idx), dmamux->used_chans);

On top of the previously asked, are you sure the use of BIT() is correct here?

-- 
With Best Regards,
Andy Shevchenko


