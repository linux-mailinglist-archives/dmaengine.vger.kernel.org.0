Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35CA717519
	for <lists+dmaengine@lfdr.de>; Wed,  8 May 2019 11:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfEHJYm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 May 2019 05:24:42 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14980 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfEHJYm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 May 2019 05:24:42 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd2a0360001>; Wed, 08 May 2019 02:24:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 08 May 2019 02:24:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 08 May 2019 02:24:41 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 May
 2019 09:24:39 +0000
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Handle DMA_PREP_INTERRUPT flag
 properly
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190505181235.14798-1-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <287d7e67-1572-b4f2-d4bb-b1f02f534d47@nvidia.com>
Date:   Wed, 8 May 2019 10:24:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505181235.14798-1-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557307446; bh=j52MX3UmQ0H8WFlT4xHF3zSZUCtlwjthG4+JQPDSgR8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=K/CA2G4S3SSZvH9KEq/Y+7jipz/sCiV7OV5tgTe/aftT8t8sMItR11/8zETzy63C6
         7OJp03NNu1OFHFGKtsFBIaRu1b8kEWx3ig7uwgcXbYfydU8wcOOIG7XYARdgkGIOdz
         CymhrDiYMeZ70mt40gENyczZAp1mgYhEsy+41JHgyzB+piCCwZVQM9kX6lyXr9hTE7
         rt09ALvmNFX3AtXBJcJ41hC6AThlawOw1OsaZFCGrIKqQhpTkeSb6tO8/8lnWpv4pl
         45Z//0ByIUtotNMNq7LbHKWznv7caS5me1eDFmFSxP+R4W+gDeLZPB9wNdgYU3RdSN
         kOEUQG2zwrW6g==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 05/05/2019 19:12, Dmitry Osipenko wrote:
> The DMA_PREP_INTERRUPT flag means that descriptor's callback should be
> invoked upon transfer completion and that's it. For some reason driver
> completely disables the hardware interrupt handling, leaving channel in
> unusable state if transfer is issued with the flag being unset. Note
> that there are no occurrences in the relevant drivers that do not set
> the flag, hence this patch doesn't fix any actual bug and merely fixes
> potential problem.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

From having a look at this, I am guessing that we have never really
tested the case where DMA_PREP_INTERRUPT flag is not set because as you
mentioned it does not look like this will work at all!

Is there are use-case you are looking at where you don't set the
DMA_PREP_INTERRUPT flag?

If not I am wondering if we should even bother supporting this and warn
if it is not set. AFAICT it does not appear to be mandatory, but maybe
Vinod can comment more on this.

Cheers
Jon

-- 
nvpublic
