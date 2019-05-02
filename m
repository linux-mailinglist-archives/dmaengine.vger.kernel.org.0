Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 319A011A55
	for <lists+dmaengine@lfdr.de>; Thu,  2 May 2019 15:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfEBNgS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 May 2019 09:36:18 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19016 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBNgS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 May 2019 09:36:18 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ccaf24b0000>; Thu, 02 May 2019 06:36:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 02 May 2019 06:36:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 02 May 2019 06:36:15 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 May
 2019 13:36:12 +0000
Subject: Re: [PATCH 0/6] Add support for Tegra186/Tegra194 and generic fixes
To:     Sameer Pujar <spujar@nvidia.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <thierry.reding@gmail.com>, <ldewangan@nvidia.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1556801717-31507-1-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f8486dab-f95b-a4b1-36f2-89b98086d0cb@nvidia.com>
Date:   Thu, 2 May 2019 14:36:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556801717-31507-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556804172; bh=zQW3UmrtuFX0g5vUoqAHKLUOOl8w+C8rfhpSmD8+zhk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=pyqAnV2poqrhI/+V/m5PoRRYO9zOVdkIGqBjd7mJZpBUz5Hwq3qv3oAwA0bO+Resk
         YXQEzi/3XX626Ghcf9jMnbCqEC4FNnphYu2UvtuOZLEbYUarQU/1JVhEKgUDVG47Nw
         ABnf6z1ke3aaRJ6Tpt1/SMHiv7gxcS1af/K2a2QxZjZmgO8lOc3sFE8ToBH5Rnsc+h
         ytBMnAimMS08Ulji4WreVCeyYIvn/jheqYfYiZmNyxRK+l6NKOGuDJgHanv0Q7D/ii
         ZmZtd4ySIRI1PvCBJez2hROmoo+0qMbcnQnJ2sWgvepEYMqZ+u3WhAi8K2dreBYJTA
         Y5hnrQ/EDE3ww==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 02/05/2019 13:55, Sameer Pujar wrote:
> Audio DMA(ADMA) interface is a gateway in the AHUB for facilitating DMA
> transfers between memory and all of its clients. Currently the driver
> supports Tegra210 based platforms. This series adds support for Tegra186
> and Tegra194 based platforms and fixes few functional issues.
> 
> Patches in the series are classified into three categories,
>   1. Add support for Tegra186 and Tegra194
>   2. Add DMA pause/resume feature
>   3. Fixes common to differernt Tegra generations
> 
> Below change log describes the patches in detail.
> 
> Change log:
> =====================================
> v1
> ----
> The series can be classified into 3 categories,
>   1. Add support for Tegra186 and Tegra194
>      [Patch 1/6] dmaengine: tegra210-adma: prepare for supporting newer
>      Tegra chips
>        * The support was there only for Tegra210
>        * This is a preparation for adding support for newer Tegra chips
>        * chip_data is enhanced to support differences between Tegra210 and
>          Tegra186/Tegra194
>      [Patch 2/6] Documentation: DT: Add compatibility binding for Tegra186
>        * New compatibility string is required for driver to work for
>          Tegra186 and Tegra194. Hence new compatibility is introduced.
>        * Tegra194 can use the same compatibility as Tegra186
>      [Patch 3/6] dmaengine: tegra210-adma: add support for Tegra186/
>      Tegra194
>        * Populates chip specific information for Tegra186
>        * There is a difference in the way ADMA CH_CONFIG registers are
>          encoded for Tegra210 and Tegra186. Added helper fucntions to
>          support different versions of burst size configuration
> 
>   2. Add DMA pause/resume feature
>      [Patch 4/6] dmaengine: tegra210-adma: add pause/resume support
>        * Adds support for ADMA pause/resume, otherwise audio loss was seen
>          during continuous pause/resume of audio playback.
> 
>   3. Fixes common to differernt Tegra generations
>      [Patch 5/6] dmaengine: tegra210-dma: free dma controller in remove()
>        * Fixes kernel panic observed during driver reload. DMA controller
>          needs to be freed when driver is unloaded
>      [Patch 6/6] dmaengine: tegra210-adma: restore channel status
>        * Fixes resume across system suspend. If the channel state is not
>          restored, the transfers won't resume from the state from where it
>          was left during suspend entry. In this case, audio playback did
>          not resume properly once system exited from low power state.
> 
> ===============================
> Sameer Pujar (6):
>   dmaengine: tegra210-adma: prepare for supporting newer Tegra chips
>   Documentation: DT: Add compatibility binding for Tegra186
>   dmaengine: tegra210-adma: add support for Tegra186/Tegra194
>   dmaengine: tegra210-adma: add pause/resume support
>   dmaengine: tegra210-dma: free dma controller in remove()
>   dmaengine: tegra210-adma: restore channel status
> 
>  .../bindings/dma/nvidia,tegra210-adma.txt     |   4 +-
>  drivers/dma/tegra210-adma.c                   | 232 +++++++++++++++++----
>  2 files changed, 193 insertions(+), 43 deletions(-)
> 

Thanks!

For the series ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
