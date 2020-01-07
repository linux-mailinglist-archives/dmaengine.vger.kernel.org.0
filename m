Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFA11329BB
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jan 2020 16:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgAGPN7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jan 2020 10:13:59 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17777 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbgAGPN6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jan 2020 10:13:58 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e14a0240000>; Tue, 07 Jan 2020 07:13:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 07:13:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 07:13:57 -0800
Received: from [10.26.11.139] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 15:13:55 +0000
Subject: Re: [PATCH v3 09/13] dmaengine: tegra-apb: Remove runtime PM usage
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200106011708.7463-1-digetx@gmail.com>
 <20200106011708.7463-10-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f63a68cf-bb9d-0e79-23f3-233fc97ca6f9@nvidia.com>
Date:   Tue, 7 Jan 2020 15:13:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106011708.7463-10-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578410020; bh=Sf0ckx5pEctxgD10OMRT1lnch6V57nc9NpAJxMakDd4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LWgsm1ORkmkJ0tg8Uqw2z2plcb298KilPFwVAdMJeRU69ugZwZh+ImPailCMGibXS
         JUK6rBM79/VREU15uTjOVxQZM1NZrJOX/I1psObzTqmy9tI3Ooq7GQVRxT2/sBk+Aj
         7xRZ+D9i1SJ1FHRQeu/RqGbkN1rWuBcAD58EEk9WarnNwNhd658HB7szBeQthZliKn
         1WumM0vQyo0UrNOxIVwBT70Zr4KgxsfRYy9n3j4Umw8cCwaWWQvs8vGdiAmGPwoDEd
         GO4a/jaCc0PgYHNj6j3Po+DybaZZDMPTXwFhnOo41QYQP1I04o7nrJokUaV3RnAg4J
         IrBEPFvyh1P4w==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 06/01/2020 01:17, Dmitry Osipenko wrote:
> There is no benefit from runtime PM usage for the APB DMA driver because
> it enables clock at the time of channel's allocation and thus clock stays
> enabled all the time in practice, secondly there is benefit from manually
> disabled clock because hardware auto-gates it during idle by itself.

This assumes that the channel is allocated during a driver
initialisation. That may not always be the case. I believe audio is one
case where channels are requested at the start of audio playback.

Jon

-- 
nvpublic
