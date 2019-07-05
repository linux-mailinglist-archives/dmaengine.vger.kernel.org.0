Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B18600F0
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2019 08:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfGEGPm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jul 2019 02:15:42 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15854 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfGEGPm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 Jul 2019 02:15:42 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1eeb0c0001>; Thu, 04 Jul 2019 23:15:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Jul 2019 23:15:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Jul 2019 23:15:41 -0700
Received: from [10.24.44.191] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Jul
 2019 06:15:38 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
From:   Sameer Pujar <spujar@nvidia.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>, <mkumard@nvidia.com>
References: <20190502122506.GP3845@vkoul-mobl.Dlink>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
 <20190504102304.GZ3845@vkoul-mobl.Dlink>
 <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <20190613044352.GC9160@vkoul-mobl.Dlink>
 <09929edf-ddec-b70e-965e-cbc9ba4ffe6a@nvidia.com>
 <20190618043308.GJ2962@vkoul-mobl>
 <23474b74-3c26-3083-be21-4de7731a0e95@nvidia.com>
 <20190624062609.GV2962@vkoul-mobl>
 <e9e822da-1cb9-b510-7639-43407fda8321@nvidia.com>
Message-ID: <75be49ac-8461-0798-b673-431ec527d74f@nvidia.com>
Date:   Fri, 5 Jul 2019 11:45:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e9e822da-1cb9-b510-7639-43407fda8321@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562307340; bh=uupu10u8U57FrqvgnS4PO2oXDfDg79qXfQJzeJWeUjM=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=C6iECg2xIEcGku37Aprky92wsyMNCnrvzB4XXD73mKb4/wEV0/RLmdnuvV1nSAmGb
         KfhE49bRt2BMdPre2zp2hEJbq/rxbh+kgcnI9vRa49X7AnOx+PkNTR/Q7ofVstaW17
         zSN1D28FI6nGEKP256VtAE34mjlPhIpq48X4S3V5bO19Bq1gy1okqLz4sFWe8Pa4OI
         b8hdF25CdmSGotUFYqczOJD1hXOt1GoSm53m/0LuQuvTEDEhWfpisvR66TRN8sHAFe
         jslOOqO8ZwjLRvwHUoRRNpxsNuCW6npm/qDsWMTfoD6bcZD75RIs4SqoUgHaAHI7Nz
         260yfyE6U1wBw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

What are your final thoughts regarding this?

Thanks,
Sameer.

>> Where does ADMAIF driver reside in kernel, who configures it for normal
>> dma txns..?
> Not yet, we are in the process of upstreaming ADMAIF driver.
> To describe briefly, audio subsystem is using ALSA SoC(ASoC) layer. 
> ADMAIF is
> registered as platform driver and exports DMA functionality. It 
> registers PCM
> devices for each Rx/Tx ADMAIF channel. During PCM playback/capture 
> operations,
> ALSA callbacks configure DMA channel using API dmaengine_slave_config().
> RFC patch proposed, is to help populate FIFO_SIZE value as well during 
> above
> call, since ADMA requires it.
>>
>> Also it wold have helped the long discussion if that part was made clear
>> rather than talking about peripheral all this time :(
> Thought it was clear, though should have avoided using 'peripheral' in 
> the
> discussions. Sorry for the confusion.

