Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B1C4C1449
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 14:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbiBWNh1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 08:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiBWNhZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 08:37:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCF6369E1;
        Wed, 23 Feb 2022 05:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645623417; x=1677159417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wQFkkwBVr5xmq1ehCi1EaGXRavrySghv8G52N1mmqNQ=;
  b=Uqb87PfhcjvSNZs94v/TL0IBT8z3g3k0gNzjR+w3M3DoLvAIwm4a2qzL
   OtLpkpnm8ZLODUc5xWwtHd8VOkUW02AfTCabhK1sa4cglQ4o4/xck4M8e
   eSIWmUQFuf+DLdaKrtwVXOuH9SgddH/z8363LZ+SuN7KKl0nl93lv7IyH
   jO2rHKUNAhCupdZf6UgYz+hUIGNU7nYim8mPSy79p7kPY3wgRV5faMTtc
   TRMsokMd6WVd4DcYDAkYPaZtViRnYrjRPxtEo/6V0rNtV8WRp4VMVz+oO
   SQE3OGfzUsK5I3OCm/8lSxDV4rylV/eEBtVW9eqzdZg8NwZZVIa5hVMMm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="276581810"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="276581810"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 05:36:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="637424343"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 05:36:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nMroI-007R0v-TI;
        Wed, 23 Feb 2022 15:36:02 +0200
Date:   Wed, 23 Feb 2022 15:35:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>
Subject: Re: [PATCH v2 5/8] dma: dw: Avoid partial transfers
Message-ID: <YhY4PqqOgYTLgpKr@smile.fi.intel.com>
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
 <20220222103437.194779-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222103437.194779-6-miquel.raynal@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 22, 2022 at 11:34:34AM +0100, Miquel Raynal wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Pausing a partial transfer only causes data to be written to memory that
> is a multiple of the memory width setting.
> 
> However, when a DMA client driver finishes DMA early, e.g. due to UART
> char timeout interrupt, all data read from the device must be written to
> memory.
> 
> Therefore, allow the slave to limit the memory width to ensure all data
> read from the device is written to memory when DMA is paused.

(I have only 2.17d and 2.21a datasheets, so below based on the latter)

It seems you are referring to the chapter 7.7 "Disabling a Channel Prior
to Transfer Completion" of the data sheet where it stays that it does not
guarantee to have last burst to be completed in case of
SRC_TR_WIDTH < DST_TR_WIDTH and the CH_SUSP bit is high, when the FIFO_EMPTY
is asserted.

Okay, in iDMA 32-bit we have a specific bit (seems like a fix) that drains
FIFO, but still it doesn't drain the FIFO fully (in case of misalignment)
and the last piece of data (which is less than TR width) is lost when channel
gets disabled.

Now, if we look at the implementation of the serial8250_rx_dma_flush() we
may see that it does
 1. Pause channel without draining FIFO
 2. Moves data to TTY buffer
 3. Terminates channel.

During termination it does pause channel again (with draining enabled),
followed by disabling channel and resuming it again.

According to the 7.7 the resuming channel allows to finish the transfer
normally.

It seems the logic in the ->terminate_all() is broken and we actually need
to resume channel first (possibly conditionally, if it was suspended), then
pause it and disable and resume again.

The problem with ->terminate_all() is that it has no knowledge if it has
been called on paused channel (that's why it has to pause channel itself).
The pause on termination is required due to some issues in early steppings
of iDMA 32-bit hardware implementations.

If my theory is correct, the above change should fix the issues you see.

-- 
With Best Regards,
Andy Shevchenko


