Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3284F95EC
	for <lists+dmaengine@lfdr.de>; Fri,  8 Apr 2022 14:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiDHMlA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Apr 2022 08:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiDHMk7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Apr 2022 08:40:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ACB3988B0;
        Fri,  8 Apr 2022 05:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649421536; x=1680957536;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UEhLx6Z09VkdWZ9A3LzArn5J3Xl0aoeo2P5IDtSDfrI=;
  b=IpT18h/4e1dg7fSjaE3G1QGtjFNaM1f354fqmJNVowRF5I8sVa29M9Nv
   qJXnmo+MkoQKhD7/7ElPNlUkk/uRw6H8K8+xGcnGQQJaYj05l3aaeGVFY
   59aZtUMaqwnm9RVuw8DdTI3lkosYJ1ZIecEtJ15rlgl6/drWAUQxaSE5L
   rYcPXncs53F0scBmIYy1CmwZ6Ld/F+dpwskciUiaF60pwIVM7PaxPqIoq
   PZxgi6Qr5wLRKOMS/OkmerDITHfbKFe6Fj0JMY8TaOu5zKgZWZ1OmEOJE
   TlvFLYDJtBzLDwnKksFRMp2dV23CpbGvEKSqasWEVf4UczsZfFj8j3ZTV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261759340"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261759340"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:38:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="571477040"
Received: from aecajiao-mobl.amr.corp.intel.com ([10.252.48.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:38:50 -0700
Date:   Fri, 8 Apr 2022 15:38:48 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Magnus Damm <magnus.damm@gmail.com>,
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
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA router
 support
In-Reply-To: <YlAgbh2AFevBktxd@smile.fi.intel.com>
Message-ID: <8d10c313-ecfe-4460-4040-8886aa421ef@linux.intel.com>
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com> <20220406161856.1669069-6-miquel.raynal@bootlin.com> <6fbeebe2-9693-f91-78bd-451480f7a6dd@linux.intel.com> <YlAgbh2AFevBktxd@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-898612093-1649421535=:1643"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-898612093-1649421535=:1643
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 8 Apr 2022, Andy Shevchenko wrote:

> On Fri, Apr 08, 2022 at 12:55:47PM +0300, Ilpo Järvinen wrote:
> > On Wed, 6 Apr 2022, Miquel Raynal wrote:
> > 
> > > The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
> > > dmamux register located in the system control area which can take up to
> > > 32 requests (16 per DMA controller). Each DMA channel can be wired to
> > > two different peripherals.
> > > 
> > > We need two additional information from the 'dmas' property: the channel
> > > (bit in the dmamux register) that must be accessed and the value of the
> > > mux for this channel.
> 
> > > +	mask = BIT(map->req_idx);
> > > +	mutex_lock(&dmamux->lock);
> > > +	dmamux->used_chans |= mask;
> > > +	ret = r9a06g032_sysctrl_set_dmamux(mask, val ? mask : 0);
> > > +	if (ret)
> > > +		goto release_chan_and_unlock;
> > > +
> > > +	mutex_unlock(&dmamux->lock);
> > > +
> > > +	return map;
> > > +
> > > +release_chan_and_unlock:
> > > +	dmamux->used_chans &= ~mask;
> > 
> > Now that I check this again, I'm not sure why dmamux->used_chans |= mask; 
> > couldn't be done after r9a06g032_sysctrl_set_dmamux() call so this 
> > rollback of it wouldn't be necessary.
> 
> I would still need the mutex unlock which I believe is down path there under
> some other label. Hence you are proposing something like
> 
> 	mask = BIT(map->req_idx);
> 
> 	mutex_lock(&dmamux->lock);
> 	ret = r9a06g032_sysctrl_set_dmamux(mask, val ? mask : 0);
> 	if (ret)
> 		goto err_unlock; // or whatever label is
> 
> 	dmamux->used_chans |= mask;
> 	mutex_unlock(&dmamux->lock);
> 
> 	return map;
> 
> Is that correct? If so, I don't see impediments either.

Yes, and yes, the mutex still has to be unlocked on that error path.

> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-898612093-1649421535=:1643--
