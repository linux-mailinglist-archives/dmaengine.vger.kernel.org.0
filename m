Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2F9322F42
	for <lists+dmaengine@lfdr.de>; Tue, 23 Feb 2021 18:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhBWRAz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Feb 2021 12:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbhBWRAx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Feb 2021 12:00:53 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6A7C06174A
        for <dmaengine@vger.kernel.org>; Tue, 23 Feb 2021 09:00:12 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id j6so8531594eja.12
        for <dmaengine@vger.kernel.org>; Tue, 23 Feb 2021 09:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g83cDVRo2aFwmjMMBeZG4AQrn7BFmaZ4MxtmZRxBHlU=;
        b=0nnsYM602Fzi7oLAbHc3ixYo6Hjiv8f1VPyeA8KYvAwULgy0IpPZmcEYehSu52u37/
         PFJajqwdEFXq7GGL9NX7FYeRZlfYwFZxyCQ5bWjQ8ifxvjFrdpxp4BF0h8D/XnNX2HL8
         D5JZBuC8eijEREuTi8UDEqj4bd+L0P6ykEdDYXqvit//JTfMRG4A5r2qdsGwNyk4dy7T
         ZyW1F3iHVKHT1UAZXX9B0o21mPFTww1cX0LD1Ss179J2s2TBP5FaUCL+3cB37KTBrxSa
         tpu6BTnSlKlXFK4mckFlJf51onti1ZoZau6oTRzLI/ZrK1EfNKHuUCPFpa5iSwc+AhoM
         Nxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g83cDVRo2aFwmjMMBeZG4AQrn7BFmaZ4MxtmZRxBHlU=;
        b=XA2itqP+g1n0lJm5nfTImj9G74JwuRhWqhCaVYIhRHP6+vv2BLZATTKbxH9J2c4dlc
         3B0wBT4SF1RNo9TJNbzrORfCMMHVU6YHskN/vrmkMd1rqXUoGFBwRVGf9BfjTASiLM3r
         J/hi7jnb0CLEd1cfbHlUeQdkoGmFjyn4MpXX5jUYRU9jTKAigZQvxgnXagaRq8Z+DAuX
         y5l1UH6bywQo8/5rFXwrBgy4RKS0eKvxhj1AFfosmKQP9CH7Xo/7OmfV7BD6S8ZqOfs1
         qUuj4Fre9g8tpo6xM4trey7rccEh7krTcQJcCFjEw8Ct7DPuHt+dS7GsGyq2tjZUu4hX
         cPKg==
X-Gm-Message-State: AOAM530IYIvXA8y3FpPtUTuiZlhHlCIaPo+WS9mtvWp9u2S8nS8MZ6nD
        IFXTMcCPeLK6bZTpH/w2GBtGCCa32olrfseoUczxOV5NRQ4=
X-Google-Smtp-Source: ABdhPJz5h89EcJ0fOeHvgTgbm93N5CZOGgXESC/eqcf0s/AqjHqNFd6fkuDazX4zymTzuec+fQ2u0WAj3lL9leyVHqA=
X-Received: by 2002:a17:907:373:: with SMTP id rs19mr14427739ejb.341.1614099610416;
 Tue, 23 Feb 2021 09:00:10 -0800 (PST)
MIME-Version: 1.0
References: <161368391486.325538.12829531932377771231.stgit@djiang5-desk3.ch.intel.com>
 <20210223125956.GY4247@nvidia.com>
In-Reply-To: <20210223125956.GY4247@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Feb 2021 09:00:06 -0800
Message-ID: <CAPcyv4g_DcYtAFV-XRdT58iPdnntf_KOBAAzXDk3aJxNxEd2xA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 23, 2021 at 5:00 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Feb 18, 2021 at 02:31:54PM -0700, Dave Jiang wrote:
> > Remove devm_* allocation of memory of 'struct device' objects.
> > The devm_* lifetime is incompatible with device->release() lifetime.
> > Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
> > functions for each component in order to free the allocated memory at
> > the appropriate time. Each component such as wq, engine, and group now
> > needs to be allocated individually in order to setup the lifetime properly.
>
> I really don't understand why idxd has so many struct device objects.
>
> Typically I expect a simple driver to have exactly one, usually
> provided by its subsystem.
>
> What is the purpose?
>
> And it is still messed up because it has:
>
> struct idxd_device {
>         enum idxd_type type;
>         struct device conf_dev; <-- This is a kref
>
>         struct dma_device dma_dev; <-- And this is also a kref
> }
>
> The first kref does kfree() and the second does
> idxd_conf_device_release() which does nothing - this is obviously
> wrong too.

Obviously... I apologize I flubbed this and assumed the devm
conversions also moved these to pointers.
