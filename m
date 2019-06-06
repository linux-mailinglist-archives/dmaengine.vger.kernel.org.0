Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFC3379BD
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 18:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfFFQcn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 12:32:43 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17548 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfFFQcm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jun 2019 12:32:42 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf940290002>; Thu, 06 Jun 2019 09:32:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 09:32:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 06 Jun 2019 09:32:41 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Jun
 2019 16:32:39 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Dmitry Osipenko <digetx@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sameer Pujar <spujar@nvidia.com>, Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <mkumard@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <20190502060446.GI3845@vkoul-mobl.Dlink>
 <e852d576-9cc2-ed42-1a1a-d696112c88bf@nvidia.com>
 <20190502122506.GP3845@vkoul-mobl.Dlink>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
 <20190504102304.GZ3845@vkoul-mobl.Dlink>
 <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <ed95f03a-bbe7-ad62-f2e1-9bfe22ec733a@ti.com>
 <4cab47d0-41c3-5a87-48e1-d7f085c2e091@nvidia.com>
 <8a5b84db-c00b-fff4-543f-69d90c245660@nvidia.com>
 <3f836a10-eaf3-f59b-7170-6fe937cf2e43@ti.com>
 <a36302fc-3173-070b-5c97-7d2c55d5e2cc@nvidia.com>
 <a08bec36-b375-6520-eff4-3d847ddfe07d@ti.com>
 <4593f37c-5e89-8559-4e80-99dbfe4235de@nvidia.com>
 <deae510a-f6ae-6a51-2875-a7463cac9169@gmail.com>
 <ac9a965d-0166-3d80-5ac4-ae841d7ae726@nvidia.com>
 <50e1f9ed-1ea0-38f6-1a77-febd6a3a0848@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <4b098fb6-1a5b-1100-ae16-978a887c9535@nvidia.com>
Date:   Thu, 6 Jun 2019 17:32:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <50e1f9ed-1ea0-38f6-1a77-febd6a3a0848@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559838761; bh=k8u67P195ByQ7NwcJoTWbUMcfVgkrN8EE1wBTc4lo2Q=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bcTBAfzNv7bqbRwB6bN21BDIGn8RjgA/UQZsXULBJ1EfkcaiOJvxj/hkXbRLyqAnm
         JRcmH7ROBIyqb1/32m03N3zKHyuE9xfbuoJdho52dOJ9Ic0PvVpr9CZTd+xGoTB8le
         aU3QrutiN7vjLgRJ+BfEgaHrmH4ORIoCBF/BArqIwBC2RqIPfdbB6Np07bDwSS47N/
         rtyiTigJGXJgXuE/xvn5cpuXhokNpk5+8ftoYNSdXTxnd6wBO6WFWFqqHy1NiGfw0d
         M/JYZOwrZ5QMJaamn3Zrdo9rKOdiZXWJABDTX8NDF2rwMmvcx6b8dz07DsbzQPkXDN
         NK2+k2D5O6cXw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 06/06/2019 16:18, Dmitry Osipenko wrote:

...

>>> If I understood everything correctly, the FIFO buffer is shared among
>>> all of the ADMA clients and hence it should be up to the ADMA driver to
>>> manage the quotas of the clients. So if there is only one client that
>>> uses ADMA at a time, then this client will get a whole FIFO buffer, but
>>> once another client starts to use ADMA, then the ADMA driver will have
>>> to reconfigure hardware to split the quotas.
>>
>> The FIFO quotas are managed by the ADMAIF driver (does not exist in
>> mainline currently but we are working to upstream this) because it is
>> this device that owns and needs to configure the FIFOs. So it is really
>> a means to pass the information from the ADMAIF to the ADMA.
> 
> So you'd want to reserve a larger FIFO for an audio channel that has a
> higher audio rate since it will perform reads more often. You could also
> prioritize one channel over the others, like in a case of audio call for
> example.
> 
> Is the shared buffer smaller than may be needed by clients in a worst
> case scenario? If you could split the quotas statically such that each
> client won't ever starve, then seems there is no much need in the
> dynamic configuration.

Actually, this is still very much relevant for the static case. Even if
we defined a static configuration of the FIFO mapping in the ADMAIF
driver we still need to pass this information to the ADMA. I don't
really like the idea of having it statically defined in two different
drivers.

Jon

-- 
nvpublic
