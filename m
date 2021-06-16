Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D3D3A905E
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 06:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhFPERU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 00:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhFPERT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 00:17:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3323B61246;
        Wed, 16 Jun 2021 04:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623816914;
        bh=FVUaYjKHc+AKLajKsB3EM4ycBOxBIGMjhYSj8aEsVbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9ImWtIF40K0ojCF0m4NObfYejwVh6r5dwuWdoJG5IQjq1V950RGEFDbO2ENwCF3I
         oMJdAkPdgQHGo1zQr8MQXJAplt/nEXbW1dN3TD3daYWGB0jnIoBQmBT6On+FFqG3QQ
         pvkzjmUPE+j9fqMI4DwPt0e4/R3hysKL6DAtAscDt8dSTHlDIZZjj4E77osHks3k20
         n7gppevuHN5O4G0hj5TiWsAYRHAR0DXtuJnt5Ge4vHlSKxfNIBvE/qwpUfPFLnJ/wh
         FFZPN6ULiyGp8uCons5sPB8+4xoRswRDw4lAVbzyu3PyMjFAPtVxgxiDo5MEBrEc5v
         5YW64Bo+hzEJQ==
Date:   Wed, 16 Jun 2021 09:45:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v9 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
Message-ID: <YMl6zpjVHls8bk/A@vkoul-mobl>
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-2-git-send-email-Sanju.Mehta@amd.com>
 <YL+rUBGUJoFLS902@vkoul-mobl>
 <94bba5dd-b755-81d0-de30-ce3cdaa3f241@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94bba5dd-b755-81d0-de30-ce3cdaa3f241@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-06-21, 16:50, Sanjay R Mehta wrote:

> >> +static struct pt_device *pt_alloc_struct(struct device *dev)
> >> +{
> >> +     struct pt_device *pt;
> >> +
> >> +     pt = devm_kzalloc(dev, sizeof(*pt), GFP_KERNEL);
> >> +
> >> +     if (!pt)
> >> +             return NULL;
> >> +     pt->dev = dev;
> >> +     pt->ord = atomic_inc_return(&pt_ordinal);
> > 
> > What is the use of this number?
> > 
> 
> There are eight similar instances of this DMA engine on AMD SOC.
> It is to differentiate each of these instances.

Are they individual device objects?

-- 
~Vinod
