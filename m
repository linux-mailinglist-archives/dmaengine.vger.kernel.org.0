Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157033155C5
	for <lists+dmaengine@lfdr.de>; Tue,  9 Feb 2021 19:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhBISVr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Feb 2021 13:21:47 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:52230 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbhBISSv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Feb 2021 13:18:51 -0500
Received: by mail-wm1-f53.google.com with SMTP id i5so4149045wmq.2;
        Tue, 09 Feb 2021 10:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uLdJv6cZuHRtRFFRIJEOoH3tFE87WZTh9kuO83NwQkA=;
        b=AQ+XhQOVzY7tNvN+7MromeEYGIc+mQAB+nJkPt0qZSlT3XflLWIVYJS3kuOrlSYnV3
         iY8IO7acAMxh4Raaq+esbLoxLLigbJxNsW/qmAnN+jnzRckSF3+HXFAHXwuHa3dk9Afp
         CQTnAz8ByqxnI5fo1T5NvFB4JT30kM6hGD9s4QJ2PUREIWbZRz8X7Ju4FenHTy3GK3gq
         2s0hmen74301TCgW/Tq5aNiher26PN1SqbEaWaYkR6Pc5QJ/X9w/Pa3n6vhupgf7fJzD
         FtfnBoboDFsGw+lsSF7CO0WnJVZKBjkkmUobv/CaQkUB/QkyGunTZLlNL+Qv4FNoREn+
         yt4w==
X-Gm-Message-State: AOAM531yJTqrhiAiUo+d6CMDrC4zJIvUeNg8oLZM96SXn4HdyQP7ZUxC
        wBnMkBZ4UaE4RiHLgXChnP2gO4geLdYcbrS7
X-Google-Smtp-Source: ABdhPJwz+oj1rYRkIUbkuFpwNkRP8w69gpqFE7NuELRZRlrJxE3bDlWo2EjSvBNuLir40teoqSz3YQ==
X-Received: by 2002:a1c:105:: with SMTP id 5mr4662963wmb.89.1612894688876;
        Tue, 09 Feb 2021 10:18:08 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u70sm6019208wmu.20.2021.02.09.10.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 10:18:08 -0800 (PST)
Date:   Tue, 9 Feb 2021 19:18:06 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 15/15] dmaengine: dw-edma: Add pcim_iomap_table return
 checker
Message-ID: <YCLR3uB5+GELTXSk@rocinante>
References: <ceb5eb396e417f9e45d39fd5ef565ba77aae6a63.1612389406.git.gustavo.pimentel@synopsys.com>
 <20210208193516.GA406304@bjorn-Precision-5520>
 <DM5PR12MB1835A960892E401D50DEBB9DDA8E9@DM5PR12MB1835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM5PR12MB1835A960892E401D50DEBB9DDA8E9@DM5PR12MB1835.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Gustavo,

[...]
> > This "pcim_iomap_table(dev)[n]" pattern is extremely common.  There
> > are over 100 calls of pcim_iomap_table(), and
> > 
> >   $ git grep "pcim_iomap_table(.*)\[.*\]" | wc -l
> > 
> > says about 75 of them are of this form, where we dereference the
> > result before testing it.
> 
> That's true, there are a lot of drivers that don't verify that pointer. 
> What do you suggest?
> 1) To remove the verification so that is aligned with the other drivers
> 2) Leave it as is. Or even to add this verification to the other drivers?
> 
> Either way, I will add the pcim_iomap_table(pdev) before this 
> instruction.
[...]

A lot of the drivers consume the value from pcim_iomap_table() at
a given BAR index directly as-is, some check if the pointer they got
back is not NULL, a very few also check if the address at a given index
is not NULL.

Given that the memory allocation for the table can fail, we ought to
check for a NULL pointer.  It's a bit worrying that people decided to
consume the value it returns directly without any verification.

I only found two drivers that perform this additional verification of
checking whether the address at a given index is valid, as per:

  https://lore.kernel.org/linux-pci/YCLFTjZQ2bCfGC+J@rocinante/

Personally, I would opt for (2), and then like you suggested send
a separate series to update other drivers so that they also include the
this NULL pointer check.

But let's wait for Bjorn's take on this, though.

Krzysztof
