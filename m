Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C094D6083
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 12:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244398AbiCKLZj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 06:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiCKLZi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 06:25:38 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47241FD30;
        Fri, 11 Mar 2022 03:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646997875; x=1678533875;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4IxSc8nxzrzYVWby6Rd3lcpQrBHcSusdZ087o0jkhZY=;
  b=Jbut78rE5m0gCwhRiXyaC7x1HXuCo+Sncog7YZW3otdYlp08YgY8b7ww
   GNlCTGgUuSYzV4tn38Ro1tyJk417BOZKJ96YXSpL07/txhw3abHeEjKTu
   N6E8MJst0GfZ5IAfezewSYsGMXKbv3OA/9Y8ObAS9LbJB/GOhIQFYKCqM
   +awccRQZMC70G5HJfFRJYOoxbtz6dcoDsJELwwemFzyqOdUgYc0Ppakpo
   iJXiYL3+Su6zhUuq5fI2+CG5qHMmOafwbF2922O3BHuVhtApH0KSRWNJs
   eA76+nznYZ6QH3GEDquJkQAfQw73LN/IBb8le0U4G8hJp1UmqxBzsRWg4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="235505525"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="235505525"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 03:24:34 -0800
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="555269429"
Received: from gwas-mobl.ger.corp.intel.com ([10.252.32.181])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 03:24:29 -0800
Date:   Fri, 11 Mar 2022 13:24:23 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>
Subject: Re: [PATCH v4 7/9] dma: dw: Avoid partial transfers
In-Reply-To: <20220310194640.4bc6e604@xps13>
Message-ID: <e53b98a5-fa32-97a4-7bf4-d46124c5ed@linux.intel.com>
References: <20220310155755.287294-1-miquel.raynal@bootlin.com> <20220310155755.287294-8-miquel.raynal@bootlin.com> <Yio6UWYIDZWXx2Ux@smile.fi.intel.com> <20220310194640.4bc6e604@xps13>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1099617945-1646997874=:1606"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1099617945-1646997874=:1606
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 10 Mar 2022, Miquel Raynal wrote:

> Hi Andy,
> 
> andriy.shevchenko@linux.intel.com wrote on Thu, 10 Mar 2022 19:50:09
> +0200:
> 
> > +Cc: Ilpo who is currently doing adjoining stuff.

Thanks for the head up. I was only aware of the ones on linux-serial.

> > Ilpo, this one affects Intel Bay Trail and Cherry Trail platforms.
> > Not sure if it's in scope of your interest right now, but it might
> > be useful to see how DMA <--> 8250 UART functioning.
> > 
> > On Thu, Mar 10, 2022 at 04:57:53PM +0100, Miquel Raynal wrote:
> > > As investigated by Phil Edworthy <phil.edworthy@renesas.com> on RZN1 a  
> > 
> > Email can be dropped as you put it below, just (full) name is enough.
> 
> Sure.
> 
> > I'm wondering if Phil or anybody else who possess the hardware can
> > test / tested this.
> 
> I have a board with an RZN1 SoC but I don't have exactly the same setup
> as Phil (I only have one port with DMA working, while he used two as a
> loopback device). I tried to reproduce the error with no luck so far. I
> however verified that there was apparently no performance hit
> whatsoever due to this change. IIRC Phil does not have the hardware
> anymore.
> 
> > > while ago,

> > > pausing a partial transfer only causes data to be written to
> > > memory that is a multiple of the memory width setting.

This should be rephrased. As is it doesn't make sense.

-- 
 i.

> >>  Such a situation
> > > can happen eg. because of a char timeout interrupt on a UART. In this
> > > case, the current ->terminate_all() implementation does not always flush
> > > the remaining data as it should.
> > > 
> > > In order to workaround this, a solutions is to resume and then pause
> > > again the transfer before termination. The resume call in practice
> > > actually flushes the remaining data.  
> > 
> > Perhaps Fixes tag?
> 
> I don't know exactly what hardware can suffer from this, hence I
> decided not to add a Fixes tag given the fact that it was only observed
> on RZN1 (which was until now not yet supported upstream).
> 
> > > Reported-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/dma/dw/core.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> > > index 7ab83fe601ed..2f6183177ba5 100644
> > > --- a/drivers/dma/dw/core.c
> > > +++ b/drivers/dma/dw/core.c
> > > @@ -862,6 +862,10 @@ static int dwc_terminate_all(struct dma_chan *chan)
> > >  
> > >  	clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
> > >  
> > > +	/* Ensure the last byte(s) are drained before disabling the channel */
> > > +	if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
> > > +		dwc_chan_resume(dwc, true);
> > > +
> > >  	dwc_chan_pause(dwc, true);
> > >  
> > >  	dwc_chan_disable(dw, dwc);
> > > -- 
> > > 2.27.0
> > >   
> > 
> 
> 
> Thanks,
> Miquèl
> 

--8323329-1099617945-1646997874=:1606--
