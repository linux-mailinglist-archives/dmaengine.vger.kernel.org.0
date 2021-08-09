Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5215C3E4ACD
	for <lists+dmaengine@lfdr.de>; Mon,  9 Aug 2021 19:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhHIR1X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Aug 2021 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhHIR1X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Aug 2021 13:27:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F292DC0613D3
        for <dmaengine@vger.kernel.org>; Mon,  9 Aug 2021 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4DDX4MJfPISPRbp4j7HoYkMuGx5m46aMi+yyP2A3MD8=;
        t=1628530023; x=1629739623; b=Ttqadvrlg/m/w2GYC8Kj2smOghJXU+RierFtDXZUKvPU88J
        gfSAgBak/HdBxDzQhOaZBX8eYs7tSpF+md8M1lRKuozZ+hGUVT0ZhNKvnT7gggNaVKy61rGj6g5k3
        Sw2wnFH6CgbFnzlwu/XJSrdk8cq/CeDtf+7C1l3bJu8cwhYa3PzpidSt3yaatlHwM/CcCx4dwzaf3
        bNsyWVCH2KzezLZLy10/EpOUOpjeFyRouXLbIg2BDFXib5wc87BPqThVBojQXJQ4gYqA0j+rOM35V
        HfXOG3ROFdc4aJXV7EXq9yTnJcmsoHaeJwVbO9ivaT2UwITv0IsMOn8g5XDCmssA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mD90d-008D6r-UQ; Mon, 09 Aug 2021 19:26:58 +0200
Message-ID: <0ef27e7c8df520ca48900140b3930af279cd2466.camel@sipsolutions.net>
Subject: Re: [PATCH] dmaengine: ioat: depends on !UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 09 Aug 2021 19:26:57 +0200
In-Reply-To: <CAPcyv4i0p-DaPA7YTid4XsUJUpq+L-c1kDNArb=0XXnFkXz-iw@mail.gmail.com>
References: <20210809112409.a3a0974874d2.I2ffe3d11ed37f735da2f39884a74c953b258b995@changeid>
         <CAPcyv4i0p-DaPA7YTid4XsUJUpq+L-c1kDNArb=0XXnFkXz-iw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 2021-08-09 at 10:24 -0700, Dan Williams wrote:
> On Mon, Aug 9, 2021 at 2:25 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> > 
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > Now that UML has PCI support, this driver must depend also on
> > !UML since it pokes at X86_64 architecture internals that don't
> > exist on ARCH=um.
> > 
> 
> Do you really need to disable compilation of the whole driver just
> because an arch level helper does not exist on UML builds? Isn't there
> already a check for enqcmds on x86_64 to make sure the CPU is
> sufficiently feature enabled?

Hmm?

The problem here is that cpuid_eax() and cpuid_ebx() don't even exist on
UML, and that's not really surprising - ARCH=um is after all compiled to
run as a userspace process, not to run on bare metal. I guess
technically we could provide (fake or even sort of real) implementations
of these, but there's very little point?

I don't see why you would ever possibly want to have this driver
compiled on ARCH=um, even if it's compiled for x86-64 "subarch", since
there will be no such device to run against?

johannes

