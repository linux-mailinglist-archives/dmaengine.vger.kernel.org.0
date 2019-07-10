Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818376442A
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2019 11:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfGJJMA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Jul 2019 05:12:00 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18456 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfGJJMA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 10 Jul 2019 05:12:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d25abda0000>; Wed, 10 Jul 2019 02:11:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 10 Jul 2019 02:11:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 10 Jul 2019 02:11:59 -0700
Received: from [10.26.11.158] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Jul
 2019 09:11:56 +0000
Subject: Re: [RESEND PATCH] dmaengine: tegra210-adma: Don't program FIFO
 threshold
To:     Vinod Koul <vkoul@kernel.org>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
References: <20190705091557.726-1-jonathanh@nvidia.com>
 <20190705130531.GE2911@vkoul-mobl>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ac13d007-4b42-c3af-70db-de06703eb154@nvidia.com>
Date:   Wed, 10 Jul 2019 10:11:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705130531.GE2911@vkoul-mobl>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562749914; bh=G60ez2mN5dTDYDltN/wrNsRVVYDWXcm1whA8ovlkPNs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ZXNtHjMmtH0Hlef8wp1D5g7Yq0XQsJrtVHDG0YbCpozGMg8Vuo2nbp6hqeJFttT0D
         vSbBbztA+OkuvN0IEB7hHgimNP3B3qpK5+QdlhjYYeBmTrHooTsfx4c9lf9xSbtGK3
         72YCM9er7RBA7WgIRPGDkQYho768LuGaATpt0bAQvLYR0pZNWA/vt+r8KfO7n7QMNx
         ST1U3ObS9gvhomdNVRk2wbghW1ad4vaKw5skp0A5cgSiTZEDqIyIP1flnAvOuvJyXX
         R3G3uwxRvjEWm5puTTcvXGiKQSNdGC6JSe8LdHdduLIV63QbImV7aL2nU/4Us4n/VF
         I+M83IJjBkotQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 05/07/2019 14:05, Vinod Koul wrote:
> On 05-07-19, 10:15, Jon Hunter wrote:
>> From: Jonathan Hunter <jonathanh@nvidia.com>
>>
>> The Tegra210 ADMA supports two modes for transferring data to a FIFO
>> which are ...
>>
>> 1. Transfer data to/from the FIFO as soon as a single burst can be
>>    transferred.
>> 2. Transfer data to/from the FIFO based upon FIFO thresholds, where
>>    the FIFO threshold is specified in terms on multiple bursts.
>>
>> Currently, the ADMA driver programs the FIFO threshold values in the
>> FIFO_CTRL register, but never enables the transfer mode that uses
>> these threshold values. Given that these have never been used so far,
>> simplify the ADMA driver by removing the programming of these threshold
>> values.
>>
>> Signed-off-by: Jonathan Hunter <jonathanh@nvidia.com>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> ---
>>
>> Resending the patch rebased on top next-20190704. I have added Thierry's
>> ACK as well.
> 
> Thanks but this fails as well. I had applied few tegra patches so I
> suspect that is causing issues now. It would have been nice to have them
> in series.
> 
> Would you rebase on
> git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git next (yeah
> this is different location, i dont see to push to infradead today)

So this patch should apply cleanly on top of the fixes series I sent for
v5.2 [0] which you merged and is now in mainline. So if I rebase on the
above, I wondering if it is then going to conflict with mainline? Looks
like the above branch is based upon v5.2-rc1 and hence the conflict.

Cheers
Jon

[0] https://patchwork.kernel.org/cover/10946849/

-- 
nvpublic
