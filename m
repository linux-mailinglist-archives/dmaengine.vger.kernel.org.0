Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5923366EB0
	for <lists+dmaengine@lfdr.de>; Wed, 21 Apr 2021 17:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbhDUPEV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Apr 2021 11:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243763AbhDUPEO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 21 Apr 2021 11:04:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4F4B6144B;
        Wed, 21 Apr 2021 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619017421;
        bh=h4bnYJpTsBnh2Jm4qYlSxDKXA+i8trJiLN/1joCEa+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=drl2jHGU6wXdYAZeJ4Hr1dVI6l3i0kn4WsW5CiUaCxsnihRfeUBTnyTbhtfSYx53h
         BEaHnwmKtFfh9rvKUy0zkpvmXDNFg01Z32uRvRiRuVFFOQpgIcsdoF4tXg5pRcpPBI
         r09CidzMLWlMYqOLYW4rwBk7Q0L/o3hbkAbc9aYtbE+ya6z1p92hS2qRMJTe8Kq6EV
         NgHazX0iNCxUJSL44iZx6BoyZp09KD0sFSorRUlhJsWMyo2X7X79fuP7fuvt6YmrSu
         V6I8bQeX9UrSx0dTnxyrYNdOB/lg14GocUkBRgXgfJkRRmn3drOru+T87I6LQ/3qAA
         oGDkxtev6Sy2w==
Date:   Wed, 21 Apr 2021 20:33:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, dave.jiang@intel.com,
        tony.luck@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dmaengine: idxd: Add IDXD performance monitor
 support
Message-ID: <YIA+ycNfqwytoy/Z@vkoul-mobl.Dlink>
References: <cover.1617467772.git.zanussi@kernel.org>
 <d38a8b3a5d087f1df918fa98627938ef0c898208.1617467772.git.zanussi@kernel.org>
 <YH623ULPRbdi1ker@vkoul-mobl.Dlink>
 <34f61cc9-a6d6-e5a3-5f8c-6ffae8858cce@linux.intel.com>
 <YH+/qyUVtlHwWQJ/@vkoul-mobl.Dlink>
 <410134d7-5a4d-3537-e9cc-c4c8e7068cde@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410134d7-5a4d-3537-e9cc-c4c8e7068cde@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-04-21, 07:50, Zanussi, Tom wrote:

> > > > > +static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> > > > > +			    char *buf);
> > > > > +
> > > > > +static cpumask_t		perfmon_dsa_cpu_mask;
> > > > > +static bool			cpuhp_set_up;
> > > > > +static enum cpuhp_state		cpuhp_slot;
> > > > > +
> > > > > +static DEVICE_ATTR_RO(cpumask);
> > > > 
> > > > Pls document these new attributes added
> > 
> > ?
> > 
> 
> Yes, I'll add comments to all the attributes (also I'm assuming they don't need to be documented elsewhere).

They need to be, all new sysfs attributes are ABI and need to be
documented in Documentation/ABI/

Thanks
-- 
~Vinod
