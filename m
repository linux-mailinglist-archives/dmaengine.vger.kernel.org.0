Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA9C20230C
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2020 11:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFTJx3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 20 Jun 2020 05:53:29 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9331 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgFTJx3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 20 Jun 2020 05:53:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eeddc8c0000>; Sat, 20 Jun 2020 02:53:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 20 Jun 2020 02:53:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 20 Jun 2020 02:53:28 -0700
Received: from [10.26.73.131] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 20 Jun
 2020 09:53:22 +0000
Subject: Re: [PATCH] [v3] dmaengine: tegra210-adma: Fix runtime PM imbalance
 on error
To:     <dinghao.liu@zju.edu.cn>
CC:     <kjlu@umn.edu>, Laxman Dewangan <ldewangan@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200618105727.14669-1-dinghao.liu@zju.edu.cn>
 <9f7684d9-7a75-497d-db1c-75cf0991a072@nvidia.com>
 <24ea1ef1.10213.172ca4d45be.Coremail.dinghao.liu@zju.edu.cn>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f4034e16-e720-57c4-eb9d-733786212a4a@nvidia.com>
Date:   Sat, 20 Jun 2020 10:53:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <24ea1ef1.10213.172ca4d45be.Coremail.dinghao.liu@zju.edu.cn>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592646796; bh=skDQ77maO2GC7cm4xW7BXoWafTy1w2SK+o9txAtL5SE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UimnWIqpRJy7kUAKmx0otVxsMGTTOcIcq44DP2Q5g9xTeWqUH6NSnNDqR6hnTZ/mO
         RW22vRCa6BZ6k/TDgdYcAmeWCLgM+1gQHulmACKUapQXyooMt7XRyx/UKASP+XhFBB
         XN1AXJtTB3koVzlED+vKIUKDGJkEGtjP+AdLktNtOINJfFLMTafwfYGt0AfZZlTZ5C
         djhZUysytC6torZrMRhRcjfHk3IpOnp9GURpLmvi5AdwIVa4HsC5C3j09ZMBbrOv3L
         tHH7g9g8VZfW89oOtP94NLhHaSV7L3E0wlc1z0QcQ29SDRUIF9HOklT6Kc/rjqDeFN
         E+L169HQ1F3xQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 19/06/2020 02:59, dinghao.liu@zju.edu.cn wrote:
>>
>> Why noidle?
>>
> 
> _noidle is enough for fixing this bug. _sync may suspend
> the device beyond expectation.

In that case, then the other instance you are fixing with this patch is
not correct.

Jon

-- 
nvpublic
