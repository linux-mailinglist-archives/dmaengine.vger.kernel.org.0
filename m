Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C22FCA4A
	for <lists+dmaengine@lfdr.de>; Thu, 14 Nov 2019 16:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfKNPxh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Nov 2019 10:53:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42508 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfKNPxh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Nov 2019 10:53:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so7033193wrf.9;
        Thu, 14 Nov 2019 07:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xNSszojfafkdfUGJiT19mnY4jwE3FcMYwyygs0ndMzA=;
        b=HKaaK3huyouLu7maPWIzKUeshjOgpC1y+hNAkb1MDUv5qoEcqgnWUx2H7+qiRAbKmd
         XOX/7wcbR5dCWgkp6R+ckE1HZ/Ji/a+7eqk4/w6ENEGEde+5WaDqzCtK0YYxETKoMox6
         baJOjp0uINnmsLzofTAOM+Dj7E37Kg2yUxfLgFJKvK1qQ+L8UlPPbctC5xBG+UeyOmlb
         GIJvLyTyq4v59rDIhPhMk+SlKpAQQIblKeb3M90/4dr+3SJ4yKPSCXwDeUEjtCXrL5LD
         YcMjrfSZNgpWP+5lsTo1GgpipxqtFYEOxSY2PkneK5BvL1+4h4BQrwQzbgljqrHaE7vm
         6wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xNSszojfafkdfUGJiT19mnY4jwE3FcMYwyygs0ndMzA=;
        b=nPc0fQxc3/KDRMxLB+lvhi33MOrwy6RgyK+lNfJBs+JzOd8Q3Yv0hVs8Z1K7mX9ytw
         O6Zr1GyAL2ZBnQz2Vf+PEMJsqtgqRJqvrfnnTeBx553DSbF+bk3V8HPxF6HDQWIFZcY1
         robu4WCF0UehXOemYuq830bNcV4trWCofXPJ87vIVYTBGDR56B9C698lvi9kunOuEcz6
         gim0GIr8QkoiJ88n259/0h8gL0YR2aLGek6hG1ocQgzq9PELMh8YZKMlQkHmmM3H6cfx
         8bDasH6YfLcEBDDZ/84J4K3aurmJayLmOj8zp5r0qHD2O8LD+jkVEFzSUiXn7891r9RA
         6PbA==
X-Gm-Message-State: APjAAAXqmIQ9L/9rgqRODZguC0kFb87O0gZlPh+UKVguTmWXK2hj4jdU
        eYGHWCfGhsUgpNcNDBVsFM4=
X-Google-Smtp-Source: APXvYqy6goqgVrjnSN7Z7JfhfPg7Jzegrh/BrLUOrhxBO7NMiC6aUV8HyO5OKQnWHuOHR4A5TryFWQ==
X-Received: by 2002:adf:db41:: with SMTP id f1mr8484923wrj.351.1573746814450;
        Thu, 14 Nov 2019 07:53:34 -0800 (PST)
Received: from AlexGordeev-DPL-IR1335 (62-99-176-46.static.upcbusiness.at. [62.99.176.46])
        by smtp.gmail.com with ESMTPSA id k4sm7146827wmk.26.2019.11.14.07.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 07:53:33 -0800 (PST)
Date:   Thu, 14 Nov 2019 16:53:32 +0100
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH RFC v5 2/2] dmaengine: avalon-test: Intel Avalon-MM DMA
 Interface for PCIe test
Message-ID: <20191114155331.GA19187@AlexGordeev-DPL-IR1335>
References: <cover.1573052725.git.a.gordeev.box@gmail.com>
 <948f34471b74a8a20747311cc1d7733d00d77645.1573052725.git.a.gordeev.box@gmail.com>
 <20191114050331.GL952516@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114050331.GL952516@vkoul-mobl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Nov 14, 2019 at 10:33:31AM +0530, Vinod Koul wrote:
> On 06-11-19, 20:22, Alexander Gordeev wrote:
> > This is a sample implementation of a driver using "avalon-dma" to
> > perform data transfers between target device memory and system memory:
> > 
> >     +----------+    +----------+            +----------+
> >     |   RAM    |<-->|  Avalon  |<---PCIe--->|   Host   |
> >     +----------+    +----------+            +----------+
> >
> > The target device is expected to use only Avalon-MM DMA Interface for
> > PCIe to initiate DMA transactions - without custom hardware specifics
> > to make such transfers possible.
> > 
> > Unlike "dmatest" driver, the contents of DMAed data is not manipulated by
> > "avalon-test" in any way. It is basically pass-through and the the data
> > are fully dependent on the target device implementation. Thus, it is up
> > to the users to analyze received or provide meaningful transmitted data.
> 
> Is this the only reason why you have not used dmatest. If so, why not
> add the feature to dmatest to optionally not check the DMAed data
> contents?

The main reason is that "dmatest" does not support DMA_SLAVE type of
transactions.

I considered adding DMA_SLAVE to "dmatest". But it would break the 
current neat design and does not appear solving the issue of data
verification. Simply besause in general DMA_SLAVE case there is no
data integrity criteria easily available to the driver. I.e if the
data is a sensor image then verifying it in the driver would be
pointless.

So in case of "avalon-test" I offloaded the task of data verification
to the user. The driver itself just streams user data to/from device.

In fact, this approach is not "avalon-dma" specific and could be used
with any "dmaengine" compatible driver. Moreover, it would be quite
useful for bringing up devices in embedded systems. I.e one could
master a raw display frame in user space and DMA it via the driver -
without graphic stack involved.

The only missing functionality I could think of is using DMABUFs, but that
is very easy to add.

Actually, "avalon-test" is rather a presentation of how I tested
"avalon-dma". I understand "dmatest" is more easy to trust and I could
probably make it working with DMA_SLAVE type. But that would entail
hardware design requirements:

  - DMA slave should both respond to read and write transactions;
  - data read should always be the same as data written;

I have such version of hardware design, but I doubt majorify of devices
out there can honor the above requirements. 

Summarizing - I would suggest not to change "dmatest" and bring in a
generalized version of "avalon-test" if you find it useful for a wider
audience.

Thanks!

> -- 
> ~Vinod
