Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7764E204EDA
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2020 12:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbgFWKNS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Jun 2020 06:13:18 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17429 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgFWKNS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Jun 2020 06:13:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef1d5b10002>; Tue, 23 Jun 2020 03:13:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Jun 2020 03:13:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Jun 2020 03:13:18 -0700
Received: from [10.26.75.236] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jun
 2020 10:13:14 +0000
Subject: Re: [PATCH] [v4] dmaengine: tegra210-adma: Fix runtime PM imbalance
 on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, <kjlu@umn.edu>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200621054710.9915-1-dinghao.liu@zju.edu.cn>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <44d7771e-5600-19c2-888a-dd226cbc4b50@nvidia.com>
Date:   Tue, 23 Jun 2020 11:13:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200621054710.9915-1-dinghao.liu@zju.edu.cn>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592907186; bh=EZI9TZbYmyLEWExqkGXDn2O3RrVrZtPcSQrA+alXwVA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CHRl8YP78ii6tyRtOb0nssd6GQ+EhEzEKC6dQVl7Bo3KmOfNchnDHWhgEzcX08YC4
         EWMqPgPb532QJvk39hUArCbJbEdLeI9UvPsoQHXtB6lgpyIeznKhjtJWUM/iFd+2Jr
         FacDLYNveujH5RbXg8UfG98cfm8sYWRBuR8snjlidewr6WxgydrzK6z77OPCWJArr3
         oqW25efQ29TGJlj77eGBIqOAvT5YOrjigwjlnM81dEIxziZ9Uq5hlVxZ+T/5+do4vk
         LStxiYIZ2cZ66fuMpI5QL34fsWeBsRP6oiy6Ay+Qzmz3R6gVhjITw108EwRFt7vZjU
         0kmAS7Zn6EOIw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 21/06/2020 06:47, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.

So you have not mentioned here why you are using _noidle and not _put.
Furthermore, in this patch [0] you are not using _noidle to fix the same
problem in another driver. We should fix this in a consistent manner
across all drivers, otherwise it leads to more confusion.

Finally, Rafael mentions we should just use _put [0] and so I think we
should follow his recommendation.

Jon

[0] https://lkml.org/lkml/2020/5/21/601
-- 
nvpublic
