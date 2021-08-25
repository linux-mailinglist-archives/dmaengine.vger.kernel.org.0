Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488203F75EB
	for <lists+dmaengine@lfdr.de>; Wed, 25 Aug 2021 15:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241249AbhHYNe3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Aug 2021 09:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbhHYNe2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Aug 2021 09:34:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF46C061757
        for <dmaengine@vger.kernel.org>; Wed, 25 Aug 2021 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=MYmXSlOM0SqMblcSPbHztllMvOzuKRj0PAbx8whDuaI=;
        t=1629898423; x=1631108023; b=Vh5jVCnoDjda8CIh307GHeNOjn93/edv72Uv/7Lwexu531A
        S27+ZvOeQiFfcx6JNalAl7pNO9lKZ6QXjhktKZ2A2HVIiHRxS1rXG57+cgKdfHz67n+j/aTGJBh0N
        +7o/wRdtPuSKYN7TT+XokdIEDt7cx+/OfidYFl3onWVn3GlIADxQGs6bayt+izxSiua8vuGgPGU61
        I7t3pcrek00d/tDWjgz45V00R2iu1U3Aczqza4fludnH2xTnIXqukwkX/VO9GM+C8xIk3DtFBEcLZ
        g92K/jbs/LOJGiJmyo7bB4xnaqybBysNt/zA/UPoMAZkBfS135GearFH2QB3bdIw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mIt2B-00Fji7-67; Wed, 25 Aug 2021 15:33:39 +0200
Message-ID: <4dc26051a8b03c1bc7fbac9212e71703d57457c0.camel@sipsolutions.net>
Subject: Re: [PATCH] dmaengine: ioat: depends on !UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Aug 2021 15:33:38 +0200
In-Reply-To: <CAPcyv4jYy+O9NcTr93PK_rq2xYnhx3GHyS1=k+jbvO4t7U1iiw@mail.gmail.com>
References: <20210809112409.a3a0974874d2.I2ffe3d11ed37f735da2f39884a74c953b258b995@changeid>
         <CAPcyv4i0p-DaPA7YTid4XsUJUpq+L-c1kDNArb=0XXnFkXz-iw@mail.gmail.com>
         <0ef27e7c8df520ca48900140b3930af279cd2466.camel@sipsolutions.net>
         <CAPcyv4jYy+O9NcTr93PK_rq2xYnhx3GHyS1=k+jbvO4t7U1iiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 2021-08-25 at 06:31 -0700, Dan Williams wrote:
> On Mon, Aug 9, 2021 at 10:27 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> > 
> > On Mon, 2021-08-09 at 10:24 -0700, Dan Williams wrote:
> > > On Mon, Aug 9, 2021 at 2:25 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> > > > 
> > > > From: Johannes Berg <johannes.berg@intel.com>
> > > > 
> > > > Now that UML has PCI support, this driver must depend also on
> > > > !UML since it pokes at X86_64 architecture internals that don't
> > > > exist on ARCH=um.
> > > > 
> > > 
> > > Do you really need to disable compilation of the whole driver just
> > > because an arch level helper does not exist on UML builds? Isn't there
> > > already a check for enqcmds on x86_64 to make sure the CPU is
> > > sufficiently feature enabled?
> > 
> > Hmm?
> > 
> > The problem here is that cpuid_eax() and cpuid_ebx() don't even exist on
> > UML, and that's not really surprising - ARCH=um is after all compiled to
> > run as a userspace process, not to run on bare metal. I guess
> > technically we could provide (fake or even sort of real) implementations
> > of these, but there's very little point?
> > 
> > I don't see why you would ever possibly want to have this driver
> > compiled on ARCH=um, even if it's compiled for x86-64 "subarch", since
> > there will be no such device to run against?
> 
> See CONFIG_COMPILE_TEST, i.e. even the "depends on X86_64" should be
> reconsidered if you ask me.
> 
But CONFIG_COMPILE_TEST is for stuff that can *compile*, just not *work*
independent of the platform - e.g. if I have a driver that compiles
fine, but I know there's never going to be such a PCI device on non-
Intel platforms (happens a lot, after all)

But here it's the other way around - this cannot *compile* even anywhere
other than "X86_64 && !UML", let alone *work*.

johannes


