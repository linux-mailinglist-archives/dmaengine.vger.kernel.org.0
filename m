Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEFA315718
	for <lists+dmaengine@lfdr.de>; Tue,  9 Feb 2021 20:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhBITps (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Feb 2021 14:45:48 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:37483 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbhBITkr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Feb 2021 14:40:47 -0500
Received: by mail-wm1-f48.google.com with SMTP id m1so4649799wml.2;
        Tue, 09 Feb 2021 11:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c6vCaI1Ot4rIOLJkm4PsY67pG5cYnNtElevzVRC/8jc=;
        b=HEZWULPJ+zz9Zw7W3W/pwWRa85Feels4tRl3vzTw9uUorgAhvnmwLkj1EJIKmJ+5du
         97HyEp6ZmNBr4cknN6LcKiXjMUFS/c3VURmBlbvSdHTZGUb4xasUdMeP/jj7MIfeZTR3
         stIQ1SHkDEq94qRdaFE6CCAHYA/NJtKtmEZJuX258NLQWB6bPjTsqBpOWl1GBZgc//kD
         iKp8EZ58l3pdnbgu2C/tFyt1drgf5gRvdQCdD9f2Dg4pa9Oy7ReE0Ht3NDFfIqRG11Eq
         Rmqcdz/J7DUC7frhl2id8lPzYUc3jc27Jl9zd2vImb8Dv+niOaBIi/0bzXn02vj+avAe
         clBw==
X-Gm-Message-State: AOAM5314CXwB3RD5Xe11dG7KecZxyU2aNrreBg50CG3dVGNyc5LbNPV9
        BCOj60zV4NBmz9C1+IBtWho=
X-Google-Smtp-Source: ABdhPJw7FD2tJaT20PTfXYsdZ/lAuCGttMIMQRbkmPz7RXBi0JFHhR8pII9knECGQDnDCrCFoWqmrg==
X-Received: by 2002:a1c:b087:: with SMTP id z129mr5003988wme.147.1612899605420;
        Tue, 09 Feb 2021 11:40:05 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r16sm36117272wrt.68.2021.02.09.11.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:40:04 -0800 (PST)
Date:   Tue, 9 Feb 2021 20:40:03 +0100
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
Message-ID: <YCLlE+StUVWjfxqf@rocinante>
References: <ceb5eb396e417f9e45d39fd5ef565ba77aae6a63.1612389406.git.gustavo.pimentel@synopsys.com>
 <20210208193516.GA406304@bjorn-Precision-5520>
 <DM5PR12MB1835A960892E401D50DEBB9DDA8E9@DM5PR12MB1835.namprd12.prod.outlook.com>
 <YCLR3uB5+GELTXSk@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCLR3uB5+GELTXSk@rocinante>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Gustavo,

[...]
> > That's true, there are a lot of drivers that don't verify that pointer. 
> > What do you suggest?
> > 1) To remove the verification so that is aligned with the other drivers
> > 2) Leave it as is. Or even to add this verification to the other drivers?
> > 
> > Either way, I will add the pcim_iomap_table(pdev) before this 
> > instruction.
> [...]
> 
> A lot of the drivers consume the value from pcim_iomap_table() at
> a given BAR index directly as-is, some check if the pointer they got
> back is not NULL, a very few also check if the address at a given index
> is not NULL.
> 
> Given that the memory allocation for the table can fail, we ought to
> check for a NULL pointer.  It's a bit worrying that people decided to
> consume the value it returns directly without any verification.
> 
> I only found two drivers that perform this additional verification of
> checking whether the address at a given index is valid, as per:
> 
>   https://lore.kernel.org/linux-pci/YCLFTjZQ2bCfGC+J@rocinante/
> 
> Personally, I would opt for (2), and then like you suggested send
> a separate series to update other drivers so that they also include the
> this NULL pointer check.
> 
> But let's wait for Bjorn's take on this, though.

As per Bjorn's reply:

  https://lore.kernel.org/linux-pci/20210209185246.GA494880@bjorn-Precision-5520/

These extra checks I proposed would be definitely too much, especially
since almost everyone who uses pcim_iomap_table() also calls either
pcim_iomap_regions() or pcim_iomap_regions_request_all() before
accessing the table.

There probably is also an opportunity to simplify some of the other
drivers in the future, especially if do some API changes as per what
Bjorn suggested.

Sorry for taking your time, and thank you again!

Krzysztof
