Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81D33F760B
	for <lists+dmaengine@lfdr.de>; Wed, 25 Aug 2021 15:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbhHYNly (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Aug 2021 09:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241343AbhHYNlx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Aug 2021 09:41:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD74C0613C1
        for <dmaengine@vger.kernel.org>; Wed, 25 Aug 2021 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=GQvq2DTqPzci4LJKK5jZWJjIqb8BSvLCZHlpAc2jAyQ=;
        t=1629898868; x=1631108468; b=NoaE9WWBdqSgkQQGxkY72d2NWY2WH8q9pZedH9xeEVxGlL8
        2QldXk/WEU2W2CMYiMKH5D0swn3DiiFRPlpejwqzucsnEuL8Za5Idcgc8YULuCy31dlsw0NufWDAZ
        LTnXBanlmX6UzaxfGWMpIigNpHXUIsxVWedZaWFyEhxz1Jwgwu3FCNdv0njf3J5BhJkcNFa6zjCK7
        U028xVH4y3sawmFrd/fuFvn/cSQ68c8WTj8Oc0HbQjB3XHWA9m68pyUQuAlsBznIl+jxsl8Engi0F
        tQKuVtRhoz761sw/NwzGw5mvHPRvMfnwH8rBTZ3eLG+HcVnWohyX+rdpRZKrs4Hw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mIt9N-00FjsC-LG; Wed, 25 Aug 2021 15:41:05 +0200
Message-ID: <b6fd5d53925712f9948a2ae3fa29cc4bc3b219fc.camel@sipsolutions.net>
Subject: Re: [PATCH] dmaengine: ioat: depends on !UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Aug 2021 15:41:04 +0200
In-Reply-To: <CAPcyv4j545=-9igjXjMWU_6-1COkOOejZz9ULgOmVvK1Y+8eiQ@mail.gmail.com>
References: <20210809112409.a3a0974874d2.I2ffe3d11ed37f735da2f39884a74c953b258b995@changeid>
         <CAPcyv4i0p-DaPA7YTid4XsUJUpq+L-c1kDNArb=0XXnFkXz-iw@mail.gmail.com>
         <0ef27e7c8df520ca48900140b3930af279cd2466.camel@sipsolutions.net>
         <CAPcyv4jYy+O9NcTr93PK_rq2xYnhx3GHyS1=k+jbvO4t7U1iiw@mail.gmail.com>
         <4dc26051a8b03c1bc7fbac9212e71703d57457c0.camel@sipsolutions.net>
         <CAPcyv4j545=-9igjXjMWU_6-1COkOOejZz9ULgOmVvK1Y+8eiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 2021-08-25 at 06:36 -0700, Dan Williams wrote:
> > > > 
> > > > The problem here is that cpuid_eax() and cpuid_ebx() don't even exist on
> 
[snip]

> It can't compile because the arch dependencies are not stubbed out
> like other arch specific helpers. I think this is something to revisit
> if / when concepts similar to the "enqcmd" instruction appear on other
> archs.

I think you're confusing ioat and idxd? :)

The ioat driver (which this patch is against) uses cpuid_eax() and
cpuid_ebx() above, and really if a driver uses that then it can only
possibly run on IA :)

I'm not sure it makes sense to abstract out things such as
dca_enabled_in_bios() to a general architecture thing either?

johannes

