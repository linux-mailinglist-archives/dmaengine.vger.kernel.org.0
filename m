Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9A1813AD2A
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 16:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgANPJ4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jan 2020 10:09:56 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1244 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgANPJ4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jan 2020 10:09:56 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1dd98d0000>; Tue, 14 Jan 2020 07:09:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 14 Jan 2020 07:09:55 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 14 Jan 2020 07:09:55 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 15:09:53 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v4 01/14] dmaengine: tegra-apb: Fix use-after-free
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-2-digetx@gmail.com>
Message-ID: <4c1b9e48-5468-0c03-2108-158ee814eea8@nvidia.com>
Date:   Tue, 14 Jan 2020 15:09:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200112173006.29863-2-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579014541; bh=G7diX+f6twmP7TJqSOM2EsIIN01zQX3YxUpUGhCBY2Q=;
        h=X-PGP-Universal:From:Subject:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bo2IRZWsYTVKvVkTCapcbpqKE1iifep2ycKLBGkQLjuhAY/ZWGG+N6owPwkbGgV18
         ghBw6UUfCrnpRtbkns0ihjBENOmTIHzGPnrI/17dKE+x5OoUY9A2kyr7TMvv6xn9ge
         oDj9CEedRlTUjZqHm+hJ6jTW35mamu64IysH4zLCm9QZnVLsMjLcRpM9bwFrYlA0Hs
         WLt0x/bGzr7CtvVgcK2ji34ExjSVzkmt9HSJw8dVG9b/eC5a+1ZFsIuil5rVVOpIAv
         G0kQVmmwOVKtfYnUOpliHcKemnRcnd2quiqo8GLaqq1XnHRKNVWO83hO/98HNOPaVh
         gMWsVE0LeqONw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 12/01/2020 17:29, Dmitry Osipenko wrote:
> I was doing some experiments with I2C and noticed that Tegra APB DMA
> driver crashes sometime after I2C DMA transfer termination. The crash
> happens because tegra_dma_terminate_all() bails out immediately if pending
> list is empty, thus it doesn't release the half-completed descriptors
> which are getting re-used before ISR tasklet kicks-in.

Can you elaborate a bit more on how these are getting re-used? What is
the sequence of events which results in the panic? I believe that this
was also reported in the past [0] and so I don't doubt there is an issue
here, but would like to completely understand this.

Thanks!
Jon

[0] https://lore.kernel.org/patchwork/patch/675349/

-- 
nvpublic
