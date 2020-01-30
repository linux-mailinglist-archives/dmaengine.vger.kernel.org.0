Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6389714DC78
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 15:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgA3OI4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 09:08:56 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15358 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3OIz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 09:08:55 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e32e3430000>; Thu, 30 Jan 2020 06:08:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 Jan 2020 06:08:55 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 Jan 2020 06:08:55 -0800
Received: from [10.26.11.91] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Jan
 2020 14:08:51 +0000
Subject: Re: [PATCH v6 08/16] dmaengine: tegra-apb: Fix coding style problems
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200130043804.32243-1-digetx@gmail.com>
 <20200130043804.32243-9-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5194893f-3b2c-5f00-035a-2be62e8b1d89@nvidia.com>
Date:   Thu, 30 Jan 2020 14:08:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130043804.32243-9-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580393283; bh=A6G6Pwn0RO+ie3y0YiBc4An7mwnXvP01M5DO4BoZRaQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=k2CyEyKEjBp4qKbaB7YCPgAd2xuu7fi5jJmqcRm9cRtaMQr2Dr0E35GAjY3cpmuWt
         WGFr2TDNiMMurBKCiOHkDL3wZIKLQ/BpWvw3VDkvp/4iniM0U+0dl894bsMu+bUOal
         Se3RCjLutdCjpl5Zzs9VPHqvvJSMNqsbE7O8oJX245VsJKmK3SX97PbjQr7F/KUsyQ
         bkDCw2KSJDmF15eGpQZQBdgCJblch8cWLsYo2JY6/ONWBNJXkxRCmJj9rpbZkrSZ/t
         D+ugH1gNNUgYNXuzxaOoKLUt/UkMXOb0RO5cEoXN6zFLfMjUaBSHUffz2uGtfb/1Q/
         Xw3HZXyXNHJ3g==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 30/01/2020 04:37, Dmitry Osipenko wrote:
> This patch fixes few dozens of coding style problems reported by
> checkpatch and prettifies code where makes sense.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 275 ++++++++++++++++++----------------
>  1 file changed, 144 insertions(+), 131 deletions(-)

Thanks!

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
