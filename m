Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418BB53EAEE
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jun 2022 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241595AbiFFQOl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jun 2022 12:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241632AbiFFQOk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Jun 2022 12:14:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F7A158F18
        for <dmaengine@vger.kernel.org>; Mon,  6 Jun 2022 09:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654532079; x=1686068079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mlU4DcYubN2neKWfKJfc6fwTIdSa2Atdwt2l++LZqCE=;
  b=eXtUucHrsE+PvMLSrfJJo//bXYt8VPaiMfbMie60g9U3ldtRNbDrgV2f
   9SgkMLv0cAYeWz4sUEIbpvpnE63PaJ0Od+SJz3zhJccyeyhUFanWlly5/
   4F/pzqubaL4e6dETSGkEBrMws7chqbXBWQLnOmmBbp8QgBLK7aUWd/L3d
   7JoawB44RfNMsbN8wUR7pieWfJfLgaE/5VjeKr4jTUAV9+rHzMUwUeUNL
   CDKR5l3ZrrMXjPKtWZP+E18E1NpQKpaOfTeoJkmL95TuAsFRkME3yMVrU
   YRhsmqAiJVyHMiIOzsOrfpccyCLNH/KWMXBK69lxnKpU29J0QRKflNkj6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="256504305"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="256504305"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 09:14:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="583715799"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 09:14:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nyFNB-000UwX-F6;
        Mon, 06 Jun 2022 19:14:33 +0300
Date:   Mon, 6 Jun 2022 19:14:33 +0300
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
Subject: Re: [PATCH] dmaengine: dw: dmamux: Fix build without CONFIG_OF
Message-ID: <Yp4n6Xm4LwACvJcO@smile.fi.intel.com>
References: <20220606151713.33682-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606151713.33682-1-miquel.raynal@bootlin.com>
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

On Mon, Jun 06, 2022 at 05:17:13PM +0200, Miquel Raynal wrote:
> When built without OF support, the match tables are not used and may
> produce the following output:
> >> drivers/dma/dw/rzn1-dmamux.c:105:34: warning: unused variable 'rzn1_dmac_match' [-Wunused-const-variable]
>    static const struct of_device_id rzn1_dmac_match[] = {
> 
> One way to silence the warnings is to define the structures with
> __maybe_unused.

Can we simply drop CONFIG_OF / of_match_ptr() instead, please?

-- 
With Best Regards,
Andy Shevchenko


