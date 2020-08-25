Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204DF2511E9
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 08:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgHYGNH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 02:13:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53483 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHYGNG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 02:13:06 -0400
Received: from [2001:67c:670:100:1d::c0] (helo=ptx.hi.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kASCS-0004AV-Lp; Tue, 25 Aug 2020 08:12:52 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kASCO-0001dd-22; Tue, 25 Aug 2020 08:12:48 +0200
Date:   Tue, 25 Aug 2020 08:12:48 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Benjamin Bara - SKIDATA <Benjamin.Bara@skidata.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Richard Leitner - SKIDATA <Richard.Leitner@skidata.com>
Subject: Re: pcm|dmaengine|imx-sdma race condition on i.MX6
Message-ID: <20200825061247.GL13023@pengutronix.de>
References: <20200813112258.GA327172@pcleri>
 <VE1PR04MB6638EE5BDBE2C65FF50B7DB889400@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <61498763c60e488a825e8dd270732b62@skidata.com>
 <16942794-1e03-6da0-b8e5-c82332a217a5@metafoo.de>
 <20200820065221.GF19745@pengutronix.de>
 <VE1PR04MB66386A43E2BCC5B758D1A71A895B0@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB66386A43E2BCC5B758D1A71A895B0@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:55:28 up 187 days, 13:25, 139 users,  load average: 0.40, 0.16,
 0.11
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Aug 21, 2020 at 09:52:00AM +0000, Robin Gong wrote:
> On 2020/08/20 14:52 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Wed, Aug 19, 2020 at 01:08:29PM +0200, Lars-Peter Clausen wrote:
> > > > For the first option, which is potentially more performant, we have
> > > > to leave the atomic PCM context and we are not sure if we are allowed to.
> > > > For the second option, we would have to divide the dma_device
> > > > terminate_all into an atomic sync and an async one, which would
> > > > align with the dmaengine API, giving it the option to ensure termination in
> > an atomic context.
> > > > Based on my understanding, most of them are synchronous anyways, for
> > > > the currently async ones we would have to implement busy waits.
> > > > However, with this approach, we reach the WARN_ON [6] inside of an
> > > > atomic context, indicating we might not do the right thing.
> > >
> > > I don't know how feasible this is to implement in the SDMA dmaengine
> > driver.
> > > But I think what is should do is to have some flag to indicate if a
> > > terminate is in progress. If a new transfer is issued while terminate
> > > is in progress the transfer should go on a list. Once terminate
> > > finishes it should check the list and start the transfer if there are any on the
> > list.
> > 
> > The list is already there in form of the vchan helpers the driver uses.
> Seems Lars major concern is on the race condition between next descriptor
> and sdma_channel_terminate_work which free the last terminated descriptor,
> not the ability of vchan to support multi descriptors. But anyway, I think we
> should take care vchan_get_all_descriptors to free descriptors during terminate
> phase in case it's done in worker like sdma_channel_terminate_work, since that
> may free the next descriptor wrongly. That's what my patch attached in
> 0001-dmaengine-imx-sdma-add-terminated-list-for-freed-des.patch
> https://www.spinics.net/lists/arm-kernel/msg829972.html

Indeed this should solve the problem of freeing descriptors allocated
between terminate_all and a following prep_slave*.

> 
> > 
> > I think the big mistake the driver makes is to configure fields in struct
> > sdma_channel and also the hardware directly in sdma_prep_memcpy(),
> > sdma_prep_slave_sg() and sdma_prep_dma_cyclic(). All information should be
> > stored in the struct sdma_desc allocated in the prep functions and only be used
> > when it's time to fire that specific descriptor.
> Sorry Sascha, seems that's another topic and your intention is to make sure only
> software involved in sdma_prep_* and all HW moved into one function inside
> sdma_start_desc. I agree that will make code more clean but my concern is
> sdma_start_desc is protect by spin_lock which should be short as possible while
> some HW touch as context_load may cost some time. Anyway, that's another topic,
> maybe we can refine it in the future.

Yes, you are right. This is another topic.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
