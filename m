Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9D12C3A0
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2019 11:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfE1Jzo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 May 2019 05:55:44 -0400
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:33841 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726203AbfE1Jzn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 May 2019 05:55:43 -0400
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 May 2019 05:55:43 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id AAA261803BAD8
        for <dmaengine@vger.kernel.org>; Tue, 28 May 2019 09:46:56 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2FF991803EF1F;
        Tue, 28 May 2019 09:46:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:16:41:355:379:599:800:960:966:973:988:989:1042:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1605:1711:1730:1747:1777:1792:2196:2199:2376:2393:2538:2553:2559:2562:2693:2734:2828:2904:2911:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:4385:4425:5007:6117:6119:7576:7809:7882:7903:9010:9040:9149:9367:10004:10400:10450:10455:10848:11658:11914:12043:12555:12740:12760:12895:13095:13255:13439:14181:14345:14346:14347:14659:14721:19904:19999:21067:21080:21433:21627:30012:30014:30029:30030:30054:30056:30063:30064:30067:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: mist72_7673f0578614e
X-Filterd-Recvd-Size: 4027
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 May 2019 09:46:53 +0000 (UTC)
Message-ID: <7bad367da73e07dca74941f80ed998590c6f14fb.camel@perches.com>
Subject: Re: [EXT] Re: [V3 1/2] dmaengine: fsl-dpaa2-qdma: Add the
 DPDMAI(Data Path DMA Interface) support
From:   Joe Perches <joe@perches.com>
To:     Peng Ma <peng.ma@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Date:   Tue, 28 May 2019 02:46:52 -0700
In-Reply-To: <VI1PR04MB44314E4B35FA0C7E850CD512ED1E0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190409072212.15860-1-peng.ma@nxp.com>
         <20190426124550.GE28103@vkoul-mobl>
         <VI1PR04MB44314E4B35FA0C7E850CD512ED1E0@VI1PR04MB4431.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 2019-05-28 at 04:47 +0000, Peng Ma wrote:
> -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
[]
> > > diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> > > b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> > > new file mode 100644
> > > index 0000000..c8a7b7f
> > > --- /dev/null
> > > +++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> > > @@ -0,0 +1,524 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/* Copyright 2014-2018 NXP */
> > > +
> > > +/*
> > > + * Redistribution and use in source and binary forms, with or without
> > > + * modification, are permitted provided that the following conditions are
> > met:
> > > + * * Redistributions of source code must retain the above copyright
> > > + * notice, this list of conditions and the following disclaimer.
> > > + * * Redistributions in binary form must reproduce the above
> > > +copyright
> > > + * notice, this list of conditions and the following disclaimer in
> > > +the
> > > + * documentation and/or other materials provided with the distribution.
> > > + * * Neither the name of the above-listed copyright holders nor the
> > > + * names of any contributors may be used to endorse or promote
> > > +products
> > > + * derived from this software without specific prior written permission.
> > > + *
> > > + *
> > > + * ALTERNATIVELY, this software may be distributed under the terms of
> > > +the
> > > + * GNU General Public License ("GPL") as published by the Free
> > > +Software
> > > + * Foundation, either version 2 of that License or (at your option)
> > > +any
> > > + * later version.
> > > + *
> > > + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
> > CONTRIBUTORS "AS IS"
> > > + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> > LIMITED
> > > +TO, THE
> > > + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> > PARTICULAR
> > > +PURPOSE
> > > + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR
> > > +CONTRIBUTORS BE
> > > + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
> > > +OR
> > > + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
> > PROCUREMENT
> > > +OF
> > > + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> > > +BUSINESS
> > > + * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
> > > +WHETHER IN
> > > + * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
> > > +OTHERWISE)
> > > + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
> > > +ADVISED OF THE
> > > + * POSSIBILITY OF SUCH DAMAGE.
> > > + */
> > 
> > we have SiPDX tag, why do you need ths here!
> > 
> [Peng Ma] It is my mistake. I will fixe it.

Please have your company review which licenses you are
intending to use as the SPDX tag does not match the
licenses shown in the text.


