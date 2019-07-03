Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92A25EB5C
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jul 2019 20:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfGCSP3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jul 2019 14:15:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39243 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCSP3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Jul 2019 14:15:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so3860022wrt.6;
        Wed, 03 Jul 2019 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NVBqu5DptPqOy9+V2yP9T7VWkccxmcCRSOq9yYCdQOY=;
        b=Hda7GC6zv2u/cyq7wABC70JBSb24VuutbpKes/AeQn14Kan30rmxmYM5OrMa8hxSld
         9Bp3qu/ZAlngCgZK4G7F+djod4yfRjBbytk6BnItl28NeaPIBe+5CEL3ZwCET2TZ3wew
         fubADU2jQDOl0uN+n4FkGtJhNU7h5yI6LD031DzvbkHf8nrOneq9m0baWSDzuS8kJq36
         h0eN9uwRT9N28UwG6TxvvkbK8gwZj7LyMTtka+4C5Q4GCUHfQyjlhct87DDff5QnDMEu
         CjqCJtYnAe/UrBDKQDrAkYJ3BNtNBlA4GqaHJybTCCHR0IAIiWApRR5ROSJDPMZiTBpy
         1CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NVBqu5DptPqOy9+V2yP9T7VWkccxmcCRSOq9yYCdQOY=;
        b=gkyWImdDadsjfiQqL0ETtGxhiFXSq3ml/x57mkvTTcGMNCfr6e8uusFCu6i3oT8jEq
         tF5nX22+7biM9r5P+IIkOdGT9HXsoRcqILxVPZa2Yd1du2ifH/yIUBLiA74uoxG8W/J5
         Mw3y3mo7irnocq6vHwImEyWusmMPcvtDhMNo6lssKYjXZP9UhQBUpWoOXOV+r/WG1T2J
         SDjplQleuH2/oKS9AU/cQ6Kd7U0gAeQehXuxospwPuBGH7Cb+bSyAMgl5spVWdixzQko
         vEkFb4yZEXjoP1FTB1UM/JpV5TyqdUYNWeTCBCUGGjeznEPcUoQxfx4nVLZocDgJdUGs
         RB9g==
X-Gm-Message-State: APjAAAUFVVG6p4jBIMmdat5k8V4SL9sHNmmEkU3v5V7Av7YZcSbWtdC0
        8MvqykSeIOXVXwJl0ymjVF4=
X-Google-Smtp-Source: APXvYqxaYDgPpI4MaTVwp4VmLO4SY9ymzJptCqDH6qOUwRR9HVviybslQMG9wlofW3W7tRLhiOqsdA==
X-Received: by 2002:a5d:4908:: with SMTP id x8mr29140007wrq.290.1562177727028;
        Wed, 03 Jul 2019 11:15:27 -0700 (PDT)
Received: from x230 (ipb218f589.dynamic.kabel-deutschland.de. [178.24.245.137])
        by smtp.gmail.com with ESMTPSA id b203sm3894182wmd.41.2019.07.03.11.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 11:15:26 -0700 (PDT)
From:   Eugeniu Rosca <roscaeugeniu@gmail.com>
X-Google-Original-From: Eugeniu Rosca <erosca@de.adit-jv.com>
Date:   Wed, 3 Jul 2019 20:15:19 +0200
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        dmaengine@vger.kernel.org,
        "George G . Davis" <george_davis@mentor.com>
Subject: Re: [PATCH 0/2] serial: sh-sci: Fix .flush_buffer() issues
Message-ID: <20190703181519.ifrmycrsrohcc2gf@x230>
References: <20190624123540.20629-1-geert+renesas@glider.be>
 <20190626173434.GA24702@x230>
 <CAMuHMdWuk7CkfcUSX=706f8b6YMFio7iwZg32+uXsyOKL68fuQ@mail.gmail.com>
 <20190628123907.GA10962@vmlxhi-102.adit-jv.com>
 <20190628125534.GB1458@ninjato>
 <20190628130200.GA11231@vmlxhi-102.adit-jv.com>
 <20190703173050.GA11328@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703173050.GA11328@kroah.com>
User-Agent: NeoMutt/20180716-2148-008987
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Greg,

On Wed, Jul 03, 2019 at 07:30:50PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 28, 2019 at 03:02:00PM +0200, Eugeniu Rosca wrote:
[..]
> > I am doing this per-patch to allow patchwork to reflect the status of
> > each patch on the linux-renesas-soc front-page. AFAIK patchwork ignores
> > series-wide '*-by: Name <email>' signatures/tags.
> 
> I don't use patchwork :)

How do you then collect all the "{Reviewed,Tested,etc}-by:" signatures
(each of which means sometimes hours of effort) in the hairy ML threads?
Patchwork makes it a matter of one click.

-- 
Best regards,
Eugeniu.
